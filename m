Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CE82054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfHTMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:02 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7hrw-1iLHVS2kkc-014oTr; Tue, 20 Aug 2019 14:35:52 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 9/9] drivers: ata: sata_rcar: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:48 +0200
Message-Id: <1566304548-19972-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:GFgie2U970YyZGkG3noiek5XN2mWDBvFVquvcRyQ8cdHVlBoBTL
 k9/T/AQBNZXUzA6MeJD860+e9ts/WfgOEqwuJSP/lL6TrW8ud6bclphAPPQ6ALxxw6s2/1a
 7TE4ulpn8yWXcc3fPix3RTIurmWWM9RTygD2PlIw13R5TmAAneXU4b6aY1TSml/ohkueKQI
 6Lau3jZWQUiupvjs9fyZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAo2nzR61+Q=:XbDBDurTSEjw+v7eLAAMbW
 p4odBvqVWzliFJU4ZG93L9zje7OXjQRMxuMnqfgtCSZpAUwEt0m556BjmdxMIGeM4Q9XWoXY3
 Y3n6bML24M4dyF6zXQ/H/P2chP3pwxQOGtDcUSszklqPo3zRdQd4EnbLXd9I+q2QXCRaEOksA
 MS2y3hk9v51qXlguUe/0VQ2wHlrb6IGj8bNZD2WvCiMUuKo6UH28H1apcpjHEh9JMacSOj36i
 zAKwcmgf7MHV+yvGfa4d+10yG8tpZEMbR0Q1X2ZVJLSIqovGYHV1ESUGeHiqnjXgSHPrNSGFB
 SiGIGko8VdYJ6SwdcRKp7JYwuwRo+MstsWRthb1aC8HK2dkVCRqcULxGozLJRXV9GbcZLckoM
 uqvbMoj9c9B6Hi/RtAsZnAvvP4WMF2efyC9v+IA4nuQjsY990O43BD41QRBZsFfhcKrT8Q6d6
 Ep0NesXEAzGnSiaNK1TZiwUNEc6LjTuXIjDuiTMOzIx0VI4jx4XyNTRGaEi3RUsj10iyhA5K+
 y4VkfTm8++CqQzxEYtL/BZphAiVTCHovZrtoChCct2xrsmhR4ixXchEBLTgOQKLP9uU69QSu2
 IbfMdE6Q/V4wAa0Y+PM3sKj2ZCTRRaer9qf1SbdBNEhyZfWiigHu3j2OTROeNlWI8gQRB3DsV
 cVuebIAXUWG65jcgh7t0IFgeAkJQG1oaJnZu/qYYF8spCvWgak29ba/64iJUicsOAQ3ndvyNj
 kn3FKToMnKoYuKhQzUQpGbupk68ZZ4N9kFoksg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 3495e17..14ea1d6 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -886,7 +886,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
 	int irq;
 	int ret = 0;
 
@@ -915,8 +914,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
1.9.1

