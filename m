Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38997C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F342070D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ksnPKDAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFDULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:11:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43697 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:11:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so20765636oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F10q0KVTHECot/kJH3bpXBBhMISLUSKtyxb6F/sOWco=;
        b=ksnPKDAH2vpajVlt3FdQ1o79daRSPs4sDyRSGkAnPXDC4guUemOThTNV7g2HkHBxbD
         KXNuYnnQJVPBBlgZeN1qsUEcxDgjW2ufLJB5ApQuUqmY9t5pyOduHXi0i+fyeBUthTPn
         ZHv7ab9rPNIR8AjTnkjHC8Gn4cIxKM8v9syi3dzP+3dc4idH/Xf2WS7hxQ3ULABRAbk8
         p38g/F1LB2o75+qTMh1KrUZSdiZmOydTYQK7Raku7yVUkx6zhYiCplV+oX4oTz5NbSjp
         icXuRtOvbP+XqkZOAYVXIwWyk4CyASDUFH+oB5inG7C5S+4ESpn43x/vw/XWSgOgg7Eh
         uLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F10q0KVTHECot/kJH3bpXBBhMISLUSKtyxb6F/sOWco=;
        b=BDT+k4PmGBdtyeHADdQhV9Qfho7JHXQ+w1oWRE42vlA0+0zySvPONpvkU0jWkvFqLG
         pTC7X4xnIMg/2t0qmENidkEpSio00noBttN3wlW+1UcK3KnTeROIhAPdaaq/7CTAhDWM
         CnCyQPydGQxNqL7H804e4rf1eFe74vEGmRCnA+KBtsxECdxijXIX/ibgomryUQ8+y3Bj
         k3yJjDW5hcmVUueqRjEW+V5b0aqdzFZMQgVfNeeKUvLYLw/V3FFZsdBA2/Poh0r5NWpD
         fz1ZAsCyFgGztfGzIuFmluiPAks1sr5/wqXRQ5/WracFA9DHiGqgW9Muup6Vm8W9T7md
         dYig==
X-Gm-Message-State: APjAAAXQ7kT81niX1dMkxtvbJV4BFteHu9HgftncqkajGtBrsf2RKUGx
        VUf+iXyhFoaNgbLEqQ5lsHHOs3I4StoFogo8jTvH5Q==
X-Google-Smtp-Source: APXvYqyTa8Gbb8IOD8Dh6HgENFAnEfuHPskg2EEGvtw42nEap43nVkmpzXcyUap1w5NLnmmqleclS53nXaf3ZvnOp0U=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr6416236otr.207.1559679110583;
 Tue, 04 Jun 2019 13:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190604164813.31514-1-ira.weiny@intel.com> <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
In-Reply-To: <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jun 2019 13:11:38 -0700
Message-ID: <CAPcyv4hmN7M3Y1HzVGSi9JuYKUUmvBRgxmkdYdi_6+H+eZAyHA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 12:48 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 6/4/19 9:48 AM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > release_pages() is an optimized version of a loop around put_page().
> > Unfortunately for devmap pages the logic is not entirely correct in
> > release_pages().  This is because device pages can be more than type
> > MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS
> > DAX, and PCI P2PDMA.  Some of these have specific needs to "put" the
> > page while others do not.
> >
> > This logic to handle any special needs is contained in
> > put_devmap_managed_page().  Therefore all devmap pages should be
> > processed by this function where we can contain the correct logic for a
> > page put.
> >
> > Handle all device type pages within release_pages() by calling
> > put_devmap_managed_page() on all devmap pages.  If
> > put_devmap_managed_page() returns true the page has been put and we
> > continue with the next page.  A false return of
> > put_devmap_managed_page() means the page did not require special
> > processing and should fall to "normal" processing.
> >
> > This was found via code inspection while determining if release_pages()
> > and the new put_user_pages() could be interchangeable.[1]
> >
> > [1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc=
.intel.com/
> >
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes from V2:
> >       Update changelog for more clarity as requested by Michal
> >       Update comment WRT "failing" of put_devmap_managed_page()
> >
> > Changes from V1:
> >       Add comment clarifying that put_devmap_managed_page() can still
> >       fail.
> >       Add Reviewed-by tags.
> >
> >  mm/swap.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 7ede3eddc12a..6d153ce4cb8c 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
> >               if (is_huge_zero_page(page))
> >                       continue;
> >
> > -             /* Device public page can not be huge page */
> > -             if (is_device_public_page(page)) {
> > +             if (is_zone_device_page(page)) {
> >                       if (locked_pgdat) {
> >                               spin_unlock_irqrestore(&locked_pgdat->lru=
_lock,
> >                                                      flags);
> >                               locked_pgdat =3D NULL;
> >                       }
> > -                     put_devmap_managed_page(page);
> > -                     continue;
> > +                     /*
> > +                      * Not all zone-device-pages require special
> > +                      * processing.  Those pages return 'false' from
> > +                      * put_devmap_managed_page() expecting a call to
> > +                      * put_page_testzero()
> > +                      */
>
> Just a documentation tweak: how about:
>
>                         /*
>                          * ZONE_DEVICE pages that return 'false' from
>                          * put_devmap_managed_page() do not require speci=
al
>                          * processing, and instead, expect a call to
>                          * put_page_testzero().
>                          */

Looks better to me, but maybe just go ahead and list those
expectations explicitly. Something like:

                        /*
                         * put_devmap_managed_page() only handles
                         * ZONE_DEVICE (struct dev_pagemap managed)
                         * pages when the hosting dev_pagemap has the
                         * ->free() or ->fault() callback handlers
                         *  implemented as indicated by
                         *  dev_pagemap.type. Otherwise the expectation
                         *  is to fall back to a plain decrement /
                         *  put_page_testzero().
                         */
