Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAB7218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfCUULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfCUULy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:11:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE44218A5;
        Thu, 21 Mar 2019 20:11:52 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:11:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321161151.0d10b6d7@gandalf.local.home>
In-Reply-To: <20190321200316.GC2490@worktop.programming.kicks-ass.net>
References: <20190321090241.GL6521@hirez.programming.kicks-ass.net>
        <20190321104517.GM6521@hirez.programming.kicks-ass.net>
        <20190321093242.4a948198@gandalf.local.home>
        <20190321172203.GS5996@hirez.programming.kicks-ass.net>
        <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
        <20190321141020.641e313f@gandalf.local.home>
        <20190321182830.GV5996@hirez.programming.kicks-ass.net>
        <20190321145551.4c80c3a7@gandalf.local.home>
        <20190321193152.GB2490@worktop.programming.kicks-ass.net>
        <20190321155006.5288345f@gandalf.local.home>
        <20190321200316.GC2490@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 21:03:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Doesn't make sense; you say data, but then talk code and i$.

Ah, you meant d$

> 
> Not the point, spinlock_t is 4 bytes, but growns into a monster with
> lockdep on. There are plenty locations where the spinlock and the data
> it protects fit together into a single cacheline, no longer so with
> lockdep on.
> 
> Another example is split pte locks, without lockdep they are in struct
> page, with lockdep, they're a separate allocation, adding pointer
> chases.
> 
> Also; I do not, and have never done so, understood the desire to have
> this unified kernel. Building another kernel just isn't a problem, esp.
> not if you're doing kernel development to begin with.

It's not for the typical kernel developer like you and me. It's about
shipping to the customers. Shipping multiple kernels is a pain. Lockdep
has some features that can be used in production environments, like
seeing lock contention and irq latency. Most of that code is dependent
on lockdep. Having just tracing of locks and such would be useful. But
that also relies heavily on the lockdep infrastructure.

> 
> Making debug code complicated, such that you need to spend more time
> debugging the debug code, just doens't make sense to me either.

Perhaps this can also help clean it up, and organize it. Sometimes
adding features makes the code cleaner (see what RT has done to the
kernel).

-- Steve
