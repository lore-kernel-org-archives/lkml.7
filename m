Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E67DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0774120674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfDOIS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:18:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33183 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:18:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so13069189ede.0;
        Mon, 15 Apr 2019 01:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ecOXDlNYrgaSWCYKkeZwcYkvFqlf/u+gwlZpWq4i8Q=;
        b=p7biLxrDk0Im1YLf3t2FApLKj0MR5+zouFJK0YGW15GKWVyL/dE9PqqxapVNXSVgtH
         K17V55mBOpF8k1gRtm6j+gGnIF0zC8Z23QpBFm6HYjGwsZPlvRZ8o42AAnpXlcxfwPN6
         bIwG4EjkGMVgbeKaWuBgShyisEfBVHByBe3AK/ei/MzM37CUcZf7GyKghMq1zeyU5dM1
         lxZqoD8+YTrAza03lxTQtvEkocfxADoKMpp/3yjGU872ApkVXmU9+6tpifb2e2zTIQqI
         m6lVVX0+GdJgNou9vqJ0u0/fiEcAbSqLEDklVbQJX/E2lf+ak6VWAqSdrL5utrCtIa8L
         nEPA==
X-Gm-Message-State: APjAAAVPgdpN5vG/BenEDLGulFZvljVb6X9VIs7CSKyf4a1P/Oxv5gdd
        zR+WkfFEoS9/AbRVnHPXLyeMEi8KvPY=
X-Google-Smtp-Source: APXvYqxmlpTDHnvJ/IlAlSbefBh/GPtu4fPwuiThTnVrOt+8suE8tfpk4Cjp3Z3dKWm7NjW3A1dyyA==
X-Received: by 2002:a17:906:3e91:: with SMTP id a17mr39644596ejj.73.1555316304832;
        Mon, 15 Apr 2019 01:18:24 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a8sm3668267edv.81.2019.04.15.01.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 01:18:23 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id a184so19425705wma.2;
        Mon, 15 Apr 2019 01:18:23 -0700 (PDT)
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr21080948wml.24.1555316303380;
 Mon, 15 Apr 2019 01:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190412120730.473-1-megous@megous.com>
In-Reply-To: <20190412120730.473-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 15 Apr 2019 16:18:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
Message-ID: <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/3] Add basic support for RTC on Allwinner
 H6 SoC
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:07 PM megous via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> I went through the datasheets for H6 and H5, and compared the differences.
> RTCs are largely similar, but not entirely compatible. Incompatibilities
> are in details not yet implemented by the rtc driver though.
>
> I also corrected the clock tree in H6 DTSI.

Please also add DCXO clock input/output and XO clock input to the bindings
and DT, and also fix up the clock tree. You can skip them in the driver for
now, but please add a TODO. As long as you don't change the clock-output-name
of osc24M, everything should work as before.

We just want the DT to describe what is actually there. For the XO input,
you could just directly reference the external crystal node. The gate for
it is likely somewhere in the PRCM block, which we don't have docs for.

> There's a small detail here, that's not described absolutely correctly in
> DTSI, but the difference is not really that material. ext_osc32k is
> originally modelled as a fixed clock that feeds into RTC module, but in
> reality it's the RTC module that implements via its registers enabling and
> disabling of this oscillator/clock.
>
> Though:
> - there's no other possible user of ext_osc32k than RTC module
> - there's no other possible external configuration for the crystal
>   circuit that would need to be handled in the dts per board
>
> So I guess, while the description is not perfect, this patch series still
> improves the current situation. Or maybe I'm misunderstanding something,
> and &ext_osc32k node just describes a fact that there's a crystal on
> the board. Then, everything is perhaps fine. :)

Correct. The external clock nodes are modeling the crystal, not the internal
clock gate / distributor.

Were the vendor to not include the crystal (for whatever reasons), the DT
should be able to describe it via the absence of the clock input, and the
driver should correctly use the internal (inaccurate) oscillator. I realize
the clocks property is required, and the driver doesn't handle this case
either, so we might have to fix that if it were to appear in the wild.

> For now, the enable bit for this oscillator is toggled by the re-parenting
> code automatically, as needed.

That's fine. No need to increase the clock tree depth.

ChenYu

> This patchset is necessary for implementing the WiFi/Bluetooth support
> on boards using H6 SoC.
>
> Please take a look.
>
> Thank you and regards,
>   Ondrej Jirman
>
> Ondrej Jirman (3):
>   dt-bindings: Add compatible for H6 RTC
>   rtc: sun6i: Add support for H6 RTC
>   arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree
>
>  .../devicetree/bindings/rtc/sun6i-rtc.txt     |  1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 30 +++++++-------
>  drivers/rtc/rtc-sun6i.c                       | 40 ++++++++++++++++++-
>  3 files changed, 55 insertions(+), 16 deletions(-)
>
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
