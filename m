Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C041920673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570524036;
	bh=ztMVJu70f7Wzk4Hpyopzu5sw8UM/3NaOonTy4ToEadk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zF3O0ZecFwmZ+pBb3SMuwT9012lSFgjq2T7zbRgBasL7P9pU03eSJs/W5u10AEFV+
	 EvQCoZ4jOdV+hlACDT71L86kVtr/kjKA5iJJcFVBO+cJWzqSYaRlOUdCwtAR0UN7XH
	 eCJrc1bX8/TYLVW14SPzZFaLy9pHETqxwNjYEqEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfJHIkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:40:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:40260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:40:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23F2BAF87;
        Tue,  8 Oct 2019 08:40:33 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:40:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008084031.GC6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
 <20191007151237.GP2381@dhcp22.suse.cz>
 <1570462407.5576.292.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570462407.5576.292.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 11:33:27, Qian Cai wrote:
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
> 
> Here it only need someone held the rq_lock and allocate some memory.

Is the scheduler really allocating while holding the rq lock?

> There is
> also true for port_lock. Since the deadlock could involve a lot of CPUs and a
> longer lock chain, it is impossible to predict which one to allocate some memory
> while held a lock could end up with the same problematic lock chain.

And that is exactly what I've said earlier. Locks used by consoles
should really better be tail locks because then they are going to create
arbitrary dependency chains. The zone->lock is in no way special here.
 
> > So again, crippling the MM code just because of lockdep false possitives
> > or a broken console driver sounds like a wrong way to approach the
> > problem.
> > 
> > > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > > [  297.425967]        lock_acquire+0x126/0x280
> > > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > > [  297.425970]        univ8250_console_write+0x4b/0x60
> > > [  297.425970]        console_unlock+0x501/0x750
> > > [  297.425971]        vprintk_emit+0x10d/0x340
> > > [  297.425972]        vprintk_default+0x1f/0x30
> > > [  297.425972]        vprintk_func+0x44/0xd4
> > > [  297.425973]        printk+0x9f/0xc5
> > > [  297.425974]        register_console+0x39c/0x520
> > > [  297.425975]        univ8250_console_init+0x23/0x2d
> > > [  297.425975]        console_init+0x338/0x4cd
> > > [  297.425976]        start_kernel+0x534/0x724
> > > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > 
> > This is an early init code again so the lockdep sounds like a false
> > possitive to me.
> 
> This is just a tip of iceberg to show the lock dependency,

Does this tip point to a real deadlock or merely a class of lockdep
false dependencies?

> console_owner --> port_lock_key
> 
> which could easily happen everywhere with a simple printk().

-- 
Michal Hocko
SUSE Labs
