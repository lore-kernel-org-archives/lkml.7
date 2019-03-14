Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8275121019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCNJ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfCNJ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:27:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DA27AF61;
        Thu, 14 Mar 2019 09:27:28 +0000 (UTC)
Date:   Thu, 14 Mar 2019 10:27:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190314092727.m37frq3jszz6mh4g@pathway.suse.cz>
References: <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
 <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
 <20190313092759.GA10060@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313092759.GA10060@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-03-13 18:27:59, Sergey Senozhatsky wrote:
> On (03/13/19 09:40), Sebastian Siewior wrote:
> > On 2019-03-13 09:19:32 [+0100], John Ogness wrote:
> > > recursive situation. As you are pointing out, the notification/wake
> > > component of printk_safe will still be needed. I will leave that (small)
> > > part in printk_safe.c.
> > 
> > Does this mean we keep irq_work part or we bury it and solve it by other
> > means?
>
> *May be* we can take a closer look and find cases when ->atomic
> consoles don't really depend on console_sem. And *may be* we can
> split the console drivers list and somehow forbid removal and
> modification (ioctl) of ->atomic consoles under us. Assuming that
> this is doable we then can start iterating ->atomic consoles list
> with unlocked console_sem.

I believe that this is actually the plan. Atomic consoles depending
on console_sem would not be a real step forward.


> Non->atomic consoles or consoles which depend on console_sem (VT,
> fbcon and so on) will stay in another list, and we will take
> console_sem before we iterate that list and invoke those drivers.

This might be also needed for "less" important messages
that people would not want to get to the console atomically
because it would serialize CPUs and slow down the entire
system.

I think that we would still need irq_work for this mode.
But it should be necessary only for messages from NMI context
and printk() recursion. It means that it should be a rare
situation and the amount of messages should get limited.
It should not be much worse than handling few printk()
calls from any irq handler.

Best Regards,
Petr
