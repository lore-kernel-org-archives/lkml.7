Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F62DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECEE21929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfJXU2n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfJXU2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:28:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA39D21872;
        Thu, 24 Oct 2019 20:28:40 +0000 (UTC)
Date:   Thu, 24 Oct 2019 16:28:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024162839.5144abdd@gandalf.local.home>
In-Reply-To: <20191024202455.GK4114@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
        <20191018074634.801435443@infradead.org>
        <20191021222110.49044eb5@oasis.local.home>
        <20191022202401.GO1817@hirez.programming.kicks-ass.net>
        <20191023145245.53c75d70@gandalf.local.home>
        <20191024101609.GA4131@hirez.programming.kicks-ass.net>
        <20191024110024.324a9435@gandalf.local.home>
        <20191024164320.GD4131@hirez.programming.kicks-ass.net>
        <20191024141731.5c7c414c@gandalf.local.home>
        <20191024202455.GK4114@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 22:24:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 24, 2019 at 02:17:31PM -0400, Steven Rostedt wrote:
> > On Thu, 24 Oct 2019 18:43:20 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > > 
> > > >   CC [M]  drivers/gpu/drm/i915/gem/i915_gem_context.o
> > > > /work/git/linux-trace.git/kernel/trace/trace_events_hist.c: In function ‘register_synth_event’:
> > > > /work/git/linux-trace.git/kernel/trace/trace_events_hist.c:1157:15: error: ‘struct trace_event_class’ has no member named ‘define_fields’; did you mean ‘get_fields’?
> > > >   call->class->define_fields = synth_event_define_fields;
> > > >                ^~~~~~~~~~~~~
> > > >                get_fields
> > > > make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:265: kernel/trace/trace_events_hist.o] Error 1
> > > > make[3]: *** Waiting for unfinished jobs....    
> > > 
> > > allmodconfig clean
> > > 
> > > (omg, so much __field(); fail)  
> > 
> > Well it built without warnings and passed the ftrace selftests.
> > 
> > I haven't ran it through the full suite, but that can wait for the v5.  
> 
> I'll push it out to git to the 0day robot can have a go at it. For v5
> I'm still staring at some KLP borkage. Then again, maybe I should delay
> that last bit and make that a new series.

Also note, that I'm about to travel to Lyon for Open Source Summit,
thus my looking at this will come pretty much to a stand still :-/

-- Steve
