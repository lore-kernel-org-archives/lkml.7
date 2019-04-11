Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC473C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1AE20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVG93Xvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:12:16 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37929 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:12:15 -0400
Received: by mail-vs1-f68.google.com with SMTP id s2so3145358vsi.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SfexgW28E4UUrLamx42EHS+Zd9dRP/vmGvBJMYO6Ddw=;
        b=DVG93Xvg/kcz8zYHijFL+2ZWd/zPj4SYVEu0BJar47Za55UtCYUyCWGM0V8TRYpQjV
         w1s53fuP45o0n961Jby+vD5ZT18d5zSZrJHTh7BYs3Dn2plaZKZzW5AMr6G399XJYsF2
         coSUtIr95TO855syIVDEpBF212B+bo2GjkdOkOe7MuK1nO7mlUyQ1XrB9RrnkiVwQNWP
         AW3xm4bDtAjToREweuztkJiJuDpIZnkIDD28lvmf/4ANoH2PQJhzfpk2BjvJOjFT/nr+
         /zoVh6Z651p1fcZdMzUEj1Lzc2QB8K0Txkjh69DBXRBZWfiG90FnOi9SFlCltFrc6bbL
         uSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SfexgW28E4UUrLamx42EHS+Zd9dRP/vmGvBJMYO6Ddw=;
        b=EuHBpo/yZfbTPC9t0l5sEX7p+fydxBrYo12wFvogCEu65igfeZ66dUTqdsrOhWgp1u
         dXpaNqsRkhpJQISxJrGzPej7ETKA8Aidk7IDnsfZjBkpi/Gym9Qwoc89ae3YeFd9Um+3
         kFwWjwKArxBBH4TBgBpK5HF6mPcAoxuxQop9UBabLb6s1whSpk5TmlYO9pdateCWVEfL
         ihuMtAsJDhi34PsPqiQ/mhXzR+VBljZvyBsGpNRpAdvoxx94PKZq0aykWE5ciU/XaOi+
         6ESqR7dk/KUuxvIqKzZfT/GL6ehMjrBO8a+k4uHeXXxJwpXdhR9vOHOrp6dUHbcCDgTT
         /rNQ==
X-Gm-Message-State: APjAAAVOPiUcj+TkXq0Y0Wxa7PgJQtqgMxXh2DU5HmSRfPtuBRyMZ1L1
        K0MmJ2YnvFUQI78L/KALhIRXkV+hdTA64Pv1nMTJb/EF
X-Google-Smtp-Source: APXvYqx+/v/dF+t2ikCAj89NGm6jl1P7n7apxHk6U0J0gzr0UUZtQIvMN28ZhE/WCV+XAjysiKHCj3UnavPa2faRlgU=
X-Received: by 2002:a67:2e8c:: with SMTP id u134mr27081195vsu.57.1554977534532;
 Thu, 11 Apr 2019 03:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
 <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:11:38 +0200
Message-ID: <CAPDyKFqwESQ9_gDxLXhzBzu236+8p6rnqricULA7GrZguVZQWQ@mail.gmail.com>
Subject: Re: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 at 19:43, Sowjanya Komatineni <skomatineni@nvidia.com> w=
rote:
>
> > > >
> > > > Default tap and trim values are incorrect for Tegra186 SDMMC4.
> > > > This patch fixes it.
> > > >
> > > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > >
> > > Is this a fix and/or for stable?
> > >
> > > In either case, I am leaving this for arm-soc.
> > >
> > > Kind regards
> > > Uffe
> > >
> >
> > Thanks Uffe. Yes this is applicable for stable.
>
> I don=E2=80=99t see any confirmation of this being applied by arm-soc.
> So thought to re-check if this is applied?

Perhaps repost it to remind the soc maintainer to pick it up.

Kind regards
Uffe

>
> > > > ---
> > > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > index 97aeb946ed5e..472f55fe9488 100644
> > > > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > @@ -317,8 +317,8 @@
> > > >                 nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D=
 <0x0a>;
> > > >                 nvidia,pad-autocal-pull-up-offset-3v3-timeout =3D <=
0x0a>;
> > > >                 nvidia,pad-autocal-pull-down-offset-3v3-timeout =3D=
 <0x0a>;
> > > > -               nvidia,default-tap =3D <0x5>;
> > > > -               nvidia,default-trim =3D <0x9>;
> > > > +               nvidia,default-tap =3D <0x9>;
> > > > +               nvidia,default-trim =3D <0x5>;
> > > >                 nvidia,dqs-trim =3D <63>;
> > > >                 mmc-hs400-1_8v;
> > > >                 status =3D "disabled";
> > > > --
> > > > 2.7.4
> > > >
