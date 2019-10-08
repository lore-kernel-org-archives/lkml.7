Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62251ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9821871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfJHIPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbfJHIPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86616ADDC;
        Tue,  8 Oct 2019 08:15:11 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:15:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
 <20191007151237.GP2381@dhcp22.suse.cz>
 <1570462407.5576.292.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570462407.5576.292.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-07 11:33:27, Qian Cai wrote:
> On Mon, 2019-10-07 at 17:12 +0200, Michal Hocko wrote:
> > On Mon 07-10-19 10:59:10, Qian Cai wrote:
> > [...]
> > > It is almost impossible to eliminate all the indirect call chains from
> > > console_sem/console_owner_lock to zone->lock because it is too normal that
> > > something later needs to allocate some memory dynamically, so as long as it
> > > directly call printk() with zone->lock held, it will be in trouble.
> > 
> > Do you have any example where the console driver really _has_ to
> > allocate. Because I have hard time to believe this is going to work at
> > all as the atomic context doesn't allow to do any memory reclaim and
> > such an allocation would be too easy to fail so the allocation cannot
> > really rely on it.
> 
> I don't know how to explain to you clearly, but let me repeat again one last
> time. There is no necessary for console driver directly to allocate considering
> this example,
> 
> CPU0:              CPU1:    CPU2:       CPU3:
> console_sem->lock                       zone->lock
>                    pi->lock
> pi->lock                    rq_lock
>                    rq->lock
>                             zone->lock
>                                         console_sem->lock

I am curious about CPU2. Does scheduler need to allocate memory?

> Here it only need someone held the rq_lock and allocate some memory. There is
> also true for port_lock. Since the deadlock could involve a lot of CPUs and a
> longer lock chain, it is impossible to predict which one to allocate some memory
> while held a lock could end up with the same problematic lock chain.
> 
> This is just a tip of iceberg to show the lock dependency,
> 
> console_owner --> port_lock_key
> 
> which could easily happen everywhere with a simple printk().

We have got several lockdep reports about possible deadlocks between
console_lock and port_lock caused by printk() called from console
code.

First note that they have been there for years. They were well hidden
until 4.11 released in April 2017. Where the commit
f975237b76827956fe13e ("printk: use printk_safe buffers in printk")
allowed recursive printk() and lockdep.

We believe that these deadlocks are really hard to hit. Console
drivers call printk() only in very critical and rare situations.
This is why nobody invested too much time into fixing these
so far.

There are basically three possibilities:

1. Do crazy exercises with locks all around the kernel to
   avoid the deadlocks. It is usually not worth it. And
   it is a "whack a mole" approach.

2. Use printk_deferred() in problematic code paths. It is
   a "whack a mole" approach as well. And we would end up
   with printk_deferred() used almost everywhere.

3. Always deffer the console handling in printk(). This would
   help also to avoid soft lockups. Several people pushed
   against this last few years because it might reduce
   the chance to see the message in case of system crash.

As I said, there has finally been agreement to always do
the offload few weeks ago. John Ogness is working on it.
So we might have the systematic solution for these deadlocks
rather sooner than later.

Feel free to ask John to CC you on the patches if you want
to help with review.

Best Regards,
Petr
