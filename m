Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD5CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2371D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571672523;
	bh=pe6wXcO3jDuMibDCNI6MAcNzt7uASgB+Lk3Qh7R/3XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cu1g8oW8PtuliI+e7BvLChl3I5OqFFJq/v6h1ax53Cci8wWmVfxBRzGjFcvWhGt9+
	 tFmVBigTDnsyDLtzkbFfp4h2vICyQ+M5DKifgiVANzUNuhpZFABRcoenRY8Qxv6xCh
	 u2kiTTDg/iHNhfXZnFQp5Y8XyADoGNBpsbXj/N6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfJUPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:42:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfJUPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 183E0B392;
        Mon, 21 Oct 2019 15:41:59 +0000 (UTC)
Date:   Mon, 21 Oct 2019 17:41:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191021154158.GV9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021125842.GA11330@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 14:58:49, Oscar Salvador wrote:
> On Fri, Oct 18, 2019 at 02:06:15PM +0200, Michal Hocko wrote:
> > On Thu 17-10-19 16:21:17, Oscar Salvador wrote:
> > [...]
> > > +bool take_page_off_buddy(struct page *page)
> > > + {
> > > +	struct zone *zone = page_zone(page);
> > > +	unsigned long pfn = page_to_pfn(page);
> > > +	unsigned long flags;
> > > +	unsigned int order;
> > > +	bool ret = false;
> > > +
> > > +	spin_lock_irqsave(&zone->lock, flags);
> > 
> > What prevents the page to be allocated in the meantime? Also what about
> > free pages on the pcp lists? Also the page could be gone by the time you
> > have reached here.
> 
> Nothing prevents the page to be allocated in the meantime.
> We would just bail out and return -EBUSY to userspace.
> Since we do not do __anything__ to the page until we are sure we took it off,
> and it is completely isolated from the memory, there is no danger.

Wouldn't it be better to simply check the PageBuddy state after the lock
has been taken?

> Since soft-offline is kinda "best effort" mode, it is something like:
> "Sorry, could not poison the page, try again".

Well, I would disagree here. While madvise is indeed a best effort
operation please keep in mind that the sole purpose of this interface is
to allow real MCE behavior. And that operation should better try
_really_ hard to make sure we try to recover as gracefully as possible.

> Now, thinking about this a bit more, I guess we could be more clever here
> and call the routine that handles in-use pages if we see that the page
> was allocated by the time we reach take_page_off_buddy.
> 
> About pcp pages, you are right.
> I thought that we were already handling that case, and we do, but looking closer the
> call to shake_page() (that among other things spills pcppages into buddy)
> is performed at a later stage.
> I think we need to adjust __get_any_page to recognize pcp pages as well.

Yeah, pcp pages are PITA. We cannot really recognize them now. Dropping
all pcp pages is certainly a way to go but we need to mark the page
before that happens.
-- 
Michal Hocko
SUSE Labs
