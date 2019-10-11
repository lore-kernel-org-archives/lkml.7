Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721821835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfJKQ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:56:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727149AbfJKQ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:56:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 648B6AB91;
        Fri, 11 Oct 2019 16:56:40 +0000 (UTC)
Date:   Fri, 11 Oct 2019 09:55:27 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/5] ipc/mqueue.c: Update/document memory barriers
Message-ID: <20191011165527.bsdiw6gu2sk7yrnl@linux-p48b>
References: <20191011112009.2365-1-manfred@colorfullife.com>
 <20191011112009.2365-3-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191011112009.2365-3-manfred@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019, Manfred Spraul wrote:

>Update and document memory barriers for mqueue.c:
>- ewp->state is read without any locks, thus READ_ONCE is required.

In general we relied on the barrier for not needing READ/WRITE_ONCE,
but I agree this scenario should be better documented with them.
Similarly imo, the 'state' should also need them for write, even if
under the lock -- consistency and documentation, for example.

In addition, I think it makes sense to encapsulate some of the
pipelined send/recv operations, that also can allow us to keep
the barrier comments in pipelined_send(), which I wonder why
you chose to remove. Something like so, before your changes:

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 3d920ff15c80..be48c0ba92f7 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -918,17 +918,12 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
  * The same algorithm is used for senders.
  */
 
-/* pipelined_send() - send a message directly to the task waiting in
- * sys_mq_timedreceive() (without inserting message into a queue).
- */
-static inline void pipelined_send(struct wake_q_head *wake_q,
+static inline void __pipelined_op(struct wake_q_head *wake_q,
 				  struct mqueue_inode_info *info,
-				  struct msg_msg *message,
-				  struct ext_wait_queue *receiver)
+				  struct ext_wait_queue *this)
 {
-	receiver->msg = message;
-	list_del(&receiver->list);
-	wake_q_add(wake_q, receiver->task);
+	list_del(&this->list);
+	wake_q_add(wake_q, this->task);
 	/*
 	 * Rely on the implicit cmpxchg barrier from wake_q_add such
 	 * that we can ensure that updating receiver->state is the last
@@ -937,7 +932,19 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
 	 * yet, at that point we can later have a use-after-free
 	 * condition and bogus wakeup.
 	 */
-	receiver->state = STATE_READY;
+        this->state = STATE_READY;
+}
+
+/* pipelined_send() - send a message directly to the task waiting in
+ * sys_mq_timedreceive() (without inserting message into a queue).
+ */
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
+				  struct msg_msg *message,
+				  struct ext_wait_queue *receiver)
+{
+	receiver->msg = message;
+	__pipelined_op(wake_q, info, receiver);
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
@@ -955,9 +962,7 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
 	if (msg_insert(sender->msg, info))
 		return;
 
-	list_del(&sender->list);
-	wake_q_add(wake_q, sender->task);
-	sender->state = STATE_READY;
+	__pipelined_op(wake_q, info, sender);
 }
 
 static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
