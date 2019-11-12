Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A38C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oX0opbp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKLTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:13:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfKLTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:13:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so19771680wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtM0xm6pvdP2cIipj503CLA+c94Cc19gSxiP/7lkCo0=;
        b=oX0opbp+DaCHjx5NPFMutLUzOXNzS9qzrTQmMpDfKyHpUE5q/PBcpbwYBiWRikr0T+
         ID/+T5BH/Fixjg/Un5sKJ2fqggO2bDcV/7OnEGuNU0SpT04cpVg5galbiZtTukCxNJYS
         ezBGYSpp20/SEYfh3UyfDeDfIEkrIYBCcXW+aZleBlQRN5OyfkqbdqDFnsp5UtYSR9mf
         MSbaVZpN3HHZAQ7cWAIzDpJh0W73RsMgFsDs7RfoYIRtLAR2dETepgjpOtotx15onznZ
         92EEUVSNj0Cyic50ZTBFs243Xq2zt6jKDWsj2fFkzzD7kdi4QsUYfwQ9+hWVTT4odJd5
         dnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtM0xm6pvdP2cIipj503CLA+c94Cc19gSxiP/7lkCo0=;
        b=TlyTaFEgeKLXuNIjCIFGzkBRJyYJx6zg4y7mKZST3V55swmghSoXhwafBf1MKy3Ost
         ioVNwDePh2cd7gVdoNotrDhgC7ST/vsvoRHsUyKJ+9ueUwEwY0djDwYj/v27eiW1PQYX
         NacgFLi1AHD/iNbeF5swhAtNg1m+ItCOl0nnyaB3Fz138m7A9Pi8t521DbVyF9FPDDCm
         FZWq8SwvauN48txm7zhb3o3OKRRitZd32F1m1X1dqf09wY5KNt2TOxoA34/r0jtlrEbS
         ZwDAy7AQXsvRKKJNDAI7iy3OMcUc9qTbomeZW+wTcOWrBwKhJMOotIRiesV14t5Zu7wv
         JgdA==
X-Gm-Message-State: APjAAAWRDKnVI1VXCjs04TWoph54nABfLt9cY4rrEfTSQ/hLhgPHcFoT
        tVQ2nTBkzDSGLWt2Sf5xl12wVG/G/VhvUxbLUn0sSw==
X-Google-Smtp-Source: APXvYqzMdkx5IZeFl9kZ1JAz2Fz3PH7Ac1ewNQNH9EP7dZAMdZyI4Vlcv9hr2OgkmnZtO+bPOV89e1xK6L7Mpft+sdo=
X-Received: by 2002:adf:d18b:: with SMTP id v11mr28764776wrc.308.1573586000825;
 Tue, 12 Nov 2019 11:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-4-hannes@cmpxchg.org>
 <CAJuCfpHSTr8Vt+Tj-Hj4OBYHq1ucw7_B1VoVWKEHQVPHaMhUdA@mail.gmail.com> <20191112180019.GB178331@cmpxchg.org>
In-Reply-To: <20191112180019.GB178331@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Nov 2019 11:13:09 -0800
Message-ID: <CAJuCfpFJ-tzqc6Ng-6ntQn46iatgOdLF5PY6WAcOHVvGSQGwMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: vmscan: enforce inactive:active ratio at the
 reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Nov 10, 2019 at 06:15:50PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > @@ -2758,7 +2775,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >                         total_high_wmark += high_wmark_pages(zone);
> > >                 }
> > >
> > > -               sc->file_is_tiny = file + free <= total_high_wmark;
> > > +               /*
> > > +                * Consider anon: if that's low too, this isn't a
> > > +                * runaway file reclaim problem, but rather just
> > > +                * extreme pressure. Reclaim as per usual then.
> > > +                */
> > > +               anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> > > +
> > > +               sc->file_is_tiny =
> > > +                       file + free <= total_high_wmark &&
> > > +                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> > > +                       anon >> sc->priority;
> >
> > The name of file_is_tiny flag seems to not correspond with its actual
> > semantics anymore. Maybe rename it into "skip_file"?
>
> I'm not a fan of file_is_tiny, but I also don't like skip_file. IMO
> it's better to have it describe a situation instead of an action, in
> case we later want to take additional action for that situation.
>
> Any other ideas? ;)

All other ideas still yield verbs (like sc->prefer_anon). Maybe then
add some comment at the file_is_tiny declaration that it represents
not only the fact that the file LRU is too small to reclaim but also
that there are easily reclaimable anon pages?

>
> > I'm confused about why !(sc->may_deactivate & DEACTIVATE_ANON) should
> > be a prerequisite for skipping file LRU reclaim. IIUC this means we
> > will skip reclaiming from file LRU only when anonymous page
> > deactivation is not allowed. Could you please add a comment explaining
> > this?
>
> The comment above this check tries to explain it: the definition of
> file being "tiny" is dependent on the availability of anon. It's a
> relative comparison.
>
> If file only has a few pages, and anon is easily reclaimable (does not
> require deactivation to reclaim pages), then file is "tiny" and we
> should go after the more plentiful anon pages.

Your above explanation is much clearer to me than the one in the comment :)

>
> If anon is under duress, too, this preference doesn't make sense and
> we should just reclaim both lists equally, as per usual.
>
> Note that I'm not introducing this constraint, I'm just changing how
> it's implemented. From the patch:
>
> > >         /*
> > >          * If the system is almost out of file pages, force-scan anon.
> > > -        * But only if there are enough inactive anonymous pages on
> > > -        * the LRU. Otherwise, the small LRU gets thrashed.
> > >          */
> > > -       if (sc->file_is_tiny &&
> > > -           !inactive_list_is_low(lruvec, false, sc, false) &&
> > > -           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
> > > -                           sc->reclaim_idx) >> sc->priority) {
> > > +       if (sc->file_is_tiny) {
> > >                 scan_balance = SCAN_ANON;
> > >                 goto out;
> > >         }
>
> So it's always been checking whether reclaim would deactivate anon,
> and whether inactive_anon has sufficient pages for this priority.

I didn't realize !inactive_list_is_low(lruvec, false, sc, false) is
effectively the same as !(sc->may_deactivate & DEACTIVATE_ANON) but
after re-reading the patch that makes sense... Except when
force_deactivate==true, in which case shouldn't you consider
NR_ACTIVE_ANON as easily reclaimable too? IOW should it be smth like
this:

anon = node_page_state(pgdat, NR_INACTIVE_ANON) +
(sc->force_deactivate ? node_page_state(pgdat, NR_ACTIVE_ANON) : 0);

?
