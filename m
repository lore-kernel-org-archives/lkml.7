Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD8CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0422305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfHGRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfHGRVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:21:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B813E22296;
        Wed,  7 Aug 2019 17:21:00 +0000 (UTC)
Date:   Wed, 7 Aug 2019 13:20:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tracing/arm: Fix the stack tracer when LR is saved
 after local storage
Message-ID: <20190807132058.37616e8f@gandalf.local.home>
In-Reply-To: <20190807170814.GA45351@lakrids.cambridge.arm.com>
References: <20190807163401.570339297@goodmis.org>
        <20190807170814.GA45351@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 18:08:14 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Steve,
> 
> On Wed, Aug 07, 2019 at 12:34:01PM -0400, Steven Rostedt wrote:
> > As arm64 saves the link register after a function's local variables are
> > stored, it causes the max stack tracer to be off by one in its output
> > of which function has the bloated stack frame.  
> 
> For reference, it's a bit more complex than that. :/

Yeah, I know it is. ;-)

> 
> Our procedure call standard (the AAPCS) says that the frame record may
> be placed anywhere within a stackframe, so we don't have a guarantee as
> to where the saved lr will fall w.r.t local variables.

Yep.

> 
> Today, GCC happens to create the stack frame by creating the stack
> record, so the LR is saved at a lower addresss than the local variables.

Which is what breaks the current algorithm (without this update).

> 
> However, I am aware that there are reasons why a compiler may choose to
> place the frame record at a different locations, e.g. using pointer
> authentication to provide an implicit stack canary, so this could change
> in future, or potentially differ across functions.
> 
> Maybe that's a bridge we'll have to cross in future.

OK, how about I update the change log and add a comment that states
that this can change. But even if it does, it wont break anything but
show the wrong stack size, which is usually only important for us
kernel developers anyway ;-)

Let me send a v2.

-- Steve
