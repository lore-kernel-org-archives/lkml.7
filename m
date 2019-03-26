Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8D320870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582463;
	bh=zDFnRThJpxI6U7oyxsiT/yug3rU5zqywyC9TEpOw0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9P/nFDWAkkJZlYaBZ3GfdeMF+STNOnQZ5EvFgMIfr+X8yze2Y0+AcFOoI4b3JtSJ
	 Zx9cfCpXc8mDjaiSpDFQvQqT7/T2dcsL9zsCLa7lI5Uhv4VkNNp6oM1RPnjaUr8SKc
	 jA+HoD01XfcJ0GexFOmsIafyhH302vq7c01ArnD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfCZGlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbfCZGkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:55 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D8F2086C;
        Tue, 26 Mar 2019 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582454;
        bh=zDFnRThJpxI6U7oyxsiT/yug3rU5zqywyC9TEpOw0jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcVfpgpTLuBS0PyG8w4QauiTQEhpMU6r58Okx2NrHz2/RNr4r266/S6I5bXEIJkJp
         lv+8KCyoTGP2w4vDx2la+/IGy75riLBsLdrD0gI1jLo12cJhw+QBANVihY8CkyyEU5
         4gDLuzRj8dGMwIPpDTEQMfltqq1XDdcFuAA88FIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 44/52] aio: simplify - and fix - fget/fput for io_submit()
Date:   Tue, 26 Mar 2019 15:30:31 +0900
Message-Id: <20190326042703.322415113@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 84c4e1f89fefe70554da0ab33be72c9be7994379 upstream.

Al Viro root-caused a race where the IOCB_CMD_POLL handling of
fget/fput() could cause us to access the file pointer after it had
already been freed:

 "In more details - normally IOCB_CMD_POLL handling looks so:

   1) io_submit(2) allocates aio_kiocb instance and passes it to
      aio_poll()

   2) aio_poll() resolves the descriptor to struct file by req->file =
      fget(iocb->aio_fildes)

   3) aio_poll() sets ->woken to false and raises ->ki_refcnt of that
      aio_kiocb to 2 (bumps by 1, that is).

   4) aio_poll() calls vfs_poll(). After sanity checks (basically,
      "poll_wait() had been called and only once") it locks the queue.
      That's what the extra reference to iocb had been for - we know we
      can safely access it.

   5) With queue locked, we check if ->woken has already been set to
      true (by aio_poll_wake()) and, if it had been, we unlock the
      queue, drop a reference to aio_kiocb and bugger off - at that
      point it's a responsibility to aio_poll_wake() and the stuff
      called/scheduled by it. That code will drop the reference to file
      in req->file, along with the other reference to our aio_kiocb.

   6) otherwise, we see whether we need to wait. If we do, we unlock the
      queue, drop one reference to aio_kiocb and go away - eventual
      wakeup (or cancel) will deal with the reference to file and with
      the other reference to aio_kiocb

   7) otherwise we remove ourselves from waitqueue (still under the
      queue lock), so that wakeup won't get us. No async activity will
      be happening, so we can safely drop req->file and iocb ourselves.

  If wakeup happens while we are in vfs_poll(), we are fine - aio_kiocb
  won't get freed under us, so we can do all the checks and locking
  safely. And we don't touch ->file if we detect that case.

  However, vfs_poll() most certainly *does* touch the file it had been
  given. So wakeup coming while we are still in ->poll() might end up
  doing fput() on that file. That case is not too rare, and usually we
  are saved by the still present reference from descriptor table - that
  fput() is not the final one.

  But if another thread closes that descriptor right after our fget()
  and wakeup does happen before ->poll() returns, we are in trouble -
  final fput() done while we are in the middle of a method:

Al also wrote a patch to take an extra reference to the file descriptor
to fix this, but I instead suggested we just streamline the whole file
pointer handling by submit_io() so that the generic aio submission code
simply keeps the file pointer around until the aio has completed.

Fixes: bfe4037e722e ("aio: implement IOCB_CMD_POLL")
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c           |   72 +++++++++++++++++++++--------------------------------
 include/linux/fs.h |    8 +++++
 2 files changed, 36 insertions(+), 44 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -167,9 +167,13 @@ struct kioctx {
 	unsigned		id;
 };
 
+/*
+ * First field must be the file pointer in all the
+ * iocb unions! See also 'struct kiocb' in <linux/fs.h>
+ */
 struct fsync_iocb {
-	struct work_struct	work;
 	struct file		*file;
+	struct work_struct	work;
 	bool			datasync;
 };
 
@@ -183,8 +187,15 @@ struct poll_iocb {
 	struct work_struct	work;
 };
 
