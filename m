Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F291CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E81214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfJUM6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:58:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbfJUM6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:58:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 433A8AC18;
        Mon, 21 Oct 2019 12:58:52 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:58:49 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191021125842.GA11330@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018120615.GM5017@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:06:15PM +0200, Michal Hocko wrote:
> On Thu 17-10-19 16:21:17, Oscar Salvador wrote:
> [...]
> > +bool take_page_off_buddy(struct page *page)
> > + {
> > +	struct zone *zone = page_zone(page);
> > +	unsigned long pfn = page_to_pfn(page);
> > +	unsigned long flags;
> > +	unsigned int order;
> > +	bool ret = false;
> > +
> > +	spin_lock_irqsave(&zone->lock, flags);
> 
> What prevents the page to be allocated in the meantime? Also what about
> free pages on the pcp lists? Also the page could be gone by the time you
> have reached here.

Nothing prevents the page to be allocated in the meantime.
We would just bail out and return -EBUSY to userspace.
Since we do not do __anything__ to the page until we are sure we took it off,
and it is completely isolated from the memory, there is no danger.

Since soft-offline is kinda "best effort" mode, it is something like:
"Sorry, could not poison the page, try again".

Now, thinking about this a bit more, I guess we could be more clever here
and call the routine that handles in-use pages if we see that the page
was allocated by the time we reach take_page_off_buddy.

About pcp pages, you are right.
I thought that we were already handling that case, and we do, but looking closer the
call to shake_page() (that among other things spills pcppages into buddy)
is performed at a later stage.
I think we need to adjust __get_any_page to recognize pcp pages as well.

I will do some work here.

Thanks for comments.

-- 
Oscar Salvador
SUSE L3
