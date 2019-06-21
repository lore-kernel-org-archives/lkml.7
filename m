Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78421C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57360205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFUPW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:22:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55255 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:22:28 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heLMl-0005f7-2I; Fri, 21 Jun 2019 17:22:15 +0200
Date:   Fri, 21 Jun 2019 17:22:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/18] x86/fsgsbase/64: Preserve FS/GS state in
 __switch_to() if FSGSBASE is on
In-Reply-To: <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1906211717500.5503@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019, Chang S. Bae wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> With the new FSGSBASE instructions, we can efficiently read and write
> the FSBASE and GSBASE in __switch_to().  Use that capability to preserve
> the full state.
> 
> This will enable user code to do whatever it wants with the new
> instructions without any kernel-induced gotchas.  (There can still be
> architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GSBASE
> if WRGSBASE was used, but users are expected to read the CPU manual
> before doing things like that.)
> 
> This is a considerable speedup.  It seems to save about 100 cycles
> per context switch compared to the baseline 4.6-rc1 behavior on my
> Skylake laptop.
> 
> [ chang: 5~10% performance improvements were seen by a context switch
>   benchmark that ran threads with different FS/GSBASE values (to the
>   baseline 4.16). Minor edit on the changelog. ]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 17421c3..e2089c9 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -239,8 +239,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
>  {
>  	savesegment(fs, task->thread.fsindex);
>  	savesegment(gs, task->thread.gsindex);
> -	save_base_legacy(task, task->thread.fsindex, FS);
> -	save_base_legacy(task, task->thread.gsindex, GS);
> +	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +		/*
> +		 * If FSGSBASE is enabled, we can't make any useful guesses
> +		 * about the base, and user code expects us to save the current
> +		 * value.  Fortunately, reading the base directly is efficient.
> +		 */
> +		task->thread.fsbase = rdfsbase();
> +		task->thread.gsbase = __rdgsbase_inactive();

This explodes when called from copy_thread_tls() when an interrupt hits
after switching GS in __rdgsbase_inactive(). Wrapped it with
local_irq_save/restore().

Oh well.

Thanks,

	tglx
