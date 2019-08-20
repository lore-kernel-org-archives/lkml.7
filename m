Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E99C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E922DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfHTMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:35:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:35:59 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9nEJ-1hwUzr1v9B-005o1s; Tue, 20 Aug 2019 14:35:50 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 3/9] drivers: ata: ahci_tegra: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:42 +0200
Message-Id: <1566304548-19972-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Jr/gZnoTUUBhlRs4XcX+dJVWioPVUmZYUARoTa655pPANyYFd9M
 tCxIl3V/NTfLLnE3QoM2ZXKsK18cftyW1d2pglYWhkHEqnJoSH31HdtzpU6Es7JEdYnJ1X+
 /ujTfvSbZTD3kvZdOdW2e7y7Gljx3jUo8YzZWllk344CTT4OTp3yMobZeHUC0fsLUNHdvEt
 lHcZ9fFO77dgUYbBivKdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gejSv/wXZnw=:Fku2qEi360K7XvfR2GyKmV
 xqJQc7hstNjq4FiXwu4quGCnaRiEAfARoajs/HxbV953dLNd5RUsYZwV4Lp2KxIK33ZTtD2Qg
 rk5y+IavjGAN7tv8pZTYxbDmZgx58udeniC9boyVmlf21B4+oGuK4soDEt56MhYNCuR3sBv2m
 EqtGS6jIbBZg/hX67JWL2KlcAlJBTAom0z+uL8XKSZCNbAy5ctjlEEiFUwptiPtthpLTIa7Tn
 HAPj/zf2eSKrow/1dYngaeQ8bJd97kPxJX3NkSQyNbRJ+du4eX9BlWxku+HqsxFP/JwM74++L
 S+puleGe3tgCmfoEmyV+nKfKmkFGsYG/RMMNQqFMLytRZYeDDfYV99SROaY8+awY8fdxrM9Hx
 HlVJg/LakjH6tu8wvAn6J+3MG0LT8RCuTSI+5lQ+gFrFhBYdruIy03LWEZcNtSjPsxSlC4myR
 FjBsb82ht3RvoJ++A7WWRpUoP9rc1KPhqPYaHXMKHOr2KWoI8ZDhEao10dJV4zIAIOGhbjCXj
 NC7lfJDDQaVMxRRpLIQns+Wn5euIna5EXEfhzoqu2yoqiGTdsOibypswntchikINB6gJ6WAa3
 RJ08Gtf9W5M7MAXyLYbBPcoH0XZZAdmYCvcrHG2UKz9fXhhaDTH/91z8g4mPCaguG/edIEJIj
 FqPn9bEB/TrmtibnMUjdZr5LN8afV6PDJ6YYCyQdBB3W+mjEcxXLGKY4LW2adpIU1drvMRa0m
 OZcW6aemXRFcww9r1mU2QpoqflELt7yCYnrSow==
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
index e3163da..3845c23 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -481,7 +481,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 {
 	struct ahci_host_priv *hpriv;
 	struct tegra_ahci_priv *tegra;
-	struct resource *res;
 	int ret;
 	unsigned int i;
 
@@ -498,19 +497,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
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

