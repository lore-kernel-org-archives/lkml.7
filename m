Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A242084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iz+3qSD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFTUb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:31:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46635 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfFTUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:31:26 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so112546iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RIT3PGSIDktw6riBTCLlesL4b2Jegy8h8HP+jn0p40=;
        b=Iz+3qSD6WbRhUE+tFCZqsR6W+T43RQqlhJuaueVgnsR+UHXqI6yGDiXDmoAN2KQV+J
         K7hg/B5bhJJNeAfOcSvC9amZalXql2GlhpAuSC3SORlAuoH0aFCsWHNWnVuqQGKr3bWe
         AvfJ6cVBI86oXbCiPbIGzMw+OcyhdOGqhwB0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RIT3PGSIDktw6riBTCLlesL4b2Jegy8h8HP+jn0p40=;
        b=VHVqj6JTYEETxp+0dI0CxKtk+9OLP6giiKLEjkNriB9QZff6g+H5mrF0ub40GTVJ+G
         oGYNG8RCjHe8Tbj3DFJatv5R/wQBwXBmAWCACo0prv+TW+eilMQRttFjI9Gfk2B13AAD
         E8nEj6i9oGz55Qb/pFgjTpKMqOrDtvRDoIkTGjx2YUhI2fZ63HtzU7lleUXLsVWOCmGG
         vzoO01cLZMurnxvRdLp4tOJEYN4CqOSbsslSwXuLo5f6YoCi/kMoO2qVplX6Q9facXzs
         0SFqrhaKgXwfUuVuEbnD/FI54Q1XWn8scezj5R8T2EutcDIM/41A2DONK4myer2LFyCI
         FKUA==
X-Gm-Message-State: APjAAAWfVevX3fy6IRKAQx/ZBL2JLhfsy8h4RJJ20KD3CiY8MB6A72fu
        JTzfz4E+EKTWyCYy49SQrH6Rh9G5iw0=
X-Google-Smtp-Source: APXvYqzGadqLHqYWYpoMbzL8wSn+vbuT4AO0CGB6OREdjbP/VSBLHP9FPztyZDPDSF+IQgkiZOnmEQ==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr2822455iol.152.1561062684959;
        Thu, 20 Jun 2019 13:31:24 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id b14sm1059033iod.33.2019.06.20.13.31.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:31:23 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id j6so32716ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:31:23 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr9824185iot.141.1561062682954;
 Thu, 20 Jun 2019 13:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190620182056.61552-1-dianders@chromium.org>
In-Reply-To: <20190620182056.61552-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 13:31:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi21Emjg7CpCJfSRiKr_EisR20UO1tbPjAeJzdJNbSVw@mail.gmail.com>
Message-ID: <CAD=FV=Wi21Emjg7CpCJfSRiKr_EisR20UO1tbPjAeJzdJNbSVw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: add startup delay to
 rk3288-veyron panel-regulators"
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This reverts commit 1f45e8c6d0161f044d679f242fe7514e2625af4a.
>
> This 100 ms mystery delay is not on downstream kernels and no longer
> seems needed on upstream kernels either [1].  Presumably something in the
> meantime has made things better.  A few possibilities for patches that
> have landed in the meantime that could have made this better are
> commit 3157694d8c7f ("pwm-backlight: Add support for PWM delays
> proprieties."), commit 5fb5caee92ba ("pwm-backlight: Enable/disable
> the PWM before/after LCD enable toggle."), and commit 6d5922dd0d60
> ("ARM: dts: rockchip: set PWM delay backlight settings for Veyron")
>
> Let's revert and get our 100 ms back.
>
> [1] https://lkml.kernel.org/r/2226970.BAPq4liE1j@diego
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 -
>  arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 -
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 -
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 -
>  4 files changed, 4 deletions(-)

Maybe wait before applying.  I've been running reboot tests now with
this patch applied (among others) and with enough reboots I managed to
see:

[    5.682418] rockchip-dp ff970000.dp: eDP link training failed (-5)

I'll see if I can confirm that it's this patch and why things are
different compared to downstream.

-Doug
