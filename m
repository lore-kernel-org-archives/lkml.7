Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45045C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF62245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsLGG1uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLFKJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:09:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32867 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLFKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:09:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id y23so9413686wma.0;
        Fri, 06 Dec 2019 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UsGwuJpmmXggI12c0BJbL3myfNW+vrDNmKExLXNygA8=;
        b=WsLGG1uT0EHP0LWLa7rcecRpTgGQAwTESH1i7zL9UoTK5xHg3MI6tuNXVX2GIZhiCI
         GxLb+b198fRzaRZIDlPf3i9qYnKKZW1x/5wqajSgIRj9RSX1oyEuSvYoCAe/XEdHsNzx
         jQqK9cs+U6vfYCxdXtO5g/vmT8DFjUjF4nj5Z/kOOF/zMHz1v/ZEW4NoExL7T2G3wGfs
         cb7o6efTprnimGhqhAx5ReOt+GN1JXQJKF0cNL3hvofKkZUWBDuuiqyPZ66Jntm+C7/h
         GZfi8xyv8R9LUe29mQX1AFY5ykit2tr7jkYIHVQ1xYbksbQ0NeHdE0Dwk51Eo1AohCbZ
         2b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UsGwuJpmmXggI12c0BJbL3myfNW+vrDNmKExLXNygA8=;
        b=kIA/OGo4jWPzxrhKpuvvhgou2kyw2CsWT9ToqDjbNx84/Zi0nQdHm6nJKm10UeR+c/
         xtsDiEclylFIKbjJZ3c+mFUg9XdADE+0akdcPMVuRnNdlmOToEs2euCnzafvubtPuxI5
         rR5/dx86vgRXLLHKFFVepGNn0eQEk5ID7vwRd+CiCAhUYK7WGbU/kRIVU2NGF3WQrerc
         /MBdoHE6mxpbmuiAHgLYcWynhwAgJGdhLHke4u+gflPfL/OKNucsWD7L/XfxzsHcD0rP
         b8XvNWKBmjZZiYl6WTCQSXWUB12KrhYmnlwpQyXMUzr5DamPMO8tz3Bj6y/93o7en+Fx
         PJXw==
X-Gm-Message-State: APjAAAVaRuSsx5664v+DrKGc3/K+dscLXChXQHZwbgDILyok6JYCOuAh
        Spwv1pLLR2A1JcwhDCTGEMFDv16FcrKkFzT5Zjw=
X-Google-Smtp-Source: APXvYqwDFvN6nRFU4i6tJIgVnMTN3dF1rix2W514PLzTBSRjPJ+dltNekFEdEtwWBnuLrcvSRDXwzoKiHOG6cO7SDpA=
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr9713944wmk.1.1575626986848;
 Fri, 06 Dec 2019 02:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-6-chunyan.zhang@unisoc.com> <20191114210516.GB16668@bogus>
 <CAAfSe-tg2Jp-kuKW5QC4cAityDiuEhMuDfDDyUgt1YZ4eXte7A@mail.gmail.com>
 <CAL_JsqKqFmXZCJRKdHoYx14j=pzs80KqGpVd19ri4T_f6jrQCA@mail.gmail.com>
 <CAAfSe-uU0O_hkNfCX7aptHyMSMagPH-=9KRKbXfUp2J26Bk4AA@mail.gmail.com> <CAL_Jsq+ciND5sCpR3L63yH2XvbMLE2b7DMdOzWSZJc8utE7gZg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ciND5sCpR3L63yH2XvbMLE2b7DMdOzWSZJc8utE7gZg@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 6 Dec 2019 18:09:10 +0800
