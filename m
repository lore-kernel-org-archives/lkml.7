Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B72C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A86B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfDJMrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbfDJMrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:47:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B8A320818;
        Wed, 10 Apr 2019 12:47:05 +0000 (UTC)
Date:   Wed, 10 Apr 2019 08:47:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [RFC patch 17/41] tracing: Make stack_trace_print() static and
 rename it
Message-ID: <20190410084703.2b702e70@gandalf.local.home>
In-Reply-To: <20190410103645.136887071@linutronix.de>
References: <20190410102754.387743324@linutronix.de>
        <20190410103645.136887071@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 12:28:11 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> It's only used in the source file where it is defined and it's using the
> stack_trace_ namespace. Rename it to free it up for stack trace related
> functions.
> 

Can you put it back to its original name "print_max_stack()" which was
changed by this commit:

bb99d8ccec7 ("tracing: Allow arch-specific stack tracer")

I actually want to do a clean up and remove all "trace_" functions that
are not a tracepoint. It's getting confusing to see a "trace_..." and
search for the corresponding TRACE_EVENT() macro and not being able to
find it.

Hmm, I'm not sure why Akashi changed that function to be global in the
first place. It looks like only check_stack() needed to be changed.

Akashi?

-- Steve


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h     |    1 -
>  kernel/trace/trace_stack.c |    4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -251,7 +251,6 @@ extern unsigned long stack_trace_max_siz
>  extern arch_spinlock_t stack_trace_max_lock;
>  
>  extern int stack_tracer_enabled;
> -void stack_trace_print(void);
>  int
>  stack_trace_sysctl(struct ctl_table *table, int write,
>  		   void __user *buffer, size_t *lenp,
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -41,7 +41,7 @@ static DEFINE_MUTEX(stack_sysctl_mutex);
>  int stack_tracer_enabled;
>  static int last_stack_tracer_enabled;
>  
> -void stack_trace_print(void)
> +static void trace_stack_trace_print(void)
>  {
>  	long i;
>  	int size;
> @@ -179,7 +179,7 @@ check_stack(unsigned long ip, unsigned l
>  	stack_trace_max.nr_entries = x;
>  
>  	if (task_stack_end_corrupted(current)) {
> -		stack_trace_print();
> +		trace_stack_trace_print();
>  		BUG();
>  	}
>  
> 

