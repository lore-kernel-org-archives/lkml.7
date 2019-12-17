Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB550C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C326207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576582046;
	bh=ct3pUphbSv9JnYkzOcRYAOFNLDfO3hVm7sO9gXG9vbc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RZbyumkKus/osRTtXSBEXGfdKUdNqO6QUhOZ3UPtFhRVRV8Yr0UFNQ8fo95BLud50
	 BGnqW4aDLMubID/H4bvjuqO6pxVTyqNQazp4W17kV4DEvw5WEzw68xMP8J4JJ8+dhm
	 4+Ee0bjHWkzMggjOGNy8zJ3BTYs0v4TgBxMrqdzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLQL1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:27:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39289 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:27:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id b72so2708373wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=297ZTOzoMHrow0iBwAdJrUteYguMngrEFjdgvGbbn08=;
        b=kvRhD2fjPjIlDRCmB8XQ2Vpi85ooFp8Y05lUqRSV6x23AY7aEU9FYFf9f9s3JO8IP2
         /4jPrbFnNgoe4fDXiqVRWqFsU/KeRVoBzGDVCJu4fkx65FDMrv2WRSdzdjBr25+NET0P
         2WFvJYEFZNb2fkrMm7E/KaD4mG8A68OqhA+OnNYwjeQjbO/unv2zEKnUJ7kNDwusB627
         wDh7VTh7+CEyDqSeZ5LaHGv0drAznkihEHuwbJ6OcvGp1yhPDHMx73C9u7uBHWnMr7gh
         PW9DzHNOe1ts7aiMGfnbQVqQKxoeLRDjsDnLdVghaDm6+kIs6b3J7meMj79CEkTG3MXe
         9y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=297ZTOzoMHrow0iBwAdJrUteYguMngrEFjdgvGbbn08=;
        b=Xsxrr+ohUswalceyCtxzNHIpM9o2ksqUuIAHbDMeOamRcseOBZ22ocM/9RLnvgMUkM
         S+lJfnQFCtl7o31+fdGNfpFucwW2b8pXw+EkZbBFIx/Vc0k64XSBK6gd+JAdG/15e6r7
         Sw9/6IrbJYnDhabBLyvc58KYI7KOPDOfqKCG57eYArnfJKVlIH9XUXaqT2pEt9THsmFJ
         VE8vATxpHLUct8U7P+rdt7MhD+/JLJZ4uvwr/jNLHWKgpFCyVgGjx42FmR2Fs5+QT9Q5
         S5H/1fyzE5uq+1ERmAS1DPg/6tm3H8mJ3oe0kvd4yXrXlxl1+rDdUaq13MiEkj5pqhS3
         UciA==
X-Gm-Message-State: APjAAAVgOunwjG7Cgl0LhT+QpVKlNvpe5XMDJBLTK4yO/kv4RoxzXQo9
        8Ed0V4lQU6AmPmwQ5ch3j60=
X-Google-Smtp-Source: APXvYqwNEfe0zH+91xuxqQp/jFWsUE2ujM05KNoZ+/Vm1DQpnOzyUfsMrsJMaegrhL6QGCkI9mWyzA==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr4746860wmj.72.1576582041759;
        Tue, 17 Dec 2019 03:27:21 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f16sm25551375wrm.65.2019.12.17.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:27:20 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:27:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20191217112719.GA123630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: c571b72e2b845ca0519670cb7c4b5fe5f56498a5 Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"

Tone down mutex debugging complaints, and annotate/fix spinlock debugging 
data accesses for KCSAN.

 Thanks,

	Ingo

------------------>
Davidlohr Bueso (1):
      Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"

Marco Elver (1):
      locking/spinlock/debug: Fix various data races


 kernel/locking/mutex.c          |  4 ----
 kernel/locking/spinlock_debug.c | 32 ++++++++++++++++----------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 54cc5f9286e9..5352ce50a97e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -733,9 +733,6 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
-	WARN_ON(in_interrupt());
-#endif
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 	if (__mutex_unlock_fast(lock))
 		return;
@@ -1416,7 +1413,6 @@ int __sched mutex_trylock(struct mutex *lock)
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-	WARN_ON(in_interrupt());
 #endif
 
 	locked = __mutex_trylock(lock);
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 399669f7eba8..472dd462a40c 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -51,19 +51,19 @@ EXPORT_SYMBOL(__rwlock_init);
 
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
-	struct task_struct *owner = NULL;
+	struct task_struct *owner = READ_ONCE(lock->owner);
 
-	if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
-		owner = lock->owner;
+	if (owner == SPINLOCK_OWNER_INIT)
+		owner = NULL;
 	printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
 		msg, raw_smp_processor_id(),
 		current->comm, task_pid_nr(current));
 	printk(KERN_EMERG " lock: %pS, .magic: %08x, .owner: %s/%d, "
 			".owner_cpu: %d\n",
-		lock, lock->magic,
+		lock, READ_ONCE(lock->magic),
 		owner ? owner->comm : "<none>",
 		owner ? task_pid_nr(owner) : -1,
-		lock->owner_cpu);
+		READ_ONCE(lock->owner_cpu));
 	dump_stack();
 }
 
@@ -80,16 +80,16 @@ static void spin_bug(raw_spinlock_t *lock, const char *msg)
 static inline void
 debug_spin_lock_before(raw_spinlock_t *lock)
 {
-	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
-	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
-	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	SPIN_BUG_ON(READ_ONCE(lock->magic) != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	SPIN_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
 static inline void debug_spin_lock_after(raw_spinlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_spin_unlock(raw_spinlock_t *lock)
@@ -99,8 +99,8 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
 	SPIN_BUG_ON(lock->owner != current, lock, "wrong owner");
 	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 /*
@@ -187,8 +187,8 @@ static inline void debug_write_lock_before(rwlock_t *lock)
 
 static inline void debug_write_lock_after(rwlock_t *lock)
 {
-	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner = current;
+	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
+	WRITE_ONCE(lock->owner, current);
 }
 
 static inline void debug_write_unlock(rwlock_t *lock)
@@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
 	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
 	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
+	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
+	WRITE_ONCE(lock->owner_cpu, -1);
 }
 
 void do_raw_write_lock(rwlock_t *lock)
