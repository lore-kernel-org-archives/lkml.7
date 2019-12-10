Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2EFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370F2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLJW1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:27:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:50011 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfLJW1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:27:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBAMQSkf025639;
        Tue, 10 Dec 2019 16:26:29 -0600
Message-ID: <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Date:   Wed, 11 Dec 2019 09:26:28 +1100
In-Reply-To: <20191210080154.GJ88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
         <20191210080154.GJ88619@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 17:01 +0900, Sergey Senozhatsky wrote:
> On (19/12/10 11:57), Benjamin Herrenschmidt wrote:
> [..]
> >  - add_preferred_console is called early to register "uart0". In
> > our case that happens from acpi_parse_spcr() on arm64 since the
> > "enable_console" argument is true on that architecture. This causes
> > "uart0" to become entry 0 of the console_cmdline array.
> 
> Hmm, two independent console list configuration sources.

Yes, we've had that for a while. So far it "worked" because the
explicit calls to add_preferred_console() tends to happen before the
parsing of the command line, and thus are "overriden" by the latter if
any.

> [..]
> > +++ b/kernel/printk/printk.c
> > @@ -2646,8 +2646,8 @@ void register_console(struct console *newcon)
> >  		if (i == preferred_console) {
> >  			newcon->flags |= CON_CONSDEV;
> >  			has_preferred = true;
> > +			break;
> >  		}
> > -		break;
> >  	}
> >  
> >  	if (!(newcon->flags & CON_ENABLED))
> 
> Wouldn't this, basically, mean that we want to match only consoles,
> which were in the kernel's console= cmdline? IOW, ignore consoles
> that were placed into consoles list via alternative path - ACPI.

No not exactly. Architectures/platforms use add_preferred_console()
(such as arm64 with ACPI but powerpc at least does it too) based on
various factors to select a reasonable "default" for that specific
platform. Without that the kernel will basically default to the first
one to register which may not be what you want.

The command line ones however want to override the defaults (provided
they exist, ie, it's possible that whever is specified on the command
line doesn't actually exist, and thus shall be ignored. That typically
happens when there is either no match or ->setup fails).

> Hmm.
> 
> The patch may affect setups where alias matching is expected to
> happen. E.g.:
> 
> 	console=uartFOO,BAR
> 
> Is 8250 the only console that does alias matching?

Why would the patch affect this negatively ? Today we stop on the first
match, mark the driver enabled, and make it preferred if the match
index matches preferred_console.

My patch makes us continue searching if it wasnt' the preferred console
(but we still mark it enabled). Which means either of those two things
happen:

 - No more match or another match that isn't the preferred_console,
this won't change the existing behaviour.

 - Another match that is marked preferred_console, in which case in
addition to being enabled, the newly registered console will also be
made the default console (ie, first in the list with CONSDEV set). This
is actually what we want ! IE. The console matches the last specified
one on the command line.

Cheers,
Ben.

> 	-ss

