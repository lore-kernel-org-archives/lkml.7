Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113742083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901625;
	bh=cVrHZdCHkOo3oho3Ppf/pRL9wzhHEuokTXPNrgmzd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwkqHuVb1Jz0BM/4A67RI0ORAR3qsDmCivRLs1plCFnd93/AcBhdoKcqvwbWGhrfh
	 QPFPd3/SXbqxS/i0kojeB/HiZi1PETEexqg5NBib1iLwUatI3q4ZUEd2eqKhaGEREV
	 nMndOgifun+EpSdOoBYzbKNHtFMasT4IjUPfyRPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfCRJdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfCRJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027972087C;
        Mon, 18 Mar 2019 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901617;
        bh=cVrHZdCHkOo3oho3Ppf/pRL9wzhHEuokTXPNrgmzd48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0uy9/CVQv/w+eEAzYS1EnYzVp8yn0EKgVi0MME6IUotHKujWxSw/8xicRmZxfgfY
         NT3xmAABT+I5K1net3ECBvf1aU4ArB/HVbTPr+anCOTngYbOa1X8sZZsAbTc95tfaY
         /43Ajn8m//ieKmuj9s0IY//TqjL+eG+YzwXx9T4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 50/52] staging: erofs: fix race when the managed cache is enabled
Date:   Mon, 18 Mar 2019 10:25:47 +0100
Message-Id: <20190318084019.445530342@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 51232df5e4b268936beccde5248f312a316800be upstream.

When the managed cache is enabled, the last reference count
of a workgroup must be used for its workstation.

Otherwise, it could lead to incorrect (un)freezes in
the reclaim path, and it would be harmful.

A typical race as follows:

Thread 1 (In the reclaim path)  Thread 2
workgroup_freeze(grp, 1)                                refcnt = 1
...
workgroup_unfreeze(grp, 1)                              refcnt = 1
                                workgroup_get(grp)      refcnt = 2 (x)
workgroup_put(grp)                                      refcnt = 1 (x)
                                ...unexpected behaviors

* grp is detached but still used, which violates cache-managed
  freeze constraint.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/internal.h |    1 
 drivers/staging/erofs/utils.c    |  139 ++++++++++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 39 deletions(-)

--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -260,6 +260,7 @@ repeat:
 }
 
 #define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
