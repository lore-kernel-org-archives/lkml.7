Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44147C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF96206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfLKEDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:03:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:48317 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfLKEC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:02:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBB422AG012504;
        Tue, 10 Dec 2019 22:02:03 -0600
Message-ID: <38b543cb91e936d7bd9f8885e585dd55032d83a4.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 15:02:02 +1100
In-Reply-To: <20191211020149.GN88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
         <20191210080154.GJ88619@google.com>
         <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
         <20191211020149.GN88619@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 11:01 +0900, Sergey Senozhatsky wrote:
> On (19/12/11 09:26), Benjamin Herrenschmidt wrote:
> 

> As far as I know, ->match() does not only match but also does ->setup().
> If we have two console list entries that match (one via aliasing and one
> via exact match) then the console driver is setup twice. Do all console
> drivers handle it? [double setup]

I don't think it's an issue but I may be wrong. I had a quick look
at some of the drivers and I don't really see why they would break but
I couldn't look at them all and I might be mistaken.

We could skip setup if the console is already enabled but I would
advise against that since the two calls might have different options
(the firmware baud rate could be different from the command line one
for example) and we want the options for the last one.

> If we could perform simple alias matching, without ->setup() call, and
> exact matching (strcmp()), and then, if newcon would match two entries,
> we would pick up the last matching entry and configure newcon only once.
> 
> This changes the order, tho.

Walking the array backwards might just be what we want actually for the
case at hand, but of course if some platforms or driver call
add_preferred_console *after* the command line parsing, then it will
break those.

Simple alias matching would require re-working all the match()
callbacks. That said I think it was a mistake to begin with to have
them include setup(). Those should have remained separate.

What about a compromise here:

Instead of walking the array and testing for preferred_console as we do
so, we first test the array entry pointed to by preferred_console
(doing both match & setup as today) and if that doesn't work, fallback
to our existing mechanism ?

It would be a first step. It wouldn't fix all cases but would be
something reasonable to backport.

Another approach woudl be to pass to add_preferred_console an argument
"bool user_specified" which we would use to set a CON_USER flag.

We could then do a two-pass lookup of the array where we first only
match user specified entries, then match the rest.

> [..]
> >  - Another match that is marked preferred_console, in which case in
> > addition to being enabled, the newly registered console will also be
> > made the default console (ie, first in the list with CONSDEV set). This
> > is actually what we want ! IE. The console matches the last specified
> > one on the command line.
> 
> Well, it still looks to me that what you want is to "ignore alias
> match and prefer exact match".

We don't want to ignore the alias match. But we do want to prefer the
exact match. We still want to keep the fallback to the alias match.

Cheers,
Ben.


