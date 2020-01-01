Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F9C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2376F2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgAAS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:26:28 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13063
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbgAAS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:26:27 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="334542274"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 19:26:24 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] fbdev: s1d13xxxfb: use resource_size
Date:   Wed,  1 Jan 2020 18:49:43 +0100
Message-Id: <1577900990-8588-4-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes these changes is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/video/fbdev/s1d13xxxfb.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 8048499e398d..eaea8c373753 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -746,9 +746,9 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 	}
 
 	release_mem_region(pdev->resource[0].start,
-			pdev->resource[0].end - pdev->resource[0].start +1);
+			   resource_size(&pdev->resource[0]));
 	release_mem_region(pdev->resource[1].start,
-			pdev->resource[1].end - pdev->resource[1].start +1);
+			   resource_size(&pdev->resource[1]));
 	return 0;
 }
 
@@ -788,14 +788,14 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 	}
 
 	if (!request_mem_region(pdev->resource[0].start,
-		pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) {
+		resource_size(&pdev->resource[0]), "s1d13xxxfb mem")) {
 		dev_dbg(&pdev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
 		goto bail;
 	}
 
 	if (!request_mem_region(pdev->resource[1].start,
-		pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) {
+		resource_size(&pdev->resource[1]), "s1d13xxxfb regs")) {
 		dev_dbg(&pdev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
 		goto bail;
@@ -810,7 +810,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	default_par = info->par;
 	default_par->regs = ioremap(pdev->resource[1].start,
-			pdev->resource[1].end - pdev->resource[1].start +1);
+				    resource_size(&pdev->resource[1]));
 	if (!default_par->regs) {
 		printk(KERN_ERR PFX "unable to map registers\n");
 		ret = -ENOMEM;
@@ -819,7 +819,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 	info->pseudo_palette = default_par->pseudo_palette;
 
 	info->screen_base = ioremap(pdev->resource[0].start,
-			pdev->resource[0].end - pdev->resource[0].start +1);
+				    resource_size(&pdev->resource[0]));
 
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "unable to map framebuffer\n");
@@ -857,9 +857,9 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 
 	info->fix = s1d13xxxfb_fix;
 	info->fix.mmio_start = pdev->resource[1].start;
-	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start + 1;
+	info->fix.mmio_len = resource_size(&pdev->resource[1]);
 	info->fix.smem_start = pdev->resource[0].start;
-	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+	info->fix.smem_len = resource_size(&pdev->resource[0]);
 
 	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
 	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);

