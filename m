Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D03C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83E523403
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfHTMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:23 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:00 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqJZl-1icflV3Ut1-00nQ3O; Tue, 20 Aug 2019 14:35:50 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 4/9] drivers: ata: ahci_xgene: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:43 +0200
Message-Id: <1566304548-19972-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:EGVdhOvit0epxFckX90tJLb4dXT1lQ105Bt+j9X+HPLLELoBJKC
 1CsSnhwaJs3yJkZPHY5z3RtvocKSa/XejFWKSPl4s5dvP4piKFrpvs3Dz2b54Nzx1d3Qa4T
 TfimFi+xF3cZnOod8gfrP/E1u7QQb9LaoN5a8XEGdctUySujPF1z0Z66fNDJ7KXsitcOb51
 cBt5WNZsemgbkUb5hFUKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3zvMyjGQ2ws=:GlCH8QROjQWMSD+gNDBjkm
 3nKW9qtGRIICF+YnnVsDRKminnWxEVic35yRp5PGWALoIpPqK4g07PoiYAvVucHw+iuNTe80r
 30KrQcaHyRS9/XVipWO2/HEaIwxtPuVOPmQUXuLd3OfBY4Y5mbLADrX0G3Vt0qMXOFNfy5qIZ
 WEmMr/eeQU/YrbI1rT7KogjaVlBY/ni0c5rx9QH8E9djEn2Uz1LJYKNWlDj21C7zYjey6Y0BG
 vZDoZQmPeivZU858Zs+EfQ7EIf0fPRrnIi2IeNpTrnLrMu//fvyM+4G+W8AcHnISJJ0BeQDT2
 yc8RI7VRg6O8wFjc3iuDiHq/JHlEcO9qsnv9a/nccXJ0nELHzppweCZpdxF/5ZN0gaf4FASsr
 DwdxMyAuG7A1oka8Pcb/NSGwuOSSNLNUheJSPmdRxN07iBDzrcNe6AuoD3voqpoCQpavTxzd6
 R0lnOn3KRmmxISNn/W6peNdQ6MAS1qgcO+U3l5MmBmb29KN+1gQp1rv55zH7AuZW40+x2pJsG
 aljzXQIbGmdiyMXDK20FhCfKLl+kR8oW3bUYExnvpdpApCO2HbeLTEdtyU0eAHL5DNZlrd1e8
 mzKGtATAdrjhHVUzkzqdS20O9sdL2TP673RoobgeeKsWlM6XRjkljM++lkHQ3InWJM3+oNcna
 GhDvzds8eS4iz0rSG+pShpYAFcSFm1kv3ffKjKcdFLlR8GcjODoyThzjbglPbkujLZ5nCj5hb
 I1BPfBSSypmImS/vza0t5LPyF+ANdxhbqdqB0w==
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
index 16246c8..5391f5d 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -739,7 +739,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
-	struct resource *res;
 	const struct of_device_id *of_devid;
 	enum xgene_ahci_version version = XGENE_AHCI_V1;
 	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
@@ -759,31 +758,25 @@ static int xgene_ahci_probe(struct platform_device *pdev)
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

