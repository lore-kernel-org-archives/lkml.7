Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CD22184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfJVHq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:46:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbfJVHqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:46:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29256B299;
        Tue, 22 Oct 2019 07:46:23 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:46:20 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022074615.GA19060@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021154158.GV9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:41:58PM +0200, Michal Hocko wrote:
> On Mon 21-10-19 14:58:49, Oscar Salvador wrote:
> > Nothing prevents the page to be allocated in the meantime.
> > We would just bail out and return -EBUSY to userspace.
> > Since we do not do __anything__ to the page until we are sure we took it off,
> > and it is completely isolated from the memory, there is no danger.
> 
> Wouldn't it be better to simply check the PageBuddy state after the lock
> has been taken?

We already do that:

bool take_page_off_buddy(struct page *page)
 {
	... 
        spin_lock_irqsave(&zone->lock, flags);
        for (order = 0; order < MAX_ORDER; order++) {
                struct page *page_head = page - (pfn & ((1 << order) - 1));
                int buddy_order = page_order(page_head);
                struct free_area *area = &(zone->free_area[buddy_order]);

                if (PageBuddy(page_head) && buddy_order >= order) {
	...
 }

Actually, we __only__ call break_down_buddy_pages() (which breaks down a higher-order page
and keeps our page out of buddy) if that is true.

> > Since soft-offline is kinda "best effort" mode, it is something like:
> > "Sorry, could not poison the page, try again".
> 
> Well, I would disagree here. While madvise is indeed a best effort
> operation please keep in mind that the sole purpose of this interface is
> to allow real MCE behavior. And that operation should better try
> _really_ hard to make sure we try to recover as gracefully as possible.

In this case, there is nothing to be recovered from.
If we wanted to soft-offline a page that was free, and then it was allocated
in the meantime, there is no harm in that as we do not flag the page
until we are sure it is under our control.
That means:

 - for free pages: was succesfully taken off buddy
 - in use pages: was freed or migrated

So, opposite to hard-offline, in soft-offline we do not fiddle with pages
unless we are sure the page is not reachable anymore by any means.

> > Now, thinking about this a bit more, I guess we could be more clever here
> > and call the routine that handles in-use pages if we see that the page
> > was allocated by the time we reach take_page_off_buddy.
> > 
> > About pcp pages, you are right.
> > I thought that we were already handling that case, and we do, but looking closer the
> > call to shake_page() (that among other things spills pcppages into buddy)
> > is performed at a later stage.
> > I think we need to adjust __get_any_page to recognize pcp pages as well.
> 
> Yeah, pcp pages are PITA. We cannot really recognize them now. Dropping
> all pcp pages is certainly a way to go but we need to mark the page
> before that happens.

I will work on that.

-- 
Oscar Salvador
SUSE L3
