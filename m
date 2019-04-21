Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52D620857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfDUVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 17:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfDUVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 17:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45B6E81F0F;
        Sun, 21 Apr 2019 21:08:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-184.rdu2.redhat.com [10.10.120.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9455160BF4;
        Sun, 21 Apr 2019 21:07:56 +0000 (UTC)
Reply-To: llong@redhat.com
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-15-longman@redhat.com>
 <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
From:   Waiman Long <llong@redhat.com>
Organization: Red Hat
Message-ID: <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
Date:   Sun, 21 Apr 2019 17:07:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 21 Apr 2019 21:08:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 3:39 PM, Waiman Long wrote:
> On 04/19/2019 09:15 AM, Peter Zijlstra wrote:
>> On Fri, Apr 19, 2019 at 03:03:04PM +0200, Peter Zijlstra wrote:
>>> On Fri, Apr 19, 2019 at 02:02:07PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Apr 19, 2019 at 12:26:47PM +0200, Peter Zijlstra wrote:
>>>>> I thought of a horrible horrible alternative:
>>>> Hurm, that's broken as heck. Let me try again.
>>> So I can't make that scheme work, it all ends up wanting to have
>>> cmpxchg().
>>>
>>> Do we have a performance comparison somewhere of xadd vs cmpxchg
>>> readers? I tried looking in the old threads, but I can't seem to locate
>>> it.
>>>
>>> We need new instructions :/ Or more clever than I can muster just now.
>> In particular, an (unsigned) saturation arithmetic variant of XADD would
>> be very nice to have at this point.
> I just want to clear about my current scheme. There will be 16 bits
> allocated for reader count. I use the MS bit for signaling that there
> are too many readers. So the fast path will fail and the readers will be
> put into the wait list. This effectively limit readers to 32k-1, but it
> doesn't mean the actual reader count cannot go over that. As long as the
> actual count is less than 64k, everything should still work perfectly.
> IOW, even though we have reached the limit of 32k, we need to pile on an
> additional 32k readers to really overflow the count and cause problem.

How about the following chunks to disable preemption temporarily for the
increment-check-decrement sequence?

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index dd92b1a93919..4cc03ac66e13 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -250,6 +250,8 @@ do { \
 #define preempt_enable_notrace()               barrier()
 #define preemptible()                          0
 
+#define __preempt_disable_nop  /* preempt_disable() is nop */
+
 #endif /* CONFIG_PREEMPT_COUNT */
 
 #ifdef MODULE
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 043fd29b7534..54029e6af17b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -256,11 +256,64 @@ static inline struct task_struct
*rwsem_get_owner(struct r
        return (struct task_struct *) (cowner
                ? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
 }
+
+/*
+ * If __preempt_disable_nop is defined, calling preempt_disable() and
+ * preempt_enable() directly is the most efficient way. Otherwise, it may
+ * be more efficient to disable and enable interrupt instead for disabling
+ * preemption tempoarily.
+ */
+#ifdef __preempt_disable_nop
+#define disable_preemption()   preempt_disable()
+#define enable_preemption()    preempt_enable()
+#else
+#define disable_preemption()   local_irq_disable()
+#define enable_preemption()    local_irq_enable()
+#endif
+
+/*
+ * When the owner task structure pointer is merged into couunt, less bits
+ * will be available for readers. Therefore, there is a very slight chance
+ * that the reader count may overflow. We try to prevent that from
happening
+ * by checking for the MS bit of the count and failing the trylock attempt
+ * if this bit is set.
+ *
+ * With preemption enabled, there is a remote possibility that preemption
+ * can happen in the narrow timing window between incrementing and
+ * decrementing the reader count and the task is put to sleep for a
+ * considerable amount of time. If sufficient number of such unfortunate
+ * sequence of events happen, we may still overflow the reader count.
+ * To avoid such possibility, we have to disable preemption for the
+ * whole increment-check-decrement sequence.
+ *
+ * The function returns true if there are too many readers and the count
+ * has already been properly decremented so the reader must go directly
+ * into the wait list.
+ */
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
+{
+       bool wait = false;      /* Wait now flag */
+
+       disable_preemption();
+       *cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
&sem->count);
+       if (unlikely(*cnt < 0)) {
+               atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+               wait = true;
+       }
+       enable_preemption();
+       return wait;
+}
 #else /* !CONFIG_RWSEM_OWNER_COUNT */
 static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 {
        return READ_ONCE(sem->owner);
 }
+
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
+{
+       *cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
&sem->count);
+       return false;
+}
 #endif /* CONFIG_RWSEM_OWNER_COUNT */
 
 /*
@@ -981,32 +1034,18 @@ static inline void clear_wr_nonspinnable(struct
rw_semaph
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, const
bool wait)
 {
-       long adjustment = -RWSEM_READER_BIAS;
+       long count, adjustment = -RWSEM_READER_BIAS;
        bool wake = false;
        struct rwsem_waiter waiter;
        DEFINE_WAKE_Q(wake_q);
 
-       if (unlikely(count < 0)) {
+       if (unlikely(wait)) {
                /*
-                * The sign bit has been set meaning that too many active
-                * readers are present. We need to decrement reader count &
-                * enter wait queue immediately to avoid overflowing the
-                * reader count.
-                *
-                * As preemption is not disabled, there is a remote
-                * possibility that preemption can happen in the narrow
-                * timing window between incrementing and decrementing
-                * the reader count and the task is put to sleep for a
-                * considerable amount of time. If sufficient number
-                * of such unfortunate sequence of events happen, we
-                * may still overflow the reader count. It is extremely
-                * unlikey, though. If this is a concern, we should consider
-                * disable preemption during this timing window to make
-                * sure that such unfortunate event will not happen.
+                * The reader count has already been decremented and the
+                * reader should go directly into the wait list now.
                 */
-               atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
                adjustment = 0;
                goto queue;
        }
@@ -1358,11 +1397,12 @@ static struct rw_semaphore
*rwsem_downgrade_wake(struct
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-       long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-                                                &sem->count);
+       long tmp;
+       bool wait;
 
+       wait = rwsem_read_trylock(sem, &tmp);
        if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
-               rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, tmp);
+               rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, wait);
                DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
        } else {
                rwsem_set_reader_owned(sem);
@@ -1371,11 +1411,12 @@ inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-       long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-                                                &sem->count);
+       long tmp;
+       bool wait;
 
+       wait = rwsem_read_trylock(sem, &tmp);
        if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
-               if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
tmp)))
+               if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
wait)))
                        return -EINTR;
                DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
        } else {

