Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D2C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233FE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKDdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:33:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKDdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:33:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8B5030821C2;
        Thu, 11 Apr 2019 03:33:23 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1F11171C4;
        Thu, 11 Apr 2019 03:33:22 +0000 (UTC)
Date:   Wed, 10 Apr 2019 22:33:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 40/41] stacktrace: Remove obsolete functions
Message-ID: <20190411033320.64zafrthhsm2ohdm@treble>
References: <20190410102754.387743324@linutronix.de>
 <20190410103647.205989744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410103647.205989744@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 11 Apr 2019 03:33:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:28:34PM +0200, Thomas Gleixner wrote:
> No more users of the struct stack_trace based interfaces. Remove them.
> 
> Remove the macro stubs for !CONFIG_STACKTRACE as well as they are pointless
> because the storage on the call sites is conditional on CONFIG_STACKTRACE
> already. No point to be 'smart'.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/stacktrace.h |   46 +++++++++++++++------------------------------
>  kernel/stacktrace.c        |   14 -------------
>  2 files changed, 16 insertions(+), 44 deletions(-)
> 
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -8,23 +8,6 @@ struct task_struct;
>  struct pt_regs;
>  
>  #ifdef CONFIG_STACKTRACE
> -struct stack_trace {
> -	unsigned int nr_entries, max_entries;
> -	unsigned long *entries;
> -	int skip;	/* input argument: How many entries to skip */
> -};
> -
> -extern void save_stack_trace(struct stack_trace *trace);
> -extern void save_stack_trace_regs(struct pt_regs *regs,
> -				  struct stack_trace *trace);
> -extern void save_stack_trace_tsk(struct task_struct *tsk,
> -				struct stack_trace *trace);
> -extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> -					 struct stack_trace *trace);
> -
> -extern void print_stack_trace(struct stack_trace *trace, int spaces);
> -extern int snprint_stack_trace(char *buf, size_t size,
> -			struct stack_trace *trace, int spaces);
>  
>  extern void stack_trace_print(unsigned long *trace, unsigned int nr_entries,
>  			      int spaces);
> @@ -43,20 +26,23 @@ extern unsigned int stack_trace_save_reg
>  extern unsigned int stack_trace_save_user(unsigned long *store,
>  					  unsigned int size,
>  					  unsigned int skipnr);
> +/*
> + * The below is for stack trace internals and architecture
> + * implementations. Do not use in generic code.
> + */
> +struct stack_trace {
> +	unsigned int nr_entries, max_entries;
> +	unsigned long *entries;
> +	int skip;	/* input argument: How many entries to skip */
> +};

I was a bit surprised to see struct stack_trace still standing at the
end of the patch set, but I guess 41 patches is enough :-)  Do we want
to eventually remove the struct altogether?

I was also hoping to see the fragile "skipnr" go away in favor of
something less dependent on compiler optimizations, but I'm not sure how
feasible that would be.

Regardless, these are very nice cleanups, nice work.

> -#ifdef CONFIG_USER_STACKTRACE_SUPPORT
> +extern void save_stack_trace(struct stack_trace *trace);
> +extern void save_stack_trace_regs(struct pt_regs *regs,
> +				  struct stack_trace *trace);
> +extern void save_stack_trace_tsk(struct task_struct *tsk,
> +				struct stack_trace *trace);
> +extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> +					 struct stack_trace *trace);

save_stack_trace_tsk_reliable() is still in use by generic livepatch
code.

Also I wonder if it would make sense to rename these to
__save_stack_trace_*() or arch_save_stack_trace_*() to help discourage
them from being used by generic code.

-- 
Josh
