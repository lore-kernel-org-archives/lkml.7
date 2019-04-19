Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45613C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46E8204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701275;
	bh=82oCbWyqzL3KRu6Wfg15eC53qNduO9IYqQpYycJR+zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2fIjb8gg+U6fwzeylvxyOo5mb/aOjcLeyx+bghgnFYgT/+vuyUrbvEnKiEl/GZ8p8
	 evD8sihCGiCZ8jsG50y5GCXyJv+qurWLip80DHBtkkK9gdmKry8kAciNwWVz2nSn5n
	 G2bsok+OHLcB2Mw4ZmC8n/Eu7ALLc6aWFvdx6UBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfDSTOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfDSTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so4650627wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EwPXQCKia7c9T7PRZKsifvlOrlZrG+R0jF+OBx3zxVg=;
        b=Zk6ko3DWtCgZtMdWQ+5sRwLmnfzXVF/Ze7iRICrLPvs/ZiUtEUH9JoyCzkaO7DPXXH
         7p5KIXn0hmdDvE+NFO1KfetVDW/myhAY8UqGvhkfnUPQcqCzPu/j/sJijBbxdpHX5VcO
         YCg/CbT63Yn5OpdotvpftCTWx1pKC1KjlZ4V8+FTU3lwgAIqXRgEs9Rgk0gC1TGDyflb
         nzIGJU9KcQ5PxLseEJjnR8eD+CrYmBhJsYW34qe2BPCvGVSsrH1n0SAOqIRFpHlLbIMc
         odALGGByPxx2jZuwjjj/LqjdHUQVi7YXA5E0qvSpxSSRuikse2Bv5j1M/mGVLwF2eECw
         ZIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwPXQCKia7c9T7PRZKsifvlOrlZrG+R0jF+OBx3zxVg=;
        b=Hw/j8HpNtBJfLl8tQepw/rIG9EnTvQlN6Rbz7cRlghBte3MLfFpfsYzmNRbbDcJpn5
         ekyCYVeYMey71zRcGFx0agW595RH/KnW2iLRJc9pv9n2BDnlblwasCEBg8QcQD6ur6EV
         EoftYgQhwnnob8xY/gtzQbwW2DbNfecRfSfQ8q3iS5t1q0QH2cmiJXvPJ5/ud8ONFAJF
         ONoKXUHUCELPG/n9Wmv2//Au8Fu0LbmxFlk7zal34X0p65ZJOCXeEVOSAStnS3SiNhaL
         DNcmzpfjSz3nqJID4sXgmK0Cbhm684v+nks7MkP1/OUtqQ0jNdt3BPqk6+BifujSKn7+
         hSbw==
X-Gm-Message-State: APjAAAUcf9MsoeDBw17QDatHw3MOyJRbZCLGowmULA51EZHZDJeu5VhW
        r2HgT4fJQtMKiB/9hTykFF3jASWe
X-Google-Smtp-Source: APXvYqyHlJK278jq4JQRZu3sCDQ2HCTWunUjWIGQFwfb8dvKNaEqyEJlRH28BkcC7yw7AW5pRfRomA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr1824644wrx.80.1555660259973;
        Fri, 19 Apr 2019 00:50:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h2sm7667357wro.11.2019.04.19.00.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:50:58 -0700 (PDT)
Date:   Fri, 19 Apr 2019 09:50:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v5 00/18] locking/rwsem: Rwsem rearchitecture part 2
Message-ID: <20190419075055.GA6795@gmail.com>
References: <20190418234628.3675-1-longman@redhat.com>
 <8f1adff7-3bd4-7d35-1a0d-698662bfa2b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1adff7-3bd4-7d35-1a0d-698662bfa2b8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 04/18/2019 07:46 PM, Waiman Long wrote:
> >  v5:
> >   - Drop v4 patch 1 as it is merged into tip's locking/core branch.
> >   - Integrate the 2 followup patches into the series. The first
> >     follow-up patch is broken into 2 pieces. The first piece comes in
> >     before the "Enable readers spinning on writer" and the 2nd piece
> >     is merged into the "Enable time-based spinning on reader-owned
> >     rwsem" patch. The 2nd followup patch is added after that.
> >   - Add a new patch to make all wake_up_q() calls after dropping
> >     wait_lock as suggested by PeterZ.
> >   - Incorporate numerouos suggestions by PeterZ and Davidlohr.
> 
> This patchset is still being reviewed by Peter . The purpose of this
> series is mainly to sync up the version that Peter has and the ones that
> I am working on incorporating his feedback. Further changes may still be
> needed.
> 
> I run an overall performance test on this new patchset and present the
> data in this cover letter. However, I haven't run performance tests for
> individual patches. So the performance data listed in some of the
> patches may be stale.

Just for those who'd like to follow the scope of changes, find below the 
v4->v5 interdiff. v5 is now included in tip:WIP.locking/core, and also 
merged into tip:master. (But not propagated towards linux-next yet.)

