Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8091DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3C20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLi73Q2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDYQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:00:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34520 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfDYQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:00:52 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so2380311itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+Bmw2hfySDG5AGC94jPKpMtOqOqORroU6ucETpM+GQ=;
        b=TLi73Q2oncaQ3nQPKIm7JjxObj4pgxHQ47NIZDz2BDGXsG7h8jHfol7nyBPip1jmWk
         NpCyc3eDHD+rKt5ZAhvCLkllAgxwzBtTe+An+Uljqpha6GcKIEt+9uoRmVIWpke2dT2b
         WZgH++oBWwjJzEnZ99SKRZZk3leJDsvYBry8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+Bmw2hfySDG5AGC94jPKpMtOqOqORroU6ucETpM+GQ=;
        b=ZwE5SJrBT8ueoC8H7yD6L6YlAXwv74Z2qYXuIEXmxerOBcpYXZ84Iwfq53yESofDYN
         Zm/T1HxqN2eAiw+a5DIh9+PuX8YYUOWU/ZzbzpsDbGdwnzoSvpPexnRLeBVTibF+qT79
         QdSbJHW6h/v+QtMKZsoXV0yfL5DRitZisHW+11Aw7k5ZMBXZoCgWqdYM+v794qAcopdW
         TggxrdPCCUk9FHwggu7m9CTBeV0J5JOilkm4RFI6DbwJLJkpJ8vD+gh7mqUoNaNWWMQh
         kSLGN7XF1vF4qmlpCXd+uv7IUwzT8sm0zYzMqadGmuH9zQxtNhjqPH0AW5tQVs193Xf1
         4dIw==
X-Gm-Message-State: APjAAAVdAshY4qgNYdq4KzSP/49loXLOtlNyyneD67TUDD6MKgICEKSc
        HqvsrJ3KEpNTQ+wP3pXIpegMRFTf/RCZBsTQrMwTiw==
X-Google-Smtp-Source: APXvYqy4x4bb1Jps5LQRWU5iHwnUaSm5rsCtx1NQQuXhCz9WTYjdup7c7wraV10F/QbJvNH9b14uECx1kFdiRP/Rafs=
X-Received: by 2002:a24:ca05:: with SMTP id k5mr4859619itg.71.1556208051251;
 Thu, 25 Apr 2019 09:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190424232918.243308-1-gwendal@chromium.org> <20190425081232.GA14758@dell>
 <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com>
In-Reply-To: <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 25 Apr 2019 09:00:36 -0700
Message-ID: <CAPUE2ussoqWAP-1Hpa2mGq-23NuTh=Ai3dssiZYYiqLBDTCJwQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 4:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal, Lee
>
> On 25/4/19 10:12, Lee Jones wrote:
> > On Wed, 24 Apr 2019, Gwendal Grignou wrote:
> >
> >> The interface between CrosEC embedded controller and the host,
> >> described by cros_ec_commands.h, as diverged from what the embedded
> >> controller really support.
> >>
> >> The source of thruth is at
> >> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >>
> >> That include file is converted to remove ACPI and Embedded only code.
> >>
> >> From now on, cros_ec_commands.h will be automatically generated from
> >> the file above, do not modify directly.
> >>
> >> Fell free to squash the commits below.
> >
> > This is going to need a bunch of Chromium reviews (and testing
> > ideally) before I can take this set.
> >
>
> I tested this patchset in different ways. With the full series applied I checked
> that didn't break any cros-ec driver on Kevin, Samus and Veyron devices. I also
> checked via userspace tool that I don't see any problem sending commands and
> finally I checked that applying one-by-one the patches didn't break the build on
> x86 and arm64, there is though, a problem,
>
> [PATCH 24/30] mfd: cros_ec: Update I2S API
>
> introduces a build problem because removes a struct that is currently used by
> the cros_ec_codec driver. I think that at the same time we should update that
> driver with the new struct name.
Sorry, I did not structure this patchset right. The i2s patch is available at
https://patchwork.kernel.org/patch/10877645/

Gwendal.
>
> Once this is fixed,
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> for the full series.
>
> Thanks,
>  Enric
>
