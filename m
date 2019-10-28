Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9025FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6248721721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572279935;
	bh=z7y68uGhxU3XB3UAHmTS6TFGDi0jIXGTfw9R8HUSZGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BfLrgCvHs5CNH5PPG1ofechmRZB8lOzbF/ao9pb/yqSQiK/5MyI9TwLho4AAEX4Yt
	 losSRMd5vCFOKv+3LTV/coNgRLY+L7znztAhwzkJ6dDvrX0DUuBDEvyEq5p9iF8TdJ
	 lUXwRS+HUwLvTzXkRaoaEOYkp4hqJke6xNeyI5go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbfJ1QZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390902AbfJ1QZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:25:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24019214E0;
        Mon, 28 Oct 2019 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572279933;
        bh=z7y68uGhxU3XB3UAHmTS6TFGDi0jIXGTfw9R8HUSZGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZhgFIv7DOtxVAHYqIF3RcX1tJzkqko8mXiKuLKSI0ybMZ+uudMrIwikRjoJcDQWs
         jxS2ziD1Ie7coLSI81NO6jho6OGT+9kpTwD9VaUzYETlTuE53cIGLeJ5ZoIjP/Egqc
         expN7sBdn3XlNNNy9HtnYox194KYKSt4FVti+40U=
Date:   Mon, 28 Oct 2019 16:25:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        rabin@rab.in, Mark Rutland <mark.rutland@arm.com>,
        james.morse@arm.com
Subject: Re: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
Message-ID: <20191028162525.GF5576@willie-the-truck>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.687479693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018074634.687479693@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Oct 18, 2019 at 09:35:38AM +0200, Peter Zijlstra wrote:
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

Why can't you just pass 'true' for patch_text_remap? AFAICT, the only
time you want to pass false is during early boot when the text is
assumedly still writable without the fixmap.

Will
