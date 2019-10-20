Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BE321927
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="XVdy17L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfJTMdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfJTMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so10241935wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xIXlDUgby5VEEFPeCf89OBlmuCbMsbxM2rL58fQTHCc=;
        b=XVdy17L6ouQhycYatyBjU9teBQLlBYJJbwexEoMUnbrbyUVF41xIETnN7T5gjWVSlF
         MFaZk5Od84K5OaPmAOL6fj71cP9dnUzfu7TJi2RHKnXgyZKnHoecfx0qn6L5WrbQYFPw
         IfYPtPl0OXqLd4icO55onymrPmAHOy19jxNwcowiNS7waUuRu0ikLra9isWLuya74TRQ
         aPX133FuVX5dx9dfdos6GAqHikcTGGVBX/o9g1NhoZGGBUpvpnOJX+hWtudMqdGWjKZX
         OkYc/xtCedHXjOPLqO0AFLQa8KQ2D/RX/6Yuwj+f2ctjRPB25cO+b82G7OJjMgKFAZ1R
         iauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIXlDUgby5VEEFPeCf89OBlmuCbMsbxM2rL58fQTHCc=;
        b=UsU0n3qGIZfSQb/hVah32tVSzKQODiEmbrSEzle+MA+RklsD8Ey5hKg7KXQCIHBi10
         09zgUZVhohhXWu8HEEkPHDpkGMY3ymEqtbuwbqxH6pxaXf2WUNkp679j9+x5m/YTeu96
         oYIrWVZOF4emp7gJZuPv5+QHPewl9BAntywZwL8tNXFYe0sroHT5sSqHXamkdNJF6eMU
         qKabNHhGi3a77K+ymWBdSNmMEK2Q4CbYbfDBEnWHrzGxNE1xHNV2v1v7OKDt2FAyVJNu
         96BzGWwQaW5pOwFV8NK9G4UhSG8BKBK6ohBeMXZO7Emb9g++xkxv8pXQjIa06kf/4Yxj
         S62g==
X-Gm-Message-State: APjAAAVlYFWKVO2oP5rWyDUeZ4B1qLlldJ3WXe2drH5xg+HLE6bDbTm0
        GIePneNLT9PwGWtFfYx1lFWOJbXbhpQ=
X-Google-Smtp-Source: APXvYqy2yStk+yyrSVTUfloSZ6/p4miRuifCoBtzpSBzIsMPL9BkjZNvM0jrHWE/D4+0AO8oAPUcUQ==
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr3343342wrc.309.1571574802405;
        Sun, 20 Oct 2019 05:33:22 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:22 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 5/5] ipc/sem.c: Document and update memory barriers
Date:   Sun, 20 Oct 2019 14:33:05 +0200
Message-Id: <20191020123305.14715-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020123305.14715-1-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
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

- Switch to using wake_q_add_safe().

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/sem.c | 66 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index ec97a7072413..c89734b200c6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -205,15 +205,38 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  *
  * Memory ordering:
  * Most ordering is enforced by using spin_lock() and spin_unlock().
- * The special case is use_global_lock:
+ *
+ * Exceptions:
+ * 1) use_global_lock: (SEM_BARRIER_1)
  * Setting it from non-zero to 0 is a RELEASE, this is ensured by
- * using smp_store_release().
+ * using smp_store_release(): Immediately after setting it to 0,
+ * a simple op can start.
  * Testing if it is non-zero is an ACQUIRE, this is ensured by using
  * smp_load_acquire().
  * Setting it from 0 to non-zero must be ordered with regards to
  * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
  * is inside a spin_lock() and after a write from 0 to non-zero a
  * spin_lock()+spin_unlock() is done.
+ *
+ * 2) queue.status: (SEM_BARRIER_2)
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
+ * happen immediately after calling wake_q_add. As wake_q_add_safe() is called
+ * when holding sem_lock(), no further barriers are required.
+ *
+ * See also ipc/mqueue.c for more details on the covered races.
  */
 
 #define sc_semmsl	sem_ctls[0]
@@ -344,12 +367,8 @@ static void complexmode_tryleave(struct sem_array *sma)
 		return;
 	}
 	if (sma->use_global_lock == 1) {
-		/*
-		 * Immediately after setting use_global_lock to 0,
-		 * a simple op can start. Thus: all memory writes
-		 * performed by the current operation must be visible
-		 * before we set use_global_lock to 0.
-		 */
+
+		/* See SEM_BARRIER_1 for purpose/pairing */
 		smp_store_release(&sma->use_global_lock, 0);
 	} else {
 		sma->use_global_lock--;
@@ -400,7 +419,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 		 */
 		spin_lock(&sem->lock);
 
-		/* pairs with smp_store_release() */
+		/* see SEM_BARRIER_1 for purpose/pairing */
 		if (!smp_load_acquire(&sma->use_global_lock)) {
 			/* fast path successful! */
 			return sops->sem_num;
@@ -766,15 +785,12 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
 					     struct wake_q_head *wake_q)
 {
-	wake_q_add(wake_q, q->sleeper);
-	/*
-	 * Rely on the above implicit barrier, such that we can
-	 * ensure that we hold reference to the task before setting
-	 * q->status. Otherwise we could race with do_exit if the
-	 * task is awoken by an external event before calling
-	 * wake_up_process().
-	 */
-	WRITE_ONCE(q->status, error);
+	get_task_struct(q->sleeper);
+
+	/* see SEM_BARRIER_2 for purpuse/pairing */
+	smp_store_release(&q->status, error);
+
+	wake_q_add_safe(wake_q, q->sleeper);
 }
 
 static void unlink_queue(struct sem_array *sma, struct sem_queue *q)
@@ -2148,9 +2164,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	}
 
 	do {
+		/* memory ordering ensured by the lock in sem_lock() */
 		WRITE_ONCE(queue.status, -EINTR);
 		queue.sleeper = current;
 
+		/* memory ordering is ensured by the lock in sem_lock() */
 		__set_current_state(TASK_INTERRUPTIBLE);
 		sem_unlock(sma, locknum);
 		rcu_read_unlock();
@@ -2173,13 +2191,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		 */
 		error = READ_ONCE(queue.status);
 		if (error != -EINTR) {
-			/*
-			 * User space could assume that semop() is a memory
-			 * barrier: Without the mb(), the cpu could
-			 * speculatively read in userspace stale data that was
-			 * overwritten by the previous owner of the semaphore.
-			 */
-			smp_mb();
+			/* see SEM_BARRIER_2 for purpose/pairing */
+			smp_acquire__after_ctrl_dep();
 			goto out_free;
 		}
 
@@ -2189,6 +2202,9 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		if (!ipc_valid_object(&sma->sem_perm))
 			goto out_unlock_free;
 
+		/*
+		 * No necessity for any barrier: We are protect by sem_lock()
+		 */
 		error = READ_ONCE(queue.status);
 
 		/*
-- 
2.21.0

