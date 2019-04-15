Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FF2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcUDHDPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfDOPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:36:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfDOPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aoFG2HnbXkNjGObHpjAc3XGin1mvookbC3kQHJVrCXw=; b=fcUDHDPS0RT8/jdu5Ye7/469y
        1PqK3WukF7GhyLA8Dm7oKHVELeYCFBAdm463J8npcOWQddQRcunCkRowPf8cVgc5iHr/V7iFBWJ0j
        yJZssoVh4HGRRaJnwSSo121RYpM6spO6VrV31f9JwGAdk9134H91ZniSQTG1XeIX8JbVUjtAUfYa3
        1yUgzYFsIKHvhKryZ31MWnhFL6RsXBmkCqadqFSMaghWTcwaejZu7/KRrwnmfMqRYT8kOogoFGVTS
        /SWpBERUP9423QkXO8vNBw6VnYZlZxZISkq4UFVntNYcJQ47/QSjbzjxRguZT4zD0/oGCV1liw48o
        9ROPAsK8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG3ej-0002XQ-2r; Mon, 15 Apr 2019 15:36:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE24229B4DB32; Mon, 15 Apr 2019 17:36:22 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:36:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190415153622.GG12232@hirez.programming.kicks-ass.net>
References: <20190408165942.23640-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408165942.23640-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'll mostly defer to Josh on unwinding, but a few comments below.

On Tue, Apr 09, 2019 at 12:59:42AM +0800, Kairui Song wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e2b1447192a8..6075a4f94376 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2355,6 +2355,12 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	cyc2ns_read_end();
>  }
>  
> +static inline int
> +valid_perf_registers(struct pt_regs *regs)
> +{
> +	return (regs->ip && regs->bp && regs->sp);
> +}

I'm unconvinced by this, with both guess and orc having !bp is perfectly
valid.

>  void
>  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>  {
> @@ -2366,11 +2372,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> -	if (perf_callchain_store(entry, regs->ip))
> +	if (valid_perf_registers(regs)) {
> +		if (perf_callchain_store(entry, regs->ip))
> +			return;
> +		unwind_start(&state, current, regs, NULL);
> +	} else if (regs->sp) {
> +		unwind_start(&state, current, NULL, (unsigned long *)regs->sp);
> +	} else {
>  		return;
> +	}

AFAICT if we, by pure accident, end up with !bp for ORC, then we
initialize the unwind wrong.

Note that @regs is mostly trivially correct, except for that tracepoint
case. So I don't think we should magic here.

> -	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
> -	     unwind_next_frame(&state)) {
> +	for (; !unwind_done(&state); unwind_next_frame(&state)) {
>  		addr = unwind_get_return_address(&state);
>  		if (!addr || perf_callchain_store(entry, addr))
>  			return;


> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index f335aad404a4..226077e20412 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -98,18 +98,23 @@ struct stack_frame_ia32 {
>      u32 return_address;
>  };
>  
> +#ifdef CONFIG_FRAME_POINTER
>  static inline unsigned long caller_frame_pointer(void)
>  {
>  	struct stack_frame *frame;
>  
>  	frame = __builtin_frame_address(0);
>  
> -#ifdef CONFIG_FRAME_POINTER
>  	frame = frame->next_frame;
> -#endif
>  
>  	return (unsigned long)frame;
>  }
> +#else
> +static inline unsigned long caller_frame_pointer(void)
> +{
> +	return 0;
> +}
> +#endif

OK, that makes sense I guess.
