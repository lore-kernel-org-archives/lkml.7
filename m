Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F55C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF934206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nSpPfFNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfEFXf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:35:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15420 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFXf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:35:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd0c49b0001>; Mon, 06 May 2019 16:34:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 16:35:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 May 2019 16:35:26 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 23:35:25 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] mm/hmm: Fix mm stale reference use in hmm_free()
Date:   Mon, 6 May 2019 16:35:14 -0700
Message-ID: <20190506233514.12795-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557185692; bh=Pz+Lnilo8jwREPLLjDIfQshwvwWMrvNGLPYsN6aFmxg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:X-Originating-IP:
         X-ClientProxiedBy:Content-Transfer-Encoding:Content-Type;
        b=nSpPfFNUVG2DSiJcoI6i99LQZXi4BGjgIxH3xOgnSqX+B9nKq56UTkGLtTWOycSiw
         hZc+SfwMhoRm9UoNFR1dG5p2O4/zT8jWOgc9hyShq0S3TzuWX/jqutQhFdotZc8xbK
         Eapq7ctsmHsdhFGkHFSkRHI3M9jaC7OVHsamMQTRtf2TU2ARDVQ6Uxpt3vvkoB16m8
         MwJwPP9wVm2+yQPcvS/egojLEgkS62VUtjO4T3Pbz6kaT87mL/s9GVF2CKjrIKWPjH
         zyqaDfFTY6dPpktY3+rBl+9LqcDMtzvaBHYgB2DhH4tWc7jc4WWSHPoFjkEvwlDcah
         WVOZ+x+vXPPFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

The last reference to struct hmm may be released long after the mm_struct
is destroyed because the struct hmm_mirror memory may be part of a
device driver open file private data pointer. The file descriptor close
is usually after the mm_struct is destroyed in do_exit(). This is a good
reason for making struct hmm a kref_t object [1] since its lifetime spans
the life time of mm_struct and struct hmm_mirror.

The fix is to not use hmm->mm in hmm_free() and to clear mm->hmm and
hmm->mm pointers in hmm_destroy() when the mm_struct is destroyed. By
clearing the pointers at the very last moment, it eliminates the need for
additional locking since the mmu notifier code already handles quiescing
notifier callbacks and unregistering the hmm notifiers. Also, by making
mm_struct hold a reference to struct hmm, there is no need to check for a
zero hmm reference count in mm_get_hmm().

[1] https://marc.info/?l=3Dlinux-mm&m=3D155432001406049&w=3D2
    ("mm/hmm: use reference counting for HMM struct v3")

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h |  10 +----
 mm/hmm.c            | 100 ++++++++++++++++----------------------------
 2 files changed, 37 insertions(+), 73 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index fa0671d67269..538867c76906 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -488,15 +488,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
  */
 static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
 {
-	struct mm_struct *mm;
-
-	if (!mirror || !mirror->hmm)
-		return false;
-	mm =3D READ_ONCE(mirror->hmm->mm);
-	if (mirror->hmm->dead || !mm)
-		return false;
-
-	return true;
+	return mirror && mirror->hmm && !mirror->hmm->dead;
 }
=20
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 2aa75dbed04a..4e42c282d334 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -43,8 +43,10 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *m=
m)
 {
 	struct hmm *hmm =3D READ_ONCE(mm->hmm);
=20
-	if (hmm && kref_get_unless_zero(&hmm->kref))
+	if (hmm && !hmm->dead) {
+		kref_get(&hmm->kref);
 		return hmm;
+	}
=20
 	return NULL;
 }
@@ -53,25 +55,28 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *=
mm)
  * hmm_get_or_create - register HMM against an mm (HMM internal)
  *
  * @mm: mm struct to attach to
- * Returns: returns an HMM object, either by referencing the existing
- *          (per-process) object, or by creating a new one.
+ * Return: an HMM object reference, either by referencing the existing
+ *         (per-process) object, or by creating a new one.
  *
- * This is not intended to be used directly by device drivers. If mm alrea=
dy
- * has an HMM struct then it get a reference on it and returns it. Otherwi=
se
- * it allocates an HMM struct, initializes it, associate it with the mm an=
d
- * returns it.
+ * If the mm already has an HMM struct then return a new reference to it.
+ * Otherwise, allocate an HMM struct, initialize it, associate it with the=
 mm,
+ * and return a new reference to it. If the return value is not NULL,
+ * the caller is responsible for calling hmm_put().
  */
 static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
-	struct hmm *hmm =3D mm_get_hmm(mm);
-	bool cleanup =3D false;
+	struct hmm *hmm =3D mm->hmm;
=20
-	if (hmm)
-		return hmm;
+	if (hmm) {
+		if (hmm->dead)
+			goto error;
+		goto out;
+	}
=20
 	hmm =3D kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
