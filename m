Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA2BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3C2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJGJF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727383AbfJGJF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99BDDB14B;
        Mon,  7 Oct 2019 09:05:54 +0000 (UTC)
Date:   Mon, 7 Oct 2019 11:05:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com, john.ogness@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007090553.g5cq7qa4tj5yrtaa@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007080742.GD2381@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007080742.GD2381@dhcp22.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-07 10:07:42, Michal Hocko wrote:
> On Fri 04-10-19 18:26:45, Qian Cai wrote:
> > It is unsafe to call printk() while zone->lock was held, i.e.,
> > 
> > zone->lock --> console_lock
> > 
> > because the console could always allocate some memory in different code
> > paths and form locking chains in an opposite order,
> > 
> > console_lock --> * --> zone->lock
> > 
> > As the result, it triggers lockdep splats like below and in different
> > code paths in this thread [1]. Since has_unmovable_pages() was only used
> > in set_migratetype_isolate() and is_pageblock_removable_nolock(). Only
> > the former will set the REPORT_FAILURE flag which will call printk().
> > Hence, unlock the zone->lock just before the dump_page() there where
> > when has_unmovable_pages() returns true, there is no need to hold the
> > lock anyway in the rest of set_migratetype_isolate().
> > 
> > While at it, remove a problematic printk() in __offline_isolated_pages()
> > only for debugging as well which will always disable lockdep on debug
> > kernels.
> 
> I do not think that removing the printk is the right long term solution.
> While I do agree that removing the debugging printk __offline_isolated_pages
> does make sense because it is essentially of a very limited use, this
> doesn't really solve the underlying problem.  There are likely other
> printks from zone->lock. It would be much more saner to actually
> disallow consoles to allocate any memory while printk is called from an
> atomic context.

The current "standard" solution for these situations is to replace
the problematic printk() with printk_deferred(). It would deffer
the console handling.

Of course, this is a whack a mole approach. The long term solution
is to deffer printk() by default. We have finally agreed on this
few weeks ago on Plumbers conference. It is going to be added
together with fully lockless log buffer hopefully soon. It will
be part of upstreaming Real-Time related code.

> > The problem is probably there forever, but neither many developers will
> > run memory offline with the lockdep enabled nor admins in the field are
> > lucky enough yet to hit a perfect timing which required to trigger a
> > real deadlock. In addition, there aren't many places that call printk()
> > while zone->lock was held.
> > 
> > WARNING: possible circular locking dependency detected
> > ------------------------------------------------------
> > test.sh/1724 is trying to acquire lock:
> > 0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
> > 01: 328/0xa30
> > 
> > but task is already holding lock:
> > 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
> > 01: late_page_range+0x216/0x538
> 
> I am also wondering what does this lockdep report actually say. How come
> we have a dependency between a start_kernel path and a syscall?

My understanding is that these are different code paths. Where each
code paths shows one existing lock ordering.

IMHO, it is possible that these code paths could never run in
parallel. I guess that lockdep is not able to distinguish
code paths that are called only during boot and others
that are called only in fully booted system. That said,
I am not sure if this is the case here.

Best Regards,
Petr
