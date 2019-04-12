Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F043C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5EA20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tqmWMvB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDLOXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53680 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfDLOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:16 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so15973132itf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrDH57bQG2o4KJBrG5k5zmJiTn+4+uR9TaQNTiUy5d0=;
        b=tqmWMvB04VikQpMZ2UJAt1JWG7VbHL7jzZSPvCv9KZ405cX1x/R2TD/IxQin+A+lDs
         gRKjk5qLoJteOwowOZdUtxD1PDBNy8wd56U4yUOyREbIpZV9FzBpLhp94Rbynqqwl7/n
         6MECerG7c3hUR/SBHfqyhbDNFres8+sLUV+VGX9SBvP+1pB23jIy8QxjLdwcmLRA7lFV
         vMOH4QzYPU9tWcBrusTu3n/nhCbnjaOw1WRwvyYyNt1GmHrKqitwAz4vNsQF8unBuKEB
         ThJyU8i1Mud6vQ7KSTyenV1DlHEezxrQRVUFeg4EylyTQLtuVljIcFRG9C8Ex0O58VPb
         mfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrDH57bQG2o4KJBrG5k5zmJiTn+4+uR9TaQNTiUy5d0=;
        b=Z3/CcPFMqVk0jL1Pm4rOk7HsYx9UKCRrcX6pMdE0AdzADy+vqQ3ly79Mh11HLg0vwW
         9n9vQvVJ/lKQJpUaxX1Ajf1qqcFuy3pyy+icabV+e3pHoKixmADLiXMnpwZRNTYGuxWP
         DmwyHBmOedJnZiTMn0ygnhCxF4TB0Vw5g5dzFNU9cQy/cP6iafP1a25RG3z+OvOupofn
         DFVzgX+czbUMnovd1t89P1S6nKk3zrWl8fnNU2iOCsBAEpchl7VYcWvhQ2rh1v/LgAkJ
         qfP0gLa/+63YBtq6o6p1b67rqW+Szo3YrfUi3I/cx7FMUpRbiL9useoeD21dQfTErY7o
         bBeQ==
X-Gm-Message-State: APjAAAXTjDLsO7SnQtgeawmCPIyrmf9XLzg4vmM7L0a2Wf1DbdUhpz5k
        WyQpCI3EkiX3IEdMcSwMJ9UCwka0DCOPD3sbFbuxhg==
X-Google-Smtp-Source: APXvYqy94lzP4DxCRk/dbaMFBvfm3+thim2vYOADaTGL1LvG2eOW9qwD3NjA/Xh9yU0qniQVNWmNhR1Ogm14J3mIisI=
X-Received: by 2002:a02:5bc2:: with SMTP id g185mr40046106jab.31.1555078995393;
 Fri, 12 Apr 2019 07:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-3-brgl@bgdev.pl>
 <57fe079c-fd69-45ef-b4fb-a2c792218c21@ti.com> <CAHCN7x+BpuuNnV+wteD=JBwuYF3z7EDD4kig26Kj4rOdJcW+LA@mail.gmail.com>
In-Reply-To: <CAHCN7x+BpuuNnV+wteD=JBwuYF3z7EDD4kig26Kj4rOdJcW+LA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 16:23:04 +0200
Message-ID: <CAMRc=MfTytX=8L8BrNKXGhiutxWj8i84wX-5agh=EWA-AZe1Pw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: da850-evm: enable cpufreq
To:     Adam Ford <aford173@gmail.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 kwi 2019 o 15:59 Adam Ford <aford173@gmail.com> napisa=C5=82(a):
>
> On Fri, Apr 12, 2019 at 8:06 AM Sekhar Nori <nsekhar@ti.com> wrote:
> >
> > On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> > > tps6507 pmic with configurable output voltage, so all operating point=
s
> > > can be enabled.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Adam, can you please ack? Looks good to me.
>
> Sekhar,
> Based on what I read in the thread about the LCDK, I want to do some
> tests on the da850-evm before put my name on it.  I like what I see in
> general, so I am excited to this this here.
>
> Bartosz - which kernel branch should I use as a starting point to apply t=
hese?
>

Upstream v5.1-rc4.

Bartosz

> adam
> >
> > Thanks,
> > Sekhar
> >
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
> > >       };
> > >  };
> > >
> > > +&cpu {
> > > +     cpu-supply =3D <&vdcdc3_reg>;
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
> > > +     status =3D "okay";
> > > +};
> > > +
> > >  &sata {
> > >       status =3D "okay";
> > >  };
> > > --
> > > 2.21.0
> > >
> >
