Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79624208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404458AbfFKPKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:10:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404326AbfFKPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:10:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F10FAFA5;
        Tue, 11 Jun 2019 15:10:19 +0000 (UTC)
Date:   Tue, 11 Jun 2019 17:10:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190611151018.gvjazu4vedw2h2qh@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
 <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
 <20190607170922.GA17017@xo-6d-61-c0.localdomain>
 <b28da439-1d2c-9a1c-17be-fa8b8476d313@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28da439-1d2c-9a1c-17be-fa8b8476d313@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-06-08 11:45:45, Tetsuo Handa wrote:
> On 2019/06/08 2:09, Pavel Machek wrote:
> > On Tue 2019-05-28 19:15:43, Tetsuo Handa wrote:
> >> On 2019/05/28 17:51, Sergey Senozhatsky wrote:
> >>>> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
> >>>> context information. But doesn't such attempt resemble find_printk_buffer() ?
> >>>
> >>> Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
> >>> line is hardly possible. At the same time I'd really prefer not
> >>> to have buffering for sysrq.
> >>
> >> I don't think it is hardly possible. And I really prefer having
> >> deferred printing for SysRq.

> > 
> > Well, magic SysRq was meant for situation where system is in weird/broken state.
> > "Give me backtrace where it is hung", etc. Direct printing is more likely to work
> > in that cases.
> 
> Magic SysRq from keyboard is for situation where system is in weird/broken state.
> 
> But I want to use Magic SysRq from /proc for situation where system is not fatally
> weird/broken state. I have trouble getting SysRq-t from /proc when something bad
> happened (e.g. some health check process did not return for 60 seconds). Since
> /proc/pid/wchan shows only 1 line, it is useless for understanding why that process
> got stuck. If direct printing is enforced, "echo t > /proc/sysrq-trigger" might take
> many minutes. If direct printing is not enforced, "echo t > /proc/sysrq-trigger"
> should complete within less than one second. If syslog is working (which is almost
> equivalent to being able to write to /proc/sysrq-trigger), the latter is more helpful
> for taking snapshots for multiple times (e.g. 5 times with 10 seconds interval) in
> order to understand why that process got stuck. That's why I added

This looks like a very specific use case. But the proposal changes
the behavior for anyone. I am not persuaded that everyone would
appreciate the change.

OK, it takes 60 seconds when the messages appear on the console and
1 second when they are just stored to the syslog.

Why the system is configured to show all messages on the console
when syslog is enough?

If sysrq is the preferred interface, it might be used also the other
way. I mean to increase console_loglevel to hide all messages on
the console, trigger output of the system state and eventually
decrease the loglevel again.

> Also, regarding Magic SysRq from keyboard case, my intent is to allow SysRq
> to just store the messages to printk() buffer, in order to avoid stalls and
> take better snapshots for multiple times. And my intent of
> 
>   And I really prefer having deferred printing for SysRq.

Always deferring printk() for everyone is not acceptable. It is one
extreme between printk() reliability and speed in favor of the speed.
But many people prefer reliability (high chance to see messages
when the system goes down.

IMHO, the only acceptable solution need to be configurable:

   + never deffer (debugging corner cases?)
   + avoid softlockup (default on normal systems?)
   + guarantee max time (throughput oriented systems)
   + always deffer (real time, special usecases)

It might be based on Sergey's patchsets adding the offload logic
into console_unlock().

IMHO, the most problematic thing is how to define the limit
(lines?, characters?, time?). A limit bases on the data amount
would also depend on console speed. Time based limit would be
better but measuring time in console_unlock() is problematic
(atomic context, possible deadlocks).

Best Regards,
Petr
