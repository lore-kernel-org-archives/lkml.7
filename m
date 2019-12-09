Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DC72077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575887287;
	bh=aUluel73jszc5HGoGM15wcPlAP9gDKT1ifArlEQ/6n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d6ad/JOwbx2vYFL6PsZq6h4xNEC0eJWbnbIM11b68XGlZpUOooutshNXAHtZYCWF7
	 k/55t+Yx2R9lkm7DP8GhpF2BMa1XSFn6zcVFT1fgVoukk4lK1RR5qsppj8mVtz4A53
	 qpVWNuU/ZXli+c6pWvYfNU2ThwIkPQ2F4fkBGDJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfLIK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:28:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so14897493wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 02:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4GLNuPvXa946MKOEj+GxTbV4L+MbmiJYwQR6Q556Ztc=;
        b=Wp+wkdCH7SDBK+7favQomUPmvNLLgRSfFByQcnl3AZDUvDq8LOZSK49p6E/BLViErp
         EmRrnsx8PX4EfCz5My5yPnYPRbn6WeZWWzTkfZMrDgHbw6YerFte2RUSa9kt4oapMyIH
         53bLRBmi+2xuayqevfU0J8c+6BrVkhiTSwzNfuNbnXjJDmAFT5NHyIZreypvafng3pNJ
         WF5I0nivr+0JeVhPuOH772qaK8BuSmZs3qFcfszDRSXY1R9pED+lxcwTrbuESSnI6YMR
         1aYy4xI5PGwalyM6aMnd6ubnSi7MJPxKgWeQo2hcrTfhsF95SHeCIAZnRh6ZF3XKXFUw
         MF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4GLNuPvXa946MKOEj+GxTbV4L+MbmiJYwQR6Q556Ztc=;
        b=lW3bQ50ADZpqteUIzsWqYL2k6kash/L7euKM03RpOuH1wZN8LzKZnjq9wRsnnHkCuo
         4bEdjDnrYp9ChuakhN2xfMR4OnWvnpIghanDIffq8Gtj2Y9DfJO4P3fn8VCcrz02CGwt
         6tZIKQ4xWU8ndx/HjXk6Y9rDXIciGWSkq3PIF1MgqyGrMOE3eGC0vVogTywO96dVUxZq
         GM6xCboFTVRn9QbJVUXh/vq39mXKD8aP1LZHiX94yHxTRN+IBsFQLLUycw/5d/mm/y3m
         /y/4rx68RxuhyaBs6YQdptl616LExL//cX6e16eXyL8vJSUO3GLzTERJJxZQ6xgJjB1U
         ls4A==
X-Gm-Message-State: APjAAAVwsKuCX5c5L49HDX/4NhjlovzxzbB4aWog4oU2UTAyRMEnW/1H
        RKFTkDLpGxLNPfCrjlXNSHE=
X-Google-Smtp-Source: APXvYqzF40EwMEEO3bBSTJ7eKI62CECC7ThMA1uHrN1iTzA5WIJb09feact/jY2/S746XlPm9IAMEw==
X-Received: by 2002:a1c:a78f:: with SMTP id q137mr24518144wme.8.1575887281974;
        Mon, 09 Dec 2019 02:28:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a16sm26202734wrt.37.2019.12.09.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 02:28:01 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:27:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
Message-ID: <20191209102759.GA123769@gmail.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209091813.GA41320@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> I think your analysis is correct, and I think the statistical evidence 
> is also overwhelming that the interface is buggy: if we include your 
> new usecase then 3 out of 3 attempts got it wrong. :-)
> 
> So I'd argue we should fix the interface and allow the 'simple' use of 
> reliable interruptible-exclusive waitqueues - i.e. reintroduce the 
> abort_exclusive_wait() logic?

Forgot to attach the patch...

Totally untested, but shows the principle: I believe interrupted 
exclusive waits should not auto-cleanup in prepare_to_wait_event().

This slightly complicates the error path of open coded 
prepare_to_wait_event() users, but there's only one in BTRFS, so ...

Also note that there's now a split of the cleanup interface, 
finish_wait() vs. finish_wait_exclusive().

In principle this could be the same API, but then we'd have to pass in a 
new flag which is a runtime overhead - but splitting the API we can do 
this at build time.

Any consumed exclusive event is handled in finish_wait_exclusive() now:

+               } else {
+                       /* We got removed from the waitqueue already, wake up the next exclusive waiter (if any): */
+                       if (interrupted && waitqueue_active(wq_head))
+                               __wake_up_locked_key(wq_head, TASK_NORMAL, NULL);

I tried to maintain the lockless fastpath in the usual 
finish_wait_exclusive() fastpath.

I pushed the cleanup into finish_wait() to reduce the inlining footprint 
of wait_event*() - the most readable variant of this event loop would be 
to open code the signal check in the wait.h macro itself.

I also also added a WARN_ON() to check an assumption that I think is 
always true, and which could be used to remove the 
___wait_is_interruptible(state) check.

BTW., I actually like it that we now always go through finish_wait(), 
even in the interrupted case, makes the main loop easier to read IMHO.

Completely, utterly untested though, and might be terminally broken.

Thanks,

	Ingo

Subject: [PATCH] sched/wait: Make interruptible exclusive waitqueue wakeups reliable

---
 fs/btrfs/space-info.c    |  1 +
 include/linux/wait.h     | 16 +++++++----
 include/linux/wait_bit.h | 13 +++++----
 kernel/sched/wait.c      | 72 +++++++++++++++++++++++++++++++-----------------
 4 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f09aa6ee9113..39b8d044b6c5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -899,6 +899,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 			 * despite getting an error, resulting in a space leak
 			 * (bytes_may_use counter of our space_info).
 			 */
+			finish_wait(&ticket->wait, &wait);
 			list_del_init(&ticket->list);
 			ticket->error = -EINTR;
 			break;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d02137..a86a6e0148b1 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -261,26 +261,31 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 
 #define ___wait_event(wq_head, condition, state, exclusive, ret, cmd)		\
 ({										\
-	__label__ __out;							\
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
+	long __int = 0;								\
 										\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
-		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
+		__int = prepare_to_wait_event(&wq_head, &__wq_entry, state);	\
 										\
 		if (condition)							\
 			break;							\
 										\
+		WARN_ON_ONCE(__int && !___wait_is_interruptible(state));	\
+										\
 		if (___wait_is_interruptible(state) && __int) {			\
 			__ret = __int;						\
-			goto __out;						\
+			break;							\
 		}								\
 										\
 		cmd;								\
 	}									\
-	finish_wait(&wq_head, &__wq_entry);					\
-__out:	__ret;									\
+	if (exclusive)								\
+		finish_wait_exclusive(&wq_head, &__wq_entry, __int);		\
+	else									\
+		finish_wait(&wq_head, &__wq_entry);				\
+	__ret;									\
 })
 
 #define __wait_event(wq_head, condition)					\
