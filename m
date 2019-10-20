Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5094CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAC2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="pBhqrqh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfJTMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfJTMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so5555906wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeqO4mL3zLL4eK3EX0t/1HNknFqm+3mfxJWPOzungG8=;
        b=pBhqrqh9w3tFhKh9diR4zGWp9TKXzIGC5V/XBMMJo3RmNIeyc0ZyXj45wY9ySzf+2o
         iT7WFPPjkzPJ1HvhffiDpEpWyOCqS8vYXVDXdYll8zvIRuLk2G5gGoUtxAGaFPNABqNj
         p29PWrbvglxwy4XFGnVH9TYdEqLPRumpvm6GwHsYDYAyiq0rUWOn2y7oJ6UFM7gwdgvZ
         2iSUzmCAYNl82hESa2WQ/XqafXdR/91o85Mbm1ZeBoGHlfLFv+XSdzZVKeSbj4J0qH7s
         3/BiRvxg5TL9Wf5pys+YsqnxzNW7jIyxKYAmJo6hWfYzFLtjh0my6js/kxzmvmzNXR6i
         n87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeqO4mL3zLL4eK3EX0t/1HNknFqm+3mfxJWPOzungG8=;
        b=qg+F/+IG5941+XEoHZgsJU92PH/13HWE70jauio7tEWueohL/ibVclRoL+3o5Mrm0R
         sQDXlVf+MS5na3uGAgo3Uoo+RPX22CIn6IxLKtuRS8WJnGpNJd4+wkNSJhSpqmkNTASw
         vB2frugol5/flYshRNT5x0PwtJxT7pQzPJfOaxFlfk12nngEr67rVCN0yfE50KsjSfNU
         Dl+DKuxeIMwoMzduEwgN+SNgvoSHl6sNCKFppdPgdtqyaiwi/o6hTpA9CdDPVpH1VWUE
         1xvfO0Wby7cXYljMACgdlks7l/7Hlivr2ZUmWgZxHtpELCo0dR7L9Q7lHI02hLAT7O3L
         agpw==
X-Gm-Message-State: APjAAAWjeJkG+90Jgyk409sTldcqYKJDkVvcAgyJiXvuDiudQaRRgwfJ
        p1mEUMZcfUZU4x9tM1NjbbQWeJELnQQ=
X-Google-Smtp-Source: APXvYqws+frhrkJhvfQXwSGnnTeJykR1R6G6Eoeji68pSehNH1ZXurSl+XaJm4S6WuKPTCWGPtDPTw==
X-Received: by 2002:adf:a506:: with SMTP id i6mr15153973wrb.159.1571574801633;
        Sun, 20 Oct 2019 05:33:21 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:21 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 4/5] ipc/msg.c: Update and document memory barriers.
Date:   Sun, 20 Oct 2019 14:33:04 +0200
Message-Id: <20191020123305.14715-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020123305.14715-1-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transfer findings from ipc/mqueue.c:
- A control barrier was missing for the lockless receive case
  So in theory, not yet initialized data may have been copied
  to user space - obviously only for architectures where
  control barriers are not NOP.

- use smp_store_release(). In theory, the refount
  may have been decreased to 0 already when wake_q_add()
  tries to get a reference.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/msg.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 8dec945fa030..192a9291a8ab 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -61,6 +61,16 @@ struct msg_queue {
 	struct list_head q_senders;
 } __randomize_layout;
 
+/*
+ * MSG_BARRIER Locking:
+ *
+ * Similar to the optimization used in ipc/mqueue.c, one syscall return path
+ * does not acquire any locks when it sees that a message exists in
+ * msg_receiver.r_msg. Therefore r_msg is set using smp_store_release()
+ * and accessed using READ_ONCE()+smp_acquire__after_ctrl_dep(). In addition,
+ * wake_q_add_safe() is used. See ipc/mqueue.c for more details
+ */
+
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
 	struct list_head	r_list;
@@ -184,6 +194,10 @@ static inline void ss_add(struct msg_queue *msq,
 {
 	mss->tsk = current;
 	mss->msgsz = msgsz;
+	/*
+	 * No memory barrier required: we did ipc_lock_object(),
+	 * and the waker obtains that lock before calling wake_q_add().
+	 */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	list_add_tail(&mss->list, &msq->q_senders);
 }
@@ -237,8 +251,11 @@ static void expunge_all(struct msg_queue *msq, int res,
 	struct msg_receiver *msr, *t;
 
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
-		wake_q_add(wake_q, msr->r_tsk);
-		WRITE_ONCE(msr->r_msg, ERR_PTR(res));
+		get_task_struct(msr->r_tsk);
+
+		/* see MSG_BARRIER for purpose/pairing */
+		smp_store_release(&msr->r_msg, ERR_PTR(res));
+		wake_q_add_safe(wake_q, msr->r_tsk);
 	}
 }
 
@@ -798,13 +815,17 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 			list_del(&msr->r_list);
 			if (msr->r_maxsize < msg->m_ts) {
 				wake_q_add(wake_q, msr->r_tsk);
-				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
+
+				/* See expunge_all regarding memory barrier */
+				smp_store_release(&msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
 				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
-				WRITE_ONCE(msr->r_msg, msg);
+
+				/* See expunge_all regarding memory barrier */
+				smp_store_release(&msr->r_msg, msg);
 				return 1;
 			}
 		}
@@ -1154,7 +1175,11 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 			msr_d.r_maxsize = INT_MAX;
 		else
 			msr_d.r_maxsize = bufsz;
-		msr_d.r_msg = ERR_PTR(-EAGAIN);
+
+		/* memory barrier not require due to ipc_lock_object() */
+		WRITE_ONCE(msr_d.r_msg, ERR_PTR(-EAGAIN));
+
+		/* memory barrier not required, we own ipc_lock_object() */
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		ipc_unlock_object(&msq->q_perm);
@@ -1183,8 +1208,12 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		 * signal) it will either see the message and continue ...
 		 */
 		msg = READ_ONCE(msr_d.r_msg);
-		if (msg != ERR_PTR(-EAGAIN))
+		if (msg != ERR_PTR(-EAGAIN)) {
+			/* see MSG_BARRIER for purpose/pairing */
+			smp_acquire__after_ctrl_dep();
+
 			goto out_unlock1;
+		}
 
 		 /*
 		  * ... or see -EAGAIN, acquire the lock to check the message
@@ -1192,7 +1221,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		  */
 		ipc_lock_object(&msq->q_perm);
 
-		msg = msr_d.r_msg;
+		msg = READ_ONCE(msr_d.r_msg);
 		if (msg != ERR_PTR(-EAGAIN))
 			goto out_unlock0;
 
-- 
2.21.0

