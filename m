Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F64C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC92229F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MH3iZKyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKRRLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:11:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42450 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:11:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so21015739qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLWuzn35UcCrxAH0vPUkNSjLox6KKcBRbOlrNyg/FIg=;
        b=MH3iZKypeEMn6eJb9Ix/Otz7onqgGHRJL9afadNFwPY0KDIvW4KrX0L3JQ6qwF8/jA
         N1oCKYAU8Dz9r6TX6rqm31mg4N1/Wvg+5Yw096OvLhzj/43uvpC2fNWILPUDBNvmTDgL
         nvGRd6miKKmeDVZ8u3Z+HMjVMlLyJ3Ahewvbx4kx98y+GVFAgG7iDjuryjAnL8mSGvYs
         a+olFnVuUuc4Gg94cTcPII9Sykl9gDE9dPTjmymuo9L+k+y6GyLEdzyO3AAVW6YUW1pp
         R9lhOhRE5PqL2bcKrAjPMq1plY0/64fqqdSzd6An8Ugn8H8l9r9XN/bXU4yJQ8SNnsnV
         dcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLWuzn35UcCrxAH0vPUkNSjLox6KKcBRbOlrNyg/FIg=;
        b=QKp/SxXcoMeJT+IKe0NJYmIFlKjW35dDCS8FraLL+h2m+BQlgUZsAlnYbycIRiZE+p
         n7iiwblP50Fq9kCLsJlSmfAaJCI5dfQFaIoYfXrrITXbnJ5OgCcmFbB5D4IDvj3LcYsV
         d5vhOqpyU58UGKTTAv+vrXquEKDKCay4VSsYb7zIPPEaKLlrXes97SJcyqGS3WOuBWXl
         LKCcmM/t+JxZJXKYOjX9zL1ERUkbGRNayo39rqdqz3AxohozEhOEJ8NJTY1PeWjDGcTe
         ziqzrGAx2pk4RfVPd3Khl4hTvQ5SANc8RcirxMck7aAEKQDZN4P8W349EBlPU5N34iII
         naMg==
X-Gm-Message-State: APjAAAW8tH1dO8bQa5BFToxmHMX2hjKA7Vi2nY874ay2Pltamwhu9xlW
        GAj2w8BKyRZ/eUBkX2Xzj3YqtA==
X-Google-Smtp-Source: APXvYqzliPKDmikS4XgP3WlBwNZGz6arPLK8vRNTOmMUT5SgSVY0OZfuJoTZKIegW2snRbtqR/4JdA==
X-Received: by 2002:ac8:6f17:: with SMTP id g23mr9774921qtv.104.1574097090195;
        Mon, 18 Nov 2019 09:11:30 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t24sm11012562qtc.97.2019.11.18.09.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 09:11:29 -0800 (PST)
Message-ID: <1574097087.5937.141.camel@lca.pw>
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
From:   Qian Cai <cai@lca.pw>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 18 Nov 2019 12:11:27 -0500
In-Reply-To: <20191118101645.2f68c521@oasis.local.home>
References: <1573849732.5937.136.camel@lca.pw>
         <20191115160230.78871d8f@gandalf.local.home>
         <1573851994.5937.138.camel@lca.pw>
         <20191118095104.0daebbc3@oasis.local.home>
         <20191118095842.546b38d8@oasis.local.home>
         <20191118101645.2f68c521@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-18 at 10:16 -0500, Steven Rostedt wrote:
> On Mon, 18 Nov 2019 09:58:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 18 Nov 2019 09:51:04 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > > > Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022      
> > > > 
> > > > # git reset --hard b83b43ffc6e4b514ca034a0fbdee01322e2f7022
> > > > 
> > > > Yes, that one is bad.    
> > > 
> > > Can you see if this patch fixes the issue for you?  
> > 
> > Don't bother. This isn't the right fix, I know see the real issue.
> > 
> > New fix coming shortly.
> > 
> 
> Can you try this?

Yes, it works fine.

> 
> It appears that I picked a name "ftrace_graph_stub", that was already in
> use by powerpc. This just renames the function stub I used.
> 
> -- Steve
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 0f358be551cd..996db32c491b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -112,7 +112,7 @@
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
>  /*
> - * Need to also make ftrace_graph_stub point to ftrace_stub
> + * Need to also make ftrace_stub_graph point to ftrace_stub
>   * so that the same stub location may have different protocols
>   * and not mess up with C verifiers.
>   */
> @@ -120,17 +120,17 @@
>  			__start_mcount_loc = .;			\
>  			KEEP(*(__patchable_function_entries))	\
>  			__stop_mcount_loc = .;			\
> -			ftrace_graph_stub = ftrace_stub;
> +			ftrace_stub_graph = ftrace_stub;
>  #else
>  #define MCOUNT_REC()	. = ALIGN(8);				\
>  			__start_mcount_loc = .;			\
>  			KEEP(*(__mcount_loc))			\
>  			__stop_mcount_loc = .;			\
> -			ftrace_graph_stub = ftrace_stub;
> +			ftrace_stub_graph = ftrace_stub;
>  #endif
>  #else
>  # ifdef CONFIG_FUNCTION_TRACER
> -#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
> +#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
>  # else
>  #  define MCOUNT_REC()
>  # endif
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index fa3ce10d0405..67e0c462b059 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -336,10 +336,10 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
>   * Simply points to ftrace_stub, but with the proper protocol.
>   * Defined by the linker script in linux/vmlinux.lds.h
>   */
> -extern void ftrace_graph_stub(struct ftrace_graph_ret *);
> +extern void ftrace_stub_graph(struct ftrace_graph_ret *);
>  
>  /* The callbacks that hook a function */
> -trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_stub;
> +trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
>  trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
>  
> @@ -619,7 +619,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		goto out;
>  
>  	ftrace_graph_active--;
> -	ftrace_graph_return = ftrace_graph_stub;
> +	ftrace_graph_return = ftrace_stub_graph;
>  	ftrace_graph_entry = ftrace_graph_entry_stub;
>  	__ftrace_graph_entry = ftrace_graph_entry_stub;
>  	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
