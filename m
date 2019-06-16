Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FDC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7207216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560677497;
	bh=V2RGOroRMp3GYJD0CJ4tGNj0hThRjNfWKCdJFaQknLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=awOLw2IHFBlZ4M+0Vbfd1Ygciqg/3xEKm/dJ+MhkbmZe1C6TJbS40VHo66YayBXqb
	 hOhqTEwqqRkt9D1n8DczeoS/gfTNii7CLINhHvrpXl1Y0dK2KBIxS3Kwm0t1T6ETG7
	 ZSCI6t6uDw3z2Qw0JKGomBxUTSEJkhbfVnTS7iqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfFPJbe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 05:31:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFPJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 05:31:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so6128591wml.0;
        Sun, 16 Jun 2019 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P7np2R0uiRKT2gJN8ek7rdfOANAI0XwQdtdo70dDyiU=;
        b=NAMDF+4EtP1973je2uTGBUgvrMI9bYXhHVmS3/3Ts1vT4b+4wnifdhbU8W9kf+Y7S9
         pgiLbr3UtVMu3h+hsiX8wY9jAO6K6c5/QMQ6StZnaJj4Der8IBpqNYVuNmHkGLnWKLek
         hkmNp53+mjCc08jAh44bdK/2FDMTrw95J0lTDE3sm03gOWcO/OZZCVi9C48O1OhvGei+
         LrbAVmySeAFNCESuhOoBqK2wwLDPMbhCOcGYok2+enWu6qjeMDpTMyWBJ6gDBLi7pQRg
         KMXn5xNQqQXlcCkrMHUi4T9g5sD4AzZVFisPwV2HSWH7h1eYzWzcpnAE+v68dJbNqfyK
         /jNw==
X-Gm-Message-State: APjAAAVxAck2wjJncSK423YBSc+4AvhpqAkvFH3EKa51XHaet4WCu4Rb
        hWJdZlkcFjmuUX013qM8NYKfRk1i
X-Google-Smtp-Source: APXvYqwrQ37EbqFHvz3Vz48TrUGqOVW3AcltditTb1gdeHf5Yz1/YUzW/ieDtmIwy2CL4dOiT39uOQ==
X-Received: by 2002:a1c:e183:: with SMTP id y125mr14510016wmg.152.1560677490827;
        Sun, 16 Jun 2019 02:31:30 -0700 (PDT)
Received: from kozik-lap ([194.230.155.186])
        by smtp.googlemail.com with ESMTPSA id c6sm3766254wma.25.2019.06.16.02.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 02:31:29 -0700 (PDT)
Date:   Sun, 16 Jun 2019 11:31:27 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        edubezval@gmail.com, manivannan.sadhasivam@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>, dianders@chromium.org,
        Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones
 conflict in rk3399.dtsi
Message-ID: <20190616093127.GC3826@kozik-lap>
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
 <5188064.YWmxIpmbGp@phil>
 <55b9018e-672e-522b-d0a0-c5655be0f353@linaro.org>
 <e5a4f850-27e0-cad3-04bd-6c004fca2b81@arm.com>
 <9bf85c22-f1ba-3dbc-0b67-17e124484fa1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9bf85c22-f1ba-3dbc-0b67-17e124484fa1@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:30:13PM +0200, Daniel Lezcano wrote:
> On 14/06/2019 16:02, Robin Murphy wrote:
> > On 14/06/2019 14:03, Daniel Lezcano wrote:
> >> On 14/06/2019 11:35, Heiko Stuebner wrote:
> >>> Hi Daniel,
> >>>
> >>> Am Dienstag, 4. Juni 2019, 18:57:57 CEST schrieb Daniel Lezcano:
> >>>> Currently the common thermal zones definitions for the rk3399 assumes
> >>>> multiple thermal zones are supported by the governors. This is not the
> >>>> case and each thermal zone has its own governor instance acting
> >>>> individually without collaboration with other governors.
> >>>>
> >>>> As the cooling device for the CPU and the GPU thermal zones is the
> >>>> same, each governors take different decisions for the same cooling
> >>>> device leading to conflicting instructions and an erratic behavior.
> >>>>
> >>>> As the cooling-maps is about to become an optional property, let's
> >>>> remove the cpu cooling device map from the GPU thermal zone.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> ---
> >>>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
> >>>>   1 file changed, 9 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>>> index 196ac9b78076..e1357e0f60f7 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>>> @@ -821,15 +821,6 @@
> >>>>                       type = "critical";
> >>>>                   };
> >>>>               };
> >>>> -
> >>>> -            cooling-maps {
> >>>> -                map0 {
> >>>> -                    trip = <&gpu_alert0>;
> >>>> -                    cooling-device =
> >>>> -                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >>>> -                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >>>> -                };
> >>>> -            };
> >>>>           };
> >>>>       };
> >>>
> >>> my knowledge of the thermal framework is not that big, but what about
> >>> the
> >>> rk3399-devices which further detail the cooling-maps like
> >>> rk3399-gru-kevin
> >>> and the rk3399-nanopc-t4 with its fan-handling in the cooling-maps?
> >>
> >> The rk3399-gru-kevin is correct.
> >>
> >> The rk3399-nanopc-t4 is not correct because the cpu and the gpu are
> >> sharing the same cooling device (the fan). There are different
> >> configurations:
> >>
> >> 1. The cpu cooling device for the CPU and the fan for the GPU
> >>
> >> 2. Different trip points on the CPU thermal zone, eg. one to for the CPU
> >> cooling device and another one for the fan.
> >>
> >> There are some variant for the above. If this board is not on battery,
> >> you may want to give priority to the throughput, so activate the fan
> >> first and then cool down the CPU. Or if you are on battery, you may want
> >> to invert the trip points.
> >>
> >> In any case, it is not possible to share the same cooling device for
> >> different thermal zones.
> > 
> > OK, thanks for the clarification. I'll get my board set up again to
> > figure out the best fix for rk3399-nanopc-t4 (FWIW most users are
> > probably just using passive cooling or a plain DC fan anyway). You might
> > want to raise this issue with the maintainers of
> > arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi, since the
> > everything-shared-by-everything approach in there was what I used as a
> > reference.
> 
> Cc'ed: Kukjin Kim and Krzysztof Kozlowski
> 
> Easy :)
>

Assuming that all trip-points are the same between thermal zones, I
understand that solution could be to have one thermal zone with thermal
multiple sensors (some time ago bindings did not support it) and all
cooling devices? Then only one governor would be assigned?

Best regards,
Krzysztof

