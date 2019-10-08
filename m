Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0139C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D8321721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JG+hpqwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfJHSFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:05:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38921 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:05:40 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so38545279ioc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HI75GouwRxYN8A61a1OmNG/T9ubH5sh09rpMiJz5bs=;
        b=JG+hpqwrxAKEEYcv+zMT9gPASAVNdwQPfuQybjrMkqX/JlIEn7BlrTVVWK3rnK72rp
         IrP1u4TMxOUbhXCRKUMtovSns1sZr0NWLjFJ1Sha5/epWnT4NpUp0kHnroYgRKJ2I5AG
         /kVf66tqMQ5oGVfF2ibcRgZyOpKNYmuoC9kTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HI75GouwRxYN8A61a1OmNG/T9ubH5sh09rpMiJz5bs=;
        b=YvGqaOd8WDlQ5SWW2HU7cmJHms/5VP00SVmLQMvQ9q9IUV/GJuvW1lQe78t5Oc95xq
         0l5wtW7Y3tPbyfZJHuxEsyEn3LCy72TuYBZ0k5eW536gNkbaMAH+FDxZu80MNvgfxpfD
         RAlh2n+/W7jHq9olH5tKffBE2WDUB1cdffT9ffW1SI4uYjI2/KPQWi9+KY0lk5jgEXWa
         hp636ybgJvIEEPyAFvTqElxGRMxjepyw8OtsElLU0eZubMOZVkKQWtx56RFzpe0OpzEz
         dSVVV36LoBfYpcCVzllu0rCUvOBC7N0H5xsuu3YWaSToBlIQsEChRW+8qnXNcCFftdIF
         OTDw==
X-Gm-Message-State: APjAAAVoLwa5tPa/TcfeJrzDvxK3/nBuoxDk+FU2YR9hfw55qT0MCfkZ
        pVhDLh5tMC43CkcBuLm2LER4R2sjobo=
X-Google-Smtp-Source: APXvYqxL91WRqDnoQrNKUIizQF09GiCnxUy4P3jxBEbSLnYKkYeEPPgGSGsvN582it/XoSMowBXigQ==
X-Received: by 2002:a6b:b213:: with SMTP id b19mr28982816iof.58.1570557939315;
        Tue, 08 Oct 2019 11:05:39 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id u124sm7246664ioe.63.2019.10.08.11.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:05:38 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id n26so38439652ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:05:36 -0700 (PDT)
X-Received: by 2002:a5d:9812:: with SMTP id a18mr13195587iol.168.1570557936383;
 Tue, 08 Oct 2019 11:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191003094137.v2.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
In-Reply-To: <20191003094137.v2.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 11:05:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xi-M=Kk0axj=ukGMDr4p0a86LRdiL-6WyPZnL2vuDZGA@mail.gmail.com>
Message-ID: <CAD=FV=Xi-M=Kk0axj=ukGMDr4p0a86LRdiL-6WyPZnL2vuDZGA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: rockchip: Use interpolated brightness tables
 for veyron
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 3, 2019 at 9:42 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Use interpolated brightness tables (added by commit 573fe6d1c25
> ("backlight: pwm_bl: Linear interpolation between
> brightness-levels") for veyron, instead of specifying every single
> step. Some devices/panels have intervals that are smaller than
> the specified 'num-interpolated-steps', the driver interprets
> these intervals as a single step.
>
> Another option would be to switch to a perceptual brightness curve
> (CIE 1931), with the caveat that it would change the behavior of
> the backlight. Also the concept of a minimum brightness level is
> currently not supported for CIE 1931 curves.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - added 0 as first step for devices/panels that require a minimum
>   PWM duty cycle
> - increased 'num-interpolated-steps' values by one, it's not the
>   number of steps between levels, but that number +1
>
>  arch/arm/boot/dts/rk3288-veyron-edp.dtsi   | 35 ++--------------------
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 35 ++--------------------
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 35 ++--------------------
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 35 ++--------------------
>  4 files changed, 8 insertions(+), 132 deletions(-)

I guess if someone wanted to they could try to increase the number of
steps and see if they got prettier backlight transition, but what's
there now doesn't bother me and has the advantage of matching what has
been in use forever.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
