Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9D7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585A5206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643413;
	bh=+pRBD+DXYf0Vx1wWkRljRenYXMJ40s5kRaus2Nqa6xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRL85trxYPiW/GfMTmsHruiEmDr6rgycfmzk6lQGvFu9qGxOkQLNG6AC+lqYstodk
	 eK0lDQxqnn3atUuWuEB5pfc3CMflKuHDOi9HjZzovfPuTgcGU3hXmSJQMMemHuuASJ
	 /h7kZFgN2oa3A8DO1b2FG2ZlykrRJ3k26q/Q07yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfL2SQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfL2RX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:23:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F248207FD;
        Sun, 29 Dec 2019 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640238;
        bh=+pRBD+DXYf0Vx1wWkRljRenYXMJ40s5kRaus2Nqa6xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNqk6H8JMEzM1lSh8fOODJaEYmjFhHaj0iSIlw+n7ZiBIGmQYOg/YgXFhDZRSbWVq
         lZOQa4yIZpCEknUlFsYJz/bnz/AK6xj9EviirB9U5kioGvJO03g3KEsg7zf6dd2f7e
         iXp7CKwr9u9jnz2kf05rj0Lauu9y/TJ/e23A1Dco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 074/161] net: dsa: LAN9303: select REGMAP when LAN9303 enable
Date:   Sun, 29 Dec 2019 18:18:42 +0100
Message-Id: <20191229162422.387073676@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit b6989d248a2d13f02895bae1a9321b3bbccc0283 ]

When NET_DSA_SMSC_LAN9303=y and NET_DSA_SMSC_LAN9303_MDIO=y,
below errors can be seen:
drivers/net/dsa/lan9303_mdio.c:87:23: error: REGMAP_ENDIAN_LITTLE
undeclared here (not in a function)
  .reg_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/net/dsa/lan9303_mdio.c:93:3: error: const struct regmap_config
has no member named reg_read
  .reg_read = lan9303_mdio_read,

It should select REGMAP in config NET_DSA_SMSC_LAN9303.

Fixes: dc7005831523 ("net: dsa: LAN9303: add MDIO managed mode support")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 83a9bc892a3b..6ae13f2419e3 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -55,6 +55,7 @@ config NET_DSA_QCA8K
 config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
+	select REGMAP
 	---help---
 	  This enables support for the SMSC/Microchip LAN9303 3 port ethernet
 	  switch chips.
-- 
2.20.1