+/*
+ * NOTE! Each of the iocb union members has the file pointer
+ * as the first entry in their struct definition. So you can
+ * access the file pointer through any of the sub-structs,
+ * or directly as just 'ki_filp' in this struct.
+ */
 struct aio_kiocb {
 	union {
+		struct file		*ki_filp;
 		struct kiocb		rw;
 		struct fsync_iocb	fsync;
 		struct poll_iocb	poll;
@@ -1060,6 +1071,8 @@ static inline void iocb_put(struct aio_k
 {
 	if (refcount_read(&iocb->ki_refcnt) == 0 ||
 	    refcount_dec_and_test(&iocb->ki_refcnt)) {
+		if (iocb->ki_filp)
+			fput(iocb->ki_filp);
 		percpu_ref_put(&iocb->ki_ctx->reqs);
 		kmem_cache_free(kiocb_cachep, iocb);
 	}
@@ -1424,7 +1437,6 @@ static void aio_complete_rw(struct kiocb
 		file_end_write(kiocb->ki_filp);
 	}
 
-	fput(kiocb->ki_filp);
 	aio_complete(iocb, res, res2);
 }
 
@@ -1432,9 +1444,6 @@ static int aio_prep_rw(struct kiocb *req
 {
 	int ret;
 
-	req->ki_filp = fget(iocb->aio_fildes);
-	if (unlikely(!req->ki_filp))
-		return -EBADF;
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
@@ -1451,7 +1460,7 @@ static int aio_prep_rw(struct kiocb *req
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
-			goto out_fput;
+			return ret;
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
@@ -1460,14 +1469,10 @@ static int aio_prep_rw(struct kiocb *req
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
-		goto out_fput;
+		return ret;
 
 	req->ki_flags &= ~IOCB_HIPRI; /* no one is going to poll for this I/O */
 	return 0;
-
-out_fput:
-	fput(req->ki_filp);
-	return ret;
 }
 
 static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
@@ -1521,24 +1526,19 @@ static ssize_t aio_read(struct kiocb *re
 	if (ret)
 		return ret;
 	file = req->ki_filp;
-
-	ret = -EBADF;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
-		goto out_fput;
+		return -EBADF;
 	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter))
-		goto out_fput;
+		return -EINVAL;
 
 	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
 	if (ret)
-		goto out_fput;
+		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
 		aio_rw_done(req, call_read_iter(file, req, &iter));
 	kfree(iovec);
-out_fput:
-	if (unlikely(ret))
-		fput(file);
 	return ret;
 }
 
@@ -1555,16 +1555,14 @@ static ssize_t aio_write(struct kiocb *r
 		return ret;
 	file = req->ki_filp;
 
-	ret = -EBADF;
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
-		goto out_fput;
-	ret = -EINVAL;
+		return -EBADF;
 	if (unlikely(!file->f_op->write_iter))
-		goto out_fput;
+		return -EINVAL;
 
 	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
 	if (ret)
-		goto out_fput;
+		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
 		/*
@@ -1582,9 +1580,6 @@ static ssize_t aio_write(struct kiocb *r
 		aio_rw_done(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
-out_fput:
-	if (unlikely(ret))
-		fput(file);
 	return ret;
 }
 
@@ -1594,7 +1589,6 @@ static void aio_fsync_work(struct work_s
 	int ret;
 
 	ret = vfs_fsync(req->file, req->datasync);
-	fput(req->file);
 	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
 }
 
@@ -1605,13 +1599,8 @@ static int aio_fsync(struct fsync_iocb *
 			iocb->aio_rw_flags))
 		return -EINVAL;
 
-	req->file = fget(iocb->aio_fildes);
-	if (unlikely(!req->file))
-		return -EBADF;
-	if (unlikely(!req->file->f_op->fsync)) {
-		fput(req->file);
+	if (unlikely(!req->file->f_op->fsync))
 		return -EINVAL;
-	}
 
 	req->datasync = datasync;
 	INIT_WORK(&req->work, aio_fsync_work);
@@ -1621,10 +1610,7 @@ static int aio_fsync(struct fsync_iocb *
 
 static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
 {
-	struct file *file = iocb->poll.file;
-
 	aio_complete(iocb, mangle_poll(mask), 0);
-	fput(file);
 }
 
 static void aio_poll_complete_work(struct work_struct *work)
@@ -1749,9 +1735,6 @@ static ssize_t aio_poll(struct aio_kiocb
 
 	INIT_WORK(&req->work, aio_poll_complete_work);
 	req->events = demangle_poll(iocb->aio_buf) | EPOLLERR | EPOLLHUP;
-	req->file = fget(iocb->aio_fildes);
-	if (unlikely(!req->file))
-		return -EBADF;
 
 	req->head = NULL;
 	req->woken = false;
@@ -1794,10 +1777,8 @@ static ssize_t aio_poll(struct aio_kiocb
 	spin_unlock_irq(&ctx->ctx_lock);
 
 out:
-	if (unlikely(apt.error)) {
-		fput(req->file);
+	if (unlikely(apt.error))
 		return apt.error;
-	}
 
 	if (mask)
 		aio_poll_complete(aiocb, mask);
@@ -1835,6 +1816,11 @@ static int __io_submit_one(struct kioctx
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
+	req->ki_filp = fget(iocb->aio_fildes);
+	ret = -EBADF;
+	if (unlikely(!req->ki_filp))
+		goto out_put_req;
+
 	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
 		/*
 		 * If the IOCB_FLAG_RESFD flag of aio_flags is set, get an
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -304,13 +304,19 @@ enum rw_hint {
 
 struct kiocb {
 	struct file		*ki_filp;
+
+	/* The 'ki_filp' pointer is shared in a union for aio */
+	randomized_struct_fields_start
+
 	loff_t			ki_pos;
 	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
-} __randomize_layout;
+
+	randomized_struct_fields_end
+};
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
 {


