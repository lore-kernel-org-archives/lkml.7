Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B2BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62876218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfJJRsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfJJRsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:48:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7612421835;
        Thu, 10 Oct 2019 17:48:31 +0000 (UTC)
Date:   Thu, 10 Oct 2019 13:48:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010134830.72ccef3d@gandalf.local.home>
In-Reply-To: <20191010172819.GS2328@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
        <20191009224135.2dcf7767@oasis.local.home>
        <20191010092054.GR2311@hirez.programming.kicks-ass.net>
        <20191010091956.48fbcf42@gandalf.local.home>
        <20191010140513.GT2311@hirez.programming.kicks-ass.net>
        <20191010115449.22044b53@gandalf.local.home>
        <20191010172819.GS2328@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 19:28:19 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > That is, I really hate the above "set_ro" hack. This is because you
> > moved the ro setting to create_trampoline() and then forcing the
> > text_poke() on text that has just been created. I prefer to just modify
> > it and then setting it to ro before it gets executed. Otherwise we need
> > to do all these dances.  
> 
> I thought create_trampoline() finished the whole thing; if it does not,
> either make create_trampoline() do everything, or add a
> finish_trampoline() callback to mark it complete.

I'm good with a finish_trampoline(). I can make a patch that does that.

> 
> > The same is with the module code. My patch was turning text to
> > read-write that is not to be executed yet. Really, what's wrong with
> > that?  
> 
> The fact that it is executable; also the fact that you do it right after
> we mark it ro. Flipping the memory protections back and forth is just
> really poor everything.

Hmm, I wonder if we can work with a way to make this work in the module
code as well. Moving the place it sets 'x' and 'ro' around :-/

> 
> Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
> executable (kernel) memory writable.

OK.

> 
> Really the best solution is to move all the poking into
> ftrace_module_init(), before we mark it RO+X. That's what I'm going to
> do for jump_label and static_call as well, I just need to add that extra
> notifier callback.

I'll have to think about other ways to handle the other archs with the
all or nothing approach. Perhaps we can use my patch as an arch
dependent situation, I'll try another approach.

-- Steve
