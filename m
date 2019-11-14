Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD639206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RLZ3Ddrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:31:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfKNEbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:31:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so2868938pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 20:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ATcCOvPgaDxDdfb/2fmiaxeweoZIFDGlDDkWkjQsyvY=;
        b=RLZ3DdrzvnlpKn78eg7PLlkgOiwaq/1jGHecsmEGH08sCwiSEyiJIHWQVQosVurRAz
         8drBb1+jSOJHM3kkew5ancydBlYeV0wM/r6eafY/ZQn5vBKAG/x4tQ2Gj908mvMXFLCf
         mqzgpWxUdzpinHuYY/3+Dbkgoq+W2pl/z0E0WHMEdNfu97C2DsJHsJd+sHJMOS4iv8as
         vzmiveQRoT2t0QgKXq8k3V831DxPctrdOrxZ21uIp+f2pliDtnlLtzuF7EWiHncJZ4sU
         yzfaBEcmbGsQhQlTV/9RqtpYBQedd6PHhKse6r5k1r60QM9ZnpPJcBdve/Yx+THGQ3SN
         ZWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ATcCOvPgaDxDdfb/2fmiaxeweoZIFDGlDDkWkjQsyvY=;
        b=RPXjWlOXxkxOpG/Em8Wdy2zZmU6HeUJcvD06W+yTzRMly+6QjXH02NEskRtdTQVLfe
         oZV43mB25rVw7q6t16SgtUrhw/c51ccXrZHa9aofcIMCoFfFgFNNPUnu00sTkCEi30hp
         HfYc1FkcffcuDSVxQ0QYsjRrGWs2H/ch+BXYlcVbUTW7Fd3vA80eMXeu19nBaHlngu9E
         behmZHF6lj59f8ghO7Q1dEqrVbFCVhPAgedPheHvzXCdrmrceU0tNe91uuFKdnb4XjLD
         ZS6raeRS2LjlnM5MbzogEUDkufV6raWV5AetJLZl3iJJr44N/IsGdo3JfPrCpjLrs9+G
         Vu7g==
X-Gm-Message-State: APjAAAUGc0WN4BX9hY6lc6DDGUQTD4OL60MwFmZXvDCrlbREAZ43iHBF
        e/jnWC3N883iEbhasMJ75kpXYg==
X-Google-Smtp-Source: APXvYqxT2qEUiCoLd/ZcoKmq/Ca+QIL1lDVpHdDad0BcRpMCe3PoHcHKGE+wGWSN2EdDOvkKnYqWOQ==
X-Received: by 2002:a63:f441:: with SMTP id p1mr7746477pgk.362.1573705869452;
        Wed, 13 Nov 2019 20:31:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 129sm3179960pfd.174.2019.11.13.20.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 20:31:08 -0800 (PST)
To:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio) POLL
Message-ID: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
Date:   Wed, 13 Nov 2019 21:31:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a case of "I don't really know what I'm doing, but this works
for me". Caveat emptor, but I'd love some input on this.

I got a bug report that using the poll command with signalfd doesn't
work for io_uring. The reporter also noted that it doesn't work with the
aio poll implementation either. So I took a look at it.

What happens is that the original task issues the poll request, we call
->poll() (which ends up with signalfd for this fd), and find that
nothing is pending. Then we wait, and the poll is passed to async
context. When the requested signal comes in, that worker is woken up,
and proceeds to call ->poll() again, and signalfd unsurprisingly finds
no signals pending, since it's the async worker calling it.

That's obviously no good. The below allows you to pass in the task in
the poll_table, and it does the right thing for me, signal is delivered
and the correct mask is checked in signalfd_poll().

Similar patch for aio would be trivial, of course.

Not-really-signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d8ea9b4f83a7..d9a4c9aac958 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -299,6 +299,7 @@ struct io_poll_iocb {
 	bool				done;
 	bool				canceled;
 	struct wait_queue_entry		wait;
+	struct task_struct		*task;
 };
 
 struct io_timeout {
@@ -2021,7 +2022,10 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_poll_iocb *poll = &req->poll;
-	struct poll_table_struct pt = { ._key = poll->events };
+	struct poll_table_struct pt = {
+		._key = poll->events,
+		.task = poll->task
+	};
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt = NULL;
 	__poll_t mask = 0;
@@ -2139,9 +2143,11 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	poll->head = NULL;
 	poll->done = false;
 	poll->canceled = false;
+	poll->task = current;
 
 	ipt.pt._qproc = io_poll_queue_proc;
 	ipt.pt._key = poll->events;
+	ipt.pt.task = poll->task;
 	ipt.req = req;
 	ipt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
 
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..a7f31758db1a 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -61,16 +61,17 @@ static int signalfd_release(struct inode *inode, struct file *file)
 static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 {
 	struct signalfd_ctx *ctx = file->private_data;
+	struct task_struct *tsk = wait->task ?: current;
 	__poll_t events = 0;
 
-	poll_wait(file, &current->sighand->signalfd_wqh, wait);
+	poll_wait(file, &tsk->sighand->signalfd_wqh, wait);
 
-	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (next_signal(&tsk->pending, &ctx->sigmask) ||
+	    next_signal(&tsk->signal->shared_pending,
 			&ctx->sigmask))
 		events |= EPOLLIN;
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
 
 	return events;
 }
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 1cdc32b1f1b0..6d2b6d923b2b 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -43,6 +43,7 @@ typedef void (*poll_queue_proc)(struct file *, wait_queue_head_t *, struct poll_
 typedef struct poll_table_struct {
 	poll_queue_proc _qproc;
 	__poll_t _key;
+	struct task_struct *task;
 } poll_table;
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
@@ -76,6 +77,7 @@ static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
 {
 	pt->_qproc = qproc;
 	pt->_key   = ~(__poll_t)0; /* all events enabled */
+	pt->task = NULL;
 }
 
 static inline bool file_can_poll(struct file *file)


-- 
Jens Axboe

