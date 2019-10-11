Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC36820679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfJKS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbfJKS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:26:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424EB20673;
        Fri, 11 Oct 2019 18:26:52 +0000 (UTC)
Date:   Fri, 11 Oct 2019 14:26:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix function type mismatches
Message-ID: <20191011142650.36404713@gandalf.local.home>
In-Reply-To: <201910101411.98362BA0@keescook>
References: <20191007214740.188547-1-samitolvanen@google.com>
        <201910101411.98362BA0@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 14:12:24 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Oct 07, 2019 at 02:47:40PM -0700, Sami Tolvanen wrote:
> > This change fixes indirect call mismatches with function and function
> > graph tracing, which trip Control-Flow Integrity (CFI) checking.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>  
> 
> Thanks for sending this! We're getting pretty close to having all the
> various CFI issues cleaned up now. :)

Unfortunately, this breaks function graph tracing. There's lots of arch
code that tests if the function graph tracer is set to point to the
ftrace_stub. Which by the way is a nop function written in assembly.

Is there a way to do an alias or something that can fix whatever you
are trying to fix?
 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
> > ---
> >  kernel/trace/fgraph.c | 9 ++++++---
> >  kernel/trace/ftrace.c | 8 +++++---
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 7950a0356042..ecfd4a4a106a 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -327,14 +327,17 @@ void ftrace_graph_sleep_time_control(bool enable)
> >  	fgraph_sleep_time = enable;
> >  }
> >  
> > +void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
> > +{
> > +}
> > +
> >  int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
> >  {
> >  	return 0;
> >  }
> >  
> >  /* The callbacks that hook a function */
> > -trace_func_graph_ret_t ftrace_graph_return =
> > -			(trace_func_graph_ret_t)ftrace_stub;
> > +trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_return_stub;
> >  trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
> >  static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
> >  
> > @@ -614,7 +617,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
> >  		goto out;
> >  
> >  	ftrace_graph_active--;
> > -	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
> > +	ftrace_graph_return = ftrace_graph_return_stub;
> >  	ftrace_graph_entry = ftrace_graph_entry_stub;
> >  	__ftrace_graph_entry = ftrace_graph_entry_stub;
> >  	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 62a50bf399d6..b68ee130d4a2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -125,8 +125,9 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  				 struct ftrace_ops *op, struct pt_regs *regs);
> >  #else
> >  /* See comment below, where ftrace_ops_list_func is defined */
> > -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> > -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
> > +static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
> > +			      struct ftrace_ops *op, struct pt_regs *regs);
> > +#define ftrace_ops_list_func ftrace_ops_no_ops
> >  #endif
> >  
> >  static inline void ftrace_ops_init(struct ftrace_ops *ops)
> > @@ -6325,7 +6326,8 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  }
> >  NOKPROBE_SYMBOL(ftrace_ops_list_func);
> >  #else
> > -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
> > +static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
> > +			      struct ftrace_ops *op, struct pt_regs *regs)

Also, this happens to be done because the arch only passes in the first
two parameters. That's why this is called when ARCH_SUPPORTS_FTRACE_OPS
is net set.

The Linux world is not x86 only!

-- Steve


> >  {
> >  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
> >  }
> > -- 
> > 2.23.0.581.g78d2f28ef7-goog
> >   
> 

