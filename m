Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0135CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7236233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391778AbfHWKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389133AbfHWKrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FB49AEF8;
        Fri, 23 Aug 2019 10:47:14 +0000 (UTC)
Date:   Fri, 23 Aug 2019 12:47:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823104713.mtxarc3ywtnryd2d@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
 <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
 <20190822173801.GA2218@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822173801.GA2218@andrea>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-22 19:38:01, Andrea Parri wrote:
> On Thu, Aug 22, 2019 at 03:50:52PM +0200, Petr Mladek wrote:
> > On Wed 2019-08-21 07:46:28, John Ogness wrote:
> > > On 2019-08-20, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > > > [..]
> > > >> > +	 *
> > > >> > +	 * Memory barrier involvement:
> > > >> > +	 *
> > > >> > +	 * If dB reads from gA, then dC reads from fG.
> > > >> > +	 * If dB reads from gA, then dD reads from fH.
> > > >> > +	 * If dB reads from gA, then dE reads from fE.
> > > >> > +	 *
> > > >> > +	 * Note that if dB reads from gA, then dC cannot read from fC.
> > > >> > +	 * Note that if dB reads from gA, then dD cannot read from fD.
> > > >> > +	 *
> > > >> > +	 * Relies on:
> > > >> > +	 *
> > > >> > +	 * RELEASE from fG to gA
> > > >> > +	 *    matching
> > > >> > +	 * ADDRESS DEP. from dB to dC
> > > >> > +	 *
> > > >> > +	 * RELEASE from fH to gA
> > > >> > +	 *    matching
> > > >> > +	 * ADDRESS DEP. from dB to dD
> > > >> > +	 *
> > > >> > +	 * RELEASE from fE to gA
> > > >> > +	 *    matching
> > > >> > +	 * ACQUIRE from dB to dE
> > > >> > +	 */
> > > >> 
> > > >> But I am not sure how much this is useful. It would take ages to decrypt
> > > >> all these shortcuts (signs) and translate them into something
> > > >> human readable. Also it might get outdated easily.
> > > >> 
> > > The labels are necessary for the technical documentation of the
> > > barriers. And, after spending much time in this, I find them very
> > > useful. But I agree that there needs to be a better way to assign label
> > > names.
> > 
> > I could understand that you spend a lot of time on creating the
> > labels and that they are somehow useful for you.
> > 
> > But I am not using them and I hope that I will not have to:
> > 
> >   + Grepping takes a lot of time, especially over several files.
> > 
> >   + Grepping is actually not enough. It is required to read
> >     the following comment or code to realize what the label is for.
> > 
> >   + Several barriers have multiple dependencies. Grepping one
> >     label helps to check that one connection makes sense.
> >     But it is hard to keep all relations in head to confirm
> >     that they are complete and make sense overall.
> > 
> >   + There are about 50 labels in the code. "Entry Lifecycle"
> >     section in dataring.c talks about 8 step. One would
> >     expect that it would require 8 read and 8 write barriers.
> > 
> >     Even coordination of 16 barriers might be complicated to check.
> >     Where 50 is just scary.
> > 
> > 
> >   + It seems to be a newly invented format and it is not documented.
> >     I personally do not understand it completely, for example,
> >     the meaning of "RELEASE from jA->cD->hA to jB".
> 
> IIUC, something like "hA is the interested access, happening within
> cD (should have been cC?), which in turn happens within jA".  But I
> should defer to John (FWIW, I found that notation quite helpful).
> 
> 
> > 
> > 
> > I hope that we could do better. I believe that human readable
> > comments all less error prone because they describe the intention.
> > Pseudo code based on labels just describes the code but it
> > does not explain why it was done this way.
> > 
> > From my POV, the labels do more harm than good. The code gets
> > too scattered and is harder to follow.
> > 
> > 
> > > I hope that we can agree that the labels are important.
> > 
> > It would be great to hear from others.
> 
> I agree with you that reviewing these comments might be "scary" and
> not suitable for a bed-reading  ;-) (I didn't have time to complete
> such review yet).  OTOH, from my POV, removing such comments/labels
> could only make such (and future) reviews scarier, because then the
> (memory-ordering) "intention" would then be _hidden in the code.

I am not suggesting to remove all comments. Some human readable
explanation is important as long as the code is developed by humans.

I think that I'll have to accept also the extra comments if you are
really going to use them to check the consistency by a tool. Or
if they are really used for review by some people.


> > > And that a formal documentation of the barriers is also important.
> > 
> > It might be helpful if it can be somehow feed to a tool that would
> > prove correctness. Is this the case?
> 
> >From what I've read so far, it _should be relatively straighforward
> to write down a litmus test from any such comment (and give this to
> the LKMM simulator).

Sounds good.

> > In each case, it should follow some "widely" used format.
> > We should not invent a new one that nobody else would use
> > and understand.
> 
> Agreed.  Well, litmus tests (or the comments here in question, that
> are intended to convey the same information) have been successfully
> adopted by memory model and concurrency people for as long as I can
> remember, current architecture reference manuals use these tools to
> describe the semantics of fence or atomic instructions, discussions
> about memory barriers on LKML, gcc MLs often reduce to a discussion
> around one or more litmus tests...

Do all this manuals, tools, people use any common syntax, please?
Would it be usable in our case as well?

I would like to avoid reinventing the wheel. Also I do not want
to create a dialect for few people that other potentially interested
parties will not understand.

Best Regards,
Petr
