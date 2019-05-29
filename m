Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B2C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0F321019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE2DzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:55:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:44796 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfE2DzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:55:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 20:55:18 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2019 20:55:18 -0700
Date:   Tue, 28 May 2019 20:56:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190529035618.GA21745@iweiny-DESK2.sc.intel.com>
References: <20190524173656.8339-1-ira.weiny@intel.com>
 <20190527150107.GG1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527150107.GG1658@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:01:07PM +0200, Michal Hocko wrote:
> On Fri 24-05-19 10:36:56, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Device pages can be more than type MEMORY_DEVICE_PUBLIC.
> > 
> > Handle all device pages within release_pages()
> > 
> > This was found via code inspection while determining if release_pages()
> > and the new put_user_pages() could be interchangeable.
> 
> Please expand more about who is such a user and why does it use
> release_pages rather than put_*page API.

Sorry for not being more clear.   The error was discovered while discussing a
proposal to change a use of release_pages() to put_user_pages()[1]

[1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc.intel.com/

In that thread John was saying that release_pages() was functionally equivalent
to a loop around put_page().  He also suggested implementing put_user_pages()
by using release_pages().  On the surface they did not seem the same to me so I
did a deep dive to make sure they were and found this error.

>
> The above changelog doesn't
> really help understanding what is the actual problem. I also do not
> understand the fix and a failure mode from release_pages is just scary.

This is not failing release_pages().  The fix is that not all devmap pages are
"public" type.  So previous to this change devmap pages of other types would
not correctly be accounted for.

The discussion about put_devmap_managed_page() "failing" is not about it
failing directly but rather in how these pages should be accounted for.  Only
devmap pages which require pagemap ops (specifically page_free()) require
put_devmap_managed_page() processing.   Because of the optimized locking in
release_pages() the zone device check is required to release the lock even if
put_devmap_managed_page() does not handle the put.

> It is basically impossible to handle the error case. So what is going on
> here?

I think what has happened is the code in release_pages() and put_page()
diverged at some point.  I think it is worth a clean up in this area but I
don't see way to do it at the moment which would be any cleaner than what is
there.  So I've refrained from doing so.

Does this help?  Would you like to roll a V3 with some of this in the commit
message?

Ira

>
>
>
> 
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V1:
> > 	Add comment clarifying that put_devmap_managed_page() can still
> > 	fail.
> > 	Add Reviewed-by tags.
> > 
> >  mm/swap.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 9d0432baddb0..f03b7b4bfb4f 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -740,15 +740,18 @@ void release_pages(struct page **pages, int nr)
> >  		if (is_huge_zero_page(page))
> >  			continue;
> >  
> > -		/* Device public page can not be huge page */
> > -		if (is_device_public_page(page)) {
> > +		if (is_zone_device_page(page)) {
> >  			if (locked_pgdat) {
> >  				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> >  						       flags);
> >  				locked_pgdat = NULL;
> >  			}
> > -			put_devmap_managed_page(page);
> > -			continue;
> > +			/*
> > +			 * zone-device-pages can still fail here and will
> > +			 * therefore need put_page_testzero()
> > +			 */
> > +			if (put_devmap_managed_page(page))
> > +				continue;
> >  		}
> >  
> >  		page = compound_head(page);
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
