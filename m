Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6779EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D9420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570638224;
	bh=wMxhG9s5h9fA1Vfah8Q8baDQgL2AYa2Qv5Jd6Hxq1gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KM14W0N3qo9SUmI6pNs/Za9MuaYg7J/AbgOnknmUh3mn4XixyYcwRTly5xz/LDe6N
	 5V1EXz+xwVXlfZu64KHFTSEPMtuFv8hF41StPcTM3cK+xHqhTup5FtW51Du6JkzM2s
	 oBw2pzkXEHojupQoB4Pw2dh7NgD2qk62JQ7mZsqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfJIQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731173AbfJIQXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6725EB03D;
        Wed,  9 Oct 2019 16:23:40 +0000 (UTC)
Date:   Wed, 9 Oct 2019 18:23:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191009162339.GI6681@dhcp22.suse.cz>
References: <20191008191728.GS6681@dhcp22.suse.cz>
 <1570563324.5576.309.camel@lca.pw>
 <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
 <1570626402.5937.1.camel@lca.pw>
 <20191009132746.GA6681@dhcp22.suse.cz>
 <1570628593.5937.3.camel@lca.pw>
 <20191009135155.GC6681@dhcp22.suse.cz>
 <1570630784.5937.5.camel@lca.pw>
 <20191009143439.GF6681@dhcp22.suse.cz>
 <1570633715.5937.10.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570633715.5937.10.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 11:08:35, Qian Cai wrote:
> On Wed, 2019-10-09 at 16:34 +0200, Michal Hocko wrote:
> > On Wed 09-10-19 10:19:44, Qian Cai wrote:
> > > On Wed, 2019-10-09 at 15:51 +0200, Michal Hocko wrote:
> > 
> > [...]
> > > > Can you paste the full lock chain graph to be sure we are on the same
> > > > page?
> > > 
> > > WARNING: possible circular locking dependency detected
> > > 5.3.0-next-20190917 #8 Not tainted
> > > ------------------------------------------------------
> > > test.sh/8653 is trying to acquire lock:
> > > ffffffff865a4460 (console_owner){-.-.}, at:
> > > console_unlock+0x207/0x750
> > > 
> > > but task is already holding lock:
> > > ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> > > __offline_isolated_pages+0x179/0x3e0
> > > 
> > > which lock already depends on the new lock.
> > > 
> > > 
> > > the existing dependency chain (in reverse order) is:
> > > 
> > > -> #3 (&(&zone->lock)->rlock){-.-.}:
> > >        __lock_acquire+0x5b3/0xb40
> > >        lock_acquire+0x126/0x280
> > >        _raw_spin_lock+0x2f/0x40
> > >        rmqueue_bulk.constprop.21+0xb6/0x1160
> > >        get_page_from_freelist+0x898/0x22c0
> > >        __alloc_pages_nodemask+0x2f3/0x1cd0
> > >        alloc_pages_current+0x9c/0x110
> > >        allocate_slab+0x4c6/0x19c0
> > >        new_slab+0x46/0x70
> > >        ___slab_alloc+0x58b/0x960
> > >        __slab_alloc+0x43/0x70
> > >        __kmalloc+0x3ad/0x4b0
> > >        __tty_buffer_request_room+0x100/0x250
> > >        tty_insert_flip_string_fixed_flag+0x67/0x110
> > >        pty_write+0xa2/0xf0
> > >        n_tty_write+0x36b/0x7b0
> > >        tty_write+0x284/0x4c0
> > >        __vfs_write+0x50/0xa0
> > >        vfs_write+0x105/0x290
> > >        redirected_tty_write+0x6a/0xc0
> > >        do_iter_write+0x248/0x2a0
> > >        vfs_writev+0x106/0x1e0
> > >        do_writev+0xd4/0x180
> > >        __x64_sys_writev+0x45/0x50
> > >        do_syscall_64+0xcc/0x76c
> > >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > This one looks indeed legit. pty_write is allocating memory from inside
> > the port->lock. But this seems to be quite broken, right? The forward
> > progress depends on GFP_ATOMIC allocation which might fail easily under
> > memory pressure. So the preferred way to fix this should be to change
> > the allocation scheme to use the preallocated buffer and size it from a
> > context when it doesn't hold internal locks. It might be a more complex
> > fix than using printk_deferred or other games but addressing that would
> > make the pty code more robust as well.
> 
> I am not really sure if doing a surgery in pty code is better than fixing the
> memory offline side as a short-term fix.

If this was only about the memory offline code then I would agree. But
we are talking about any printk from the zone->lock context and that is
a bigger deal. Besides that it is quite natural that the printk code
should be more universal and allow to be also called from the MM
contexts as much as possible. If there is any really strong reason this
is not possible then it should be documented at least.

-- 
Michal Hocko
SUSE Labs
