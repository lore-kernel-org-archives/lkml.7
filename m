Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E4C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B721900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116622;
	bh=rMk+C1vK8BfFTsnhRIYkWgj+ZXryiP+lubAOWx7AcFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6hUHecYNUatL/ENbJrAFS3C06rYsl5boqGfkwzOt3GSC6sI4WRFK6Y2uQwP5Ev80
	 /USk8ArlWduxwNd6gF4+pZdi834R9ECqxJxAZ8WFqVPhgi5KTx5ZabLUMWwaZgjXUC
	 1NrR4fDstCx979FGFnUyj5aaZc8LEGQnuOSygCzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfDXOgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbfDXOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B2A21909;
        Wed, 24 Apr 2019 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116601;
        bh=rMk+C1vK8BfFTsnhRIYkWgj+ZXryiP+lubAOWx7AcFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqGfxkvKcEraPX9+weMvapyAYUzof+dxxOJYNbEjXl8+YDhbyZmMKVYdkFDVhLpM2
         4jvydA5PEe2xSzGq5fn90LXATokX3P/KXsjUbYAcI6QH4RTYTEOJ1wlDcMcISsqfMT
         zh9WykLw8n6dlNkcbWGCVNPrhgVFLI0HNbRKoysU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: [PATCH AUTOSEL 5.0 64/66] aio: keep io_event in aio_kiocb
Date:   Wed, 24 Apr 2019 10:33:38 -0400
Message-Id: <20190424143341.27665-64-sashal@kernel.org>
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

[ Upstream commit a9339b7855094ba11a97e8822ae038135e879e79 ]

We want to separate forming the resulting io_event from putting it
into the ring buffer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ae60c29b8a98..387b224217b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -204,8 +204,7 @@ struct aio_kiocb {
 	struct kioctx		*ki_ctx;
 	kiocb_cancel_fn		*ki_cancel;
 
-	struct iocb __user	*ki_user_iocb;	/* user's aiocb */
-	__u64			ki_user_data;	/* user's data for completion */
+	struct io_event		ki_res;
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -1084,15 +1083,6 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 		iocb_destroy(iocb);
 }
 
-static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
-			   long res, long res2)
-{
-	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
-	ev->data = iocb->ki_user_data;
-	ev->res = res;
-	ev->res2 = res2;
-}
-
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1104,6 +1094,8 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	unsigned tail, pos, head;
 	unsigned long	flags;
 
+	iocb->ki_res.res = res;
+	iocb->ki_res.res2 = res2;
 	/*
 	 * Add a completion event to the ring buffer. Must be done holding
 	 * ctx->completion_lock to prevent other code from messing with the tail
@@ -1120,14 +1112,14 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
-	aio_fill_event(event, iocb, res, res2);
+	*event = iocb->ki_res;
 
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
-	pr_debug("%p[%u]: %p: %p %Lx %lx %lx\n",
-		 ctx, tail, iocb, iocb->ki_user_iocb, iocb->ki_user_data,
-		 res, res2);
+	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
+		 (void __user *)(unsigned long)iocb->ki_res.obj,
+		 iocb->ki_res.data, iocb->ki_res.res, iocb->ki_res.res2);
 
 	/* after flagging the request as done, we
 	 * must never even look at it again
@@ -1844,8 +1836,10 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		goto out_put_req;
 	}
 
-	req->ki_user_iocb = user_iocb;
-	req->ki_user_data = iocb->aio_data;
+	req->ki_res.obj = (u64)(unsigned long)user_iocb;
+	req->ki_res.data = iocb->aio_data;
+	req->ki_res.res = 0;
+	req->ki_res.res2 = 0;
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
@@ -2019,6 +2013,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	struct aio_kiocb *kiocb;
 	int ret = -EINVAL;
 	u32 key;
+	u64 obj = (u64)(unsigned long)iocb;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
@@ -2032,7 +2027,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	spin_lock_irq(&ctx->ctx_lock);
 	/* TODO: use a hash or array, this sucks. */
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
-		if (kiocb->ki_user_iocb == iocb) {
+		if (kiocb->ki_res.obj == obj) {
 			ret = kiocb->ki_cancel(&kiocb->rw);
 			list_del_init(&kiocb->ki_list);
 			break;
-- 
2.19.1

