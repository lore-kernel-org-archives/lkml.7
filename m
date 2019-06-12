Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08625C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85B9208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWWcW//l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439298AbfFLMt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:49:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42795 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439235AbfFLMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:49:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so25567473edq.9;
        Wed, 12 Jun 2019 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DjdxsQABmfK1WPNklnYNFmVAbkT5O5+cSSTNMpg6oUc=;
        b=iWWcW//lap4DHEyJrA1Sl2TUhOIB7DPFDIWTr9DG8KDrvKpkdWzOoKJJAm0JXgV4hI
         xpzVsa0Fx1UKfJ8kRh95QMRBD9HVtr3QNWW+DMb6IM8S15tOIqSAg40+NZx4fa8KGSm5
         AukZlLpx8ZITFjeCypSdnMnRMlvGTchYw3NkuRMyjAAge+smAfIZiI+NbxH4uKfxzNC3
         vkn0k1D/mZyneKnPhzPelu3FXc0K1AmMLrW9F/UpIxB6sB1y7K1o4dHKn6Eeb8Nyw/Bo
         v/qV0ApNiqcMT7Qa1KsDcawoEXkMQgh4Nx+MuPYkfIK6iQBn/xFpFcMILVBxNIbOtuaN
         mmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DjdxsQABmfK1WPNklnYNFmVAbkT5O5+cSSTNMpg6oUc=;
        b=ihQ3y+dUb9PfwOTOXBMdWB28NHwkjbGbqBJWGak7ZwrbYDyf+yetAZ5TsQC3dBO1nY
         IEh2i3lsaEVw6ICrMXp2hCgDfllGWF9mPwAB0D4iiW3COUqS7e1Tg/++aJoXsbDV5PXg
         bGhJqR24Cxg7aphkoLrECNP51l/wD82fqLF+rtY9HTJZeOuOX3dGIYjOvXiaH1EGunWB
         WDqc4xZzeLzaUPZlMi6nzEPNZfHCEOEw/aAZ3gOEobeTfpuyjzjcTD2e6hsl04F29U/E
         7i/Dziq1Im2Za236Ia0MCtL3JTn4maG1ZsyI0sWGctS81WrS4iscuLog1HHMD/DrkoM6
         R42A==
X-Gm-Message-State: APjAAAXaN3KpS6XRFUyGEdcRnDP+lDa5c4ZKNUvgqM7rbKnL7nKesRtA
        TfcCpQH0gpAqPNKpMDgPu0z2MkODhZwY8eubvX4=
X-Google-Smtp-Source: APXvYqwzPSHRjKrf/iW4ZovRxWbXKd8s+2QANDut49hAcIR5dxKoAQpg5uf97WL9Vcr46DHFfN4VvGBcBWS58XxzvSA=
X-Received: by 2002:a50:ba09:: with SMTP id g9mr68765111edc.172.1560343754476;
 Wed, 12 Jun 2019 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190606090612.16685-1-igor.opaniuk@gmail.com> <3b84f3cc6cd5399f25ebd8e1c8559c58@agner.ch>
In-Reply-To: <3b84f3cc6cd5399f25ebd8e1c8559c58@agner.ch>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Wed, 12 Jun 2019 15:49:03 +0300
Message-ID: <CAByghJZJzFN9c9V-o=SV0z07++RPqsB0R8MTsovbtLr3vqJgyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
To:     Stefan Agner <stefan@agner.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wed, Jun 12, 2019 at 3:17 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 06.06.2019 11:06, Igor Opaniuk wrote:
> > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> >
> > Allows to use the SD interface at a higher speed mode if the card
> > supports it. For this the signaling voltage is switched from 3.3V to
> > 1.8V under the usdhc1's drivers control.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> > ---
> >  arch/arm/boot/dts/imx6ul.dtsi                  |  4 ++++
> >  arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 11 +++++++++--
> >  arch/arm/boot/dts/imx6ull-colibri.dtsi         |  6 ++++++
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.d=
tsi
> > index fc388b84bf22..91a0ced44e27 100644
> > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > @@ -857,6 +857,8 @@
> >                                        <&clks IMX6UL_CLK_USDHC1>,
> >                                        <&clks IMX6UL_CLK_USDHC1>;
> >                               clock-names =3D "ipg", "ahb", "per";
> > +                             fsl,tuning-step=3D <2>;
> > +                             fsl,tuning-start-tap =3D <20>;
> >                               bus-width =3D <4>;
> >                               status =3D "disabled";
> >                       };
> > @@ -870,6 +872,8 @@
> >                                        <&clks IMX6UL_CLK_USDHC2>;
> >                               clock-names =3D "ipg", "ahb", "per";
> >                               bus-width =3D <4>;
> > +                             fsl,tuning-step=3D <2>;
> > +                             fsl,tuning-start-tap =3D <20>;
> >                               status =3D "disabled";
> >                       };
> >
> > diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > index 006690ea98c0..7dc7770cf52c 100644
> > --- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > +++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > @@ -145,13 +145,20 @@
> >  };
> >
> >  &usdhc1 {
> > -     pinctrl-names =3D "default";
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sle=
ep";
> >       pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
> > -     no-1-8-v;
> > +     pinctrl-1 =3D <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
>
> Should that not be pinctrl_usdhc1_200mhz?
>

Correct, thanks for pointing this out.
Taking into account that the patch was already accepted by Shawn, will
send another to fix this typo ASAP (added to my todo list).

Thanks

> --
> Stefan
>
> > +     pinctrl-3 =3D <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
> >       cd-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> >       disable-wp;
> >       wakeup-source;
> >       keep-power-in-suspend;
> >       vmmc-supply =3D <&reg_3v3>;
> > +     vqmmc-supply =3D <&reg_sd1_vmmc>;
> > +     sd-uhs-sdr12;
> > +     sd-uhs-sdr25;
> > +     sd-uhs-sdr50;
> > +     sd-uhs-sdr104;
> >       status =3D "okay";
> >  };
> > diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > index 9ad1da159768..d56728f03c35 100644
> > --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > @@ -545,6 +545,12 @@
> >               >;
> >       };
> >
> > +     pinctrl_snvs_usdhc1_sleep_cd: snvs-usdhc1-cd-grp-slp {
> > +             fsl,pins =3D <
> > +                     MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00     0x0
> > +             >;
> > +     };
> > +
> >       pinctrl_snvs_wifi_pdn: snvs-wifi-pdn-grp {
> >               fsl,pins =3D <
> >                       MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11       0x14



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
