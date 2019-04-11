Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98EAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B7F217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIgYPa1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKH4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:56:32 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42174 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:56:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id e76so1735757ywa.9;
        Thu, 11 Apr 2019 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FF+kGzLeHOTOqjnZhY2qqCwlHNXf85+HEBfTvnUXTAI=;
        b=jIgYPa1sZ3xJxzxAM0NYqvsMqKy7MrJ/4zVKK5CWeANdJJ3CAAqTwd5AO1Qe8tCukq
         kh9OfM5IygNqA0ZG+Q8Jh09EP37ygJAybbbRGrjygyvhk37vJoTLMtYbahM1L70++0oD
         fdW+zzQYuII3jMdXntXqGJPXDRh5Aes/E2nYPNGsH3W7yeL8afVJq8Pk7G1vooWAd+Oq
         DWR5xJEiKLd6/TJNEsju67dVd4E99cX9SVDVU8eNvJwkKCNdBedXs4v2++hcaUAhZtsh
         xeMTTkFb1V2J7wZpxiCXmkjWe2yX+a1xvRKrMSaT+q5f8yQUbX4k+hlyg+yOzt87HItT
         otPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FF+kGzLeHOTOqjnZhY2qqCwlHNXf85+HEBfTvnUXTAI=;
        b=hbxdNg2wQ25aEaNhO4NJTR18OI/8UkGhBL5I+M0n4zgPig9fXgsn/Tg9KbA0fvxAjm
         iAPXeiACfTnz7qYomVPwPgjn5zgrS3uHcAPyiTMyDIDG+gkBioKGyw3y7ZBlqjPMQg+X
         fxd7JA3CoiHB8mRtYIQvmsTL3Qlw6731NUTzIvx+H4kIaaGO6fUfZLOE04dHEULOJwMW
         sfv9mhEbkdt2bVlWszfG2mfmmFp1gVFkhkMJuS6prg18IvsER2fSE1zlLzuz+1/Qapd+
         +RCmz0ioB7FExMe3NpDkdLlpU/tgurY3pAkxldeBxg6ktKJhC2a4JG64hx2tPv74Ggqy
         5LkQ==
X-Gm-Message-State: APjAAAXpeOAfm98X9vtnKVaE5K7eu0qfLwpLYeq7hb7gyJ4ulno1Dc0d
        JwFtKJ0TKj93D+raoDYwRfox0QlQMXS7jchc1KA=
X-Google-Smtp-Source: APXvYqyp0mkCHJZQKqijFI3OxwD+SsNnu873lzpcfibwTnI41VeJFKheElyEJk+d/AOWEx7YqT8dDYlhuqlt/a4VUU8=
X-Received: by 2002:a81:7895:: with SMTP id t143mr38341466ywc.156.1554969390860;
 Thu, 11 Apr 2019 00:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190410232543.13297-1-peron.clem@gmail.com> <20190410232543.13297-5-peron.clem@gmail.com>
 <20190411072806.yr3z3ei6djjhpo32@flea>
In-Reply-To: <20190411072806.yr3z3ei6djjhpo32@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 09:56:15 +0200
Message-ID: <CAJiuCcfGO2+rx=91osok3nnqTWBddMVc_1RS3rh0TbVz4ALvrg@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 09:28, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Thu, Apr 11, 2019 at 01:25:39AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Add the mali gpu node to the H6 device-tree.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index e0dc4a05c1ba..152b2128aadf 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -17,6 +17,71 @@
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> > +     gpu_opp_table: opp_table1 {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp@756000000 {
> > +                     opp-hz =3D /bits/ 64 <756000000>;
> > +                     opp-microvolt =3D <1040000>;
> > +             };
> > +             opp@624000000 {
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-microvolt =3D <950000>;
> > +             };
> > +             opp@576000000 {
> > +                     opp-hz =3D /bits/ 64 <576000000>;
> > +                     opp-microvolt =3D <930000>;
> > +             };
> > +             opp@540000000 {
> > +                     opp-hz =3D /bits/ 64 <540000000>;
> > +                     opp-microvolt =3D <910000>;
> > +             };
> > +             opp@504000000 {
> > +                     opp-hz =3D /bits/ 64 <504000000>;
> > +                     opp-microvolt =3D <890000>;
> > +             };
> > +             opp@456000000 {
> > +                     opp-hz =3D /bits/ 64 <456000000>;
> > +                     opp-microvolt =3D <870000>;
> > +             };
> > +             opp@432000000 {
> > +                     opp-hz =3D /bits/ 64 <432000000>;
> > +                     opp-microvolt =3D <860000>;
> > +             };
> > +             opp@420000000 {
> > +                     opp-hz =3D /bits/ 64 <420000000>;
> > +                     opp-microvolt =3D <850000>;
> > +             };
> > +             opp@408000000 {
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-microvolt =3D <840000>;
> > +             };
> > +             opp@384000000 {
> > +                     opp-hz =3D /bits/ 64 <384000000>;
> > +                     opp-microvolt =3D <830000>;
> > +             };
> > +             opp@360000000 {
> > +                     opp-hz =3D /bits/ 64 <360000000>;
> > +                     opp-microvolt =3D <820000>;
> > +             };
> > +             opp@336000000 {
> > +                     opp-hz =3D /bits/ 64 <336000000>;
> > +                     opp-microvolt =3D <810000>;
> > +             };
> > +             opp@312000000 {
> > +                     opp-hz =3D /bits/ 64 <312000000>;
> > +                     opp-microvolt =3D <810000>;
> > +             };
> > +             opp@264000000 {
> > +                     opp-hz =3D /bits/ 64 <264000000>;
> > +                     opp-microvolt =3D <810000>;
> > +             };
> > +             opp@216000000 {
> > +                     opp-hz =3D /bits/ 64 <216000000>;
> > +                     opp-microvolt =3D <810000>;
> > +             };
> > +     };
> > +
>
> How were those OPPs tested?

They are taken from the vendor device tree.
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/=
boot/dts/sunxi/sun50iw6p1.dtsi#L2121

Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
