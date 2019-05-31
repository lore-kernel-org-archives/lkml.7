Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE045C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AEA25468
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEaPhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:37:16 -0400
Received: from foss.arm.com ([217.140.101.70]:53380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaPhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:37:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA98341;
        Fri, 31 May 2019 08:37:15 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76123F59C;
        Fri, 31 May 2019 08:37:12 -0700 (PDT)
Date:   Fri, 31 May 2019 16:37:03 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190531153703.GA21288@fuggles.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <efcd5cf4-3501-f3b6-bf47-145a9ef19a53@linux.ibm.com>
 <8b55f79a-c324-0701-e85f-c7797a60a708@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b55f79a-c324-0701-e85f-c7797a60a708@linux.ibm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 03:57:36PM +0530, Ravi Bangoria wrote:
> 
> 
> On 5/30/19 2:08 PM, Ravi Bangoria wrote:
> >> ---
> >> Subject: perf: Fix perf_sample_regs_user()
> >> From: Peter Zijlstra <peterz@infradead.org>
> >> Date: Wed May 29 14:37:24 CEST 2019
> >>
> >> perf_sample_regs_user() uses 'current->mm' to test for the presence of
> >> userspace, but this is insufficient, consider use_mm().
> >>
> >> A better test is: '!(current->flags & PF_KTHREAD)', exec() clears
> >> PF_KTHREAD after it sets the new ->mm but before it drops to userspace
> >> for the first time.
> > 
> > This looks correct. I'll give it a try.
> > 
> >>
> >> Possibly obsoletes: bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs user process")
> >>
> >> Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> >> Reported-by: Young Xiao <92siuyang@gmail.com>
> >> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> >> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> >> Cc: Stephane Eranian <eranian@google.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> Acked-by: Will Deacon <will.deacon@arm.com>
> >> Fixes: 4018994f3d87 ("perf: Add ability to attach user level registers dump to sample")
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> ---
> >>  kernel/events/core.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct
> >>  	if (user_mode(regs)) {
> >>  		regs_user->abi = perf_reg_abi(current);
> >>  		regs_user->regs = regs;
> >> -	} else if (current->mm) {
> >> +	} else if (!(current->flags & PF_KTHREAD)) {
> 
> With this patch applied and my patch reverted, I still see it crashing
> because current->flags does not have PF_KTHREAD set. Sample trace with
> v5.0 kernel:
> 
> 
>    BUG: Kernel NULL pointer dereference at 0x00000000
>    Faulting instruction address: 0xc0000000000f1a6c
>    Oops: Kernel access of bad area, sig: 11 [#1]
>    LE SMP NR_CPUS=2048 NUMA pSeries
>    CPU: 17 PID: 3241 Comm: systemd-cgroups Kdump: loaded Not tainted 5.0.0+ #7
>    NIP:  c0000000000f1a6c LR: c0000000002acc7c CTR: c0000000002a8f90
>    REGS: c0000001e80469a0 TRAP: 0300   Not tainted  (5.0.0+)
>    MSR:  8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 48022448  XER: 20000000
>    CFAR: c00000000000deb4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1 
>    GPR00: c0000000002acc7c c0000001e8046c30 c000000001607500 0000000000000000 
>    GPR04: 0000000000000000 0000000000000000 0000000000000000 c000000000128618 
>    GPR08: 000007ffffffffff 0000000000000000 ffffffffffffffff c00000000001cd40 
>    GPR12: c000000000446fd8 c00000003ffdf080 00000000ffff0000 0000000000000007 
>    GPR16: c0000001edd74988 c0000001edd60400 00007fff89801130 000000000005e1b0 
>    GPR20: c0000001edb77a08 c0000001e8047208 c0000001f03d9800 c0000001e8046e00 
>    GPR24: 000000000000b1af c000000001126938 c0000001f03d9b28 0000000000010000 
>    GPR28: c0000001e8046d30 0000000000000000 0000000000000000 0000000000000000 
>    NIP [c0000000000f1a6c] perf_reg_value+0x5c/0xc0
>    LR [c0000000002acc7c] perf_output_sample_regs+0x6c/0xd0
>    Call Trace:
>    [c0000001e8046c30] [c0000000002acc7c] perf_output_sample_regs+0x6c/0xd0 (unreliable)
>    [c0000001e8046c80] [c0000000002b9cd0] perf_output_sample+0x620/0x8c0
>    [c0000001e8046d10] [c0000000002ba6b4] perf_event_output_forward+0x64/0x90
>    [c0000001e8046d80] [c0000000002b2908] __perf_event_overflow+0x88/0x1e0
>    [c0000001e8046dd0] [c0000000000f3d18] record_and_restart+0x288/0x670
>    [c0000001e8047180] [c0000000000f4c18] perf_event_interrupt+0x2b8/0x4b0
>    [c0000001e8047280] [c00000000002b380] performance_monitor_exception+0x50/0x70
>    [c0000001e80472a0] [c000000000009ca0] performance_monitor_common+0x110/0x120
>    --- interrupt: f01 at slice_scan_available+0x20/0xc0
>        LR = slice_find_area+0x174/0x210
>    [c0000001e8047630] [c000000000083ea0] slice_get_unmapped_area+0x3d0/0x7f0
>    [c0000001e8047ae0] [c00000000032d5b0] get_unmapped_area+0xa0/0x170
>    [c0000001e8047b10] [c00000000001cd40] arch_setup_additional_pages+0xc0/0x1c0
>    [c0000001e8047b60] [c000000000446fd8] load_elf_binary+0xb48/0x1580
>    [c0000001e8047c80] [c0000000003c3938] search_binary_handler+0xe8/0x2a0
>    [c0000001e8047d10] [c0000000003c42f4] __do_execve_file.isra.13+0x694/0x980
>    [c0000001e8047de0] [c000000000128618] call_usermodehelper_exec_async+0x248/0x290
>    [c0000001e8047e20] [c00000000000b65c] ret_from_kernel_thread+0x5c/0x80
>    Instruction dump:
>    7c9e2378 7c7f1b78 f8010010 f821ffd1 419e0044 3d22ff6b 7bc41764 3929ae10 
>    7d29202e 2b890150 419d003c 38210030 <7c7f482a> e8010010 ebc1fff0 ebe1fff8 
>    ---[ end trace 54f3492ad1d403d8 ]---

Oh, nice! I think this happens because Power doesn't actually initialise
the regs after a kthread execs() until late in start_thread(). But the plot
thickens somewhat, since current_pt_regs() is different to
task_pt_regs(current) on Power (the former cannot return NULL).

So a really hideous hack on top of Peter's patch might be:

diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac612146e..5bde866024b6 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -57,6 +57,6 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy)
 {
-	regs_user->regs = task_pt_regs(current);
+	regs_user->regs = current_pt_regs();
 	regs_user->abi = perf_reg_abi(current);
 }

Will
