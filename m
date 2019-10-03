Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3BAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA77215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfJCWKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfJCWKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:10:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7655C20867;
        Thu,  3 Oct 2019 22:10:47 +0000 (UTC)
Date:   Thu, 3 Oct 2019 18:10:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191003181045.7fb1a5b3@gandalf.local.home>
In-Reply-To: <20191002182106.GC4643@worktop.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 20:21:06 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 02, 2019 at 06:35:26PM +0200, Daniel Bristot de Oliveira wrote:
> 
> > ftrace was already batching the updates, for instance, causing 3 IPIs to enable
> > all functions. The text_poke() batching also works. But because of the limited
> > buffer [ see the reply to the patch 2/3 ], it is flushing the buffer during the
> > operation, causing more IPIs than the previous code. Using the 5.4-rc1 in a VM,
> > when enabling the function tracer, I see 250+ intermediate text_poke_finish()
> > because of a full buffer...
> > 
> > Would this be the case of trying to use a dynamically allocated buffer?
> > 
> > Thoughts?  
> 
> Is it a problem? I tried growing the buffer (IIRC I made it 10 times
> bigger) and didn't see any performance improvements because of it.

I'm just worried if people are going to complain about the IPI burst.
Although, I just tried it out before applying this patch, and there's
still a bit of a burst. Not sure why. I did:

# cat /proc/interrupts > /tmp/before; echo function > /debug/tracing/current_tracer; cat /proc/interrupts > /tmp/after
# cat /proc/interrupts > /tmp/before1; echo nop > /debug/tracing/current_tracer; cat /proc/interrupts > /tmp/after1

Before this patch:

# diff /tmp/before /tmp/after
< CAL:       2342       2347       2116       2175       2446       2030       2416       2222   Function call interrupts
---
> CAL:       2462       2467       2236       2295       2446       2150       2536       2342   Function call interrupts

(Just showing the function call interrupts)

There appears to be 120 IPIs sent to all CPUS for enabling function tracer.

# diff /tmp/before1 /tmp/after1
< CAL:       2462       2467       2236       2295       2446       2150       2536       2342   Function call interrupts
---
> CAL:       2577       2582       2351       2410       2446       2265       2651       2457   Function call interrupts

And 151 IPIs for disabling it.

After applying this patch:

# diff /tmp/before /tmp/after
< CAL:      66070      46620      59955      59236      68707      63397      61644      62742   Function call interrupts
---
> CAL:      66727      47277      59955      59893      69364      64054      62301      63399   Function call interrupts

# diff /tmp/before1 /tmp/after1
< CAL:      66727      47277      59955      59893      69364      64054      62301      63399   Function call interrupts
---
> CAL:      67358      47938      59985      60554      70025      64715      62962      64060   Function call interrupts


We get 657 IPIs for enabling function tracer, and 661 for disabling it.
Funny how it's more on the disable than the enable with the patch but
the other way without it.

But still, we are going from 120 to 660 IPIs for every CPU. Not saying
it's a problem, but something that we should note. Someone (those that
don't like kernel interference) may complain.

-- Steve
