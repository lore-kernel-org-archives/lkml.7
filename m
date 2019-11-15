Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902412073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKOVCd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfKOVCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:02:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D3220723;
        Fri, 15 Nov 2019 21:02:31 +0000 (UTC)
Date:   Fri, 15 Nov 2019 16:02:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
Message-ID: <20191115160230.78871d8f@gandalf.local.home>
In-Reply-To: <1573849732.5937.136.camel@lca.pw>
References: <1573849732.5937.136.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 15:28:52 -0500
Qian Cai <cai@lca.pw> wrote:

> # echo function >/sys/kernel/debug/tracing/current_tracer
> 
> It hangs forever with today's linux-next on powerpc. Reverted the conflict fix
> [1] as below fixes the issue.
> 
> [1] https://lore.kernel.org/linux-next/20191115135357.10386fac@canb.auug.org.au/

What's your config file.

And can you test the two conflicting commits to see which one caused
your error?

Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022

And see if the issue is with that one, and not with the one without it.

-- Steve


> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> generic/vmlinux.lds.h
> index 7d0d03a03d4d..a92222f79b53 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -136,29 +136,20 @@
>  #endif
>  
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
> -/*
> - * The ftrace call sites are logged to a section whose name depends on the
> - * compiler option used. A given kernel image will only use one, AKA
> - * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
> - * dependencies for FTRACE_CALLSITE_SECTION's definition.
> - */
> -/*
> - * Need to also make ftrace_graph_stub point to ftrace_stub
> - * so that the same stub location may have different protocols
> - * and not mess up with C verifiers.
> - */
> -#define MCOUNT_REC()	. = ALIGN(8);				\
> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> +#define MCOUNT_REC()	. = ALIGN(8)				\
>  			__start_mcount_loc = .;			\
> -			KEEP(*(__mcount_loc))			\
>  			KEEP(*(__patchable_function_entries))	\
>  			__stop_mcount_loc = .;			\
>  			ftrace_graph_stub = ftrace_stub;
>  #else
> -# ifdef CONFIG_FUNCTION_TRACER
> -#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
> -# else
> -#  define MCOUNT_REC()
> -# endif
> +#define MCOUNT_REC()	. = ALIGN(8);				\
> +			__start_mcount_loc = .;			\
> +			KEEP(*(__mcount_loc))			\
> +			__stop_mcount_loc = .;
> +#endif
> +#else
> +#define MCOUNT_REC()
>  #endif
>  
>  #ifdef CONFIG_TRACE_BRANCH_PROFILING

