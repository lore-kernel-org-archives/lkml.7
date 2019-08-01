Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED9BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E1B20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564668509;
	bh=IXX2z3LZp9/vh6A4fK4Aj8M5DxOuM9+ZGyNm+tX+k/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YAaOWDQhNK1TRRV4FrjVV1AfjDm4Yd1WnbPqtitMCsDlnQ+kLtcgHFlJb3AtayolQ
	 /ch5ClLe7n/tRwWzzSjF/1yKLIsCzIabvb3s7z0o/+e3j8KkadO54SCd1xVFisYl2D
	 /uIncUlw+exiPCntIJsu/pdOOAHqEiXUvWGDGORI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfHAOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731814AbfHAOIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:08:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A220720679;
        Thu,  1 Aug 2019 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564668504;
        bh=IXX2z3LZp9/vh6A4fK4Aj8M5DxOuM9+ZGyNm+tX+k/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pm+No2ALbNs9D3JreUMGhHDgHvV3biwf7mnRH8qzi9I1RVHSjqyh5YskaCxmu8kYo
         NCLqpdwJ/Ba06p49XKSvpMUCc85N3f4O02ZpbUBh0Ijkk1TNIti22T7W1c9YS+Ctyb
         cvO99qd1mQuHyQFpT6gORgPt9mR4kon+2lKfkQss=
Date:   Thu, 1 Aug 2019 23:08:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dan Rue <dan.rue@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Matt Hart <matthew.hart@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] arm64: kprobes: Recover pstate.D in single-step
 exception handler
Message-Id: <20190801230818.72fadeea8a58d1f657179b30@kernel.org>
In-Reply-To: <20190801121622.vs57a6e2syklyr3z@willie-the-truck>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
        <156404255444.2020.3301023170351823334.stgit@devnote2>
        <20190801121622.vs57a6e2syklyr3z@willie-the-truck>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 13:16:22 +0100
Will Deacon <will@kernel.org> wrote:

> On Thu, Jul 25, 2019 at 05:15:54PM +0900, Masami Hiramatsu wrote:
> > kprobes manipulates the interrupted PSTATE for single step, and
> > doesn't restore it. Thus, if we put a kprobe where the pstate.D
> > (debug) masked, the mask will be cleared after the kprobe hits.
> > 
> > Moreover, in the most complicated case, this can lead a kernel
> > crash with below message when a nested kprobe hits.
> > 
> > [  152.118921] Unexpected kernel single-step exception at EL1
> > 
> > When the 1st kprobe hits, do_debug_exception() will be called.
> > At this point, debug exception (= pstate.D) must be masked (=1).
> > But if another kprobes hits before single-step of the first kprobe
> > (e.g. inside user pre_handler), it unmask the debug exception
> > (pstate.D = 0) and return.
> > Then, when the 1st kprobe setting up single-step, it saves current
> > DAIF, mask DAIF, enable single-step, and restore DAIF.
> > However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
> > single-step exception happens soon after restoring DAIF.
> > 
> > This has been introduced by commit 7419333fa15e ("arm64: kprobe:
> > Always clear pstate.D in breakpoint exception handler")
> > 
> > To solve this issue, this stores all DAIF bits and restore it
> > after single stepping.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Tested-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   Changes in v3:
> >    - Update patch description
> >    - move PSR_DAIF_MASK in daifflags.h
> >   Changes in v2:
> >    - Save and restore all DAIF flags.
> >    - Operate pstate directly and remove spsr_set_debug_flag().
> > ---
> >  arch/arm64/include/asm/daifflags.h |    2 ++
> >  arch/arm64/kernel/probes/kprobes.c |   39 +++++-------------------------------
> >  2 files changed, 7 insertions(+), 34 deletions(-)
> 
> I'm seeing an allmodconfig build failure with this:
> 
> arch/arm64/kernel/probes/kprobes.c: In function ‘kprobes_save_local_irqflag’:
> arch/arm64/kernel/probes/kprobes.c:181:38: error: ‘DAIF_MASK’ undeclared (first use in this function); did you mean ‘BIT_MASK’?
>   kcb->saved_irqflag = regs->pstate & DAIF_MASK;
>                                       ^~~~~~~~~
>                                       BIT_MASK
> arch/arm64/kernel/probes/kprobes.c:181:38: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm64/kernel/probes/kprobes.c: In function ‘kprobes_restore_local_irqflag’:
> arch/arm64/kernel/probes/kprobes.c:190:19: error: ‘DAIF_MASK’ undeclared (first use in this function); did you mean ‘BIT_MASK’?
>   regs->pstate &= ~DAIF_MASK;
>                    ^~~~~~~~~
>                    BIT_MASK
> make[2]: *** [scripts/Makefile.build:274: arch/arm64/kernel/probes/kprobes.o] Error 1

Oops, daifflags.h is included via kvm_host.h...
OK, kprobes.c must include daifflags.h directly in this case.

I'll update this patch too.

Thank you,

> 
> Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>
