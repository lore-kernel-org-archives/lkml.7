Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966CC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7422084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfHNEjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:39:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38358 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHNEjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:39:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so5913563edo.5;
        Tue, 13 Aug 2019 21:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOFzth/1t3h2J4LDht3H6+aj/CXIWQiypTJlHhUjEtg=;
        b=irPlJWYku41mghSOVpE88PjPtRisvjHWxIuP8ANpDyWgwCULm0MMnEbRrKBFDbARBA
         RmM+s+mUYqtWuRhXFyXMR7CcqE4APdu6pae4ACEhIzMhSg8duDrU1uztS//gk7rkMVVI
         ED2dNiDLTS+S6SOYb6hyOPGeNORXLTc4yY61Za++9Wei5vP1XwVibFtXE/oVLFmsjsQG
         paR3uiaT/kVjVkZLuNEgRShz5mP0x30gSopd8MlIpro80EWhKrHJspdu9k4hO2HX7Y9B
         Jy35Jen7z7KI2C2Ayi+k4WiDrUdC826UfPd1c90XFF4dByQNPHTc4KcTqI/WnwpBMucN
         9RFA==
X-Gm-Message-State: APjAAAU0HiSU+shvk21gZbONKiMOxbuzsQylbwXIjAuNGxHeBjCfvQiP
        JXOcwtcvjigOrrmp8V8Y4jLB8ywncdI=
X-Google-Smtp-Source: APXvYqwILgQ9HiR8qxeH5kOeSHE7enK0H3ZeprQqO73aeEOsjuN0iNPZUhpytJ2GGNy13sOThClfeQ==
X-Received: by 2002:a50:c19a:: with SMTP id m26mr16395223edf.184.1565757545257;
        Tue, 13 Aug 2019 21:39:05 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id r19sm2540152edy.52.2019.08.13.21.39.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 21:39:04 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id l2so3223603wmg.0;
        Tue, 13 Aug 2019 21:39:04 -0700 (PDT)
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr5533924wmi.61.1565757543807;
 Tue, 13 Aug 2019 21:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190813124744.32614-1-mripard@kernel.org> <20190813124744.32614-4-mripard@kernel.org>
In-Reply-To: <20190813124744.32614-4-mripard@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Aug 2019 12:38:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mp-=T=-zDYMf6Qw-vaiR3OB5Xhxie39jeKWS+Kvmecw@mail.gmail.com>
Message-ID: <CAGb2v66mp-=T=-zDYMf6Qw-vaiR3OB5Xhxie39jeKWS+Kvmecw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: sun8i: a83t: Remove the watchdog clock
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 8:47 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The watchdog binding doesn't define a clock, and it indeed looks like
> there's no explicit clock feeding it.

The diagram on page 133 of the manual shows OSC24M / 750 feeding the watchdog.

Other manuals, such as the A10 one, mention:

    Watchdog clock source is OSC24M. if the OSC24M is turned off, the watchdog
    will not work.

So in fact it does use a clock signal. It's just that we've been lazy, since
the clock rate is fixed and is always on.

ChenYu

> Let's remove it from our DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 523be6611c50..15f8c80f69a5 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -817,7 +817,6 @@
>                         compatible = "allwinner,sun6i-a31-wdt";
>                         reg = <0x01c20ca0 0x20>;
>                         interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks = <&osc24M>;
>                 };
>
>                 spdif: spdif@1c21000 {
> --
> 2.21.0
>
