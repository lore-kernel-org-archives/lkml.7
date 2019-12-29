Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8DDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163B820718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641237;
	bh=Kt13FmWtwyAi2G4UWzaTUWxqQw3aYVaDV5iA/pCW+ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dXkBTrUXvdSa6JN6cBoeTiGLOOFmkgdIsJOI6+oTBdrySS3xSLych11Z67Y/lQz4v
	 PYJ79kePzUX6uE4g4yOaJ4KDmoOgnoHFt8mGfpy8WsVmbLvmAnOzk4RufdI6sAh2Nr
	 D5k4tFSFrICxoDJiRoDZLnE+OZwqrox9GjNb2/44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfL2Rkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbfL2Rbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:31:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F8D20722;
        Sun, 29 Dec 2019 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640694;
        bh=Kt13FmWtwyAi2G4UWzaTUWxqQw3aYVaDV5iA/pCW+ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6hGzD7oSdgzK5GWPAJxDH4x6VB2rkwS7Kt5cVmxasihrqG6v04+LO8p4M/1oQVLO
         jbOYBuMD9obR0QhZ1DTBNXAfKYA5jCRUgjHFz/uV1b6a883dkOzL1N18Q7rWsIMVUo
         jft22kKrvFMIQDWWix4cOWCDVzUrsCqrCKmCs6cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/219] net: dsa: LAN9303: select REGMAP when LAN9303 enable
Date:   Sun, 29 Dec 2019 18:18:23 +0100
Message-Id: <20191229162523.412154759@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
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
index d3ce1e4cb4d3..dbfb6ad80fac 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -66,6 +66,7 @@ config NET_DSA_REALTEK_SMI
 config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
+	select REGMAP
 	---help---
 	  This enables support for the SMSC/Microchip LAN9303 3 port ethernet
 	  switch chips.
-- 
2.20.1