Thanks,

	Ingo

==============>
 arch/x86/Kconfig                  |   6 +
 include/linux/sched/wake_q.h      |   5 +
 kernel/Kconfig.locks              |  12 +
 kernel/locking/lock_events_list.h |   2 -
 kernel/locking/rwsem.c            | 538 +++++++++++++++++++-------------------
 5 files changed, 291 insertions(+), 272 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7d160f58a8f6..82a8c02f1b44 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -80,6 +80,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_RWSEM_OWNER_COUNT	if X86_64
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_THP_SWAP		if X86_64
@@ -350,6 +351,11 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config RWSEM_OWNER_COUNT_PA_BITS
+	int
+	default 52 if X86_5LEVEL
+	default 46 if X86_64
+
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index ad826d2a4557..26a2013ac39c 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,6 +51,11 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
+static inline bool wake_q_empty(struct wake_q_head *head)
+{
+	return head->first == WAKE_Q_TAIL;
+}
+
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index e335953fa704..3370ea21407b 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,3 +251,15 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+#
+# An architecture that want to merge rwsem write-owner into count should
+# select ARCH_USE_RWSEM_OWNER_COUNT and define RWSEM_OWNER_COUNT_PA_BITS
+# as the correct number of physical address bits.
+#
+config ARCH_USE_RWSEM_OWNER_COUNT
+	bool
+
+config RWSEM_OWNER_COUNT
+	def_bool y if ARCH_USE_RWSEM_OWNER_COUNT
+	depends on SMP && 64BIT
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index b0eeb77070dd..661326885800 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -65,8 +65,6 @@ LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
 LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
-LOCK_EVENT(rwsem_rtrylock)	/* # of read trylock calls		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
-LOCK_EVENT(rwsem_wtrylock)	/* # of write trylock calls		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index d50bc7b0315f..19d8fbd50d17 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -10,8 +10,9 @@
  * Optimistic spinning by Tim Chen <tim.c.chen@intel.com>
  * and Davidlohr Bueso <davidlohr@hp.com>. Based on mutexes.
  *
- * Rwsem count bit fields re-definition and rwsem rearchitecture
- * by Waiman Long <longman@redhat.com>.
+ * Rwsem count bit fields re-definition and rwsem rearchitecture by
+ * Waiman Long <longman@redhat.com> and
+ * Peter Zijlstra <peterz@infradead.org>.
  */
 
 #include <linux/types.h>
@@ -44,10 +45,9 @@
  * writer nonspinnable bit and clear it only to give writers preference
  * to acquire the lock via optimistic spinning, but not readers. Similar
  * action is also done in the reader slowpath.
- *
+
  * When a writer acquires a rwsem, it puts its task_struct pointer
