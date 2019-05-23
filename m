Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27656217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638507;
	bh=Ial3fphRF7+fx0HeHk/iihCGNqhGfW0Xc8IFSzHi/mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9UXA4Qcm72mrZBNj/HeBYuSicdT09w+89dnrnFsKJpD+RqQTP7r1hzsh5EC6mvRm
	 J0u3fgperCpInW1/jFi0iJWnGR1i0uyHSg1t7iud1LZE2t5EFtcAbr9u7OrKJ90+ms
	 5P2m0+VcpJTNz5pVViEUvYv48yRIcGfBP8N3ngeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfEWTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfEWTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:08:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E70217D7;
        Thu, 23 May 2019 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638504;
        bh=Ial3fphRF7+fx0HeHk/iihCGNqhGfW0Xc8IFSzHi/mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcwADktIp/7/Ei+Mxe91DSfLyIe4ZaPDDwtNbeTd5ZAQzqIvFgCGiqbxPZi1zaxgz
         MvDRDPpQzMVILLiqyOVG4ncpmbOR72yapF3F3ESk7KcoV5c+LIc3R6xu4Tj2NvS4RZ
         mfwiaCZR5WkgOJzE+MW1Zu1BY5v7+nx4lEsgdqFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 13/53] intel_th: msu: Fix single mode with IOMMU
Date:   Thu, 23 May 2019 21:05:37 +0200
Message-Id: <20190523181713.011377416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 4e0eaf239fb33ebc671303e2b736fa043462e2f4 upstream.

Currently, the pages that are allocated for the single mode of MSC are not
mapped into the device's dma space and the code is incorrectly using
*_to_phys() in place of a dma address. This fails with IOMMU enabled and
is otherwise bad practice.

Fix the single mode buffer allocation to map the pages into the device's
DMA space.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: ba82664c134e ("intel_th: Add Memory Storage Unit driver")
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |   35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -90,6 +90,7 @@ struct msc_iter {
  * @reg_base:		register window base address
  * @thdev:		intel_th_device pointer
  * @win_list:		list of windows in multiblock mode
+ * @single_sgt:		single mode buffer
  * @nr_pages:		total number of pages allocated for this buffer
  * @single_sz:		amount of data in single mode
  * @single_wrap:	single mode wrap occurred
@@ -110,6 +111,7 @@ struct msc {
 	struct intel_th_device	*thdev;
 
 	struct list_head	win_list;
+	struct sg_table		single_sgt;
 	unsigned long		nr_pages;
 	unsigned long		single_sz;
 	unsigned int		single_wrap : 1;
@@ -623,22 +625,45 @@ static void intel_th_msc_deactivate(stru
  */
 static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
 {
+	unsigned long nr_pages = size >> PAGE_SHIFT;
 	unsigned int order = get_order(size);
 	struct page *page;
+	int ret;
 
 	if (!size)
 		return 0;
 
+	ret = sg_alloc_table(&msc->single_sgt, 1, GFP_KERNEL);
+	if (ret)
+		goto err_out;
+
+	ret = -ENOMEM;
 	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!page)
-		return -ENOMEM;
+		goto err_free_sgt;
 
 	split_page(page, order);
-	msc->nr_pages = size >> PAGE_SHIFT;
+	sg_set_buf(msc->single_sgt.sgl, page_address(page), size);
+
+	ret = dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl, 1,
+			 DMA_FROM_DEVICE);
+	if (ret < 0)
+		goto err_free_pages;
+
+	msc->nr_pages = nr_pages;
 	msc->base = page_address(page);
-	msc->base_addr = page_to_phys(page);
+	msc->base_addr = sg_dma_address(msc->single_sgt.sgl);
 
 	return 0;
+
+err_free_pages:
+	__free_pages(page, order);
+
+err_free_sgt:
+	sg_free_table(&msc->single_sgt);
+
+err_out:
+	return ret;
 }
 
 /**
@@ -649,6 +674,10 @@ static void msc_buffer_contig_free(struc
 {
 	unsigned long off;
 
+	dma_unmap_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl,
+		     1, DMA_FROM_DEVICE);
+	sg_free_table(&msc->single_sgt);
+
 	for (off = 0; off < msc->nr_pages << PAGE_SHIFT; off += PAGE_SIZE) {
 		struct page *page = virt_to_page(msc->base + off);
 


