Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB84B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLLAgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:36:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:46636 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfLLAgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:36:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBC0ZORJ002058;
        Wed, 11 Dec 2019 18:35:25 -0600
Message-ID: <b359a4a84d3dad08dc45899dc9b56e7323ffb734.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Date:   Thu, 12 Dec 2019 11:35:23 +1100
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
> 
> Anyway, here is the patch that we use. Could you please check if it
> works for you as well? Does it make sense, please?

It doesn't fix my problem. tty0 remains the default console instead
of ttyS0 with your patch applied.

I suspect for the same reason, we match uart0 which isn't preferred,
so we enable that but don't put it "first" in the list, and since
we break out of the loop we never match ttyS0.

I see 3 simple ways out of this that don't involve breaking up match()

 - Bite the bullet and use my patch assuming that calling setup()
multiple times is safe. I had a look at the two you had concerns
with, the zilog ones seems safe. pl1011 will leak a clk_prepare
reference but I think that's a non-issue for a kernel console
(I may be wrong)

 - Rework the loop to try matching against the array entry pointed
by preferred_console first.

 - Rework the loop to try matching the entries from the command line
before trying to match the entries added by the platform/arch.
(Easily done by flagging them in the array, I can cook a patch).

Let me know what you prefer or if you have a different idea and
I'll try to whip up a patch tomorrow.

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
> regressions. For example, ttyS* are taken as aliases as well
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
> flag set. Also it expects that a boot console will stay first
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

