Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F2C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC523208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt7AoMwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfF1T10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:27:26 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36155 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1T1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:27:25 -0400
Received: by mail-yw1-f65.google.com with SMTP id t126so4562075ywf.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvUXywiG0f7bCL3wZmKqPPbl6x6Ilq7Dj7JuFch+QdI=;
        b=vt7AoMwrNcWqMkfexaU6xlBIiiJMEym5gtlszE1wfAtxsaHc1nUkstrKx+VfeTOdW4
         jQapxfMfdVK3Kha0PgKtzyz67iZqe3RpRtmY8sqR0qFSYnjgzcmPDH0oBxumTHL7rpPw
         nYmM/KbsDPwQWESafxthWv+EoEX8OBpvv+0JkYtwBtgXKpikXgGKVH8FznIk7SA7Qijn
         OH47owMfMltuYy1/N6QD/WhAOZGseF75WthtolK2ck54xcf0GFpr4l1YJiVcBYg29F13
         8MZF9RT5I9torHdvXAJeC8N9iKGeudMzvl8gW8wkxVdskrvnbXbAqjxQfWdKBQ0SzIm+
         27KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvUXywiG0f7bCL3wZmKqPPbl6x6Ilq7Dj7JuFch+QdI=;
        b=jh58fhG3lXAipFPyQgTcJCTRP1+swDbxcd6LPHyfmbr+NmfuOXe6qon9Npx30NM4Hw
         AUrezJ3j/fbwVs5nOCkh3h/KtCcwgAh4aKmL2haVbAUGdzUzmF7B4zMEmILo4UtTyfBX
         CNpZc/kbEFL2Qwy+A9S57G35tVjyP8uyS9HmDgT9zSYkcv499YililPsHOZ/2iIgaSey
         8a3cneI0AfBrFI2t0CnrRK74FJ20kFieTUmz9YXoEYSiEumn/VobEOrMmi5kYrtYUo9e
         Q4NhoxMrBXmbbrUHDab8E8xzXFNUuMABVILWmG0EFE7CPjU3qIC4UiAeRzMLJdd5qTBA
         nkyQ==
X-Gm-Message-State: APjAAAXTFDOLOSUzfWlIf2xVxuKoDKNaAkNUIIrZbaHyhlAwBkOdOazl
        +WhoRA+p8IqY++cpqCmvTrqdoFz6eDBQnA4SlyaVLw==
X-Google-Smtp-Source: APXvYqyeNqvAsUAnD2/zSmW+uHs3PMxd0RthI9aXZomvVE0l90UkfP/cn8j691rqydeWakodWOrph9gJGKwfB7MrDG0=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr7609987ywh.308.1561750044891;
 Fri, 28 Jun 2019 12:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190628015520.13357-1-shakeelb@google.com> <6e28c8ce-96e1-5a1e-bd06-d1df5856094e@linux.alibaba.com>
In-Reply-To: <6e28c8ce-96e1-5a1e-bd06-d1df5856094e@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 28 Jun 2019 12:27:13 -0700
Message-ID: <CALvZod6sDHNwTbUPSnBdj4bEG1gT1BDgwD=f=MrDOAx4yVuRiQ@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent useless kswapd loops
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:53 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 6/27/19 6:55 PM, Shakeel Butt wrote:
> > On production we have noticed hard lockups on large machines running
> > large jobs due to kswaps hoarding lru lock within isolate_lru_pages when
> > sc->reclaim_idx is 0 which is a small zone. The lru was couple hundred
> > GiBs and the condition (page_zonenum(page) > sc->reclaim_idx) in
> > isolate_lru_pages was basically skipping GiBs of pages while holding the
> > LRU spinlock with interrupt disabled.
> >
> > On further inspection, it seems like there are two issues:
> >
> > 1) If the kswapd on the return from balance_pgdat() could not sleep
> > (maybe all zones are still unbalanced), the classzone_idx is set to 0,
> > unintentionally, and the whole reclaim cycle of kswapd will try to reclaim
> > only the lowest and smallest zone while traversing the whole memory.
> >
> > 2) Fundamentally isolate_lru_pages() is really bad when the allocation
> > has woken kswapd for a smaller zone on a very large machine running very
> > large jobs. It can hoard the LRU spinlock while skipping over 100s of
> > GiBs of pages.
> >
> > This patch only fixes the (1). The (2) needs a more fundamental solution.
> >
> > Fixes: e716f2eb24de ("mm, vmscan: prevent kswapd sleeping prematurely
> > due to mismatched classzone_idx")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >   mm/vmscan.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9e3292ee5c7c..786dacfdfe29 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3908,7 +3908,7 @@ static int kswapd(void *p)
> >
> >               /* Read the new order and classzone_idx */
> >               alloc_order = reclaim_order = pgdat->kswapd_order;
> > -             classzone_idx = kswapd_classzone_idx(pgdat, 0);
> > +             classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
>
> I'm a little bit confused by the fix. What happen if kswapd is waken for
> a lower zone? It looks kswapd may just reclaim the higher zone instead
> of the lower zone?
>
> For example, after bootup, classzone_idx should be (MAX_NR_ZONES - 1),
> if GFP_DMA is used for allocation and kswapd is waken up for ZONE_DMA,
> kswapd_classzone_idx would still return (MAX_NR_ZONES - 1) since
> kswapd_classzone_idx(pgdat, classzone_idx) returns the max classzone_idx.
>

Indeed you are right. I think kswapd_classzone_idx() is too much
convoluted. It has different semantics when called from the wakers
than when called from kswapd(). Let me see if we can decouple the
logic in this function based on the context (or have two separate
functions for both contexts).

thanks,
Shakeel
