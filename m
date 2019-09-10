Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD10320872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CiW2CUw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbfIJJsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:48:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:42152 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfIJJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:48:04 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E1B93BCDD5;
        Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id lpzdfGQbw0SW; Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6B6DFBCDCD;
        Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B6DFBCDCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568108882;
        bh=IdusK4PuURuSTT8wxQ41V7XVI28sGALL5MVCjAUT6lM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CiW2CUw+BauNaL7r3gZSkrCEotim2gRrhdpdhgmqENqWDcHnrxH9ptP4d7YMddtg+
         T5SAJ8HgG5HEYIF5K0NLSASpjzm3p4J59ikUt6OJ13UnWaJEV0koAFTBRhp16NjCY+
         DLwjVFQbLJaKSm723W8VPTRQGR2j/YNYX2u9Hw+RSkGT0hTWIwALO/wKy5t8CXjVXt
         62XnYeo2eWJUwAlmJRYUQkDw84TezHw5aJG7vyp0aN8xaQ9IsgQUCqEU2BlpqqcdFO
         nqrRQRt/W6fb47AINlIjZv8oO9L2qgYrZK4J0AsrxLZFgnIe16Yjkmw8FoDlDBa7xc
         YA7cK/GwzOoeQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rW-lRaCiW0vA; Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4893DBCDC1;
        Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
Date:   Tue, 10 Sep 2019 05:48:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Message-ID: <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <20190908134909.12389-1-mathieu.desnoyers@efficios.com> <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load (v2)
Thread-Index: U08tj4vVS7vLih3Xxyh7ZqZVN5xuZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 8, 2019, at 5:51 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Sun, Sep 8, 2019 at 6:49 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> +static void sync_runqueues_membarrier_state(struct mm_struct *mm)
>> +{
>> +       int membarrier_state = atomic_read(&mm->membarrier_state);
>> +       bool fallback = false;
>> +       cpumask_var_t tmpmask;
>> +
>> +       if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
>> +               /* Fallback for OOM. */
>> +               fallback = true;
>> +       }
>> +
>> +       /*
>> +        * For each cpu runqueue, if the task's mm match @mm, ensure that all
>> +        * @mm's membarrier state set bits are also set in in the runqueue's
>> +        * membarrier state. This ensures that a runqueue scheduling
>> +        * between threads which are users of @mm has its membarrier state
>> +        * updated.
>> +        */
>> +       cpus_read_lock();
>> +       rcu_read_lock();
>> +       for_each_online_cpu(cpu) {
>> +               struct rq *rq = cpu_rq(cpu);
>> +               struct task_struct *p;
>> +
>> +               p = task_rcu_dereference(&rq->curr);
>> +               if (p && p->mm == mm) {
>> +                       if (!fallback)
>> +                               __cpumask_set_cpu(cpu, tmpmask);
>> +                       else
>> +                               smp_call_function_single(cpu, ipi_sync_rq_state,
>> +                                                        mm, 1);
>> +               }
>> +       }
> 
> I really absolutely detest this whole "fallback" code.
> 
> It will never get any real testing, and the code is just broken.
> 
> Why don't you just use the mm_cpumask(mm) unconditionally? Yes, it
> will possibly call too many CPU's, but this fallback code is just
> completely disgusting.
> 
> Do a simple and clean implementation. Then, if you can show real
> performance issues (which I doubt), maybe do something else, but even
> then you should never do something that will effectively create cases
> that have absolutely zero test-coverage.

A few points worth mentioning here:

1) As I stated earlier, using mm_cpumask in its current form is not
   an option for membarrier. For two reasons:

   A) The mask is not populated on all architectures (e.g. arm64 does
      not populate it),

   B) Even if it was populated on all architectures, we would need to
      carefully audit and document every spot where this mm_cpumask
      is set or cleared within each architecture code, and ensure we
      have the required memory barriers between user-space memory
      accesses and those stores, documenting those requirements into
      each architecture code in the process. This seems to be a lot of
      useless error-prone code churn.

2) I should actually use GFP_KERNEL rather than GFP_NOWAIT in this
   membarrier registration code. But it can still fail. However, the other
   membarrier code using the same fallback pattern (private and global
   expedited) documents that those membarrier commands do not block in
   the membarrier(2) man page, so GFP_NOWAIT is appropriate in those cases.

3) Testing-wise, I fully agree with your argument of lacking test coverage.
   One option I'm considering would be to add a selftest based on the
   fault-injection infrastructure, which would ensure that we have coverage
   of the failure case in the kernel selftests.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
