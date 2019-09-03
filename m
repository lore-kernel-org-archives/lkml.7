Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E97207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QAGZVubg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfICUlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:41:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:48680 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICUlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:41:49 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 56F032B2FED;
        Tue,  3 Sep 2019 16:41:48 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id YGe_ofTvY5TO; Tue,  3 Sep 2019 16:41:48 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E3F942B2FE8;
        Tue,  3 Sep 2019 16:41:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3F942B2FE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567543307;
        bh=kzbhdxL6p5DVUn//4xlV8bUJLkFCNwDgZOU5rVYtjZo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QAGZVubgcPGJTtBDr1bZtaI93DEcxBG552w5ddI7wME23neccf4IK82x+KTg2V5GK
         qxI/CbcmcauVtv1odvRNG1/k8DZanCIOGey/OKJR4S2s/1GFUTRhQQ5U74Nc65pq+Z
         tRB6ZGHVoqHgkEtq5w66456VfFXf+nKYulNt4HSFb5NfcyiCQyCypEjb5swSbWWDjL
         XJ2MI/13Ety0vpqOJk9F4Z0nLOztTTrW0wFZI5T20h1RijonD6defKy4eNEZt2Dur+
         w292u1muSB65YX/7d5ysT44X0BAYId6pymLNcn0waVJkFgX7MzZjebyNQnTd/1zuFj
         3shykfPVFauEw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id f_nSfkUuR3DT; Tue,  3 Sep 2019 16:41:47 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C94F62B2FDA;
        Tue,  3 Sep 2019 16:41:47 -0400 (EDT)
Date:   Tue, 3 Sep 2019 16:41:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190903202434.GX2349@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: VxBHx0Ijjv+FZdN+7ID1WvH9d1Li7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 4:24 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Sep 03, 2019 at 04:11:34PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 9f51932bd543..e24d52a4c37a 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1130,6 +1130,10 @@ struct task_struct {
>>  	unsigned long			numa_pages_migrated;
>>  #endif /* CONFIG_NUMA_BALANCING */
>>  
>> +#ifdef CONFIG_MEMBARRIER
>> +	atomic_t membarrier_state;
>> +#endif
>> +
>>  #ifdef CONFIG_RSEQ
>>  	struct rseq __user *rseq;
>>  	u32 rseq_sig;
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 4a7944078cc3..3577cd7b3dbb 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -371,7 +371,17 @@ static inline void
>> membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>>  static inline void membarrier_execve(struct task_struct *t)
>>  {
>>  	atomic_set(&t->mm->membarrier_state, 0);
>> +	atomic_set(&t->membarrier_state, 0);
>>  }
>> +
>> +static inline void membarrier_prepare_task_switch(struct task_struct *t)
>> +{
>> +	if (!t->mm)
>> +		return;
>> +	atomic_set(&t->membarrier_state,
>> +		   atomic_read(&t->mm->membarrier_state));
>> +}
>> +
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 010d578118d6..8d4f1f20db15 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3038,6 +3038,7 @@ prepare_task_switch(struct rq *rq, struct task_struct
>> *prev,
>>  	perf_event_task_sched_out(prev, next);
>>  	rseq_preempt(prev);
>>  	fire_sched_out_preempt_notifiers(prev, next);
>> +	membarrier_prepare_task_switch(next);
>>  	prepare_task(next);
>>  	prepare_arch_switch(next);
>>  }
> 
> 
> Yuck yuck yuck..
> 
> so the problem I have with this is that we add yet another cacheline :/
> 
> Why can't we frob this state into a line/word we already have to
> unconditionally touch, like the thread_info::flags word for example.
> 
> The above also does the store unconditionally, even though, in the most
> common case, it won't have to.

This approach would require to reserve TIF flags in each supported
architecture, which I would like to avoid if possible.

As discussed on IRC, one alternative for the multi-threaded case would
be to grab the task list lock and iterate over all existing tasks to
set the bit, so we don't have to touch an extra cache line from the
scheduler.

In order to keep the speed of the common single-threaded library
constructor common case fast, we simply set the bit in the current
task struct, and rely on clone() propagating the flag to children
threads (which it already does).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
