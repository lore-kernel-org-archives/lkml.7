Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF55ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9A206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGOLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727745AbfJGOLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 999A6ADE0;
        Mon,  7 Oct 2019 14:11:00 +0000 (UTC)
Date:   Mon, 7 Oct 2019 16:10:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007141059.friotqx2ymwvlo3j@pathway.suse.cz>
References: <20191007080742.GD2381@dhcp22.suse.cz>
 <FB72D947-A0F9-43E7-80D9-D7ACE33849C7@lca.pw>
 <20191007113710.GH2381@dhcp22.suse.cz>
 <1570450304.5576.283.camel@lca.pw>
 <20191007124356.GJ2381@dhcp22.suse.cz>
 <1570453622.5576.288.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570453622.5576.288.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-07 09:07:02, Qian Cai wrote:
> On Mon, 2019-10-07 at 14:43 +0200, Michal Hocko wrote:
> > On Mon 07-10-19 08:11:44, Qian Cai wrote:
> > > On Mon, 2019-10-07 at 13:37 +0200, Michal Hocko wrote:
> > > > On Mon 07-10-19 07:04:00, Qian Cai wrote:
> > > > > 
> > > > > 
> > > > > > On Oct 7, 2019, at 4:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > 
> > > > > > I do not think that removing the printk is the right long term solution.
> > > > > > While I do agree that removing the debugging printk __offline_isolated_pages
> > > > > > does make sense because it is essentially of a very limited use, this
> > > > > > doesn't really solve the underlying problem.  There are likely other
> > > > > > printks from zone->lock. It would be much more saner to actually
> > > > > > disallow consoles to allocate any memory while printk is called from an
> > > > > > atomic context.
> > > > > 
> > > > > No, there is only a handful of places called printk() from
> > > > > zone->lock. It is normal that the callers will quietly process
> > > > > “struct zone” modification in a short section with zone->lock
> > > > > held.
> > > > 
> > > > It is extremely error prone to have any zone->lock vs. printk
> > > > dependency. I do not want to play an endless whack a mole.
> > > > 
> > > > > No, it is not about “allocate any memory while printk is called from an
> > > > > atomic context”. It is opposite lock chain  from different processors which has the same effect. For example,
> > > > > 
> > > > > CPU0:                 CPU1:         CPU2:
> > > > > console_owner
> > > > >                             sclp_lock
> > > > > sclp_lock                                 zone_lock
> > > > >                             zone_lock
> > > > >                                                  console_owner
> > > > 
> > > > Why would sclp_lock ever take a zone->lock (apart from an allocation).
> > > > So really if sclp_lock is a lock that might be taken from many contexts
> > > > and generate very subtle lock dependencies then it should better be
> > > > really careful what it is calling into.
> > > > 
> > > > In other words you are trying to fix a wrong end of the problem. Fix the
> > > > console to not allocate or depend on MM by other means.
> > > 
> > > It looks there are way too many places that could generate those indirect lock
> > > chains that are hard to eliminate them all. Here is anther example, where it
> > > has,
> > 
> > Yeah and I strongly suspect they are consoles which are broken and need
> > to be fixed rathert than the problem papered over.
> > 
> > I do realize how tempting it is to remove all printks from the
> > zone->lock but do realize that as soon as the allocator starts using any
> > other locks then we are back to square one and the problem is there
> > again. We would have to drop _all_ printks from any locked section in
> > the allocator and I do not think this is viable.
> > 
> > Really, the only way forward is to make these consoles be more careful
> > of external dependencies.
> 
> Even with the new printk() Petr proposed. There is no guarantee it will fix it
> properly. It looks like just reduce the chance of this kind of deadlocks as it
> may or may not call wake_up_klogd() in vprintk_emit() depends on timing.

The chain below is wrong:

> zone->lock
> printk_deferred()
>   vprintk_emit()
>     wake_up_klogd()

wake_up_klogd() calls irq_work_queue(). It queues the work for
an interrupt handler and triggers the interrupt.

>       wake_up_klogd_work_func()
>         console_unlock()

The work is done in the interrupt context. The interrupt could
never be handled under zone->lock.

So, printk_deferred() would help. But I do not think that it is
really needed. I am going to answer the original mail with
all the full lockdep report.

Best Regards,
Petr
