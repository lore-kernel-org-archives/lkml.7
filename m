Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81F9204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBi1XhD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLI7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:59:14 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:35767 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:59:14 -0500
Received: by mail-ua1-f51.google.com with SMTP id s14so1075495uad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tf2mudZCYNcbKijnx7l8kTR9ghpKz810SOwwndyzloo=;
        b=cBi1XhD0izth7qoDufpZuhLyMbzgjKIertes3s+oTmfIQUcjyLC8nW7YvKMwUZ/Al9
         UuIzrbTfcLHfhcS1agSm4E5e9xzV4StaELnCTzrZmFgfAUu9xlkw6reZZ6QDIR21pmkz
         2TCmzM/P3XZfnY6UuHhqasT074EnDsb/CuuEobGXrsW1IZ1fF8KVfToYsOnG4K6dmuuC
         THbZYKW5WoYK29Lm1OtsYJWZFCM+TzHFu9SoQQ4W/BSff3vARAm6NMYoBRME8PINAAe8
         /BW6SN00vqrBxU3PCxxhw5KTWeIZ+Bi+hg/ePhibVioqHu6mYwP0GFedmy79HOB3a48i
         MXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tf2mudZCYNcbKijnx7l8kTR9ghpKz810SOwwndyzloo=;
        b=OAfMw5eqxxEJaq3Xkd1nrAPOak9vdC7AEUpmoy0UyXlKOOcswKYDcumiuyON0HvlM7
         kcgl6xorEUjHfA2jTXh+v4rD/SgI5BPQSkJXyyFW6GxDqlvuJyF2jR/fgaVTL4O187Bz
         PWpmN/mLxICwGAuulCXDklG5CJ8pcUIm4aic4VKZNhGjwmgeFQ/3rXJjSxh5rAfc6x3N
         wrQrmbqfYOpUTAAbFe4hpVXSxCTX3uFPNUf5PTA4HgJubw7p4UFR2I+J884jfJcmrMEH
         BeX9HHphiRMhSPUSB/KIipUM80Dtv8Y62rbp+Bajk9uHdNzHNd7wner7J4t1zDfEyqTl
         ra6w==
X-Gm-Message-State: APjAAAWvcvgEIh2t9XmxGmLudZvs4P6RLXHaigZDQaEOnEBSo+NRWBML
        AQr42xMGveplF+HrT0FwRLkm5AAdJeO8wcEacwhAEg==
X-Google-Smtp-Source: APXvYqxFPhWgc8iHkpTuygj7MTTUYu4BcQnzbVKGkW6JXLBaDAutQSmw9xt4FZ9zvOyXuQCGXHtYTV2Sub2XRMdS+zw=
X-Received: by 2002:ab0:648d:: with SMTP id p13mr113924uam.129.1573549153321;
 Tue, 12 Nov 2019 00:59:13 -0800 (PST)
MIME-Version: 1.0
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
 <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com> <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
In-Reply-To: <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 09:58:37 +0100
Message-ID: <CAPDyKFrsQNMhDb3yh4M1EPGtftFrVmHY-pmpR7AbfrXW=xzyyg@mail.gmail.com>
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 20:32, Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> Hi Ulf,
>
> Am 11.11.19 um 18:27 schrieb Ulf Hansson:
> > On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wr=
ote:
> >>
> >> Add SDR104 capability and regulators to SD card node.
> >> While at it, fix a typo in lcd pinctrl and remove two
> >> undocumented bindings from pmic.
> >>
> >> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> ---
> >>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++---=
-
> >>  1 file changed, 25 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> index 33df95e384b4..e86a6db54499 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> @@ -135,6 +135,20 @@
> >>                 vin-supply =3D <&vcc_1v8>;
> >>         };
> >>
> >> +       vcc3v0_sd: vcc3v0-sd {
> >> +               compatible =3D "regulator-fixed";
> >> +               enable-active-high;
> >> +               gpio =3D <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> >> +               pinctrl-names =3D "default";
> >> +               pinctrl-0 =3D <&vcc3v0_sd_en>;
> >> +               regulator-name =3D "vcc3v0_sd";
> >> +               regulator-always-on;
> >
> > This looks odd. A GPIO regulator being always on?
>
> This is a standard micro SD card socket that can also be used for
> booting the board. I wanted to be cautious and start
> working with it and several SD cards and explore the capabilities.
>
> On this board nearly all regulators are still continously
> switched on. I plan to remove the always-on properties step
> by step from the regulators when the board runs stable with it's
> components all enbled.
>
> >
> >> +               regulator-boot-on;
> >> +               regulator-min-microvolt =3D <3000000>;
> >> +               regulator-max-microvolt =3D <3000000>;
> >> +               vin-supply =3D <&vcc3v3_sys>;
> >> +       };
> >
> > Assumes this powers an SDIO embedded card. Often those have a specific
> > power sequence, just wanted to make sure the above are really
> > sufficient? No delays or external clock needed?
>
> It's not embedded, just a standard =C2=B5SD plug. It is already enabled
> by mainline U-Boot and ejecting and inserting the card works fine.

Ah, thanks for confirming.

Kind regards
Uffe
