Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dL4buwRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfIDPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:24:33 -0400
Received: from mail.efficios.com ([167.114.142.138]:55938 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfIDPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:24:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A3FFD258BAD;
        Wed,  4 Sep 2019 11:24:31 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fohZMjaMnQs7; Wed,  4 Sep 2019 11:24:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2BF92258BA6;
        Wed,  4 Sep 2019 11:24:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2BF92258BA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567610671;
        bh=3WFBOIY5OY0F8CXaDaPYAsIAbuxngZe+uKvWxfu8yyU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dL4buwRahr/z52XgCkKSL4c30CrHsqZ0hevp+S4exCXG7QMd3hxLmcAQ1QdpezhyE
         1IVgD6/kFNsAFLx3nfoGZCSSrY+TWuHell0XCqo5CjLlTxKoP8Tv8qDk8/p5F2c8Y2
         bMmPHtU1wd9w5aHxifUcaLxlxZAiV84juYnuBBBFLjzuoAw4RDWCir+YeMKtdrD0tn
         peKZSiIKproXzPvvmB0lJwejwCnyBMf/RhzRrtB2rOkuwLlZaJxiN7zIyYS8b4nPxB
         OgrvZffx0WCwPnPAWm0DJvw3Xy0vhw4PiAwrUMc0BdkxaJpPOjQnrwsoG3OcwmHAlf
         touCk1GCfkgVw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id aR87kcbAbHsl; Wed,  4 Sep 2019 11:24:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 12791258B9C;
        Wed,  4 Sep 2019 11:24:31 -0400 (EDT)
Date:   Wed, 4 Sep 2019 11:24:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <88198910.1581.1567610670849.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904105348.GA24568@redhat.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190904105348.GA24568@redhat.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: OXzKmCka+fo6nDQ/Ff7nKHY3OCg6wQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 6:53 AM, Oleg Nesterov oleg@redhat.com wrote:

> On 09/03, Mathieu Desnoyers wrote:
>>
>> @@ -1130,6 +1130,10 @@ struct task_struct {
>>  	unsigned long			numa_pages_migrated;
>>  #endif /* CONFIG_NUMA_BALANCING */
>>
>> +#ifdef CONFIG_MEMBARRIER
>> +	atomic_t membarrier_state;
>> +#endif
> 
> ...
> 
>> +static inline void membarrier_prepare_task_switch(struct task_struct *t)
>> +{
>> +	if (!t->mm)
>> +		return;
>> +	atomic_set(&t->membarrier_state,
>> +		   atomic_read(&t->mm->membarrier_state));
>> +}
> 
> Why not
> 
>	rq->membarrier_state = next->mm ? t->mm->membarrier_state : 0;
> 
> and
> 
>	if (cpu_rq(cpu)->membarrier_state & MEMBARRIER_STATE_GLOBAL_EXPEDITED) {
>		...
>	}
> 
> in membarrier_global_expedited() ? (I removed atomic_ to simplify)
> 
> IOW, why this new member has to live in task_struct, not in rq?

As replied to Linus, if we copy the membarrier_state into the rq, we'd need
to ensure we have full memory barriers between:

prior user-space memory accesses  /  setting the runqueue membarrier state

and

setting the runqueue membarrier state / following user-space memory accesses

Because membarrier does not take any runqueue lock when it iterates over
runqueues.

I try to avoid putting too much memory barrier constraints on the scheduler
for membarrier, but if it's really the way forward it could be done.

And the basic question remains: it is acceptable performance-wise to load
mm->membarrier_state from sched switch prepare ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
