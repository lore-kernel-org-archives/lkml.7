Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F63C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6182075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565080158;
	bh=3edY4Y9PFCZ1ppIc6dRX/VFv9Pmaa5EO6FEFuE6ZR9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ocN22QT41s8hQozUcLVrsUclRCJz4bu7BSQ565y0GnHrGIOtJgHrsMtEy3UgTTYbM
	 7yKuLxh20uW90GJnYrESyvMr3eXHv4SbtaG/NQOiX3AEZfVk0n/2Vwm24WBLHS8S/t
	 FNLJ0FIFdVklJ7bzoKzMzFxRJ9EVrPzG+W8gap/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfHFI3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:29:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbfHFI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C99FAF1D;
        Tue,  6 Aug 2019 08:29:10 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:29:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     syzbot <syzbot+8e6326965378936537c3@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, chris@chrisdown.name, chris@zankel.net,
        dancol@google.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        hdanton@sina.com, james.bottomley@hansenpartnership.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        laoar.shao@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        oleksandr@redhat.com, ralf@linux-mips.org, rth@twiddle.net,
        sfr@canb.auug.org.au, shakeelb@google.com, sonnyrao@google.com,
        surenb@google.com, syzkaller-bugs@googlegroups.com,
        timmurray@google.com, yang.shi@linux.alibaba.com
Subject: Re: kernel BUG at mm/vmscan.c:LINE! (2)
Message-ID: <20190806082907.GI11812@dhcp22.suse.cz>
References: <000000000000a9694d058f261963@google.com>
 <20190802200643.GA181880@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802200643.GA181880@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03-08-19 05:06:43, Minchan Kim wrote:
> On Fri, Aug 02, 2019 at 10:58:05AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    0d8b3265 Add linux-next specific files for 20190729
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1663c7d0600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ae96f3b8a7e885f7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8e6326965378936537c3
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c437c600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15645854600000
> > 
> > The bug was bisected to:
> > 
> > commit 06a833a1167e9cbb43a9a4317ec24585c6ec85cb
> > Author: Minchan Kim <minchan@kernel.org>
> > Date:   Sat Jul 27 05:12:38 2019 +0000
> > 
> >     mm: introduce MADV_PAGEOUT
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1545f764600000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1745f764600000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1345f764600000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> > Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
> > 
> > raw: 01fffc0000090025 dead000000000100 dead000000000122 ffff88809c49f741
> > raw: 0000000000020000 0000000000000000 00000002ffffffff ffff88821b6eaac0
> > page dumped because: VM_BUG_ON_PAGE(PageActive(page))
> > page->mem_cgroup:ffff88821b6eaac0
> > ------------[ cut here ]------------
> > kernel BUG at mm/vmscan.c:1156!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 9846 Comm: syz-executor110 Not tainted 5.3.0-rc2-next-20190729
> > #54
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156
> 
> My old version had PG_active flag clear but it seems to lose it with revising
> patchsets. Thanks, Sizbot!
> 
> >From 66d64988619ef7e86b0002b2fc20fdf5b84ad49c Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Sat, 3 Aug 2019 04:54:02 +0900
> Subject: [PATCH] mm: Clear PG_active on MADV_PAGEOUT
> 
> shrink_page_list expects every pages as argument should be no active
> LRU pages so we need to clear PG_active.

Ups, missed that during review.

> 
> Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")

This is not a valid sha1 because it likely comes from linux-next. I
guess Andrew will squash it into mm-introduce-madv_pageout.patch

Just for the record
Acked-by: Michal Hocko <mhocko@suse.com>

And thanks for syzkaller to exercise the new interface so quickly!

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/vmscan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 47aa2158cfac2..e2a8d3f5bbe48 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2181,6 +2181,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  		}
>  
>  		if (nid == page_to_nid(page)) {
> +			ClearPageActive(page);
>  			list_move(&page->lru, &node_page_list);
>  			continue;
>  		}
> -- 
> 2.22.0.770.g0f2c4a37fd-goog

-- 
Michal Hocko
SUSE Labs
