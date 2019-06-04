Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B2C46460
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130B20848
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="som4VuEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFDVmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:42:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44964 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:42:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id e189so10018871oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmbOSyUJaWKC7E6mkMCzZ130rukGjBMZ7YsMSlPmAOc=;
        b=som4VuEnLAm6NcFA4G/8bUu59DJs6RQOXDu6uZ1dl355pmtObd2mRXHG+QnM2NILle
         6DTXAQBmdRMaZD/x8iF9Y+ryzMErSw+5JBQo8Ro6J+sgLvZco1iE/lfnV+f4LAl3DAHn
         BAy+HURpJHjZM6ifsf+NaHt6OzO9VRQgq9Rko4eWC5NCxUiL5IegRMqCGfwNenMs3zrq
         yAHjmwOlHQrfADQgDM4ZbZgN/gs2XWJsOhdjaDVoJadZeL6PHpmdxdY1+b8bHDr2gD1D
         TjQRJZ66edOjw2MfQXWpKr98kqESN59Fy+Gb7g6GhFh4MYAVLfUPkUh5tK+kWuRZ8sbq
         Tu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmbOSyUJaWKC7E6mkMCzZ130rukGjBMZ7YsMSlPmAOc=;
        b=WVl9tlC5uvIphtbipOaEePNn2y1GpPMJ5rBVoLtZ1GNQbYgxOSYrNPPQ9vnjpgLnXu
         iXKYaoQambzKnURTUD3nTecp/QJhT34hxkzWIj07dftCplc5ITRRzZltzKQNEWxKewGj
         ig9+hn8BJpzboYNygU6zVTVunAAWmzR4F1oJDmos99Cm2Hhx7i10HsgQ0lx+pEhvnirD
         Rd+BqGUkI/fxG2Pp78tVsxXTdCYmMQZRSYDubyhVGubeOJQsO70j6JV8C2EGAGo6QvJU
         wDcgFCiNejECZhSxAhpBvoVCZyLNpjUMpPP0mv7Q2eLH4fHu1idssO3QhMJO2q1jR23w
         rBHA==
X-Gm-Message-State: APjAAAVD4UatiHLs63nsjWq4y1apXr3xd4b+A2mfGQTCO0QiavxROi75
        bdPSb6tcsjpNu6iRK/gNvd3VbGr1vYNwy4QvmWB1YQ==
X-Google-Smtp-Source: APXvYqwy/zP1uRQYn1PObI3YjbeOg8OAYcgtGZPJVk80vheA3mZKMw14QcF60p+PtjD68c6OpiKRTCMpu+IhxFZif08=
X-Received: by 2002:aca:6087:: with SMTP id u129mr5555815oib.70.1559684562041;
 Tue, 04 Jun 2019 14:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190604164813.31514-1-ira.weiny@intel.com> <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
 <CAPcyv4hmN7M3Y1HzVGSi9JuYKUUmvBRgxmkdYdi_6+H+eZAyHA@mail.gmail.com> <4d97645c-0e55-37c0-1a16-8649706b9e78@nvidia.com>
In-Reply-To: <4d97645c-0e55-37c0-1a16-8649706b9e78@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jun 2019 14:42:30 -0700
Message-ID: <CAPcyv4h8fgkaP_zVT0bBwnstkO+=V8RRH5z4a=EemQLFamXB1Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 1:17 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
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

Ok.  Ideally there wouldn't be any commentary needed at the call site
and the put_page() could be handled internal to
put_devmap_managed_page(), but I did not see a way to do that without
breaking the compile out / static branch optimization when there are
no active ZONE_DEVICE users.