+#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
 
 extern int erofs_workgroup_put(struct erofs_workgroup *grp);
 
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -87,12 +87,21 @@ int erofs_register_workgroup(struct supe
 		grp = (void *)((unsigned long)grp |
 			1UL << RADIX_TREE_EXCEPTIONAL_SHIFT);
 
-	err = radix_tree_insert(&sbi->workstn_tree,
-		grp->index, grp);
+	/*
+	 * Bump up reference count before making this workgroup
+	 * visible to other users in order to avoid potential UAF
+	 * without serialized by erofs_workstn_lock.
+	 */
+	__erofs_workgroup_get(grp);
 
-	if (!err) {
-		__erofs_workgroup_get(grp);
-	}
+	err = radix_tree_insert(&sbi->workstn_tree,
+				grp->index, grp);
+	if (unlikely(err))
+		/*
+		 * it's safe to decrease since the workgroup isn't visible
+		 * and refcount >= 2 (cannot be freezed).
+		 */
+		__erofs_workgroup_put(grp);
 
 	erofs_workstn_unlock(sbi);
 	radix_tree_preload_end();
@@ -101,19 +110,99 @@ int erofs_register_workgroup(struct supe
 
 extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 
+static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
+{
+	atomic_long_dec(&erofs_global_shrink_cnt);
+	erofs_workgroup_free_rcu(grp);
+}
+
 int erofs_workgroup_put(struct erofs_workgroup *grp)
 {
 	int count = atomic_dec_return(&grp->refcount);
 
 	if (count == 1)
 		atomic_long_inc(&erofs_global_shrink_cnt);
-	else if (!count) {
-		atomic_long_dec(&erofs_global_shrink_cnt);
-		erofs_workgroup_free_rcu(grp);
-	}
+	else if (!count)
+		__erofs_workgroup_free(grp);
 	return count;
 }
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+/* for cache-managed case, customized reclaim paths exist */
+static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
+{
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
+}
+
+bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+				    struct erofs_workgroup *grp,
+				    bool cleanup)
+{
+	void *entry;
+
+	/*
+	 * for managed cache enabled, the refcount of workgroups
+	 * themselves could be < 0 (freezed). So there is no guarantee
+	 * that all refcount > 0 if managed cache is enabled.
+	 */
+	if (!erofs_workgroup_try_to_freeze(grp, 1))
+		return false;
+
+	/*
+	 * note that all cached pages should be unlinked
+	 * before delete it from the radix tree.
+	 * Otherwise some cached pages of an orphan old workgroup
+	 * could be still linked after the new one is available.
+	 */
+	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
+		erofs_workgroup_unfreeze(grp, 1);
+		return false;
+	}
+
+	/*
+	 * it is impossible to fail after the workgroup is freezed,
+	 * however in order to avoid some race conditions, add a
+	 * DBG_BUGON to observe this in advance.
+	 */
+	entry = radix_tree_delete(&sbi->workstn_tree, grp->index);
+	DBG_BUGON((void *)((unsigned long)entry &
+			   ~RADIX_TREE_EXCEPTIONAL_ENTRY) != grp);
+
+	/*
+	 * if managed cache is enable, the last refcount
+	 * should indicate the related workstation.
+	 */
+	erofs_workgroup_unfreeze_final(grp);
+	return true;
+}
+
+#else
+/* for nocache case, no customized reclaim path at all */
+bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+				    struct erofs_workgroup *grp,
+				    bool cleanup)
+{
+	int cnt = atomic_read(&grp->refcount);
+	void *entry;
+
+	DBG_BUGON(cnt <= 0);
+	DBG_BUGON(cleanup && cnt != 1);
+
+	if (cnt > 1)
+		return false;
+
+	entry = radix_tree_delete(&sbi->workstn_tree, grp->index);
+	DBG_BUGON((void *)((unsigned long)entry &
+			   ~RADIX_TREE_EXCEPTIONAL_ENTRY) != grp);
+
+	/* (rarely) could be grabbed again when freeing */
+	erofs_workgroup_put(grp);
+	return true;
+}
+
+#endif
+
 unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 				       unsigned long nr_shrink,
 				       bool cleanup)
@@ -130,43 +219,15 @@ repeat:
 		batch, first_index, PAGEVEC_SIZE);
 
 	for (i = 0; i < found; ++i) {
-		int cnt;
 		struct erofs_workgroup *grp = (void *)
 			((unsigned long)batch[i] &
 				~RADIX_TREE_EXCEPTIONAL_ENTRY);
 
 		first_index = grp->index + 1;
 
-		cnt = atomic_read(&grp->refcount);
-		BUG_ON(cnt <= 0);
-
-		if (cleanup)
-			BUG_ON(cnt != 1);
-
-#ifndef EROFS_FS_HAS_MANAGED_CACHE
-		else if (cnt > 1)
-#else
-		if (!erofs_workgroup_try_to_freeze(grp, 1))
-#endif
-			continue;
-
-		if (radix_tree_delete(&sbi->workstn_tree,
-			grp->index) != grp) {
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-skip:
-			erofs_workgroup_unfreeze(grp, 1);
-#endif
+		/* try to shrink each valid workgroup */
+		if (!erofs_try_to_release_workgroup(sbi, grp, cleanup))
 			continue;
-		}
-
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (erofs_try_to_free_all_cached_pages(sbi, grp))
-			goto skip;
-
-		erofs_workgroup_unfreeze(grp, 1);
-#endif
-		/* (rarely) grabbed again when freeing */
-		erofs_workgroup_put(grp);
 
 		++freed;
 		if (unlikely(!--nr_shrink))


