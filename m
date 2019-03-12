Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD21214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCLJUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:20:00 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:48 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MA4ja-1hE2t947PW-00BdvE; Tue, 12 Mar 2019 10:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 3/9] drivers: ata: ahci_tegra: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:28 +0100
Message-Id: <1552382374-28789-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5aT0/fZ3q9LmzBpe0c9uZepzjFoF264uxfJaPnxxR0+DoTxZw73
 YWhNEYXtfSDkC7Ht5bc7Akibs1qZ++AkfBrLFtnt+YAVC5BM4NJt2EaHkCcbHMcaj+UKR0a
 3TEPUUfQVnUBa727uVpTme323ozptkz429HTC6cNHFluj28FI2fn+KW4XJfgOwmJ9ZjCueB
 Ze2UEpxJqE4r6TCb26tgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AnHnVlt1wso=:EWButESJN1wFPqXyIZYLQy
 c+iX/LM+Yx5PjcfTYOad/qW+j1UrS+HhLS1Cx7RURTL/dh15vSMTVcZHVuG8S9xr39e/1wjuM
 gMycuF7Dg28V1nmpC2L9mfA13/xaSqo7Lbf+BSd9hz83wQ/Zaaj6DbX0Zh5ncxm+vv8A6N3wR
 aIOdKtQpDqjNBNRpXYWp9/B/yO2RMV5dK8O51BIz5PEaGyt6K6bsRSrq6ek9jqyhutne84evR
 pQlxxRZ/ZjrffjYjBKrFR0RibQnj+DsVqDWKnFyDqU2obJTa5VlVyO6UXgoqFiD9o8TdbhJ38
 ODl9blWW1CG3U5qI6KsvjUF2Hc+9YQfyA+pvwLs1GsH8/yDQha25X5Dp/Zn0tOoR4dtzkucMl
 1D2Rwn4d6lFpb+kNReAg3kY5hNHhkcDDGGHKPBSBC9/u+03PIY82JKCSN83gfTjJC+wri0CwH
 PHCziSq3agW0yNpyxjnytLOxAXKkbSmSt4Ps6QtSdgK5Q8TIsEN/J+quNX42SUZ9zoDll8ucB
 f1cVucoqa7PfhGm1SB6/0RzFY4aaW1oukflt4tdj2g1DIzWnzRy8g3hc7a+KAOhn/QfejjAiR
 CBCo3I0s7TB+fPi7A6JoQ0uKwLLeCLlOwBwihU9BAyhJoNMM/tggcItSmPStzFDMJQZTIdh/s
 tCFbhUW8wdh3sLsDc15fzB2IYFXDHoBTX3H0KOsZDd6VkQ3ey5wPflMlcdbDD6KchXbhTJXSr
 NWT936QLA76QY9Kb2kkB2R/4niUMZ+s/8c6qWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_tegra.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 004f260..88748ca 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -490,7 +490,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 {
 	struct ahci_host_priv *hpriv;
 	struct tegra_ahci_priv *tegra;
-	struct resource *res;
 	int ret;
 	unsigned int i;
 
@@ -507,19 +506,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	tegra->pdev = pdev;
 	tegra->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
 
 	/*
 	 * AUX registers is optional.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (res) {
-		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(tegra->sata_aux_regs))
-			return PTR_ERR(tegra->sata_aux_regs);
+	tegra->sata_aux_regs = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(tegra->sata_aux_regs)) {
+		dev_info(&pdev->dev, "Cant get aux registers (optional)");
+		tegra->sata_aux_regs = NULL;
 	}
 
 	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
-- 
1.9.1

