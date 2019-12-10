Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F7C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C191206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLJJPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:15:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbfLJJPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:15:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FBF1AE5E;
        Tue, 10 Dec 2019 09:15:03 +0000 (UTC)
Date:   Tue, 10 Dec 2019 10:15:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-12-10 11:57:26, Benjamin Herrenschmidt wrote:
> In the following circumstances, the rule of selecting the console
> corresponding to the last "console=" entry on the command line as
> the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
> is a specific example, but it could happen with different consoles
> that have a similar name aliasing mechanism.
> 
> This tentative fix changes the loop in register_console to continue
> matching with the array until the match is actually the preferred
> console.

One problem with this is that con->match() callbacks might have
side effects. If the console matches, the callback sometimes
do some changes in the console driver because it expects
that the console is going to be registered and used.

I have solved the same problem some time ago and we use the following
patch in SUSE kernels.

Sigh, I have never send it upstream because it looked too complicated
to me. I wanted to clean up the console registration code a bit first,
see https://lkml.kernel.org/r/1497358444-30736-1-git-send-email-pmladek@suse.com
But it was pretty complicated and it has somehow fallen into cracks.


Anyway, here is the patch that we use. Could you please check if it
works for you as well? Does it make sense, please?

From: Petr Mladek <pmladek@suse.com>
Date: Tue, 20 Jun 2017 14:40:34 +0200
Subject: printk/console: Correctly mark console that is used when opening /dev/console
Patch-mainline: Never, an extensive clean up is being prepared for upstream
References: bsc#1040020

showconsole tool shows the real name of tty device associated with
/dev/console. It expects that the related console driver has set
CON_CONSDEV flag.

On the other hand, kernel ignores CON_CONSDEV flag when it looks
for the right driver. Instead, it takes the first driver that
has the tty binding (console->device). See tty_lookup_driver()
and console_device().

All this works most of the time because kernel puts the driver
with CON_CONSDEV flag first into the list. There is almost always
registered a real (non-boot) console with this flag set. The real
consoles mostly (always?) have tty binding. Boot consoles that
might miss the tty binding are always removed unless keep_bootcon
command line parameter is used.

The problem is when some consoles are defined on the command line
and the preferred one (last one) is not registered from some reason.
Note that the consoles might be added to the command line also
using ACPI SPCR or device tree. It might happen that, for example,
SPCR code and user add the same console using two aliases.
Then the first alias matches and we might miss that it matched
also with the preferred console.

There was one attempt to fix this by searching the command line
from the end and match the preferred alias first. But it caused
regressions. For example, ttyS* are taken as aliases as well
and kernel messages can appear only on one serial port.
The reversed matching caused that the logs suddenly appeared
on another serial port.

The right solution is to set CON_CONSDEV flag for the driver
used by tty_lookup_driver() even when the preferred console
is not registered.

It is a bit complicated because register_console() code is tricky.
It expects that only the preferred driver will have CON_CONSDEV
flag set. Also it expects that a boot console will stay first
in the list until the preferred console is registered. These
information are used to make various decisions:

    + Use a fallback code when none console is configured on
      the command line. This code tries to enable any console
      until a real one is enabled.

    + Unregister all boot consoles when the real preferred one
      is registered. And do not reply the log on the real console
      to avoid duplicates.

A rather invasive clean up is being prepared for upstream. This
patch tries to be as minimalist and do not change the order
of consoles as possible.

It keeps the logic about having a boot console first until
the real preferred console is registered. But it makes sure
that the first console with tty binding (console->device) will
have CON_CONSDEV flag set. Let's look at this in more details.

The fallback code in console_register() already works as
expected. It sets CON_CONSDEV flag for any console with
tty binding.

The code matching all consoles from the command line newly sets
CON_CONSDEV flag also for the fist console with the tty binding.
But it sets "consdev_fallback" to avoid putting this console
first into the list. Remember that we want to keep the boot
console first until the preferred is registered. The information
about the fallback is used also to avoid doing other actions
that need to wait for the preferred console.

The code adding the console into the list of drivers must
put non-preferred drivers with tty binding next to the
console with CON_CONSDEV set. This is the only change that
might change the order of console drivers in the list
and eventually cause regressions. But it has an effect only
when there are at least three drivers mentioned on the command
line, a boot console is registered and the preferred driver
is not registered. This should be a corner case.

