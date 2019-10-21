Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68BDCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF72070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571667152;
	bh=clcgHjrxDMuAXRCjN1821UyecuiY1dA5ZM4jCVNJO4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O4FXt5cLiXDvOz9yMgzG2T/kp9P2dhBFS3F7r//0gZf/gEaCsV8GvbL8zGlfNKQee
	 ZaHNI/hRSEt4x1N+A4+0DpWEy4ozW4xONXDWh1IHHpF/HVk2gHLBekpNidnxL6aBIC
	 NfaUhfzjPOnlAn+c6eFYdjxADOvM0HErrVaZxK8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfJUOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:12:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727344AbfJUOMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:12:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE668BE68;
        Mon, 21 Oct 2019 14:12:28 +0000 (UTC)
Date:   Mon, 21 Oct 2019 16:12:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191021141228.GR9379@dhcp22.suse.cz>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
 <20191021094808.28824-2-mgorman@techsingularity.net>
 <85A7E76A-0839-4A43-86F3-6847639F9F92@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85A7E76A-0839-4A43-86F3-6847639F9F92@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 10:01:24, Qian Cai wrote:
> 
> 
> > On Oct 21, 2019, at 5:48 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
i[...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c0b2e0306720..f972076d0f6b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1947,6 +1947,14 @@ void __init page_alloc_init_late(void)
> > 	/* Block until all are initialised */
> > 	wait_for_completion(&pgdat_init_all_done_comp);
> > 
> > +	/*
> > +	 * The number of managed pages has changed due to the initialisation
> > +	 * so the pcpu batch and high limits needs to be updated or the limits
> > +	 * will be artificially small.
> > +	 */
> > +	for_each_populated_zone(zone)
> > +		zone_pcp_update(zone);
> > +
> > 	/*
> > 	 * We initialized the rest of the deferred pages.  Permanently disable
> > 	 * on-demand struct page initialization.
> > -- 
> > 2.16.4
> > 
> > 
> 
> Warnings from linux-next,
> 
> [   14.265911][  T659] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> [   14.265992][  T659] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 659, name: pgdatinit8
> [   14.266044][  T659] 1 lock held by pgdatinit8/659:
> [   14.266075][  T659]  #0: c000201ffca87b40 (&(&pgdat->node_size_lock)->rlock){....}, at: deferred_init_memmap+0xc4/0x26c

This is really surprising to say the least. I do not see any spinlock
held here. Besides that we do sleep in wait_for_completion already.
Is it possible that the patch has been misplaced? zone_pcp_update is
called from page_alloc_init_late which is a different context than
deferred_init_memmap which runs in a separate kthread.

> [   14.266160][  T659] irq event stamp: 26
> [   14.266194][  T659] hardirqs last  enabled at (25): [<c000000000950584>] _raw_spin_unlock_irq+0x44/0x80
> [   14.266246][  T659] hardirqs last disabled at (26): [<c0000000009502ec>] _raw_spin_lock_irqsave+0x3c/0xa0
> [   14.266299][  T659] softirqs last  enabled at (0): [<c0000000000ff8d0>] copy_process+0x720/0x19b0
> [   14.266339][  T659] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   14.266400][  T659] CPU: 64 PID: 659 Comm: pgdatinit8 Not tainted 5.4.0-rc4-next-20191021 #1
> [   14.266462][  T659] Call Trace:
> [   14.266494][  T659] [c00000003d8efae0] [c000000000921cf4] dump_stack+0xe8/0x164 (unreliable)
> [   14.266538][  T659] [c00000003d8efb30] [c000000000157c54] ___might_sleep+0x334/0x370
> [   14.266577][  T659] [c00000003d8efbb0] [c00000000094a784] __mutex_lock+0x84/0xb20
> [   14.266627][  T659] [c00000003d8efcc0] [c000000000954038] zone_pcp_update+0x34/0x64
> [   14.266677][  T659] [c00000003d8efcf0] [c000000000b9e6bc] deferred_init_memmap+0x1b8/0x26c
> [   14.266740][  T659] [c00000003d8efdb0] [c000000000149528] kthread+0x1a8/0x1b0
> [   14.266792][  T659] [c00000003d8efe20] [c00000000000b748] ret_from_kernel_thread+0x5c/0x74
> [   14.268288][  T659] node 8 initialised, 1879186 pages in 12200ms
> [   14.268527][  T659] pgdatinit8 (659) used greatest stack depth: 27984 bytes left
> [   15.589983][  T658] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> [   15.590041][  T658] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 658, name: pgdatinit0
> [   15.590078][  T658] 1 lock held by pgdatinit0/658:
> [   15.590108][  T658]  #0: c000001fff5c7b40 (&(&pgdat->node_size_lock)->rlock){....}, at: deferred_init_memmap+0xc4/0x26c
> [   15.590192][  T658] irq event stamp: 18
> [   15.590224][  T658] hardirqs last  enabled at (17): [<c000000000950654>] _raw_spin_unlock_irqrestore+0x94/0xd0
> [   15.590283][  T658] hardirqs last disabled at (18): [<c0000000009502ec>] _raw_spin_lock_irqsave+0x3c/0xa0
> [   15.590332][  T658] softirqs last  enabled at (0): [<c0000000000ff8d0>] copy_process+0x720/0x19b0
> [   15.590379][  T658] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   15.590414][  T658] CPU: 8 PID: 658 Comm: pgdatinit0 Tainted: G        W         5.4.0-rc4-next-20191021 #1
> [   15.590460][  T658] Call Trace:
> [   15.590491][  T658] [c00000003d8cfae0] [c000000000921cf4] dump_stack+0xe8/0x164 (unreliable)
> [   15.590541][  T658] [c00000003d8cfb30] [c000000000157c54] ___might_sleep+0x334/0x370
> [   15.590588][  T658] [c00000003d8cfbb0] [c00000000094a784] __mutex_lock+0x84/0xb20
> [   15.590643][  T658] [c00000003d8cfcc0] [c000000000954038] zone_pcp_update+0x34/0x64
> [   15.590689][  T658] [c00000003d8cfcf0] [c000000000b9e6bc] deferred_init_memmap+0x1b8/0x26c
> [   15.590739][  T658] [c00000003d8cfdb0] [c000000000149528] kthread+0x1a8/0x1b0
> [   15.590790][  T658] [c00000003d8cfe20] [c00000000000b748] ret_from_kernel_thread+0x5c/0x74

-- 
Michal Hocko
SUSE Labs
