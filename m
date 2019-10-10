Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A735C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A9208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfJJNUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfJJNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:20:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456B92064A;
        Thu, 10 Oct 2019 13:19:58 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:19:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010091956.48fbcf42@gandalf.local.home>
In-Reply-To: <20191010092054.GR2311@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
        <20191009224135.2dcf7767@oasis.local.home>
        <20191010092054.GR2311@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 11:20:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 09, 2019 at 10:41:35PM -0400, Steven Rostedt wrote:
> > On Tue, 8 Oct 2019 10:43:35 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> >   
> > > BTW, I'd really like to take this patch series through my tree. That
> > > way I can really hammer it, as well as I have code that will be built
> > > on top of it.  
> > 
> > I did a bit of hammering and found two bugs. One I sent a patch to fix
> > (adding a module when tracing is enabled), but the other bug I
> > triggered, I'm too tired to debug right now. But figured I'd mention it
> > anyway.  
> 
> I'm thinking this should fix it... Just not sure this is the right plce,
> then again, we're doing the same thing in jump_label and static_call, so
> perhaps we should do it like this.
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1230,10 +1230,15 @@ void text_poke_queue(void *addr, const v
>   * dynamically allocated memory. This function should be used when it is
>   * not possible to allocate memory.
>   */
> -void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> +void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
>  {
>  	struct text_poke_loc tp;
>  
> +	if (unlikely(system_state == SYSTEM_BOOTING)) {
> +		text_poke_early(addr, opcode, len);
> +		return;
> +	}

We need a new system state. SYSTEM_UP ? (Arg, that name is confusing,
SYSTEM_BOOTING_SMP?) Or perhaps just test num_online_cpus()?

	if (unlikely(system_state == SYSTEM_BOOTING &&
		     num_online_cpus() == 1)

?

Because we can't do the above once we have more than one CPU running.

-- Steve

> +
>  	text_poke_loc_init(&tp, addr, opcode, len, emulate);
>  	text_poke_bp_batch(&tp, 1);
>  }

