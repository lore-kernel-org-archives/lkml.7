Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CA22253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1KdCWzgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfGXJOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:14:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfGXJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P++G4+Hz0arFZYzGJZ+QG+qM4QDwhDQLrMwzJGHEyZY=; b=1KdCWzgWulsi3IBfsv8jy595R
        UnfpIx6ZkNH9rlSBcB58f9EF+iJWUNNlBHNjhPicufGaKuSiY3OZ8qOsZc/gG16Te0vdGfgekq6bA
        0B1uNi/kz54qv4lyCbT4mf86DPKjYL/4VmajslrhokpXeVSk5jhJg4WWzp1PP5hz9ve652vBzbH8d
        l2JNIK8PYNS18RRKGQyYvldlJIZ2KeGynlog5CyHfN0e0J7vRqMyWbkLf0Ia5N8TXe6UF24yho92Y
        wpjggEX0hse6nHFUzkTYW+VjfU+tAgJIEiH5IutTfaIe9PKtji61OgfqGyL67pcjqcaQmnO1oijkP
        +dfhO7VQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqDM9-0002Oq-I3; Wed, 24 Jul 2019 09:14:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE02F2026E807; Wed, 24 Jul 2019 11:14:38 +0200 (CEST)
Date:   Wed, 24 Jul 2019 11:14:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Mullins <mmullins@fb.com>
Cc:     tglx@linutronix.de, luto@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry/32: pass cr2 to do_async_page_fault
Message-ID: <20190724091438.GA31363@hirez.programming.kicks-ass.net>
References: <20190724042058.24506-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724042058.24506-1-mmullins@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:20:58PM -0700, Matt Mullins wrote:
> Commit a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption") added the
> address parameter to do_async_page_fault, but does not pass it from the
> 32-bit entry point.  To plumb it through, factor-out
> common_exception_read_cr2 in the same fashion as common_exception, and
> uses it from both page_fault and async_page_fault.
> 
> For a 32-bit KVM guest, this fixes:
> 
> [    1.148669][    T1] Run /sbin/init as init process
> [    1.153328][    T1] Starting init: /sbin/init exists but couldn't execute it (error -14)
> 
> Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
> Signed-off-by: Matt Mullins <mmullins@fb.com>

Argh. Sorry for overlooking that one.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There's some potential for sharing between common_exception and your
common_exception_read_cr2, I'll see if I can do that without making a
mess of it.

Also; FB uses 32bit guests?!?

> ---
>  arch/x86/entry/entry_32.S | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 2bb986f305ac..4f86928246e7 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1443,8 +1443,12 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
>  
>  ENTRY(page_fault)
>  	ASM_CLAC
> -	pushl	$0; /* %gs's slot on the stack */
> +	pushl	$do_page_fault
> +	jmp	common_exception_read_cr2
> +END(page_fault)
>  
> +common_exception_read_cr2:
> +	/* the function address is in %gs's slot on the stack */
>  	SAVE_ALL switch_stacks=1 skip_gs=1
>  
>  	ENCODE_FRAME_POINTER
> @@ -1452,6 +1456,7 @@ ENTRY(page_fault)
>  
>  	/* fixup %gs */
>  	GS_TO_REG %ecx
> +	movl	PT_GS(%esp), %edi
>  	REG_TO_PTGS %ecx
>  	SET_KERNEL_GS %ecx
>  
> @@ -1463,9 +1468,9 @@ ENTRY(page_fault)
>  
>  	TRACE_IRQS_OFF
>  	movl	%esp, %eax			# pt_regs pointer
> -	call	do_page_fault
> +	CALL_NOSPEC %edi
>  	jmp	ret_from_exception
> -END(page_fault)
> +END(common_exception_read_cr2)
>  
>  common_exception:
>  	/* the function address is in %gs's slot on the stack */
> @@ -1595,7 +1600,7 @@ END(general_protection)
>  ENTRY(async_page_fault)
>  	ASM_CLAC
>  	pushl	$do_async_page_fault
> -	jmp	common_exception
> +	jmp	common_exception_read_cr2
>  END(async_page_fault)
>  #endif
>  
> -- 
> 2.17.1
> 
