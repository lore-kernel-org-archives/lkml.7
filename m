Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF21C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C041721900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NaBXqyUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfCURNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:13:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44663 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfCURNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:13:37 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so5863358iop.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OydQ3I+eSUcbumeta8J04huPgRBJ+5IOsbO/9ZBLyjo=;
        b=NaBXqyUxvnvgI9YDpQxLCTrBg/w0oUtCTUZMlXh+3DPZBPekmkIPw/ryl+lkd5ppqf
         BIuSh2tHS7RiI2dX1TfcfpgI1K0qKtN5Isjbl4UAAvpnGY8lnOvoXAXBeUN8CO1iyFnf
         91WXGqQygyB48Z48U3aurIICwO8tKwSTFmkDazkKZh/2eK9tZrLYOZslvykG2TGBxcM2
         FdEqslBQqfs8p0Jlc2U9wtsK6C27+fXeBcTHUewFRful9hkIiA4tBNRJcc5yfYl8YPEx
         6QkUd/qPtAozUp7GzupgvutkP2loXcbv700OXap72sEiftOe3NH4O6ziwosM+bz2+8a+
         NPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OydQ3I+eSUcbumeta8J04huPgRBJ+5IOsbO/9ZBLyjo=;
        b=SqcWl0COIjlm/oDRY+SVnh8ptOwNCMDslF3xzH7DzlePVP5Mwj6j3dV8VtFfvdrdYF
         HZWz+82yH/oLAxkbQZk9o8re4khJXgEHtOR0HcR2gzUF3PCVH+Ih6YqmpIGA+U4wWDhJ
         1o8ZRi9P+/OKyTzIUIWuWjnGOZRK7WF9dmr+JF2QkuDa8FGgKUMXSwbsdTm6u5UloXYJ
         q8d3xL0SvJMbhOviBhhlj0nx4bAigFyJDEideWXdzNMX53MASJPLBqytL0+r4loN7+B4
         /ieCUB2jf7kU9gmATNBctdbhudwReLoKaWEQ0chm+E6fWEABDzflOPWOf+N76tmeB/gK
         gjRQ==
X-Gm-Message-State: APjAAAXvR1/qLxeMDE+8utQN/oq76WE2x5Qw8TdJtjDAUAVQzVNeZh4b
        eCIYla+Bdjw50SEzDOEbIBYLe59lS6egH4HFCF/dGA==
X-Google-Smtp-Source: APXvYqyTfixgP6aHBwz6RG9WrgEZ/N39EEfGi4dxeR/6yWut+Hlv+UzCJDd7/dyeZT9CmuqMArXxfATWfnVcv4/fJhQ=
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr3566103iol.187.1553188416010;
 Thu, 21 Mar 2019 10:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190321141010.19612-1-brgl@bgdev.pl> <20190321141010.19612-4-brgl@bgdev.pl>
 <06c6fe16-eb33-960c-909a-635e70c3b976@lechnology.com> <CAMpxmJWDn9-W6wGTyZdAHJJnp8vHysNHNcL+qqKMRss664MhrQ@mail.gmail.com>
 <CAMpxmJUT7Rc5noOAKZsoaN--hu14wQTujnH_6v8TWiO=KufNhg@mail.gmail.com>
In-Reply-To: <CAMpxmJUT7Rc5noOAKZsoaN--hu14wQTujnH_6v8TWiO=KufNhg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 21 Mar 2019 18:13:25 +0100
Message-ID: <CAMRc=MfFqYJnfgA=Ku-mpYv_NQz2BhsBvXtwpKufScob+YT_Og@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
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

czw., 21 mar 2019 o 17:44 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> czw., 21 mar 2019 o 17:36 Bartosz Golaszewski
> <bgolaszewski@baylibre.com> napisa=C5=82(a):
> >
> > czw., 21 mar 2019 o 16:53 David Lechner <david@lechnology.com> napisa=
=C5=82(a):
> > >
> > > On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Enable cpufreq-dt support for da850-evm. The cvdd regulator is fixe=
d
> > > > at 1.2V on this board so disable the lower operating points and ena=
ble
> > > > the 375MHz opp.
> > >
> > >
> > > The board-da850-evm.c file seems to indicate that this regulator is
> > > variable and comes from the tps65070. This regulator seems to be miss=
ing
> > > from the device tree though, even though it has device tree bindings.
> > >
> >
> > Oh snap, you're right. I glanced over the 1.2V comment and thought
> > it's the same as other boards, but actually it specifies: .min_uV =3D
> > 950000, .max_uV =3D 1350000, so all the operating points should work on
> > that one.
> >
>
> It seems this pmic is defined here[1] and a skeleton included here[2]
> and then the regulator constraints follow.
>
> Bart
>
> [1] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/da85=
0-evm.dts#L224
> [2] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/da85=
0-evm.dts#L326
>

Ok I retested and the patch will look like this:

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.=
dts
index f04bc3e15332..a0a1b3dccf37 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -191,6 +191,18 @@
         };
 };

+&cpu {
+        cpu-supply =3D <&vdcdc3_reg>;
+};
+
+&opp_375 {
+        status =3D "okay";
+};
+
+&opp_456 {
+        status =3D "okay";
+};
+
 &sata {
         status =3D "okay";
 };

I'll resend the whole series tomorrow to not spam Sekhar's mailbox anymore.

Bartosz

> > Bart
> >
> > > Cc: Adam Ford
> > >
> > >
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >   arch/arm/boot/dts/da850-evm.dts | 30 ++++++++++++++++++++++++++++=
++
> > > >   1 file changed, 30 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da=
850-evm.dts
> > > > index f04bc3e15332..f63867692da4 100644
> > > > --- a/arch/arm/boot/dts/da850-evm.dts
> > > > +++ b/arch/arm/boot/dts/da850-evm.dts
> > > > @@ -151,6 +151,15 @@
> > > >                       system-clock-frequency =3D <24576000>;
> > > >               };
> > > >       };
> > > > +
> > > > +     cvdd: regulator0 {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             regulator-name =3D "cvdd";
> > > > +             regulator-min-microvolt =3D <1200000>;
> > > > +             regulator-max-microvolt =3D <1200000>;
> > > > +             regulator-always-on;
> > > > +             regulator-boot-on;
> > > > +     };
> > > >   };
> > > >
> > > >   &ecap2 {
> > > > @@ -191,6 +200,27 @@
> > > >       };
> > > >   };
> > > >
> > > > +&cpu {
> > > > +     cpu-supply =3D <&cvdd>;
> > > > +};
> > > > +
> > > > +/*
> > > > + * DA850-EVM has a fixed CVDD of 1.2V - we cannot go below 300MHz =
or
> > > > + * above 375MHz.
> > > > + */
> > > > +
> > > > +&opp_100 {
> > > > +     status =3D "disabled";
> > > > +};
> > > > +
> > > > +&opp_200 {
> > > > +     status =3D "disabled";
> > > > +};
> > > > +
> > > > +&opp_375 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > >   &sata {
> > > >       status =3D "okay";
> > > >   };
> > > >
> > >
