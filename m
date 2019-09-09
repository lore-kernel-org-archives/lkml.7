Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F3C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B29D21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pg0BqddT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfIIQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:54:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45225 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfIIQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:54:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so9387319oti.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31kxGZUlgh39qJethx0hRa+2PyryHdT/Kifm1vwiYDs=;
        b=pg0BqddTOhx6M/Lw9KYbXBx53VB0/+25bq5PSVGS50kKhJAnUXeSYvtCFIgIlUO7I4
         Sg1kq0KCyg8dXxJGHKD/MqCwcoPyMDnS6oFukKEhKHQoDCoLoj8esh2gRMKFIcUMl5La
         2FHcOz3V5odVTWnN7UmsDFgD91cDoA9lm/fqufSc+5Jfe1CCXs3dxqddQtSFZUYmc+Mh
         Q7v6HcK87vArL8+rNjdx+vspc3BNqWnc12MCGysMYEtg0aFAUl7cnDYzfUvg0oLEO0o+
         k8ZvmZolsz5u43ZSfVkBrweedczj7i6/QGcV4lflm9XvPAaqCL9km3p4IpM1HxWR9qoP
         hgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31kxGZUlgh39qJethx0hRa+2PyryHdT/Kifm1vwiYDs=;
        b=t6tieiMkxgUO/5QA06Fzh9lg13t0H+jPoea975iX1RcBWVEWCbgSwtkfKZfM97JPLu
         IXLQ91NNEpqGi5T/ZdvLCT/kBP0gWILEL6/QL6B+boqkFcd1mUHjPQA+wovDg2znniFh
         gSuK5gbeALcQJaeiEMfrupAYPjLmAfF3ngCvDkwbzCejrOyDJ4ycWLgBeMH0a/zXWcWe
         FR64drYa2izA2gyMjB1Q/HxC1aQ4WLlYlTyO0KatTL8YCrawE/WCRTmEKMjqQJv6Gd2A
         MFjYF7acW0HNU2KYJ5fvtAIxaMQhbtiDf+khtDmNrXzI/rUe8/AY98ympWsg76sGfNrP
         S5hQ==
X-Gm-Message-State: APjAAAUZolGHY8vvfLEGx3YV/Yh+gsUoCPypUl1vQsC699cBlh4p+cFi
        GwxdM6XsE7ZQe3wSL/NxIP2rpFVIXVGUnBQdJfrmtIMYn9I=
X-Google-Smtp-Source: APXvYqxnlaS57V4kAtXP0r+RRN9r75uKF5+ohgYNaIFFekZNrp9ytwRto6OPiRHTdghftBB5ZTPY16S+Jyw0XDyq2s0=
X-Received: by 2002:a9d:12e4:: with SMTP id g91mr19182974otg.368.1568048065736;
 Mon, 09 Sep 2019 09:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160430.1368-1-lpf.vector@gmail.com> <20190903160430.1368-3-lpf.vector@gmail.com>
 <80fe024b-006e-b38e-1548-70441d917b41@suse.cz>
In-Reply-To: <80fe024b-006e-b38e-1548-70441d917b41@suse.cz>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 10 Sep 2019 00:54:14 +0800
Message-ID: <CAD7_sbFf429WxnqcROGgpsYvK4q1maF2uP9nZjqs60195aC95g@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, slab_common: Remove unused kmalloc_cache_name()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 10:59 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/3/19 6:04 PM, Pengfei Li wrote:
> > Since the name of kmalloc can be obtained from kmalloc_info[],
> > remove the kmalloc_cache_name() that is no longer used.
>
> That could simply be part of patch 1/5 really.
>

Ok, thanks.

> > Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
>
> Ack
>
> > ---
> >   mm/slab_common.c | 15 ---------------
> >   1 file changed, 15 deletions(-)
