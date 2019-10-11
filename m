Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF8C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96221214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="mDr3bVaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfJKLUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43626 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfJKLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id j18so11461944wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVDeeKegIVpF3Miuvea7d5/Yj/QgDeKLTga2PH/DxSg=;
        b=mDr3bVajKoX5kxCNC5YeODLex8bbXGpWHGN0t9Rk8SKIPK+5OJE7ovCSmgEeDbr7RI
         V3xQg59xtamUB9OMZ4urKMcPc7pD/tlH2CvmpyKoieQqLcCs7ZQBVm+KGtSiSC5JgEre
         QE8y/3I1HCeTY8Q2mEvwYXeZZi7De7hRkpYMb/yZpoukRer5YYUjAX4kVUQGkt+80Hj0
         VMH/HTJBpjXG86KI1A+EmCN+SBmxoe3RT1EXiQ8+/kEuJ4YEjdl6C6n+7aG9A51r9rrY
         It3Wilzn0vw2jpuGNRpTHWhTL/yoznWIw88OpN+2RPDTBQMwgx3UhoPZgAdh0qd9n/QR
         hjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVDeeKegIVpF3Miuvea7d5/Yj/QgDeKLTga2PH/DxSg=;
        b=rpuNRgwvqQyb9T3uQF6bon3qB5inh5CaRygbns+/8SthgtnVIYPhA2YIyACWf8c5x5
         cF++StNz/f3NeFRlfkyEDLnQbZ0j18JDimTBacjZB03eqVgOJjIRGNN8RsfScNm2UseJ
         hLsRoT1x1EdSJCg6QbzvyEMgp+pYuRGUdfYwvqv64V7IIrkTwE8Iu7DUhfuVawvI8/FI
         HZWn1tD5hugx8NDCeNoxmThq+yliu9GstS7PkIWMKI8JaE5+smh8xSgkRGrVUohwbckb
         yw8JB+NoOs72YDW3Xs+l+U2lDmnmDAJl63pkkORY9ZWZYHi81sBllRjUGsuUHA4Q5M+I
         6yog==
X-Gm-Message-State: APjAAAXdT51MS15pv6oD1HM+SwloM9ddlAwI8dmoP5g2fYVFFhw1YJX5
        5bXUyclevI8pkCTtrkQmOu9G9NlSt5U=
X-Google-Smtp-Source: APXvYqzKPXlB3FbjCipVMHjFFOJU2bpvAsra1Tx8gVy/+dg8jD+UZsz1tWZgQye5dndMahRd9NNhhg==
X-Received: by 2002:adf:b781:: with SMTP id s1mr12728696wre.343.1570792818253;
        Fri, 11 Oct 2019 04:20:18 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:17 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 2/5] ipc/mqueue.c: Update/document memory barriers
Date:   Fri, 11 Oct 2019 13:20:06 +0200
Message-Id: <20191011112009.2365-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011112009.2365-1-manfred@colorfullife.com>
References: <20191011112009.2365-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update and document memory barriers for mqueue.c:
- ewp->state is read without any locks, thus READ_ONCE is required.

- add smp_aquire__after_ctrl_dep() after the RAED_ONCE, we need
  acquire semantics if the value is STATE_READY.

- document that the code relies on the barrier inside wake_q_add()

- document why __set_current_state() may be used:
  Reading task->state cannot happen before the wake_q_add() call,
  which happens while holding info->lock.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/mqueue.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 3d920ff15c80..902167407737 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -646,17 +646,25 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
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
+			 * the barrier in wake_q_add().
+			 */
+			smp_acquire__after_ctrl_dep();
 			retval = 0;
 			goto out;
 		}
 		spin_lock(&info->lock);
+
+		/* we hold info->lock, so no memory barrier required */
 		if (ewp->state == STATE_READY) {
 			retval = 0;
 			goto out_unlock;
@@ -928,16 +936,11 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
 {
 	receiver->msg = message;
 	list_del(&receiver->list);
+
 	wake_q_add(wake_q, receiver->task);
-	/*
-	 * Rely on the implicit cmpxchg barrier from wake_q_add such
-	 * that we can ensure that updating receiver->state is the last
-	 * write operation: As once set, the receiver can continue,
-	 * and if we don't have the reference count from the wake_q,
-	 * yet, at that point we can later have a use-after-free
-	 * condition and bogus wakeup.
-	 */
-	receiver->state = STATE_READY;
+
+	/* The memory barrier is provided by wake_q_add(). */
+	WRITE_ONCE(receiver->state, STATE_READY);
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
@@ -956,8 +959,11 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
 		return;
 
 	list_del(&sender->list);
+
 	wake_q_add(wake_q, sender->task);
-	sender->state = STATE_READY;
+
+	/* The memory barrier is provided by wake_q_add(). */
+	WRITE_ONCE(sender->state, STATE_READY);
 }
 
 static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
@@ -1044,6 +1050,8 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 		} else {
 			wait.task = current;
 			wait.msg = (void *) msg_ptr;
+
+			/* memory barrier not required, we hold info->lock */
 			wait.state = STATE_NONE;
 			ret = wq_sleep(info, SEND, timeout, &wait);
 			/*
@@ -1147,6 +1155,8 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 			ret = -EAGAIN;
 		} else {
 			wait.task = current;
+
+			/* memory barrier not required, we hold info->lock */
 			wait.state = STATE_NONE;
 			ret = wq_sleep(info, RECV, timeout, &wait);
 			msg_ptr = wait.msg;
-- 
2.21.0

