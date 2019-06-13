Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7F20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RN6yQ/nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392580AbfFMQbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:44030 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbfFMI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:27:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CB8B62489B9;
        Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id QHJmLqleYeRS; Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 484792489B3;
        Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 484792489B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560414476;
        bh=DKUdPP8QewPcULFHQ4nNVUH6OyOARFLzUileql0AfD4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RN6yQ/nRSeXb+h+A6bJAgudOIpsM4HOtI50An+x6EKgJr+9dVyIV9hEp5vJ0VXiwf
         fZpgMAMgKKHzkVsVy8AcdE61opOS0vnwgZjhh9b344RQnmNE3s2sdvaGJKPpZZlBLk
         2PKI0KwbZIQbmIe9vezfiPODrlV/T8k0KWNk1jL4FhURJAhRWl7rsq7Coiq4m0giSS
         U047pKX1xNgT28cX6gPNFCQvEdtl256QaypkbIfXnhlY5O4hQy19Fqdvvgcx6nqkoQ
         7TMwj8kNxjejvWFczXW0SSyT6cYTCidPH0cdBCRFlxAaLye0x7QbJiaOA7HKeP1bep
         aUeWnNOBSs/Jw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id g8HEodOTGNtd; Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2A60A2489A5;
        Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
Date:   Thu, 13 Jun 2019 04:27:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <1209580932.46461.1560414476136.JavaMail.zimbra@efficios.com>
In-Reply-To: <a99c41fb-40f6-a0e2-af6b-22d7e6ac9b3d@arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com> <20190611125315.18736-4-raphael.gault@arm.com> <20190611143346.GB28689@kernel.org> <20190611165755.GG29008@lakrids.cambridge.arm.com> <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com> <a99c41fb-40f6-a0e2-af6b-22d7e6ac9b3d@arm.com>
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to
 pmu counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: perf: arm64: Use rseq to test userspace access to pmu counters
Thread-Index: 9ubg2q5ItojJmCg9sl7e6XSnaMmSwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 13, 2019, at 9:10 AM, Raphael Gault raphael.gault@arm.com wrote:

> Hi Mathieu,
> 
> On 6/11/19 8:33 PM, Mathieu Desnoyers wrote:
>> ----- On Jun 11, 2019, at 6:57 PM, Mark Rutland mark.rutland@arm.com wrote:
>> 
>>> Hi Arnaldo,
>>>
>>> On Tue, Jun 11, 2019 at 11:33:46AM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Em Tue, Jun 11, 2019 at 01:53:11PM +0100, Raphael Gault escreveu:
>>>>> Add an extra test to check userspace access to pmu hardware counters.
>>>>> This test doesn't rely on the seqlock as a synchronisation mechanism but
>>>>> instead uses the restartable sequences to make sure that the thread is
>>>>> not interrupted when reading the index of the counter and the associated
>>>>> pmu register.
>>>>>
>>>>> In addition to reading the pmu counters, this test is run several time
>>>>> in order to measure the ratio of failures:
>>>>> I ran this test on the Juno development platform, which is big.LITTLE
>>>>> with 4 Cortex A53 and 2 Cortex A57. The results vary quite a lot
>>>>> (running it with 100 tests is not so long and I did it several times).
>>>>> I ran it once with 10000 iterations:
>>>>> `runs: 10000, abort: 62.53%, zero: 34.93%, success: 2.54%`
>>>>>
>>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>>>>> ---
>>>>>   tools/perf/arch/arm64/include/arch-tests.h    |   5 +-
>>>>>   tools/perf/arch/arm64/include/rseq-arm64.h    | 220 ++++++++++++++++++
>>>>
>>>> So, I applied the first patch in this series, but could you please break
>>>> this patch into at least two, one introducing the facility
>>>> (include/rseq*) and the second adding the test?
>>>>
>>>> We try to enforce this kind of granularity as down the line we may want
>>>> to revert one part while the other already has other uses and thus
>>>> wouldn't allow a straight revert.
>>>>
>>>> Also, can this go to tools/arch/ instead? Is this really perf specific?
>>>> Isn't there any arch/arm64/include files for the kernel that we could
>>>> mirror and have it checked for drift in tools/perf/check-headers.sh?
>>>
>>> The rseq bits aren't strictly perf specific, and I think the existing
>>> bits under tools/testing/selftests/rseq/ could be factored out to common
>>> locations under tools/include/ and tools/arch/*/include/.
>> 
>> Hi Mark,
>> 
>> Thanks for CCing me!
>> 
>> Or into a stand-alone librseq project:
>> 
>> https://github.com/compudj/librseq (currently a development branch in
>> my own github)
>> 
>> I don't see why this user-space code should sit in the kernel tree.
>> It is not tooling-specific.
>> 
>>>
>>>  From a scan, those already duplicate barriers and other helpers which
>>> already have definitions under tools/, which seems unfortunate. :/
>>>
>>> Comments below are for Raphael and Matthieu.
>>>
>>> [...]
>>>
>>>>> +static u64 noinline mmap_read_self(void *addr, int cpu)
>>>>> +{
>>>>> +	struct perf_event_mmap_page *pc = addr;
>>>>> +	u32 idx = 0;
>>>>> +	u64 count = 0;
>>>>> +
>>>>> +	asm volatile goto(
>>>>> +                     RSEQ_ASM_DEFINE_TABLE(0, 1f, 2f, 3f)
>>>>> +		     "nop\n"
>>>>> +                     RSEQ_ASM_STORE_RSEQ_CS(1, 0b, rseq_cs)
>>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>>>>> +                     RSEQ_ASM_OP_R_LOAD(pc_idx)
>>>>> +                     RSEQ_ASM_OP_R_AND(0xFF)
>>>>> +		     RSEQ_ASM_OP_R_STORE(idx)
>>>>> +                     RSEQ_ASM_OP_R_SUB(0x1)
>>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>>>>> +                     "msr pmselr_el0, " RSEQ_ASM_TMP_REG "\n"
>>>>> +                     "isb\n"
>>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>> 
>> I really don't understand why the cpu_id needs to be compared 3 times
>> here (?!?)
>> 
>> Explicit comparison of the cpu_id within the rseq critical section
>> should be done _once_.
>> 
> 
> I understand and that's what I thought as well but I got confused with a
> comment in (src)/include/uapi/linux/rseq.h which states:
> > This CPU number value should always be compared
> > against the value of the cpu_id field before performing a rseq
> > commit or returning a value read from a data structure indexed
> > using the cpu_id_start value.
> 
> I'll remove the unnecessary testing.

It needs to be compared at least once, yes. But once is enough.

Thanks,

Mathieu

> 
> 
>> If the kernel happens to preempt and migrate the thread while in the
>> critical section, it's the kernel's job to move user-space execution
>> to the abort handler.
>> 
> [...]
> 
> Thanks,
> 
> --
> Raphael Gault

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
