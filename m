Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C174AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93621721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567168619;
	bh=+EMUZjiejiGSd7O/x3S67andmzwFAbmvFbgL5IRzahI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e1b/KDWffnSkLKOaDfSDPvJFwxHTYB26LghKxca7GjBQZejxGncKS5iPhJFPH3W7r
	 oVHVVNe4s+t2oKVtO4G8ABTjhk+cy5nz1xdZ6qUJVHVqO/QtB8vZ259oiTd2g5/FS1
	 yKPA5cOx9C1S31jDXPcrIVRBR54TFmVMWFYnqYl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfH3Mg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:36:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbfH3Mg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6918BAB9D;
        Fri, 30 Aug 2019 12:36:57 +0000 (UTC)
Date:   Fri, 30 Aug 2019 14:36:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: poisoned pages do not play well in the buddy allocator
Message-ID: <20190830123656.GG28313@dhcp22.suse.cz>
References: <20190826104144.GA7849@linux>
 <20190827013429.GA5125@hori.linux.bs1.fc.nec.co.jp>
 <20190827072808.GA17746@linux>
 <20190830104530.GA29647@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830104530.GA29647@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 12:45:35, Oscar Salvador wrote:
> On Tue, Aug 27, 2019 at 09:28:13AM +0200, Oscar Salvador wrote:
> > On Tue, Aug 27, 2019 at 01:34:29AM +0000, Naoya Horiguchi wrote:
> > > > @Naoya: I could give it a try if you are busy.
> > > 
> > > Thanks for raising hand. That's really wonderful. I think that the series [1] is not
> > > merge yet but not rejected yet, so feel free to reuse/update/revamp it.
> > 
> > I will continue pursuing this then :-).
> 
> I have started implementing a fix for this.
> Right now I only performed tests on normal pages (non-hugetlb).
> 
> I took the approach of:
> 
> - Free page: remove it from the buddy allocator and set it as PageReserved|PageHWPoison.
> - Used page: migrate it and do not release it (skip put_page in unmap_and_move for MR_MEMORY_FAILURE
> 	     reason). Set it as PageReserved|PageHWPoison.

But this will only cover mapped pages. What about page cache in general?
Any reason why this cannot be handled in __free_one_page and simply skip
the whole freeing of the HWPoisoned parts of the freed page (in case of
higher order).

> The routine that handles this also sets the refcount of these pages to 1, so the unpoison
> machinery will only have to check for PageHWPoison and to a put_page() to send
> the page to the buddy allocator.
> 
> The Reserved bit is used because these pages will now __only__ be accessible through
> pfn walkers, and pfn walkers should respect Reserved pages.
> The PageHWPoison bit is used to remember that this page is poisoned, so the unpoison
> machinery knows that it is valid to unpoison it.

Do we really need both bits? pfn walkers in general shouldn't handle
pages they do not know about.

> It should also let us get rid of some if not all of the PageHWPoison() checks.

Although this sounds really appealing. The kernel code appart from the
hwpoison subsystem shouldn't really care about hwpoison status. With
some few isolated exceptions of course.
 
> Overall, it seems to work as I no longer see the issue our customer and I faced.

\o/

> My goal is to go further and publish that fix along with several
> cleanups/refactors for the soft-offline machinery (hard-poison will come later),
> as I strongly think we do really need to re-work that a bit, to make it more simple.
> 
> Since it will take a bit to have everything ready, I just wanted to
> let you know.

Thanks for the heads up and the work! The plan sounds great to me.
-- 
Michal Hocko
SUSE Labs
