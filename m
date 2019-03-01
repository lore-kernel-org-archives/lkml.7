Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF84C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF12084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f/jn/p56";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Re8o/xGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfCATjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCATjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D7BE6115B; Fri,  1 Mar 2019 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469173;
        bh=wBZB+LFIv8r0uTFu6MNzs2A3S+65mKQ9oZ1KI8mimLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/jn/p56Zv/WVlZp6nB/4xlbOfSzMcJs3Bw4dzgrb5yrY5opQ1W6DU+6nIBqlWSz3
         JxQ3EYv6jfu/YqJcd4HwaAgi5P7dS+tas6ZNahDqKnA+Tdzn0KLLheU47qFD9H+reU
         YZD2d4Ev7py2cTHBaTyl2IIzPLlT8uY16vkbkbkU=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EA9F617A3;
        Fri,  1 Mar 2019 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469138;
        bh=wBZB+LFIv8r0uTFu6MNzs2A3S+65mKQ9oZ1KI8mimLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Re8o/xGQPGqb8QmQKRwUj+Um7m7Z/0gNZ5vhXhdiwQZQNdIabkc6SpYeZhMx2+zdf
         J4TLjoMYGwsD8vRwfyO7EeQRgSTNlRST0GDalmD1Z2b5rsmbBNUkOP9uoEv1jeuvDq
         NRqQ1j9u96MhnTbkV/g8CFnEOgOCJtUmt2hfvMto=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EA9F617A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH v1 10/15] drm/msm: Add support for IOMMU auxiliary domains
Date:   Fri,  1 Mar 2019 12:38:32 -0700
Message-Id: <1551469117-3404-11-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating a auxiliary domain from the IOMMU device to
implement per-instance pagetables. Also add a helper function to
return the pagetable base address (ttbr) and asid to the caller so
that the GPU target code can set up the pagetable switch.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_iommu.c | 97 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h   |  4 ++
 2 files changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 1926329..adf9f18 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -21,9 +21,21 @@
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
+	u64 ttbr;
+	u32 asid;
 };
 #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
 
+/*
+ * The asid is currently unused for arm-smmu-v2 since all the pagetable
+ * switching does a TLBIALL but still assign a somewhat unique number per
+ * instance to leave open the possibility of being smarter about it
+ *
+ * Accepted range is 32 to 255 (starting at 32 gives a cushion for the asids
+ * assigned to the real context banks in the arm-smmu driver.
+ */
+static int msm_iommu_asid = 32;
+
 static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
@@ -34,6 +46,47 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 	return 0;
 }
 
+static int msm_iommu_aux_attach(struct msm_mmu *mmu, const char * const *names,
+			    int cnt)
+{
+	struct msm_iommu *iommu = to_msm_iommu(mmu);
+	int ret;
+
+	/* Attach the aux device */
+	ret = iommu_aux_attach_device(iommu->domain, mmu->dev);
+	if (ret)
+		return ret;
+
+	/* Get the base address of the pagetable */
+	ret = iommu_domain_get_attr(iommu->domain, DOMAIN_ATTR_PTBASE,
+		&iommu->ttbr);
+	if (ret)
+		return ret;
+
+	/*
+	 * Assign an asid for the instance even though the code doesn't
+	 * currently support per-asid TLB invalidation. There isn't any
+	 * protection on this so two instances could in theory end up with the
+	 * same ASID but that would have very minor performance implications if
+	 * per-ASID TLB invalidation were to be enabled in the future
+	 */
+	iommu->asid = msm_iommu_asid++;
+
+	if (msm_iommu_asid > 0xff)
+		msm_iommu_asid = 32;
+
+	return 0;
+}
+
+static void msm_iommu_aux_detach(struct msm_mmu *mmu, const char * const *names,
+			     int cnt)
+{
+	struct msm_iommu *iommu = to_msm_iommu(mmu);
+
+	iommu->ttbr = 0;
+	iommu->asid = 0;
+}
+
 static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
 			    int cnt)
 {
@@ -86,6 +139,50 @@ static const struct msm_mmu_funcs funcs = {
 		.destroy = msm_iommu_destroy,
 };
 
+static const struct msm_mmu_funcs aux_funcs = {
+		.attach = msm_iommu_aux_attach,
+		.detach = msm_iommu_aux_detach,
+		.map = msm_iommu_map,
+		.unmap = msm_iommu_unmap,
+		.destroy = msm_iommu_destroy,
+};
+
+bool msm_iommu_get_ptinfo(struct msm_mmu *mmu, u64 *ttbr, u32 *asid)
+{
+	struct msm_iommu *iommu = to_msm_iommu(mmu);
+
+	if (!iommu->ttbr)
+		return false;
+
+	if (ttbr)
+		*ttbr = iommu->ttbr;
+	if (asid)
+		*asid = iommu->asid;
+
+	return true;
+}
+
+
+struct msm_mmu *msm_iommu_new_instance(struct device *dev)
+{
+	struct msm_iommu *iommu;
+
+	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return ERR_PTR(-ENOMEM);
+
+	/* Create a new domain that will be attached as an aux domain */
+	iommu->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!iommu->domain) {
+		kfree(iommu);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	msm_mmu_init(&iommu->base, dev, &aux_funcs);
+
+	return &iommu->base;
+}
+
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 {
 	struct msm_iommu *iommu;
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index d21b266..f430903 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -46,6 +46,10 @@ static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
 struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu);
 
+struct msm_mmu *msm_iommu_new_instance(struct device *dev);
+
+bool msm_iommu_get_ptinfo(struct msm_mmu *mmu, u64 *ttbr, u32 *asid);
+
 static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 		int (*handler)(void *arg, unsigned long iova, int flags))
 {
-- 
2.7.4

