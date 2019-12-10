Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233EDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3DC20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfLJWjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:39:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:50313 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfLJWjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:39:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBAMd6uc026857;
        Tue, 10 Dec 2019 16:39:07 -0600
Message-ID: <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Date:   Wed, 11 Dec 2019 09:39:06 +1100
In-Reply-To: <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
         <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 10:15 +0100, Petr Mladek wrote:
> On Tue 2019-12-10 11:57:26, Benjamin Herrenschmidt wrote:
> > In the following circumstances, the rule of selecting the console
> > corresponding to the last "console=" entry on the command line as
> > the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
> > is a specific example, but it could happen with different consoles
> > that have a similar name aliasing mechanism.
> > 
> > This tentative fix changes the loop in register_console to continue
> > matching with the array until the match is actually the preferred
> > console.
> 
> One problem with this is that con->match() callbacks might have
> side effects. If the console matches, the callback sometimes
> do some changes in the console driver because it expects
> that the console is going to be registered and used.

It will still be enabled. I am not changing that. The main issue would
be if the match callback chokes on being called multiple times.

IE. The only change in behaviour I think with my patch is who gets to
be the default, ie who gets to be first in the list with CONSDEV set.
There should be no change in who gets enabled.

> I have solved the same problem some time ago and we use the following
> patch in SUSE kernels.
> 
> Sigh, I have never send it upstream because it looked too complicated
> to me. I wanted to clean up the console registration code a bit first,
> see https://lkml.kernel.org/r/1497358444-30736-1-git-send-email-pmladek@suse.com
> But it was pretty complicated and it has somehow fallen into cracks.

This looks indeed a lot more invasive. Is there any reason why what I
propose wouldn't work as a first patch that can easily be backported ?

I don't see how it would break anything but I haven't necessarily fully
understood everything the driver match callbacks might be doing...

We can continue cleaning up from there of course, but I'd be keen on
having a minimal fix that can go back to stable first.

> Anyway, here is the patch that we use. Could you please check if it
> works for you as well? Does it make sense, please?

I'll give it a spin. However I don't fully grasp why it's necessarily
so complicated. Correct me if I'm wrong here but you are trying to
address two issues in that patch:

 - The one I'm trying to address which is that we might "miss" the
preferred console in the case of multiple matches.

 - The fact that when the preferred console isn't found, the one we
default to (which ends up first in the list) is missing CONSDEV.

Or am I missing something here ?

Now couldnt we just use a combination of my patch and one that sets
CONSDEV on the first enabled console if not set at the end of
register_console ?

If later on the preferred one comes in, it will be inserted first with
CONSDEV and the flag will be removed from the previous first unless I
misread the code.

Cheers,
Ben.

