Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FEB21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYq4HNUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLQAIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:08:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41195 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLQAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:08:44 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so9037362ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwZ3AcnTBQ28nJN51stCAhZ95AFZOrQo6pEdFmYHvWk=;
        b=oYq4HNUKFOf9/7j0uKcIs7SryzuQ8y4simLaoxDczAwBenaH6YErxmMyLAq0bK3XCD
         PMW9ODSGe9K7iaJ8ie+n4HMBwyhn+FyaA6OzLVUNmAmvRTdg++fa8VrMy5VZXzMuP8jR
         Zdauzy0aLchy5kDrwsTWI7/ZflWrfFYv323zILAke+/u4ocJY1L+uIgkNDkTNKXgN6zI
         qGzPZFyA32JpQ9Uij+ACa31wph2uNKhrjvaTstG8TrBfELFXv2fxOGLiMyHAFSYmo61n
         5zZ0IZqBXOqavvC1WWUoZYA3Isn7ydoQ8Q4+Yov/YzG/xWtJRL7WJUC60wQh0/WJ9402
         X7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwZ3AcnTBQ28nJN51stCAhZ95AFZOrQo6pEdFmYHvWk=;
        b=PenDxqU+twJR74HacGQeFmUMSVVnw+rJdcHSKL4dxM8X3sBHjgop+K6uwyPtzLJrBx
         unlVDJCAfhYEiFZ9RnzcJQAlamomQqvDUdUFA3SQ9gb30SZFjQLsLfx2jCLHT+kVKgnN
         KvThKINcIoyFf/nJwAX9w5WV+Gt+lfGXvWSpq0IClo26uORWY8EKjLFJS+0E78y0Ax9O
         tC75taA+24r+UqksXglFyEfJzzbu3Lx9Wg8K62eWvJMDAraqX/Kab7iY5iou78meSHmh
         56g/1tXrB02gdjKb3FVrMSYvGxzDysS/HoQj8ANM3syxjPH/4febjWlS4+8pJdMxrQwW
         pHUg==
X-Gm-Message-State: APjAAAVURVLNG8I7ccOh+oiRJcVcy9thyixHeOd6H/Np2nQVau7xj5oQ
        gUinjCafBlcOIXxzLEUKMYPi8YmpgTWeS1sNcJtBGaQD
X-Google-Smtp-Source: APXvYqz/NhneasvOmRKmNOgigyn1brjYBnpS85lUIlHqZWs1givSMqQNUWoo0IUhJYhpTbnvXrnLkRhVW0BLQ2Uxsyw=
X-Received: by 2002:a02:3089:: with SMTP id q131mr7916853jaq.30.1576541323436;
 Mon, 16 Dec 2019 16:08:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575932654.git.robin.murphy@arm.com> <20191216111219.GB2369@dell>
 <3c78d334-9110-e88c-84d0-2f41c28a6317@web.de>
In-Reply-To: <3c78d334-9110-e88c-84d0-2f41c28a6317@web.de>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 17 Dec 2019 05:38:31 +0530
Message-ID: <CANAwSgSfA9pMQxmvkAfDfH_wsBovc9hCivoo_YU1+ZMOD0OuYg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mfd: RK8xx tidyup
To:     Soeren Moch <smoch@web.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Daniel Schultz <d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Tue, 17 Dec 2019 at 05:00, Soeren Moch <smoch@web.de> wrote:
>
> On 16.12.19 12:12, Lee Jones wrote:
> > On Tue, 10 Dec 2019, Robin Murphy wrote:
> >
> >> Hi all,
> >>
> >> In trying to debug suspend issues on my RK3328 box, I was looking at
> >> how the RK8xx driver handles the RK805 sleep pin, and frankly the whole
> >> driver seemed untidy enough to warrant some cleanup and minor fixes
> >> before going any further. I've based the series on top of Soeren's
> >> "mfd: rk808: Always use poweroff when requested" patch[1].
> >>
> >> Note that I've only had time to build-test these patches so far, but I
> >> wanted to share them early for the sake of discussion in response to
> >> the other thread[2].
> >>
> >> Robin.
> >>
> >> [1] https://patchwork.kernel.org/patch/11279249/
> >> [2] https://patchwork.kernel.org/cover/11276945/
> >>
> >> Robin Murphy (4):
> >>   mfd: rk808: Set global instance unconditionally
> >>   mfd: rk808: Always register syscore ops
> >>   mfd: rk808: Reduce shutdown duplication
> >>   mfd: rk808: Convert RK805 to syscore/PM ops
> >>
> >>  drivers/mfd/rk808.c       | 122 ++++++++++++++++----------------------
> >>  include/linux/mfd/rk808.h |   2 -
> >>  2 files changed, 50 insertions(+), 74 deletions(-)
> > Not sure what's happening with these (competing?) patch-sets.  I'm not
> > planning on getting involved until you guys have arrived at and agreed
> > upon a single solution.
> >
> My understanding is like this:
>
> The patch [1] fixes power-off to use the method requested in the
> devicetree. This patch series on top of that cleans up the rk808
> power-off code, which perfectly makes sense for me. I think these 2
> patch series are not controversial as such.
>
> And then we have the series [2], which is a mix of
> - some clean-up
> - converting the existing code to use syscon_shutdown for actual power-off
>
> Robin, Heiko, and myself agree that the shutdown method introduced in
> [2] is fundamentally wrong. All syscon_shutdown methods of all
> registered syscons have to run before the actual shutdown, what is
> triggered in pm_power_off. This is how it works now, and what is the
> right way to do it. Patch series [2] breaks this promise since it does
> the actual shutdown in the middle of the chain of syscon_shutdown handlers.
>
> In the discussion about series [2] Anand repeatedly talks about restart
> problems. But this rk808 mfd driver is not involved in restart, also
> patch series [2]
> does not change that. So I cannot see what should be the point here.
>
Sorry I dont have any expert knowledge on this, so continue on best approach..

> There was an earlier attempt [3] to enhance this rk808 mfd driver for
> restart. I'm not sure, however, what happened to this. For me it could
> make sense to reimplement such restart functionality on top of this
> "mfd: RK8xx tidyup" series.
>
> Regards,
> Soeren
>
> [3] https://lore.kernel.org/patchwork/patch/934323/
>
>

-Anand
