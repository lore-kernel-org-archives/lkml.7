Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB3BC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242D12063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mL1Rlf6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfHOH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:27:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfHOH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aOOFFEKMnnWfkUQ6+f0ZGZafV/dFv2cac5Nj+r5TNwg=; b=mL1Rlf6pCUs6KJaCWyDncsprOD
        UptO53edITEfoLPm9rmJl4TaSqCRE910hw2/biJBlDFeZ1hpyTVLKxBzmNTsESkC4jjh7o1aVvpM1
        DfYe/Tm+vXvx6STtd1Tdnkta85ENBKWwG89h7wwbFgyGKgZchhxUX25p7oDwlNPzqevXbz7D6OEDU
        LMM1pW87k9Bosy6WIAL0SYewBMT4j9QdiyV6YBPNNLg4TQ8wVQNMa2s9GRZqwYWjjo3lhirShFW0Q
        nNaym2zeHnBDoALZq9osjBRrwrJqzwKv8/7hkdoZQcwhMpuaK976dE4Xo9Uv/Zb3MkwShGBWO9Xiv
        u0rlVlOA==;
Received: from [2001:4bb8:18c:28b5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyAAF-00010w-06; Thu, 15 Aug 2019 07:27:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/amdgpu: simplify and cleanup setting the dma mask
Date:   Thu, 15 Aug 2019 09:27:03 +0200
Message-Id: <20190815072703.7010-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815072703.7010-1-hch@lst.de>
References: <20190815072703.7010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_set_mask_and_coherent to set both masks in one go, and remove
the no longer required fallback, as the kernel now always accepts
larger than required DMA masks.  Fail the driver probe if we can't
set the DMA mask, as that means the system can only support a larger
mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 20 +++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 20 +++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 20 +++-----------------
 6 files changed, 14 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8199d201b43a..ab562c27bb44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -758,7 +758,6 @@ struct amdgpu_device {
 	int				usec_timeout;
 	const struct amdgpu_asic_funcs	*asic_funcs;
 	bool				shutdown;
-	bool				need_dma32;
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5eeb72fcc123..05c8872eb8d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -590,7 +590,6 @@ static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
 static int gmc_v10_0_sw_init(void *handle)
 {
 	int r;
-	int dma_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	gfxhub_v2_0_init(adev);
@@ -637,26 +636,10 @@ static int gmc_v10_0_sw_init(void *handle)
 	else
 		adev->gmc.stolen_size = 9 * 1024 *1024;
 
-	/*
-	 * Set DMA mask + need_dma32 flags.
-	 * PCIE - can handle 44-bits.
-	 * IGP - can handle 44-bits
-	 * PCI - dma32 for legacy pci gart, 44 bits on navi10
-	 */
-	adev->need_dma32 = false;
-	dma_bits = adev->need_dma32 ? 32 : 44;
-
-	r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		adev->need_dma32 = true;
-		dma_bits = 32;
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
-	}
-
-	r = pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
-		printk(KERN_WARNING "amdgpu: No coherent DMA available.\n");
+		return r;
 	}
 
 	r = gmc_v10_0_mc_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca8dbe91cc8b..14073b506afe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -839,7 +839,6 @@ static unsigned gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
 static int gmc_v6_0_sw_init(void *handle)
 {
 	int r;
-	int dma_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->flags & AMD_IS_APU) {
@@ -862,20 +861,12 @@ static int gmc_v6_0_sw_init(void *handle)
 
 	adev->gmc.mc_mask = 0xffffffffffULL;
 
-	adev->need_dma32 = false;
-	dma_bits = adev->need_dma32 ? 32 : 40;
-	r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		adev->need_dma32 = true;
-		dma_bits = 32;
 		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		return r;
 	}
-	r = pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
-		dev_warn(adev->dev, "amdgpu: No coherent DMA available.\n");
-	}
-	adev->need_swiotlb = drm_need_swiotlb(dma_bits);
+	adev->need_swiotlb = drm_need_swiotlb(44);
 
 	r = gmc_v6_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 57f80065d57a..ca32915fbecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -959,7 +959,6 @@ static unsigned gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
 static int gmc_v7_0_sw_init(void *handle)
 {
 	int r;
-	int dma_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->flags & AMD_IS_APU) {
@@ -990,25 +989,12 @@ static int gmc_v7_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
 
-	/* set DMA mask + need_dma32 flags.
-	 * PCIE - can handle 40-bits.
-	 * IGP - can handle 40-bits
-	 * PCI - dma32 for legacy pci gart, 40 bits on newer asics
-	 */
-	adev->need_dma32 = false;
-	dma_bits = adev->need_dma32 ? 32 : 40;
-	r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
-		adev->need_dma32 = true;
-		dma_bits = 32;
 		pr_warn("amdgpu: No suitable DMA available\n");
+		return r;
 	}
-	r = pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
-		pr_warn("amdgpu: No coherent DMA available\n");
-	}
-	adev->need_swiotlb = drm_need_swiotlb(dma_bits);
+	adev->need_swiotlb = drm_need_swiotlb(40);
 
 	r = gmc_v7_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9238280d1ff7..909a8764703e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1079,7 +1079,6 @@ static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 static int gmc_v8_0_sw_init(void *handle)
 {
 	int r;
-	int dma_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->flags & AMD_IS_APU) {
@@ -1116,25 +1115,12 @@ static int gmc_v8_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
 
-	/* set DMA mask + need_dma32 flags.
-	 * PCIE - can handle 40-bits.
-	 * IGP - can handle 40-bits
-	 * PCI - dma32 for legacy pci gart, 40 bits on newer asics
-	 */
-	adev->need_dma32 = false;
-	dma_bits = adev->need_dma32 ? 32 : 40;
-	r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
-		adev->need_dma32 = true;
-		dma_bits = 32;
 		pr_warn("amdgpu: No suitable DMA available\n");
+		return r;
 	}
-	r = pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
-		pr_warn("amdgpu: No coherent DMA available\n");
-	}
-	adev->need_swiotlb = drm_need_swiotlb(dma_bits);
+	adev->need_swiotlb = drm_need_swiotlb(40);
 
 	r = gmc_v8_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 73f3b79ab131..38b91a407e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -968,7 +968,6 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 static int gmc_v9_0_sw_init(void *handle)
 {
 	int r;
-	int dma_bits;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	gfxhub_v1_0_init(adev);
@@ -1030,25 +1029,12 @@ static int gmc_v9_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	/* set DMA mask + need_dma32 flags.
-	 * PCIE - can handle 44-bits.
-	 * IGP - can handle 44-bits
-	 * PCI - dma32 for legacy pci gart, 44 bits on vega10
-	 */
-	adev->need_dma32 = false;
-	dma_bits = adev->need_dma32 ? 32 : 44;
-	r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		adev->need_dma32 = true;
-		dma_bits = 32;
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		return r;
 	}
-	r = pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
-		printk(KERN_WARNING "amdgpu: No coherent DMA available.\n");
-	}
-	adev->need_swiotlb = drm_need_swiotlb(dma_bits);
+	adev->need_swiotlb = drm_need_swiotlb(44);
 
 	if (adev->gmc.xgmi.supported) {
 		r = gfxhub_v1_1_get_xgmi_info(adev);
-- 
2.20.1