> From: Petr Mladek <pmladek@suse.com>
> Date: Tue, 20 Jun 2017 14:40:34 +0200
> Subject: printk/console: Correctly mark console that is used when opening /dev/console
> Patch-mainline: Never, an extensive clean up is being prepared for upstream
> References: bsc#1040020
> 
> showconsole tool shows the real name of tty device associated with
> /dev/console. It expects that the related console driver has set
> CON_CONSDEV flag.
> 
> On the other hand, kernel ignores CON_CONSDEV flag when it looks
> for the right driver. Instead, it takes the first driver that
> has the tty binding (console->device). See tty_lookup_driver()
> and console_device().
> 
> All this works most of the time because kernel puts the driver
> with CON_CONSDEV flag first into the list. There is almost always
> registered a real (non-boot) console with this flag set. The real
> consoles mostly (always?) have tty binding. Boot consoles that
> might miss the tty binding are always removed unless keep_bootcon
> command line parameter is used.
> 
> The problem is when some consoles are defined on the command line
> and the preferred one (last one) is not registered from some reason.
> Note that the consoles might be added to the command line also
> using ACPI SPCR or device tree. It might happen that, for example,
> SPCR code and user add the same console using two aliases.
> Then the first alias matches and we might miss that it matched
> also with the preferred console.
> 
> There was one attempt to fix this by searching the command line
> from the end and match the preferred alias first. But it caused
> regressions. For example, ttyS* are taken as aliases as wellhttps://lkml.kernel.org/r/1497358444-30736-1-git-send-email-pmladek@suse.com
> and kernel messages can appear only on one serial port.
> The reversed matching caused that the logs suddenly appeared
> on another serial port.
> 
> The right solution is to set CON_CONSDEV flag for the driver
> used by tty_lookup_driver() even when the preferred console
> is not registered.
> 
> It is a bit complicated because register_console() code is tricky.
> It expects that only the preferred driver will have CON_CONSDEV
> flag set. Also it expects that a boot console will stay firsthttps://lkml.kernel.org/r/1497358444-30736-1-git-send-email-pmladek@suse.com
> in the list until the preferred console is registered. These
> information are used to make various decisions:
> 
>     + Use a fallback code when none console is configured on
>       the command line. This code tries to enable any console
>       until a real one is enabled.
> 
>     + Unregister all boot consoles when the real preferred one
>       is registered. And do not reply the log on the real console
>       to avoid duplicates.
> 
> A rather invasive clean up is being prepared for upstream. This
> patch tries to be as minimalist and do not change the order
> of consoles as possible.
> 
> It keeps the logic about having a boot console first until
> the real preferred console is registered. But it makes sure
> that the first console with tty binding (console->device) will
> have CON_CONSDEV flag set. Let's look at this in more details.
> 
> The fallback code in console_register() already works as
> expected. It sets CON_CONSDEV flag for any console with
> tty binding.
> 
> The code matching all consoles from the command line newly sets
> CON_CONSDEV flag also for the fist console with the tty binding.
> But it sets "consdev_fallback" to avoid putting this console
> first into the list. Remember that we want to keep the boot
> console first until the preferred is registered. The information
> about the fallback is used also to avoid doing other actions
> that need to wait for the preferred console.
> 
> The code adding the console into the list of drivers must
> put non-preferred drivers with tty binding next to the
> console with CON_CONSDEV set. This is the only change that
> might change the order of console drivers in the list
> and eventually cause regressions. But it has an effect only
> when there are at least three drivers mentioned on the command
> line, a boot console is registered and the preferred driver
> is not registered. This should be a corner case.
> 
> Finally, unregister_console() sets CON_CONSDEV to first console
> with tty binding instead of the first one in the list.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c | 59 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 94ec1aacea64..b6bb4d362b22 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2662,16 +2662,23 @@ void register_console(struct console *newcon)
>  	int i;
>  	unsigned long flags;
>  	struct console *bcon = NULL;
> +	struct console *con_consdev = NULL;
>  	struct console_cmdline *c;
>  	static bool has_preferred;
> +	bool consdev_fallback = false;
>  
> -	if (console_drivers)
> -		for_each_console(bcon)
> +	if (console_drivers) {
> +		for_each_console(bcon) {
>  			if (WARN(bcon == newcon,
>  					"console '%s%d' already registered\n",
>  					bcon->name, bcon->index))
>  				return;
>  
> +			if (bcon->flags & CON_CONSDEV && !con_consdev)
> +				con_consdev = bcon;
> +		}
> +	}
> +
>  	/*
>  	 * before we register a new CON_BOOT console, make sure we don't
>  	 * already have a valid console
> @@ -2739,8 +2746,17 @@ void register_console(struct console *newcon)
>  
>  		newcon->flags |= CON_ENABLED;
>  		if (i == preferred_console) {
> +			/* This is the last console on the command line. */
>  			newcon->flags |= CON_CONSDEV;
>  			has_preferred = true;
> +		} else if (newcon->device && !con_consdev) {
> +			/*
> +			 * This is the first console with tty binding. It will
> +			 * be used for /dev/console when the preferred one
> +			 * will not get registered for some reason.
> +			 */
> +			newcon->flags |= CON_CONSDEV;
> +			consdev_fallback = true;
>  		}
>  		break;
>  	}
> @@ -2754,7 +2770,9 @@ void register_console(struct console *newcon)
>  	 * the real console are the same physical device, it's annoying to
>  	 * see the beginning boot messages twice
>  	 */
> -	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV))
> +	if (bcon &&
> +	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
> +	    !consdev_fallback)
>  		newcon->flags &= ~CON_PRINTBUFFER;
>  
>  	/*
> @@ -2762,12 +2780,28 @@ void register_console(struct console *newcon)
>  	 *	preferred driver at the head of the list.
>  	 */
>  	console_lock();
> -	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
> +	if ((newcon->flags & CON_CONSDEV && !consdev_fallback) ||
> +	     console_drivers == NULL) {
> +		/* Put the preferred or the first console at the head. */
>  		newcon->next = console_drivers;
>  		console_drivers = newcon;
> -		if (newcon->next)
> see 
> https://lkml.kernel.org/r/1497358444-30736-1-git-send-email-pmladek@suse.com>
> ; But it was pretty complicated and it has somehow fallen into
> cracks.
> This looks indeed a lot more invasive. Is there any reason why what I
> propose wouldn't work as a first patch that can easily be backported
> ?
> I don't see how it would break anything but I haven't necessarily
> fully understood everything the driver match callbacks might be
> doing...
> We can continue cleaning up from there of course, but I'd be keen on
> having a minimal fix that can go back to stable first.
> > Anyway, here is the patch that we use. Could you please check if
> it> works for you as well? Does it make sense, please?
> I'll give it a spin. Some comments on it at first look though:> 
> 
> -			newcon->next->flags &= ~CON_CONSDEV;
> +		/* Only one console can have CON_CONSDEV flag set */
> +		if (con_consdev)
> +			con_consdev->flags &= ~CON_CONSDEV;
> +	} else if (newcon->device && con_consdev) {
> +		/*
> +		 * Keep the driver associated with /dev/console.
> +		 * We are here only when the console was enabled by the cycle
> +		 * checking console_cmdline and this is neither preferred
> +		 * console nor the consdev fallback.
> +		 */
> +		newcon->next = con_consdev->next;
> +		con_consdev->next = newcon;
>  	} else {
> +		/*
> +		 * Keep a boot console first until the preferred real one
> +		 * is registered.
> +		 */
>  		newcon->next = console_drivers->next;
>  		console_drivers->next = newcon;
>  	}
> @@ -2808,6 +2842,7 @@ void register_console(struct console *newcon)
>  		newcon->name, newcon->index);
>  	if (bcon &&
>  	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
> +	    !consdev_fallback &&
>  	    !keep_bootcon) {
>  		/* We need to iterate through all boot consoles, to make
>  		 * sure we print everything out, before we unregister them.
> @@ -2853,10 +2888,16 @@ int unregister_console(struct console *console)
>  
>  	/*
>  	 * If this isn't the last console and it has CON_CONSDEV set, we
> -	 * need to set it on the next preferred console.
> +	 * need to set it on the first console with tty binding.
>  	 */
> -	if (console_drivers != NULL && console->flags & CON_CONSDEV)
> -		console_drivers->flags |= CON_CONSDEV;
> +	if (console_drivers != NULL && console->flags & CON_CONSDEV) {
> +		for_each_console(a) {
> +			if (a->device) {
> +				a->flags |= CON_CONSDEV;
> +				break;
> +			}
> +		}
> +	}
>  
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();