Finally, unregister_console() sets CON_CONSDEV to first console
with tty binding instead of the first one in the list.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 59 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 94ec1aacea64..b6bb4d362b22 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2662,16 +2662,23 @@ void register_console(struct console *newcon)
 	int i;
 	unsigned long flags;
 	struct console *bcon = NULL;
+	struct console *con_consdev = NULL;
 	struct console_cmdline *c;
 	static bool has_preferred;
+	bool consdev_fallback = false;
 
-	if (console_drivers)
-		for_each_console(bcon)
+	if (console_drivers) {
+		for_each_console(bcon) {
 			if (WARN(bcon == newcon,
 					"console '%s%d' already registered\n",
 					bcon->name, bcon->index))
 				return;
 
+			if (bcon->flags & CON_CONSDEV && !con_consdev)
+				con_consdev = bcon;
+		}
+	}
+
 	/*
 	 * before we register a new CON_BOOT console, make sure we don't
 	 * already have a valid console
@@ -2739,8 +2746,17 @@ void register_console(struct console *newcon)
 
 		newcon->flags |= CON_ENABLED;
 		if (i == preferred_console) {
+			/* This is the last console on the command line. */
 			newcon->flags |= CON_CONSDEV;
 			has_preferred = true;
+		} else if (newcon->device && !con_consdev) {
+			/*
+			 * This is the first console with tty binding. It will
+			 * be used for /dev/console when the preferred one
+			 * will not get registered for some reason.
+			 */
+			newcon->flags |= CON_CONSDEV;
+			consdev_fallback = true;
 		}
 		break;
 	}
@@ -2754,7 +2770,9 @@ void register_console(struct console *newcon)
 	 * the real console are the same physical device, it's annoying to
 	 * see the beginning boot messages twice
 	 */
-	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV))
+	if (bcon &&
+	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
+	    !consdev_fallback)
 		newcon->flags &= ~CON_PRINTBUFFER;
 
 	/*
@@ -2762,12 +2780,28 @@ void register_console(struct console *newcon)
 	 *	preferred driver at the head of the list.
 	 */
 	console_lock();
-	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
+	if ((newcon->flags & CON_CONSDEV && !consdev_fallback) ||
+	     console_drivers == NULL) {
+		/* Put the preferred or the first console at the head. */
 		newcon->next = console_drivers;
 		console_drivers = newcon;
-		if (newcon->next)
-			newcon->next->flags &= ~CON_CONSDEV;
+		/* Only one console can have CON_CONSDEV flag set */
+		if (con_consdev)
+			con_consdev->flags &= ~CON_CONSDEV;
+	} else if (newcon->device && con_consdev) {
+		/*
+		 * Keep the driver associated with /dev/console.
+		 * We are here only when the console was enabled by the cycle
+		 * checking console_cmdline and this is neither preferred
+		 * console nor the consdev fallback.
+		 */
+		newcon->next = con_consdev->next;
+		con_consdev->next = newcon;
 	} else {
+		/*
+		 * Keep a boot console first until the preferred real one
+		 * is registered.
+		 */
 		newcon->next = console_drivers->next;
 		console_drivers->next = newcon;
 	}
@@ -2808,6 +2842,7 @@ void register_console(struct console *newcon)
 		newcon->name, newcon->index);
 	if (bcon &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
+	    !consdev_fallback &&
 	    !keep_bootcon) {
 		/* We need to iterate through all boot consoles, to make
 		 * sure we print everything out, before we unregister them.
@@ -2853,10 +2888,16 @@ int unregister_console(struct console *console)
 
 	/*
 	 * If this isn't the last console and it has CON_CONSDEV set, we
-	 * need to set it on the next preferred console.
+	 * need to set it on the first console with tty binding.
 	 */
-	if (console_drivers != NULL && console->flags & CON_CONSDEV)
-		console_drivers->flags |= CON_CONSDEV;
+	if (console_drivers != NULL && console->flags & CON_CONSDEV) {
+		for_each_console(a) {
+			if (a->device) {
+				a->flags |= CON_CONSDEV;
+				break;
+			}
+		}
+	}
 
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
-- 
1.8.5.6