- * into the owner field or the count itself (64-bit only. It should
- * be cleared after an unlock.
+ * into the owner field. It is cleared after an unlock.
  *
  * When a reader acquires a rwsem, it will also puts its task_struct
  * pointer into the owner field with the RWSEM_READER_OWNED bit set.
@@ -107,13 +107,6 @@
 # define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
-/*
- * Enable the merging of owner into count for x86-64 only.
- */
-#ifdef CONFIG_X86_64
-#define RWSEM_MERGE_OWNER_TO_COUNT
-#endif
-
 /*
  * With separate count and owner, there are timing windows where the two
  * values are inconsistent. That can cause problem when trying to figure
@@ -127,14 +120,17 @@
  * architectures, the long integer value just isn't big enough for
  * combining owner and count. So they remain separate.
  *
- * For x86-64, the physical address can use up to 52 bits. That is 4PB
- * of memory. That leaves 12 bits available for other use. The task
- * structure pointer is also aligned to the L1 cache size. That means
- * another 6 bits (64 bytes cacheline) will be available. Reserving
- * 2 bits for status flags, we will have 16 bits for the reader count
- * and read fail bit. That can supports up to (32k-1) active readers.
+ * For x86-64, the physical address can use up to 52 bits if
+ * CONFIG_X86_5LEVEL. That is 4PB of memory. That leaves 12 bits
+ * available for other use. The task structure pointer is also aligned
+ * to the L1 cache size. That means another 6 bits (64 bytes cacheline)
+ * will be available. Reserving 2 bits for status flags, we will have
+ * 16 bits for the reader count and read fail bit. That can supports up
+ * to (32k-1) active readers. If 5-level page table support isn't
+ * configured, we can supports up to (2M-1) active readers.
  *
- * On x86-64, the bit definitions of the count are:
+ * On x86-64 with CONFIG_X86_5LEVEL and CONFIG_RWSEM_OWNER_COUNT, the bit
+ * definitions of the count are:
  *
  * Bit   0    - waiters present bit
  * Bit   1    - lock handoff bit
@@ -142,7 +138,8 @@
  * Bits 48-62 - 15-bit reader counts
  * Bit  63    - read fail bit
  *
- * On other 64-bit architectures, the bit definitions are:
+ * On other 64-bit architectures without CONFIG_RWSEM_OWNER_COUNT, the bit
+ * definitions are:
  *
  * Bit  0    - writer locked bit
  * Bit  1    - waiters present bit
@@ -181,23 +178,16 @@
 #define RWSEM_FLAG_HANDOFF	(1UL << 1)
 #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
-
-#ifdef RWSEM_MERGE_OWNER_TO_COUNT
-
-#ifdef __PHYSICAL_MASK_SHIFT
-#define RWSEM_PA_MASK_SHIFT	__PHYSICAL_MASK_SHIFT
-#else
-#define RWSEM_PA_MASK_SHIFT	52
-#endif
-#define RWSEM_READER_SHIFT	(RWSEM_PA_MASK_SHIFT - L1_CACHE_SHIFT + 2)
+#ifdef CONFIG_RWSEM_OWNER_COUNT
+#define RWSEM_READER_SHIFT	(CONFIG_RWSEM_OWNER_COUNT_PA_BITS -\
+				 L1_CACHE_SHIFT + 2)
 #define RWSEM_WRITER_MASK	((1UL << RWSEM_READER_SHIFT) - 4)
 #define RWSEM_WRITER_LOCKED	rwsem_owner_count(current)
-
-#else /* RWSEM_MERGE_OWNER_TO_COUNT */
+#else /* !CONFIG_RWSEM_OWNER_COUNT */
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_WRITER_MASK	(1UL << 7)
 #define RWSEM_WRITER_LOCKED	RWSEM_WRITER_MASK
-#endif /* RWSEM_MERGE_OWNER_TO_COUNT */
+#endif /* CONFIG_RWSEM_OWNER_COUNT */
 
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
 #define RWSEM_READER_MASK	(~(RWSEM_READER_BIAS - 1))
@@ -205,14 +195,6 @@
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
 				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
-#define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
-#define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
-#define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
-#define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
-	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
-#define RWSEM_COUNT_WLOCKED_OR_HANDOFF(c)	\
-	((c) & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
-
 /*
  * Task structure pointer compression (64-bit only):
  * (owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2)
@@ -251,10 +233,10 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
-#ifdef RWSEM_MERGE_OWNER_TO_COUNT
+#ifdef CONFIG_RWSEM_OWNER_COUNT
 /*
  * Get the owner value from count to have early access to the task structure.
- * Owner from sem->count should includes the RWSEM_NONSPINNABLE bit
+ * Owner from sem->count should includes the RWSEM_NONSPINNABLE bits
  * from sem->owner.
  */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
@@ -265,16 +247,12 @@ static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 	return (struct task_struct *) (cowner
 		? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
 }
-#else /* !RWSEM_MERGE_OWNER_TO_COUNT */
+#else /* !CONFIG_RWSEM_OWNER_COUNT */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 {
-	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
-
-	/* Clear all the flag bits for writer */
-	return (struct task_struct *)((owner & RWSEM_READER_OWNED)
-		? owner : (owner & ~RWSEM_OWNER_FLAGS_MASK));
+	return READ_ONCE(sem->owner);
 }
-#endif /* RWSEM_MERGE_OWNER_TO_COUNT */
+#endif /* CONFIG_RWSEM_OWNER_COUNT */
 
 /*
  * The task_struct pointer of the last owning reader will be left in
@@ -302,18 +280,13 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
  * and steal the lock.
  * N.B. !owner is considered spinnable.
  */
-static inline bool is_rwsem_owner_spinnable(void *owner, bool wr)
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner, bool wr)
 {
 	unsigned long bit = wr ? RWSEM_WR_NONSPINNABLE : RWSEM_RD_NONSPINNABLE;
 
 	return !((unsigned long)owner & bit);
 }
 
-static inline bool is_rwsem_owner_reader(void *owner)
-{
-	return (unsigned long)owner & RWSEM_READER_OWNED;
-}
-
 /*
  * Return true if the rwsem is spinnable.
  */
