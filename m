Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB613C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lvYT7v7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405661AbfFKTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:33:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:59000 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404808AbfFKTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:33:45 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B2628247C82;
        Tue, 11 Jun 2019 15:33:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 3ktOBi1VoLx0; Tue, 11 Jun 2019 15:33:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 00280247C7B;
        Tue, 11 Jun 2019 15:33:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 00280247C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560281623;
        bh=zJid1e5FXuQtN6uF85qQ39cgoHZ2diUc9sjrg/WPqzw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lvYT7v7wrNnC3o7de4ee+i3xraPaZTxjLAL3v6BSznG7IlMyMRwmjI9/yaZc6keuS
         SB8Cc1213JlwMQEYZ6BBUF7nc/E8UMmwZX3I0BcFFc78+UK4phJsstqNCPtnwjq8B3
         FE6XtyFaLuHxn6tOlqoeeHEmoeceb52MABMIzIbWqsW2NDbXFMoaeLWmmf8xPX917C
         StquAFq9odBLcURDHMbrVvuZ3RQCNMSrx1vH4GCAeTJo1zuhrWn/UAnjScRhEDJZSf
         Lm+v4U3uV/cOgbaLQSRrVHwxZBrNV4kjI9oAQ7V3Y2NUmO2gKeW/DZAI47fuDJ64Kz
         OVSgv0ElPw18A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id jnu1hLnQ0GI8; Tue, 11 Jun 2019 15:33:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D8CE6247C6D;
        Tue, 11 Jun 2019 15:33:42 -0400 (EDT)
Date:   Tue, 11 Jun 2019 15:33:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <1620360283.42036.1560281622707.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190611165755.GG29008@lakrids.cambridge.arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com> <20190611125315.18736-4-raphael.gault@arm.com> <20190611143346.GB28689@kernel.org> <20190611165755.GG29008@lakrids.cambridge.arm.com>
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to
 pmu counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: perf: arm64: Use rseq to test userspace access to pmu counters
Thread-Index: vngIXTjUv63g0EqcvRtU5bPOhNcuFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 11, 2019, at 6:57 PM, Mark Rutland mark.rutland@arm.com wrote:

> Hi Arnaldo,
> 
> On Tue, Jun 11, 2019 at 11:33:46AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jun 11, 2019 at 01:53:11PM +0100, Raphael Gault escreveu:
>> > Add an extra test to check userspace access to pmu hardware counters.
>> > This test doesn't rely on the seqlock as a synchronisation mechanism but
>> > instead uses the restartable sequences to make sure that the thread is
>> > not interrupted when reading the index of the counter and the associated
>> > pmu register.
>> > 
>> > In addition to reading the pmu counters, this test is run several time
>> > in order to measure the ratio of failures:
>> > I ran this test on the Juno development platform, which is big.LITTLE
>> > with 4 Cortex A53 and 2 Cortex A57. The results vary quite a lot
>> > (running it with 100 tests is not so long and I did it several times).
>> > I ran it once with 10000 iterations:
>> > `runs: 10000, abort: 62.53%, zero: 34.93%, success: 2.54%`
>> > 
>> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>> > ---
>> >  tools/perf/arch/arm64/include/arch-tests.h    |   5 +-
>> >  tools/perf/arch/arm64/include/rseq-arm64.h    | 220 ++++++++++++++++++
>> 
>> So, I applied the first patch in this series, but could you please break
>> this patch into at least two, one introducing the facility
>> (include/rseq*) and the second adding the test?
>> 
>> We try to enforce this kind of granularity as down the line we may want
>> to revert one part while the other already has other uses and thus
>> wouldn't allow a straight revert.
>> 
>> Also, can this go to tools/arch/ instead? Is this really perf specific?
>> Isn't there any arch/arm64/include files for the kernel that we could
>> mirror and have it checked for drift in tools/perf/check-headers.sh?
> 
> The rseq bits aren't strictly perf specific, and I think the existing
> bits under tools/testing/selftests/rseq/ could be factored out to common
> locations under tools/include/ and tools/arch/*/include/.

Hi Mark,

Thanks for CCing me!

Or into a stand-alone librseq project:

https://github.com/compudj/librseq (currently a development branch in
my own github)

I don't see why this user-space code should sit in the kernel tree.
It is not tooling-specific.

> 
> From a scan, those already duplicate barriers and other helpers which
> already have definitions under tools/, which seems unfortunate. :/
> 
> Comments below are for Raphael and Matthieu.
> 
> [...]
> 
>> > +static u64 noinline mmap_read_self(void *addr, int cpu)
>> > +{
>> > +	struct perf_event_mmap_page *pc = addr;
>> > +	u32 idx = 0;
>> > +	u64 count = 0;
>> > +
>> > +	asm volatile goto(
>> > +                     RSEQ_ASM_DEFINE_TABLE(0, 1f, 2f, 3f)
>> > +		     "nop\n"
>> > +                     RSEQ_ASM_STORE_RSEQ_CS(1, 0b, rseq_cs)
>> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>> > +                     RSEQ_ASM_OP_R_LOAD(pc_idx)
>> > +                     RSEQ_ASM_OP_R_AND(0xFF)
>> > +		     RSEQ_ASM_OP_R_STORE(idx)
>> > +                     RSEQ_ASM_OP_R_SUB(0x1)
>> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
>> > +                     "msr pmselr_el0, " RSEQ_ASM_TMP_REG "\n"
>> > +                     "isb\n"
>> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)

I really don't understand why the cpu_id needs to be compared 3 times
here (?!?)

Explicit comparison of the cpu_id within the rseq critical section
should be done _once_.

If the kernel happens to preempt and migrate the thread while in the
critical section, it's the kernel's job to move user-space execution
to the abort handler.

>> > +                     "mrs " RSEQ_ASM_TMP_REG ", pmxevcntr_el0\n"
>> > +                     RSEQ_ASM_OP_R_FINAL_STORE(cnt, 2)
>> > +		     "nop\n"
>> > +                     RSEQ_ASM_DEFINE_ABORT(3, abort)
>> > +                     :/* No output operands */
>> > +		     :  [cpu_id] "r" (cpu),
>> > +			[current_cpu_id] "Qo" (__rseq_abi.cpu_id),
>> > +			[rseq_cs] "m" (__rseq_abi.rseq_cs),
>> > +			[cnt] "m" (count),
>> > +			[pc_idx] "r" (&pc->index),
>> > +			[idx] "m" (idx)
>> > +                     :"memory"
>> > +                     :abort
>> > +                    );
> 
> While baroque, this doesn't look as scary as I thought it would!

