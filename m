Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254ED215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392305AbfFMQhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:37:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbfFMHKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:10:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467C228;
        Thu, 13 Jun 2019 00:10:48 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8973F73C;
        Thu, 13 Jun 2019 00:10:46 -0700 (PDT)
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to pmu
 counters
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-4-raphael.gault@arm.com>
 <20190611143346.GB28689@kernel.org>
 <20190611165755.GG29008@lakrids.cambridge.arm.com>
 <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <a99c41fb-40f6-a0e2-af6b-22d7e6ac9b3d@arm.com>
Date:   Thu, 13 Jun 2019 08:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/11/19 8:33 PM, Mathieu Desnoyers wrote:
> ----- On Jun 11, 2019, at 6:57 PM, Mark Rutland mark.rutland@arm.com wrote:
> 
>> Hi Arnaldo,
>>
>> On Tue, Jun 11, 2019 at 11:33:46AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jun 11, 2019 at 01:53:11PM +0100, Raphael Gault escreveu:
>>>> Add an extra test to check userspace access to pmu hardware counters.
>>>> This test doesn't rely on the seqlock as a synchronisation mechanism but
>>>> instead uses the restartable sequences to make sure that the thread is
>>>> not interrupted when reading the index of the counter and the associated
>>>> pmu register.
>>>>
>>>> In addition to reading the pmu counters, this test is run several time
>>>> in order to measure the ratio of failures:
>>>> I ran this test on the Juno development platform, which is big.LITTLE
>>>> with 4 Cortex A53 and 2 Cortex A57. The results vary quite a lot
>>>> (running it with 100 tests is not so long and I did it several times).
>>>> I ran it once with 10000 iterations:
>>>> `runs: 10000, abort: 62.53%, zero: 34.93%, success: 2.54%`
>>>>
>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>>>> ---
>>>>   tools/perf/arch/arm64/include/arch-tests.h    |   5 +-
>>>>   tools/perf/arch/arm64/include/rseq-arm64.h    | 220 ++++++++++++++++++
>>>
>>> So, I applied the first patch in this series, but could you please break
>>> this patch into at least two, one introducing the facility
>>> (include/rseq*) and the second adding the test?
>>>
>>> We try to enforce this kind of granularity as down the line we may want
>>> to revert one part while the other already has other uses and thus
>>> wouldn't allow a straight revert.
>>>
>>> Also, can this go to tools/arch/ instead? Is this really perf specific?
>>> Isn't there any arch/arm64/include files for the kernel that we could
>>> mirror and have it checked for drift in tools/perf/check-headers.sh?
>>
>> The rseq bits aren't strictly perf specific, and I think the existing
>> bits under tools/testing/selftests/rseq/ could be factored out to common
>> locations under tools/include/ and tools/arch/*/include/.
> 
> Hi Mark,
> 
> Thanks for CCing me!
> 
> Or into a stand-alone librseq project:
> 
> https://github.com/compudj/librseq (currently a development branch in
> my own github)
> 
> I don't see why this user-space code should sit in the kernel tree.
> It is not tooling-specific.
> 
>>
>>  From a scan, those already duplicate barriers and other helpers which
>> already have definitions under tools/, which seems unfortunate. :/
>>
>> Comments below are for Raphael and Matthieu.
>>
>> [...]
>>
>>>> +static u64 noinline mmap_read_self(void *addr, int cpu)
>>>> +{
>>>> +	struct perf_event_mmap_page *pc = addr;
>>>> +	u32 idx = 0;
>>>> +	u64 count = 0;
>>>> +
>>>> +	asm volatile goto(
>>>> +                     RSEQ_ASM_DEFINE_TABLE(0, 1f, 2f, 3f)
>>>> +		     "nop\n"
>>>> +                     RSEQ_ASM_STORE_RSEQ_CS(1, 0b, rseq_cs)
>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>>>> +                     RSEQ_ASM_OP_R_LOAD(pc_idx)
>>>> +                     RSEQ_ASM_OP_R_AND(0xFF)
>>>> +		     RSEQ_ASM_OP_R_STORE(idx)
>>>> +                     RSEQ_ASM_OP_R_SUB(0x1)
>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>>>> +                     "msr pmselr_el0, " RSEQ_ASM_TMP_REG "\n"
>>>> +                     "isb\n"
>>>> +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
> 
> I really don't understand why the cpu_id needs to be compared 3 times
> here (?!?)
> 
> Explicit comparison of the cpu_id within the rseq critical section
> should be done _once_.
> 

I understand and that's what I thought as well but I got confused with a 
comment in (src)/include/uapi/linux/rseq.h which states:
 > This CPU number value should always be compared
 > against the value of the cpu_id field before performing a rseq
 > commit or returning a value read from a data structure indexed
 > using the cpu_id_start value.

I'll remove the unnecessary testing.


> If the kernel happens to preempt and migrate the thread while in the
> critical section, it's the kernel's job to move user-space execution
> to the abort handler.
> 
[...]

Thanks,

-- 
Raphael Gault
