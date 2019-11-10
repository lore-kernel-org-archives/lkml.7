Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DFEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D170215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353960;
	bh=YoOdhLDsccXJu821EOv0qP752hFVRTq/feQk1vt7ELE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v9ILncuuxvCgLjIQTVJfCbVyxwRl0QHutL42j/CQNzxcwgBAELLXH3m7/3cqnO5dq
	 ky88aFK2WIE0HGEUzgs+KCaTDCXub4bHqJFMkdO0+EPU+/JWoz21bBKbKcSAqJsP87
	 vc3DGUZRwYsCeTA5NrzYO3/uFcBTcOsHl3K1H6vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfKJCp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbfKJCpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB9F21850;
        Sun, 10 Nov 2019 02:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353931;
        bh=YoOdhLDsccXJu821EOv0qP752hFVRTq/feQk1vt7ELE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BefvvuzddmujSUvASBbpx/VR85B94duhn9prhT14Pu0oNt10q2/sK+77P4PLdvD04
         2omC/q3ZfkVCXgdq1rQ0MrGODSaRWPEqKsWmvcCzSrvovUl8NjLTWpXek2Q2m85TBt
         ZD0+OmUJcBlbCELuperZF7b3tFw0a7E97QRQSUjs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 190/191] net: phy: mdio-bcm-unimac: mark PM functions as __maybe_unused
Date:   Sat,  9 Nov 2019 21:40:12 -0500
Message-Id: <20191110024013.29782-190-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 80b9583eaa952..df75efa96a7d9 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -318,7 +318,7 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int unimac_mdio_suspend(struct device *d)
+static int __maybe_unused unimac_mdio_suspend(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 
@@ -327,7 +327,7 @@ static int unimac_mdio_suspend(struct device *d)
 	return 0;
 }
 
-static int unimac_mdio_resume(struct device *d)
+static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 	int ret;
-- 
2.20.1

