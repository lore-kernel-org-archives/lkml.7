Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8343C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A478B20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTctEi3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfEVEYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:24:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44109 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:24:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so1656195edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NQu0NI8ncRqI8fsVQtJ0PPb5XIcqSyNmrQ1DHUlIgA=;
        b=cTctEi3aTljPqIa9jevUUtkhUYP6k7DFrA/xHnftumm9ApHTJKy3N++7Ueoj0t2YuR
         GqtafLyvkH2P4JExAvskMZj3A+phaDWwFHrdXLM5Q9UZw4i4ZPRvt4R4WScaJZ0QxMvh
         rsoFhFnx/DRaxyTPlryjIEHTPtMsJi8CGRuw9mz8pc53fXK5Y5dHApQF2uGnifIy/9aA
         KDgZVDf2tH57ieUxk0C9OSNHKLsLTL6tAD+m436cT3jECDzLtJfQnw69G5l+euN9240+
         5vYHG/3HNGySzVeHP4I7Bw7WhrwBfcwQIX7ZmqYPgwOsow8gxFB1vjkoBZHwClOkmyoW
         2aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NQu0NI8ncRqI8fsVQtJ0PPb5XIcqSyNmrQ1DHUlIgA=;
        b=F51IH/m6IQyX70OQFYVTV/s/NFJGufFplo0XG9aU/ii6gKvrbW/qJhuD2a30iKiEVt
         x6JC3OteK4WMDQxjLMovGsBw9QmMBHXTHCK/IxVFahrbepc5AbBZ/48AMd90EktKUllV
         0IP9FmxpBe6X0v9KoOGC6+8HmS1siqgH1gFjqiCSNwC+gmir19KWn51nNpqD9oiC+Pe3
         ZqGN9Gmfi4FQXPvIdHmcKTxz1fULTmKoDE7ec6NEKGG/iW/5I4ocBoh2/37b3DxpaRQI
         CSDmgfkHFjd6jymfxx7TJ51Df+Zwlms/h9exdgm6jmpiUsHAed6TskkC+XGbi1RDNMwl
         393A==
X-Gm-Message-State: APjAAAW+OlKuh9nQRRIoXebpph2LqImSNUOUoXyDEjvMPiFaQv+PH5pw
        fJylORi5DgV8UDd0lbQVCvDV1w3Gj5/Dv0j6ls9Zme/2/pRMiicv
X-Google-Smtp-Source: APXvYqyRHcfinxI7Xw/i+5OLohhLHbRhnK8lQ37zl+2Edp8bEtKpoEyaN6XkTY8Aox/DgqYZ2vbzhn7fg2fKtixYDMo=
X-Received: by 2002:a50:9264:: with SMTP id j33mr85821109eda.125.1558499041640;
 Tue, 21 May 2019 21:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
 <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com> <CALvZod6ioRxSi7tHB-uSTxN1-hsxD+8O3mfFAjaqdsimjUVmcw@mail.gmail.com>
In-Reply-To: <CALvZod6ioRxSi7tHB-uSTxN1-hsxD+8O3mfFAjaqdsimjUVmcw@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 21 May 2019 21:23:35 -0700
Message-ID: <CADyq12xG5AO-bAniiMwrW+7W4jBdJVsacVC_gbOq_g4zQ=X12g@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sonny Rao <sonnyrao@google.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To expand on the ChromeOS use case we're in a very similar situation
to Android. For example, the Chrome browser uses a separate process
for each individual tab (with some exceptions) and over time many tabs
remain open in a back-grounded or idle state. Given that we have a lot
of information about the weight of a tab, when it was last active,
etc, we can benefit tremendously from per-process reclaim. We're
working on getting real world numbers but all of our initial testing
shows very promising results.


On Tue, May 21, 2019 at 5:57 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, May 20, 2019 at 7:55 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> >
> > On 05/20/2019 10:29 PM, Tim Murray wrote:
> > > On Sun, May 19, 2019 at 11:37 PM Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:
> > >>
> > >> Or Is the objective here is reduce the number of processes which get killed by
> > >> lmkd by triggering swapping for the unused memory (user hinted) sooner so that
> > >> they dont get picked by lmkd. Under utilization for zram hardware is a concern
> > >> here as well ?
> > >
> > > The objective is to avoid some instances of memory pressure by
> > > proactively swapping pages that userspace knows to be cold before
> > > those pages reach the end of the LRUs, which in turn can prevent some
> > > apps from being killed by lmk/lmkd. As soon as Android userspace knows
> > > that an application is not being used and is only resident to improve
> > > performance if the user returns to that app, we can kick off
> > > process_madvise on that process's pages (or some portion of those
> > > pages) in a power-efficient way to reduce memory pressure long before
> > > the system hits the free page watermark. This allows the system more
> > > time to put pages into zram versus waiting for the watermark to
> > > trigger kswapd, which decreases the likelihood that later memory
> > > allocations will cause enough pressure to trigger a kill of one of
> > > these apps.
> >
> > So this opens up bit of LRU management to user space hints. Also because the app
> > in itself wont know about the memory situation of the entire system, new system
> > call needs to be called from an external process.
> >
> > >
> > >> Swapping out memory into zram wont increase the latency for a hot start ? Or
> > >> is it because as it will prevent a fresh cold start which anyway will be slower
> > >> than a slow hot start. Just being curious.
> > >
> > > First, not all swapped pages will be reloaded immediately once an app
> > > is resumed. We've found that an app's working set post-process_madvise
> > > is significantly smaller than what an app allocates when it first
> > > launches (see the delta between pswpin and pswpout in Minchan's
> > > results). Presumably because of this, faulting to fetch from zram does
> >
> > pswpin      417613    1392647     975034     233.00
> > pswpout    1274224    2661731    1387507     108.00
> >
> > IIUC the swap-in ratio is way higher in comparison to that of swap out. Is that
> > always the case ? Or it tend to swap out from an active area of the working set
> > which faulted back again.
> >
> > > not seem to introduce a noticeable hot start penalty, not does it
> > > cause an increase in performance problems later in the app's
> > > lifecycle. I've measured with and without process_madvise, and the
> > > differences are within our noise bounds. Second, because we're not
> >
> > That is assuming that post process_madvise() working set for the application is
> > always smaller. There is another challenge. The external process should ideally
> > have the knowledge of active areas of the working set for an application in
> > question for it to invoke process_madvise() correctly to prevent such scenarios.
> >
> > > preemptively evicting file pages and only making them more likely to
> > > be evicted when there's already memory pressure, we avoid the case
> > > where we process_madvise an app then immediately return to the app and
> > > reload all file pages in the working set even though there was no
> > > intervening memory pressure. Our initial version of this work evicted
> >
> > That would be the worst case scenario which should be avoided. Memory pressure
> > must be a parameter before actually doing the swap out. But pages if know to be
> > inactive/cold can be marked high priority to be swapped out.
> >
> > > file pages preemptively and did cause a noticeable slowdown (~15%) for
> > > that case; this patch set avoids that slowdown. Finally, the benefit
> > > from avoiding cold starts is huge. The performance improvement from
> > > having a hot start instead of a cold start ranges from 3x for very
> > > small apps to 50x+ for larger apps like high-fidelity games.
> >
> > Is there any other real world scenario apart from this app based ecosystem where
> > user hinted LRU management might be helpful ? Just being curious. Thanks for the
> > detailed explanation. I will continue looking into this series.
>
> Chrome OS is another real world use-case for this user hinted LRU
> management approach by proactively reclaiming reclaim from tabs not
> accessed by the user for some time.
