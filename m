Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78A7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39DC205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfLCKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:35:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:35:01 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ic5WB-0008K7-N0; Tue, 03 Dec 2019 11:34:55 +0100
Date:   Tue, 3 Dec 2019 11:34:55 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, jon.grimm@amd.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than
 struct declaration
Message-ID: <20191203103455.pvm5jrwkksygmhd7@linutronix.de>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-03 04:01:28 [-0500], Suravee Suthikulpanit wrote:
> The current XCHECK_SZ macro warns if the XFEATURE size reported
> by CPUID does not match the size of kernel structure. However, depending
> on the hardware implementation, CPUID can report the XSAVE state size
> larger than the size of C structures defined for each of the XSAVE state
> due to padding. Such case should be safe and should not need to generate
> warning message.

Do you have an example which CPU generation and which feature?

We don't use this these structs in the kernel and the xsave layout is
dynamic based on the memory requirements reported by the CPU.
But we have a warning which complains about different sizes. Now you
change the warning that it is okay if the CPU reports that more memory
is needed than we expect. This looks wrong. The other way around would
be "okay" but this just renders the warning useless.

> Therefore, change the logic to warn only when the CPUID reported size is
> less than then size of C structure.
> 
> Fixes: ef78f2a4bf84 ("x86/fpu: Check CPU-provided sizes against struct declarations")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index e5cb67d..f002115 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -523,7 +523,7 @@ static void __xstate_dump_leaves(void)
>  
>  #define XCHECK_SZ(sz, nr, nr_macro, __struct) do {			\
>  	if ((nr == nr_macro) &&						\
> -	    WARN_ONCE(sz != sizeof(__struct),				\
> +	    WARN_ONCE(sz < sizeof(__struct),				\
>  		"%s: struct is %zu bytes, cpu state %d bytes\n",	\
>  		__stringify(nr_macro), sizeof(__struct), sz)) {		\
>  		__xstate_dump_leaves();					\

Sebastian