Message-ID: <CAAfSe-tm-E-q-L4J=NP_Oa3+jLP5nM4yf69XuAm4=Uij_YB4AQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 00:33, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 25, 2019 at 2:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> >
> > On Fri, 15 Nov 2019 at 22:43, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Nov 15, 2019 at 2:59 AM Chunyan Zhang <zhang.lyra@gmail.com> =
wrote:
> > > >
> > > > On Fri, 15 Nov 2019 at 05:05, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Mon, Nov 11, 2019 at 05:02:30PM +0800, Chunyan Zhang wrote:
> > > > > >
> > > > > > Add basic DT to support Unisoc's SC9863A, with this patch,
> > > > > > the board sp9863a-1h10 can run into console.
> > > > > >
> > > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> > > > > >  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 536 ++++++++++++++=
++++++++
> > > > > >  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 188 ++++++++
> > > > > >  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  40 ++
> > > > > >  4 files changed, 766 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boo=
t/dts/sprd/Makefile
> > > > > > index 2bdc23804f40..f4f1f5148cc2 100644
> > > > > > --- a/arch/arm64/boot/dts/sprd/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/sprd/Makefile
> > > > > > @@ -1,3 +1,4 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > >  dtb-$(CONFIG_ARCH_SPRD) +=3D sc9836-openphone.dtb \
> > > > > > -                     sp9860g-1h10.dtb
> > > > > > +                     sp9860g-1h10.dtb        \
> > > > > > +                     sp9863a-1h10.dtb
> > > > > > diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64=
/boot/dts/sprd/sc9863a.dtsi
> > > > > > new file mode 100644
> > > > > > index 000000000000..578d71a932d9
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > > > > @@ -0,0 +1,536 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Unisoc SC9863A SoC DTS file
> > > > > > + *
> > > > > > + * Copyright (C) 2019, Unisoc Inc.
> > > > > > + */
> > > > > > +
> > > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > +#include "sharkl3.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +     cpus {
> > > > > > +             #address-cells =3D <2>;
> > > > > > +             #size-cells =3D <0>;
> > > > > > +
> > > > > > +             cpu-map {
> > > > > > +                     cluster0 {
> > > > > > +                             core0 {
> > > > > > +                                     cpu =3D <&CPU0>;
> > > > > > +                             };
> > > > > > +                             core1 {
> > > > > > +                                     cpu =3D <&CPU1>;
> > > > > > +                             };
> > > > > > +                             core2 {
> > > > > > +                                     cpu =3D <&CPU2>;
> > > > > > +                             };
> > > > > > +                             core3 {
> > > > > > +                                     cpu =3D <&CPU3>;
> > > > > > +                             };
> > > > > > +                     };
> > > > > > +
> > > > > > +                     cluster1 {
> > > > > > +                             core0 {
> > > > > > +                                     cpu =3D <&CPU4>;
> > > > > > +                             };
> > > > > > +                             core1 {
> > > > > > +                                     cpu =3D <&CPU5>;
> > > > > > +                             };
> > > > > > +                             core2 {
> > > > > > +                                     cpu =3D <&CPU6>;
> > > > > > +                             };
> > > > > > +                             core3 {
> > > > > > +                                     cpu =3D <&CPU7>;
> > > > > > +                             };
> > > > > > +                     };
> > > > > > +             };
> > > > > > +
> > > > > > +             CPU0: cpu@0 {
> > > > > > +                     device_type =3D "cpu";
> > > > > > +                     compatible =3D "arm,cortex-a55";
> > > > > > +                     reg =3D <0x0 0x0>;
> > > > > > +                     enable-method =3D "psci";
> > > > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > > > +             };
> > > > > > +
> > > > > > +             CPU1: cpu@100 {
> > > > >
> > > > > Your numbering seems odd. This follows the MPIDR reg? Normally a =
cluster
> > > > > would share the same number in one of the bytes.
> > > >
> > > > We're using A55, and the spec says that bit[15:8] identifies
> > > > individual cores within the local DynamIQ=E2=84=A2 cluster
> > >
> > > Okay.
> > >
> > > > Also, we only support one cluster.
> > >
> > > cpu-map shows 2 clusters.
> >
> > From the scheduler view, we have two clusters, but there's actually
> > one physical cluster only.
>
> What's the scheduler? ;)

It refers to EAS actually, which has a out-of-tree concept of Phantom
Domains which are not congruent to the real cluster physical domains
for DynamIQ.
But now I understand the problem (saw the previous similar discussions
on other DynamIQ SoC), dividing the cores into two phantom clusters is
a workaround and cannot be merged into mainline.  :)

>
> DT describes the physical system.

Got it, I will fix that to move all cores into a single cluster.

Thanks for the review.
Chunyan

>
> Rob
