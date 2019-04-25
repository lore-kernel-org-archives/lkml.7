Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84866C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF68120891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VqnasD/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfDYQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:26:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbfDYQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:26:29 -0400
Received: from zn.tnic (p200300EC2F0E43001D86563D61B131D5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4300:1d86:563d:61b1:31d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F9F91EC050B;
        Thu, 25 Apr 2019 18:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556209587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bhEpDc5d4HyhQ2bpVjieSeCZ31GaRinPp/sR5VeHQ6U=;
        b=VqnasD/zMdS+0uAelD4hutyqDB8IyeLbKILtFiZqFO8GVwKD8qzxgPpJi0rWWAzqt3XCkv
        0lhbY7oIEM/5nlBPWCr1Oc92xyJvS3bMpMsjBKLeFHZBxLgMAduzCX4bZ+Rz0S2WdHmSYZ
        PHMxLE/J/50mz0+wo+W3eQrFC84hXuc=
Date:   Thu, 25 Apr 2019 18:26:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v4 03/23] x86/mm: Introduce temporary mm structs
Message-ID: <20190425162620.GA5199@zn.tnic>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190422185805.1169-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422185805.1169-4-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:57:45AM -0700, Rick Edgecombe wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> Using a dedicated page-table for temporary PTEs prevents other cores
> from using - even speculatively - these PTEs, thereby providing two
> benefits:
> 
> (1) Security hardening: an attacker that gains kernel memory writing
> abilities cannot easily overwrite sensitive data.
> 
> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> remote page-tables.
> 
> To do so a temporary mm_struct can be used. Mappings which are private
> for this mm can be set in the userspace part of the address-space.
> During the whole time in which the temporary mm is loaded, interrupts
> must be disabled.
> 
> The first use-case for temporary mm struct, which will follow, is for
> poking the kernel text.
> 
> [ Commit message was written by Nadav Amit ]
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 19d18fae6ec6..d684b954f3c0 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -356,4 +356,37 @@ static inline unsigned long __get_current_cr3_fast(void)
>  	return cr3;
>  }
>  
> +typedef struct {
> +	struct mm_struct *prev;
> +} temp_mm_state_t;
> +
> +/*
> + * Using a temporary mm allows to set temporary mappings that are not accessible
> + * by other cores. Such mappings are needed to perform sensitive memory writes

s/cores/CPUs/g

Yeah, the concept of a thread of execution we call a CPU in the kernel,
I'd say. No matter if it is one of the hyperthreads or a single thread
in core.

> + * that override the kernel memory protections (e.g., W^X), without exposing the
> + * temporary page-table mappings that are required for these write operations to
> + * other cores.

Ditto.

>  Using temporary mm also allows to avoid TLB shootdowns when the

Using a ..

> + * mapping is torn down.
> + *

Nice commenting.

> + * Context: The temporary mm needs to be used exclusively by a single core. To
> + *          harden security IRQs must be disabled while the temporary mm is
			      ^
			      ,

> + *          loaded, thereby preventing interrupt handler bugs from overriding
> + *          the kernel memory protection.
> + */
> +static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +	temp_mm_state_t state;
> +
> +	lockdep_assert_irqs_disabled();
> +	state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	switch_mm_irqs_off(NULL, mm, current);
> +	return state;
> +}
> +
> +static inline void unuse_temporary_mm(temp_mm_state_t prev)
> +{
> +	lockdep_assert_irqs_disabled();
> +	switch_mm_irqs_off(NULL, prev.prev, current);

I think this code would be more readable if you call that
temp_mm_state_t variable "temp_state" and the mm_struct pointer "mm" and
then you have:

	switch_mm_irqs_off(NULL, temp_state.mm, current);

And above you'll have:

	temp_state.mm = ...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
