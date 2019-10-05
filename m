Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B0C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FA720867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkYm1YbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfJEUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 16:04:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38817 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJEUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:04:04 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so20703176iom.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRHgwxZdGw0blwU74PDIectE4sOFeAoxwqMR6ZTtSjU=;
        b=HkYm1YbP6dhP5HDrvhFJiVGj0WMBirms1vp0+/Dp4li8Rvy0DQ9X4+delTdtfmi3Py
         fySH0qUwpqO0SpoBuhDqygMEfYV8TKIybhe5uVnusupZQvLT+2HrATBMXO+3Hgi4tb0n
         WJIUcc3n1Gbqv9oIFBnSWHh98uADLYgPPxmv3SMKEM8S7VsTwwANAq1F0aHecJcYmGJE
         wC5pK6o77+Ls5d0gdraEJsF7mMdFV9EYaVtVukrwL3fQzLAaPwDPL8tt6bckpw1JJkh8
         MPWS+sqOm06P+IjTjvlrANW12l1OQFIVbhe6l+Ub1nhei9TdlEOYl7ZOMLB73rjhnNuo
         fDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRHgwxZdGw0blwU74PDIectE4sOFeAoxwqMR6ZTtSjU=;
        b=QzT6zW+q054pujdtLerR2fYocFKRtDTqcAakCSnCrsTIfFOAUhldCYUQqj0ZRlKGUi
         i+EwJCT+/OXwa8NCIlD7qryWxZMYEeGwaOHkky2AHiTZpeQsHWH4pTRGUIR/sHSizdTU
         3y1y/qOKMlzR00WCdY9ZbqvS49jAOI+kRj1PXRsno/nIzf2qo3pz4Ivv9BAy649nhYmh
         Zfw2Cas7BiE5wkQiDsIOTbZk8GPqRqjgmKRslV9Id6VpgfeIjTE2SMMaHyN337L1GMKo
         piz4ZQ6AfzH+ixCcalNBWSWGww1BJNFh5xJrcR1OFG1TwmLxtLC4Dv8MqRXXmq0BBj9w
         /GOA==
X-Gm-Message-State: APjAAAUVmf25wiq0qoeGJfSI8Gluy0Q2QnAhYRP41/EJU9T1NevuWZuq
        8hTdryGsX2/Y+UiaUvBzvxNHIMvKKON17kSkKKk0K85j
X-Google-Smtp-Source: APXvYqwOrc0R/c3VOz/QM5b3vD7qEJVUgTKPFzQytiP7GeQI2Rf77AeDFQs4Rii1UaUX2u4CEmwV/h5mSqlM6ZRWB34=
X-Received: by 2002:a02:4487:: with SMTP id o129mr21197311jaa.136.1570305843122;
 Sat, 05 Oct 2019 13:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <157019456205.3142.3369423180908482020.stgit@buzz> <20191005123523.0db4ad1b9f268c419f8a59eb@linux-foundation.org>
In-Reply-To: <20191005123523.0db4ad1b9f268c419f8a59eb@linux-foundation.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 5 Oct 2019 23:03:50 +0300
Message-ID: <CALYGNiPSr-cxV9MX9czaVh6Wz_gzSv3H_8KPvgjBTGbJywUJpA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 10:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 04 Oct 2019 16:09:22 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>
> > This is very slow operation. There is no reason to do it again if somebody
> > else already drained all per-cpu vectors while we waited for lock.
> >
> > Piggyback on drain started and finished while we waited for lock:
> > all pages pended at the time of our enter were drained from vectors.
> >
> > Callers like POSIX_FADV_DONTNEED retry their operations once after
> > draining per-cpu vectors when pages have unexpected references.
> >
> > ...
> >
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -708,9 +708,10 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
> >   */
> >  void lru_add_drain_all(void)
> >  {
> > +     static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
> >       static DEFINE_MUTEX(lock);
> >       static struct cpumask has_work;
> > -     int cpu;
> > +     int cpu, seq;
> >
> >       /*
> >        * Make sure nobody triggers this path before mm_percpu_wq is fully
> > @@ -719,7 +720,19 @@ void lru_add_drain_all(void)
> >       if (WARN_ON(!mm_percpu_wq))
> >               return;
> >
> > +     seq = raw_read_seqcount_latch(&seqcount);
> > +
> >       mutex_lock(&lock);
> > +
> > +     /*
> > +      * Piggyback on drain started and finished while we waited for lock:
> > +      * all pages pended at the time of our enter were drained from vectors.
> > +      */
> > +     if (__read_seqcount_retry(&seqcount, seq))
> > +             goto done;
> > +
> > +     raw_write_seqcount_latch(&seqcount);
> > +
> >       cpumask_clear(&has_work);
> >
> >       for_each_online_cpu(cpu) {
> > @@ -740,6 +753,7 @@ void lru_add_drain_all(void)
> >       for_each_cpu(cpu, &has_work)
> >               flush_work(&per_cpu(lru_add_drain_work, cpu));
> >
> > +done:
> >       mutex_unlock(&lock);
> >  }
>
> I'm not sure this works as intended.
>
> Suppose CPU #30 is presently executing the for_each_online_cpu() loop
> and has reached CPU #15's per-cpu data.
>
> Now CPU #2 comes along, adds some pages to its per-cpu vectors then
> calls lru_add_drain_all().  AFAICT the code will assume that CPU #30
> has flushed out all of the pages which CPU #2 just added, but that
> isn't the case.
>
> Moving the raw_write_seqcount_latch() to the point where all processing
> has completed might fix?
>
>

No, raw_write_seqcount_latch() should be exactly before draining.

Here seqcount works as generation of pages that could be in vectors.
And all steps are serialized by mutex: only after taking lock we could be
sure that all previous generations are gone.

Here CPU #2 will see same generation at entry and after taking lock.
So it will drain own pages.
