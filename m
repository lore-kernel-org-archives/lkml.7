Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A02ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3393220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfJJLL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfJJLL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55FC3AE36;
        Thu, 10 Oct 2019 11:11:24 +0000 (UTC)
Date:   Thu, 10 Oct 2019 13:11:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        rostedt@goodmis.org, peterz@infradead.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, john.ogness@linutronix.de,
        akpm@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010111123.ql7c4v6hmmplutgb@pathway.suse.cz>
References: <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
 <20191010082110.dreavjarni7mkvv6@pathway.suse.cz>
 <20191010083908.GA2521@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010083908.GA2521@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-10-10 17:39:08, Sergey Senozhatsky wrote:
> On (10/10/19 10:21), Petr Mladek wrote:
> [..]
> > > > Considering that console.write is called from essentially arbitrary code
> > > > path IIUC then all the locks used in this path should be pretty much
> > > > tail locks or console internal ones without external dependencies.
> > > 
> > > That's a good expectation, but I guess it's not always the case.
> > > 
> > > One example might be NET console - net subsystem locks, net device
> > > drivers locks, maybe even some MM locks (skb allocations?).
> > > 
> > > But even more "commonly used" consoles sometimes break that
> > > expectation. E.g. 8250
> > > 
> > > serial8250_console_write()
> > >  serial8250_modem_status()
> > >   wake_up_interruptible()
> > > 
> > > And so on.
> > 
> > I think that the only maintainable solution is to call the console
> > drivers in a well defined context (kthread). We have finally opened
> > doors to do this change.
> 
> Yeah, that's a pretty complex thing, I suspect. Panic flush to
> netcon may deadlock if oops occurs under one of those "important
> MM locks" (if any MM locks are actually involved in ATOMIC skb
> allocation). If there are such MM locks, then I think flush_on_panic
> issue can't be address by printing kthread or ->atomic_write callback.

Sure, we could not rely on kthreads in panic(). In this situation
any lock taken from console->write() callback is a possible source
of a deadlock.

Note that I say that the locks are the problem and not printk()
called under these locks. It is because:

  + The experience shows that we could not prevent people from
    using printk() anywhere.

  + printk() might get called even when it is not used explicitly.
    For example, from NMI, IRQ, Oops.


So, the best solution is to avoid as many locks in console->write()
callbacks as possible. Especially this means as less dependencies
on external subsystems as possible. MM is an obvious candidate.
We should avoid calling MM not only because it uses locks but
also because there might not be any available memory.

Of course, there are better and worse console drivers. It is hard
to expect that all will or can be made safe. From the printk()
point of view, the defense against the problematic consoles
might be:

   + Classify each console driver. Flush all messages to the most
     reliable consoles first and to the least reliable ones at last.

   + Prevent calling consoles when there is other way to preserve
     the messages over the reboot, e.g. crashdump or permanent memory.


Of course, we will still need a way how to actively search for
problems in advance. For example, printk() could use a fake
lock even during the normal operation so that it could trigger
lockdep splat. We could enable it after all the init calls
are proceed to reduce the number of false positives.


Hmm, this discussion probably belongs to another thread about
printk() design.

Anyway, it seems that removing MM from console->write() calls
is a win-win solution.

Best Regards,
Petr
