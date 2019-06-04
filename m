Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61548C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD9208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFDUbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:31:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:3131 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFDUbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:31:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 13:31:38 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 13:31:37 -0700
Date:   Tue, 4 Jun 2019 13:32:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190604203247.GB3980@iweiny-DESK2.sc.intel.com>
References: <20190604164813.31514-1-ira.weiny@intel.com>
 <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
 <CAPcyv4hmN7M3Y1HzVGSi9JuYKUUmvBRgxmkdYdi_6+H+eZAyHA@mail.gmail.com>
 <4d97645c-0e55-37c0-1a16-8649706b9e78@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d97645c-0e55-37c0-1a16-8649706b9e78@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:17:42PM -0700, John Hubbard wrote:
> On 6/4/19 1:11 PM, Dan Williams wrote:
> > On Tue, Jun 4, 2019 at 12:48 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>
> >> On 6/4/19 9:48 AM, ira.weiny@intel.com wrote:
> >>> From: Ira Weiny <ira.weiny@intel.com>
> >>>
> ...
> >>> diff --git a/mm/swap.c b/mm/swap.c
> >>> index 7ede3eddc12a..6d153ce4cb8c 100644
> >>> --- a/mm/swap.c
> >>> +++ b/mm/swap.c
> >>> @@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
> >>>               if (is_huge_zero_page(page))
> >>>                       continue;
> >>>
> >>> -             /* Device public page can not be huge page */
> >>> -             if (is_device_public_page(page)) {
> >>> +             if (is_zone_device_page(page)) {
> >>>                       if (locked_pgdat) {
> >>>                               spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> >>>                                                      flags);
> >>>                               locked_pgdat = NULL;
> >>>                       }
> >>> -                     put_devmap_managed_page(page);
> >>> -                     continue;
> >>> +                     /*
> >>> +                      * Not all zone-device-pages require special
> >>> +                      * processing.  Those pages return 'false' from
> >>> +                      * put_devmap_managed_page() expecting a call to
> >>> +                      * put_page_testzero()
> >>> +                      */
> >>
> >> Just a documentation tweak: how about:
> >>
> >>                         /*
> >>                          * ZONE_DEVICE pages that return 'false' from
> >>                          * put_devmap_managed_page() do not require special
> >>                          * processing, and instead, expect a call to
> >>                          * put_page_testzero().
> >>                          */
> > 
> > Looks better to me, but maybe just go ahead and list those
> > expectations explicitly. Something like:
> > 
> >                         /*
> >                          * put_devmap_managed_page() only handles
> >                          * ZONE_DEVICE (struct dev_pagemap managed)
> >                          * pages when the hosting dev_pagemap has the
> >                          * ->free() or ->fault() callback handlers
> >                          *  implemented as indicated by
> >                          *  dev_pagemap.type. Otherwise the expectation
> >                          *  is to fall back to a plain decrement /
> >                          *  put_page_testzero().
> >                          */
> 
> I like it--but not here, because it's too much internal detail in a
> call site that doesn't use that level of detail. The call site looks
> at the return value, only.
> 
> Let's instead put that blurb above (or in) the put_devmap_managed_page() 
> routine itself. And leave the blurb that I wrote where it is. And then I
> think everything will have an appropriate level of detail in the right places.

I agree.  This leaves it open that this handles any special processing which is
required.

FWIW the same call is made in put_page() and has no comment so perhaps we are
getting wrapped around the axle for no reason?

Frankly I questioned myself when I mentioned put_page_testzero() as well.  But
I'm ok with Johns suggestion.  My wording was a bit "rushed".  Sorry about
that.  I wanted to remove the word 'fail' from the comment because I think it
is what caught Michal's eye.

Ira

> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