-		return NULL;
+		goto error;
+
 	init_waitqueue_head(&hmm->wq);
 	INIT_LIST_HEAD(&hmm->mirrors);
 	init_rwsem(&hmm->mirrors_sem);
@@ -83,47 +88,32 @@ static struct hmm *hmm_get_or_create(struct mm_struct *=
mm)
 	hmm->dead =3D false;
 	hmm->mm =3D mm;
=20
-	spin_lock(&mm->page_table_lock);
-	if (!mm->hmm)
-		mm->hmm =3D hmm;
-	else
-		cleanup =3D true;
-	spin_unlock(&mm->page_table_lock);
-
-	if (cleanup)
-		goto error;
-
 	/*
-	 * We should only get here if hold the mmap_sem in write mode ie on
-	 * registration of first mirror through hmm_mirror_register()
+	 * The mmap_sem should be held for write so no additional locking
+	 * is needed. Note that struct_mm holds a reference to hmm.
+	 * It is cleared in hmm_release().
 	 */
+	mm->hmm =3D hmm;
+
 	hmm->mmu_notifier.ops =3D &hmm_mmu_notifier_ops;
 	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
 		goto error_mm;
=20
+out:
+	/* Return a separate hmm reference for the caller. */
+	kref_get(&hmm->kref);
 	return hmm;
=20
 error_mm:
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm =3D=3D hmm)
-		mm->hmm =3D NULL;
-	spin_unlock(&mm->page_table_lock);
-error:
+	mm->hmm =3D NULL;
 	kfree(hmm);
+error:
 	return NULL;
 }
=20
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm =3D container_of(kref, struct hmm, kref);
-	struct mm_struct *mm =3D hmm->mm;
-
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
-
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm =3D=3D hmm)
-		mm->hmm =3D NULL;
-	spin_unlock(&mm->page_table_lock);
=20
 	kfree(hmm);
 }
@@ -135,25 +125,18 @@ static inline void hmm_put(struct hmm *hmm)
=20
 void hmm_mm_destroy(struct mm_struct *mm)
 {
-	struct hmm *hmm;
+	struct hmm *hmm =3D mm->hmm;
=20
-	spin_lock(&mm->page_table_lock);
-	hmm =3D mm_get_hmm(mm);
-	mm->hmm =3D NULL;
 	if (hmm) {
+		mm->hmm =3D NULL;
 		hmm->mm =3D NULL;
-		hmm->dead =3D true;
-		spin_unlock(&mm->page_table_lock);
 		hmm_put(hmm);
-		return;
 	}
-
-	spin_unlock(&mm->page_table_lock);
 }
=20
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct hmm *hmm =3D mm_get_hmm(mm);
+	struct hmm *hmm =3D mm->hmm;
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
=20
@@ -187,14 +170,12 @@ static void hmm_release(struct mmu_notifier *mn, stru=
ct mm_struct *mm)
 						  struct hmm_mirror, list);
 	}
 	up_write(&hmm->mirrors_sem);
-
-	hmm_put(hmm);
 }
=20
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm =3D mm_get_hmm(nrange->mm);
+	struct hmm *hmm =3D nrange->mm->hmm;
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
@@ -238,14 +219,13 @@ static int hmm_invalidate_range_start(struct mmu_noti=
fier *mn,
 	up_read(&hmm->mirrors_sem);
=20
 out:
-	hmm_put(hmm);
 	return ret;
 }
=20
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm =3D mm_get_hmm(nrange->mm);
+	struct hmm *hmm =3D nrange->mm->hmm;
=20
 	VM_BUG_ON(!hmm);
=20
@@ -262,8 +242,6 @@ static void hmm_invalidate_range_end(struct mmu_notifie=
r *mn,
 		wake_up_all(&hmm->wq);
 	}
 	mutex_unlock(&hmm->lock);
-
-	hmm_put(hmm);
 }
=20
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops =3D {
@@ -931,20 +909,14 @@ int hmm_range_register(struct hmm_range *range,
 		return -EINVAL;
 	if (start >=3D end)
 		return -EINVAL;
+	hmm =3D mm_get_hmm(mm);
+	if (!hmm)
+		return -EFAULT;
=20
 	range->page_shift =3D page_shift;
 	range->start =3D start;
 	range->end =3D end;
-
-	range->hmm =3D mm_get_hmm(mm);
-	if (!range->hmm)
-		return -EFAULT;
-
-	/* Check if hmm_mm_destroy() was call. */
-	if (range->hmm->mm =3D=3D NULL || range->hmm->dead) {
-		hmm_put(range->hmm);
-		return -EFAULT;
-	}
+	range->hmm =3D hmm;
=20
 	/* Initialize range to track CPU page table updates. */
 	mutex_lock(&range->hmm->lock);
--=20
2.20.1