@@ -368,8 +341,8 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 {
 	long owner = (long)READ_ONCE(sem->owner);
 
-	while (is_rwsem_owner_reader((struct task_struct *)owner)) {
-		if (!is_rwsem_owner_spinnable((void *)owner, true))
+	while (owner & RWSEM_READER_OWNED) {
+		if (!is_rwsem_owner_spinnable((void *)owner, false))
 			break;
 		owner = cmpxchg((long *)&sem->owner, owner,
 				owner | RWSEM_NONSPINNABLE);
@@ -400,9 +373,9 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
 	/*
-	 * We should support at least (4k-1) concurrent readers
+	 * We should support at least (8k-1) concurrent readers
 	 */
-	BUILD_BUG_ON(sizeof(long) * 8 - RWSEM_READER_SHIFT < 12);
+	BUILD_BUG_ON(sizeof(long) * 8 - RWSEM_READER_SHIFT < 14);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -432,6 +405,8 @@ struct rwsem_waiter {
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
 };
+#define rwsem_first_waiter(sem) \
+	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
 
 enum rwsem_wake_type {
 	RWSEM_WAKE_ANY,		/* Wake whatever's at head of wait list */
@@ -447,15 +422,16 @@ enum writer_wait_state {
 
 /*
  * The typical HZ value is either 250 or 1000. So set the minimum waiting
- * time to 4ms in the wait queue before initiating the handoff protocol.
+ * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
+ * queue before initiating the handoff protocol.
  */
-#define RWSEM_WAIT_TIMEOUT	(HZ/250)
+#define RWSEM_WAIT_TIMEOUT	DIV_ROUND_UP(HZ, 250)
 
 /*
- * We limit the maximum number of readers that can be woken up for a
- * wake-up call to not penalizing the waking thread for spending too
- * much time doing it as well as the unlikely possiblity of overflowing
- * the reader count.
+ * Magic number to batch-wakeup waiting readers, even when writers are
+ * also present in the queue. This both limits the amount of work the
+ * waking thread must do and also prevents any potential counter overflow,
+ * however unlikely.
  */
 #define MAX_READERS_WAKEUP	0x100
 
@@ -484,7 +460,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * Take a peek at the queue head waiter such that we can determine
 	 * the wakeup(s) to perform.
 	 */
-	waiter = list_first_entry(&sem->wait_list, struct rwsem_waiter, list);
+	waiter = rwsem_first_waiter(sem);
 
 	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
 		if (wake_type == RWSEM_WAKE_ANY) {
@@ -512,7 +488,9 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
 			/*
-			 * Initiate handoff to reader, if applicable.
+			 * When we've been waiting "too" long (for writers
+			 * to give up the lock), request a * HANDOFF to
+			 * force the issue.
 			 */
 			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
 			    time_after(jiffies, waiter->timeout)) {
@@ -520,7 +498,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 				lockevent_inc(rwsem_rlock_handoff);
 			}
 
-			atomic_long_sub(adjustment, &sem->count);
+			atomic_long_add(-adjustment, &sem->count);
 			return;
 		}
 		/*
@@ -532,9 +510,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 
 	/*
 	 * Grant up to MAX_READERS_WAKEUP read locks to all the readers in the
-	 * queue. We know that woken will be at least 1 as we accounted for
-	 * above. Note we increment the 'active part' of the count by the
+	 * queue. We know that the woken will be at least 1 as we accounted
+	 * for above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
+	 *
+	 * This is an adaptation of the phase-fair R/W locks where at the
+	 * reader phase (first waiter is a reader), all readers are eligible
+	 * to acquire the lock at the same time irrespective of their order
+	 * in the queue. The writers acquire the lock according to their
+	 * order in the queue.
 	 */
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		struct task_struct *tsk;
@@ -549,7 +533,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		list_del(&waiter->list);
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
-		 * waiter to nil such that rwsem_down_read_failed() cannot
+		 * waiter to nil such that rwsem_down_read_slowpath() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
@@ -575,9 +559,10 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Clear the handoff flag
+	 * When we've woken a reader, we no longer need to force writers
+	 * to give up the lock and we can clear HANDOFF.
 	 */
-	if (woken && RWSEM_COUNT_HANDOFF(atomic_long_read(&sem->count)))
+	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
 		adjustment -= RWSEM_FLAG_HANDOFF;
 
 	if (adjustment)
@@ -590,7 +575,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * sem->count accordingly.
  *
  * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
- * bit is set or the lock is acquired.
+ * bit is set or the lock is acquired with handoff bit cleared.
  */
 static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
 					const long wlock,
@@ -598,34 +583,34 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
 {
 	long new;
 
-retry:
-	if (RWSEM_COUNT_LOCKED(count)) {
-		if (RWSEM_COUNT_HANDOFF(count) || (wstate != WRITER_HANDOFF))
-			return false;
-		/*
-		 * The lock may become free just before setting handoff bit.
-		 * It will be simpler if atomic_long_or_return() is available.
-		 */
-		atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
-		count = atomic_long_read(&sem->count);
-		goto retry;
-	}
+	lockdep_assert_held(&sem->wait_lock);
+	do {
+		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-	if ((wstate == WRITER_NOT_FIRST) && RWSEM_COUNT_HANDOFF(count))
-		return false;
+		if (has_handoff && wstate == WRITER_NOT_FIRST)
+			return false;
 
-	new = (count & ~RWSEM_FLAG_HANDOFF) + wlock -
-	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
+		if (count & RWSEM_LOCK_MASK) {
+			if (has_handoff || (wstate != WRITER_HANDOFF))
+				return false;
+			new = count | RWSEM_FLAG_HANDOFF;
+		} else {
+			new = (count | wlock) & ~RWSEM_FLAG_HANDOFF;
 
-	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
-		rwsem_set_owner(sem);
-		return true;
-	}
+			if (list_is_singular(&sem->wait_list))
+				new &= ~RWSEM_FLAG_WAITERS;
+		}
+	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
 
-	if (unlikely((wstate == WRITER_HANDOFF) && !RWSEM_COUNT_HANDOFF(count)))
-		goto retry;
+	/*
+	 * We have either acquired the lock with handoff bit cleared or
+	 * set the handoff bit.
+	 */
+	if (new & RWSEM_FLAG_HANDOFF)
+		return false;
 
-	return false;
+	rwsem_set_owner(sem);
+	return true;
 }
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
@@ -638,11 +623,11 @@ static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
 
-	if (RWSEM_COUNT_WLOCKED_OR_HANDOFF(count))
+	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
 		return false;
 
 	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
-	if (!RWSEM_COUNT_WLOCKED_OR_HANDOFF(count)) {
+	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 		rwsem_set_reader_owned(sem);
 		lockevent_inc(rwsem_opt_rlock);
 		return true;
@@ -661,9 +646,9 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!RWSEM_COUNT_LOCKED_OR_HANDOFF(count)) {
+	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-						    count + wlock)) {
+					count | wlock)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -674,6 +659,11 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 
 static inline bool owner_on_cpu(struct task_struct *owner)
 {
+	/*
+	 * Clear all the flag bits in owner
+	 */
+	*((unsigned long *)&owner) &= ~RWSEM_OWNER_FLAGS_MASK;
+
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
@@ -698,7 +688,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner, wr) &&
-		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
+		      (((unsigned long)owner & RWSEM_READER_OWNED) ||
+		       owner_on_cpu(owner));
 	}
 	rcu_read_unlock();
 	preempt_enable();
@@ -708,7 +699,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 }
 
 /*
- * Return the folowing 4 values depending on the lock owner state.
+ * The rwsem_spin_on_owner() function returns the folowing 4 values
+ * depending on the lock owner state.
  *   OWNER_NULL  : owner is currently NULL
  *   OWNER_WRITER: when owner changes and is a writer
  *   OWNER_READER: when owner changes and the new owner may be a reader.
@@ -725,22 +717,40 @@ enum owner_state {
 };
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
+static inline enum owner_state rwsem_owner_state(unsigned long owner, bool wr)
+{
+	if (!owner)
+		return OWNER_NULL;
+
+	if (!is_rwsem_owner_spinnable((void *)owner, wr))
+		return OWNER_NONSPINNABLE;
+
+	if (owner & RWSEM_READER_OWNED)
+		return OWNER_READER;
+
+	return OWNER_WRITER;
+}
+
 static noinline enum owner_state
 rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
-	struct task_struct *owner = rwsem_get_owner(sem);
-	long count;
+	struct task_struct *tmp, *owner = rwsem_get_owner(sem);
+	enum owner_state state = rwsem_owner_state((unsigned long)owner, wr);
 
-	if (!is_rwsem_owner_spinnable(owner, wr))
-		return OWNER_NONSPINNABLE;
+	if (state != OWNER_WRITER)
+		return state;
 
 	rcu_read_lock();
-	while (owner && !is_rwsem_owner_reader(owner)) {
-		struct task_struct *new_owner = rwsem_get_owner(sem);
+	for (;;) {
+		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
+			state = OWNER_NONSPINNABLE;
+			break;
+		}
 
-		if (new_owner != owner) {
-			owner = new_owner;
-			break;	/* The owner has changed */
+		tmp = rwsem_get_owner(sem);
+		if (tmp != owner) {
+			state = rwsem_owner_state((unsigned long)tmp, wr);
+			break;
 		}
 
 		/*
@@ -751,33 +761,16 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 		 */
 		barrier();
 
-		/*
-		 * abort spinning when need_resched or owner is not running or
-		 * owner's cpu is preempted.
-		 */
 		if (need_resched() || !owner_on_cpu(owner)) {
-			rcu_read_unlock();
-			return OWNER_NONSPINNABLE;
+			state = OWNER_NONSPINNABLE;
+			break;
 		}
 
 		cpu_relax();
 	}
 	rcu_read_unlock();
 
