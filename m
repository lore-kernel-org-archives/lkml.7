Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A788C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1511E2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUk3ytbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfETUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:21:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42672 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfETUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:21:47 -0400
Received: by mail-vs1-f66.google.com with SMTP id z11so9739034vsq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+cwBfmNJOYYnLoNWnVRRnVYNxdiZh0AA2x8O10NbLoM=;
        b=UUk3ytbRvoMJoCb1BDVV+bhMWyNCfP4VAtjMhf1lzGoGdYLBnk+w1DzR1J257pctAl
         Z1sIhOH/IrWFoh7qnyLcIMvuCkh8fkDTGFrKquN9TP9ipVXj2ksMpQf/2h+xNxqCH3K2
         oiIVhVB2Wc5K/vc4KJ88h0vfB7fgjFsM3M9kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+cwBfmNJOYYnLoNWnVRRnVYNxdiZh0AA2x8O10NbLoM=;
        b=k4BpxqIXZrAzLHGpXTkHIrRvPgZp3HUFkyYy/8+s6V/MQbxiHoP0J8Lx9DPqYVha/Y
         eqAdlEJEuhLMSPpx4/qL3osarsicrH/GgTIauzcOPRp0W/Xc2Htrwh1VDpCD7OJXowbw
         1dLkeUcaMs9G3gHJlCm8sf8QxYXnKjRbJA7zJprpyszN8iJ35MgHaQDum7m4KCynZz4I
         ak/0bp2yMwRl7jh7A7+i0pkzDUX0LU+MmTKwrR1ZG1IdEW3gYAfiBbW5lWu0k8dVWjb1
         L6/ESrEri6UPgmM3QZXuBOnWNKyHXrLoq0HD7YlqybD75rfZeM3IciMm/S+DjsCbxNnz
         lfEA==
X-Gm-Message-State: APjAAAUyJyMqsa7v7z98leem2cplUIivRWll75JB9gGPqPszrmDzo+pG
        OxIDUkiY1DPheX/hnIWGpA4Mo0+EXkc=
X-Google-Smtp-Source: APXvYqxp1nEvdJ2w+BjTguNWg67kjmvNt1JGLZAQGrblM6t2EwsmEsCOQ/xbiz04SoYzXKsrYVsELw==
X-Received: by 2002:a67:6801:: with SMTP id d1mr39168130vsc.209.1558383706572;
        Mon, 20 May 2019 13:21:46 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id b2sm8006206vkf.16.2019.05.20.13.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:21:45 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id x8so5835962vsx.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:21:45 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr31790963vsk.149.1558383705071;
 Mon, 20 May 2019 13:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170132.91571-1-mka@chromium.org> <20190520170132.91571-2-mka@chromium.org>
In-Reply-To: <20190520170132.91571-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 13:21:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vr2thgHYTH_khqka27_SdGcSEShpSRp+u2E=O5eyxLMQ@mail.gmail.com>
Message-ID: <CAD=FV=Vr2thgHYTH_khqka27_SdGcSEShpSRp+u2E=O5eyxLMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure the GPU thermal zone
 for mickey
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 10:01 AM Matthias Kaehlcke <mka@chromium.org> wrote=
:
>
> mickey crams a lot of hardware into a tiny package, which requires
> more aggressive thermal throttling than for devices with a larger
> footprint. Configure the GPU thermal zone to throttle the GPU
> progressively at temperatures >=3D 60=C2=B0C. Heat dissipated by the
> CPUs also affects the GPU temperature, hence we cap the CPU
> frequency to 1.4 GHz for temperatures above 65=C2=B0C. Further throttling
> of the CPUs may be performed by the CPU thermal zone.
>
> The configuration matches that of the downstram Chrome OS 3.14

s/downstram/downstream


> +       cooling-maps {
> +               /* After 1st level throttle the GPU down to as low as 400=
 MHz */
> +               gpu_warmish_limit_gpu {
> +                       trip =3D <&gpu_alert_warmish>;
> +                       cooling-device =3D <&gpu THERMAL_NO_LIMIT 1>;

As per my comment in patch #1, you are probably ending up throttling
to 500 MHz, not 400 MHz.  Below will all have similar problems unless
we actually delete the 500 MHz operating point.


> +               };
> +
> +               /*
> +                * Slightly after we throttle the GPU, we'll also make su=
re that
> +                * the CPU can't go faster than 1.4 GHz.  Note that we wo=
n't
> +                * throttle the CPU lower than 1.4 GHz due to GPU heat--w=
e'll
> +                * let the CPU do the rest itself.
> +                */
> +               gpu_warm_limit_cpu {
> +                       trip =3D <&gpu_alert_warm>;
> +                       cooling-device =3D <&cpu0 4 4>;

Shouldn't you list cpu1, cpu2, and cpu3 too?  That'd match what
upstream did elsewhere in this file?
