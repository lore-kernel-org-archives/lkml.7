Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01879C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37120651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfC2OAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:00:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39716 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbfC2OAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:00:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FBE21A0290;
        Fri, 29 Mar 2019 15:00:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7362D1A0289;
        Fri, 29 Mar 2019 15:00:20 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CE04220606;
        Fri, 29 Mar 2019 15:00:19 +0100 (CET)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
Date:   Fri, 29 Mar 2019 16:00:06 +0200
Message-Id: <20190329140014.8126-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Prior to calling iommu_map()/iommu_unmap() page align the size or
failures such as below could happen:

iommu: unaligned: iova 0x... pa 0x... size 0x4000 min_pagesz 0x10000
qman_portal 500000000.qman-portal: failed to iommu_map() -22

Seen when booted a kernel compiled with 64K page size support.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c   | 2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c   | 4 ++--
 drivers/soc/fsl/qbman/qman_portal.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index b209c79511bb..3a6e01bde32d 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -230,7 +230,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
 	/* Create an 1-to-1 iommu mapping for FBPR area */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain) {
-		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
+		ret = iommu_map(domain, fbpr_a, fbpr_a, PAGE_ALIGN(fbpr_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "failed to iommu_map() %d\n", ret);
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index eec7700507e1..8d3c950ce52d 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -783,11 +783,11 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	/* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain) {
-		ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
+		ret = iommu_map(domain, fqd_a, fqd_a, PAGE_ALIGN(fqd_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
-		ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
+		ret = iommu_map(domain, pfdr_a, pfdr_a, PAGE_ALIGN(pfdr_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index dfb62f9815e9..bce56da2b01f 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -297,7 +297,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 		 */
 		err = iommu_map(domain,
 				addr_phys[0]->start, addr_phys[0]->start,
-				resource_size(addr_phys[0]),
+				PAGE_ALIGN(resource_size(addr_phys[0])),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (err)
 			dev_warn(dev, "failed to iommu_map() %d\n", err);
-- 
2.17.1

