Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6A2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfGWQDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:03:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfGWQDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7AEC28;
        Tue, 23 Jul 2019 09:03:53 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76CC83F71A;
        Tue, 23 Jul 2019 09:03:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] arm64: kprobes: Recover pstate.D in single-step
 exception handler
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
 <156378171555.12011.2511666394591527888.stgit@devnote2>
From:   James Morse <james.morse@arm.com>
Message-ID: <9bb27cda-dac9-eaca-f028-e1c82b9f7a3f@arm.com>
Date:   Tue, 23 Jul 2019 17:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156378171555.12011.2511666394591527888.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 22/07/2019 08:48, Masami Hiramatsu wrote:
> On arm64, if a nested kprobes hit, it can crash the kernel with below
> error message.
> 
> [  152.118921] Unexpected kernel single-step exception at EL1
> 
> This is because commit 7419333fa15e ("arm64: kprobe: Always clear
> pstate.D in breakpoint exception handler") unmask pstate.D for
> doing single step but does not recover it after single step in
> the nested kprobes.

> That is correct *unless* any nested kprobes
> (single-stepping) runs inside other kprobes user handler.

(I don't think this is correct, its just usually invisible as PSTATE.D is normally clear)


> When the 1st kprobe hits, do_debug_exception() will be called. At this
> point, debug exception (= pstate.D) must be masked (=1). When the 2nd
>  (nested) kprobe is hit before single-step of the first kprobe, it
> unmask debug exception (pstate.D = 0) and return.
> Then, when the 1st kprobe setting up single-step, it saves current
> DAIF, mask DAIF, enable single-step, and restore DAIF.
> However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
> single-step exception happens soon after restoring DAIF.

This is pretty complicated. Just to check I've understood this properly:
Stepping on a kprobe in a kprobe-user's pre_handler will cause the remainder of the
handler (the first one) to run with PSTATE.D clear. Once we enable single-step, we start
stepping the debug handler, and will never step the original kprobe'd instruction.

This is describing the most complicated way that this problem shows up! (I agree its also
the worst)

I can get this to show up with just one kprobe. (function/file names here are meaningless):

| static int wibble(struct seq_file *m, void *discard)
| {
|        unsigned long d, flags;
|
|        flags = local_daif_save();
|
|        kprobe_me();
|        d = read_sysreg(daif);
|        local_daif_restore(flags);
|
|        seq_printf(m, "%lx\n", d);
|
|        return 0;
| }

plumbed into debugfs, then kicked using the kprobe_example module:
| root@adam:/sys/kernel/debug# cat wibble
| 3c0

| root@adam:/sys/kernel/debug# insmod ~morse/kprobe_example.ko symbol=kprobe_me
| [   69.478098] Planted kprobe at [..]
| root@adam:/sys/kernel/debug# cat wibble
| [   71.478935] <kprobe_me> pre_handler: p->addr = [..], pc = [..], pstate = 0x600003c5
| [   71.488942] <kprobe_me> post_handler: p->addr = [..], pstate = 0x600001c5
| 1c0

| root@adam:/sys/kernel/debug#

This is problem for any code that had debug masked, not just kprobes.

Can we start the commit-message with the simplest description of the problem: kprobes
manipulates the interrupted PSTATE for single step, and doesn't restore it.

(trying to understand this bug through kprobe's interaction with itself is hard!)


> To solve this issue, this stores all DAIF bits and restore it
> after single stepping.


> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index bd5dfffca272..348e02b799a2 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -29,6 +29,8 @@
>  
>  #include "decode-insn.h"
>  
> +#define PSR_DAIF_MASK	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)

We should probably move this to daifflags.h. Its going to be useful to other series too.


Patch looks good!
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>

(I haven't tried to test the nested kprobes case...)


Thanks,

James