-	/*
-	 * If there is a new owner or the owner is not set, we continue
-	 * spinning except when here is no active locks and the handoff bit
-	 * is set. In this case, we have to stop spinning.
-	 */
-	if (!is_rwsem_owner_spinnable(owner, wr))
-		return OWNER_NONSPINNABLE;
-	if (owner && !is_rwsem_owner_reader(owner))
-		return OWNER_WRITER;
-
-	count = atomic_long_read(&sem->count);
-	if (RWSEM_COUNT_HANDOFF(count) && !RWSEM_COUNT_LOCKED(count))
-		return OWNER_NONSPINNABLE;
-	return !owner ? OWNER_NULL : OWNER_READER;
+	return state;
 }
 
 /*
@@ -795,8 +788,11 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
  *
  * In the first case when RWSEM_FLAG_WAITERS is set, no new reader can
  * become rwsem owner. It is assumed that the more readers own the rwsem,
- * the longer it will take for them to wind down and free the rwsem. This
- * is subjected to a maximum value of 25us.
+ * the longer it will take for them to wind down and free the rwsem. In
+ * addition, if it happens that a previous task that releases the lock
+ * is in the process of waking up readers one-by-one, the process will
+ * take longer when more readers needed to be woken up. This is subjected
+ * to a maximum value of 25us.
  *
  * In the second case with RWSEM_FLAG_WAITERS off, new readers can join
  * and become one of the owners. So assuming for the worst case and spin
@@ -805,19 +801,22 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
-	int reader_cnt = atomic_long_read(&sem->count) >> RWSEM_READER_SHIFT;
+	u64 delta = 25 * NSEC_PER_USEC;
+
+	if (count & RWSEM_FLAG_WAITERS) {
+		int readers = count >> RWSEM_READER_SHIFT;
 
-	if (reader_cnt > 30)
-		reader_cnt = 30;
-	return sched_clock() + ((count & RWSEM_FLAG_WAITERS)
-		? 10 * NSEC_PER_USEC + reader_cnt * NSEC_PER_USEC/2
-		: 25 * NSEC_PER_USEC);
+		if (readers > 30)
+			readers = 30;
+		delta = (20 + readers) * NSEC_PER_USEC / 2;
+	}
+
+	return sched_clock() + delta;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 {
 	bool taken = false;
-	bool is_rt_task = rt_task(current);
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0;
@@ -832,7 +831,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	 * Optimistically spin on the owner field and attempt to acquire the
 	 * lock whenever the owner changes. Spinning will be stopped when:
 	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock and spinning count has reached 0.
+	 *  2) readers own the lock and spinning time has exceeded limit.
 	 */
 	for (;;) {
 		enum owner_state owner_state = rwsem_spin_on_owner(sem, wlock);
@@ -854,8 +853,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		 */
 		if (wlock && (owner_state == OWNER_READER)) {
 			/*
-			 * Initialize rspin_threshold when the owner
-			 * state changes from non-reader to reader.
+			 * Re-initialize rspin_threshold every time when
+			 * the owner state changes from non-reader to reader.
+			 * This allows a writer to steal the lock in between
+			 * 2 reader phases and have the threshold reset at
+			 * the beginning of the 2nd reader phase.
 			 */
 			if (prev_owner_state != OWNER_READER) {
 				if (!is_rwsem_spinnable(sem, wlock))
@@ -865,10 +867,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 			}
 
 			/*
-			 * Check time threshold every 16 iterations to
-			 * avoid calling sched_clock() too frequently.
-			 * This will make the actual spinning time a
-			 * bit more than that specified in the threshold.
+			 * Check time threshold once every 16 iterations to
+			 * avoid calling sched_clock() too frequently so
+			 * as to reduce the average latency between the times
+			 * when the lock becomes free and when the spinner
+			 * is ready to do a trylock.
 			 */
 			else if (!(++loop & 0xf) &&
 				 (sched_clock() > rspin_threshold)) {
@@ -882,13 +885,28 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		 * An RT task cannot do optimistic spinning if it cannot
 		 * be sure the lock holder is running or live-lock may
 		 * happen if the current task and the lock holder happen
-		 * to run in the same CPU.
+		 * to run in the same CPU. However, aborting optimistic
+		 * spinning while a NULL owner is detected may miss some
+		 * opportunity where spinning can continue without causing
+		 * problem.
+		 *
+		 * There are 2 possible cases where an RT task may be able
+		 * to continue spinning.
 		 *
-		 * When there's no owner or is reader-owned, an RT task
-		 * will stop spinning if the owner state is not a writer
-		 * at the previous iteration of the loop. This allows the
-		 * RT task to recheck if the task that steals the lock is
-		 * a spinnable writer. If so, it can keeps on spinning.
+		 * 1) The lock owner is in the process of releasing the
+		 *    lock, sem->owner is cleared but the lock has not
+		 *    been released yet.
+		 * 2) The lock was free and owner cleared, but another
+		 *    task just comes in and acquire the lock before
+		 *    we try to get it. The new owner may be a spinnable
+		 *    writer.
+		 *
+		 * To take advantage of two scenarios listed agove, the RT
+		 * task is made to retry one more time to see if it can
+		 * acquire the lock or continue spinning on the new owning
+		 * writer. Of course, if the time lag is long enough or the
+		 * new owner is not a writer or spinnable, the RT task will
+		 * quit spinning.
 		 *
 		 * If the owner is a writer, the need_resched() check is
 		 * done inside rwsem_spin_on_owner(). If the owner is not
@@ -897,7 +915,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		if (owner_state != OWNER_WRITER) {
 			if (need_resched())
 				break;
-			if (is_rt_task && (prev_owner_state != OWNER_WRITER))
+			if (rt_task(current) &&
+			   (prev_owner_state != OWNER_WRITER))
 				break;
 		}
 		prev_owner_state = owner_state;
@@ -916,6 +935,23 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
+
+/*
+ * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
+ * only be called when the reader count reaches 0.
+ *
+ * This give writers better chance to acquire the rwsem first before
+ * readers when the rwsem was being held by readers for a relatively long
+ * period of time. Race can happen that an optimistic spinner may have
+ * just stolen the rwsem and set the owner, but just clearing the
+ * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
+ */
+static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
+{
+	if (!is_rwsem_spinnable(sem, true))
+		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
+				  (atomic_long_t *)&sem->owner);
+}
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
@@ -927,25 +963,18 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
 {
 	return false;
 }
