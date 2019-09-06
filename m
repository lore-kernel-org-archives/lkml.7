Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA798C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E9620650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XCzFbHpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405190AbfIFNkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:40:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:44372 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfIFNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:40:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 13BAA32CB4E;
        Fri,  6 Sep 2019 09:40:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7WK2DKSDYcCb; Fri,  6 Sep 2019 09:40:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 58E0432CB42;
        Fri,  6 Sep 2019 09:40:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 58E0432CB42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567777212;
        bh=cOklc/wlc2Zt3t/dQOFT+ZVQWzMiNI+f0pSUsOGaZjU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XCzFbHpd3+YKhdIf4ZZHJ59KXv8LgmWVZs927/d4OcK+F7s7H3GLkt0cFshxVyCx/
         02cQQt7oMtDNPs7I2Ay3nz5Hv3P1qjz0bRKylqZSPKozrMz3VNuZQi7p7OSIFN3FoO
         ClK+oWQtPb1j758WkdS9Y+wIGrLqrOeoCjMPy3u3+7HpjlrHLwNSPTF7SzDjyPcPQq
         St0kGQaKq45EdtlUMHTAKzrpbHFOF3GXqcPqNenQns7QAyy4y0f3Sip//oHdP1+y+X
         FlaYVf6xVmiFom92a9CaU1STmlV22P0y7vRi3vfn/2/x75zu9/WDqFewNvWQeimt3V
         072ZXIttaw2iA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id k0AAjCXxSK0k; Fri,  6 Sep 2019 09:40:12 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3F18932CB37;
        Fri,  6 Sep 2019 09:40:12 -0400 (EDT)
Date:   Fri, 6 Sep 2019 09:40:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1557294001.259.1567777212084.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190906074104.GT2349@hirez.programming.kicks-ass.net>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com> <20190906031300.1647-4-mathieu.desnoyers@efficios.com> <20190906074104.GT2349@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 3/4] Cleanup: sched/membarrier: only sync_core
 before usermode for same mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: Cleanup: sched/membarrier: only sync_core before usermode for same mm
Thread-Index: 37L7M3woYcZLc81zOthf22X9Bd8mmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 6, 2019, at 3:41 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Sep 05, 2019 at 11:12:59PM -0400, Mathieu Desnoyers wrote:
>> When the prev and next task's mm change, switch_mm() provides the core
>> serializing guarantees before returning to usermode. The only case
>> where an explicit core serialization is needed is when the scheduler
>> keeps the same mm for prev and next.
>> 
>> Suggested-by: Oleg Nesterov <oleg@redhat.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
>> Cc: Chris Metcalf <cmetcalf@ezchip.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Kirill Tkhai <tkhai@yandex.ru>
>> Cc: Mike Galbraith <efault@gmx.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> ---
>>  include/linux/sched/mm.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 4a7944078cc3..8557ec664213 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -362,6 +362,8 @@ enum {
>>  
>>  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>>  {
>> +	if (current->mm != mm)
>> +		return;
>>  	if (likely(!(atomic_read(&mm->membarrier_state) &
>>  		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
>>  		return;
> 
> So SYNC_CORE is about I$ coherency and funny thing like that. Now it
> seems 'natural' that if we flip the address space, that I$ also gets
> wiped/updated, because the whole text mapping changes.
> 
> But did we just assume that, or did we verify the truth of this? (I'm
> just being paranoid here)

We have documented those here:

Documentation/features/sched/membarrier-sync-core/arch-support.txt

For instance, x86:

# * x86
#
# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
# instruction is core serializing, but not SYSEXIT.
#
# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
# However, it can return to user-space through either SYSRETL (compat code),
# SYSRETQ, or IRET.
#
# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
# instead on write_cr3() performed by switch_mm() to provide core serialization
# after changing the current mm, and deal with the special case of kthread ->
# uthread (temporarily keeping current mm into active_mm) by issuing a
# sync_core_before_usermode() in that specific case.

I've also made sure x86 switch_mm_irqs_off() has the following comment,
just in case someone too keen on optimizing away the CR3 write would
forget to look at arch-support.txt:

        /*
         * The membarrier system call requires a full memory barrier and
         * core serialization before returning to user-space, after
         * storing to rq->curr. Writing to CR3 provides that full
         * memory barrier and core serializing instruction.
         */

In the case of arm/arm64, they have no requirement on switch_mm():

# * arm/arm64
#
# Rely on implicit context synchronization as a result of exception return
# when returning from IPI handler, and when returning to user-space.


Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
