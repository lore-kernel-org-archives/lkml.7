Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2FD207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QTb4ducN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbfIFAve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:51:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:55250 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390794AbfIFAvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:51:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5416432C7D1;
        Thu,  5 Sep 2019 20:51:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id aKnMaAaamc9x; Thu,  5 Sep 2019 20:51:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CA60D32C7CE;
        Thu,  5 Sep 2019 20:51:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CA60D32C7CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567731091;
        bh=4avMchy2H6M2dh3qUpVReLXsndrsxB7wu+tz4cO9dcw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QTb4ducNNd/8yHcmsvscs7QNhysC1vYyGPf5SgObu6H4ZO1cR6hkuxKVswdoA6QWz
         OnfxS5DwoB2AnUjMkslsP6AwUWcwGhQCXO/HbSDCtijURIYWMmelykJhIxo2vDA6s3
         KtKLMcesFCf1m93VbvcVtAQ0HSEPcjy8TDdfMxm9auKXgFH8tHzHsTnf7tY+IXPuYn
         jizSLUaZruZbayrTJK3EwzaOckHgIHcfrgdzSUsMt0fFxYa7u/5TKhehwXENKqpN9G
         xxJyCt3ZVzydV0L5qa5q1bNtmhU2YX9+u92L1r6Go1FY152gZNp4QW8IpRLOP/1GCX
         vaxHd51e5vm4w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id j4EWsVNB08Wi; Thu,  5 Sep 2019 20:51:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AE59632C7C2;
        Thu,  5 Sep 2019 20:51:31 -0400 (EDT)
Date:   Thu, 5 Sep 2019 20:51:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck <paulmck@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1713923102.3325.1567731091553.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904182607.GG17205@worktop.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net> <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com> <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com> <20190904160953.GU2332@hirez.programming.kicks-ass.net> <1825272223.1740.1567617173011.JavaMail.zimbra@efficios.com> <20190904182607.GG17205@worktop.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: JBSNbl1z+P6IVHXWCzU+dev6Y364Kw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 2:26 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Sep 04, 2019 at 01:12:53PM -0400, Mathieu Desnoyers wrote:
>> ----- On Sep 4, 2019, at 12:09 PM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Wed, Sep 04, 2019 at 11:19:00AM -0400, Mathieu Desnoyers wrote:
>> >> ----- On Sep 3, 2019, at 4:36 PM, Linus Torvalds torvalds@linux-foundation.org
>> >> wrote:
>> > 
>> >> > I wonder if the easiest model might be to just use a percpu variable
>> >> > instead for the membarrier stuff? It's not like it has to be in
>> >> > 'struct task_struct' at all, I think. We only care about the current
>> >> > runqueues, and those are percpu anyway.
>> >> 
>> >> One issue here is that membarrier iterates over all runqueues without
>> >> grabbing any runqueue lock. If we copy that state from mm to rq on
>> >> sched switch prepare, we would need to ensure we have the proper
>> >> memory barriers between:
>> >> 
>> >> prior user-space memory accesses  /  setting the runqueue membarrier state
>> >> 
>> >> and
>> >> 
>> >> setting the runqueue membarrier state / following user-space memory accesses
>> >> 
>> >> Copying the membarrier state into the task struct leverages the fact that
>> >> we have documented and guaranteed those barriers around the rq->curr update
>> >> in the scheduler.
>> > 
>> > Should be the same as the barriers we already rely on for rq->curr, no?
>> > That is, if we put this before switch_mm() then we have
>> > smp_mb__after_spinlock() and switch_mm() itself.
>> 
>> Yes, I think we can piggy-back on the already documented barriers documented
>> around
>> rq->curr store.
>> 
>> > Also, if we place mm->membarrier_state in the same cacheline as mm->pgd
>> > (which switch_mm() is bound to load) then we should be fine, I think.
>> 
>> Yes, if we make sure membarrier_prepare_task_switch only updates the
>> rq->membarrier_state if prev->mm != next->mm, we should be able to avoid
>> loading next->mm->membarrier_state when switch_mm() is not invoked.
>> 
>> I'll prepare RFC patch implementing this approach.
> 
> Thinking about this a bit; switching it 'on' still requires some
> thinking. Consider register on an already threaded process of which
> multiple threads are 'current' on multiple CPUs. In that case none of
> the rq bits will be set.
> 
> Not even synchronize_rcu() is sufficient to force it either, since we
> only update on switch_mm() and nothing guarantees we pass that.
> 
> One possible approach would be to IPI broadcast (after setting the
> ->mm->membarrier_State) and having the IPI update the rq state from
> 'current->mm'.
> 
> But possible I'm just confusing evryone again. I'm not having a good day
> today.

Indeed, switching 'on' requires some care. I implemented the IPI-based
approach as per your suggestion,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
