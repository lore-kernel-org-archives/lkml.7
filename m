Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442ADC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154762086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBg4mAX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfENEhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:37:17 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:44735 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENEhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:37:16 -0400
Received: by mail-qt1-f177.google.com with SMTP id f24so13078687qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tf3korJmRLD8o2Lf06LrqOczw1F6ZM2FyAdskXAP/yk=;
        b=lBg4mAX3TS8PJBOsb+445RvCKsl4l9r5dT0BTkb/FL86zuZPgzqK0IYwRDoq8DS/wW
         bkN3AEQUlfMHlZU+0IVgdRfgFaOm6ajkuDV2FOR1rhtOAcMcbR1RfK+japxmOfw3PGr1
         1KkIg29RCtaWyEWi81wAsuTrGj7UFXSekgkO7QlV3qE02GyWhbmyKqhRfqgs+DR/k+CO
         xdanmaGLWE6F7ApSxivM8U+T/V/mz9LNfgVXI9ujMA77bvmfSG2ZBWbf2GcKqwClQ0Rj
         UHVn5SVbESeu1MTDsvNW1+ztooPYlK9Aop1IqrJ7HASDwOGZcC5O3Ly+tDFg9XW9YDEa
         2uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tf3korJmRLD8o2Lf06LrqOczw1F6ZM2FyAdskXAP/yk=;
        b=JKE4Qa42nsqN5YC8BLuPkfwCbSA8IyGMjOXWsqMboyD7AsSr9wabxTwZRa3wuBDgVM
         7phrSVr3Yq/42KDcSVVlpiGBUSugLtmGymvh0wcSkwAhIFHMNEm2qQhJcWRGyil9beoH
         x36AUtuiOFyVans7GWeQaHAl7+B8o2yI5Tg7oTly6eexkQ0Hg0l7ozfx0rhHKe2L8OYC
         eRYgllrBKTR9s6bhCQJ0iIIieW2zzeyXpBeMdVKP7j1DlWXQQZSN6EllUXk2CwJkymyb
         mUtv4IExXbBXIv1wdMvhklb+flm4J3uIDa+TGCvR2wzF3FS4wGDGU25Nq4HF7LS5+8gc
         t8Ng==
X-Gm-Message-State: APjAAAWWSKXDqz//m1kIgSlHru9Hwllf4oYS3Gb89I3FpOOnhF3U0rGb
        rApF3N7C5wJaPStSyakOTwpK+8e2ys1ChutASGM=
X-Google-Smtp-Source: APXvYqwh4a0o8vAEeDVZY6kolyij7RZoaYa1MYOibq43kvFPp4BJjJKs9M6IS2Pmf3oMCR3z5OP/uvmiygdphi38f9o=
X-Received: by 2002:ac8:5409:: with SMTP id b9mr27316238qtq.326.1557808635902;
 Mon, 13 May 2019 21:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz> <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
 <20190513214503.GB25356@dhcp22.suse.cz>
In-Reply-To: <20190513214503.GB25356@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 13 May 2019 21:36:59 -0700
Message-ID: <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:45 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 13-05-19 14:09:59, Yang Shi wrote:
> [...]
> > I think we can just account 512 base pages for nr_scanned for
> > isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT
> > just use it.
> >
> > And, sc->nr_scanned should be accounted as 512 base pages too otherwise we
> > may have nr_scanned < nr_to_reclaim all the time to result in false-negative
> > for priority raise and something else wrong (e.g. wrong vmpressure).
>
> Be careful. nr_scanned is used as a pressure indicator to slab shrinking
> AFAIR. Maybe this is ok but it really begs for much more explaining

I don't know why my company mailbox didn't receive this email, so I
replied with my personal email.

It is not used to double slab pressure any more since commit
9092c71bb724 ("mm: use sc->priority for slab shrink targets"). It uses
sc->priority to determine the pressure for slab shrinking now.

So, I think we can just remove that "double slab pressure" code. It is
not used actually and looks confusing now. Actually, the "double slab
pressure" does something opposite. The extra inc to sc->nr_scanned
just prevents from raising sc->priority.

> than "it should be fine". This should have happened when THP swap out
> was implemented...
>
> --
> Michal Hocko
> SUSE Labs
>
