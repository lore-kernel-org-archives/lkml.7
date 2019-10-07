Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DDAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2A206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNQKHVR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfJGPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:30:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39727 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:30:58 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so29509911ioc.6;
        Mon, 07 Oct 2019 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4hcT7mBp35uXHSVwUqNeV4V+B+eaf0dc/DbaSlAph0=;
        b=XNQKHVR2uoPGMAtS9PckZVazA5sBYNsa9mhHeQTYCZd507obrqq6yzVn3muywbCC9w
         wo+ndKBZ9UNVa4cy8iVCLIBtWXPPg0w5lcKPxdlUDRIEVruo44+BLb4j4hyD5q6DpGm4
         Gji7iCC918Xgnv4XLUVr4MJsooi9nkyLDUvIvAgddW+2TXByJq7yy6eH4o2vf5TFnGg+
         w2jCz3XCjqXKhv4jNCb3v1C1u7OHGuhC+cQk3ZZNQpZx1VkfMCXduNdJhB+H3drb0Xky
         xFD31ivqnGuNn2XnILy/HvPnx0CYesxQCm9vRSiSssFm6ruTBbiOrKq1nZCpecYt49gN
         ZD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4hcT7mBp35uXHSVwUqNeV4V+B+eaf0dc/DbaSlAph0=;
        b=E4qXocB3ta3j7p+eWoj8gd24Z++GtheZkPqp3CuVnoPgGqN+tRulYsecqSX7utB4xw
         gqjlcxLwRs0UHjfy+PCRrI9rb5MtNXm4712e9c1ZHx7kw7Axtq0o8R8SfMEG2LReWaeh
         DvwFAv6vlK1rIzWDmfy4XQHQQpz8hPSl4bhb1iQl60JsZlS+dpvRLka5IIRBzsN4wMuJ
         3uBQ/e8jUp6c1NY/ctgaoz3FFUO0FE/6pUgMSUF2jvXnWBe2Xul5gsK9rNUszsV0ypfy
         vBtKoz07uRJKeYLjVw37Yn5a7raVVUp51XKdihhgse7fYiDg4fG7BwdGdK5LE2Lp2Gni
         OfNw==
X-Gm-Message-State: APjAAAXGp5PoE+KzE8lvhiV+quo+/hXx9VRBDTB4BS2CeG82WAsw+LQK
        leosASSRWS2OfB1hSFECindZlybH8hpTH+RZjY4=
X-Google-Smtp-Source: APXvYqxpe2durmFMtM3vpWDBRud3gbR8qLIzCHYB0na4/zQaLD4Xtara1qgDIzbl+85++yeu5iQDy5tir7B4sAyQU60=
X-Received: by 2002:a92:3ac3:: with SMTP id i64mr29073302ilf.221.1570462256975;
 Mon, 07 Oct 2019 08:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-3-linux.amoon@gmail.com>
 <8a74834e-5cfa-3f3b-9ba6-e88e265b67a0@baylibre.com>
In-Reply-To: <8a74834e-5cfa-3f3b-9ba6-e88e265b67a0@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 7 Oct 2019 21:00:44 +0530
Message-ID: <CANAwSgS=r_Rz0fc6GDsD7Rk6udq3LcYtB-Ag_=kjVa-EApchJQ@mail.gmail.com>
Subject: Re: [RFCv1 2/5] arm64: dts: meson: Add missing pwm control gpio
 signal for pwm-regulator
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 7 Oct 2019 at 19:50, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 07/10/2019 15:16, Anand Moon wrote:
> > As per schematics add missing VDDCPUA_PWM and VDDCPUB_PWM
> > gpio signal use to enable/disable the pwm regulator for DVFS.
> >
> > Fixes: d14734a04a8a (arm64: dts: meson-g12b-odroid-n2: enable DVFS)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > index a9a661258886..66262a6ab3fe 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -135,6 +135,8 @@
> >
> >               regulator-boot-on;
> >               regulator-always-on;
> > +             /* VDDCPUA_PWM */
> > +             enable-gpios = <&gpio GPIOE_1 GPIO_ACTIVE_HIGH>;
> >       };
> >
> >       vddcpu_b: regulator-vddcpu-b {
> > @@ -154,6 +156,8 @@
> >
> >               regulator-boot-on;
> >               regulator-always-on;
> > +             /* VDDCPUB_PWM */
> > +             enable-gpios = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> >       };
> >
> >       hub_5v: regulator-hub_5v {
> >
>
> Same as 5V_EN, This GPIO is handled by the BL301 SCP firmware, I'm personally against
> adding this to the DT since it's out of control of Linux or any OS.
>
> This GPIO id controlles by the PSCI call to SCP to enable/disable
> the CPU clusters.
>
> Neil

Thanks for your input's.

Best Regards
-Anand
