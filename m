Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDCFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BE121874
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfGSSpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:45:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbfGSSpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:45:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8824CAF10;
        Fri, 19 Jul 2019 18:45:40 +0000 (UTC)
Date:   Fri, 19 Jul 2019 19:45:38 +0100
From:   Luis Henriques <lhenriques@suse.com>
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
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
Message-ID: <20190719184538.GA20324@hermes.olymp>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520205918.22251-14-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
> The rwsem->owner contains not just the task structure pointer, it also
> holds some flags for storing the current state of the rwsem. Some of
> the flags may have to be atomically updated. To reflect the new reality,
> the owner is now changed to an atomic_long_t type.
> 
> New helper functions are added to properly separate out the task
> structure pointer and the embedded flags.

I started seeing KASAN use-after-free with current master, and a bisect
showed me that this commit 94a9717b3c40 ("locking/rwsem: Make
rwsem->owner an atomic_long_t") was the problem.  Does it ring any
bells?  I can easily reproduce it with xfstests (generic/464).

Cheers,
--
Luís

[ 6380.820179] run fstests generic/464 at 2019-07-19 12:04:05
[ 6381.504693] libceph: mon0 (1)192.168.155.1:40786 session established
[ 6381.506790] libceph: client4572 fsid 86b39301-7192-4052-8427-a241af35a591
[ 6381.618830] libceph: mon0 (1)192.168.155.1:40786 session established
[ 6381.619993] libceph: client4573 fsid 86b39301-7192-4052-8427-a241af35a591
[ 6384.464561] ==================================================================
[ 6384.466165] BUG: KASAN: use-after-free in rwsem_down_write_slowpath+0x67d/0x8a0
[ 6384.468288] Read of size 4 at addr ffff8881d5dc9478 by task xfs_io/17238

[ 6384.469545] CPU: 1 PID: 17238 Comm: xfs_io Not tainted 5.2.0+ #444
[ 6384.469550] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 6384.469554] Call Trace:
[ 6384.469563]  dump_stack+0x5b/0x90
[ 6384.469569]  print_address_description+0x6f/0x332
[ 6384.469573]  ? rwsem_down_write_slowpath+0x67d/0x8a0
[ 6384.469575]  ? rwsem_down_write_slowpath+0x67d/0x8a0
[ 6384.469579]  __kasan_report.cold+0x1a/0x3e
[ 6384.469583]  ? rwsem_down_write_slowpath+0x67d/0x8a0
[ 6384.469588]  kasan_report+0xe/0x12
[ 6384.469591]  rwsem_down_write_slowpath+0x67d/0x8a0
[ 6384.469596]  ? __ceph_caps_issued_mask+0xe7/0x280
[ 6384.469599]  ? find_held_lock+0xc9/0xf0
[ 6384.469604]  ? __ceph_do_getattr+0x19f/0x290
[ 6384.469608]  ? down_read_non_owner+0x1c0/0x1c0
[ 6384.469612]  ? do_raw_spin_unlock+0xa3/0x130
[ 6384.469617]  ? _raw_spin_unlock+0x24/0x30
[ 6384.469622]  ? __lock_acquire.isra.0+0x486/0x770
[ 6384.469629]  ? path_openat+0x7ef/0xfe0
[ 6384.469635]  ? down_write+0x11e/0x130
[ 6384.469638]  down_write+0x11e/0x130
[ 6384.469642]  ? down_read_killable+0x1e0/0x1e0
[ 6384.469646]  ? __sb_start_write+0x11c/0x170
[ 6384.469650]  ? __mnt_want_write+0xb4/0xd0
[ 6384.469655]  path_openat+0x7ef/0xfe0
[ 6384.469661]  ? path_mountpoint+0x4d0/0x4d0
[ 6384.469667]  ? __is_insn_slot_addr+0x93/0xb0
[ 6384.469671]  ? kernel_text_address+0x113/0x120
[ 6384.469674]  ? __kernel_text_address+0xe/0x30
[ 6384.469679]  ? unwind_get_return_address+0x2f/0x50
[ 6384.469683]  ? swiotlb_map.cold+0x25/0x25
[ 6384.469687]  ? arch_stack_walk+0x8f/0xe0
[ 6384.469692]  do_filp_open+0x12b/0x1c0
[ 6384.469695]  ? may_open_dev+0x50/0x50
[ 6384.469702]  ? __alloc_fd+0x115/0x280
[ 6384.469705]  ? lock_downgrade+0x350/0x350
[ 6384.469709]  ? do_raw_spin_lock+0x113/0x1d0
[ 6384.469713]  ? rwlock_bug.part.0+0x60/0x60
[ 6384.469718]  ? do_raw_spin_unlock+0xa3/0x130
[ 6384.469722]  ? _raw_spin_unlock+0x24/0x30
[ 6384.469725]  ? __alloc_fd+0x115/0x280
[ 6384.469731]  do_sys_open+0x1f0/0x2d0
[ 6384.469735]  ? filp_open+0x50/0x50
[ 6384.469738]  ? switch_fpu_return+0x13e/0x230
[ 6384.469742]  ? __do_page_fault+0x4b5/0x670
[ 6384.469748]  do_syscall_64+0x63/0x1c0
[ 6384.469753]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6384.469756] RIP: 0033:0x7fe961434528
[ 6384.469760] Code: 00 00 41 00 3d 00 00 41 00 74 47 48 8d 05 20 4d 0d 00 8b 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 94 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[ 6384.469762] RSP: 002b:00007ffd9bbabb20 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 6384.469765] RAX: ffffffffffffffda RBX: 0000000000000242 RCX: 00007fe961434528
[ 6384.469767] RDX: 0000000000000242 RSI: 00007ffd9bbae2a5 RDI: 00000000ffffff9c
[ 6384.469769] RBP: 00007ffd9bbae2a5 R08: 0000000000000001 R09: 0000000000000000
[ 6384.469771] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000000242
[ 6384.469773] R13: 00007ffd9bbabe00 R14: 0000000000000180 R15: 0000000000000060

