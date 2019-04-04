Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B98C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E05E2183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369083;
	bh=TSwKxQHFg/n5xu5AG2DWs9tTuA3QRPGS1dqaTv0/UzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GqOMMkGi2hdtCQUUNTwlT+dByOnwlle9h7o3wNKZyyFNLXO9VbCvg7gf6EupwOFeP
	 xqf/vCjlHrnznhAvQzzH/H/kfiQGlOOdkWV3PwtPvsp3aKzbMr5y54XZ9CrPJaN5yO
	 s/nNnm4+/z/DNwPr0jCXvSBzr2r/3H52nJhv1xSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfDDJLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbfDDJLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3D12075E;
        Thu,  4 Apr 2019 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369078;
        bh=TSwKxQHFg/n5xu5AG2DWs9tTuA3QRPGS1dqaTv0/UzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=re5CZTG5VNu3x2dTOBTNmKACdqFOnTlMMOZ7gIddWYMfn1DzWV7g4j0zYCDpBHrWH
         ZVBoOBnlw6ZWOsuEevkwo2gK4Y6dEXS2lVJAGEb5rWTRbUJatWpqvAhoZBCLENHVyH
         0x5JhlHBsUTgFuQ4JRYWcJe17sMrfj4Dhck+TNTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 081/246] net: dsa: mv88e6xxx: Default CMODE to 1000BaseX only on 6390X
Date:   Thu,  4 Apr 2019 10:46:21 +0200
Message-Id: <20190404084621.970604908@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 65b034cf5c1766492aa107958149b440889480be ]

Commit 787799a9d555 sets the SERDES interfaces of 6390 and 6390X to
1000BaseX, but this is only needed on 6390X, since there are SERDES
interfaces which can be used on lower ports on 6390.

This commit fixes this by returning to previous behaviour on 6390.
(Previous behaviour means that CMODE is not set at all if requested mode
is NA).

This is needed on Turris MOX, where the 88e6190 is connected to CPU in
2500BaseX mode.

Fixes: 787799a9d555 ("net: dsa: mv88e6xxx: Default ports 9/10 6390X CMODE to 1000BaseX")
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 41eee62fed25..c44b2822e4dd 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -480,6 +480,8 @@ int mv88e6390_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			     phy_interface_t mode)
 {
 	switch (mode) {
+	case PHY_INTERFACE_MODE_NA:
+		return 0;
 	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_RXAUI:
-- 
2.19.1



