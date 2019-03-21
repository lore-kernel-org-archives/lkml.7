Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E882183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f4OneVWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfCUQoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:44:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41288 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCUQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:44:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so5129785oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c253zTARKFb19mRQCljAnAcD7xr/VEPDG/k7eMQBX5k=;
        b=f4OneVWDuc6BYxGskMWuTp1Y6JvuoFFzC7xoEKsuvNPNTTJ4+dvjtWN5NICAdZ/Io7
         JpNlu3241T+AKkPZRrfacyKhnsK9ez7TplQjSE2rHD0BbxFpnspS05UhniFtsJRLW0kh
         SQCXYpjRBuNnsEkZ21QoTZxwtX5zYa4Vjb+E1vyStvoMQkez+OQi3dsXcv+VFn/ycTv5
         EA4tvQB6D4TVWck/1SJ/22PFOQFQ4EunO6HPrNlaNMwDtrzb3MkCJo+D2EL1Om0kB7zs
         VSdAwkO6fQZvgnInSwrq6Jlh5bQ9zqsTeJ3dxg3ptL0vECy/qQM48BsQP5gsOP5PBNf7
         UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c253zTARKFb19mRQCljAnAcD7xr/VEPDG/k7eMQBX5k=;
        b=fKwIbx2z67nxSlBsQmRWeJz1sj7Z6Ptg0bN94cOR96WLYPIu/aYczyOJI0sdTzVWy7
         Ea53vP5VKWjl+XR9NMdEsktU9PYgU+XBvxBbz4x2vwSvwqyitVyODaqjn60yTlV/4BxF
         uQXJV1LhHzXzCfpv8opMFN+PwTknKYilsQbaCSCKELeOAABsGvzA5b+sv6ddZDnGcIKG
         nk+5vbb42dPPGA8k56AZrb4GO5yITZCAGLlEbh/FIIW8rLD60kJ/6OyVEoEDDxjTv5Wt
         5slxy2ZsDBpf+I27n12rPEl8Lw2fp70hWkOUO7z86FVejI2RV3GbXhe7QODprgy7bXqQ
         HNOg==
X-Gm-Message-State: APjAAAWNg8DjHp8D0VRp2DJS0N1pk/sdPztvry+UizfbbAg6a+8/RKHA
        mpHrNFdFr+Ym5yA+LkMwATfC7DD8wmohs6D6r3i9Hg==
X-Google-Smtp-Source: APXvYqxO+jxEfk+7D39nCQluStBGJRAsjmkVH4Fpn7RFlrt+C/MBdcZ4OeuTkFZ7tBoywuHxnWP2Vt/VkWKomE5WESc=
X-Received: by 2002:aca:5843:: with SMTP id m64mr165437oib.114.1553186647097;
 Thu, 21 Mar 2019 09:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190321141010.19612-1-brgl@bgdev.pl> <20190321141010.19612-4-brgl@bgdev.pl>
 <06c6fe16-eb33-960c-909a-635e70c3b976@lechnology.com> <CAMpxmJWDn9-W6wGTyZdAHJJnp8vHysNHNcL+qqKMRss664MhrQ@mail.gmail.com>
In-Reply-To: <CAMpxmJWDn9-W6wGTyZdAHJJnp8vHysNHNcL+qqKMRss664MhrQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 21 Mar 2019 17:43:55 +0100
Message-ID: <CAMpxmJUT7Rc5noOAKZsoaN--hu14wQTujnH_6v8TWiO=KufNhg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: da850-evm: enable cpufreq
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 21 mar 2019 o 17:36 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> czw., 21 mar 2019 o 16:53 David Lechner <david@lechnology.com> napisa=C5=
=82(a):
> >
> > On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Enable cpufreq-dt support for da850-evm. The cvdd regulator is fixed
> > > at 1.2V on this board so disable the lower operating points and enabl=
e
> > > the 375MHz opp.
> >
> >
> > The board-da850-evm.c file seems to indicate that this regulator is
> > variable and comes from the tps65070. This regulator seems to be missin=
g
> > from the device tree though, even though it has device tree bindings.
> >
>
> Oh snap, you're right. I glanced over the 1.2V comment and thought
> it's the same as other boards, but actually it specifies: .min_uV =3D
> 950000, .max_uV =3D 1350000, so all the operating points should work on
> that one.
>

It seems this pmic is defined here[1] and a skeleton included here[2]
and then the regulator constraints follow.

Bart

[1] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/da850-=
evm.dts#L224
[2] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/da850-=
evm.dts#L326

> Bart
>
> > Cc: Adam Ford
> >
> >
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >   arch/arm/boot/dts/da850-evm.dts | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da85=
0-evm.dts
> > > index f04bc3e15332..f63867692da4 100644
> > > --- a/arch/arm/boot/dts/da850-evm.dts
> > > +++ b/arch/arm/boot/dts/da850-evm.dts
> > > @@ -151,6 +151,15 @@
> > >                       system-clock-frequency =3D <24576000>;
> > >               };
> > >       };
> > > +
> > > +     cvdd: regulator0 {
> > > +             compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "cvdd";
> > > +             regulator-min-microvolt =3D <1200000>;
> > > +             regulator-max-microvolt =3D <1200000>;
> > > +             regulator-always-on;
> > > +             regulator-boot-on;
> > > +     };
> > >   };
> > >
> > >   &ecap2 {
> > > @@ -191,6 +200,27 @@
> > >       };
> > >   };
> > >
> > > +&cpu {
> > > +     cpu-supply =3D <&cvdd>;
> > > +};
> > > +
> > > +/*
> > > + * DA850-EVM has a fixed CVDD of 1.2V - we cannot go below 300MHz or
> > > + * above 375MHz.
> > > + */
> > > +
> > > +&opp_100 {
> > > +     status =3D "disabled";
> > > +};
> > > +
> > > +&opp_200 {
> > > +     status =3D "disabled";
> > > +};
> > > +
> > > +&opp_375 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > >   &sata {
> > >       status =3D "okay";
> > >   };
> > >
> >
