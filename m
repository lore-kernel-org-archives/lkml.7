Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D4C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0720722
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575304417;
	bh=iQH96Vs2T9TQdYzyOj/q1Gf724ykpw844ZjShyRmznY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jz7SV+kCr8Sags4YSFZnEOrGj54776kG0Wj4//4KAjhNqHpPzHa++iqqrvF9XjQRu
	 ezaJpK0SZo1mNyq15co0GG3sAOmtrneW+gSGmsVAIk+GKAYBjQjRebgENWMdQGTMr7
	 A2YKTHbUAbTrGHvHssxtXwCTd9TXFHYPM8DTKFcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLBQdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfLBQdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:33:36 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4292084F;
        Mon,  2 Dec 2019 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575304414;
        bh=iQH96Vs2T9TQdYzyOj/q1Gf724ykpw844ZjShyRmznY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuIAH6SYDVdPq1CpdERDZdmMbR632d21p7dbAwat9pFMIKOV6wHRpeonHaAeYOuBe
         1AE+UyHSBglMU6d6W5Y7qhMhR7AlDh4YCEMle2GWVDvTaAMcu2NLumtKF2XtqaED9E
         1F1ZB3/PzXQy4iBjPGRL1TI5cAEhICqhL8NkQpgg=
Received: by mail-qt1-f181.google.com with SMTP id i17so340039qtq.1;
        Mon, 02 Dec 2019 08:33:34 -0800 (PST)
X-Gm-Message-State: APjAAAWD6WukdBdFMosJDQfV08nanIs8OdttREIJymxDl86I25onAMEv
        sPH2OUMedudj45/+oSygG/MVTe8zJdKBkHTrmQ==
X-Google-Smtp-Source: APXvYqzKQxzuL7ZqhimR5TTiPJQf8/A8+mKZg6BrQ1GiRyrnWiCj94UB8EV/iURbbM8gWrqiI2IDbPwO+H4NaP3z7GY=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr154447qtp.224.1575304413718;
 Mon, 02 Dec 2019 08:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-6-chunyan.zhang@unisoc.com> <20191114210516.GB16668@bogus>
 <CAAfSe-tg2Jp-kuKW5QC4cAityDiuEhMuDfDDyUgt1YZ4eXte7A@mail.gmail.com>
 <CAL_JsqKqFmXZCJRKdHoYx14j=pzs80KqGpVd19ri4T_f6jrQCA@mail.gmail.com> <CAAfSe-uU0O_hkNfCX7aptHyMSMagPH-=9KRKbXfUp2J26Bk4AA@mail.gmail.com>
In-Reply-To: <CAAfSe-uU0O_hkNfCX7aptHyMSMagPH-=9KRKbXfUp2J26Bk4AA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Dec 2019 10:33:21 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ciND5sCpR3L63yH2XvbMLE2b7DMdOzWSZJc8utE7gZg@mail.gmail.com>
Message-ID: <CAL_Jsq+ciND5sCpR3L63yH2XvbMLE2b7DMdOzWSZJc8utE7gZg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Mon, Nov 25, 2019 at 2:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Fri, 15 Nov 2019 at 22:43, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Nov 15, 2019 at 2:59 AM Chunyan Zhang <zhang.lyra@gmail.com> wr=
ote:
> > >
> > > On Fri, 15 Nov 2019 at 05:05, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 05:02:30PM +0800, Chunyan Zhang wrote:
> > > > >
> > > > > Add basic DT to support Unisoc's SC9863A, with this patch,
> > > > > the board sp9863a-1h10 can run into console.
> > > > >
> > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> > > > >  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 536 ++++++++++++++++=
++++++
> > > > >  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 188 ++++++++
> > > > >  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  40 ++
> > > > >  4 files changed, 766 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > > > >  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/=
dts/sprd/Makefile
> > > > > index 2bdc23804f40..f4f1f5148cc2 100644
> > > > > --- a/arch/arm64/boot/dts/sprd/Makefile
> > > > > +++ b/arch/arm64/boot/dts/sprd/Makefile
> > > > > @@ -1,3 +1,4 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >  dtb-$(CONFIG_ARCH_SPRD) +=3D sc9836-openphone.dtb \
> > > > > -                     sp9860g-1h10.dtb
> > > > > +                     sp9860g-1h10.dtb        \
> > > > > +                     sp9863a-1h10.dtb
> > > > > diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/b=
oot/dts/sprd/sc9863a.dtsi
> > > > > new file mode 100644
> > > > > index 000000000000..578d71a932d9
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > > > @@ -0,0 +1,536 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Unisoc SC9863A SoC DTS file
> > > > > + *
> > > > > + * Copyright (C) 2019, Unisoc Inc.
> > > > > + */
> > > > > +
> > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +#include "sharkl3.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +     cpus {
> > > > > +             #address-cells =3D <2>;
> > > > > +             #size-cells =3D <0>;
> > > > > +
> > > > > +             cpu-map {
> > > > > +                     cluster0 {
> > > > > +                             core0 {
> > > > > +                                     cpu =3D <&CPU0>;
> > > > > +                             };
> > > > > +                             core1 {
> > > > > +                                     cpu =3D <&CPU1>;
> > > > > +                             };
> > > > > +                             core2 {
> > > > > +                                     cpu =3D <&CPU2>;
> > > > > +                             };
> > > > > +                             core3 {
> > > > > +                                     cpu =3D <&CPU3>;
> > > > > +                             };
> > > > > +                     };
> > > > > +
> > > > > +                     cluster1 {
> > > > > +                             core0 {
> > > > > +                                     cpu =3D <&CPU4>;
> > > > > +                             };
> > > > > +                             core1 {
> > > > > +                                     cpu =3D <&CPU5>;
> > > > > +                             };
> > > > > +                             core2 {
> > > > > +                                     cpu =3D <&CPU6>;
> > > > > +                             };
> > > > > +                             core3 {
> > > > > +                                     cpu =3D <&CPU7>;
> > > > > +                             };
> > > > > +                     };
> > > > > +             };
> > > > > +
> > > > > +             CPU0: cpu@0 {
> > > > > +                     device_type =3D "cpu";
> > > > > +                     compatible =3D "arm,cortex-a55";
> > > > > +                     reg =3D <0x0 0x0>;
> > > > > +                     enable-method =3D "psci";
> > > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > > +             };
> > > > > +
> > > > > +             CPU1: cpu@100 {
> > > >
> > > > Your numbering seems odd. This follows the MPIDR reg? Normally a cl=
uster
> > > > would share the same number in one of the bytes.
> > >
> > > We're using A55, and the spec says that bit[15:8] identifies
> > > individual cores within the local DynamIQ=E2=84=A2 cluster
> >
> > Okay.
> >
> > > Also, we only support one cluster.
> >
> > cpu-map shows 2 clusters.
>
> From the scheduler view, we have two clusters, but there's actually
> one physical cluster only.

What's the scheduler? ;)

DT describes the physical system.

Rob
