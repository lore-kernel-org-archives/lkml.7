Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95165C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7222070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 17:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsGURvxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLVRiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 12:38:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43932 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 12:38:55 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so12577495ioo.10;
        Sun, 22 Dec 2019 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dEeO7j9D/bAeYE+w+B+X07HsZGVL/f7/+4ZeT7yN+Po=;
        b=tsGURvxzUj/qUopMihnBbhfUXJNI6tq5BTfzaXjxQ9JWD25U7cLlpOUcduZS9mWHa3
         RRGbALozdobrRfPgaELywUEUCsyAJJ73uCTj0zzykSETOK/W+7/AdBZK1aco8xLGIUBZ
         SMJ/QU0TafLmcnhUkcBUWdk4ER7UUa+h/8/lC+o0c/9ZmvBMv0Wu4r7GwDZqkkHDQ3bA
         mCKqZ0dR2CtefElLyOBh3Twf3HoHj2IUJQER+S5K6flfBdb+jGE9JEVOPuCbfj+55Jul
         2pUKSVl0De8FTFeGPBoN5dRrTkpUCOC946CyKd4Ey8rXxwtTe1Ngd75dBEbcGZv1JtWu
         zrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dEeO7j9D/bAeYE+w+B+X07HsZGVL/f7/+4ZeT7yN+Po=;
        b=Wahd/ztiko1DDXaUtGDpDm15IYzwf8Luv/LiY7OzXzfyKCM8hAAi4NxAa707JP2MP4
         59OxvYEvg9e8jcfEIUCHMgmmo4gppiYTOzAMvkQHYkY0EeYtC0C19YJ2h0EP7B+Jzvew
         QoV/AkSwke8rSfUGm3YNL5KO/m9oxVQ38FMXTCk6oIXbMjPsy/VqqhNLM2IzyDaH/L5H
         J254Px/xpkNhGSfARgydLI/zKPHBz/xiw71fO1obe2owDZ0kuNBSPNod2/DeaOBw+2lL
         TVCsCrePXFt2NbCaxysvxRgOY55hrDtIw530Y9xPLa15o8j4wUTAnyC1MMubdCXyUn98
         1DVA==
X-Gm-Message-State: APjAAAUGyYNdrSbIBmKRVb5nS2FvgNHj95uJA06zedriLaKnJL92yneb
        gBdYbxRWEG3veHqaNSHiunsxsIetLCEYz18+S2d84LFSi6A=
X-Google-Smtp-Source: APXvYqypcVotE4T4YbABfS+1aFaQ7hyQb7JA3za7IoeTRT6yqGLRTGJQk3ry/CudGuJS2cDOwXJ+BvcLwgITEyxI+7U=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr16695810ioa.18.1577036334507;
 Sun, 22 Dec 2019 09:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20191221173737.30906-1-tiny.windzz@gmail.com> <19c1277f-f0b1-899d-6db0-5c7ff4fe7512@linaro.org>
In-Reply-To: <19c1277f-f0b1-899d-6db0-5c7ff4fe7512@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 23 Dec 2019 01:38:43 +0800
Message-ID: <CAEExFWte+2f0ys5pmUyo1Fcf+FxpPOTDD3bgiAyOu2wgJ2vy4Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: fix indentation in makefile
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BC=9Aq

On Sun, Dec 22, 2019 at 2:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/12/2019 18:37, Yangtao Li wrote:
> > To unify code style.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/thermal/Makefile | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index baeb70bf0568..ab9389bc42b2 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -5,7 +5,7 @@
> >
> >  obj-$(CONFIG_THERMAL)                +=3D thermal_sys.o
> >  thermal_sys-y                        +=3D thermal_core.o thermal_sysfs=
.o \
> > -                                     thermal_helpers.o
> > +                                thermal_helpers.o
>
> Here a tabulation is replaced with spaces.

It won't align after using tab here, shouldn't modify it?


Yours,
Yangtao

>
> >  # interface to/from other layers providing sensors
> >  thermal_sys-$(CONFIG_THERMAL_HWMON)          +=3D thermal_hwmon.o
> > @@ -25,11 +25,11 @@ thermal_sys-$(CONFIG_CPU_THERMAL) +=3D cpu_cooling.=
o
> >  thermal_sys-$(CONFIG_CLOCK_THERMAL)  +=3D clock_cooling.o
> >
> >  # devfreq cooling
> > -thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
> > +thermal_sys-$(CONFIG_DEVFREQ_THERMAL)        +=3D devfreq_cooling.o
> >
> >  # platform thermal drivers
> >  obj-y                                +=3D broadcom/
> > -obj-$(CONFIG_THERMAL_MMIO)           +=3D thermal_mmio.o
> > +obj-$(CONFIG_THERMAL_MMIO)   +=3D thermal_mmio.o
> >  obj-$(CONFIG_SPEAR_THERMAL)  +=3D spear_thermal.o
> >  obj-$(CONFIG_ROCKCHIP_THERMAL)       +=3D rockchip_thermal.o
> >  obj-$(CONFIG_RCAR_THERMAL)   +=3D rcar_thermal.o
> > @@ -49,9 +49,9 @@ obj-$(CONFIG_TI_SOC_THERMAL)        +=3D ti-soc-therm=
al/
> >  obj-y                                +=3D st/
> >  obj-$(CONFIG_QCOM_TSENS)     +=3D qcom/
> >  obj-y                                +=3D tegra/
> > -obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
> > +obj-$(CONFIG_HISI_THERMAL)   +=3D hisi_thermal.o
> >  obj-$(CONFIG_MTK_THERMAL)    +=3D mtk_thermal.o
> >  obj-$(CONFIG_GENERIC_ADC_THERMAL)    +=3D thermal-generic-adc.o
> >  obj-$(CONFIG_ZX2967_THERMAL) +=3D zx2967_thermal.o
> >  obj-$(CONFIG_UNIPHIER_THERMAL)       +=3D uniphier_thermal.o
> > -obj-$(CONFIG_AMLOGIC_THERMAL)     +=3D amlogic_thermal.o
> > +obj-$(CONFIG_AMLOGIC_THERMAL)        +=3D amlogic_thermal.o
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
