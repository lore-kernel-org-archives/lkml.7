Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391AEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B5F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLSVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:55:14 -0500
Received: from kernel.crashing.org ([76.164.61.194]:52706 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLSVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:55:13 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 16:55:12 EST
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xBJLmPqL021727
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Dec 2019 15:48:29 -0600
Message-ID: <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Dec 2019 08:48:24 +1100
In-Reply-To: <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
         <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-19 at 14:50 +0100, Petr Mladek wrote:
> 
> > NOTE: This may look convoluted because I'm trying to keep the existing
> > behaviour identical when it comes to things like Braille selection,
> > setup failures, on Braille consoles, or setup failures on normal consoles
> > which all have subtly different results in the current code.
> > 
> > Some of those behaviour are a bit dubious and we might be able to simply
> > rely on CON_ENABLED and CON_BRL flags in newcon after the search but I
> > don't want to change those corner cases in this patch.
> 
> Yes, it is dubious. IMHO, the 5 error codes make it even harder to
> see what happens in which case.

Agreed.

> The code really need simplification. I would prefer to take the risk
> and reduce the amount of added conditions as much as possible.
> I have an idea, see below.

I wanted you to say that :-) I'll rework along those lines. Just a nit
or two:
> 
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2542,6 +2545,53 @@ static int __init keep_bootcon_setup(char *str)
> >  
> >  early_param("keep_bootcon", keep_bootcon_setup);
> >  
> > +enum con_match {
> > +	con_matched,
> > +	con_matched_preferred,
> > +	con_braille,
> > +	con_failed,
> > +	con_no_match,
> > +};
> 
> Please, replace this with int, where:
> 
>    + con_matched -> 0
>    + con_matched_preferred -> 0 and make "has_preferred" global variable
>    + con_braile -> 0		later check for CON_BRL flag
>    + con_failed -> -EFAULT
>    + con_no_match -> -ENOENT

Not fan of using -EFAULT here, it's a detail since it's rather kernel
internal, but I'd rather use -ENXIO for no match and -EIO for failed
(or pass the original error code up if any). That said it's really bike
shed painting at this point :-)
> 
> > @@ -2615,41 +2664,19 @@ void register_console(struct console *newcon)
> > +	/* See if this console matches one we selected on the command line */
> > +	match = try_match_new_console(newcon, true);
> > +	/* If it didn't, try matching the platform ones */
> > +	if (match == con_no_match)
> > +		match = try_match_new_console(newcon, false);
> > +	/* If we matched a Braille console, bail out */
> > +	if (match == con_braille)
> > +		return;
> > +	/* Check if we found a preferred one */
> > +	if (match == con_matched_preferred)
> > +		has_preferred = true;
> >  
> > +	/* If we don't have an enabled console, bail out */
> >  	if (!(newcon->flags & CON_ENABLED))
> >  		return;
> 
> Some of the comments describe what is obvious. I would simplify
> it the following way:
> 
> 	/* Prefer command line over platform specific defaults. */
> 	err = try_match_new_console(newcon, true);
> 	if (err = -ENOENT)
> 		err = try_match_new_console(newcon, false);
> 
> 	/* printk() messages are not printed to Braille consoles. */
> 	if (err || console->flags | CON_BRL)
> 		return;

So this changes the existing behaviour in one way that may or may not
matter, I don't know:

If setup() fails, the existing code will not exit. That means that if
the console has CON_ENABLED already set (some do set it statically or
set it from outside this function, I haven't looked into details the
various circumstances this can happen), the existing code will still
insert it. Your patch will make us not insert it.

> Finally, please split the change into two patches:
> 
> 1st patch will "just" introduce try_match_new_console(console) and
>  use it the following way:
> 
> 	err = try_match_new_console(newcon);
> 
> 	/* printk() messages are not printed to the Braille console. */
> 	if (err || console->flags | CON_BRL)
> 		return;
> 
> 2nd patch will add the user_specified logic.
> 
> This way bisection will distinguish regressions caused
> by the refactoring and by the changed search order.
> 
> Best Regards,
> Petr
> 
> PS: I have vacation between December 23 and January 1. I believe
> that v3 will be ready for merging. Anyway, I will not push it
> into linux-next before I am back from vacation. I would like
> to stay off the computer and do not want to eventually break
> linux-next for too long.

No worries. This isn't super urgent.

Cheers,
Ben.