[ 6384.470018] Allocated by task 16593:
[ 6384.470562]  __kasan_kmalloc.part.0+0x3c/0xa0
[ 6384.470565]  kmem_cache_alloc+0xdc/0x240
[ 6384.470569]  copy_process+0x1dce/0x27b0
[ 6384.470572]  _do_fork+0xec/0x540
[ 6384.470576]  __se_sys_clone+0xb2/0x100
[ 6384.470581]  do_syscall_64+0x63/0x1c0
[ 6384.470586]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 6384.470823] Freed by task 9:
[ 6384.471235]  __kasan_slab_free+0x147/0x200
[ 6384.471240]  kmem_cache_free+0x111/0x330
[ 6384.471246]  rcu_core+0x2f9/0x830
[ 6384.471251]  __do_softirq+0x154/0x486

[ 6384.471493] The buggy address belongs to the object at ffff8881d5dc9440
                which belongs to the cache task_struct of size 4928
[ 6384.473081] The buggy address is located 56 bytes inside of
                4928-byte region [ffff8881d5dc9440, ffff8881d5dca780)
[ 6384.474453] The buggy address belongs to the page:
[ 6384.474989] page:ffffea0007577200 refcount:1 mapcount:0 mapping:ffff8881f6811800 index:0x0 compound_mapcount: 0
[ 6384.474993] flags: 0x8000000000010200(slab|head)
[ 6384.474997] raw: 8000000000010200 0000000000000000 0000000100000001 ffff8881f6811800
[ 6384.475000] raw: 0000000000000000 0000000000060006 00000001ffffffff 0000000000000000
[ 6384.475002] page dumped because: kasan: bad access detected

[ 6384.475176] Memory state around the buggy address:
[ 6384.475744]  ffff8881d5dc9300: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[ 6384.476571]  ffff8881d5dc9380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 6384.477390] >ffff8881d5dc9400: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
[ 6384.478214]                                                                 ^
[ 6384.479052]  ffff8881d5dc9480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 6384.479898]  ffff8881d5dc9500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 6384.481300] ==================================================================
[ 6384.482408] Disabling lock debugging due to kernel taint


> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/percpu-rwsem.h |   4 +-
>  include/linux/rwsem.h        |  11 +--
>  kernel/locking/rwsem.c       | 125 ++++++++++++++++++++++-------------
>  3 files changed, 88 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index 03cb4b6f842e..0a43830f1932 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -117,7 +117,7 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
>  	lock_release(&sem->rw_sem.dep_map, 1, ip);
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  	if (!read)
> -		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
> +		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
>  #endif
>  }
>  
> @@ -127,7 +127,7 @@ static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
>  	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  	if (!read)
> -		sem->rw_sem.owner = current;
> +		atomic_long_set(&sem->rw_sem.owner, (long)current);
>  #endif
>  }
>  
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index bb76e82398b2..e401358c4e7e 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -35,10 +35,11 @@
>  struct rw_semaphore {
>  	atomic_long_t count;
>  	/*
> -	 * Write owner or one of the read owners. Can be used as a
> -	 * speculative check to see if the owner is running on the cpu.
> +	 * Write owner or one of the read owners as well flags regarding
> +	 * the current state of the rwsem. Can be used as a speculative
> +	 * check to see if the write owner is running on the cpu.
>  	 */
> -	struct task_struct *owner;
> +	atomic_long_t owner;
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  	struct optimistic_spin_queue osq; /* spinner MCS lock */
>  #endif
> @@ -53,7 +54,7 @@ struct rw_semaphore {
>   * Setting all bits of the owner field except bit 0 will indicate
>   * that the rwsem is writer-owned with an unknown owner.
>   */
> -#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
> +#define RWSEM_OWNER_UNKNOWN	(-2L)
>  
>  /* In all implementations count != 0 means locked */
>  static inline int rwsem_is_locked(struct rw_semaphore *sem)
> @@ -80,7 +81,7 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
>  
>  #define __RWSEM_INITIALIZER(name)				\
>  	{ __RWSEM_INIT_COUNT(name),				\
> -	  .owner = NULL,					\
> +	  .owner = ATOMIC_LONG_INIT(0),				\
>  	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
>  	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
>  	  __RWSEM_OPT_INIT(name)				\
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9eb46ab9edaa..555da4868e54 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -64,7 +64,7 @@
>  	if (!debug_locks_silent &&				\
>  	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
>  		#c, atomic_long_read(&(sem)->count),		\
> -		(long)((sem)->owner), (long)current,		\
> +		atomic_long_read(&(sem)->owner), (long)current,	\
>  		list_empty(&(sem)->wait_list) ? "" : "not "))	\
>  			debug_locks_off();			\
>  	} while (0)
> @@ -114,12 +114,20 @@
>   */
>  static inline void rwsem_set_owner(struct rw_semaphore *sem)
>  {
> -	WRITE_ONCE(sem->owner, current);
> +	atomic_long_set(&sem->owner, (long)current);
>  }
>  
>  static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>  {
> -	WRITE_ONCE(sem->owner, NULL);
> +	atomic_long_set(&sem->owner, 0);
> +}
> +
> +/*
> + * Test the flags in the owner field.
> + */
> +static inline bool rwsem_test_oflags(struct rw_semaphore *sem, long flags)
> +{
> +	return atomic_long_read(&sem->owner) & flags;
>  }
>  
>  /*
> @@ -133,10 +141,9 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>  static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
>  					    struct task_struct *owner)
>  {
> -	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
> -						 | RWSEM_NONSPINNABLE;
> +	long val = (long)owner | RWSEM_READER_OWNED | RWSEM_NONSPINNABLE;
>  
> -	WRITE_ONCE(sem->owner, (struct task_struct *)val);
> +	atomic_long_set(&sem->owner, val);
>  }
>  
>  static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
> @@ -145,13 +152,20 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
>  }
>  
>  /*
> - * Return true if the a rwsem waiter can spin on the rwsem's owner
> - * and steal the lock.
> - * N.B. !owner is considered spinnable.
> + * Return true if the rwsem is owned by a reader.
>   */
> -static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
> +static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
>  {
> -	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
> +#ifdef CONFIG_DEBUG_RWSEMS
> +	/*
> +	 * Check the count to see if it is write-locked.
> +	 */
> +	long count = atomic_long_read(&sem->count);
> +
> +	if (count & RWSEM_WRITER_MASK)
> +		return false;
> +#endif
> +	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
>  }
>  
>  #ifdef CONFIG_DEBUG_RWSEMS
> @@ -163,11 +177,13 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
>   */
>  static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
>  {
> -	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
> -						   | RWSEM_NONSPINNABLE;
> -	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
> -		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
> -				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
> +	long val = atomic_long_read(&sem->owner);
> +
> +	while ((val & ~RWSEM_OWNER_FLAGS_MASK) == (long)current) {
> +		if (atomic_long_try_cmpxchg(&sem->owner, &val,
> +					    val & RWSEM_OWNER_FLAGS_MASK))
> +			return;
> +	}
>  }
>  #else
>  static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
> @@ -175,6 +191,28 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
>  }
>  #endif
>  
> +/*
> + * Return just the real task structure pointer of the owner
> + */
> +static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
> +{
> +	return (struct task_struct *)(atomic_long_read(&sem->owner) &
> +					~RWSEM_OWNER_FLAGS_MASK);
> +}
> +
> +/*
> + * Return the real task structure pointer of the owner and the embedded
> + * flags in the owner. pflags must be non-NULL.
> + */
> +static inline struct task_struct *
> +rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
> +{
> +	long owner = atomic_long_read(&sem->owner);
> +
> +	*pflags = owner & RWSEM_OWNER_FLAGS_MASK;
> +	return (struct task_struct *)(owner & ~RWSEM_OWNER_FLAGS_MASK);
> +}
> +
>  /*
>   * Guide to the rw_semaphore's count field.
>   *
> @@ -208,7 +246,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
>  	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
>  	raw_spin_lock_init(&sem->wait_lock);
>  	INIT_LIST_HEAD(&sem->wait_list);
> -	sem->owner = NULL;
> +	atomic_long_set(&sem->owner, 0L);
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  	osq_lock_init(&sem->osq);
>  #endif
> @@ -511,9 +549,10 @@ static inline bool owner_on_cpu(struct task_struct *owner)
>  static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  {
>  	struct task_struct *owner;
> +	long flags;
>  	bool ret = true;
>  
> -	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
> +	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
>  
>  	if (need_resched()) {
>  		lockevent_inc(rwsem_opt_fail);
> @@ -522,11 +561,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  
>  	preempt_disable();
>  	rcu_read_lock();
> -	owner = READ_ONCE(sem->owner);
> -	if (owner) {
> -		ret = is_rwsem_owner_spinnable(owner) &&
> -		      owner_on_cpu(owner);
> -	}
> +	owner = rwsem_read_owner_flags(sem, &flags);
> +	if ((flags & RWSEM_NONSPINNABLE) || (owner && !owner_on_cpu(owner)))
> +		ret = false;
>  	rcu_read_unlock();
>  	preempt_enable();
>  
> @@ -553,25 +590,26 @@ enum owner_state {
>  };
>  #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
>  
> -static inline enum owner_state rwsem_owner_state(unsigned long owner)
> +static inline enum owner_state rwsem_owner_state(struct task_struct *owner,
> +						 long flags)
>  {
> -	if (!owner)
> -		return OWNER_NULL;
> -
> -	if (owner & RWSEM_NONSPINNABLE)
> +	if (flags & RWSEM_NONSPINNABLE)
>  		return OWNER_NONSPINNABLE;
>  
> -	if (owner & RWSEM_READER_OWNED)
> +	if (flags & RWSEM_READER_OWNED)
>  		return OWNER_READER;
>  
> -	return OWNER_WRITER;
> +	return owner ? OWNER_WRITER : OWNER_NULL;
>  }
>  
>  static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>  {
> -	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
> -	enum owner_state state = rwsem_owner_state((unsigned long)owner);
> +	struct task_struct *new, *owner;
> +	long flags, new_flags;
> +	enum owner_state state;
>  
> +	owner = rwsem_read_owner_flags(sem, &flags);
> +	state = rwsem_owner_state(owner, flags);
>  	if (state != OWNER_WRITER)
>  		return state;
>  
> @@ -582,9 +620,9 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>  			break;
>  		}
>  
> -		tmp = READ_ONCE(sem->owner);
> -		if (tmp != owner) {
> -			state = rwsem_owner_state((unsigned long)tmp);
> +		new = rwsem_read_owner_flags(sem, &new_flags);
> +		if ((new != owner) || (new_flags != flags)) {
> +			state = rwsem_owner_state(new, new_flags);
>  			break;
>  		}
>  
> @@ -1001,8 +1039,7 @@ inline void __down_read(struct rw_semaphore *sem)
>  	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
>  			&sem->count) & RWSEM_READ_FAILED_MASK)) {
>  		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
> -		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
> -					RWSEM_READER_OWNED), sem);
> +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	} else {
>  		rwsem_set_reader_owned(sem);
>  	}
> @@ -1014,8 +1051,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
>  			&sem->count) & RWSEM_READ_FAILED_MASK)) {
>  		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
>  			return -EINTR;
> -		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
> -					RWSEM_READER_OWNED), sem);
> +		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	} else {
>  		rwsem_set_reader_owned(sem);
>  	}
> @@ -1084,7 +1120,7 @@ inline void __up_read(struct rw_semaphore *sem)
>  {
>  	long tmp;
>  
> -	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED), sem);
> +	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	rwsem_clear_reader_owned(sem);
>  	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
>  	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
> @@ -1103,8 +1139,8 @@ static inline void __up_write(struct rw_semaphore *sem)
>  	 * sem->owner may differ from current if the ownership is transferred
>  	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
>  	 */
> -	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
> -			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
> +	DEBUG_RWSEMS_WARN_ON((rwsem_read_owner(sem) != current) &&
> +			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>  	rwsem_clear_owner(sem);
>  	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
>  	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
> @@ -1125,7 +1161,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>  	 * read-locked region is ok to be re-ordered into the
>  	 * write side. As such, rely on RELEASE semantics.
>  	 */
> -	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
> +	DEBUG_RWSEMS_WARN_ON(rwsem_read_owner(sem) != current, sem);
>  	tmp = atomic_long_fetch_add_release(
>  		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
>  	rwsem_set_reader_owned(sem);
> @@ -1296,8 +1332,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
>  
>  void up_read_non_owner(struct rw_semaphore *sem)
>  {
> -	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
> -				sem);
> +	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>  	__up_read(sem);
>  }
>  EXPORT_SYMBOL(up_read_non_owner);
> -- 
> 2.18.1
> 

