Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09389C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751A233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfHVNu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfHVNu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:50:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DDFAB016;
        Thu, 22 Aug 2019 13:50:54 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:50:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7c3f4uj.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-21 07:46:28, John Ogness wrote:
> On 2019-08-20, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > [..]
> >> > +	 *
> >> > +	 * Memory barrier involvement:
> >> > +	 *
> >> > +	 * If dB reads from gA, then dC reads from fG.
> >> > +	 * If dB reads from gA, then dD reads from fH.
> >> > +	 * If dB reads from gA, then dE reads from fE.
> >> > +	 *
> >> > +	 * Note that if dB reads from gA, then dC cannot read from fC.
> >> > +	 * Note that if dB reads from gA, then dD cannot read from fD.
> >> > +	 *
> >> > +	 * Relies on:
> >> > +	 *
> >> > +	 * RELEASE from fG to gA
> >> > +	 *    matching
> >> > +	 * ADDRESS DEP. from dB to dC
> >> > +	 *
> >> > +	 * RELEASE from fH to gA
> >> > +	 *    matching
> >> > +	 * ADDRESS DEP. from dB to dD
> >> > +	 *
> >> > +	 * RELEASE from fE to gA
> >> > +	 *    matching
> >> > +	 * ACQUIRE from dB to dE
> >> > +	 */
> >> 
> >> But I am not sure how much this is useful. It would take ages to decrypt
> >> all these shortcuts (signs) and translate them into something
> >> human readable. Also it might get outdated easily.
> >> 
> The labels are necessary for the technical documentation of the
> barriers. And, after spending much time in this, I find them very
> useful. But I agree that there needs to be a better way to assign label
> names.

I could understand that you spend a lot of time on creating the
labels and that they are somehow useful for you.

But I am not using them and I hope that I will not have to:

  + Grepping takes a lot of time, especially over several files.

  + Grepping is actually not enough. It is required to read
    the following comment or code to realize what the label is for.

  + Several barriers have multiple dependencies. Grepping one
    label helps to check that one connection makes sense.
    But it is hard to keep all relations in head to confirm
    that they are complete and make sense overall.

  + There are about 50 labels in the code. "Entry Lifecycle"
    section in dataring.c talks about 8 step. One would
    expect that it would require 8 read and 8 write barriers.

    Even coordination of 16 barriers might be complicated to check.
    Where 50 is just scary.


  + It seems to be a newly invented format and it is not documented.
    I personally do not understand it completely, for example,
    the meaning of "RELEASE from jA->cD->hA to jB".


I hope that we could do better. I believe that human readable
comments all less error prone because they describe the intention.
Pseudo code based on labels just describes the code but it
does not explain why it was done this way.

From my POV, the labels do more harm than good. The code gets
too scattered and is harder to follow.


> I hope that we can agree that the labels are important.

It would be great to hear from others.

> And that a formal documentation of the barriers is also important.

It might be helpful if it can be somehow feed to a tool that would
prove correctness. Is this the case?

In each case, it should follow some "widely" used format.
We should not invent a new one that nobody else would use
and understand.

> Perhaps we should choose labels that are more clear, like:
> 
>     dataring_push:A
>     dataring_push:B

The dataring_push is clear. The A or B codes have no meaning
without searching.

It might look better if we replace A or B with variable names.

> Then we would see comments like:
> 
>     Memory barrier involvement:
> 
>     If _dataring_pop:B reads from dataring_datablock_setid:A, then
>     _dataring_pop:C reads from dataring_push:G.

Is this some known syntax, please? I do not understand it.

> 
> Andrea suggested that the documentation should be within the code, which
> I think is a good idea. Even if it means we have more comments than
> code.

It depends on the type of the information. I would describe:

  + The overall design on top of the source file or in
    Documentation/...

  + The behavior of externally used API and non-obvious functions
    above the function definition.

  + Implementation details, non-obvious effects, side effects,
    relations, meaning of tricky calculation, meaning of
    a block of code inside the code. But each function should
    ideally fit on the screen.

I personally tend to write more documentation but it is sometimes
too much. I am trying to become more effective and to the point.

Best Regards,
Petr
