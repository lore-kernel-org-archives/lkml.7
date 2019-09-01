Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F42262339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ2HR+ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfIAN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 09:57:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44647 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfIAN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 09:57:01 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so24087631iog.11;
        Sun, 01 Sep 2019 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlZdrf9Irxs4fo8S+BI75RsfTncmV298kgaHuNHnRpA=;
        b=SJ2HR+ZX4CCLpMwYVrMm4tC48zXsqIaDeOJpgI3Pu3aF57K2+/GDf7STWkbYhRe2jR
         7G6ODjRtP47aLxPmSBBqyyqGzi3KCb2cqBA399LgCItWnhLzUke/Y463BhS5rQjdJQTK
         1BkGi60BKBY0TjPWuG0De2lTR4hD+X4qFbNhpF9j+6ldhAF1FEkBqt5Oy8zEpeW1sj6g
         t3yKMcSIaRw2WJb4SzaAwvl8LSCsOy0JEyEOFMJYk4CAt+qCWeDjeABNCA6XWck+s3i4
         L+VsTBC+P8E3bxrBz+29duUA/AtUC8ML5kSvPq7G7g0DIxZN8tFz+7M4fUgzRKVWscmj
         GAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlZdrf9Irxs4fo8S+BI75RsfTncmV298kgaHuNHnRpA=;
        b=jlRLyVuDVnDbLn+44Ae7SJt2vap+3sv+H4WU7xAhRD7t40JrBJl+MvV65amLB8S7pe
         S0AVzugcVCZVun2cuGmEpVpuwor8USqkhh9BFasTE7s2l/jznCZoXbIfnKl6Mb1HzJ0q
         16/vT8MDWyZVb2PSDB9Y6RX14ziJm2meNXcTtiB+DU2dCBBJdIWSl7KKPyp0HXh4YBC5
         wbZpn4BtbRA0/4fwcqcRKSigi+71GJQKDM+QC8K3HbznTDOs9uBHImE/vVhWk1nNdpDQ
         Y/Sqq+sVwiS6DDPd+nQIwya4dWLbqr89i5XkyEcuhm2uq7S5XbnQJAMNyWqJEFuDsLMU
         9F5A==
X-Gm-Message-State: APjAAAUFzk6NsbZAUAEvfE+BJEljMDwAUiODOKlhWd/gqbOFFESurGvf
        +5GrjzH6KrcJ+bjgPPCIY5h/YsIRaYM5sD1i318=
X-Google-Smtp-Source: APXvYqxYOm/Hc/RFqCzlkxBEZ30dho7qz2hnto+SyaO5xK9jP5vx8O05CRf6dpJlVvYT87HcbjJnLhCQXciWgSqFGEw=
X-Received: by 2002:a6b:c810:: with SMTP id y16mr5973464iof.75.1567346220862;
 Sun, 01 Sep 2019 06:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-3-linux.amoon@gmail.com>
 <CAFBinCBA-sQcshd9iAVn=ZDBKkDN3OgJs-WjKEhVLw===b0AdQ@mail.gmail.com>
In-Reply-To: <CAFBinCBA-sQcshd9iAVn=ZDBKkDN3OgJs-WjKEhVLw===b0AdQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 1 Sep 2019 19:26:47 +0530
Message-ID: <CANAwSgTXWgcyzsU1Y6Msc4hyuRh7QPoXe9WsV5uqNc=c9_z2TA@mail.gmail.com>
Subject: Re: [PATCHv1 2/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to VDDIO_AO3V3 regulator
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks of your review comments.

On Sun, 1 Sep 2019 at 17:11, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per shematics TFLASH_VDD, TF_IO, VCC3V3 fixed regulator output which
> typo: "schematics"
>
Ok
> > is supplied by VDDIO_AO3V3.
> please add a short sentence to the description (since you probably
> have to re-send a v2) like:
> "While here, move the comment name with the signal name in the
> schematics above the gpio property to make it consistent with other
> regulators"
>

Ok I will append this in next version.

> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> with the patch rebased (see below) and the two issues from above addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index 98e742bf44c1..a078a1ee5004 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -67,17 +67,19 @@
> >         };
> >
> >         tflash_vdd: regulator-tflash_vdd {
> > -               /*
> > -                * signal name from schematics: TFLASH_VDD_EN
> > -                */
> >                 compatible = "regulator-fixed";
> >
> >                 regulator-name = "TFLASH_VDD";
> >                 regulator-min-microvolt = <3300000>;
> >                 regulator-max-microvolt = <3300000>;
> >
> > +               /*
> > +                * signal name from schematics: TFLASH_VDD_EN
> > +                */
> >                 gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
> >                 enable-active-high;
> > +               /* U16 RT9179GB */
> > +               vin-supply = <&vddio_ao3v3>;
> >         };
> >
> >         tf_io: gpio-regulator-tf_io {
> > @@ -95,6 +97,8 @@
> >
> >                 states = <3300000 0
> >                           1800000 1>;
> > +               /* U12/U13 RT9179GB */
> > +               vin-supply = <&vddio_ao3v3>;
> >         };
> thank you for the patch but I think it won't apply on top of Neil's
> "arm64: dts: meson: fix boards regulators states format" (which was
> applied just after you sent this series)
>

>
> Martin

Ok will re-base these changes on linux-next next time.

Best Regards
-Anand
