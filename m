Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B5C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C342087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgAGWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:15:29 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:15:28 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Miqvq-1jIoEP0oqq-00eu3b; Tue, 07 Jan 2020 23:15:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ata: brcm: fix reset controller API usage
Date:   Tue,  7 Jan 2020 23:15:00 +0100
Message-Id: <20200107221506.2731280-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200107221506.2731280-1-arnd@arndb.de>
References: <20200107221506.2731280-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NmmCTE4SXgwe7dUPXnI9R0WefSBAKTAyb3PWuBBiYqWyYG90CIG
 0a8RCDIQQ+Vd26gby7ZP3c2cW27ewxbB9iSPYUfA9EXVptS9kj5H0ENFlg31yYVdEBOj6sV
 acRO95sS1zZ6ZPeXqR8IRsnKduiT840K+cilEHftOVYbb5d6tsZbUbs3pmjvwPyFlFYG8kD
 veSvtvARr3CEDyBPO1AOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVAdRrNCLEs=:KAngBEb356Ra2Eto7yZgT+
 iK2PfTImBXwfmwyBHC9TKyZgr8yiFTgG85pjfdAL9MpXWLEjAwHkiTi7q+B6ijTEUljlDxrlq
 /eLrS+y644W6iBzlHLnYiZY1NXYeeHjqs1HbPiSJCZgyDlFPZVPfz+i83NRwBrwFl8UZVCvhH
 NtqcgNB2MI/GPxHYw+yhp77ATL2+EfKPth+p3coW4rTzIjNcMq8mDAwv2UP2ruqD56hDj89gI
 iQb5vVzy/TvLj43PuAU8+jcPZ9WHMqzybrZdAN/50squZjxlzbrMfQeNE/wftSj4IhtHhE963
 zHl7NP3yNS1Ys/BFHY/KyQq3nrktYAuCe1P2wDTXqpu72LTWUfiivwRh1NdbzSkprAdYL2ciH
 /2v2DRQpAPsMH9l66Ery6vP8lTEAd/EDN5UuNL6fu10zw/G059jeAmSygj/MSVP7EEjus5SYy
 YBytvtfQXNJOPBOM2X+9J7mLNY2mecBwgdTz025IWvYc0j84WUG3FtcXInqJGquAkuwnUg8p0
 NEXgCgje0oSn1nvcJc2UvxpFn53Lx2wa5eg4U5kesL5/AvOGf0Uj5jBEk+hQU8kdH94J7GfeI
 GrYLbMA4hIJBSLKSo+f2LRYPrwLvhOQ8MBJ6LV+4jXtaiVtWOty2jGx7uQSH0qGzFHKQ2Ml6O
 8atGV3xDiQ7Ofd47roRsJ0G7x8UgROHTjHU2u6QjA/wDpoTVQxCd6zpSG8Wb3/02SfgFX2wWn
 OrTI5rgxmJTvlmS2d8PcQHl0V8sNNry7nF62tKqtQyntmXjj3l9nKfhSEA6AEcAtk0r6I426Y
 kya9rlzWEyCT+V0o9ePI2nS3kkwUF9la10AAmPWad3nK1rfJdiag+1LE0IeOiX1HTp9laSJfZ
 0NkMrQcShznSWX6fWYxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While fixing another issue in this driver I noticed it uses
IS_ERR_OR_NULL(), which is almost always a mistake.

Change the driver to use the proper devm_reset_control_get_optional()
interface instead and remove the checks except for the one that
checks for a failure in that function.

Fixes: 2b2c47d9e1fe ("ata: ahci_brcm: Allow optional reset controller to be used")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/ahci_brcm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 239333d11b88..7ac1141c6ad0 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -352,8 +352,7 @@ static int brcm_ahci_suspend(struct device *dev)
 	else
 		ret = 0;
 
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev);
 
 	return ret;
 }
@@ -365,8 +364,7 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -454,9 +452,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	else
 		reset_name = "ahci";
 
-	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_deassert(priv->rcdev);
+	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
+	if (IS_ERR(priv->rcdev))
+		return PTR_ERR(priv->rcdev);
+
+	reset_control_deassert(priv->rcdev);
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv)) {
@@ -520,8 +520,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev);
 	return ret;
 }
 
-- 
2.20.0

