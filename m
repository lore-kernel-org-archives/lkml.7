Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C452082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbCC/THX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfHSPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:30:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32805 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHSPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:30:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id q10so1611277oij.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8ka/lSpx7x87DLc83+R4USIti/BoN9Ffmdc3jaOX2Q=;
        b=YbCC/THXJ+jW3CX9FXHClKXeCtKiLUPIuAcslTQaG+QSmimIH99mMK/nFW7Ftl9eQF
         eDMyAMXlqQzz2qS3NvwOgii1mrdv2rMg1HXXyOTcx1usHidRZyFkmVtsY2ySgpvSqJoa
         KWUXVre94APcbRzJkR+LWl13Ufg4AltWnGGhsH7wnaPpjq1C2F2QPm8prfNSK9zaCb19
         WQjUQ5Sioh4i9AkdytmGK5ClbiZRAvEnmdnvGxIQibMG6B0E+VuBhLlTbsyHUEBvy5rp
         37Gx4fOMHkBIAF9u1Oo5vGmA54Ue429pgpP7/99V+YFAu2vyPhif9dvma00qVEFSWmPz
         R6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8ka/lSpx7x87DLc83+R4USIti/BoN9Ffmdc3jaOX2Q=;
        b=OmewtUSVJV6R0t3jPfBTUn2UsMBoD7y7wL0j95RwZMpznjmIUKuGSqXWx6TP+QRjhy
         THn0d/7CWRk47+rumWwWFDKOPQQX6Q4Sx67fsnHWJuRK3w7apfruPqg0n/sCNWDjayAl
         kggKVX3yZ4tBqcBT6EGTLWdU+FENc6TqLC9Y1T/K5ERX8BQylgE/orUGgLD3ibjCFXrD
         lumV8g4x+IuF+IaJ/FUxcbPKX6XR5no05yHKxMY9kmGuqMhknzBLDLn+PQTgbTAP31si
         EX1BZhJ2btjP5DElTpI34icj+myHi96DvAnHFT0KFw/tmI/iixOIih69ubUNrg4jxd6r
         6DxA==
X-Gm-Message-State: APjAAAWmGAornS0cEERhfgkKda9wK4wfeR3BK27L4OXpbSl8w/dWLWzT
        M4Hl7o+F6+KX+h7ICUMVQHPjbW520Hg4PZKGJJbAHYL9
X-Google-Smtp-Source: APXvYqydVhuF3ntnoIzw4WdaFZsGX6v0yJ381g5t+kAPdv9EwyYq9UGMZNp6eBqM0v83H75PPht5fdfswl306n8hArw=
X-Received: by 2002:aca:d60b:: with SMTP id n11mr13195651oig.22.1566228603622;
 Mon, 19 Aug 2019 08:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190817105102.11732-1-lpf.vector@gmail.com> <d0549e44-a885-2178-3f98-596eff765b3d@suse.cz>
In-Reply-To: <d0549e44-a885-2178-3f98-596eff765b3d@suse.cz>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Mon, 19 Aug 2019 23:29:51 +0800
Message-ID: <CAD7_sbGYGhCTt_rfL8wX-FrXMFpSD_v7zPz9ic1Li6Jurc1ajQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: cleanup __alloc_pages_direct_compact()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        osalvador@suse.de, pavel.tatashin@microsoft.com,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 9:50 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 8/17/19 12:51 PM, Pengfei Li wrote:
> > This patch cleans up the if(page).
> >
> > No functional change.
> >
> > Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
>
> I don't see much benefit here. The indentation wasn't that bad that it
> had to be reduced using goto. But the patch is not incorrect so I'm not
> NACKing.
>

Thanks for your review and comments.

This patch reduces the number of times the if(page)
(as the compiler does), and the downside is that there is a goto.

If this improves readability, accept it. Otherwise, leave it as it is.

Thanks again.

---
Pengfei


> > ---
> >  mm/page_alloc.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 272c6de1bf4e..51f056ac09f5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3890,6 +3890,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> >               enum compact_priority prio, enum compact_result *compact_result)
> >  {
> >       struct page *page = NULL;
> > +     struct zone *zone;
> >       unsigned long pflags;
> >       unsigned int noreclaim_flag;
> >
> > @@ -3911,23 +3912,26 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> >        */
> >       count_vm_event(COMPACTSTALL);
> >
> > -     /* Prep a captured page if available */
> > -     if (page)
> > +     if (page) {
> > +             /* Prep a captured page if available */
> >               prep_new_page(page, order, gfp_mask, alloc_flags);
> > -
> > -     /* Try get a page from the freelist if available */
> > -     if (!page)
> > +     } else {
> > +             /* Try get a page from the freelist if available */
> >               page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> >
> > -     if (page) {
> > -             struct zone *zone = page_zone(page);
> > -
> > -             zone->compact_blockskip_flush = false;
> > -             compaction_defer_reset(zone, order, true);
> > -             count_vm_event(COMPACTSUCCESS);
> > -             return page;
> > +             if (!page)
> > +                     goto failed;
> >       }
> >
> > +     zone = page_zone(page);
> > +     zone->compact_blockskip_flush = false;
> > +     compaction_defer_reset(zone, order, true);
> > +
> > +     count_vm_event(COMPACTSUCCESS);
> > +
> > +     return page;
> > +
> > +failed:
> >       /*
> >        * It's bad if compaction run occurs and fails. The most likely reason
> >        * is that pages exist, but not enough to satisfy watermarks.
> >
>
