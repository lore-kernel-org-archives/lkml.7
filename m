Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF81DECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863E721655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452240;
	bh=U/+2uKUPz/q7OI4duZz2AsaWHpX52Y7QkHzN0iy8ihw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PKza7WOpYCbJ745AjZ/M/fqyXe5SsZAWJgYYWECrCrnnSe4tzbBYHU+E7XCjnJlmQ
	 v3LSYFIeQk9ZyVDtIIW+K2yMA9UfxGjPnFuctsWGxBqHv4DUBA6R3svq0mWAvGWUJS
	 AdvfOrfu8vFNjItGayOFhhs2SPnBLCmk4ChMQra8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJGMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:43:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfJGMn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30072AB9B;
        Mon,  7 Oct 2019 12:43:57 +0000 (UTC)
Date:   Mon, 7 Oct 2019 14:43:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, john.ogness@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007124356.GJ2381@dhcp22.suse.cz>
References: <20191007080742.GD2381@dhcp22.suse.cz>
 <FB72D947-A0F9-43E7-80D9-D7ACE33849C7@lca.pw>
 <20191007113710.GH2381@dhcp22.suse.cz>
 <1570450304.5576.283.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570450304.5576.283.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 08:11:44, Qian Cai wrote:
> On Mon, 2019-10-07 at 13:37 +0200, Michal Hocko wrote:
> > On Mon 07-10-19 07:04:00, Qian Cai wrote:
> > > 
> > > 
> > > > On Oct 7, 2019, at 4:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > 
> > > > I do not think that removing the printk is the right long term solution.
> > > > While I do agree that removing the debugging printk __offline_isolated_pages
> > > > does make sense because it is essentially of a very limited use, this
> > > > doesn't really solve the underlying problem.  There are likely other
> > > > printks from zone->lock. It would be much more saner to actually
> > > > disallow consoles to allocate any memory while printk is called from an
> > > > atomic context.
> > > 
> > > No, there is only a handful of places called printk() from
> > > zone->lock. It is normal that the callers will quietly process
> > > “struct zone” modification in a short section with zone->lock
> > > held.
> > 
> > It is extremely error prone to have any zone->lock vs. printk
> > dependency. I do not want to play an endless whack a mole.
> > 
> > > No, it is not about “allocate any memory while printk is called from an
> > > atomic context”. It is opposite lock chain  from different processors which has the same effect. For example,
> > > 
> > > CPU0:                 CPU1:         CPU2:
> > > console_owner
> > >                             sclp_lock
> > > sclp_lock                                 zone_lock
> > >                             zone_lock
> > >                                                  console_owner
> > 
> > Why would sclp_lock ever take a zone->lock (apart from an allocation).
> > So really if sclp_lock is a lock that might be taken from many contexts
> > and generate very subtle lock dependencies then it should better be
> > really careful what it is calling into.
> > 
> > In other words you are trying to fix a wrong end of the problem. Fix the
> > console to not allocate or depend on MM by other means.
> 
> It looks there are way too many places that could generate those indirect lock
> chains that are hard to eliminate them all. Here is anther example, where it
> has,

Yeah and I strongly suspect they are consoles which are broken and need
to be fixed rathert than the problem papered over.

I do realize how tempting it is to remove all printks from the
zone->lock but do realize that as soon as the allocator starts using any
other locks then we are back to square one and the problem is there
again. We would have to drop _all_ printks from any locked section in
the allocator and I do not think this is viable.

Really, the only way forward is to make these consoles be more careful
of external dependencies.

I am also wondering, this code is there for a long time (or is there any
recent change?), why are we seeing reports only now? Are those consoles
rarely used or you are simply luck to hit those? Or are those really
representing a deadlock? Maybe the lockdep is just confused? I am not
familiar with the code but console_owner_lock is doing some complex
stuff to hand over the context.

> console_owner -> port_lock
> port_lock -> zone_lock
> 
> [  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
> [  297.425925]        __lock_acquire+0x5b3/0xb40
> [  297.425925]        lock_acquire+0x126/0x280
> [  297.425926]        _raw_spin_lock+0x2f/0x40
> [  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
> [  297.425928]        get_page_from_freelist+0x898/0x22c0
> [  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
> [  297.425929]        alloc_pages_current+0x9c/0x110
> [  297.425930]        allocate_slab+0x4c6/0x19c0
> [  297.425931]        new_slab+0x46/0x70
> [  297.425931]        ___slab_alloc+0x58b/0x960
> [  297.425932]        __slab_alloc+0x43/0x70
> [  297.425933]        __kmalloc+0x3ad/0x4b0
> [  297.425933]        __tty_buffer_request_room+0x100/0x250
> [  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
> [  297.425935]        pty_write+0xa2/0xf0
> [  297.425936]        n_tty_write+0x36b/0x7b0
> [  297.425936]        tty_write+0x284/0x4c0
> [  297.425937]        __vfs_write+0x50/0xa0
> [  297.425938]        vfs_write+0x105/0x290
> [  297.425939]        redirected_tty_write+0x6a/0xc0
> [  297.425939]        do_iter_write+0x248/0x2a0
> [  297.425940]        vfs_writev+0x106/0x1e0
> [  297.425941]        do_writev+0xd4/0x180
> [  297.425941]        __x64_sys_writev+0x45/0x50
> [  297.425942]        do_syscall_64+0xcc/0x76c
> [  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-- 
Michal Hocko
SUSE Labs
