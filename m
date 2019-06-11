Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FAC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18AC2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405631AbfFKQ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405593AbfFKQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74754337;
        Tue, 11 Jun 2019 09:57:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3880B3F73C;
        Tue, 11 Jun 2019 09:57:58 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:57:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to
 pmu counters
Message-ID: <20190611165755.GG29008@lakrids.cambridge.arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-4-raphael.gault@arm.com>
 <20190611143346.GB28689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611143346.GB28689@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 11, 2019 at 11:33:46AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 11, 2019 at 01:53:11PM +0100, Raphael Gault escreveu:
> > Add an extra test to check userspace access to pmu hardware counters.
> > This test doesn't rely on the seqlock as a synchronisation mechanism but
> > instead uses the restartable sequences to make sure that the thread is
> > not interrupted when reading the index of the counter and the associated
> > pmu register.
> > 
> > In addition to reading the pmu counters, this test is run several time
> > in order to measure the ratio of failures:
> > I ran this test on the Juno development platform, which is big.LITTLE
> > with 4 Cortex A53 and 2 Cortex A57. The results vary quite a lot
> > (running it with 100 tests is not so long and I did it several times).
> > I ran it once with 10000 iterations:
> > `runs: 10000, abort: 62.53%, zero: 34.93%, success: 2.54%`
> > 
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > ---
> >  tools/perf/arch/arm64/include/arch-tests.h    |   5 +-
> >  tools/perf/arch/arm64/include/rseq-arm64.h    | 220 ++++++++++++++++++
> 
> So, I applied the first patch in this series, but could you please break
> this patch into at least two, one introducing the facility
> (include/rseq*) and the second adding the test?
> 
> We try to enforce this kind of granularity as down the line we may want
> to revert one part while the other already has other uses and thus
> wouldn't allow a straight revert.
> 
> Also, can this go to tools/arch/ instead? Is this really perf specific?
> Isn't there any arch/arm64/include files for the kernel that we could
> mirror and have it checked for drift in tools/perf/check-headers.sh?

The rseq bits aren't strictly perf specific, and I think the existing
bits under tools/testing/selftests/rseq/ could be factored out to common
locations under tools/include/ and tools/arch/*/include/.

From a scan, those already duplicate barriers and other helpers which
already have definitions under tools/, which seems unfortunate. :/

Comments below are for Raphael and Matthieu.

[...]

> > +static u64 noinline mmap_read_self(void *addr, int cpu)
> > +{
> > +	struct perf_event_mmap_page *pc = addr;
> > +	u32 idx = 0;
> > +	u64 count = 0;
> > +
> > +	asm volatile goto(
> > +                     RSEQ_ASM_DEFINE_TABLE(0, 1f, 2f, 3f)
> > +		     "nop\n"
> > +                     RSEQ_ASM_STORE_RSEQ_CS(1, 0b, rseq_cs)
> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
> > +                     RSEQ_ASM_OP_R_LOAD(pc_idx)
> > +                     RSEQ_ASM_OP_R_AND(0xFF)
> > +		     RSEQ_ASM_OP_R_STORE(idx)
> > +                     RSEQ_ASM_OP_R_SUB(0x1)
> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
> > +                     "msr pmselr_el0, " RSEQ_ASM_TMP_REG "\n"
> > +                     "isb\n"
> > +		     RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 3f)
> > +                     "mrs " RSEQ_ASM_TMP_REG ", pmxevcntr_el0\n"
> > +                     RSEQ_ASM_OP_R_FINAL_STORE(cnt, 2)
> > +		     "nop\n"
> > +                     RSEQ_ASM_DEFINE_ABORT(3, abort)
> > +                     :/* No output operands */
> > +		     :  [cpu_id] "r" (cpu),
> > +			[current_cpu_id] "Qo" (__rseq_abi.cpu_id),
> > +			[rseq_cs] "m" (__rseq_abi.rseq_cs),
> > +			[cnt] "m" (count),
> > +			[pc_idx] "r" (&pc->index),
> > +			[idx] "m" (idx)
> > +                     :"memory"
> > +                     :abort
> > +                    );

While baroque, this doesn't look as scary as I thought it would!

However, I'm very scared that this is modifying input operands without
clobbering them. IIUC this is beacause we're trying to use asm goto,
which doesn't permit output operands.

I'm very dubious to abusing asm goto in this way. Can we instead use a
regular asm volatile block, and place the abort handler _within_ the
asm? If performance is a concern, we can use .pushsection and
.popsection to move that far away...

> > +
> > +	if (idx)
> > +		count += READ_ONCE(pc->offset);

I'm rather scared that from GCC's PoV, idx was initialized to zero, and
not modified above (per the asm constraints). I realise that we've used
an "m" constraint and clobbered memory, but I could well imagine that
GCC can interpret that as needing to place a read-only copy in memory,
but still being permitted to use the original value in a register. That
would permit the above to be optimized away, since GCC knows no
registers were clobbered, and thus idx must still be zero.

> > +
> > +	return count;

... and for similar reasons, always return zero here.

> > +abort:
> > +        pr_debug("Abort handler\n");
> > +        exit(-2);
> > +}

Given the necessary complexity evident above, I'm also fearful that the
sort of folk that want userspace counter access aren't going to bother
with the above.

Thanks,
Mark.
