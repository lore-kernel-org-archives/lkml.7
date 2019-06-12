Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72737C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48073208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY7iUmbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437725AbfFLO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:29:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43332 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437399AbfFLO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:29:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so26053118edb.10;
        Wed, 12 Jun 2019 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0TlQYzzrPp2RCUdFN4WFG/hTYICl/lUW7zy7q9unsQo=;
        b=nY7iUmbW67xrSLerpBKJQ+5gIrIxAkvzyF4JNnkEx64/lWsHdAmJopVR4Zn9u3oJsI
         JOllpgnVQm6ozMN4M6hvnglYR5E5LHSd5Cp762HV6SRiA7W2Yd0vv3kqB6k1lD5MAKqp
         WtG+8m7i6X/7y5e+NHD7RCpgbHCO95ZVLx4SwDdv6tA2uLw4OH6/SjG/HJAcil4FFHcb
         MVTLkW0tXX1uFB8OXW89z5hrOTS/4VVuPi5MJ1x+XbAstFQuE/KESAfYxX7jhGVQPNuA
         atWmHZ8qfV5KDykTydK5EDDfNkUIYgAvXjtpL6+UKxZZaNRrzkwCA9710nOQZCkpwVFR
         tKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0TlQYzzrPp2RCUdFN4WFG/hTYICl/lUW7zy7q9unsQo=;
        b=JxzWluk9qsmRUhUnk1Fv+Tje+sxRAsh4go5bUx/GOY9bo6ftuvd6iutsiLD2aWLyPS
         bopNajDKdEgZ1pZ2/Xj/dUL4xMxt2YDyzj4ngUdktHiW/aRsu+5x6Qa9E8J2N5FmKNJ8
         RUc0QW9/qsuM04jySQzGuOm8RjsFqWZz+X8yVgzRkIqh6RQGYWPDN6Q5XLCZUGhS7wSq
         sQE5atWBMx/BvOx30luOd1beC3UWXDQWPfRzGqa2csYqikLl9mty5txQOrRGUzeIZW8l
         dNfwXrklETvlyLSl/la9XIixHi5un9BprqtpGD1/XxOaTTdz9siheZnZSirCOlnfPv2/
         BpFQ==
X-Gm-Message-State: APjAAAX+8mCjz+mW5hCg4Pl2zsGj73fDxDldAMessx6lKWiRn82bTIEY
        McsqAorlyRNdW9dI62w+jv0UUD/lFZf+O4jLT4w=
X-Google-Smtp-Source: APXvYqypOhSahWrimPdnrCOheH/4lmgx081GS3O1q0rBm7ZI3rE65UZG2S2Y0fI4iozIoKEczfDWuMfXF/6pfha4Y8k=
X-Received: by 2002:a50:972a:: with SMTP id c39mr52675075edb.46.1560349777369;
 Wed, 12 Jun 2019 07:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190606090612.16685-1-igor.opaniuk@gmail.com>
 <3b84f3cc6cd5399f25ebd8e1c8559c58@agner.ch> <CAByghJZJzFN9c9V-o=SV0z07++RPqsB0R8MTsovbtLr3vqJgyw@mail.gmail.com>
 <20190612132705.GJ11086@dragon>
In-Reply-To: <20190612132705.GJ11086@dragon>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Wed, 12 Jun 2019 17:29:26 +0300
Message-ID: <CAByghJaLgY9tStud7_JRoOF4s9fPtzn=mQu=6zvSSO4W4UF6Dw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel@ziswiler.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 4:39 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 03:49:03PM +0300, Igor Opaniuk wrote:
> > Hi Stefan,
> >
> > On Wed, Jun 12, 2019 at 3:17 PM Stefan Agner <stefan@agner.ch> wrote:
> > >
> > > On 06.06.2019 11:06, Igor Opaniuk wrote:
> > > > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> > > >
> > > > Allows to use the SD interface at a higher speed mode if the card
> > > > supports it. For this the signaling voltage is switched from 3.3V t=
o
> > > > 1.8V under the usdhc1's drivers control.
> > > >
> > > > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> > > > ---
> > > >  arch/arm/boot/dts/imx6ul.dtsi                  |  4 ++++
> > > >  arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 11 +++++++++--
> > > >  arch/arm/boot/dts/imx6ull-colibri.dtsi         |  6 ++++++
> > > >  3 files changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6=
ul.dtsi
> > > > index fc388b84bf22..91a0ced44e27 100644
> > > > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > > > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > > > @@ -857,6 +857,8 @@
> > > >                                        <&clks IMX6UL_CLK_USDHC1>,
> > > >                                        <&clks IMX6UL_CLK_USDHC1>;
> > > >                               clock-names =3D "ipg", "ahb", "per";
> > > > +                             fsl,tuning-step=3D <2>;
> > > > +                             fsl,tuning-start-tap =3D <20>;
> > > >                               bus-width =3D <4>;
> > > >                               status =3D "disabled";
> > > >                       };
> > > > @@ -870,6 +872,8 @@
> > > >                                        <&clks IMX6UL_CLK_USDHC2>;
> > > >                               clock-names =3D "ipg", "ahb", "per";
> > > >                               bus-width =3D <4>;
> > > > +                             fsl,tuning-step=3D <2>;
> > > > +                             fsl,tuning-start-tap =3D <20>;
> > > >                               status =3D "disabled";
> > > >                       };
> > > >
> > > > diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > > b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > > index 006690ea98c0..7dc7770cf52c 100644
> > > > --- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > > +++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > > @@ -145,13 +145,20 @@
> > > >  };
> > > >
> > > >  &usdhc1 {
> > > > -     pinctrl-names =3D "default";
> > > > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz", =
"sleep";
> > > >       pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
> > > > -     no-1-8-v;
> > > > +     pinctrl-1 =3D <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd=
>;
> > > > +     pinctrl-2 =3D <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd=
>;
> > >
> > > Should that not be pinctrl_usdhc1_200mhz?
> > >
> >
> > Correct, thanks for pointing this out.
> > Taking into account that the patch was already accepted by Shawn, will
> > send another to fix this typo ASAP (added to my todo list).
>
> I just fixed it up on my branch.
>
> Shawn

Thanks a lot!

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