-#endif
 
-/*
- * This is safe to be called without holding the wait_lock.
- */
-static inline bool
-rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
-{
-	return list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
-			== waiter;
-}
+static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
+#endif
 
 /*
  * Wait for the read lock to be granted
  */
-static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
+static struct rw_semaphore __sched *
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 {
 	long adjustment = -RWSEM_READER_BIAS;
+	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -957,7 +986,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 		 * reader count.
 		 *
 		 * As preemption is not disabled, there is a remote
-		 * possibility that premption can happen in the narrow
+		 * possibility that preemption can happen in the narrow
 		 * timing window between incrementing and decrementing
 		 * the reader count and the task is put to sleep for a
 		 * considerable amount of time. If sufficient number
@@ -980,19 +1009,17 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 	 */
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
-	if (rwsem_optimistic_spin(sem, 0)) {
-		unsigned long flags;
-
+	if (rwsem_optimistic_spin(sem, false)) {
 		/*
 		 * Opportunistically wake up other readers in the wait queue.
 		 * It has another chance of wakeup at unlock time.
 		 */
 		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS) &&
-		    raw_spin_trylock_irqsave(&sem->wait_lock, flags)) {
+		    raw_spin_trylock_irq(&sem->wait_lock)) {
 			if (!list_empty(&sem->wait_list))
 				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						  &wake_q);
-			raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
+			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
 		}
 		return sem;
