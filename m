Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A571C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2562F206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="WbxJYINV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfJLFuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52809 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJLFuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so12273089wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YVt5skJ0S8FZYsxyok5h6CoZAqlpvdtkf/3zVP+yms=;
        b=WbxJYINVGRbREW/OcfhzXgmOAk4d3yQyQratAXUdzaBm1BN3xQWsv2XPAIOjt6r6LZ
         baOgSA3taNp4FOhNq7pKEgOx2GrW9i7hGXG4nTVR7Kgi00XuxVCSmX9NEvjNJX/Tj1PA
         FT1v9OsWeHdRNpvA85K+BIiSmzBJKyxpeq9sVzfYaCHNXPB3ihcx9qSr4S8z2wiHuG2k
         S9f2jpW8QvAhsjZMOrdiu2LtCkt4P3X6ZHjNXPRi1jGVXGAlhXym2oMlp7bI69tjCn5a
         CthFJmmQRj1X+Ey2Xj3KOCBecxxPNDPYbxz+92VKUEChmfr7ktuZ1FyUrIoULIXgotOp
         soJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YVt5skJ0S8FZYsxyok5h6CoZAqlpvdtkf/3zVP+yms=;
        b=J7L9fkbEUgg4FNIgynL3L9SoAgY6ymlTCgYsCB3gCV5/euX1So+8SQr+1VRHh5KdUx
         Mrt5f5xcXJwNUAh3p1YRZDZoAUBNJgjQqo4WawzhCDz0Ydq+PBz0t+qLqGCbco2N1721
         AuHLjMmaqalJaAxZWhixYy4VaQel1Q48u1OKkzJxVQajmNySaiLVAikGG+IAD0eLkXqi
         4qc0rv0A0dHYqfiontuFheyDPtWBWSp95OPzb5SSluHdDqPWwGFpDyZiOJKQ7V/pRjMz
         ysmeFuSD7PrzixlVxx/DRDj3hPf7MRKnl6+H09Joj49+4hS5IrmbNKUq1t2A40xelKc6
         ILcg==
X-Gm-Message-State: APjAAAUJ6bhlJbB+d/lyAD4aiRm8/7eK00iaLHI/XNFH5jdwMPagxn0m
        2Dob1Rhx1Ncvzn0raMIQjIhOTurxShrxwA==
X-Google-Smtp-Source: APXvYqw5I5tia15ZAYdzuC16pko0QpYJG90rjju9qldCLQg6ldkaa/YJNiXdxvu7GRVCOjUcNvam4Q==
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr5510517wme.148.1570859413451;
        Fri, 11 Oct 2019 22:50:13 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:13 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 5/6] ipc/sem.c: Document and update memory barriers
Date:   Sat, 12 Oct 2019 07:49:57 +0200
Message-Id: <20191012054958.3624-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch documents and updates the memory barriers in ipc/sem.c:
- Add smp_store_release() to wake_up_sem_queue_prepare() and
  document why it is needed.

- Read q->status using READ_ONCE+smp_acquire__after_ctrl_dep().
  as the pair for the barrier inside wake_up_sem_queue_prepare().

- Add comments to all barriers, and mention the rules in the block
  regarding locking.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/sem.c | 63 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index ec97a7072413..c6c5954a2030 100644
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
+ * Setting it to a result code is a RELEASE, this is ensured by both a
+ * smp_store_release() (for case a) and while holding sem_lock()
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
@@ -766,15 +786,24 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
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
+	 * Here, we need a barrier to protect the refcount increase inside
+	 * wake_q_add().
+	 * case a: The barrier inside wake_q_add() pairs with
+	 *         READ_ONCE(q->status) + smp_acquire__after_ctrl_dep() in
+	 *         do_semtimedop().
+	 * case b: nothing, ordering is enforced by the locks in sem_lock().
 	 */
-	WRITE_ONCE(q->status, error);
+	smp_store_release(&q->status, error);
 }
 
 static void unlink_queue(struct sem_array *sma, struct sem_queue *q)
@@ -2148,9 +2177,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	}
 
 	do {
+		/* memory ordering ensured by the lock in sem_lock() */
 		WRITE_ONCE(queue.status, -EINTR);
 		queue.sleeper = current;
 
+		/* memory ordering is ensured by the lock in sem_lock() */
 		__set_current_state(TASK_INTERRUPTIBLE);
 		sem_unlock(sma, locknum);
 		rcu_read_unlock();
@@ -2174,12 +2205,16 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
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
+			 * wake_up_sem_queue_prepare().
+			 * The barrier protects user space, too: User space may
+			 * assume that all data from the CPU that did the wakeup
+			 * semop() is visible on the wakee CPU when the sleeping
+			 * semop() returns.
 			 */
-			smp_mb();
+			smp_acquire__after_ctrl_dep();
 			goto out_free;
 		}
 
@@ -2189,6 +2224,10 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		if (!ipc_valid_object(&sma->sem_perm))
 			goto out_unlock_free;
 
+		/*
+		 * No necessity for any barrier:
+		 * We are protect by sem_lock() (case b)
+		 */
 		error = READ_ONCE(queue.status);
 
 		/*
-- 
2.21.0

