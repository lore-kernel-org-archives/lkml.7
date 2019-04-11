Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA006C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79358217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDKDID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDKDID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:08:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BD520818;
        Thu, 11 Apr 2019 03:08:02 +0000 (UTC)
Date:   Wed, 10 Apr 2019 23:07:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 16/41] tracing: Remove the ULONG_MAX stack trace
 hackery
Message-ID: <20190410230759.7a0c2c10@oasis.local.home>
In-Reply-To: <20190411023425.f7aolamijvxdcuvp@treble>
References: <20190410102754.387743324@linutronix.de>
        <20190410103645.048761764@linutronix.de>
        <20190411023425.f7aolamijvxdcuvp@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 21:34:25 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -18,8 +18,7 @@
> >  
> >  #include "trace.h"
> >  
> > -static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
> > -	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
> > +static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES + 1];  
> 
> Is the "+ 1" still needed?  AFAICT, accesses to this array never go past
> nr_entries.

Probably not. But see this for an explanation:

 http://lkml.kernel.org/r/20180620110758.crunhd5bfep7zuiz@kili.mountain


> 
> Also I've been staring at the code but I can't figure out why
> max_entries is "- 1".
> 
> struct stack_trace stack_trace_max = {
> 	.max_entries		= STACK_TRACE_ENTRIES - 1,
> 	.entries		= &stack_dump_trace[0],
> };
> 

Well, it had a reason in the past, but there doesn't seem to be a
reason today.  Looking at git history, that code was originally:

	.max_entries		= STACK_TRACE_ENTRIES - 1,
	.entries		= &stack_dump_trace[1],

Where we had to make max_entries -1 as we started at the first index
into the array.

I'll have to take a new look into this code. After Thomas's clean up
here, I'm sure we can simplify it a bit more.

-- Steve

