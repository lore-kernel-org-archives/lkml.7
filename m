Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB38DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91159206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mBg+n9lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfETRqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:46:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38470 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:46:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id u199so10648677oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38zPeA6Fhr1ZBy+vMwAUUe+FH+u6lYEDinxTgKe8jfU=;
        b=mBg+n9lZrifWmIchIxvK5kTN9EZwTSDxUFaFtnFoZKXnMyAV+Iq8IUegSYcgBtLm/g
         xsXFcWOfOKQs2+ypiQpWppY/vAu2CV2U8owXBxTsSqWamFX/2gJAVMz7wWntmFQwQYpA
         jUX8MzYzGkiUPjn9u2OpVvRLaX736sRYEsvN9bTdvQ+VMb1+7KhLPGrL+faMgFtw8YhP
         5ml/388lR3IYyl00/xxscQXfHOMKX0tYZ0gkjA90hVIKiUDy7JkEyJDUzas6QF1lvuGU
         9fAfkaD42hXRWZZNCoFNp2hqGegrwjzSjOp4KKFhfVajaPIGnsGrYehV7UQxIY2wjr6T
         chgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38zPeA6Fhr1ZBy+vMwAUUe+FH+u6lYEDinxTgKe8jfU=;
        b=L/TguOwWNiGqz6+FwWfKdfuK2W1W5x7FnWri7wGxZWBaVWqFFC4SIgBBoiGVpTeRaY
         ZgBi2LEmxR4X/MXEVh+rgR+zNbw9lpp0R6l+46iv9U6SK+CnDn1V4dsoyWBk50bQhbKs
         +vHk1JQsipt6X/m3yem77+7Wnd88HLzbqNYjRUTtxsOl+zjHW7ZL006YVwHiz5as0G/J
         Z+0dUCrIvvWvfmr7RbMsckSL4gbLDigkT+7E0nX9HKia+YjxkvqTclLLR0i5s35Xg1Bw
         0WS69xnzi8qaOU7JXFS8hTdOUD2R1UFSIwEbaKU8DB+LG0IjZdJFzNwD0Fyf2nW3e3+G
         1g4g==
X-Gm-Message-State: APjAAAUoMIXL28KCFTTctm+LqBwrIb8V7+CznbxuugFEBSLkjJLWOosl
        RZHtOSgRfO1ElFRg+TVDHBzOzUsU22XFYfoW51g=
X-Google-Smtp-Source: APXvYqyuYlVtOuX+Lww9+dN0Mn8HNZ5jS8KNZEF3euwLnF9UrxtHXooz3S4Rbr6amOdAIBoCw8MEvTyFaXOkBBVDrsE=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr248920oib.129.1558374369565;
 Mon, 20 May 2019 10:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-4-narmstrong@baylibre.com>
In-Reply-To: <20190520134817.25435-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:45:58 +0200
Message-ID: <CAFBinCD6wJnYd3-E=kS6WCZLFebV9JYk-GybBxoMA8qQqGfSHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: g12a: Add hwrng node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 3:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A has the hwrng module in an unknown "EFUSE" bus.
>
> The hwrng is not enabled on the vendor G12A DTs, but is enabled on
> next generation SM1 SoC family sharing the exact same memory mapping.
>
> Let's add the "EFUSE" bus and the hwrng node.
>
> This hwrng has been checked with the rng-tools rngtest FIPS tool :
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 1630240032
> rngtest: FIPS 140-2 successes: 81436
> rngtest: FIPS 140-2 failures: 76
> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
> rngtest: FIPS 140-2(2001-10-10) Poker: 6
> rngtest: FIPS 140-2(2001-10-10) Runs: 26
> rngtest: FIPS 140-2(2001-10-10) Long run: 34
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
> rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
> rngtest: Program run time: 30000987 microseconds
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 8fcdd12f684a..19ef6a467d63 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -197,6 +197,19 @@
>                                 };
>                         };
>
> +                       apb_efuse: bus@30000 {
> +                               compatible = "simple-bus";
> +                               reg = <0x0 0x30000 0x0 0x1000>;
the public S922X datasheet lists the range as FF630000 - FF631FFF
that translates to a size of 0x2000, which the vendor kernel
(kernel/aml-4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi from
buildroot-openlinux-A113-201901) seems to use as well:
  io_efuse_base{
    reg = <0x0 0xff630000 0x0 0x2000>;
  };

where did you take the size from?

> +                               #address-cells = <2>;
> +                               #size-cells = <2>;
> +                               ranges = <0x0 0x0 0x0 0x30000 0x0 0x1000>;
(see reg property above)

> +
> +                               hwrng: rng {
this should be rng@218


Martin
