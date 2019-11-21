Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FBAC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215CB20726
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHqYx5I4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKUOig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:38:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39823 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKUOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:38:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id o17so3218124qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uBnaV53sfik9uxAcuVDwoQxz4HOkeWfiqm0sSdBIt8=;
        b=qHqYx5I4KcHedAmjd1d5VA7Cra9+uql2Yg67DF2JfSdPqsJ9EBrZsdLeui/10SaKzH
         lrrFFHp0N+fIKs1O5Kq/ZoBYYg9bm60jFhTHSBSqZ/pz0a4O0hlJpEaSpXZT/a4rCBba
         r+b7qbul7RWhqR5/gvoKpK10Z9wOYvo2Znmq1eO73y/pTQ3Jw4cmkXMi7fwGTAqv0w+Q
         dwBt78bp5McJFh6GlndtSeqBFnLD4teFPcw8DJUGYUHzCbeVj4wq/9zaKDYbajO3NSKz
         G1rS+kNrXqfzQnLlMxpsau6iJW7BUFPZ2L4DWv80kqaGYmPNiPllMKTBqmyIrbNU0aHE
         WE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uBnaV53sfik9uxAcuVDwoQxz4HOkeWfiqm0sSdBIt8=;
        b=KeZuZYBclSJBwdxJIJfePVsvnLfGetBvTYHJCAs7nkvHUdCj2JysnxcKplx+xK71hv
         A0HglkhmuCslUifZt2dt7VBsqGFUtDBkn1PRDKzyNb7UqI9l+WIuze/FkNmXspMZE68y
         LfQl20wDy+wBD8ish3CdNuHAT0ypkYK6qXMrUwfFrBNVHXnM+N+zChQYqcxaaA7rEEE8
         JKWSP9cCNV93e5T+Lfu/leiUoGfXT/xeZ0XVhDpFdcKzoi9hCXFNm+M09BEXXQP4Dih1
         tMpGn3qo4pPuXUPaqvWK4yupvym/rrWh5INXmnEy8d9bBbtXPVbjtAfTes0p1GJFr2ao
         r1Yw==
X-Gm-Message-State: APjAAAWQ0iy2WlC584rw6dyQzDpaL6LznLXxCbJrehJIrS3H8bXxje2z
        hcuczo1fli0vD3+PacmNsbmriKZoNEPOCFimkaioSuxoReI=
X-Google-Smtp-Source: APXvYqxtKxAUh/ZMebivKk+zZk45NjEKinlCwFUHSVbBLFIM++OG8OJ5sUmC4KwJfvFX69uhnJx9VWkHLUjlF+d0+LQ=
X-Received: by 2002:a05:620a:12f3:: with SMTP id f19mr7967709qkl.106.1574347111146;
 Thu, 21 Nov 2019 06:38:31 -0800 (PST)
MIME-Version: 1.0
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
 <5DD69AB7.3060307@linaro.org>
In-Reply-To: <5DD69AB7.3060307@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 21 Nov 2019 20:08:20 +0530
Message-ID: <CAP245DVwEij-fs-LK=i3+Ps6BrsHt4DfxKG=C-tFM3CVKadtXA@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "J, KEERTHY" <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 7:40 PM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> On 11/21/2019 12:50 AM, Amit Kucheria wrote:
> > From: Ram Chandrasekar <rkumbako@codeaurora.org>
> >
> > Currently, step wise governor increases the mitigation when the
> > temperature goes above a threshold and decreases the mitigation when the
> > temperature goes below the threshold. If there is a case where the
> > temperature is wavering around the threshold, the mitigation will be
> > applied and removed every iteration, which is not very efficient.
> >
> > The use of hysteresis temperature could avoid this ping-pong of
> > mitigation by relaxing the mitigation to happen only when the
> > temperature goes below this lower hysteresis value.
> Hi Amit,
>
> Can this not lead to ping-pong around the hysteresis temperature?

That isn't how hysteresis is supposed to work if there is a sufficient
delta between your trip point and your hysteresis value.

e.g. if you have a trip at 80C and a hysteresis of 10C, it means that
you will start throttling at 80C, but you won't STOP throttling until
you cool down to 70C. At that point, you will wait again to get to 80C
before throttling again.
IOW, on the downward slope (80 -> 70) you still have throttling active
and on the upward slope (70 -> 80), you have no[1] throttling, so
different behaviour is the same temperature range depending on
direction.

If your hysteresis value was very low .e.g. 1C, it would certainly be useless.

> If the idea is to minimize ping-pong isn't average a better method?

We shouldn't ping-pong with the asymmetric behaviour described above.

Regards,
Amit
[1] This is a simple example with a single trip point.
