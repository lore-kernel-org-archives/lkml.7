Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2EB20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfEVNe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfEVNez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:34:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A8821473;
        Wed, 22 May 2019 13:34:54 +0000 (UTC)
Date:   Wed, 22 May 2019 09:34:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: silence GCC 9 array bounds warning
Message-ID: <20190522093453.25e601a5@gandalf.local.home>
In-Reply-To: <CANiq72=uRuyDuRvZgxYAHxKRCOyJ-KQew+R24tPwOJuQmaO1Yw@mail.gmail.com>
References: <20190522095810.GA16110@gmail.com>
        <20190522075227.52ae4720@gandalf.local.home>
        <CANiq72=uRuyDuRvZgxYAHxKRCOyJ-KQew+R24tPwOJuQmaO1Yw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 15:11:10 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Wed, May 22, 2019 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 22 May 2019 11:58:10 +0200
> > Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >  
> > > +/* reset all but tr, trace, and overruns */
> > > +static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
> > > +{
> > > +     /*
> > > +      * We do not simplify the start address to &iter->seq in order to let
> > > +      * GCC 9 know that we really want to overwrite more members than
> > > +      * just iter->seq (-Warray-bounds).  
> >
> > This comment is fine for the change log, but here it is too specific.
> > Why does one care about GCC 9 when we are at version GCC 21? I care
> > more about why we are clearing the data and less about the way we are
> > doing it.  
> 
> Since the code is not written the obvious way on purpose, the idea is
> to document why that is so -- otherwise the reader may wonder (and
> possibly re-introduce it back). Specifying when the warning started
> appearing tends to be clarifying, too.
> 
> The commit message explains the change itself, but the comment
> explains why the current code is written like that.

Could also be shorten to: "Keep gcc from complaining about overwriting
more than just one member in the structure."


> 
> > A comment like:
> >
> >         /*
> >          * Reset the state of the trace_iterator so that it can read
> >          * consumed data. Normally, the trace_iterator is used for
> >          * reading the data when it is not consumed, and must retain
> >          * state.
> >          */
> >
> > That is more useful than why we have the offset hack.  
> 
> That comment would be great in the function's description, in my
> opinion, and it is a great addition to have nevertheless. I re-used
> the existing comment for that to keep the change as minimal as
> possible (and nevertheless I am not qualified to write it since I have
> not studied the tracing code). In other words, I'm not saying there
> are no further improvements :-)

I put it there so you have an idea what the rational was ;-)

-- Steve
