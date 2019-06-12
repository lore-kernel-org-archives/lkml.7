Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F9C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325420874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408268AbfFLBKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:10:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18553 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406598AbfFLBKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:10:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2C1B880E1B8DD6AB2047;
        Wed, 12 Jun 2019 09:10:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 09:10:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <cluster-devel@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] fs: gfs2: Use IS_ERR_OR_NULL
Date:   Wed, 12 Jun 2019 09:17:55 +0800
Message-ID: <20190612011755.94442-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611162326.26967-1-agruenba@redhat.com>
References: <20190611162326.26967-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR_OR_NULL where appropriate.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dir.c        | 4 ++--
 fs/gfs2/glock.c      | 2 +-
 fs/gfs2/inode.c      | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 88e4f955c518..6f35d19eec25 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -750,7 +750,7 @@ static struct gfs2_dirent *gfs2_dirent_split_alloc(struct inode *inode,
 	struct gfs2_dirent *dent;
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size,
 				gfs2_dirent_find_offset, name, ptr);
-	if (!dent || IS_ERR(dent))
+	if (IS_ERR_OR_NULL(dent))
 		return dent;
 	return do_init_dirent(inode, dent, name, bh,
 			      (unsigned)(ptr - (void *)dent));
@@ -854,7 +854,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 		return ERR_PTR(error);
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size, scan, name, NULL);
 got_dent:
-	if (unlikely(dent == NULL || IS_ERR(dent))) {
+	if (IS_ERR_OR_NULL(dent)) {
 		brelse(bh);
 		bh = NULL;
 	}
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index f1ebcb42cbf5..44718098cc60 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -681,7 +681,7 @@ static void delete_work_func(struct work_struct *work)
 		goto out;
 
 	inode = gfs2_lookup_by_inum(sdp, no_addr, NULL, GFS2_BLKST_UNLINKED);
-	if (inode && !IS_ERR(inode)) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		d_prune_aliases(inode);
 		iput(inode);
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b296c59832a7..2e2a8a2fb51d 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -793,7 +793,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 fail_gunlock:
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(ghs);
-	if (inode && !IS_ERR(inode)) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		clear_nlink(inode);
 		if (!free_vfs_inode)
 			mark_inode_dirty(inode);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 08823bb3b2d0..9683d534e1a1 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -568,7 +568,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 
 		INIT_WORK(&jd->jd_work, gfs2_recover_func);
 		jd->jd_inode = gfs2_lookupi(sdp->sd_jindex, &name, 1);
-		if (!jd->jd_inode || IS_ERR(jd->jd_inode)) {
+		if (IS_ERR_OR_NULL(jd->jd_inode)) {
 			if (!jd->jd_inode)
 				error = -ENOENT;
 			else
-- 
2.20.1

