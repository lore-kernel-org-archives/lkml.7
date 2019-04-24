Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56885C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FDB20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126962;
	bh=2HcbwD+O5K15CsZF8Ax3I9HHz8yC7NZM8pGTcJlsKKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ca3zSUga06dEVhxndwVL3+MFzBn6W7+5988kHGjDV478Kvzgvu8LmwnZS2mlbUXlk
	 ukziG2BOL3HGc452uHfL1Z/bM+dHujYJiWnLzIUDh7kbf8MiHMm1KRRltiwe5mNrnO
	 UO+maBGRiRy+ITwyGN1NL2qs5q85K2ORzLIf8aaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbfDXR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390764AbfDXR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3306F206BA;
        Wed, 24 Apr 2019 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126951;
        bh=2HcbwD+O5K15CsZF8Ax3I9HHz8yC7NZM8pGTcJlsKKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Te3dlEm6AI2SlYa79bQ+SeYbBmBNkA9pNh4G8edZCXwlgcCvuDKis9X0Ww28Lsndn
         jqIW0Yhb/FRyRJuw6APUU684QjwDr76dROQIoQEM6YM+hRzDe5YbUF4+v7Yr4JjNsD
         VsPPBR3VXt0cOorkCFeywaHK8Va0Z9a7q5UI1UIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Lyakas <alex@zadarastorage.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Alex Lyakas <alex@zadara.com>
Subject: [PATCH 4.14 69/70] xfs: hold xfs_buf locked between shortform->leaf conversion and the addition of an attribute
Date:   Wed, 24 Apr 2019 19:10:29 +0200
Message-Id: <20190424170919.181138726@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 6e643cd094de3bd0f97edcc1db0089afa24d909f upstream.

The new attribute leaf buffer is not held locked across the transaction
roll between the shortform->leaf modification and the addition of the
new entry.  As a result, the attribute buffer modification being made is
not atomic from an operational perspective.  Hence the AIL push can grab
it in the transient state of "just created" after the initial
transaction is rolled, because the buffer has been released.  This leads
to xfs_attr3_leaf_verify() asserting that hdr.count is zero, treating
this as in-memory corruption, and shutting down the filesystem.

Darrick ported the original patch to 4.15 and reworked it use the
xfs_defer_bjoin helper and hold/join the buffer correctly across the
second transaction roll.

Signed-off-by: Alex Lyakas <alex@zadarastorage.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alex Lyakas <alex@zadara.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_attr.c      |   20 +++++++++++++++-----
 fs/xfs/libxfs/xfs_attr_leaf.c |    9 ++++++---
 fs/xfs/libxfs/xfs_attr_leaf.h |    3 ++-
 3 files changed, 23 insertions(+), 9 deletions(-)

--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -212,6 +212,7 @@ xfs_attr_set(
 	int			flags)
 {
 	struct xfs_mount	*mp = dp->i_mount;
+	struct xfs_buf		*leaf_bp = NULL;
 	struct xfs_da_args	args;
 	struct xfs_defer_ops	dfops;
 	struct xfs_trans_res	tres;
@@ -327,9 +328,16 @@ xfs_attr_set(
 		 * GROT: another possible req'mt for a double-split btree op.
 		 */
 		xfs_defer_init(args.dfops, args.firstblock);
-		error = xfs_attr_shortform_to_leaf(&args);
+		error = xfs_attr_shortform_to_leaf(&args, &leaf_bp);
 		if (error)
 			goto out_defer_cancel;
+		/*
+		 * Prevent the leaf buffer from being unlocked so that a
+		 * concurrent AIL push cannot grab the half-baked leaf
+		 * buffer and run into problems with the write verifier.
+		 */
+		xfs_trans_bhold(args.trans, leaf_bp);
+		xfs_defer_bjoin(args.dfops, leaf_bp);
 		xfs_defer_ijoin(args.dfops, dp);
 		error = xfs_defer_finish(&args.trans, args.dfops);
 		if (error)
@@ -337,13 +345,14 @@ xfs_attr_set(
 
 		/*
 		 * Commit the leaf transformation.  We'll need another (linked)
-		 * transaction to add the new attribute to the leaf.
+		 * transaction to add the new attribute to the leaf, which
+		 * means that we have to hold & join the leaf buffer here too.
 		 */
-
 		error = xfs_trans_roll_inode(&args.trans, dp);
 		if (error)
 			goto out;
-
+		xfs_trans_bjoin(args.trans, leaf_bp);
+		leaf_bp = NULL;
 	}
 
 	if (xfs_bmap_one_block(dp, XFS_ATTR_FORK))
@@ -374,8 +383,9 @@ xfs_attr_set(
 
 out_defer_cancel:
 	xfs_defer_cancel(&dfops);
-	args.trans = NULL;
 out:
+	if (leaf_bp)
+		xfs_trans_brelse(args.trans, leaf_bp);
 	if (args.trans)
 		xfs_trans_cancel(args.trans);
 	xfs_iunlock(dp, XFS_ILOCK_EXCL);
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -739,10 +739,13 @@ xfs_attr_shortform_getvalue(xfs_da_args_
 }
 
 /*
- * Convert from using the shortform to the leaf.
+ * Convert from using the shortform to the leaf.  On success, return the
+ * buffer so that we can keep it locked until we're totally done with it.
  */
 int
-xfs_attr_shortform_to_leaf(xfs_da_args_t *args)
+xfs_attr_shortform_to_leaf(
+	struct xfs_da_args	*args,
+	struct xfs_buf		**leaf_bp)
 {
 	xfs_inode_t *dp;
 	xfs_attr_shortform_t *sf;
@@ -821,7 +824,7 @@ xfs_attr_shortform_to_leaf(xfs_da_args_t
 		sfe = XFS_ATTR_SF_NEXTENTRY(sfe);
 	}
 	error = 0;
-
+	*leaf_bp = bp;
 out:
 	kmem_free(tmpbuffer);
 	return error;
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -48,7 +48,8 @@ void	xfs_attr_shortform_create(struct xf
 void	xfs_attr_shortform_add(struct xfs_da_args *args, int forkoff);
 int	xfs_attr_shortform_lookup(struct xfs_da_args *args);
 int	xfs_attr_shortform_getvalue(struct xfs_da_args *args);
-int	xfs_attr_shortform_to_leaf(struct xfs_da_args *args);
+int	xfs_attr_shortform_to_leaf(struct xfs_da_args *args,
+			struct xfs_buf **leaf_bp);
 int	xfs_attr_shortform_remove(struct xfs_da_args *args);
 int	xfs_attr_shortform_allfit(struct xfs_buf *bp, struct xfs_inode *dp);
 int	xfs_attr_shortform_bytesfit(struct xfs_inode *dp, int bytes);


