Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AFBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568633852;
	bh=FpxvfCJty4Chs8ux7uZhIRX9jfW+FpOVLEkLx7GYtBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5gIw61008TiaEXULzGv8l5k+kd6GmbCAffLESDI7gTxuTgBhhJg5Vk0QDXeU6GCO
	 oo4ZyQQu/QDoDk2aAKKq4SSpWls6Lsc6sbumar2XMAYkx7vV0ghVj3pMq1qQfx6iA0
	 yUsOGG3tSHT4n1gnf17tiknxlYJsXXpAVTyKRxs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfIPLhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbfIPLhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF7ACAF7C;
        Mon, 16 Sep 2019 11:37:29 +0000 (UTC)
Date:   Mon, 16 Sep 2019 13:37:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm, thp: Do not queue fully unmapped pages for deferred
 split
Message-ID: <20190916113729.GF10231@dhcp22.suse.cz>
References: <20190913091849.11151-1-kirill.shutemov@linux.intel.com>
 <20190916103602.GD10231@dhcp22.suse.cz>
 <5c946cd9-e17b-b184-37b7-250c6dfb977c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c946cd9-e17b-b184-37b7-250c6dfb977c@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-09-19 13:11:37, Vlastimil Babka wrote:
> On 9/16/19 12:36 PM, Michal Hocko wrote:
> > On Fri 13-09-19 12:18:49, Kirill A. Shutemov wrote:
> >> Adding fully unmapped pages into deferred split queue is not productive:
> >> these pages are about to be freed or they are pinned and cannot be split
> >> anyway.
> >> 
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> ---
> >>  mm/rmap.c | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 003377e24232..45388f1bf317 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1271,12 +1271,20 @@ static void page_remove_anon_compound_rmap(struct page *page)
> >>  	if (TestClearPageDoubleMap(page)) {
> >>  		/*
> >>  		 * Subpages can be mapped with PTEs too. Check how many of
> >> -		 * themi are still mapped.
> >> +		 * them are still mapped.
> >>  		 */
> >>  		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
> >>  			if (atomic_add_negative(-1, &page[i]._mapcount))
> >>  				nr++;
> >>  		}
> >> +
> >> +		/*
> >> +		 * Queue the page for deferred split if at least one small
> >> +		 * page of the compound page is unmapped, but at least one
> >> +		 * small page is still mapped.
> >> +		 */
> >> +		if (nr && nr < HPAGE_PMD_NR)
> >> +			deferred_split_huge_page(page);
> > 
> > You've set nr to zero in the for loop so this cannot work AFAICS.
> 
> The for loop then does nr++ for each subpage that's still mapped?

I am blind obviously. Sorry about the noise. Then the patch looks
correct.
-- 
Michal Hocko
SUSE Labs
