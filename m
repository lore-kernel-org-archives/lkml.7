Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C712403F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f4xdf+vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfE2SNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:13:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37786 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE2SNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:13:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id i4so2473665oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gX2RMb1pokbu+YgF41RSMApGRERhvXQGphpzSmZubpo=;
        b=f4xdf+vPCxyZu4Hqkw+FoQgiJySxwGcEI4TfGDrIYVFodGV46rc5Ap4KbB5Qm3Ko4S
         iNKdL8CwC3UGq9rHNxO+RWQMu9DA5FmjngW4D78kOltgnY6rSAHQJK6T1uU+l1Oyqinx
         FHfPK9yXwdJcdTgrsB2fMNkPltmpVtsX48dSRBsqUjmwmgmLwBAjL2JlJvt/x7CvLjQ6
         LYcQxVHjUnRrc5e0zj/slp1tZHk9noniO0iI3rCtJRMvshYNiAFInO1mffaKEf858QEK
         gcGMHUS5h1rRLqagpIRF7fsyWt0xPA1twLUfvdqyHvDGjhXtun4P2Aw42nMwynZ+p3jg
         jaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gX2RMb1pokbu+YgF41RSMApGRERhvXQGphpzSmZubpo=;
        b=ArBGYQl6Ni9DG9tjPYD7jt6wVDKcvA5/bxQE/cX5yNwqT4UlLun+2ULGb7SqQ7IzHe
         k2up89SiYeDCYNZAFHzeQmdtdghEMbhC8KlCMcw/OcGS1vu2T0eNyv96Eyb+BpudmcpV
         hXIJJa9zhmCATzpadO0Y8jqh0s9c/INnbCnJs8n18TOiGVQJoa89hBipZBpRKz4R2M9g
         mibKSOBjvHRtmV6kTJvy/IvBfPXjYyfQuvWSA+CRnAo4pE8540GcZGItlKPZz3gZ0sWf
         ei3qVrnrpRjdNDUgm7OCpq7BWiDIZJVS0IFzUl5yaXtis7n+w12/0ACMtx7dmjZOuiD1
         v6CQ==
X-Gm-Message-State: APjAAAVORxOV5lm/8mAaPf54lqJDrZLb75lyrmAmTgk4Xy+Pkzw3vqTY
        bHrv8Eg7r8CAlONq70i85Ji3tLRWxOZvnzN7CXQ=
X-Google-Smtp-Source: APXvYqzjHZuuzE1Z4EhDnM0uKUidjspHW8yzeJYt383majPlmdFfHlRYLp+trb+xQVa1+dgkePYC6IMA7/C8FtzIWkA=
X-Received: by 2002:aca:f144:: with SMTP id p65mr7253057oih.47.1559153613854;
 Wed, 29 May 2019 11:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190527140206.30392-1-narmstrong@baylibre.com>
 <20190527140206.30392-4-narmstrong@baylibre.com> <7da1c182-db68-c813-1f3c-b936137deeb2@baylibre.com>
In-Reply-To: <7da1c182-db68-c813-1f3c-b936137deeb2@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 29 May 2019 20:13:22 +0200
Message-ID: <CAFBinCBjBRXMsvwiN0Hi4RHZ1VpU=2T3KnoN800N7FSy3_uBNQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: meson: Add minimal support for Odroid-N2
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, May 29, 2019 at 12:09 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 27/05/2019 16:02, Neil Armstrong wrote:
> > This patch adds basic support for :
> > - Amlogic G12B, which is very similar to G12A
> > - The HardKernel Odroid-N2 based on the S922X SoC
> >
> > The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> > most of the features and architecture, but with these differences :
> > - The first CPU cluster only has 2xCortex-A53 instead of 4
> > - G12B has a second cluster of 4xCortex-A73
> > - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
> > - CPU Clock architecture is difference, thus needing a different
> >   compatible to handle this slight difference
> > - Supports a MIPI CSI input
> > - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
> >
> > Actual support is done in the same way as for the GXM support, including
> > the G12A dtsi and redefining the CPU clusters.
> > Unlike GXM, the first cluster is different, thus needing to remove
> > the last 2 cpu nodes of the first cluster.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
> >  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 288 ++++++++++++++++++
> >  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
> >  3 files changed, 371 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> > index e129c03ced14..07b861fe5fa5 100644
> > --- a/arch/arm64/boot/dts/amlogic/Makefile
> > +++ b/arch/arm64/boot/dts/amlogic/Makefile
> > @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
> > +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > new file mode 100644
> > index 000000000000..48783ead8dfb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -0,0 +1,288 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 BayLibre, SAS
> > + * Author: Neil Armstrong <narmstrong@baylibre.com>
> > + */
> > +
> > +/dts-v1/;
> > +
>
> [...]
>
> > +
> > +     hub_5v: regulator-hub_5v {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "HUB_5V";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&vcc_5v>;
> > +
> > +             /* Connected to the Hub CHIPENABLE, LOW sets low power state */
> > +             gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> > +     usb_pwr_en: regulator-usb_pwr_en {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "USB_PWR_EN";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&hub_5v>;
> > +
> > +             /* Connected to the microUSB port power enable */
> > +             gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
>
> [...]
>
> > +
> > +&usb {
> > +     status = "okay";
> > +     vbus-supply = <&usb_pwr_en>;
> > +};
> > +
> > +&usb2_phy0 {
> > +     phy-supply = <&vcc_5v>;
> > +};
> > +
> > +&usb2_phy1 {
> > +     phy-supply = <&vcc_5v>;
> > +};
>
> In fact, I need to fixup here :
>
> usb2_phy1 needs &hub_5v and regulator-usb_pwr_en depends on &vcc_5v instead...
sounds fine for me because I don't see a better way for now

> @Martin, can I still keep your reviewed-by for v5 ?
yes, you can keep it

when you re-send it: can you please add a comment to the phy-supply in
usb2_phy1?
I have this in mind: "enable the hub which is connected to this port"
(imho this is a valuable hint together with the "CHIPENABLE" comment
that you already have inside &hub_5v and it helps to make it easier to
understand without having to test it on physical hardware)


Martin
