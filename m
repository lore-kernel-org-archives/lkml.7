Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D74C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7D2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLJA6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:58:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:40870 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfLJA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:58:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBA0vQdi010522;
        Mon, 9 Dec 2019 18:57:27 -0600
Message-ID: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
Subject: [RFC/PATCH] printk: Fix preferred console selection with multiple
 matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Date:   Tue, 10 Dec 2019 11:57:26 +1100
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

This tentative fix changes the loop in register_console to continue
matching with the array until the match is actually the preferred
console.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aa96098c64d..d36b9901c0e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2646,8 +2646,8 @@ void register_console(struct console *newcon)
 		if (i == preferred_console) {
 			newcon->flags |= CON_CONSDEV;
 			has_preferred = true;
+			break;
 		}
-		break;
 	}
 
 	if (!(newcon->flags & CON_ENABLED))
-- 
2.17.1

