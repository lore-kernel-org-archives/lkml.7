Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7334DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A30720863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fPQsvYSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391074AbfEXQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:58:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54149 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390511AbfEXQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:58:16 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so16889035ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MoMLCOnVhZSHe+BQlTmS5wevE0lJU4Hf7dR7NZTK0SA=;
        b=fPQsvYSJ7q6ZkPN90gdwNY/gQFwW2BaNnP1VwwHH5cSJOM97xQcxAYi/ejEfDdwLUF
         trMZf7pzYgvhyTAZInqDKQOFn1cyKxmEpjkQK/1MUgGJc0EAk98MHydqd/Rdfqiv4HO9
         0rzP7L2tUL2e9UyqcDSFdQltXMrBWBEkqmq1WYe0nGW3kz2bpvkXi25HzKwgIlvyH5RA
         VhfUn2vUXnc2+nxXtlMk7B4ydxKMwlCRIVALMRSTz1D28y7y0KGdSVXiZ4HuPtqH4r8F
         fXM8PL4o8NK3EDm4JmW8FvSjtq3NyfUr4q7VH32Jc1vVX7mKV+4JyWwiGh+JRSiP6zOn
         JKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoMLCOnVhZSHe+BQlTmS5wevE0lJU4Hf7dR7NZTK0SA=;
        b=Clk+QnqfH752Erok8WlT/LgqnGoNyZWrj4axSMIqMbkzw4HkdzM8iLEpK+P/AapxmL
         PsyQ8Tw57p18niCL3BFNXFCY8Kg/XxLfVaomoqzqea+ITN/89zHvAomaxKgndzCAGGJN
         pI+akUQkunOVBps03uUx3koumUH/yGivx2KZGxe50+7K5HG8AyEgTy3HwIhE+nP499A5
         qxW4V54Jx6rK998cbaBLsOaluZGlX35/a6wgx/oAt0262hkwN0wXj034EGyTWamkp+jJ
         4zYNQUDydqiZeWRR6VXCXcW1d8xhvEz7IWkZWhAFeYJSj2vrj1cfSUsMztBffJhmo3Mu
         Vn2g==
X-Gm-Message-State: APjAAAX/c7Ie2nPKigq7bewJGltcW6x93wqU3kyh74eCXZeiCSr1Zr/0
        Jz+kgazOQW5+6DJNsmDASfR8kM6CGMlj2ySqDiTet8Cj
X-Google-Smtp-Source: APXvYqzKAKOCGT1463jp43t7UOHxZ8/WT2omEyVHLyOVE3HNbV4Ak5HVMslMSUYhRfOX/SuzDLSdg7lxhnGTI3w9lSk=
X-Received: by 2002:a05:6638:233:: with SMTP id f19mr6778463jaq.24.1558717095212;
 Fri, 24 May 2019 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190417152701.23391-1-brgl@bgdev.pl> <20190417152701.23391-5-brgl@bgdev.pl>
 <CAHCN7xKVaYqd5LLvRx7i8ik+JnTFdpexZf2WXt0R2N1W1skOJA@mail.gmail.com> <CAMpxmJW9yWcQ8497OwOhMN8wj-Cmc3-UP7Rh-yoU_uDaQkVVSw@mail.gmail.com>
In-Reply-To: <CAMpxmJW9yWcQ8497OwOhMN8wj-Cmc3-UP7Rh-yoU_uDaQkVVSw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 24 May 2019 18:58:04 +0200
Message-ID: <CAMRc=Me9hwsLdpDVfs+cb_rqrWs=+bJOa9nEFY+xs_vs5LAXXA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Adam Ford <aford173@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 kwi 2019 o 11:15 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> =C5=9Br., 17 kwi 2019 o 19:09 Adam Ford <aford173@gmail.com> napisa=C5=82=
(a):
> >
> > On Wed, Apr 17, 2019 at 10:27 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> > > tps65070 pmic with configurable output voltage. By default da850-evm
> > > boards support frequencies up to 375MHz so enable this operating
> > > point.
> >
> > Have you done any testing with the LCD on any of the devices you have?
> >
> > I enabled the ondemand governor, and I got a bunch of splat from the
> > LCD controller:
> >
> > tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> > differs from the calculated rate (54000000Hz)
> > tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> > tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> > ... [ snip]
> > tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> > differs from the calculated rate (54000000Hz)
> > tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> > differs from the calculated rate (54000000Hz)
> > tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> >
> > It appears to go on forever.  I don't necessarily want to hold it up,
> > but I don't know the clocking system well enough to know where to go
> > investigate it.  I can certainly live without ondemand.  Using
> > userspace as the default governor is fine for me for now.
> >
> > adam
>
> Hi Adam,
>
> I did test the tilcdc on da850-lcdk. The only message I'm getting
> during transitions is a single:
>
> tilcdc <name>: tilcdc_crtc_irq(<address>): FIFO underflow
>
> but this is fairly normal - we also get this during modeset and it
> doesn't affect the display.
>
> The problem with the pixel clock may come from the bootloader - are
> you using a recent version of u-boot?
>
> Bart
>
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > Reviewed-by: Adam Ford <aford173@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da85=
0-evm.dts
> > > index f04bc3e15332..f94bb38fdad9 100644
> > > --- a/arch/arm/boot/dts/da850-evm.dts
> > > +++ b/arch/arm/boot/dts/da850-evm.dts
> > > @@ -191,6 +191,19 @@
> > >         };
> > >  };
> > >
> > > +&cpu {
> > > +       cpu-supply =3D <&vdcdc3_reg>;
> > > +};
> > > +
> > > +/*
> > > + * The standard da850-evm kits and SOM's are 375MHz so enable this o=
perating
> > > + * point by default. Higher frequencies must be enabled for custom b=
oards with
> > > + * other variants of the SoC.
> > > + */
> > > +&opp_375 {
> > > +       status =3D "okay";
> > > +};
> > > +
> > >  &sata {
> > >         status =3D "okay";
> > >  };
> > > --
> > > 2.21.0
> > >

Hi Adam,

did you figure out the problem by chance? Are you OK with merging this seri=
es?

Bart
