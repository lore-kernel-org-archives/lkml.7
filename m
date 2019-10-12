Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A4C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940121850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="DhDsHvNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfJLFuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40676 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfJLFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so14018481wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+Dp2Msw+zGO1kDMu4jE580sA1PjlZN5XJYLh8U2Vi4=;
        b=DhDsHvNRlbkaecGFtWzUBf5/wcJvtxTPGvuM0X7rmKUoiJ1h84srevrfOYz+/GFQDZ
         tIH/+5IijAE0bf6FVqPqwaGzBWl2pW6xZSFvL7uWcXFAVmV+qjHOAX5a4LITWfo5sLj0
         LT6Odm9H5kNqG+kbjc/10xyblTGsAdwdXceRqtNT7ou4LMYjUN6DHEOUXOUikAdK+NWA
         GRj1Ul6SwamBnMwvLq1rx1QWl+gZxI2FzCVDAZPu/pPRCTEExxpImLh4DgEiA+Dodk7c
         mET1It8SFVucxhUWmRF8qmDM6Ka+GCchQPLjHpLuEwJTypJGV+tiqOMocX81lbDSa5IQ
         dIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+Dp2Msw+zGO1kDMu4jE580sA1PjlZN5XJYLh8U2Vi4=;
        b=N7VGEcJ0H6WSyK0YZk3V+jSxfkrhYt3yuDci+2AtPbRp2sorFOjlvQwUOJewveloii
         mafFzuhw/vt2JBMKBKfv1RZcQOHMCqcmF1i7nJGeopsntPnuzSgf2DdUZYGRCu1Cbt40
         Nyh+dCk2zqOBJ+lzzadDW88i+vGu0zze2IihlPDLH5Jt211eijj96eXkBZZ9PjPqxVZv
         Lc5recx8BwnwpSoL2aVviluV2RGol8HtuwohbtaDLx7zfp/ankC4y1yCSUdcyiVuoQER
         s6sxxGIiLew1wogDM2QPy3mn7q9HEESb6K6h4fuXzOBgzdFrNjc4Pe4tGy0EzmqrQZoQ
         a3OA==
X-Gm-Message-State: APjAAAVNGWvN/kecgxdzVQeoBvw/qqEaKUFIMiBLNjmAgkQy+kBZE6r8
        wC2CPvOfoYhvoOsvf8BdTg37rm9nPRflCg==
X-Google-Smtp-Source: APXvYqw57rXFQq2Mp3icaEU95K8brSQiVTWrSCkPrnaM6I+Nf+hN5Uz2a3ym1XrxkhlE58pxX6q0Iw==
X-Received: by 2002:adf:9403:: with SMTP id 3mr17220276wrq.281.1570859411594;
        Fri, 11 Oct 2019 22:50:11 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:11 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 3/6] ipc/mqueue.c: Update/document memory barriers
Date:   Sat, 12 Oct 2019 07:49:55 +0200
Message-Id: <20191012054958.3624-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update and document memory barriers for mqueue.c:
- ewp->state is read without any locks, thus READ_ONCE is required.

- add smp_aquire__after_ctrl_dep() after the READ_ONCE, we need
  acquire semantics if the value is STATE_READY.

- add an explicit memory barrier to __pipelined_op(), the
  refcount must have been increased before the updated state becomes
  visible

- document why __set_current_state() may be used:
  Reading task->state cannot happen before the wake_q_add() call,
  which happens while holding info->lock. Thus the spin_unlock()
  is the RELEASE, and the spin_lock() is the ACQUIRE.

For completeness: there is also a 3 CPU szenario, if the to be woken
up task is already on another wake_q.
Then:
- CPU1: spin_unlock() of the task that goes to sleep is the RELEASE
- CPU2: the spin_lock() of the waker is the ACQUIRE
- CPU2: smp_mb__before_atomic inside wake_q_add() is the RELEASE
- CPU3: smp_mb__after_spinlock() inside try_to_wake_up() is the ACQUIRE

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/mqueue.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index be48c0ba92f7..b80574822f0a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -646,18 +646,26 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
 	wq_add(info, sr, ewp);
 
 	for (;;) {
+		/* memory barrier not required, we hold info->lock */
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_unlock(&info->lock);
 		time = schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
 
-		if (ewp->state == STATE_READY) {
+		if (READ_ONCE(ewp->state) == STATE_READY) {
+			/*
+			 * Pairs, together with READ_ONCE(), with
+			 * the barrier in __pipelined_op().
+			 */
+			smp_acquire__after_ctrl_dep();
 			retval = 0;
 			goto out;
 		}
 		spin_lock(&info->lock);
-		if (ewp->state == STATE_READY) {
+
+		/* we hold info->lock, so no memory barrier required */
+		if (READ_ONCE(ewp->state) == STATE_READY) {
 			retval = 0;
 			goto out_unlock;
 		}
@@ -925,14 +933,12 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
 	list_del(&this->list);
 	wake_q_add(wake_q, this->task);
 	/*
-	 * Rely on the implicit cmpxchg barrier from wake_q_add such
-	 * that we can ensure that updating receiver->state is the last
-	 * write operation: As once set, the receiver can continue,
-	 * and if we don't have the reference count from the wake_q,
-	 * yet, at that point we can later have a use-after-free
-	 * condition and bogus wakeup.
+	 * The barrier is required to ensure that the refcount increase
+	 * inside wake_q_add() is completed before the state is updated.
+	 *
+	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
 	 */
-        this->state = STATE_READY;
+        smp_store_release(&this->state, STATE_READY);
 }
 
 /* pipelined_send() - send a message directly to the task waiting in
@@ -1049,7 +1055,9 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 		} else {
 			wait.task = current;
 			wait.msg = (void *) msg_ptr;
-			wait.state = STATE_NONE;
+
+			/* memory barrier not required, we hold info->lock */
+			WRITE_ONCE(wait.state, STATE_NONE);
 			ret = wq_sleep(info, SEND, timeout, &wait);
 			/*
 			 * wq_sleep must be called with info->lock held, and
@@ -1152,7 +1160,9 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 			ret = -EAGAIN;
 		} else {
 			wait.task = current;
-			wait.state = STATE_NONE;
+
+			/* memory barrier not required, we hold info->lock */
+			WRITE_ONCE(wait.state, STATE_NONE);
 			ret = wq_sleep(info, RECV, timeout, &wait);
 			msg_ptr = wait.msg;
 		}
-- 
2.21.0

