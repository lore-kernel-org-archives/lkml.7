Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598E72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fs5ra9RA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ognx3leD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCATjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfCATjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB8ED6115A; Fri,  1 Mar 2019 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469175;
        bh=tXlDTiZ8Yze+sJs1VdJaFbhH91zYS29F71MrhySNETc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fs5ra9RAPAIZDvSfcdRrDElH3DJ0HOm9Sg5FljyCsolYwedckSOwvySg2yVMODW8F
         EeaSt5Amgb1zzuNwCYnHcD7iCu0u17cpvX/3uF0A5ZlS/+0Ca+pAb6goYKi3EXm4FU
         dr1hHLeAKB+ow+ICerFJeYV9LmIgR3cKblqox0OA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF098618F3;
        Fri,  1 Mar 2019 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469140;
        bh=tXlDTiZ8Yze+sJs1VdJaFbhH91zYS29F71MrhySNETc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ognx3leDWjQQqlqjkb1JPlKy9uo//PCSBy8WelE/Xb3Ul0pREys86PR63/pFXvFol
         O+lo2fHA4zAoXFNv/gZdqmOtz8RzfQ7+9yFCrfH/Hj/UGLl6SmKFF/YcETKVTGWSMs
         7TgXwLSylYS7CDToJBhpRSkFscpMrl/MiS0AKLSA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF098618F3
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
Subject: [RFC PATCH v1 11/15] drm/msm: Add a helper function for a per-instance address space
Date:   Fri,  1 Mar 2019 12:38:33 -0700
Message-Id: <1551469117-3404-12-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to create a GEM address space attached to
an iommu auxiliary domain for a per-instance pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.h     |  4 +++
 drivers/gpu/drm/msm/msm_gem_vma.c | 53 +++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 3140e8f..4423be0 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -258,6 +258,10 @@ struct msm_gem_address_space *
 msm_gem_address_space_create_a2xx(struct device *dev, struct msm_gpu *gpu,
 		const char *name, uint64_t va_start, uint64_t va_end);
 
+struct msm_gem_address_space *
+msm_gem_address_space_create_instance(struct device *dev, const char *name,
+		u64 va_start, u64 va_end);
+
 int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 void msm_unregister_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 49c0482..4364bf8 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -136,14 +136,12 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 	return 0;
 }
 
-
-struct msm_gem_address_space *
-msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
-		const char *name)
+static struct msm_gem_address_space *
+msm_gem_address_space_new(struct msm_mmu *mmu, const char *name,
+		u64 va_start, u64 va_end)
 {
 	struct msm_gem_address_space *aspace;
-	u64 size = domain->geometry.aperture_end -
-		domain->geometry.aperture_start;
+	u64 size = va_end - va_start;
 
 	aspace = kzalloc(sizeof(*aspace), GFP_KERNEL);
 	if (!aspace)
@@ -151,10 +149,9 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 
 	spin_lock_init(&aspace->lock);
 	aspace->name = name;
-	aspace->mmu = msm_iommu_new(dev, domain);
+	aspace->mmu = mmu;
 
-	drm_mm_init(&aspace->mm, (domain->geometry.aperture_start >> PAGE_SHIFT),
-		size >> PAGE_SHIFT);
+	drm_mm_init(&aspace->mm, (va_start >> PAGE_SHIFT), size >> PAGE_SHIFT);
 
 	kref_init(&aspace->kref);
 
@@ -162,24 +159,38 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 }
 
 struct msm_gem_address_space *
+msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
+		const char *name)
+{
+	struct msm_mmu *mmu = msm_iommu_new(dev, domain);
+
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
+
+	return msm_gem_address_space_new(mmu, name,
+		domain->geometry.aperture_start, domain->geometry.aperture_end);
+}
+
+struct msm_gem_address_space *
 msm_gem_address_space_create_a2xx(struct device *dev, struct msm_gpu *gpu,
 		const char *name, uint64_t va_start, uint64_t va_end)
 {
-	struct msm_gem_address_space *aspace;
-	u64 size = va_end - va_start;
+	struct msm_mmu *mmu = msm_gpummu_new(dev, gpu);
 
-	aspace = kzalloc(sizeof(*aspace), GFP_KERNEL);
-	if (!aspace)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
 
-	spin_lock_init(&aspace->lock);
-	aspace->name = name;
-	aspace->mmu = msm_gpummu_new(dev, gpu);
+	return msm_gem_address_space_new(mmu, name, va_start, va_end);
+}
 
-	drm_mm_init(&aspace->mm, (va_start >> PAGE_SHIFT),
-		size >> PAGE_SHIFT);
+struct msm_gem_address_space *
+msm_gem_address_space_create_instance(struct device *dev, const char *name,
+		u64 va_start, u64 va_end)
+{
+	struct msm_mmu *mmu = msm_iommu_new_instance(dev);
 
-	kref_init(&aspace->kref);
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
 
-	return aspace;
+	return msm_gem_address_space_new(mmu, name, va_start, va_end);
 }
-- 
2.7.4

