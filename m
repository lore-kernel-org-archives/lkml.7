Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A715EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B13218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCOVdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfCOVdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:33:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FC0218A1;
        Fri, 15 Mar 2019 21:33:36 +0000 (UTC)
Date:   Fri, 15 Mar 2019 17:33:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: kdb: Allow ftdump to skip all but the last
 few lines
Message-ID: <20190315173335.578c6cc1@gandalf.local.home>
In-Reply-To: <CAD=FV=UHybx9ACyWePjxyqUiH7ixokPEoJYf43BvojT1U1ZB=g@mail.gmail.com>
References: <20190315174528.16531-1-dianders@chromium.org>
        <20190315144130.1aa36931@gandalf.local.home>
        <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
        <20190315161203.25dc2a0c@gandalf.local.home>
        <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
        <20190315170822.6316f3cb@gandalf.local.home>
        <CAD=FV=UHybx9ACyWePjxyqUiH7ixokPEoJYf43BvojT1U1ZB=g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:28:39 -0700
Doug Anderson <dianders@chromium.org> wrote:

> I had a little bit of a hard time figuring out if print_trace_line()
> plus trace_printk_seq() always printed one line or always printed one
> entry.  I guess the point I was making was that in v1 of my patch it
> wouldn't matter because the pseudo code looked like:
> 
> 1. Count how many "things" would be printed, but don't printed them.
> 
> 2. Use math to figure out how many "things" to skip given that we want
> to print the last N "things".
> 
> 3. Skip the "things" the math told us to and then print the last N "things".
> 
> ...but it sounds like it _must_ print one entry because we're looping
> over trace_find_next_entry_inc().  That means that the existing "skip
> lines" that predates my patch should actually be "skip entries".  I'd
> be happy adjusting the help text (and local variable name) so that
> "skip_lines" is instead "skip_entries".  I think that would avoid
> confusion everywhere.  It doesn't change behavior but just documents
> the existing behavior.

Sounds like a plan.

> 
> 
> With that I can use your optimized path assuming you can confirm that
> "tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ" doesn't affect how many
> entries will be iterated over by trace_find_next_entry_inc().

Here's the code:

	trace_seq_puts(s, "<user stack trace>\n"); <=== already prints a line regardless of SYM_USEROBJ.

	if (tr->trace_flags & TRACE_ITER_SYM_USEROBJ) {
		struct task_struct *task;
		/*
		 * we do the lookup on the thread group leader,
		 * since individual threads might have already quit!
		 */
		rcu_read_lock();
		task = find_task_by_vpid(field->tgid);
		if (task)
			mm = get_task_mm(task);
		rcu_read_unlock();
	}

-- Steve
