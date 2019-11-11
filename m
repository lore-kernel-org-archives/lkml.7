Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0984B214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573490833;
	bh=kSP+F/NVvB3fNUcJQ5Oagfi0flczXLZxFEKPPzqYf60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lssw5g/Fc4SZXvqYK9xQKfezbGMmEDsFXY5aa4NR5Yb8y+G5/jai1/VcnpuCXiJol
	 JBPzkQlCvI4vTwojAkVP/bl1CMnGgf2vkfGgX/CP2uWlg0Gmod8IbXD2pc6bIYcq1g
	 3N3McRtqZO3UlU2Yb8HtQc8rE9dx/VAkNnEql+t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKKQrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfKKQrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:47:11 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52420206A3;
        Mon, 11 Nov 2019 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573490830;
        bh=kSP+F/NVvB3fNUcJQ5Oagfi0flczXLZxFEKPPzqYf60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxETDiwWhDE/KPIV+o7n5KxlVfcoNIUsLrpbBGnZik9L63DTwAHISigMlly9j4XPC
         eVVc2+Ml5DurIQS5mv0o180W45s0hLA+AuvMzAfj4cXDa/aahXstZ3BCDsN9FRqxBI
         ke76eNCh6lllByvT3w9qhgc1ClShZNheyXa6FgMo=
Date:   Mon, 11 Nov 2019 16:47:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: Re: [PATCH -v5 13/17] arm/ftrace: Use __patch_text_real()
Message-ID: <20191111164703.GA11521@willie-the-truck>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.220458362@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132458.220458362@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:13:05PM +0100, Peter Zijlstra wrote:
> Instead of flipping text protection, use the patch_text infrastructure
> that uses a fixmap alias where required.
> 
> This removes the last user of set_all_modules_text_*().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: ard.biesheuvel@linaro.org
> Cc: rabin@rab.in
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: james.morse@arm.com
> ---
>  arch/arm/kernel/ftrace.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -22,6 +22,7 @@
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
>  #include <asm/set_memory.h>
> +#include <asm/patch.h>
>  
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define	NOP		0xf85deb04	/* pop.w {lr} */
> @@ -31,13 +32,15 @@
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> +static int patch_text_remap = 0;
> +
>  static int __ftrace_modify_code(void *data)
>  {
>  	int *command = data;
>  
> -	set_kernel_text_rw();
> +	patch_text_remap++;
>  	ftrace_modify_all_code(*command);
> -	set_kernel_text_ro();
> +	patch_text_remap--;
>  
>  	return 0;
>  }
> @@ -59,13 +62,13 @@ static unsigned long adjust_address(stru
>  
>  int ftrace_arch_code_modify_prepare(void)
>  {
> -	set_all_modules_text_rw();
> +	patch_text_remap++;
>  	return 0;
>  }
>  
>  int ftrace_arch_code_modify_post_process(void)
>  {
> -	set_all_modules_text_ro();
> +	patch_text_remap--;
>  	/* Make sure any TLB misses during machine stop are cleared. */
>  	flush_tlb_all();
>  	return 0;
> @@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
>  			return -EINVAL;
>  	}
>  
> -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> -		return -EPERM;
> -
> -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> +	__patch_text_real((void *)pc, new, patch_text_remap);

I'd still prefer to pass 'true' unconditionally here, since I don't think
this is a hot path.

Will
