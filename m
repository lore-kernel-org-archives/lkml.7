Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C1C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70052171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405111AbfHIAsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfHIAsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:48:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3DA20C01;
        Fri,  9 Aug 2019 00:48:43 +0000 (UTC)
Date:   Thu, 8 Aug 2019 20:48:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Message-ID: <20190808204841.5afcad46@gandalf.local.home>
In-Reply-To: <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-10-john.ogness@linutronix.de>
        <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
        <874l2rclmw.fsf@linutronix.de>
        <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
        <20190808194523.6f83e087@gandalf.local.home>
        <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 17:21:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But laptops don't have reset buttons. They have "press the power
> button for ten seconds, power turns off. Press it again, and power
> comes on" reset sequences.

I've never tried, but are you saying that even with the "10 second
hold" the laptop's DRAM may still have old data that is accessible?


> 
> They are nasty to debug when they happen on a developer machine (I
> should know, I've definitely had them), but when they happen in the
> wild they are basically "user just rebooted the machine". End of
> story, and no stats or anything like that.

Would a best effort 1 page buffer work? Really, with a hard hang we
usually only care about the last thing that was printed (we need to add
one of those: stop printing after the first WARN_ON is hit, to not
lose the initial bug).

That way you could have a buffer that is written to constantly but only
is the size of one or two pages. It can have a variable in it that gets
reset on shutdown. If the system hangs, the next boot could look to see
if that page was shutdown cleanly (or never initialized) otherwise, it
can read the page or pages into a buffer that can be read from debugfs.

A user space tool could read this page and if it detects that it
contains data from a crash, notify the user and say "Can you send this
to linux-kernel@vger.kernel.org"? Even better if it tells the user the
subject and content of the email that should be sent.

-- Steve
