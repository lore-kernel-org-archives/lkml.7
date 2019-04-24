Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61907C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F09F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126968;
	bh=ZQzptpyj1E//+xO0yoURopM15v6ItdW6MgfVlmygSSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RcFH78Edaift8hCWQ7KQUz5iqVrz0oyGfMCNU4rSNZQ9kfgYgdjyGpW8CRn+h3TZZ
	 FvyBk6iefNvL76XAxXd8hfEjnV0R4YCcNNUaYZvr+mYbfgvXhRzb5nUA4WMj2RpqBB
	 Hh7ssSjtS8OpibWgt2nL28o5Y8ztlmlHO59amBFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbfDXR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390267AbfDXR3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F20206BA;
        Wed, 24 Apr 2019 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126957;
        bh=ZQzptpyj1E//+xO0yoURopM15v6ItdW6MgfVlmygSSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9SKq0kbf2OB9w5SB9FHpIVD3+RW2nKnciBI4YHts1DYn0RacVEP0IQqRQla10FYN
         fHxhmuTa5C9gbBvHmpzWT4yDJd8VGTnhbi09AHOIjpp/blCDRauunDmOw01tYVat++
         20FVOWnfsyWIJfOQhpo2hrLrytcnaiaay3fUmQEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Alex Lyakas <alex@zadara.com>
Subject: [PATCH 4.14 68/70] xfs: add the ability to join a held buffer to a defer_ops
Date:   Wed, 24 Apr 2019 19:10:28 +0200
Message-Id: <20190424170919.112617827@linuxfoundation.org>
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

commit b7b2846fe26f2c0d7f317c874a13d3ecf22670ff upstream.

In certain cases, defer_ops callers will lock a buffer and want to hold
the lock across transaction rolls.  Similar to ijoined inodes, we want
to dirty & join the buffer with each transaction roll in defer_finish so
that afterwards the caller still owns the buffer lock and we haven't
inadvertently pinned the log.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alex Lyakas <alex@zadara.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_defer.c |   39 ++++++++++++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_defer.h |    5 ++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -249,6 +249,10 @@ xfs_defer_trans_roll(
 	for (i = 0; i < XFS_DEFER_OPS_NR_INODES && dop->dop_inodes[i]; i++)
 		xfs_trans_log_inode(*tp, dop->dop_inodes[i], XFS_ILOG_CORE);
 
+	/* Hold the (previously bjoin'd) buffer locked across the roll. */
+	for (i = 0; i < XFS_DEFER_OPS_NR_BUFS && dop->dop_bufs[i]; i++)
+		xfs_trans_dirty_buf(*tp, dop->dop_bufs[i]);
+
 	trace_xfs_defer_trans_roll((*tp)->t_mountp, dop);
 
 	/* Roll the transaction. */
@@ -264,6 +268,12 @@ xfs_defer_trans_roll(
 	for (i = 0; i < XFS_DEFER_OPS_NR_INODES && dop->dop_inodes[i]; i++)
 		xfs_trans_ijoin(*tp, dop->dop_inodes[i], 0);
 
+	/* Rejoin the buffers and dirty them so the log moves forward. */
+	for (i = 0; i < XFS_DEFER_OPS_NR_BUFS && dop->dop_bufs[i]; i++) {
+		xfs_trans_bjoin(*tp, dop->dop_bufs[i]);
+		xfs_trans_bhold(*tp, dop->dop_bufs[i]);
+	}
+
 	return error;
 }
 
@@ -295,6 +305,31 @@ xfs_defer_ijoin(
 		}
 	}
 
+	ASSERT(0);
+	return -EFSCORRUPTED;
+}
+
+/*
+ * Add this buffer to the deferred op.  Each joined buffer is relogged
+ * each time we roll the transaction.
+ */
+int
+xfs_defer_bjoin(
+	struct xfs_defer_ops		*dop,
+	struct xfs_buf			*bp)
+{
+	int				i;
+
+	for (i = 0; i < XFS_DEFER_OPS_NR_BUFS; i++) {
+		if (dop->dop_bufs[i] == bp)
+			return 0;
+		else if (dop->dop_bufs[i] == NULL) {
+			dop->dop_bufs[i] = bp;
+			return 0;
+		}
+	}
+
+	ASSERT(0);
 	return -EFSCORRUPTED;
 }
 
@@ -493,9 +528,7 @@ xfs_defer_init(
 	struct xfs_defer_ops		*dop,
 	xfs_fsblock_t			*fbp)
 {
-	dop->dop_committed = false;
-	dop->dop_low = false;
-	memset(&dop->dop_inodes, 0, sizeof(dop->dop_inodes));
+	memset(dop, 0, sizeof(struct xfs_defer_ops));
 	*fbp = NULLFSBLOCK;
 	INIT_LIST_HEAD(&dop->dop_intake);
 	INIT_LIST_HEAD(&dop->dop_pending);
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -59,6 +59,7 @@ enum xfs_defer_ops_type {
 };
 
 #define XFS_DEFER_OPS_NR_INODES	2	/* join up to two inodes */
+#define XFS_DEFER_OPS_NR_BUFS	2	/* join up to two buffers */
 
 struct xfs_defer_ops {
 	bool			dop_committed;	/* did any trans commit? */
@@ -66,8 +67,9 @@ struct xfs_defer_ops {
 	struct list_head	dop_intake;	/* unlogged pending work */
 	struct list_head	dop_pending;	/* logged pending work */
 
-	/* relog these inodes with each roll */
+	/* relog these with each roll */
 	struct xfs_inode	*dop_inodes[XFS_DEFER_OPS_NR_INODES];
+	struct xfs_buf		*dop_bufs[XFS_DEFER_OPS_NR_BUFS];
 };
 
 void xfs_defer_add(struct xfs_defer_ops *dop, enum xfs_defer_ops_type type,
@@ -77,6 +79,7 @@ void xfs_defer_cancel(struct xfs_defer_o
 void xfs_defer_init(struct xfs_defer_ops *dop, xfs_fsblock_t *fbp);
 bool xfs_defer_has_unfinished_work(struct xfs_defer_ops *dop);
 int xfs_defer_ijoin(struct xfs_defer_ops *dop, struct xfs_inode *ip);
+int xfs_defer_bjoin(struct xfs_defer_ops *dop, struct xfs_buf *bp);
 
 /* Description of a deferred type. */
 struct xfs_defer_op_type {