@@ -1030,21 +1057,17 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
-	 * Also clear the owner's RWSEM_WR_NONSPINNABLE bit if set.
 	 *
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (!RWSEM_COUNT_LOCKED(count)) {
-		/* Clear RWSEM_WR_UNSPINNABLE bit if set */
-		if (!is_rwsem_spinnable(sem, true))
-			atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
-					  (atomic_long_t *)&sem->owner);
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-	} else if (!(count & RWSEM_WRITER_MASK) &&
-		    (adjustment & RWSEM_FLAG_WAITERS)) {
-		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+	if (!(count & RWSEM_LOCK_MASK)) {
+		clear_wr_nonspinnable(sem);
+		wake = true;
 	}
+	if (wake || (!(count & RWSEM_WRITER_MASK) &&
+		    (adjustment & RWSEM_FLAG_WAITERS)))
+		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
@@ -1070,27 +1093,16 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list))
+	if (list_empty(&sem->wait_list)) {
 		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
 				   &sem->count);
+	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
 	return ERR_PTR(-EINTR);
 }
 
-static inline struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem, long cnt)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE, cnt);
-}
-
-static inline struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem, long cnt)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE, cnt);
-}
-
 static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
 						bool disable)
 {
@@ -1103,16 +1115,16 @@ static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
 /*
  * Wait until we successfully acquire the write lock
  */
-static inline struct rw_semaphore *
-__rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
+static struct rw_semaphore *
+rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
+	bool disable_rspin;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 	const long wlock = RWSEM_WRITER_LOCKED;
-	bool disable_rspin;
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, true) &&
@@ -1153,27 +1165,29 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 		 *     must be read owned; so we try to wake any read lock
 		 *     waiters that were queued ahead of us.
 		 */
-		if (!RWSEM_COUNT_LOCKED(count))
-			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-		else if (!(count & RWSEM_WRITER_MASK) &&
-			  (count & RWSEM_READER_MASK))
-			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
-		else
+		if (count & RWSEM_WRITER_MASK)
 			goto wait;
 
-		/*
-		 * The wakeup is normally called _after_ the wait_lock
-		 * is released, but given that we are proactively waking
-		 * readers we can deal with the wake_q overhead as it is
-		 * similar to releasing and taking the wait_lock again
-		 * for attempting rwsem_try_write_lock().
-		 */
-		wake_up_q(&wake_q);
+		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
+					? RWSEM_WAKE_READERS
+					: RWSEM_WAKE_ANY, &wake_q);
 
