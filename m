Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994DAC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7879E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbfFKQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:23:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfFKQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 238B43162907;
        Tue, 11 Jun 2019 16:23:33 +0000 (UTC)
Received: from max.com (unknown [10.40.205.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 543B360BF4;
        Tue, 11 Jun 2019 16:23:29 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        cluster-devel@redhat.com
Subject: Re: [PATCH] fs: gfs2: Use IS_ERR_OR_NULL
Date:   Tue, 11 Jun 2019 18:23:26 +0200
Message-Id: <20190611162326.26967-1-agruenba@redhat.com>
In-Reply-To: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 16:23:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng,

On Wed, 5 Jun 2019 at 16:17, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use IS_ERR_OR_NULL where appropriate.

It seems there are several more instances in which IS_ERR_OR_NULL should
be used (see below).

Thanks,
Andreas

---
 fs/gfs2/dir.c        | 2 +-
 fs/gfs2/glock.c      | 2 +-
 fs/gfs2/inode.c      | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 3925efd3fd83..761a37a3c656 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -753,7 +753,7 @@ static struct gfs2_dirent *gfs2_dirent_split_alloc(struct inode *inode,
 	struct gfs2_dirent *dent;
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size,
 				gfs2_dirent_find_offset, name, ptr);
-	if (!dent || IS_ERR(dent))
+	if (IS_ERR_OR_NULL(dent))
 		return dent;
 	return do_init_dirent(inode, dent, name, bh,
 			      (unsigned)(ptr - (void *)dent));
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 15c605cfcfc8..f6281470a182 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -684,7 +684,7 @@ static void delete_work_func(struct work_struct *work)
 		goto out;
 
 	inode = gfs2_lookup_by_inum(sdp, no_addr, NULL, GFS2_BLKST_UNLINKED);
-	if (inode && !IS_ERR(inode)) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		d_prune_aliases(inode);
 		iput(inode);
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 998051c4aea7..1cc99da705fc 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -796,7 +796,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 fail_gunlock:
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(ghs);
-	if (inode && !IS_ERR(inode)) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		clear_nlink(inode);
 		if (!free_vfs_inode)
 			mark_inode_dirty(inode);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index f5312f3b58ee..d35772d90b0a 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -579,7 +579,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 
 		INIT_WORK(&jd->jd_work, gfs2_recover_func);
 		jd->jd_inode = gfs2_lookupi(sdp->sd_jindex, &name, 1);
-		if (!jd->jd_inode || IS_ERR(jd->jd_inode)) {
+		if (IS_ERR_OR_NULL(jd->jd_inode)) {
 			if (!jd->jd_inode)
 				error = -ENOENT;
 			else
-- 
2.20.1

