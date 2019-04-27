Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEFC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD32087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfD0HLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:11:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35526 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfD0HKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:10:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 487232000B2;
        Sat, 27 Apr 2019 09:10:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B5662000AB;
        Sat, 27 Apr 2019 09:10:38 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A985E205ED;
        Sat, 27 Apr 2019 09:10:37 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 5/9] dpaa_eth: defer probing after qbman
Date:   Sat, 27 Apr 2019 10:10:27 +0300
Message-Id: <20190427071031.6563-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Enabling SMMU altered the order of device probing causing the dpaa1
ethernet driver to get probed before qbman and causing a boot crash.
Add predictability in the probing order by deferring the ethernet
driver probe after qbman and portals by using the recently introduced
qbman APIs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dfebc30c4841..647e90e7434f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2774,6 +2774,37 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	int err = 0, i, channel;
 	struct device *dev;
 
+	err = bman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to bman probe error\n");
+		return -ENODEV;
+	}
+	err = qman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to qman probe error\n");
+		return -ENODEV;
+	}
+	err = bman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to bman portals probe error\n");
+		return -ENODEV;
+	}
+	err = qman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to qman portals probe error\n");
+		return -ENODEV;
+	}
+
 	/* device used for DMA mapping */
 	dev = pdev->dev.parent;
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
-- 
2.17.1

