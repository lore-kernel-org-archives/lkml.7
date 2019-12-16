Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AC24676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLPBIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 20:08:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:33921 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfLPBIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 20:08:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBG18Ess032384;
        Sun, 15 Dec 2019 19:08:15 -0600
Message-ID: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
Subject: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Dec 2019 12:08:14 +1100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following circumstances, the rule of selecting the console
corresponding to the last "console=" entry on the command line as
the preferred console (CON_CONSDEV, ie, /dev/console) fails. This
is a specific example, but it could happen with different consoles
that have a similar name aliasing mechanism.

 - The kernel command line has both console=tty0 and console=ttyS0
in that order (the latter with speed etc... arguments). This is common
with some cloud setups such as Amazon Linux.

 - add_preferred_console is called early to register "uart0". In
our case that happens from acpi_parse_spcr() on arm64 since the
"enable_console" argument is true on that architecture. This causes
"uart0" to become entry 0 of the console_cmdline array.

Now, because of the above, what happens is:

 - add_preferred_console is called by the cmdline parsing for tty0
and ttyS0 respectively, thus occupying entries 1 and 2 of the
console_cmdline array (since this happens after ACPI SPCR parsing).
At that point preferred_console is set to 2 as expected.

 - When the tty layer kicks in, it will call register_console for tty0.
This will match entry 1 in console_cmdline array. It isn't our preferred
console but because it's our only console at this point, it will end up
"first" in the consoles list.

 - When 8250 probes the actual serial port later on, it calls
register_console for ttyS0. At that point the loop in register_console
tries to match it with the entries in the console_cmdline array. Ideally
this should match ttyS0 in entry 2, which is preferred, causing it to
be inserted first and to replace tty0 as CONSDEV. However, 8250 provides
a "match" hook in its struct console, and that hook will match "uart"
as an alias to "ttyS". So we match uart0 at entry 0 in the array which
is not the preferred console and will not match entry 2 which is since
we break out of the loop on the first match. As a result, we don't set
CONSDEV and don't insert it first, but second in the console list.

As a result, we end up with tty0 remaining first in the array, and thus
/dev/console going there instead of the last user specified one which
is ttyS0.

This tentative fix changes the loop in register_console to scan first
for consoles specified on the command line, and only if none is found,
to then scan for consoles specified by the architecture.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Use a different logic to avoid calling match/setup multiple
    times as discussed with Petr.

NOTE: This may look convoluted because I'm trying to keep the existing
behaviour identical when it comes to things like Braille selection,
setup failures, on Braille consoles, or setup failures on normal consoles
which all have subtly different results in the current code.

Some of those behaviour are a bit dubious and we might be able to simply
rely on CON_ENABLED and CON_BRL flags in newcon after the search but I
don't want to change those corner cases in this patch.

 kernel/printk/console_cmdline.h |   1 +
 kernel/printk/printk.c          | 105 ++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 39 deletions(-)

diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 11f19c466af5..621c41802c2f 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,7 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	bool    user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
 	char	*brl_options;			/* Options for braille driver */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aa96098c64d..6fc821be0e7f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2047,7 +2047,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 #endif
 
 static int __add_preferred_console(char *name, int idx, char *options,
-				   char *brl_options)
+				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
@@ -2062,6 +2062,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
+			if (user_specified)
+				c->user_specified = true;
 			return 0;
 		}
 	}
@@ -2071,6 +2073,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
+	c->user_specified = user_specified;
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
@@ -2114,7 +2117,7 @@ static int __init console_setup(char *str)
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options);
+	__add_preferred_console(buf, idx, options, brl_options, true);
 	console_set_on_cmdline = 1;
 	return 1;
 }
@@ -2135,7 +2138,7 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL);
+	return __add_preferred_console(name, idx, options, NULL, false);
 }
 
 bool console_suspend_enabled = true;
@@ -2542,6 +2545,53 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+enum con_match {
+	con_matched,
+	con_matched_preferred,
+	con_braille,
+	con_failed,
+	con_no_match,
+};
+
+static enum con_match try_match_new_console(struct console *newcon, bool user_specified)
+{
+	struct console_cmdline *c;
+	int i;
+
+	for (i = 0, c = console_cmdline;
+	     i < MAX_CMDLINECONSOLES && c->name[0];
+	     i++, c++) {
+		if (c->user_specified != user_specified)
+			continue;
+		if (!newcon->match ||
+		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
+			/* default matching */
+			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
+			if (strcmp(c->name, newcon->name) != 0)
+				continue;
+			if (newcon->index >= 0 &&
+			    newcon->index != c->index)
+				continue;
+			if (newcon->index < 0)
+				newcon->index = c->index;
+
+			if (_braille_register_console(newcon, c))
+				return con_braille;
+
+			if (newcon->setup &&
+			    newcon->setup(newcon, c->options) != 0)
+				return con_failed;
+		}
+		newcon->flags |= CON_ENABLED;
+		if (i == preferred_console) {
+			newcon->flags |= CON_CONSDEV;
+			return con_matched_preferred;
+		}
+		return con_matched;
+	}
+	return con_no_match;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2563,11 +2613,10 @@ early_param("keep_bootcon", keep_bootcon_setup);
  */
 void register_console(struct console *newcon)
 {
-	int i;
 	unsigned long flags;
 	struct console *bcon = NULL;
-	struct console_cmdline *c;
 	static bool has_preferred;
+	enum con_match match;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2615,41 +2664,19 @@ void register_console(struct console *newcon)
 		}
 	}
 
-	/*
-	 *	See if this console matches one we selected on
-	 *	the command line.
-	 */
-	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && c->name[0];
-	     i++, c++) {
-		if (!newcon->match ||
-		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
-			/* default matching */
-			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
-			if (strcmp(c->name, newcon->name) != 0)
-				continue;
-			if (newcon->index >= 0 &&
-			    newcon->index != c->index)
-				continue;
-			if (newcon->index < 0)
-				newcon->index = c->index;
-
-			if (_braille_register_console(newcon, c))
-				return;
-
-			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
-				break;
-		}
-
-		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
-			newcon->flags |= CON_CONSDEV;
-			has_preferred = true;
-		}
-		break;
-	}
+	/* See if this console matches one we selected on the command line */
+	match = try_match_new_console(newcon, true);
+	/* If it didn't, try matching the platform ones */
+	if (match == con_no_match)
+		match = try_match_new_console(newcon, false);
+	/* If we matched a Braille console, bail out */
+	if (match == con_braille)
+		return;
+	/* Check if we found a preferred one */
+	if (match == con_matched_preferred)
+		has_preferred = true;
 
+	/* If we don't have an enabled console, bail out */
 	if (!(newcon->flags & CON_ENABLED))
 		return;
 


