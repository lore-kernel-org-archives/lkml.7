Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30FDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B7F21835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJJOzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfJJOzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:55:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA78B214E0;
        Thu, 10 Oct 2019 14:55:16 +0000 (UTC)
Date:   Thu, 10 Oct 2019 10:55:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010105515.5eba7f31@gandalf.local.home>
In-Reply-To: <20191010122909.GK2359@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
        <20191010073121.GN2311@hirez.programming.kicks-ass.net>
        <20191010093329.GI2359@hirez.programming.kicks-ass.net>
        <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
        <20191010122909.GK2359@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 14:29:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Yes, your code is anal about checking the NOPs, so you first have to

Yep, because being paranoid about modifying code is always good ;-)

> write NOPs before you can write CALLs, if it is enabled. But afaict you
> really can do all that from ftrace_module_init(), as long as you do it
> all under the same ftrace_lock section.
> 
> If you have two sections, like now, then there is indeed that race that
> ftrace can get enabled in between, and all the confusion that that
> brings.
> 
> That is, what's fundamentally buggered about something like this?
> 
> ---
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 62a50bf399d6..5f7113f100ce 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5626,6 +5626,48 @@ static int ftrace_process_locs(struct module *mod,
>  	ftrace_update_code(mod, start_pg);
>  	if (!mod)
>  		local_irq_restore(flags);
> +
> +	if (ftrace_disabled || !mod)
> +		goto out_loop;
> +
> +	do_for_each_ftrace_rec(pg, rec) {

[snip]

> +
> +		if (ftrace_start_up && cnt) {
> +			int failed = __ftrace_replace_code(rec, 1);

OK, so basically this moves the enabling of function tracing from
within the ftrace_module_enable() code without releasing the
ftrace_lock mutex.

But we have an issue with the state of the module here, as it is still
set as MODULE_STATE_UNFORMED. Let's look at what happens if we have:


	CPU0				CPU1
	----				----
 echo function > current_tracer
				modprobe foo
				  enable foo functions to be traced
				  (foo function records not disabled)
 echo nop > current_tracer

   disable all functions being
   traced including foo functions

   arch calls set_all_modules_text_rw()
    [skips UNFORMED modules, which foo still is ]

				  set foo's text to read-only
				  foo's state to COMING

   tries to disable foo's functions
   foo's text is read-only

   BUG trying to write to ro text!!!


Like I said, this is very subtle. It may no longer be a bug on x86
with your patches, but it will bug on ARM or anything else that still
uses set_all_modules_text_rw() in the ftrace prepare code.

-- Steve




> +			if (failed) {
> +				ftrace_bug(failed, rec);
> +				goto out_loop;
> +			}
> +		}
> +
> +	} while_for_each_ftrace_rec();
> +
> + out_loop:
> +
>  	ret = 0;
>   out:
>  	mutex_unlock(&ftrace_lock);
> @@ -5793,73 +5835,6 @@ void ftrace_release_mod(struct module *mod)
>  
>  void ftrace_module_enable(struct module *mod)
>  {
> -	struct dyn_ftrace *rec;
> -	struct ftrace_page *pg;
> -
> -	mutex_lock(&ftrace_lock);
> -
> -	if (ftrace_disabled)
> -		goto out_unlock;
> -
> -	/*
> -	 * If the tracing is enabled, go ahead and enable the record.
> -	 *
> -	 * The reason not to enable the record immediately is the
> -	 * inherent check of ftrace_make_nop/ftrace_make_call for
> -	 * correct previous instructions.  Making first the NOP
> -	 * conversion puts the module to the correct state, thus
> -	 * passing the ftrace_make_call check.
> -	 *
> -	 * We also delay this to after the module code already set the
> -	 * text to read-only, as we now need to set it back to read-write
> -	 * so that we can modify the text.
> -	 */
> -	if (ftrace_start_up)
> -		ftrace_arch_code_modify_prepare();
> -
> -	do_for_each_ftrace_rec(pg, rec) {
> -		int cnt;
> -		/*
> -		 * do_for_each_ftrace_rec() is a double loop.
> -		 * module text shares the pg. If a record is
> -		 * not part of this module, then skip this pg,
> -		 * which the "break" will do.
> -		 */
> -		if (!within_module_core(rec->ip, mod) &&
> -		    !within_module_init(rec->ip, mod))
> -			break;
> -
> -		cnt = 0;
> -
> -		/*
> -		 * When adding a module, we need to check if tracers are
> -		 * currently enabled and if they are, and can trace this record,
> -		 * we need to enable the module functions as well as update the
> -		 * reference counts for those function records.
> -		 */
> -		if (ftrace_start_up)
> -			cnt += referenced_filters(rec);
> -
> -		/* This clears FTRACE_FL_DISABLED */
> -		rec->flags = cnt;
> -
> -		if (ftrace_start_up && cnt) {
> -			int failed = __ftrace_replace_code(rec, 1);
> -			if (failed) {
> -				ftrace_bug(failed, rec);
> -				goto out_loop;
> -			}
> -		}
> -
> -	} while_for_each_ftrace_rec();
> -
> - out_loop:
> -	if (ftrace_start_up)
> -		ftrace_arch_code_modify_post_process();
> -
> - out_unlock:
> -	mutex_unlock(&ftrace_lock);
> -
>  	process_cached_mods(mod->name);
>  }
>  

