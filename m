Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12CDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E052339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S/f4+9NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfIALhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 07:37:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33236 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfIALhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 07:37:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id l2so8633228oil.0;
        Sun, 01 Sep 2019 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4ea0X195pjBksmLH4Jb5O+7IQFkWIEKe4KvUWbpWKw=;
        b=S/f4+9NJpYgjaAYohWElo6Lxu8W10QGg8WQpz2TSmYq6WVpnoMZ5X5mD4FD2Qm/+aT
         h6k30488weYD+GtpbU1X+etsHEo3iek41SBijV4qSTEHt2Tws6OHYsjtY9WjaLh6/EBR
         M9ZFYDsoqasPfy8ltkslhDV8TDNXC6OIyo+EZhDrhfodnlAT9tliaU/i0AVE3Gwmyc+L
         /kCNZ6SkV3A+pJFHBwpu1qX64zPcMUpLXLQhy4iazKhKc2cZnOtA7c56aIjbtj7ENxOa
         UKFmfudh4s6GVBAfHoUYAvgaNq3HNxbUXWrKBdndKCtzq5JrHaRjUC1l5hN+fAkjg1V6
         ZYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4ea0X195pjBksmLH4Jb5O+7IQFkWIEKe4KvUWbpWKw=;
        b=oY4sq1AlgAYBibTfiI7Dby9/N/D7P177TTmGrmc7LJKRSE0erfkM6lnyx4gtqwIYw+
         KZRp8A/VsZPQcJq1svVDuAmetsciXIc7bsIjbIxe+FiSkIEdGQ0LdMSXGckphRpunLSx
         aX0lWaTGRIXESD6cpLdjyZUCuZ+cd4CEKcPNR3w80S5TX+xWAGpEphY7AlJXIflRbu4q
         mMa35XqW2Gsq8BqmyXJkMBmsIQzALa6lmvwTgslnLAHGnGuO59IqdgCZPh0dn4hQCdoD
         mqThSgxbbhjqm+ZDamB3v8Ic+drvhIWQB/BauuZlqJR0nr3Fd4jaqq2v7RWU6G/h66sh
         V1BA==
X-Gm-Message-State: APjAAAUd2l5Iazhcd3Z4yKfsrb2RdrONEJxEXeGtiQ/OHWklLrpfHGYD
        Tz92Zf6Gov7Y9reejI5MKFndvyNhlfKsRVkjlGo=
X-Google-Smtp-Source: APXvYqwvsFh4/YUE47XtDvJtwbjcL/6stJq0LFpkSlQboo8+bTGRT0ChsLaFBnwCmNrxYIhmz28KlbhlSVsH+kzP2pA=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr15797899oij.15.1567337856627;
 Sun, 01 Sep 2019 04:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-2-linux.amoon@gmail.com>
In-Reply-To: <20190828202723.1145-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 13:37:25 +0200
Message-ID: <CAFBinCBWq0LcdA1-a5W06zKp0RzGs5_=Mph6StGKXJ7npCgbfg@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to P5V0 regulator
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per shematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
typo: "schematics"

> fixed regulator output which is supplied by P5V0.
>
> Rename vcc3v3 regulator node to vddio_ao3v3 as per shematics.
typo: "schematics"

according to the schematics there's both:
- VDDIO_AO3V3
- VCC3V3 (which is turned on by VDDIO_AO3V3, see [0])

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 29 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 792698a60a12..98e742bf44c1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -104,11 +104,34 @@
>                 regulator-max-microvolt = <1800000>;
>         };
>
> -       vcc3v3: regulator-vcc3v3 {
> +       vddio_ao1v8: regulator-vddio-ao1v8 {
>                 compatible = "regulator-fixed";
> -               regulator-name = "VCC3V3";
> +               regulator-name = "VDDIO_AO1V8";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-always-on;
> +               /* U17 RT9179GB */
> +               vin-supply = <&p5v0>;
> +       };
> +
> +       vddio_ao3v3: regulator-vddio-ao3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VDDIO_AO3V3";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +               /* U11 MP2161GJ-C499 */
> +               vin-supply = <&p5v0>;
> +       };
> +
> +       vddc_ddr: regulator-vddc-ddr {
> +               compatible = "regulator-fixed";
> +               regulator-name = "DDR_VDDC";
personally I would call this (along with the node name and alias) DDR3_1V5
odroid-c2_rev0.1_20150930.pdf shows that DDR3_1V5 and DDR_VDDC are
both the same. however, the DDR_VDDC signal name is not used by any
component in the datasheet

> +               regulator-min-microvolt = <1500000>;
> +               regulator-max-microvolt = <1500000>;
> +               regulator-always-on;
> +               /* U15 MP2161GJ-C499 */
> +               vin-supply = <&p5v0>;
>         };
>
>         emmc_pwrseq: emmc-pwrseq {
> @@ -301,7 +324,7 @@
>         mmc-hs200-1_8v;
>
>         mmc-pwrseq = <&emmc_pwrseq>;
> -       vmmc-supply = <&vcc3v3>;
> +       vmmc-supply = <&vddio_ao3v3>;
odroid-c2_rev0.1_20150930.pdf uses VCC3V3 as supply


Martin
