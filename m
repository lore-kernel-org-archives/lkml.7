Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C9B22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ajfsuYuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfIDP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:26:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:56682 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbfIDP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:26:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2861E258C72;
        Wed,  4 Sep 2019 11:26:37 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 8YMrWUp8pidr; Wed,  4 Sep 2019 11:26:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D49E2258C6F;
        Wed,  4 Sep 2019 11:26:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D49E2258C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567610796;
        bh=ipF+cupzpcUTZQEf1zfVw1M/5Bb8iGWnXTFm2sJdi1Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ajfsuYuJFxom3ndHZBpbmr87NyxkT1E6r4DtSKWnNdLyCt+sdgc1++7mkYKwtNLQk
         CTO8DcdFdtSoov04Dvc0tbYxPSfPPV57i2cCElyl+F8BSh2IcC8lGl1L1N80MR42JB
         ekZt/yEorwCBaxPZd7qkj/QkmfFmdkQF0SptH3GywDvmCnuFc1OJfGGFFLH3CxO1Oi
         /I9aDUNUoHBsp6HVTLMtnnZGI3+M07EAbZAvqaRAwC+WghQgT/xRHIALNf/xtmlxTD
         VItnHnGVwzEVzeu+FFTZEESiiFW3DeNkNR9fXpsOvIIIZ51fZjVcwdFrvXBgZyio8B
         /dwY9y3elQ69Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id joHJIJvovErq; Wed,  4 Sep 2019 11:26:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BA64A258C61;
        Wed,  4 Sep 2019 11:26:36 -0400 (EDT)
Date:   Wed, 4 Sep 2019 11:26:36 -0400 (EDT)
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
Message-ID: <1969212687.1583.1567610796694.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904114929.GV2386@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net> <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com> <20190904112819.GD2349@hirez.programming.kicks-ass.net> <20190904114929.GV2386@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: KwTFxAJ++SW2b+NxMfVdwoF20Sn2Kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 7:49 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Sep 04, 2019 at 01:28:19PM +0200, Peter Zijlstra wrote:
>> @@ -196,6 +198,17 @@ static int membarrier_register_global_expedited(void)
>>  		 */
>>  		smp_mb();
>>  	} else {
>> +		struct task_struct *g, *t;
>> +
>> +		read_lock(&tasklist_lock);
>> +		do_each_thread(g, t) {
>> +			if (t->mm == mm) {
>> +				atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED,
>> +					  &t->membarrier_state);
>> +			}
>> +		} while_each_thread(g, t);
>> +		read_unlock(&tasklist_lock);
>> +
>>  		/*
>>  		 * For multi-mm user threads, we need to ensure all
>>  		 * future scheduler executions will observe the new
> 
> Arguably, because this is exposed to unpriv users and a potential
> preemption latency issue, we could do it in 3 passes:
> 
>	- RCU, mark all found lacking, count
>	- RCU, mark all found lacking, count
>	- if count of last pass, tasklist_lock
> 
> That way, it becomes much harder to trigger the bad case.
> 
> Do we worry about that?

Allowing unprivileged processes to iterate over all processes/threads
with the tasklist lock held is something I try to avoid.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
