Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793CB21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116602;
	bh=Z1R5X6aZeRG7Tubzh1tLCc+vFMN6XdZrreBkoMLXWeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PWpns4pQGfYhqlO3iFuyUrA1fYe8UdTZUYOD2H8NKjK/Cuowjkz0BT2dmqiPJOsD+
	 iTffXFKpwBatDqUhp1wD3VCB90VdBo2tNunwJIp5ImxumQzcgfkef3IsqhZO0m7jQD
	 Y4K7yXGHD0QxlzkrpYRDazTE1altWfaCi+zUBY5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfDXOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731605AbfDXOgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BED21900;
        Wed, 24 Apr 2019 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116597;
        bh=Z1R5X6aZeRG7Tubzh1tLCc+vFMN6XdZrreBkoMLXWeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGC70A07UzdKkgHbumJO+MOhAuNnCrfAl2TgMTt5R3PIviqoCzWlbJYv9zM+S5cw1
         k5CHJqR2HLEAjoZH6xYY9zwCympn+WY3qqeAPDiyGdb3++2MoyJhDsPVSKbCqVVedg
         UjMeMhzXbg/I8OFYXNZPNf9XjqfgUr2AEHLLfQk4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH AUTOSEL 5.0 62/66] pin iocb through aio.
Date:   Wed, 24 Apr 2019 10:33:36 -0400
Message-Id: <20190424143341.27665-62-sashal@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit b53119f13a04879c3bf502828d99d13726639ead ]

aio_poll() is not the only case that needs file pinned; worse, while
aio_read()/aio_write() can live without pinning iocb itself, the
proof is rather brittle and can easily break on later changes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3d9669d011b9..363d7d7c8bff 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1022,6 +1022,9 @@ static bool get_reqs_available(struct kioctx *ctx)
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
+ *
+ * The refcount is initialized to 2 - one for the async op completion,
+ * one for the synchronous code that does this.
  */
 static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
@@ -1034,7 +1037,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
 	INIT_LIST_HEAD(&req->ki_list);
-	refcount_set(&req->ki_refcnt, 0);
+	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
 	return req;
 }
@@ -1067,15 +1070,18 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+static inline void iocb_destroy(struct aio_kiocb *iocb)
+{
+	if (iocb->ki_filp)
+		fput(iocb->ki_filp);
+	percpu_ref_put(&iocb->ki_ctx->reqs);
+	kmem_cache_free(kiocb_cachep, iocb);
+}
+
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
-	if (refcount_read(&iocb->ki_refcnt) == 0 ||
-	    refcount_dec_and_test(&iocb->ki_refcnt)) {
-		if (iocb->ki_filp)
-			fput(iocb->ki_filp);
-		percpu_ref_put(&iocb->ki_ctx->reqs);
-		kmem_cache_free(kiocb_cachep, iocb);
-	}
+	if (refcount_dec_and_test(&iocb->ki_refcnt))
+		iocb_destroy(iocb);
 }
 
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
@@ -1749,9 +1755,6 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	INIT_LIST_HEAD(&req->wait.entry);
 	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
 
-	/* one for removal from waitqueue, one for this function */
-	refcount_set(&aiocb->ki_refcnt, 2);
-
 	mask = vfs_poll(req->file, &apt.pt) & req->events;
 	if (unlikely(!req->head)) {
 		/* we did not manage to set up a waitqueue, done */
@@ -1782,7 +1785,6 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 	if (mask)
 		aio_poll_complete(aiocb, mask);
-	iocb_put(aiocb);
 	return 0;
 }
 
@@ -1873,18 +1875,21 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		break;
 	}
 
+	/* Done with the synchronous reference */
+	iocb_put(req);
+
 	/*
 	 * If ret is 0, we'd either done aio_complete() ourselves or have
 	 * arranged for that to be done asynchronously.  Anything non-zero
 	 * means that we need to destroy req ourselves.
 	 */
-	if (ret)
-		goto out_put_req;
-	return 0;
+	if (!ret)
+		return 0;
+
 out_put_req:
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
-	iocb_put(req);
+	iocb_destroy(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
-- 
2.19.1

