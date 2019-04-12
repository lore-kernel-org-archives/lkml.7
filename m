Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oR/JZ/T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDLNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:09:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39383 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:09:20 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so15355080ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WZlygUqsZx6dGbAisPeKZMzpR6wQAcrLvyXUEu8enHA=;
        b=oR/JZ/T/XDoEY1tF2sdUJcFYUApIdQdmEAnJloUX935kTPg4ozrzwSOvZEFBp6dsaO
         YicrU0mWg1mt7mln7nKKivNCPzsnIJsaBN9PbOksnOcXottiuMPcMfZMTaVGCCcidKZu
         5UvHUY8AvHYaFZuS2IhludoPwEGv61aSBWNvFDOUV/aK2bKPX4jDE+deYiDAAPbH/zy9
         sZ7yHqCfSUWewCohN82Q9EAHzH8I9mvOrQM0xeJ57YGvHaFcLHILl+6DQo/kihkBPxRG
         0I0WS224u5bFkgZwf8ThU/0w02QSia+7xyMs09wQaqP385MFauFHYTMAcd3S9FfGG6zd
         F52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZlygUqsZx6dGbAisPeKZMzpR6wQAcrLvyXUEu8enHA=;
        b=MeGnIN5epV4zkp8oXSOdhK9Jr+3Xexh9BrgPUZMQdrYlU7OYHqaSRIUd6Fnrs0qCOO
         N1r+NL4M9MNBu0zMr7b+j/pwZklMadFwPOdIXqHJbgjtTWWQo+lhnSzOqnYuJnqzKaVe
         +yokNAYwZDplt2c9nVXNqCcYCV+DKoC0m0pB4Sp0URc6hmUdXtHpky2PpTc+LiBqWjvp
         mOeb+pVX9ayfYKZbGu89SW3/y3oKsSINoo1hzYtHHr4JeS7WYXKspDC5wd/T2abNyxPu
         zSFEl8jXchhR1WLn2eiKrQrDI9CzcFUHYGg4woZUVgKFuczFI8l1pdb/3kjD/IrHNmXu
         2pqQ==
X-Gm-Message-State: APjAAAU0s1ApSrzWibBx6K8FnH/bfGr3SyidySTd5YBMqIj0PnSeSkxb
        y5Ox3RTCQ+wQ2Z23xvFWf0ZcfbKlHe+v21OE14wapQ==
X-Google-Smtp-Source: APXvYqwgpV170+MoBW4xyQYPzi+jzOmtmTHUS3tBVamUdw1A4PN5MbaxUFpxQKAW7r+IgenioRIVlztNy9YnueB9Edg=
X-Received: by 2002:a24:ad2:: with SMTP id 201mr12437574itw.26.1555074559532;
 Fri, 12 Apr 2019 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-3-brgl@bgdev.pl>
 <57fe079c-fd69-45ef-b4fb-a2c792218c21@ti.com>
In-Reply-To: <57fe079c-fd69-45ef-b4fb-a2c792218c21@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 15:09:08 +0200
Message-ID: <CAMRc=MepbkT06sJ39z726sRZWMfmgNk5CS_X5YVbk3T=G5Hjaw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: da850-evm: enable cpufreq
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 kwi 2019 o 15:06 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> > tps6507 pmic with configurable output voltage, so all operating points
> > can be enabled.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Adam, can you please ack? Looks good to me.
>

Actually I just noticed the commit message is no longer in line with
the changeset. I'll fix it in v4 shortly.

Bart

> Thanks,
> Sekhar
>
> > ---
> >  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-=
evm.dts
> > index f04bc3e15332..f94bb38fdad9 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -191,6 +191,19 @@
> >       };
> >  };
> >
> > +&cpu {
> > +     cpu-supply =3D <&vdcdc3_reg>;
> > +};
> > +
> > +/*
> > + * The standard da850-evm kits and SOM's are 375MHz so enable this ope=
rating
> > + * point by default. Higher frequencies must be enabled for custom boa=
rds with
> > + * other variants of the SoC.
> > + */
> > +&opp_375 {
> > +     status =3D "okay";
> > +};
> > +
> >  &sata {
> >       status =3D "okay";
> >  };
> > --
> > 2.21.0
> >
>
