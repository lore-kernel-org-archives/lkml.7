Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF60C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfG3CPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbfG3CPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:15:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208772064C;
        Tue, 30 Jul 2019 02:15:08 +0000 (UTC)
Date:   Mon, 29 Jul 2019 22:15:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        fweisbec@gmail.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
Message-ID: <20190729221506.1aed7dfc@oasis.local.home>
In-Reply-To: <2ceec933-503e-5d58-60b4-85b491b017d4@etsukata.com>
References: <20190729010734.3352-1-devel@etsukata.com>
        <20190729112126.6554b141@gandalf.local.home>
        <2ceec933-503e-5d58-60b4-85b491b017d4@etsukata.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 11:00:42 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> Thanks for comments.
> 
> On 2019/07/30 0:21, Steven Rostedt wrote:
> > On Mon, 29 Jul 2019 10:07:34 +0900
> > Eiichi Tsukata <devel@etsukata.com> wrote:
> >   
> >> If context tracking is enabled, causing page fault in preemptirq
> >> irq_enable or irq_disable events triggers the following RCU EQS warning.
> >>
> >> Reproducer:
> >>
> >>   // CONFIG_PREEMPTIRQ_EVENTS=y
> >>   // CONFIG_CONTEXT_TRACKING=y
> >>   // CONFIG_RCU_EQS_DEBUG=y
> >>   # echo 1 > events/preemptirq/irq_disable/enable
> >>   # echo 1 > options/userstacktrace  
> > 
> > So the problem is only with userstacktrace enabled?  
> 
> It can happen when tracing code causes page fault in preemptirq events.
> For example, the following perf command also hit the warning:
> 
>   # perf record -e 'preemptirq:irq_enable' -g ls

Again,

That's not a irq trace event issue, that's a stack trace issue.

> 
> 
> >>  
> >>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
> >>  {
> >> +	enum ctx_state prev_state;
> >> +
> >>  	if (this_cpu_read(tracing_irq_cpu)) {
> >> -		if (!in_nmi())
> >> +		if (!in_nmi()) {  
> > 
> > This is a very high fast path (for tracing irqs off and such). Instead
> > of adding a check here for a case that is seldom used (userstacktrace
> > and tracing irqs on/off). Move this to surround the userstack trace
> > code.
> > 
> > -- Steve  
> 
> If the problem was only with userstacktrace, it will be reasonable to
> surround only the userstack unwinder. But the situation is similar to
> the previous "tracing vs CR2" case. As Peter taught me in
> https://lore.kernel.org/lkml/20190708074823.GV3402@hirez.programming.kicks-ass.net/
> there are some other codes likely to to user access.
> So I surround preemptirq events earlier.

I disagree. The issue is with the attached callbacks that call
something (a stack unwinder) that can fault.

This is called whenever irqs are disabled. I say we surround the
culprit (the stack unwinder or stack trace) and not punish the irq
enable/disable events.

So NAK on this patch.

-- Steve