That's good to hear :)

> 
> However, I'm very scared that this is modifying input operands without
> clobbering them. IIUC this is beacause we're trying to use asm goto,
> which doesn't permit output operands.

This is correct. What is wrong with modifying the target of "m" input
operands in an inline asm that has a "memory" clobber ?

gcc documentation at https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
states:

"An asm goto statement cannot have outputs. This is due to an internal
restriction of the compiler: control transfer instructions cannot have
outputs. If the assembler code does modify anything, use the "memory"
clobber to force the optimizers to flush all register values to memory
and reload them if necessary after the asm statement."

If there is a problem with this approach, an alternative would be to
pass &__rseq_abi.rseq.cs as a "r" input operand, explicitly dereference
it in the assembly, and use the "memory" clobber to ensure the compiler
knows that there are read/write references to memory.

> I'm very dubious to abusing asm goto in this way. Can we instead use a
> regular asm volatile block, and place the abort handler _within_ the
> asm? If performance is a concern, we can use .pushsection and
> .popsection to move that far away...

Let's dig into what would be needed in order to move the abort into the
asm block.

One approach would be to make that asm block return a nonzero value in
an output register, and put zero in that register in the non-abort case,
and then have a conditional check in C on that register to check
whether it needs to branch to the abort. This adds overhead we want
to avoid.

Another alternative would be to perform the entire abort handler in
the same assembly block as the rseq critical section. However, this
prevents us from going back to C to handle the abort, which is unwanted.
For instance, in the use-case of perf counters on aarch64, a good
fallback on abort would be to call the perf system call to read the
value of the performance counter. However, requiring that the abort be
implemented within the rseq assembly block would require that we
re-implement system call invocation in user-space for this, which
is rather annoying.

> 
>> > +
>> > +	if (idx)
>> > +		count += READ_ONCE(pc->offset);
> 
> I'm rather scared that from GCC's PoV, idx was initialized to zero, and
> not modified above (per the asm constraints). I realise that we've used
> an "m" constraint and clobbered memory, but I could well imagine that
> GCC can interpret that as needing to place a read-only copy in memory,
> but still being permitted to use the original value in a register. That
> would permit the above to be optimized away, since GCC knows no
> registers were clobbered, and thus idx must still be zero.

I suspect this is based on a rather conservative interpretation of the
following statement from https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html:

"The "memory" clobber tells the compiler that the assembly code performs memory
reads or writes to items other than those listed in the input and output operands"

Based on the previous sentence, it's tempting to conclude that the "m" input
operands content is not clobbered by the "memory" clobber.

however, it is followed by this:

"Further, the compiler does not assume that any values read from memory before an
asm remain unchanged after that asm; it reloads them as needed. Using the "memory"
clobber effectively forms a read/write memory barrier for the compiler."

Based on this last sentence, my understanding is that a "memory" clobber would
also clobber the content of any "m" operand.

If use of "m" (var) input-operand-as-output + "memory" clobber ends up being an
issue, we can always fall-back to "r" (&var) input operand + "memory" clobber,
which seems less ambiguous from a documentation standpoint.

I'd really like to have an authoritative answer from gcc folks before we start
changing this in all rseq asm for all architectures.

> 
>> > +
>> > +	return count;
> 
> ... and for similar reasons, always return zero here.
> 
>> > +abort:
>> > +        pr_debug("Abort handler\n");
>> > +        exit(-2);
>> > +}
> 
> Given the necessary complexity evident above, I'm also fearful that the
> sort of folk that want userspace counter access aren't going to bother
> with the above.

The abort handler should be implemented in C, simply invoking the perf
system call which lets the kernel perform the perf counter read.

Thanks,

Mathieu


> 
> Thanks,
> Mark.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
