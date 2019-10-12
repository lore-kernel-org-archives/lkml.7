Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0453C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F26206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="oMX4Wwdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfJLFuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35415 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJLFuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so11981672wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tXLMVGJIE9Jxpvve7tewtR9gLv8cIbCDc7DcOjctPc=;
        b=oMX4WwduOz92KCEBHmqOWtpgO3X4JBYymVpV4vRqs7vNufbPgMzT/TEmli4itA1C/D
         LTqu+DhZz4MdULs4r/xO7GiVThRI5nBrKKgYr3LpBOhhewat01JjoMLLyqK0aqSCW3b0
         MmpT3WnJK2cavWHPyaek+HDIO2f5tXB1kkNyAzGa/pJ1DZ4gzE0TznQHRoZh+0XFvNBo
         S5qfe+O772s2/WreGQFFkuuu+6ohW3rPqmIdPYc4+veZXyB/QI1BeEQrAIspq4Uc41EB
         pBiWsCk8nVeaa7H/xHsD8GcUyXopW+YBkiqXjP9IuGgxs9AG2JIZSCGglWi1j/4FOji+
         hq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tXLMVGJIE9Jxpvve7tewtR9gLv8cIbCDc7DcOjctPc=;
        b=SCMC7I57KKB5TamtH+lhMfAjKQlQ0drXhXbYedG8X3dA+dn91oN7E0UZwQewg+AjQX
         CnZY+hXTQhFG0prD2zcIDZi0+hY5OJNEoz9JFhOc8DxhI63yaTPOs7zvhMz9g3Xceb6F
         jYY8fkrHJWM4fK2d6FSBIV12Lhz3k2VUqyYDXbQmWPWvGvQ7cUdVHYpiMbgtmfsHJHse
         f72Wo3lhxKYNfHFcTxhgmy0UPjgIxgvlgVWTh4m6pQ4T9bgHcPNehd7grLVtnIGM4Y4w
         Lmn27X98u29liTeyfp4j/wLRmYsnRVQGHpb2awXIjEJ8TSvmFI1p7F/bIVFUeIXsXRFw
         tnEw==
X-Gm-Message-State: APjAAAWdUca1dj3HB2DOPL4aRKlHCqTKf6qBTQCB/SQgljhHk8RRj7m0
        Oro7AItYrLjyOfXYTzY0OkJ2J/mSCxXY4Q==
X-Google-Smtp-Source: APXvYqyv1o4T8TS7SGKfR+ZCLcVIoi8jFtdmBcH0HzYGH/ecWuqDyfrBvA2GHO6UchmcTHu+qggdEw==
X-Received: by 2002:a05:600c:24c9:: with SMTP id 9mr6318292wmu.174.1570859412505;
        Fri, 11 Oct 2019 22:50:12 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:12 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 4/6] ipc/msg.c: Update and document memory barriers.
Date:   Sat, 12 Oct 2019 07:49:56 +0200
Message-Id: <20191012054958.3624-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
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
 ipc/msg.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 8dec945fa030..e6b20a7e6341 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -184,6 +184,10 @@ static inline void ss_add(struct msg_queue *msq,
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
@@ -238,7 +242,14 @@ static void expunge_all(struct msg_queue *msq, int res,
 
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
 		wake_q_add(wake_q, msr->r_tsk);
-		WRITE_ONCE(msr->r_msg, ERR_PTR(res));
+
+		/*
+		 * The barrier is required to ensure that the refcount increase
+		 * inside wake_q_add() is completed before the state is updated.
+		 *
+		 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
+		 */
+		smp_store_release(&msr->r_msg, ERR_PTR(res));
 	}
 }
 
@@ -798,13 +809,17 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
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
@@ -1154,7 +1169,11 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
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
@@ -1183,8 +1202,21 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		 * signal) it will either see the message and continue ...
 		 */
 		msg = READ_ONCE(msr_d.r_msg);
-		if (msg != ERR_PTR(-EAGAIN))
+		if (msg != ERR_PTR(-EAGAIN)) {
+			/*
+			 * Memory barrier for msr_d.r_msg
+			 * The smp_acquire__after_ctrl_dep(), together with the
+			 * READ_ONCE() above pairs with the barrier inside
+			 * wake_q_add().
+			 * The barrier protects the accesses to the message in
+			 * do_msg_fill(). In addition, the barrier protects user
+			 * space, too: User space may assume that all data from
+			 * the CPU that sent the message is visible.
+			 */
+			smp_acquire__after_ctrl_dep();
+
 			goto out_unlock1;
+		}
 
 		 /*
 		  * ... or see -EAGAIN, acquire the lock to check the message
@@ -1192,7 +1224,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		  */
 		ipc_lock_object(&msq->q_perm);
 
-		msg = msr_d.r_msg;
+		msg = READ_ONCE(msr_d.r_msg);
 		if (msg != ERR_PTR(-EAGAIN))
 			goto out_unlock0;
 
-- 
2.21.0

