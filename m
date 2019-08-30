Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38CFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3421897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfH3Kpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:45:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727751AbfH3Kpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:45:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CCF3B00E;
        Fri, 30 Aug 2019 10:45:39 +0000 (UTC)
Date:   Fri, 30 Aug 2019 12:45:35 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: poisoned pages do not play well in the buddy allocator
Message-ID: <20190830104530.GA29647@linux>
References: <20190826104144.GA7849@linux>
 <20190827013429.GA5125@hori.linux.bs1.fc.nec.co.jp>
 <20190827072808.GA17746@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827072808.GA17746@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:28:13AM +0200, Oscar Salvador wrote:
> On Tue, Aug 27, 2019 at 01:34:29AM +0000, Naoya Horiguchi wrote:
> > > @Naoya: I could give it a try if you are busy.
> > 
> > Thanks for raising hand. That's really wonderful. I think that the series [1] is not
> > merge yet but not rejected yet, so feel free to reuse/update/revamp it.
> 
> I will continue pursuing this then :-).

I have started implementing a fix for this.
Right now I only performed tests on normal pages (non-hugetlb).

I took the approach of:

- Free page: remove it from the buddy allocator and set it as PageReserved|PageHWPoison.
- Used page: migrate it and do not release it (skip put_page in unmap_and_move for MR_MEMORY_FAILURE
	     reason). Set it as PageReserved|PageHWPoison.

The routine that handles this also sets the refcount of these pages to 1, so the unpoison
machinery will only have to check for PageHWPoison and to a put_page() to send
the page to the buddy allocator.

The Reserved bit is used because these pages will now __only__ be accessible through
pfn walkers, and pfn walkers should respect Reserved pages.
The PageHWPoison bit is used to remember that this page is poisoned, so the unpoison
machinery knows that it is valid to unpoison it.

It should also let us get rid of some if not all of the PageHWPoison() checks.

Overall, it seems to work as I no longer see the issue our customer and I faced.

My goal is to go further and publish that fix along with several
cleanups/refactors for the soft-offline machinery (hard-poison will come later),
as I strongly think we do really need to re-work that a bit, to make it more simple.

Since it will take a bit to have everything ready, I just wanted to
let you know.

-- 
Oscar Salvador
SUSE L3
