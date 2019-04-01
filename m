Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607A721852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139024;
	bh=sqhOWxD2nm5BS0M8yWoHLwD5Hiz6UokFm7Q8Jvj6afk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dj9QvQcFX7rRc4CQpCv4mwP1w/uUU4I29p71hrLe2/3kHzb0NiYxRlSnsM6WTtR2y
	 pZ/2fHsWuvGX04QTFLVNetw5zOfEwJVs1h/nZGI55xZNrU5Arznx41iXKAjcM/ryba
	 X8f9a077u6h9j8s39s1yGlgqGKsY0RnKLThnPqnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfDARRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbfDARRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C86D206C0;
        Mon,  1 Apr 2019 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139020;
        bh=sqhOWxD2nm5BS0M8yWoHLwD5Hiz6UokFm7Q8Jvj6afk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAlG1eOPMtp+bkBONgOKA0kgylPRJwR29SXO1ae0vhs5ki9tRWHk1RhcTPsm7aKxz
         GZDObvE6/qndxsS28r2e6ejrmMXrpi/DCwVtKKg9/h7PtjI5ySfQy+5cxoMIeirRk1
         tV0T+sL6Cuu1iPAZCfAtAP2v52qgEktJIiGEvWkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 072/134] ocfs2: fix inode bh swapping mixup in ocfs2_reflink_inodes_lock
Date:   Mon,  1 Apr 2019 19:01:48 +0200
Message-Id: <20190401170051.161721499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Darrick J. Wong <darrick.wong@oracle.com>

commit e6a9467ea14bae8691b0f72c500510c42ea8edb8 upstream.

ocfs2_reflink_inodes_lock() can swap the inode1/inode2 variables so that
we always grab cluster locks in order of increasing inode number.

Unfortunately, we forget to swap the inode record buffer head pointers
when we've done this, which leads to incorrect bookkeepping when we're
trying to make the two inodes have the same refcount tree.

This has the effect of causing filesystem shutdowns if you're trying to
reflink data from inode 100 into inode 97, where inode 100 already has a
refcount tree attached and inode 97 doesn't.  The reflink code decides
to copy the refcount tree pointer from 100 to 97, but uses inode 97's
inode record to open the tree root (which it doesn't have) and blows up.
This issue causes filesystem shutdowns and metadata corruption!

Link: http://lkml.kernel.org/r/20190312214910.GK20533@magnolia
Fixes: 29ac8e856cb369 ("ocfs2: implement the VFS clone_range, copy_range, and dedupe_range features")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <joseph.qi@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/refcounttree.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4716,22 +4716,23 @@ out:
 
 /* Lock an inode and grab a bh pointing to the inode. */
 static int ocfs2_reflink_inodes_lock(struct inode *s_inode,
-				     struct buffer_head **bh1,
+				     struct buffer_head **bh_s,
 				     struct inode *t_inode,
-				     struct buffer_head **bh2)
+				     struct buffer_head **bh_t)
 {
-	struct inode *inode1;
-	struct inode *inode2;
+	struct inode *inode1 = s_inode;
+	struct inode *inode2 = t_inode;
 	struct ocfs2_inode_info *oi1;
 	struct ocfs2_inode_info *oi2;
+	struct buffer_head *bh1 = NULL;
+	struct buffer_head *bh2 = NULL;
 	bool same_inode = (s_inode == t_inode);
+	bool need_swap = (inode1->i_ino > inode2->i_ino);
 	int status;
 
 	/* First grab the VFS and rw locks. */
 	lock_two_nondirectories(s_inode, t_inode);
-	inode1 = s_inode;
-	inode2 = t_inode;
-	if (inode1->i_ino > inode2->i_ino)
+	if (need_swap)
 		swap(inode1, inode2);
 
 	status = ocfs2_rw_lock(inode1, 1);
@@ -4754,17 +4755,13 @@ static int ocfs2_reflink_inodes_lock(str
 	trace_ocfs2_double_lock((unsigned long long)oi1->ip_blkno,
 				(unsigned long long)oi2->ip_blkno);
 
-	if (*bh1)
-		*bh1 = NULL;
-	if (*bh2)
-		*bh2 = NULL;
-
 	/* We always want to lock the one with the lower lockid first. */
 	if (oi1->ip_blkno > oi2->ip_blkno)
 		mlog_errno(-ENOLCK);
 
 	/* lock id1 */
-	status = ocfs2_inode_lock_nested(inode1, bh1, 1, OI_LS_REFLINK_TARGET);
+	status = ocfs2_inode_lock_nested(inode1, &bh1, 1,
+					 OI_LS_REFLINK_TARGET);
 	if (status < 0) {
 		if (status != -ENOENT)
 			mlog_errno(status);
@@ -4773,15 +4770,25 @@ static int ocfs2_reflink_inodes_lock(str
 
 	/* lock id2 */
 	if (!same_inode) {
-		status = ocfs2_inode_lock_nested(inode2, bh2, 1,
+		status = ocfs2_inode_lock_nested(inode2, &bh2, 1,
 						 OI_LS_REFLINK_TARGET);
 		if (status < 0) {
 			if (status != -ENOENT)
 				mlog_errno(status);
 			goto out_cl1;
 		}
-	} else
-		*bh2 = *bh1;
+	} else {
+		bh2 = bh1;
+	}
+
+	/*
+	 * If we swapped inode order above, we have to swap the buffer heads
+	 * before passing them back to the caller.
+	 */
+	if (need_swap)
+		swap(bh1, bh2);
+	*bh_s = bh1;
+	*bh_t = bh2;
 
 	trace_ocfs2_double_lock_end(
 			(unsigned long long)oi1->ip_blkno,
@@ -4791,8 +4798,7 @@ static int ocfs2_reflink_inodes_lock(str
 
 out_cl1:
 	ocfs2_inode_unlock(inode1, 1);
-	brelse(*bh1);
-	*bh1 = NULL;
+	brelse(bh1);
 out_rw2:
 	ocfs2_rw_unlock(inode2, 1);
 out_i2:


