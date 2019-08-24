Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEAA22CEC
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK+VZ1iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHXDlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:41:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34325 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfHXDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:41:46 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so24802662ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4JfOThgU1rKXkGTSmWuM/49rJOouhdAv0PQSZEcT8E=;
        b=XK+VZ1iVfxgnbKguT+7cU89msBjcvPUQ3ycYVzyoHOjcWABcHh8bY1onqf4xYWwx0r
         6zFiSXdqLXPrtwGw+qyxd7/HVupwGaZ3QCNqlrLdHFobNC1oSjNct0Vq0YQ2FuwfwkTA
         OaARrvajKojascXHNlOxZdSNs1FQXn33nqLl3B8f6l3P7r7ELaUHqOHaTsAKGMqNObeP
         tUMZy7BxTzau8ZMwO3u/Uncbg0GB+NUfaA6rzquorHGKAeIQQKH7zlnGgZ62EuukCXpY
         gKFGlTGUcWsb/Ej/QBGQo7ShqalwblzlRVouLU/DYxBrAfnG5cHFOwHVGhMvWlieWRIi
         AOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4JfOThgU1rKXkGTSmWuM/49rJOouhdAv0PQSZEcT8E=;
        b=dv3DjFAVMd1Vk1FSEUzlG4bfFhFdLqaUYO/qFSKboxht8teUYG9/swQz28m01P/UjV
         7/0r1JCK4ot0czaab/lo00bnQ4mnE+kz3W9ZU/l7oZNtJf3St3kCXadOkzPrfbJT5+gW
         QtZC7qXnHbfaTnC2awyIfWTVa6N7E+xLWtcUpyRaLNjp6edpu56uYCPllW+yOkc///wx
         gPmTVaoKjar6AgB9/o6TnWhSerUTa04OIYJVW97MyLprONEeS27QBkZ5G61pF9x3LGBd
         WSjiOKw/Zwq858a6ZJovwjI9hx8v2dbE+tZIZxePvzV9vZO1krcEQ3yqXZ0OEjnJT6o7
         jrww==
X-Gm-Message-State: APjAAAUnBD1O6sel4S7CkMiS54Y70Azg+XsLlCUCDpnWMMh0lvTwCZsN
        ym+tr9O+6uQZTC/QcXx1Bm0c5Zh0HmJ8wceyKw8=
X-Google-Smtp-Source: APXvYqxj6hFHjPvE181WudeKU0q0Rg+0ht6n+KXE3Jr/bTBy/3xnAwRNTMAvQVi+f3UaypI8xYFlRrN9Z+gK1b3xvkU=
X-Received: by 2002:a5d:934c:: with SMTP id i12mr4089843ioo.203.1566618105736;
 Fri, 23 Aug 2019 20:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190817004726.2530670-1-guro@fb.com> <20190823223257.GA22200@tower.DHCP.thefacebook.com>
In-Reply-To: <20190823223257.GA22200@tower.DHCP.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 24 Aug 2019 11:41:09 +0800
Message-ID: <CALOAHbAXzqGksOOCOfB8ykrMQQjo7g_h7hUexr2WdAQkh3N7zg@mail.gmail.com>
Subject: Re: [PATCH] Partially revert "mm/memcontrol.c: keep local VM counters
 in sync with the hierarchical ones"
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 6:33 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Aug 16, 2019 at 05:47:26PM -0700, Roman Gushchin wrote:
> > Commit 766a4c19d880 ("mm/memcontrol.c: keep local VM counters in sync
> > with the hierarchical ones") effectively decreased the precision of
> > per-memcg vmstats_local and per-memcg-per-node lruvec percpu counters.
> >
> > That's good for displaying in memory.stat, but brings a serious regression
> > into the reclaim process.
> >
> > One issue I've discovered and debugged is the following:
> > lruvec_lru_size() can return 0 instead of the actual number of pages
> > in the lru list, preventing the kernel to reclaim last remaining
> > pages. Result is yet another dying memory cgroups flooding.
> > The opposite is also happening: scanning an empty lru list
> > is the waste of cpu time.
> >
> > Also, inactive_list_is_low() can return incorrect values, preventing
> > the active lru from being scanned and freed. It can fail both because
> > the size of active and inactive lists are inaccurate, and because
> > the number of workingset refaults isn't precise. In other words,
> > the result is pretty random.
> >
> > I'm not sure, if using the approximate number of slab pages in
> > count_shadow_number() is acceptable, but issues described above
> > are enough to partially revert the patch.
> >
> > Let's keep per-memcg vmstat_local batched (they are only used for
> > displaying stats to the userspace), but keep lruvec stats precise.
> > This change fixes the dead memcg flooding on my setup.
> >
> > Fixes: 766a4c19d880 ("mm/memcontrol.c: keep local VM counters in sync with the hierarchical ones")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
>
> Any other concerns/comments here?
>
> I'd prefer to fix the regression: we're likely leaking several pages
> of memory for each created and destroyed memory cgroup. Plus
> all internal structures, which are measured in hundreds of kb.
>

Hi Roman,

As it really introduces issues, I agree with you that we should fix it first.

So for your fix,
Acked-by: Yafang Shao <laoar.shao@gmail.com>

Thanks
Yafang
