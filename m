Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2539CC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1922CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qHTTBk+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGZA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11315 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGZA5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fdd0000>; Thu, 25 Jul 2019 17:57:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:00 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:56:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:56:57 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fd80002>; Thu, 25 Jul 2019 17:56:56 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH v2 1/7] mm/hmm: replace hmm_update with mmu_notifier_range
Date:   Thu, 25 Jul 2019 17:56:44 -0700
Message-ID: <20190726005650.2566-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102621; bh=lwkkWpTr2q6bGT3TYFre2y7WKY3WOkWdOLwJIYO0wiE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=qHTTBk+OZ0oN3QPNauWBwLkmaGwrXZByf5lYGUIWIV0ijj6z01usz0teoi13vYJef
         juL0dX1HCCmKrx2gNn+RsuLecaEo9P7UvSNBrOrV/vIeDt2gwE2pYMD0h9VsExRhHH
         J6T8T/B1wR9BG+VRYXy5QwRHCA0/pw2vXwsY+Iz3L8QIDmvKn+y/s5QA/7aLRuZ8s1
         zhb5PNY0yNkBMFLgfuYWNsx9BDGs4EcroZGPHathoVQFdmt4ObtA8BApmIMJfivowN
         BhGphDqaXimFbxoylUOzm2eBZBtySe0aSv1sUsPvXBhcX4rYKXwuUIWemLX7VO1gnV
         mNko92YqJ9Gdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hmm_mirror_ops callback function sync_cpu_device_pagetables() passes
a struct hmm_update which is a simplified version of struct
mmu_notifier_range. This is unnecessary so replace hmm_update with
mmu_notifier_range directly.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed: Christoph Hellwig <hch@lst.de>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c |  8 +++----
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  4 ++--
 include/linux/hmm.h                    | 31 ++++----------------------
 mm/hmm.c                               | 13 ++++-------
 4 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_mn.c
index 3971c201f320..cf945080dff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -196,12 +196,12 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_m=
n_node *node,
  * potentially dirty.
  */
 static int amdgpu_mn_sync_pagetables_gfx(struct hmm_mirror *mirror,
-			const struct hmm_update *update)
+			const struct mmu_notifier_range *update)
 {
 	struct amdgpu_mn *amn =3D container_of(mirror, struct amdgpu_mn, mirror);
 	unsigned long start =3D update->start;
 	unsigned long end =3D update->end;
-	bool blockable =3D update->blockable;
+	bool blockable =3D mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
=20
 	/* notification is exclusive, but interval is inclusive */
@@ -244,12 +244,12 @@ static int amdgpu_mn_sync_pagetables_gfx(struct hmm_m=
irror *mirror,
  * are restorted in amdgpu_mn_invalidate_range_end_hsa.
  */
 static int amdgpu_mn_sync_pagetables_hsa(struct hmm_mirror *mirror,
-			const struct hmm_update *update)
+			const struct mmu_notifier_range *update)
 {
 	struct amdgpu_mn *amn =3D container_of(mirror, struct amdgpu_mn, mirror);
 	unsigned long start =3D update->start;
 	unsigned long end =3D update->end;
-	bool blockable =3D update->blockable;
+	bool blockable =3D mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
=20
 	/* notification is exclusive, but interval is inclusive */
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 545100f7c594..79b29c918717 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -252,13 +252,13 @@ nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u6=
4 start, u64 limit)
=20
 static int
 nouveau_svmm_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
-					const struct hmm_update *update)
+					const struct mmu_notifier_range *update)
 {
 	struct nouveau_svmm *svmm =3D container_of(mirror, typeof(*svmm), mirror)=
;
 	unsigned long start =3D update->start;
 	unsigned long limit =3D update->end;
=20
-	if (!update->blockable)
+	if (!mmu_notifier_range_blockable(update))
 		return -EAGAIN;
=20
 	SVMM_DBG(svmm, "invalidate %016lx-%016lx", start, limit);
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 9f32586684c9..659e25a15700 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -340,29 +340,6 @@ static inline uint64_t hmm_device_entry_from_pfn(const=
 struct hmm_range *range,
=20
 struct hmm_mirror;
=20
-/*
- * enum hmm_update_event - type of update
- * @HMM_UPDATE_INVALIDATE: invalidate range (no indication as to why)
- */
-enum hmm_update_event {
-	HMM_UPDATE_INVALIDATE,
-};
-
-/*
- * struct hmm_update - HMM update information for callback
- *
- * @start: virtual start address of the range to update
- * @end: virtual end address of the range to update
- * @event: event triggering the update (what is happening)
- * @blockable: can the callback block/sleep ?
- */
-struct hmm_update {
-	unsigned long start;
-	unsigned long end;
-	enum hmm_update_event event;
-	bool blockable;
-};
-
 /*
  * struct hmm_mirror_ops - HMM mirror device operations callback
  *
@@ -383,9 +360,9 @@ struct hmm_mirror_ops {
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
-	 * @update: update information (see struct hmm_update)
-	 * Return: -EAGAIN if update.blockable false and callback need to
-	 *          block, 0 otherwise.
+	 * @update: update information (see struct mmu_notifier_range)
+	 * Return: -EAGAIN if mmu_notifier_range_blockable(update) is false
+	 * and callback needs to block, 0 otherwise.
 	 *
 	 * This callback ultimately originates from mmu_notifiers when the CPU
 	 * page table is updated. The device driver must update its page table
@@ -397,7 +374,7 @@ struct hmm_mirror_ops {
 	 * synchronous call.
 	 */
 	int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-					  const struct hmm_update *update);
+				const struct mmu_notifier_range *update);
 };
=20
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 54b3a4162ae9..4040b4427635 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -165,7 +165,6 @@ static int hmm_invalidate_range_start(struct mmu_notifi=
er *mn,
 {
 	struct hmm *hmm =3D container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
-	struct hmm_update update;
 	struct hmm_range *range;
 	unsigned long flags;
 	int ret =3D 0;
@@ -173,15 +172,10 @@ static int hmm_invalidate_range_start(struct mmu_noti=
fier *mn,
 	if (!kref_get_unless_zero(&hmm->kref))
 		return 0;
=20
-	update.start =3D nrange->start;
-	update.end =3D nrange->end;
-	update.event =3D HMM_UPDATE_INVALIDATE;
-	update.blockable =3D mmu_notifier_range_blockable(nrange);
-
 	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	hmm->notifiers++;
 	list_for_each_entry(range, &hmm->ranges, list) {
-		if (update.end < range->start || update.start >=3D range->end)
+		if (nrange->end < range->start || nrange->start >=3D range->end)
 			continue;
=20
 		range->valid =3D false;
@@ -198,9 +192,10 @@ static int hmm_invalidate_range_start(struct mmu_notif=
ier *mn,
 	list_for_each_entry(mirror, &hmm->mirrors, list) {
 		int rc;
=20
-		rc =3D mirror->ops->sync_cpu_device_pagetables(mirror, &update);
+		rc =3D mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
 		if (rc) {
-			if (WARN_ON(update.blockable || rc !=3D -EAGAIN))
+			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
+			    rc !=3D -EAGAIN))
 				continue;
 			ret =3D -EAGAIN;
 			break;
--=20
2.20.1

