Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B02C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD35020652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GpYY7mWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfDLMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:11:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44309 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:11:33 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so8209117iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4lVqUQZ8y48QeUHWnd/Jy2pgPNXI6ISMHRIV8nefK9c=;
        b=GpYY7mWE9iTdG9hsqv9Nam+qZnBeJqBYOaVXw01b4hbQzucXgtv4ToL8/uY/riJMjO
         6jY2S+0X23NNKBVVXlIXeFAqfDcgAsVg25pvN4WtO3Zm3mx2Vgv29M8DrZcxyUyB8Rbf
         +O9r1e5tunRJq5rhrV2Q7Co0L7nTfi2DA1o/Wjz96viFws8PlrFTja9XHtpeZuGkrbP8
         jTF6DdY9DB4/DOM2jn9ceoaA4r3I6qBqVj4kjoRlsrJcvhnzc7HBUeeLOXAkQed9mfL8
         7gGwVc2iElKXC1bi8jdZ7YYaM77SbVqZKPF4ZIvmsQXYstDDSIemXHKMlJCdpVZyLTWl
         tEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4lVqUQZ8y48QeUHWnd/Jy2pgPNXI6ISMHRIV8nefK9c=;
        b=JAQbOXCsIeY8TI1nwiZh0Xn5lRT2r5r3D7QxWrmPGvgZ2bUOXsPS/7nZqMgDlckaf0
         cgDZJc75rmQKWe7Dv6uS2+UVqYMLT2P3UdturwjhiohK0Qj6TyVy9yjTDucsoEknMCJp
         wgiBfZHlyEc5g4sEEQhiVBy54i9KFIxQD/xWB9o2b5l8D2ikzliIZkhqlTD5/SOrn1Ks
         tf4ywRWfjusgbbYH598f2VDGbBiK+O+gpNssM1cXsrgXG7IVhMInVF1xIqDMccCbOc/l
         6vie2IxYW8R8z9TkTimLo63SrHkvJU0vSf9f7uo1GOJhiO5XFCFnJdAZnj/jz1LtnRjC
         nbXg==
X-Gm-Message-State: APjAAAW7rtCwW+U7isTMh23Tb7ySZlEvD+SNe2TXVJ3MeSos2iJYD3Gc
        MJDhdzjKAHqOPqw23T6sJ5OcVJxWD6xqJCeKjS+2dQ==
X-Google-Smtp-Source: APXvYqxPxq1x/9zOQp9qKEZWTEoGMvyP+ChQiY0bRYhaI0VHL1pnKFlfM2Y49iMBK9Dd0OCrc89vVVrIc8HjXPMzX7E=
X-Received: by 2002:a6b:3b43:: with SMTP id i64mr36049329ioa.121.1555071091916;
 Fri, 12 Apr 2019 05:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com>
In-Reply-To: <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 14:11:21 +0200
Message-ID: <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
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

pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bartosz,
>
> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > From: David Lechner <david@lechnology.com>
> >
> > This adds a cpu node and operating points to the common da850.dtsi file=
.
> >
> > Additionally, a regulator is added to the LEGO EV3 board along with
> > some board-specific CPU configuration.
> >
> > Regulators need to be hooked up on other boards to get them working.
> >
> > Signed-off-by: David Lechner <david@lechnology.com>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I remember you mentioning about some problems using OCHI and cpufreq
> together. Are those resolved now? CPU PLL on DA850 can affect other
> peripheral clock frequencies too. So enabling it should really be a
> per-board decision.
>

The problems are still there. I've never been able to find the
culprit, but it also occurs on TI BSP in the same way (a couple
cpufreq transitions will make the controller unresponsive).

> No problems with adding OPPs to da850.dtsi, but which of those are
> enabled on any board should be after some thorough testing and analysis.
>
> Because of that, I think its also better to split da850.dtsi from board
> specific changes in this patch.
>

Sure, I'll split it.

> > +     opp_table: opp-table {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp_100: opp100-100000000 {
> > +                     opp-hz =3D /bits/ 64 <100000000>;
> > +                     opp-microvolt =3D <1000000 950000 1050000>;
> > +             };
> > +
> > +             opp_200: opp110-200000000 {
> > +                     opp-hz =3D /bits/ 64 <200000000>;
> > +                     opp-microvolt =3D <1100000 1050000 1160000>;
> > +             };
> > +
> > +             opp_300: opp120-300000000 {
> > +                     opp-hz =3D /bits/ 64 <300000000>;
> > +                     opp-microvolt =3D <1200000 1140000 1320000>;
> > +             };
> > +
> > +             /*
> > +              * Original silicon was 300MHz max, so higher frequencies
> > +              * need to be enabled on a per-board basis if the chip is
> > +              * capable.
> > +              */
> > +
> > +             opp_375: opp120-375000000 {
> > +                     status =3D "disabled";
> > +                     opp-hz =3D /bits/ 64 <375000000>;
> > +                     opp-microvolt =3D <1200000 1140000 1320000>;
> > +             };
> > +
> > +             opp_415: opp130-415000000 {
> > +                     status =3D "disabled";
> > +                     opp-hz =3D /bits/ 64 <415000000>;
> > +                     opp-microvolt =3D <1300000 1250000 1350000>;
> > +             };
> > +
> > +             opp_456: opp130-456000000 {
> > +                     status =3D "disabled";
> > +                     opp-hz =3D /bits/ 64 <456000000>;
> > +                     opp-microvolt =3D <1300000 1250000 1350000>;
> > +             };
>
> Here, lets stick to OPPs defined in OMAP-L138 data manual (irrespective
> of what existing board code has). Page 93 of
> http://www.ti.com/lit/ds/symlink/omap-l138.pdf
>

Will do in the next version.

Bart

> Thanks,
> Sekhar
