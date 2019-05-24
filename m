Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9ECC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E31C217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbfEXPgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:36:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:31359 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389927AbfEXPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:35:31 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2019 08:35:30 -0700
Date:   Fri, 24 May 2019 08:36:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
Message-ID: <20190524153625.GA23100@iweiny-DESK2.sc.intel.com>
References: <20190523223746.4982-1-ira.weiny@intel.com>
 <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:58:12PM -0700, Dan Williams wrote:
> On Thu, May 23, 2019 at 3:37 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Device pages can be more than type MEMORY_DEVICE_PUBLIC.
> >
> > Handle all device pages within release_pages()
> >
> > This was found via code inspection while determining if release_pages()
> > and the new put_user_pages() could be interchangeable.
> >
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  mm/swap.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 3a75722e68a9..d1e8122568d0 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
> >                 if (is_huge_zero_page(page))
> >                         continue;
> >
> > -               /* Device public page can not be huge page */
> > -               if (is_device_public_page(page)) {
> > +               if (is_zone_device_page(page)) {
> >                         if (locked_pgdat) {
> >                                 spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> >                                                        flags);
> >                                 locked_pgdat = NULL;
> >                         }
> > -                       put_devmap_managed_page(page);
> > -                       continue;
> > +                       if (put_devmap_managed_page(page))
> 
> This "shouldn't" fail, and if it does the code that follows might get

I agree it shouldn't based on the check.  However...

> confused by a ZONE_DEVICE page. If anything I would make this a
> WARN_ON_ONCE(!put_devmap_managed_page(page)), but always continue
> unconditionally.

I was trying to follow the pattern from put_page()  Where if fails it indicated
it was not a devmap page and so "regular" processing should continue.

Since I'm unsure I'll just ask what does this check do?

        if (!static_branch_unlikely(&devmap_managed_key))
                return false;

... In put_devmap_managed_page()?

> 
> Other than that you can add:
> 
>     Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks v2 to follow.

Ira

