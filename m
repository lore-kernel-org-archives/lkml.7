Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBE9218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zElWdr6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfCUQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:36:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41648 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:36:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so1409120otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31a6JzuULDRek2GS3CNpr43zGA6fpbqhLQMwKfTtdgQ=;
        b=zElWdr6iGPRTrvZjoN9Qk3Fw52DEgMC0f3PGs+aM9belyghek/o0Xl9u9riz7MaHd5
         tP2KJizvEq7i7DT72iffM5UWq+sDvyiZ7S2tsSgnRQHVRz0U1W1FvledIJDDhYGF1/q8
         tt5N6ZgWPnQvMg11KZWcj3DjZp7cPv+zPqjociMUIv24QqlZvM3ePYZLq/DdSs2Hfv4i
         VgPtDCmbQCIvrCcg+7xQk77VdTfwsUXoW8uX+re+nObFub2FsdZCM/zm0Oa1PiPfh9Zh
         KFFRXxWT+dA/Gd460bjOD0DgVaRQRCQtCwubk21/0nHt4IHjk55kMBxMBCJsRnssg3Al
         /1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31a6JzuULDRek2GS3CNpr43zGA6fpbqhLQMwKfTtdgQ=;
        b=oZEEGtabTUNKxVRuMcq9w9D3wpd9bMKzoAbUOlUPjzTZrhu/l+oO+rPc00yATR5kOj
         Iq22AveYy4AW1fpVkZWhd+eWAFa0K6tCufVd4Er4c6w1iWvHf7JN1xXs1WOpIEhxVFjo
         b+UtMQNUvu5zbxU6WEM/CZ++4ujCjKYBxR6V22Jl7aDKIGAwJkkty5i03ONg9QJ+2DIm
         2YwPMfygFL950ZEk+lflUsli/Qhxa0nswN/BKTH2XihAhTFlg3nQ+L1ffdlZcL2hcRSn
         uIKc7SoaL2cS4cbw7h3u6LX1dg+H1KCltiUu3htuGYMT4zll3RbFaDRJuE8MWok2yz2k
         ejLw==
X-Gm-Message-State: APjAAAXpCi6hasXol9m7TsowXIi5yhwPYum79xVb99l+W20F/DL4grlC
        HFpJdewJ198tVWx6YsTQuLt9rtN9k46IEMuHMUt6hA==
X-Google-Smtp-Source: APXvYqxyUGuKoWTIJI2uDKc2hJTzmyAzXqXwwbfEX0923fsq4MrXraZbOs1O1EmmltqUox5V9SAAxt9wJ9qndlKDdwE=
X-Received: by 2002:a9d:3635:: with SMTP id w50mr2962378otb.301.1553186176691;
 Thu, 21 Mar 2019 09:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190321141010.19612-1-brgl@bgdev.pl> <20190321141010.19612-4-brgl@bgdev.pl>
 <06c6fe16-eb33-960c-909a-635e70c3b976@lechnology.com>
In-Reply-To: <06c6fe16-eb33-960c-909a-635e70c3b976@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 21 Mar 2019 17:36:05 +0100
Message-ID: <CAMpxmJWDn9-W6wGTyZdAHJJnp8vHysNHNcL+qqKMRss664MhrQ@mail.gmail.com>
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

czw., 21 mar 2019 o 16:53 David Lechner <david@lechnology.com> napisa=C5=82=
(a):
>
> On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Enable cpufreq-dt support for da850-evm. The cvdd regulator is fixed
> > at 1.2V on this board so disable the lower operating points and enable
> > the 375MHz opp.
>
>
> The board-da850-evm.c file seems to indicate that this regulator is
> variable and comes from the tps65070. This regulator seems to be missing
> from the device tree though, even though it has device tree bindings.
>

Oh snap, you're right. I glanced over the 1.2V comment and thought
it's the same as other boards, but actually it specifies: .min_uV =3D
950000, .max_uV =3D 1350000, so all the operating points should work on
that one.

Bart

> Cc: Adam Ford
>
>
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/arm/boot/dts/da850-evm.dts | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-=
evm.dts
> > index f04bc3e15332..f63867692da4 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -151,6 +151,15 @@
> >                       system-clock-frequency =3D <24576000>;
> >               };
> >       };
> > +
> > +     cvdd: regulator0 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "cvdd";
> > +             regulator-min-microvolt =3D <1200000>;
> > +             regulator-max-microvolt =3D <1200000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> >   };
> >
> >   &ecap2 {
> > @@ -191,6 +200,27 @@
> >       };
> >   };
> >
> > +&cpu {
> > +     cpu-supply =3D <&cvdd>;
> > +};
> > +
> > +/*
> > + * DA850-EVM has a fixed CVDD of 1.2V - we cannot go below 300MHz or
> > + * above 375MHz.
> > + */
> > +
> > +&opp_100 {
> > +     status =3D "disabled";
> > +};
> > +
> > +&opp_200 {
> > +     status =3D "disabled";
> > +};
> > +
> > +&opp_375 {
> > +     status =3D "okay";
> > +};
> > +
> >   &sata {
> >       status =3D "okay";
> >   };
> >
>
