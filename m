Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC25C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FDF2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 14:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gdHiHIYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLaORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 09:17:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42941 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 09:17:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so35364410edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 06:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNs8OlYzsZsgaTVTJ4d2AeZZS0KH6pA84bynm/T8fmw=;
        b=gdHiHIYZpnEpU9UnRF0qMaOQd/vPNh1srUcHFRQTZCCWy/OgG4612UzuYrLW90hbcU
         2FJj3DWjTlw/QQf12H8e3CC54SFF0KaFjGVsRBBNqs2igzCrKfPKjmaTQw1xhMg4C2RI
         LcToOOmbdeMjMXtjfkDCrrqsGdW2YKTbzbrX3FdXCgDbHOW0mqbRjzVRml2FKRHMrykb
         5zLuHok6Hl6e6IgLYSN4hytm1fu9r4EiMxoXmZhdq2g8FNGhpotKcz0rClrK4GD2Ba9i
         bFNpoBS5u4IRNHgVV7BfeDZ/KrFmv2notP1GU+lkSv4N9J+3Dd0fdJYotb6F1oai5FUa
         +W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNs8OlYzsZsgaTVTJ4d2AeZZS0KH6pA84bynm/T8fmw=;
        b=Q0tT9/FwAkEOFw4gT6Jy+07busBnubVReQxUjYIO0dbFwEo0XL3+7wrniisaNfNa2Z
         Jj1FfZMN7ddOsck2u/eMBDlKYGxNdbCD85f/qAzFdp8jJo5X9gyyuOB2kNuCCjee/ETh
         3IfEjkEE71ushVLz1JKyCJEGnkw98SY6XhbhW9vRXvtCwLQ13h1sIIcULoO6gwp1Xcto
         dTAZ1lfOpvcOZeCnbCmKbZkAYXMh2IrPedU/itxBAaY0qEin1DB/G2LJNJm1qt+NUfqi
         U+aXkAQX+Fqx06Ih6kUpriH9DXkF4FRMMg/LHL30S1z22OUIeYFsnHyMdpmuHx/sXvmw
         SFPw==
X-Gm-Message-State: APjAAAVu/4wJosjZj01+tBjWkCrIuWeb2NVhMIFjT3h/oa2x8lgsy1cV
        pB1zo6wz56RmFoFF4HPY82IHPL0haswkg6d8Ifmig2UR
X-Google-Smtp-Source: APXvYqwSiePXVoRUw8gJ/sEg4LKPTsG3G7GWxVQyLT4WISsO6zZ4PPra5S6beiWn62LpvYWzUGdJKa4tYfMAlEsF000=
X-Received: by 2002:a17:906:1a50:: with SMTP id j16mr70863648ejf.106.1577801873680;
 Tue, 31 Dec 2019 06:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20191227173707.20413-1-martin.blumenstingl@googlemail.com>
 <20191227173707.20413-2-martin.blumenstingl@googlemail.com>
 <dd38ff5c-6a14-bb6a-4df5-d706f99234e9@arm.com> <CAFBinCDs3a8TJcQKgHUkDvssMR6Y2Kys38p50P0q=2KOiDTNHg@mail.gmail.com>
 <fe45f4f8-8c67-ded2-90bf-8d5fd6874876@arm.com>
In-Reply-To: <fe45f4f8-8c67-ded2-90bf-8d5fd6874876@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Dec 2019 15:17:42 +0100
Message-ID: <CAFBinCByzLLdVTL0v=eC-TbZQnwnDY7cBLf4jyWq7N4PA1rr+A@mail.gmail.com>
Subject: Re: [RFC v2 1/1] drm/lima: Add optional devfreq support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org, robh@kernel.org,
        tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        alyssa.rosenzweig@collabora.com, daniel@ffwll.ch,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Dec 30, 2019 at 1:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2019-12-29 11:19 pm, Martin Blumenstingl wrote:
> > Hi Robin,
> >
> > On Sun, Dec 29, 2019 at 11:58 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On 2019-12-27 5:37 pm, Martin Blumenstingl wrote:
> >>> Most platforms with a Mali-400 or Mali-450 GPU also have support for
> >>> changing the GPU clock frequency. Add devfreq support so the GPU clock
> >>> rate is updated based on the actual GPU usage when the
> >>> "operating-points-v2" property is present in the board.dts.
> >>>
> >>> The actual devfreq code is taken from panfrost_devfreq.c and modified so
> >>> it matches what the lima hardware needs:
> >>> - a call to dev_pm_opp_set_clkname() during initialization because there
> >>>     are two clocks on Mali-4x0 IPs. "core" is the one that actually clocks
> >>>     the GPU so we need to control it using devfreq.
> >>> - locking when reading or writing the devfreq statistics because (unlike
> >>>     than panfrost) we have multiple PP and GP IRQs which may finish jobs
> >>>     concurrently.
> >>
> >> I gave this a quick try on my RK3328, and the clock scaling indeed kicks
> >> in nicely on the glmark2 scenes that struggle, however something appears
> >> to be missing in terms of regulator association, as the appropriate OPP
> >> voltages aren't reflected in the GPU supply (fortunately the initial
> >> voltage seems close enough to that of the highest OPP not to cause major
> >> problems, on my box at least). With panfrost on RK3399 I do see the
> >> supply voltage scaling accordingly, but I don't know my way around
> >> devfreq well enough to know what matters in the difference :/
> > first of all: thank you for trying this out! :-)
> >
> > does your kernel include commit 221bc77914cbcc ("drm/panfrost: Use
> > generic code for devfreq") for your panfrost test?
> > if I understand the devfreq API correct then I suspect with that
> > commit panfrost also won't change the voltage anymore.
>
> Oh, you're quite right - I was already considering that change as
> ancient history, but indeed it's only in 5.5-rc, while that board is
> still on 5.4.y release kernels. No wonder I couldn't make sense of how
> the (current) code could possibly be working :)
>
> I'll try the latest -rc kernel tomorrow to confirm (now that PCIe is
> hopefully fixed), but I'm already fairly confident you've called it
> correctly.
I just tested it with the lima driver (by undervolting the GPU by
0.05V) and it seems that dev_pm_opp_set_regulators is really needed.
I'll fix this in the next version of this patch and also submit a fix
for panfrost (I won't be able to test that though, so help is
appreciated in terms of testing :))


Martin