@@ -1127,6 +1132,7 @@ void prepare_to_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *w
 void prepare_to_wait_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
 long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
 void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
+void finish_wait_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, long interrupted);
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout);
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7dec36aecbd9..a431fc3349a2 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -241,15 +241,15 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 
 #define ___wait_var_event(var, condition, state, exclusive, ret, cmd)	\
 ({									\
-	__label__ __out;						\
 	struct wait_queue_head *__wq_head = __var_waitqueue(var);	\
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
+	long __int = 0;							\
 									\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-		long __int = prepare_to_wait_event(__wq_head,		\
+		__int = prepare_to_wait_event(__wq_head,		\
 						   &__wbq_entry.wq_entry, \
 						   state);		\
 		if (condition)						\
@@ -257,13 +257,16 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 									\
 		if (___wait_is_interruptible(state) && __int) {		\
 			__ret = __int;					\
-			goto __out;					\
+			break;						\
 		}							\
 									\
 		cmd;							\
 	}								\
-	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
-__out:	__ret;								\
+	if (exclusive)							\
+		finish_wait_exclusive(__wq_head, &__wbq_entry.wq_entry, __int); \
+	else								\
+		finish_wait(__wq_head, &__wbq_entry.wq_entry);		\
+	__ret;								\
 })
 
 #define __wait_var_event(var, condition)				\
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index ba059fbfc53a..ed4318fe4e32 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -275,36 +275,20 @@ EXPORT_SYMBOL(init_wait_entry);
 long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state)
 {
 	unsigned long flags;
-	long ret = 0;
+
+	if (signal_pending_state(state, current))
+		return -ERESTARTSYS;
 
 	spin_lock_irqsave(&wq_head->lock, flags);
-	if (signal_pending_state(state, current)) {
-		/*
-		 * Exclusive waiter must not fail if it was selected by wakeup,
-		 * it should "consume" the condition we were waiting for.
-		 *
-		 * The caller will recheck the condition and return success if
-		 * we were already woken up, we can not miss the event because
-		 * wakeup locks/unlocks the same wq_head->lock.
-		 *
-		 * But we need to ensure that set-condition + wakeup after that
-		 * can't see us, it should wake up another exclusive waiter if
-		 * we fail.
-		 */
-		list_del_init(&wq_entry->entry);
-		ret = -ERESTARTSYS;
-	} else {
-		if (list_empty(&wq_entry->entry)) {
-			if (wq_entry->flags & WQ_FLAG_EXCLUSIVE)
-				__add_wait_queue_entry_tail(wq_head, wq_entry);
-			else
-				__add_wait_queue(wq_head, wq_entry);
-		}
-		set_current_state(state);
+	if (list_empty(&wq_entry->entry)) {
+		if (wq_entry->flags & WQ_FLAG_EXCLUSIVE)
+			__add_wait_queue_entry_tail(wq_head, wq_entry);
+		else
+			__add_wait_queue(wq_head, wq_entry);
 	}
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(prepare_to_wait_event);
 
@@ -384,6 +368,44 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
 }
 EXPORT_SYMBOL(finish_wait);
 
+/**
+ * finish_wait_exclusive - clean up after waiting in a queue as an exclusive waiter
+ * @wq_head: waitqueue waited on
+ * @wq_entry: wait descriptor
+ *
+ * Sets current thread back to running state and removes
+ * the wait descriptor from the given waitqueue if still
+ * queued.
+ *
+ * It also makes sure that if an exclusive wait was interrupted, no events are lost.
+ */
+void finish_wait_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, long interrupted)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+
+	if (interrupted) {
+		spin_lock_irqsave(&wq_head->lock, flags);
+		if (!list_empty(&wq_entry->entry)) {
+			list_del_init(&wq_entry->entry);
+		} else {
+			/* We got removed from the waitqueue already, wake up the next exclusive waiter (if any): */
+			if (interrupted && waitqueue_active(wq_head))
+				__wake_up_locked_key(wq_head, TASK_NORMAL, NULL);
+		}
+		spin_unlock_irqrestore(&wq_head->lock, flags);
+	} else {
+		/* See finish_wait() about why this lockless check is safe: */
+		if (!list_empty_careful(&wq_entry->entry)) {
+			spin_lock_irqsave(&wq_head->lock, flags);
+			list_del_init(&wq_entry->entry);
+			spin_unlock_irqrestore(&wq_head->lock, flags);
+		}
+	}
+}
+EXPORT_SYMBOL(finish_wait_exclusive);
+
 int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
