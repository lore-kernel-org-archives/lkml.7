Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF77121904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116611;
	bh=2ZLr2MBeGEAcRLUr9ojdOI8LqgkgqlZeQZAwNzN+EiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oVpLp+A11BoLAOFF68KOt+e9CvOVWVvBqdGldRfdg3apGqtw/fCGpz/jxt/Dx5wRd
	 rVeoDlQKKU46h5F58F3TLTzD04/skwT5hJLk0SioEwJPscUshM7Oj1bzM697EEjvpA
	 23tvM/E7X8rplOArM07LdxHVRjH5D9QBxRjDFZVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfDXOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfDXOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4828C21901;
        Wed, 24 Apr 2019 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116603;
        bh=2ZLr2MBeGEAcRLUr9ojdOI8LqgkgqlZeQZAwNzN+EiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1HEoxMc31JooNzXPYUv+XjhX9PeaLRDKIH8+Ko62gRpfPHkj79ocL/sjjr2HqhEQ
         KXPKCoP1uF4tUOtr7zOhBiGYjDQlotSW6fKLd2g7i110iX9kQeX26wNKiqSyeVwMca
         de1OQVvh+65JDBCo7NQkUHbhNNnVEEj3jCwLW5J8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 65/66] aio: store event at final iocb_put()
Date:   Wed, 24 Apr 2019 10:33:39 -0400
Message-Id: <20190424143341.27665-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 2bb874c0d873d13bd9b9b9c6d7b7c4edab18c8b4 ]

Instead of having aio_complete() set ->ki_res.{res,res2}, do that
explicitly in its callers, drop the reference (as aio_complete()
used to do) and delay the rest until the final iocb_put().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 387b224217b5..82bf5dffb272 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1077,16 +1077,10 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
 	kmem_cache_free(kiocb_cachep, iocb);
 }
 
-static inline void iocb_put(struct aio_kiocb *iocb)
-{
-	if (refcount_dec_and_test(&iocb->ki_refcnt))
-		iocb_destroy(iocb);
-}
-
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_complete(struct aio_kiocb *iocb)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
@@ -1094,8 +1088,6 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	unsigned tail, pos, head;
 	unsigned long	flags;
 
-	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
 	/*
 	 * Add a completion event to the ring buffer. Must be done holding
 	 * ctx->completion_lock to prevent other code from messing with the tail
@@ -1161,7 +1153,14 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
-	iocb_put(iocb);
+}
+
+static inline void iocb_put(struct aio_kiocb *iocb)
+{
+	if (refcount_dec_and_test(&iocb->ki_refcnt)) {
+		aio_complete(iocb);
+		iocb_destroy(iocb);
+	}
 }
 
 /* aio_read_events_ring
@@ -1435,7 +1434,9 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	aio_complete(iocb, res, res2);
+	iocb->ki_res.res = res;
+	iocb->ki_res.res2 = res2;
+	iocb_put(iocb);
 }
 
 static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
@@ -1583,11 +1584,10 @@ static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
 
 static void aio_fsync_work(struct work_struct *work)
 {
-	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
-	int ret;
+	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
 
-	ret = vfs_fsync(req->file, req->datasync);
-	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+	iocb_put(iocb);
 }
 
 static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
@@ -1608,7 +1608,8 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 
 static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
 {
-	aio_complete(iocb, mangle_poll(mask), 0);
+	iocb->ki_res.res = mangle_poll(mask);
+	iocb_put(iocb);
 }
 
 static void aio_poll_complete_work(struct work_struct *work)
-- 
2.19.1

