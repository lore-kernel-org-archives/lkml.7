Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D01ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28CA214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="HR5oZ///"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfJKLUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38748 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfJKLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so9833390wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEY4RZT1gkVHkI+OU6VQ6tYQhqgYBNr/ROEgKk7yUHc=;
        b=HR5oZ///V6iSUo3Od8gzt/JN1n41J4SgvRxG8oszEfGQkgUXfLwMHgwp9Swjuzh3ZR
         3qE8fLy5edk8tXriaWqywsUKG5inGOrlXSxct9Pvioc4aCGOSOmnmr4MwIQNPSskLjeg
         K/xYArWeNGuStwfwlsnM8WcC69dkD964WaCCAxOIgO495h9JAAF7i4n/dPYEfstOUTas
         JWIw1lGVNJRhZn0e6Pp2YZQcCokC6D9ngNprl6xTdNuV6zCWKVExJlsrGTi0TttGbNGe
         X6Qk891vAZEIr/ISSpLDUJ0nP5BPmVEPlHwymEkfITNhwXpwJlswIbvYK0KtnJZCC/Bb
         BT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEY4RZT1gkVHkI+OU6VQ6tYQhqgYBNr/ROEgKk7yUHc=;
        b=QW2m5Njsd44CJfm9m2z/eMORy2ajmrGT7kx7w1OKivasKKDVqCbXI16sYcLYrmA0xa
         zcDCQBx4Ra6A9xIbXrICb3X80HHM4aIxt9TyHpDAZ49X/PAfreWoWb0JK4ABcQpX5I3M
         Isa0usU6fjzjiMzPlKA3od5Eum+6PRjufDlCs9U5RQAqBFqEJ6SJfQ/jGyWGviOas0ZG
         c1+xu8LteeuvJIiyaLHTqJJKsKRH7DEGcpnh/0Y+9kzrJFV0z0C8V8wK3yZvGDENqBcd
         uRIVm+BqQuACq9B78mTAf9MVHlkDeeE/sbSJ8wf7CYa2jh559k2Azjn0Or8brKLdB4+O
         Fc2Q==
X-Gm-Message-State: APjAAAUmV/xlfA+Du61oApt62TMPFzSRAxJc4T+Nlxd1ZtW3D2JgJ4nY
        eHFOZ+8fOfAk+ju1hdFu/AdP9JBKoWI=
X-Google-Smtp-Source: APXvYqz7PCTmHOQ5gIkOjzwBHbfbWKgvhyXLPQ5K9ZmujWRXin0IM3zFzbJYnMNDQQbhzyYbo32Zfw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr2780352wmc.108.1570792820093;
        Fri, 11 Oct 2019 04:20:20 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:19 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 4/5] ipc/sem.c: Document and update memory barriers
Date:   Fri, 11 Oct 2019 13:20:08 +0200
Message-Id: <20191011112009.2365-5-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011112009.2365-1-manfred@colorfullife.com>
References: <20191011112009.2365-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch documents and updates the memory barriers in ipc/sem.c:
- Document that the WRITE_ONCE for q->status relies on a barrier
  inside wake_q_add().

- Read q->status using READ_ONCE+smp_acquire__after_ctrl_dep().
  as the pair for the barrier inside wake_q_add()

- Remove READ_ONCE & WRITE_ONCE for the situations where spinlocks
  provide exclusion.

- Add comments to all barriers, and mention the rules in the block
  regarding locking.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/sem.c | 64 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index ec97a7072413..53d970c4e60d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -205,7 +205,9 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  *
  * Memory ordering:
  * Most ordering is enforced by using spin_lock() and spin_unlock().
- * The special case is use_global_lock:
+ *
+ * Exceptions:
+ * 1) use_global_lock:
  * Setting it from non-zero to 0 is a RELEASE, this is ensured by
  * using smp_store_release().
  * Testing if it is non-zero is an ACQUIRE, this is ensured by using
@@ -214,6 +216,24 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
  * is inside a spin_lock() and after a write from 0 to non-zero a
  * spin_lock()+spin_unlock() is done.
