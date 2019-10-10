Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF958C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD809206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfJJMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733171AbfJJMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:50:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767012067B;
        Thu, 10 Oct 2019 12:50:13 +0000 (UTC)
Date:   Thu, 10 Oct 2019 08:50:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010085011.3734d87b@gandalf.local.home>
In-Reply-To: <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
        <20191010073121.GN2311@hirez.programming.kicks-ass.net>
        <20191010093329.GI2359@hirez.programming.kicks-ass.net>
        <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 11:36:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > > The reason is that ftrace_module_enable() is called after the module
> > > > has set its text to read-only. There's subtle reasons that this needs
> > > > to be called afterward, and we need to continue to do so.  
> > > 
> > > Please explain.  

I knew you were going to say that ;-)

I was too tired last night to go back and see all the issues.

> > 
> > I don't see any reason what so ever..
> > 
> > load_module()
> >   ...
> >   complete_formation()
> >     mutex_lock(&module_mutex);
> >     ...
> >     module_enable_ro();
> >     module_enable_nx();
> >     module_enable_x();
> > 
> >     mod->state = MODULE_STATE_COMING;
> >     mutex_unlock(&module_mutex);
> > 
> >   prepare_coming_module()
> >     ftrace_module_enable();
> >     ...
> > 
> > IOW, we're doing ftrace_module_enable() immediately after we flip it
> > RO+X. There is nothing in between that we can possibly rely on.

One reason for the above is the module_mutex. The lock order is that
module_mutex may be called inside the ftrace_lock, but not vice-versa.

The ftrace_module_init() was called due to the setting of all modules
rw when registering a ftrace function while a module was being loaded.
We may have eliminated this issue on x86 but other archs still call
set_all_modules_text_rw/ro() when enabling function tracing. Thus, the
race will still exist there.

See commit a949ae560a511 for the description of it.

After implementing that commit, I found it a bit cleaner to handle
modules in general by breaking it up into setting nops first, and then
determining if we need to trace that module.


> > 
> > I was going to put:
> > 
> >   blocking_notifier_call_chain(&module_notify_list,
> > 			       MODULE_STATE_UNFORMED, mod);
> > 
> > right before module_enable_ro(), in complete_formation(), for jump_label
> > and static_call. It looks like ftrace (and possibly klp) want that too.  
> 
> Also, you already have ftrace_module_init() right before that. The only
> thing inbetween ftrace_module_init() and ftrace_module_enable() is
> verify_exported_symbols() and module_bug_finalize().

Yep, see commit a949ae560a511 about that too.

> 
> Do you really need that for patching stuff?

Because arm and nds32 still use the set_all_modules_text_rw(), this
patch would at least remove that for all archs, and only modify the
text of a module that isn't running yet. Which I thought was a plus.

Just need to be careful about other archs, or we need to at least make
sure they change too.

-- Steve
