Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BF8206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKJWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 17:01:03 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:55209 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727080AbfKJWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:01:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 310B9100E7B40;
        Sun, 10 Nov 2019 22:01:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: river90_25ddd2f9e5c25
X-Filterd-Recvd-Size: 2113
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Nov 2019 22:01:00 +0000 (UTC)
Message-ID: <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 10 Nov 2019 14:00:44 -0800
In-Reply-To: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 10:21 +0000, Thomas Gleixner wrote:
> A small fix for a stacktrace regression. Saving a stacktrace for a foreign
> task skipped an extra entry which makes e.g. the output of /proc/$PID/stack
> incomplete.
[]
> ------------------>
> Jiri Slaby (1):
>       stacktrace: Don't skip first entry on noncurrent tasks
[]
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
[]
> @@ -141,7 +141,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
>  	struct stacktrace_cookie c = {
>  		.store	= store,
>  		.size	= size,
> -		.skip	= skipnr + 1,
> +		/* skip this function if they are tracing us */
> +		.skip	= skipnr + !!(current == tsk),

trivia:

This idiom '!!(logical test)' is odd and redundant.
Logical test result is already 0 or 1, no !! is unnecessary.

>  	};
>  
>  	if (!try_get_task_stack(tsk))
> @@ -298,7 +299,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
>  	struct stack_trace trace = {
>  		.entries	= store,
>  		.max_entries	= size,
> -		.skip		= skipnr + 1,
> +		/* skip this function if they are tracing us */
> +		.skip	= skipnr + !!(current == task),
>  	};
>  
>  	save_stack_trace_tsk(task, &trace);
> 
> 

