Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F65C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A4822419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574248747;
	bh=YNeI6f9iR8Wv1wQxa1Wf0M5a5awz3WI0WI4DD9SAWXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oTPb5VHYE3IEsps1HpxJWDR0ZV0fS2obraWDM5KrhIfaZHL67jq1BBMZ/mIg5cOLP
	 1jd6IHYDbPZ3YKZ4q4CXuMnVkAsguMy47qHBNVIG+nWlI4/1Rku6AyiDDOhDsijhTj
	 eaTQjyutLkrts+5LHeh0DvY0gCDA4c9J84aa+e88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfKTLTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:19:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44690 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfKTLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:19:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so1488561wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IehKOdRvP6ukM4yKhwxMCQI34wVSt7ku4o5K+No94hY=;
        b=deKA/QnxbOCg46jRHfrYWNYPNqLIcUHNbCkHOzA3Vi6axPcVP++sqAsz4f1oN+dbqP
         cUVjBkzzHKZVrkfk4mWdFFvGn9E8UfXixurAMYmCkwqahrv5BLH8b1TbhLApdBxUH1SU
         sjADgf8Ok7BJYJ9eR3welJ8/4jPtFdhSnhd4duT8a7HvOdgP/ZrYDUEAES4Pbu4zG7+U
         TbHckhOj69AiH6JjXXJjfOx4xlQ48xUgkJ45CWyMz8TkBEBJJiv94wlQEgFQKfdogs6z
         cJ+OAqbNSbVTunszX6QiIClSt7+hSc4INXhK7FswH+E/dMBYt4h6FVjBnkOnRhfUxm51
         ULiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IehKOdRvP6ukM4yKhwxMCQI34wVSt7ku4o5K+No94hY=;
        b=iemf9d4SbthJlROa6iapGi8sfb51OgNQZ/LWyIiyc/SAl5zaWTMTLDagBio5vI1Cs5
         1VJBuwA0tnofbZCh68VE5Nj3kmqYvVS/6rXgiiFnXHpy6QosSqReJBSDI05os0jP09EP
         JiCI77iG0bmul+qbm5cF1VncKtCeDKHLliKE3HKDcf7KCaNmKCseuglxlwCfG2y5WH+v
         eMnT7Bl4eiZgb12HBWoE7iOM/yRYNfb3kpqPmx/7tbWPkOIMfKV2FfkII1xlagytLONO
         hoxAMiVqHYBitHIKNoEMo5VbdocHIxcd2kuAav9x4auY9zksEBQyJ3q1nasVYsaD3OT2
         /aWw==
X-Gm-Message-State: APjAAAWYBhsbb5QUidUhSJtG0h6GogoB2rKzCyWvxQzELeqFZ9iptrGy
        r3tzvUrqXkCGLwj6jv6DBYU=
X-Google-Smtp-Source: APXvYqxzIrCBgSwTN/9bpWnbAfKtFcZVZpsohJjOKKS8SgY7HbMJ21neQacWUyAg3eA/EKN8BybiPg==
X-Received: by 2002:adf:9f52:: with SMTP id f18mr2498126wrg.51.1574248742163;
        Wed, 20 Nov 2019 03:19:02 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d202sm5873847wmd.47.2019.11.20.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:19:01 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:18:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120111859.GA115930@gmail.com>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120103613.63563-2-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> A frequent cause of #GP exceptions are memory accesses to non-canonical
> addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> the kernel doesn't currently print the fault address for #GP.
> Luckily, we already have the necessary infrastructure for decoding X86
> instructions and computing the memory address that is being accessed;
> hook it up to the #GP handler so that we can figure out whether the #GP
> looks like it was caused by a non-canonical address, and if so, print
> that address.
> 
> While it is already possible to compute the faulting address manually by
> disassembling the opcode dump and evaluating the instruction against the
> register dump, this should make it slightly easier to identify crashes
> at a glance.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> 
> Notes:
>     v2:
>      - print different message for segment-related GP (Borislav)
>      - rewrite check for non-canonical address (Sean)
>      - make it clear we don't know for sure why the GP happened (Andy)
>     v3:
>      - change message format to one line (Borislav)
>     
>     I have already sent a patch to syzkaller that relaxes their parsing of GPF
>     messages (https://github.com/google/syzkaller/commit/432c7650) such that
>     changes like the one in this patch don't break it.
>     That patch has already made its way into syzbot's syzkaller instances
>     according to <https://syzkaller.appspot.com/upstream>.
> 
>  arch/x86/kernel/traps.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c90312146da0..19afedcd6f4e 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -56,6 +56,8 @@
>  #include <asm/mpx.h>
>  #include <asm/vm86.h>
>  #include <asm/umip.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -509,11 +511,45 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
>  }
>  
> +/*
> + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> + * address, return that address.
> + */
> +static unsigned long get_kernel_gp_address(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_X86_64
> +	u8 insn_bytes[MAX_INSN_SIZE];
> +	struct insn insn;
> +	unsigned long addr_ref;
> +
> +	if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> +		return 0;
> +
> +	kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> +	insn_get_modrm(&insn);
> +	insn_get_sib(&insn);
> +	addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);

I had to look twice to realize that the 'insn_bytes' isn't an integer 
that shows the number of bytes in the instruction, but the instruction 
buffer itself.

Could we please do s/insn_bytes/insn_buf or such?

> +
> +	/* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
> +	if (addr_ref >= ~__VIRTUAL_MASK)
> +		return 0;
> +
> +	/* Bail out if the entire operand is in the canonical user half. */
> +	if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
> +		return 0;

BTW., it would be nice to split this logic in two: return the faulting 
address to do_general_protection(), and print it out both for 
non-canonical and canonical addresses as well -and use the canonical 
check to *additionally* print out a short note when the operand is 
non-canonical?

> +#define GPFSTR "general protection fault"
>  dotraplinkage void

Please separate macro and function definitions by an additional newline.

>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> -	const char *desc = "general protection fault";
>  	struct task_struct *tsk;
> +	char desc[90] = GPFSTR;


How was this maximum string length of '90' derived? In what way will that 
have to change if someone changes the message?

Thanks,

	Ingo