-		/*
-		 * Reinitialize wake_q after use.
-		 */
-		wake_q_init(&wake_q);
+		if (!wake_q_empty(&wake_q)) {
+			/*
+			 * We want to minimize wait_lock hold time especially
+			 * when a large number of readers are to be woken up.
+			 */
+			raw_spin_unlock_irq(&sem->wait_lock);
+			wake_up_q(&wake_q);
+			wake_q_init(&wake_q);	/* Used again, reinit */
+			raw_spin_lock_irq(&sem->wait_lock);
+			/*
+			 * This waiter may have become first in the wait
+			 * list after re-acquring the wait_lock. The
+			 * rwsem_first_waiter() test in the main while
+			 * loop below will correctly detect that.
+			 */
+		}
 	} else {
 		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
 	}
@@ -1195,19 +1209,22 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
-			count = atomic_long_read(&sem->count);
+			/*
+			 * If HANDOFF bit is set, unconditionally do
+			 * a trylock.
+			 */
+			if (wstate == WRITER_HANDOFF)
+				break;
 
 			if ((wstate == WRITER_NOT_FIRST) &&
-			    rwsem_waiter_is_first(sem, &waiter))
+			    (rwsem_first_waiter(sem) == &waiter))
 				wstate = WRITER_FIRST;
 
-			if (!RWSEM_COUNT_LOCKED(count))
+			count = atomic_long_read(&sem->count);
+			if (!(count & RWSEM_LOCK_MASK))
 				break;
 
 			/*
-			 * An RT task sets the HANDOFF bit immediately.
-			 * Non-RT task will wait a while before doing so.
-			 *
 			 * The setting of the handoff bit is deferred
 			 * until rwsem_try_write_lock() is called.
 			 */
@@ -1215,9 +1232,6 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 			    time_after(jiffies, waiter.timeout))) {
 				wstate = WRITER_HANDOFF;
 				lockevent_inc(rwsem_wlock_handoff);
-				/*
-				 * Break out to call rwsem_try_write_lock().
-				 */
 				break;
 			}
 		}
@@ -1237,12 +1251,10 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
-	/*
-	 * If handoff bit has been set by this waiter, make sure that the
-	 * clearing of it is seen by others before proceeding.
-	 */
+
 	if (unlikely(wstate == WRITER_HANDOFF))
-		atomic_long_add_return(-RWSEM_FLAG_HANDOFF,  &sem->count);
+		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
+
 	if (list_empty(&sem->wait_list))
 		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
 	else
@@ -1254,18 +1266,6 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-static inline struct rw_semaphore * __sched
-rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-
-static inline struct rw_semaphore * __sched
-rwsem_down_write_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_KILLABLE);
-}
-
 /*
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
@@ -1312,11 +1312,11 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-						   &sem->count);
+	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						 &sem->count);
 
-	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_failed(sem, count);
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, tmp);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -1325,11 +1325,11 @@ inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-						   &sem->count);
+	long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
+						 &sem->count);
 
-	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem, count)))
+	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE, tmp)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
@@ -1345,7 +1345,6 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	 */
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
-	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_READER_BIAS)) {
@@ -1361,21 +1360,25 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_failed(sem);
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						      RWSEM_WRITER_LOCKED)))
+		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
 	else
 		rwsem_set_owner(sem);
-#ifdef RWSEM_MERGE_OWNER_TO_COUNT
+#ifdef CONFIG_RWSEM_OWNER_COUNT
 	DEBUG_RWSEMS_WARN_ON(sem->owner != rwsem_get_owner(sem), sem);
 #endif
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED))) {
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						      RWSEM_WRITER_LOCKED))) {
+		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
 	} else {
 		rwsem_set_owner(sem);
@@ -1385,12 +1388,10 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
+	long tmp = RWSEM_UNLOCKED_VALUE;
 
-	lockevent_inc(rwsem_wtrylock);
-	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-					  RWSEM_WRITER_LOCKED);
-	if (tmp == RWSEM_UNLOCKED_VALUE) {
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+					    RWSEM_WRITER_LOCKED)) {
 		rwsem_set_owner(sem);
 		return true;
 	}
@@ -1407,12 +1408,9 @@ inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
-	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
-			== RWSEM_FLAG_WAITERS)) {
-		/* Clear RWSEM_WR_UNSPINNABLE bit if set */
-		if (!is_rwsem_spinnable(sem, true))
-			atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
-					  (atomic_long_t *)&sem->owner);
+	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
+		      RWSEM_FLAG_WAITERS)) {
+		clear_wr_nonspinnable(sem);
 		rwsem_wake(sem, tmp);
 	}
 }
