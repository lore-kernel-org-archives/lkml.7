Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94008C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A02171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfCLJU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:20:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:49 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mdf3x-1gUIgd11AP-00ZjWl; Tue, 12 Mar 2019 10:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 4/9] drivers: ata: ahci_xgene: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:29 +0100
Message-Id: <1552382374-28789-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:0hkIfb4mFdlNk+YlUGk4xjL+VdrE2kwL/2RgqWO+KuJK2qXhXuN
 cSe7EA61KOU7T7waLIM4pY3pUInCO9zALEHXbuX5dNcgxDNi2uV3+GeaunrDMWUUy8caDqa
 ni6bh+Q/nowb7MfSaeKgBNBrqAjZhIyAgTqdlLu0/N2E/uFh1QjGRrlzBJt8nd5s9IXiqxy
 SbUTckVttv594ahyfY3jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dtQZE7dvR/g=:RUc7WPozR6MDiUSE3ABBOr
 3Xe0bbPxibYkqZZthEMNlEX1+oI+/ubxEQMJQebkoM6mB5pHO3Nfi27h5nzjhVJ344fw6J2/y
 ZIUVRTdXMA6XLVLwObE26n6gcebBmyklDVrBO2ONAk6m7FrCes0sDrTz0ZyShAseGyRmSVWCU
 nQdUnmvo6ffRO9Kfo6WT3IJwpLVJveL+gffK8ceyki34mRW6CBZZQh9ha5rz/eOrKNiHTmvkV
 qdhSCotr55GLFbzWaLzsuxWnnTTruK2zqBtqcXBJZ6WGSAU0ZQm9qEUGdJYy7t5v0k47aoDA7
 aNJ1mpJIZ07AV3i497xx9guIu7igkDhX/dJgM4IjNAUCHasrHVfdAyrDKa+XHwcr6KlaCGWrH
 sYtHUlLpigtqPFwxq4eTNH06Yr24EIGIw7mLxKZUwkQLM2NneCZR1JMqzIsuylPbCaWguSl7+
 zXLRc9nQwDESZcMFLMq07MLx1ahpuhTTyUHXLDIQPtbrXjjpEWUNqMN7gUjIHmjOQ6xnO8o4E
 A3Am+yOve9tWUwv2SS3GIe4l1mP5CWYDdD8XbK8dx8oZJJEaKLBURcq6yGbVfx3tCnarBvjMj
 ncJ32hsnSeQZqW5tfUIfGALYyUv/Ck7XvEjARC9lr+BxFKNFVFNJU1BFag39w7upXWdQtuFDU
 yTbWvGxqVnnTUzerCV2sfDAHzLt5fBzgMyLxjX3yPtKQOk4D/7HgVSR1Z1DoIIEfq1jC0xP7k
 4ffvkX4+3/owtm+4m7QN6CH6j+J/F2lO6EvxiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_xgene.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7e157e1..99c622c 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -752,7 +752,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
-	struct resource *res;
 	const struct of_device_id *of_devid;
 	enum xgene_ahci_version version = XGENE_AHCI_V1;
 	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
@@ -772,31 +771,25 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
 	/* Retrieve the optional IP mux resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
-	if (res) {
-		void __iomem *csr = devm_ioremap_resource(dev, res);
-		if (IS_ERR(csr))
-			return PTR_ERR(csr);
-
-		ctx->csr_mux = csr;
+	ctx->csr_mux = csr = devm_platform_ioremap_resource(pdev, 4);
+	if (IS_ERR(ctx->csr_mux)) {
+		dev_info(&pdev->dev, "cant get ip mux resource (optional)");
+		ctx->csr_mux = NULL;
 	}
 
 	of_devid = of_match_device(xgene_ahci_of_match, dev);
-- 
1.9.1

