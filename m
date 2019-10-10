Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796322067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJqZYKFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfJJVM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:12:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:12:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so3256379pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HEAgwKdOoQC6Wd9HJsO0tDBZQypgFf5snhFdbKdfnZI=;
        b=HJqZYKFFJo/XZSPavT78d2YKlU9WJWvPx0wB4ao3Q/rWUk7ZrystYVsOvLIp2H+EQf
         Ofb4g2pWKoQJXFClpvlz33RB/XtxBrrAOCSeztsqH2qTZUcAO/L0CrBxg5D+yMWjM635
         FsmkZkfDWF7NNP5KcSsLTeQupmnbUk+eA/Hqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HEAgwKdOoQC6Wd9HJsO0tDBZQypgFf5snhFdbKdfnZI=;
        b=T6aIDXsfDpcH6ll7gL+tL0g1VhTWfduRVeXGkTDc5u0xiOvbGLrU66mgu/T3jJ7RKG
         8CmgDKd0VB4QW27XWruvWJbWy7wb/UOY2U/6QYROLmfp8AoZOsuNBFoRrGAYsiiXIg7Q
         Yp577dh7b+kBMPJqUkDxPd1QJ9ICokliX5Q3rFM6E/UrXK5dlrid8OeQDb7ZiSd6grz/
         W5xjKWc6LDKB/g9zx+x08JCtluPxMiIRWC/w46TrN5erGJiWdIg3e4m8fh7os2ItsS4o
         I2Zpi+KedmnN26cXxPfcYKwgu8r5CjYbxPVbM0JGybIV1yPJezg4YvuNzzlWdTIiVRnF
         yNrA==
X-Gm-Message-State: APjAAAUzEdaYCEU2+1pzTcT2mEls5ikoHzilCHOPDvrWqoFTrOvOkecK
        Ubpssh7bB+wFMn9YAXzmMJrwxQ==
X-Google-Smtp-Source: APXvYqzP+jB7UJNAvicTteDJsCk5HjaiskubGM15qBj7BzwXIu39xsb4pJUNZOtakx/Y1+Pdvj4lAQ==
X-Received: by 2002:a65:5b05:: with SMTP id y5mr13564319pgq.48.1570741946089;
        Thu, 10 Oct 2019 14:12:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b22sm6317971pgg.2.2019.10.10.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:12:25 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:12:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix function type mismatches
Message-ID: <201910101411.98362BA0@keescook>
References: <20191007214740.188547-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007214740.188547-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:47:40PM -0700, Sami Tolvanen wrote:
> This change fixes indirect call mismatches with function and function
> graph tracing, which trip Control-Flow Integrity (CFI) checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for sending this! We're getting pretty close to having all the
various CFI issues cleaned up now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/trace/fgraph.c | 9 ++++++---
>  kernel/trace/ftrace.c | 8 +++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 7950a0356042..ecfd4a4a106a 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -327,14 +327,17 @@ void ftrace_graph_sleep_time_control(bool enable)
>  	fgraph_sleep_time = enable;
>  }
>  
> +void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
> +{
> +}
> +
>  int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
>  {
>  	return 0;
>  }
>  
>  /* The callbacks that hook a function */
> -trace_func_graph_ret_t ftrace_graph_return =
> -			(trace_func_graph_ret_t)ftrace_stub;
> +trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_return_stub;
>  trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
>  
> @@ -614,7 +617,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		goto out;
>  
>  	ftrace_graph_active--;
> -	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
> +	ftrace_graph_return = ftrace_graph_return_stub;
>  	ftrace_graph_entry = ftrace_graph_entry_stub;
>  	__ftrace_graph_entry = ftrace_graph_entry_stub;
>  	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 62a50bf399d6..b68ee130d4a2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -125,8 +125,9 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  				 struct ftrace_ops *op, struct pt_regs *regs);
>  #else
>  /* See comment below, where ftrace_ops_list_func is defined */
> -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
> +static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
> +			      struct ftrace_ops *op, struct pt_regs *regs);
> +#define ftrace_ops_list_func ftrace_ops_no_ops
>  #endif
>  
>  static inline void ftrace_ops_init(struct ftrace_ops *ops)
> @@ -6325,7 +6326,8 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  }
>  NOKPROBE_SYMBOL(ftrace_ops_list_func);
>  #else
> -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
> +static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
> +			      struct ftrace_ops *op, struct pt_regs *regs)
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
>  }
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