+ *
+ * 2) queue.status:
+ * Initialization is done while holding sem_lock(), so no further barrier is
+ * required.
+ * Setting it to a result code is a RELEASE, this is ensured by both the
+ * barrier inside wake_q_add() (for case a) and while holding sem_lock()
+ * (for case b).
+ * The AQUIRE when reading the result code without holding sem_lock() is
+ * achieved by using READ_ONCE() + smp_acquire__after_ctrl_dep().
+ * (case a above).
+ * Reading the result code while holding sem_lock() needs no further barriers,
+ * the locks inside sem_lock() enforce ordering (case b above)
+ *
+ * 3) current->state:
+ * current->state is set to TASK_INTERRUPTIBLE while holding sem_lock().
+ * The wakeup is handled using the wake_q infrastructure. wake_q wakeups may
+ * happen immediately after calling wake_q_add. As wake_q_add() is called
+ * when holding sem_lock(), no further barriers are required.
  */
 
 #define sc_semmsl	sem_ctls[0]
@@ -766,13 +786,21 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
 					     struct wake_q_head *wake_q)
 {
+	/*
+	 * When the wakeup is performed, q->sleeper->state is read and later
+	 * set to TASK_RUNNING. This may happen at any time, even before
+	 * wake_q_add() returns. Memory ordering for q->sleeper->state is
+	 * enforced by sem_lock(): we own sem_lock now (that was the ACQUIRE),
+	 * and q->sleeper wrote q->sleeper->state before calling sem_unlock()
+	 * (->RELEASE).
+	 */
 	wake_q_add(wake_q, q->sleeper);
 	/*
-	 * Rely on the above implicit barrier, such that we can
-	 * ensure that we hold reference to the task before setting
-	 * q->status. Otherwise we could race with do_exit if the
-	 * task is awoken by an external event before calling
-	 * wake_up_process().
+	 * Memory barrier pairing:
+	 * case a: The barrier inside wake_q_add() pairs with
+	 *         READ_ONCE(q->status) + smp_acquire__after_ctrl_dep() in
+	 *         do_semtimedop().
+	 * case b: nothing, ordering is enforced by the locks in sem_lock().
 	 */
 	WRITE_ONCE(q->status, error);
 }
@@ -2148,9 +2176,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	}
 
 	do {
-		WRITE_ONCE(queue.status, -EINTR);
+		/* memory ordering ensured by the lock in sem_lock() */
+		queue.status = EINTR;
 		queue.sleeper = current;
 
+		/* memory ordering is ensured by the lock in sem_lock() */
 		__set_current_state(TASK_INTERRUPTIBLE);
 		sem_unlock(sma, locknum);
 		rcu_read_unlock();
@@ -2174,12 +2204,16 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		error = READ_ONCE(queue.status);
 		if (error != -EINTR) {
 			/*
-			 * User space could assume that semop() is a memory
-			 * barrier: Without the mb(), the cpu could
-			 * speculatively read in userspace stale data that was
-			 * overwritten by the previous owner of the semaphore.
+			 * Memory barrier for queue.status, case a):
+			 * The smp_acquire__after_ctrl_dep(), together with the
+			 * READ_ONCE() above pairs with the barrier inside
+			 * wake_q_add().
+			 * The barrier protects user space, too: User space may
+			 * assume that all data from the CPU that did the wakeup
+			 * semop() is visible on the wakee CPU when the sleeping
+			 * semop() returns.
 			 */
-			smp_mb();
+			smp_acquire__after_ctrl_dep();
 			goto out_free;
 		}
 
@@ -2189,7 +2223,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		if (!ipc_valid_object(&sma->sem_perm))
 			goto out_unlock_free;
 
-		error = READ_ONCE(queue.status);
+		/*
+		 * No necessity for any barrier:
+		 * We are protect by sem_lock() (case b)
+		 */
+		error = queue.status;
 
 		/*
 		 * If queue.status != -EINTR we are woken up by another process.
-- 
2.21.0

