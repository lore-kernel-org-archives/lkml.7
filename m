Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58290C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLSNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:50:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfLSNu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:50:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14749AF23;
        Thu, 19 Dec 2019 13:50:55 +0000 (UTC)
Date:   Thu, 19 Dec 2019 14:50:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-12-16 12:08:14, Benjamin Herrenschmidt wrote:
> In the following circumstances, the rule of selecting the console
> corresponding to the last "console=" entry on the command line as
> the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
> is a specific example, but it could happen with different consoles
> that have a similar name aliasing mechanism.
> 
> v2. Use a different logic to avoid calling match/setup multiple
>     times as discussed with Petr.
> 
> NOTE: This may look convoluted because I'm trying to keep the existing
> behaviour identical when it comes to things like Braille selection,
> setup failures, on Braille consoles, or setup failures on normal consoles
> which all have subtly different results in the current code.
> 
> Some of those behaviour are a bit dubious and we might be able to simply
> rely on CON_ENABLED and CON_BRL flags in newcon after the search but I
> don't want to change those corner cases in this patch.

Yes, it is dubious. IMHO, the 5 error codes make it even harder to
see what happens in which case.

The code really need simplification. I would prefer to take the risk
and reduce the amount of added conditions as much as possible.
I have an idea, see below.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2542,6 +2545,53 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +enum con_match {
> +	con_matched,
> +	con_matched_preferred,
> +	con_braille,
> +	con_failed,
> +	con_no_match,
> +};

Please, replace this with int, where:

   + con_matched -> 0
   + con_matched_preferred -> 0 and make "has_preferred" global variable
   + con_braile -> 0		later check for CON_BRL flag
   + con_failed -> -EFAULT
   + con_no_match -> -ENOENT

> @@ -2615,41 +2664,19 @@ void register_console(struct console *newcon)
> +	/* See if this console matches one we selected on the command line */
> +	match = try_match_new_console(newcon, true);
> +	/* If it didn't, try matching the platform ones */
> +	if (match == con_no_match)
> +		match = try_match_new_console(newcon, false);
> +	/* If we matched a Braille console, bail out */
> +	if (match == con_braille)
> +		return;
> +	/* Check if we found a preferred one */
> +	if (match == con_matched_preferred)
> +		has_preferred = true;
>  
> +	/* If we don't have an enabled console, bail out */
>  	if (!(newcon->flags & CON_ENABLED))
>  		return;

Some of the comments describe what is obvious. I would simplify
it the following way:

	/* Prefer command line over platform specific defaults. */
	err = try_match_new_console(newcon, true);
	if (err = -ENOENT)
		err = try_match_new_console(newcon, false);

	/* printk() messages are not printed to Braille consoles. */
	if (err || console->flags | CON_BRL)
		return;


Finally, please split the change into two patches:

1st patch will "just" introduce try_match_new_console(console) and
 use it the following way:

	err = try_match_new_console(newcon);

	/* printk() messages are not printed to the Braille console. */
	if (err || console->flags | CON_BRL)
		return;

2nd patch will add the user_specified logic.

This way bisection will distinguish regressions caused
by the refactoring and by the changed search order.

Best Regards,
Petr

PS: I have vacation between December 23 and January 1. I believe
that v3 will be ready for merging. Anyway, I will not push it
into linux-next before I am back from vacation. I would like
to stay off the computer and do not want to eventually break
linux-next for too long.
