Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0961620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564661790;
	bh=eWUXpesPjpfKZlq50R19WMAnjpRsyX8e4dc1+npLS18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vGsfvziVrSe0BplGrUzcZBFtH3wQAfxaMElHNsE+pPUn6Vsgpf5dKNvOFX+kfcHmg
	 BjISZKWLVfQYiRQAURiskikzV9r+0uBsnx/1VVVTHeHpIG6iODm89H2eQNka2WHsxF
	 6r4GezkAiEn7GKjQR8J9uggu4nx2m6AHV4hBVROc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfHAMQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHAMQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:16:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9CD2064A;
        Thu,  1 Aug 2019 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564661787;
        bh=eWUXpesPjpfKZlq50R19WMAnjpRsyX8e4dc1+npLS18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TJVGwCetQUZaW3O2BkiB+MpMEfN6Ax9jFMvAEb5a8ovdjfO7RcnBZLBjov2V6qbL
         U9dnx3qEHQ5JDb0lXe0SgZsdErruUNnSttEEH56wx6YhyiokkaVQ0VmFx3WQjmqOQO
         nkSzliCzi4ZOwcgbNcQjn5SC7Z1sjjng1mOCevk8=
Date:   Thu, 1 Aug 2019 13:16:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190801121622.vs57a6e2syklyr3z@willie-the-truck>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
 <156404255444.2020.3301023170351823334.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156404255444.2020.3301023170351823334.stgit@devnote2>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:15:54PM +0900, Masami Hiramatsu wrote:
> kprobes manipulates the interrupted PSTATE for single step, and
> doesn't restore it. Thus, if we put a kprobe where the pstate.D
> (debug) masked, the mask will be cleared after the kprobe hits.
> 
> Moreover, in the most complicated case, this can lead a kernel
> crash with below message when a nested kprobe hits.
> 
> [  152.118921] Unexpected kernel single-step exception at EL1
> 
> When the 1st kprobe hits, do_debug_exception() will be called.
> At this point, debug exception (= pstate.D) must be masked (=1).
> But if another kprobes hits before single-step of the first kprobe
> (e.g. inside user pre_handler), it unmask the debug exception
> (pstate.D = 0) and return.
> Then, when the 1st kprobe setting up single-step, it saves current
> DAIF, mask DAIF, enable single-step, and restore DAIF.
> However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
> single-step exception happens soon after restoring DAIF.
> 
> This has been introduced by commit 7419333fa15e ("arm64: kprobe:
> Always clear pstate.D in breakpoint exception handler")
> 
> To solve this issue, this stores all DAIF bits and restore it
> after single stepping.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   Changes in v3:
>    - Update patch description
>    - move PSR_DAIF_MASK in daifflags.h
>   Changes in v2:
>    - Save and restore all DAIF flags.
>    - Operate pstate directly and remove spsr_set_debug_flag().
> ---
>  arch/arm64/include/asm/daifflags.h |    2 ++
>  arch/arm64/kernel/probes/kprobes.c |   39 +++++-------------------------------
>  2 files changed, 7 insertions(+), 34 deletions(-)

I'm seeing an allmodconfig build failure with this:

arch/arm64/kernel/probes/kprobes.c: In function ‘kprobes_save_local_irqflag’:
arch/arm64/kernel/probes/kprobes.c:181:38: error: ‘DAIF_MASK’ undeclared (first use in this function); did you mean ‘BIT_MASK’?
  kcb->saved_irqflag = regs->pstate & DAIF_MASK;
                                      ^~~~~~~~~
                                      BIT_MASK
arch/arm64/kernel/probes/kprobes.c:181:38: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/kernel/probes/kprobes.c: In function ‘kprobes_restore_local_irqflag’:
arch/arm64/kernel/probes/kprobes.c:190:19: error: ‘DAIF_MASK’ undeclared (first use in this function); did you mean ‘BIT_MASK’?
  regs->pstate &= ~DAIF_MASK;
                   ^~~~~~~~~
                   BIT_MASK
make[2]: *** [scripts/Makefile.build:274: arch/arm64/kernel/probes/kprobes.o] Error 1

Will
