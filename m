Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AADC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BCB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfFXH24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfFXH2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56D955AFF8;
        Mon, 24 Jun 2019 07:28:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC51B5C1B5;
        Mon, 24 Jun 2019 07:28:36 +0000 (UTC)
Date:   Mon, 24 Jun 2019 15:28:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm] mm, swap: Fix THP swap out
Message-ID: <20190624072830.GA10539@ming.t460p>
References: <20190624022336.12465-1-ying.huang@intel.com>
 <20190624033438.GB6563@ming.t460p>
 <87imsvbnie.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imsvbnie.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 07:28:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:44:41PM +0800, Huang, Ying wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > Hi Huang Ying,
> >
> > On Mon, Jun 24, 2019 at 10:23:36AM +0800, Huang, Ying wrote:
> >> From: Huang Ying <ying.huang@intel.com>
> >> 
> >> 0-Day test system reported some OOM regressions for several
> >> THP (Transparent Huge Page) swap test cases.  These regressions are
> >> bisected to 6861428921b5 ("block: always define BIO_MAX_PAGES as
> >> 256").  In the commit, BIO_MAX_PAGES is set to 256 even when THP swap
> >> is enabled.  So the bio_alloc(gfp_flags, 512) in get_swap_bio() may
> >> fail when swapping out THP.  That causes the OOM.
> >> 
> >> As in the patch description of 6861428921b5 ("block: always define
> >> BIO_MAX_PAGES as 256"), THP swap should use multi-page bvec to write
> >> THP to swap space.  So the issue is fixed via doing that in
> >> get_swap_bio().
> >> 
> >> BTW: I remember I have checked the THP swap code when
> >> 6861428921b5 ("block: always define BIO_MAX_PAGES as 256") was merged,
> >> and thought the THP swap code needn't to be changed.  But apparently,
> >> I was wrong.  I should have done this at that time.
> >> 
> >> Fixes: 6861428921b5 ("block: always define BIO_MAX_PAGES as 256")
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Cc: Ming Lei <ming.lei@redhat.com>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Rik van Riel <riel@redhat.com>
> >> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> >> ---
> >>  mm/page_io.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/mm/page_io.c b/mm/page_io.c
> >> index 2e8019d0e048..4ab997f84061 100644
> >> --- a/mm/page_io.c
> >> +++ b/mm/page_io.c
> >> @@ -29,10 +29,9 @@
> >>  static struct bio *get_swap_bio(gfp_t gfp_flags,
> >>  				struct page *page, bio_end_io_t end_io)
> >>  {
> >> -	int i, nr = hpage_nr_pages(page);
> >>  	struct bio *bio;
> >>  
> >> -	bio = bio_alloc(gfp_flags, nr);
> >> +	bio = bio_alloc(gfp_flags, 1);
> >>  	if (bio) {
> >>  		struct block_device *bdev;
> >>  
> >> @@ -41,9 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
> >>  		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
> >>  		bio->bi_end_io = end_io;
> >>  
> >> -		for (i = 0; i < nr; i++)
> >> -			bio_add_page(bio, page + i, PAGE_SIZE, 0);
> >
> > bio_add_page() supposes to work, just wondering why it doesn't recently.
> 
> Yes.  Just checked and bio_add_page() works too.  I should have used
> that.  The problem isn't bio_add_page(), but bio_alloc(), because nr ==
> 512 > 256, mempool cannot be used during swapout, so swapout will fail.

Then we can pass 1 to bio_alloc(), together with single bio_add_page()
for making the code more readable.


thanks,
Ming
