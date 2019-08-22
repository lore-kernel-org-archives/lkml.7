Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B9FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93020870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR/KJAe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbfHVRiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:38:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389826AbfHVRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:38:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so6225367wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YyhTDWSBbWwm8NRBZUXXKvMf2Bg9as5ev6Cz2sZtgw=;
        b=HR/KJAe7TH2UMKwCBqKRrBkD4C7CgtEyTEkcth+ndNdy9HRuuHI+zwquIDFiKloYy+
         8r6OFHtaFdyclYUPdKmoPievJ9+Z9z6ElWqRBsxLr01cUdhzB6HlnG5gVrXyTyLNrvni
         xl8aAiEpdPyqKArMJSdpLkDrM1fxeja8b8Wk+khWENz6WRwWJHsSaEubfGL62DiWS03O
         dD4WDClXTDnTNyS7KGfwRiDAyk3fv5TkWOLJE8LCR5XL6fCdvemZmz40HEmjK+pctEsR
         V9OoWzqcucmfTHv5aI/i15phJJLZUh4aJ3fEUdjlf2VZ/fFgktYs6/wo2DP6cD2xqv21
         PNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YyhTDWSBbWwm8NRBZUXXKvMf2Bg9as5ev6Cz2sZtgw=;
        b=VMaiobf6NnkL4ZOsSpl1K7uTnslh86OyhQLdyHjksma99pOi+YcSM5NcYS2TOxbNGE
         xpPke19E3DeLy33GpYK4JNlqjCmEUqbzLhZazHUbKo19c5ZsW9mEyH6eYs6Zz9cvOAnb
         f0AjbunYPyEavz49899pqA6UqadbrJJYuYy2vdIDQ2rZgxxc0BKNcumW1eiD9y4Ge7rS
         BHmfE8XtiKjpCEZcyK9NgwUnVg8TuO54YWOW8sKHTiL5khl+JnL1OI3lD+AyM7DnazhN
         EArV//Mhhk+GKEA8uOK1jpUWf7C8FfAunDqedn3EphsZTuwB9qKwPh3OIhdW8RppCaPL
         c9/w==
X-Gm-Message-State: APjAAAU+HgWJFpiajvvWWGXS288/X7/x6goowrt71TDyxBMhhaGKjDTx
        Rv/QbJRPofA2rrqcraY2SxA=
X-Google-Smtp-Source: APXvYqxxdVX0hYwk1OMdCK4IfjJgSWtYUedl5d68bJYuK3xUnYKySBPwfcrupHUSXaSdP7bBXiAw2w==
X-Received: by 2002:adf:e504:: with SMTP id j4mr93243wrm.222.1566495488093;
        Thu, 22 Aug 2019 10:38:08 -0700 (PDT)
Received: from andrea ([167.220.197.36])
        by smtp.gmail.com with ESMTPSA id u7sm142984wrp.96.2019.08.22.10.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 10:38:07 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:38:01 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20190822173801.GA2218@andrea>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
 <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:50:52PM +0200, Petr Mladek wrote:
> On Wed 2019-08-21 07:46:28, John Ogness wrote:
> > On 2019-08-20, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > > [..]
> > >> > +	 *
> > >> > +	 * Memory barrier involvement:
> > >> > +	 *
> > >> > +	 * If dB reads from gA, then dC reads from fG.
> > >> > +	 * If dB reads from gA, then dD reads from fH.
> > >> > +	 * If dB reads from gA, then dE reads from fE.
> > >> > +	 *
> > >> > +	 * Note that if dB reads from gA, then dC cannot read from fC.
> > >> > +	 * Note that if dB reads from gA, then dD cannot read from fD.
> > >> > +	 *
> > >> > +	 * Relies on:
> > >> > +	 *
> > >> > +	 * RELEASE from fG to gA
> > >> > +	 *    matching
> > >> > +	 * ADDRESS DEP. from dB to dC
> > >> > +	 *
> > >> > +	 * RELEASE from fH to gA
> > >> > +	 *    matching
> > >> > +	 * ADDRESS DEP. from dB to dD
> > >> > +	 *
> > >> > +	 * RELEASE from fE to gA
> > >> > +	 *    matching
> > >> > +	 * ACQUIRE from dB to dE
> > >> > +	 */
> > >> 
> > >> But I am not sure how much this is useful. It would take ages to decrypt
> > >> all these shortcuts (signs) and translate them into something
> > >> human readable. Also it might get outdated easily.
> > >> 
> > The labels are necessary for the technical documentation of the
> > barriers. And, after spending much time in this, I find them very
> > useful. But I agree that there needs to be a better way to assign label
> > names.
> 
> I could understand that you spend a lot of time on creating the
> labels and that they are somehow useful for you.
> 
> But I am not using them and I hope that I will not have to:
> 
>   + Grepping takes a lot of time, especially over several files.
> 
>   + Grepping is actually not enough. It is required to read
>     the following comment or code to realize what the label is for.
> 
>   + Several barriers have multiple dependencies. Grepping one
>     label helps to check that one connection makes sense.
>     But it is hard to keep all relations in head to confirm
>     that they are complete and make sense overall.
> 
>   + There are about 50 labels in the code. "Entry Lifecycle"
>     section in dataring.c talks about 8 step. One would
>     expect that it would require 8 read and 8 write barriers.
> 
>     Even coordination of 16 barriers might be complicated to check.
>     Where 50 is just scary.
> 
> 
>   + It seems to be a newly invented format and it is not documented.
>     I personally do not understand it completely, for example,
>     the meaning of "RELEASE from jA->cD->hA to jB".

IIUC, something like "hA is the interested access, happening within
cD (should have been cC?), which in turn happens within jA".  But I
should defer to John (FWIW, I found that notation quite helpful).


> 
> 
> I hope that we could do better. I believe that human readable
> comments all less error prone because they describe the intention.
> Pseudo code based on labels just describes the code but it
> does not explain why it was done this way.
> 
> From my POV, the labels do more harm than good. The code gets
> too scattered and is harder to follow.
> 
> 
> > I hope that we can agree that the labels are important.
> 
> It would be great to hear from others.

I agree with you that reviewing these comments might be "scary" and
not suitable for a bed-reading  ;-) (I didn't have time to complete
such review yet).  OTOH, from my POV, removing such comments/labels
could only make such (and future) reviews scarier, because then the
(memory-ordering) "intention" would then be _hidden in the code.


> 
> > And that a formal documentation of the barriers is also important.
> 
> It might be helpful if it can be somehow feed to a tool that would
> prove correctness. Is this the case?

From what I've read so far, it _should be relatively straighforward
to write down a litmus test from any such comment (and give this to
the LKMM simulator).


> 
> In each case, it should follow some "widely" used format.
> We should not invent a new one that nobody else would use
> and understand.

Agreed.  Well, litmus tests (or the comments here in question, that
are intended to convey the same information) have been successfully
adopted by memory model and concurrency people for as long as I can
remember, current architecture reference manuals use these tools to
describe the semantics of fence or atomic instructions, discussions
about memory barriers on LKML, gcc MLs often reduce to a discussion
around one or more litmus tests...

[trimming]


> > Andrea suggested that the documentation should be within the code, which
> > I think is a good idea. Even if it means we have more comments than
> > code.
> 
> It depends on the type of the information. I would describe:
> 
>   + The overall design on top of the source file or in
>     Documentation/...
> 
>   + The behavior of externally used API and non-obvious functions
>     above the function definition.
> 
>   + Implementation details, non-obvious effects, side effects,
>     relations, meaning of tricky calculation, meaning of
>     a block of code inside the code. But each function should
>     ideally fit on the screen.
> 
> I personally tend to write more documentation but it is sometimes
> too much. I am trying to become more effective and to the point.

Unfortunately, I don't know of more concise ways to convey the same
information that these comments are intended to provide.  Thoughts?

Please don't get me wrong: I'm all for overall design, external API,
etc., if some improvements can be achieved here.

  Andrea
