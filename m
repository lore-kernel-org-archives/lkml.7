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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78293C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A84F233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUPioWUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfIAN63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 09:58:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35509 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfIAN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 09:58:29 -0400
Received: by mail-io1-f68.google.com with SMTP id b10so24216447ioj.2;
        Sun, 01 Sep 2019 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/cxPVZ2/l0a8YIvCXybq//eIUrfVE+ZOnB/0gkvzVI=;
        b=OUPioWUhBIZDB2dqmcRtby+CVstmCh3T7AjdOQuU3lxM5DpyAyhQoqygbq+LjXnlVt
         pxq3M0bnuMbmiHbpQVUlcrj0J5dH3UX6ZNt3Tua6YHqpNGEr4fhskrTYQrGH2ndYrdnI
         Hu2CzCWi323aqNBO9FrIf7c1cOGMKpUC0S+hLVvSOBXYgxTUQRJ9zeM5nDJENBzPDpIy
         tk0XruVKlM4ZRg0bDdapG05nSXqUyiOVWeNuleQfF1clP7S1ZxPnAmwvAZ8uxMPhjnCY
         8KZLeotoUVi9OlY4Y+Nnvgp3t2MNYEN0AIS+0FeDDMd3ecmTuNxd9pbYMi86vgMv/AiF
         EteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/cxPVZ2/l0a8YIvCXybq//eIUrfVE+ZOnB/0gkvzVI=;
        b=L7YZDJX5Ie9xfm0a4WFgJfg/Kg70kc1Y6OW+Ik6spU5nX+6LzGxycNQkht0v8XgzUC
         Zt9oclcckgSHgEO5OCjBJIPh0TXVo5AhnjGphJ+ueDRHd3Nt8M8Klv6ryvB7NNZZzJIA
         9wzMuUV1V8xHChx2FhHacbsUbW7DyZrqSXynpPadz8jrKHZPhGpBp6FZg/zLyfvCzykU
         595oqGn3URp25d97CltxbAIhch3I1fnQ+OCyqw6H4AcYsp6e2Bp/quaiskQ7QXPfBKdX
         lkIRjaM0gJ+XWxYKJ5TM3r1teu5CbAK9kMBqa/8Q6N9o30W0gY6XtBrebG59eYdW7l6P
         2PKg==
X-Gm-Message-State: APjAAAVmO6PGTGUx+Zkdru34CRE6jb4vT/QsuCTpQReBG5Gg18s1CuP7
        MGa0+WBejBzbSpkSG34KWMFn3RHNxX7/f8wpuv4XaQ==
X-Google-Smtp-Source: APXvYqx1T5rFEQe6gKYnb6Zc83oGlevxTISfBjsjjxv9Vx2xPyRReQNYrCAH8EUo+T85H50o406WImhEOyF0jyTzAGY=
X-Received: by 2002:a5d:9bd4:: with SMTP id d20mr103670ion.243.1567346308370;
 Sun, 01 Sep 2019 06:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-4-linux.amoon@gmail.com>
 <CAFBinCB9NPtncyJCMWDbbzJnQafeaY5U3XHh=NuRZSCNDdO=Hg@mail.gmail.com>
In-Reply-To: <CAFBinCB9NPtncyJCMWDbbzJnQafeaY5U3XHh=NuRZSCNDdO=Hg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 1 Sep 2019 19:28:14 +0530
Message-ID: <CANAwSgT_K8oqwrxaQr0j_nyxZdh=Um5ivjoUDBixxWPbqJyYcA@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to HDMI supply
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

On Sun, 1 Sep 2019 at 17:14, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per shematics HDMI_P5V0 is supplied by P5V0 so add missing link.
> typo: "schematics"
>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index a078a1ee5004..47789fd50415 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -213,6 +213,8 @@
> >         status = "okay";
> >         pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> >         pinctrl-names = "default";
> > +       /* AP2331SA-7 */
> > +       hdmi-supply = <&p5v0>;
> >  };
> my understanding based on odroid-c2_rev0.1_20150930.pdf is that:
> - there's a (fixed) hdmi_p5v0 regulator using p5v0 as input
> - the hdmi_p5v0 is the hdmi-supply
>
> it doesn't change the functionality of this patch (since both supplies
> are fixed regulators anyways)
> you are already doing a nice cleanup with this series, so it would be
> a shame to take a shortcut here
>

I could not find gpio control pin which could be used to enable
hdmi-supply node.
So that the reason for direct linking this to p5v0 node.

But looking back at the schematics it and datasheet their are two more
regulator supplies to HDMI.

HDMITX_AVDD33-1 ---- VDDIO_AO3V3
HDMITX_AVDD18-1 ---- VCC1V8

Need to check the hdmi driver if these need to enable.

Best Regards
-Anand

>
> Martin
