Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AE12084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142944;
	bh=TgMTOV6vcLpQIk4fl+/asFU0iDlVDGF7K2gCTffcTAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKUlsJXggFyMNBLBpDjsTd4Gzwt8RqGSu+y8X/TQABJ06/hCw1uPH1NDaBlG0e7Z1
	 hAKupRP2YvlIi2yJqs7C5yohQjSQ+tx5pEM/1At3/qR+CydSPchQhxQKd7OmqAWf4i
	 WbAQu5Un4q5vpYSeG2Y37kfveul4+YGRXT7TmPlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfKSFzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbfKSFy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6109208C3;
        Tue, 19 Nov 2019 05:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142897;
        bh=TgMTOV6vcLpQIk4fl+/asFU0iDlVDGF7K2gCTffcTAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNec4prQ07v/8RHslk2HMe1gRhreaqzQOF6r/spFOEbAszp8zN0k+7viN8d6EuZ8H
         pWw936fO8l4R48usbmIdAUCFu2WZOweIYWDUkGcoZzwWBVatoxrnqKpMMiy3JCvygn
         YRcm01GMSwiKkxDM8Y0xllUBeuLUBeg87JkUjKqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 238/239] net: phy: mdio-bcm-unimac: mark PM functions as __maybe_unused
Date:   Tue, 19 Nov 2019 06:20:38 +0100
Message-Id: <20191119051342.758447783@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9b97123a584f60a5bca5a2663485768a1f6cd0a4 ]

The newly added runtime-pm support causes a harmless warning
when CONFIG_PM is disabled:

drivers/net/phy/mdio-bcm-unimac.c:330:12: error: 'unimac_mdio_resume' defined but not used [-Werror=unused-function]
 static int unimac_mdio_resume(struct device *d)
drivers/net/phy/mdio-bcm-unimac.c:321:12: error: 'unimac_mdio_suspend' defined but not used [-Werror=unused-function]
 static int unimac_mdio_suspend(struct device *d)

Marking the functions as __maybe_unused is the easiest workaround
and avoids adding #ifdef checks.

Fixes: b78ac6ecd1b6 ("net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mdio-bcm-unimac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index f9d98a6e67bc4..52703bbd4d666 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -316,7 +316,7 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int unimac_mdio_suspend(struct device *d)
+static int __maybe_unused unimac_mdio_suspend(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 
@@ -325,7 +325,7 @@ static int unimac_mdio_suspend(struct device *d)
 	return 0;
 }
 
-static int unimac_mdio_resume(struct device *d)
+static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 	int ret;
-- 
2.20.1



