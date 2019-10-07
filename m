Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F00205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq91mJU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfJGP3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:29:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33657 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:29:00 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so29597828ior.0;
        Mon, 07 Oct 2019 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtVsLO1ntFCrS5daswTpm686yy3QS5pSIH9g4p/6SHY=;
        b=Rq91mJU4qTssd1QORjJKdkSCMC5RTaFQhaQZilPoU8yf2BUuUM+yTlZnTRoi+85Fri
         evPqABRZll0UgF32Srs86O6CyUHAb6Y4hgM+r2xZMDa9x1ClU/dfLgn/JjwfI+GnTJYt
         9iIAlIcMRWHCoi/b6W1HBDgQEPLleBYKQNNBZYfF2AaD9gKAv7u7kE+NUbQxlehRltWh
         /HhI+/V/rk0/jcP6/YcVqlVkTrnJ+NVRkzGPUCXxk6uYohYaPCw/QKpAdMpxk2K95PGH
         ULYlMqwJWHMBZLNfWNWB8HRuYt3akVcDn6GgQ1145Fz43jqbF5bFZIWmdtjcBS+EkH5f
         j+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtVsLO1ntFCrS5daswTpm686yy3QS5pSIH9g4p/6SHY=;
        b=Ef70Hncbaa5KT9MTJTqoriQPM5idksBjaR/JG/hYVlyD1cbMP0wX14D9CzKukrEssX
         LpjmKLCz9hr8RlCaHtZcy5wSggOGWIYmTpYDc8Re7OT9WvsqY6bnTQR5SyGzXT3CJE+i
         Z62Y0zm6dadyXcVO0ejucNtCPCZgKgerVZUCWjXtlo/L10WqYC9o5tQvHS8RfUtuiq9M
         J4593kJE9vVfzN4AjgF6HrYSgTOpgMS86YmWw2uhkMdnlSj3o+HN1fS3OREvL2mp5x9e
         4QNeoKt330onA8+eXL1I19ntpAhI0ren5zgG/CCTvfJtl4f+vx8BjgEAZLE5iByo14Mz
         M8SA==
X-Gm-Message-State: APjAAAXOMcpci28Y4JQhSgvoTv45wRhZHMuPKDPyRlf2/o4Nzw5xNBKh
        uNtwq3xsNhMVhxn51OITj63VsG5wIrh7tW6t4dc=
X-Google-Smtp-Source: APXvYqx45IwIf/HAU8nElk9tCCd1rWFbJeMPlSSBQCc0bur5Oz+a9TlsSmo4fwChJbmJLYKpfCOoDn08G87lnL/TrVc=
X-Received: by 2002:a02:69cd:: with SMTP id e196mr28656654jac.84.1570462139862;
 Mon, 07 Oct 2019 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-2-linux.amoon@gmail.com>
 <c99adf31-42df-c88e-40d4-1dc383c990b1@baylibre.com>
In-Reply-To: <c99adf31-42df-c88e-40d4-1dc383c990b1@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 7 Oct 2019 20:58:47 +0530
Message-ID: <CANAwSgQi=56RPQK-a7CM2W9dOt3mzDzdtfNABKmpdsYRN8vLwQ@mail.gmail.com>
Subject: Re: [RFCv1 1/5] arm64: dts: meson: Add missing 5V_EN gpio signal for
 VCC5V regulator
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

On Mon, 7 Oct 2019 at 19:49, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Anand,
>
> On 07/10/2019 15:16, Anand Moon wrote:
> > As per schematics add missing 5V_EN gpio signal to enable
> > VCC5V regulator node.
> >
> > Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > index 42f15405750c..a9a661258886 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -94,6 +94,9 @@
> >               regulator-max-microvolt = <5000000>;
> >               regulator-always-on;
> >               vin-supply = <&main_12v>;
> > +             /* U12 NB679GD 5V_EN */
> > +             gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> > +             enable-active-high;
>
> This GPIO is handled by the BL301 SCP firmware, I'm personally against
> adding this to the DT since it's out of control of Linux or any OS.
>
> Neil
>

Thanks for your input.

> >       };
> >
> >       vcc_1v8: regulator-vcc_1v8 {
> >
>

Best Regards
-Anand
