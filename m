Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D425C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312D720409
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6gf1Uxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKYIeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:34:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35262 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:34:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id n5so4711599wmc.0;
        Mon, 25 Nov 2019 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vdNRdoIFhVqHUJeabKMLxpBtX1R0D2pJwSn4EAEi7Ks=;
        b=W6gf1UxusKhcJ4rUD8Z5Z96sSun2gLYeIdHJ5oEb/0849bLOsYOewRbT1O1UezF7vZ
         5CPg25AqSVcitNuTO9c4RFaYAJh3HpT/J+xLyoOPc1qJerA0fsZq4g/wQEFiRrhIxX7p
         uf0Pfm7JjjaeSqhcrF1VXxpan30mT6qWcFm0wn0upv0usigu7Q3geVdZsGQ/lK3chiyF
         54BSfnPcVJ+SohY6ALSD9rHzlOJ3ajxkYInhuEAKA0qlbftdN1rzlXbHqPixKUWvP/Lh
         mjFMsDOL4AIDqjNFik+tQWaE5wDG+MkgmkeaBIEjuqQ/ovFA49JkZEEzVT9FgsmEIGdQ
         uE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vdNRdoIFhVqHUJeabKMLxpBtX1R0D2pJwSn4EAEi7Ks=;
        b=GxLjtcFLjGhT7gNmmREExFBcmsgVRcn0KgQ9Xp3p6+P4pi1Kbw+2vuty1+xpk8iZwT
         EH9ck81CUT28TVa2opHuioBo4lHcyya6bsZdUYSHpUbe2gr5yQ3eB2BvdDRk2NSiydBO
         r4H6r2SuaAKW69eaKtPIcVFeXqfcn8lzj8/qPpI58XGFAirLV6MTG+XjSSSJzAfbv1u9
         1sreSNJg7gNOP0CJ1EspfPBbmb7LkpsXmD/GHlk+JyN/8tOGv2jFcqDwYpcQlp5wpXpY
         YQG2zvfP7qHRHSaWJuNINdmZ9oN5/F2e159IuSXl+FLNcxjizqE3bpOL/ic/BvZMHixn
         WrNg==
X-Gm-Message-State: APjAAAXUesVCZK5b0SwLjei2m+fHqt294Hkav4Xx46Dz1G0CIqlfGRn0
        BdbJRKBIHybpGJb+uxaUNNNo2Ww/zoCYckpgNtS0wA==
X-Google-Smtp-Source: APXvYqxE9wzNkMkF38LdfXtwHSm2x3HDbiWVM0RaNqkpZJceTQCFtZKpJ+9sDkkAtzYoyXGfmc8mge+hZQ473Oi52c0=
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr7840442wmj.2.1574670849778;
 Mon, 25 Nov 2019 00:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-6-chunyan.zhang@unisoc.com> <20191114210516.GB16668@bogus>
 <CAAfSe-tg2Jp-kuKW5QC4cAityDiuEhMuDfDDyUgt1YZ4eXte7A@mail.gmail.com> <CAL_JsqKqFmXZCJRKdHoYx14j=pzs80KqGpVd19ri4T_f6jrQCA@mail.gmail.com>
In-Reply-To: <CAL_JsqKqFmXZCJRKdHoYx14j=pzs80KqGpVd19ri4T_f6jrQCA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 25 Nov 2019 16:33:33 +0800
Message-ID: <CAAfSe-uU0O_hkNfCX7aptHyMSMagPH-=9KRKbXfUp2J26Bk4AA@mail.gmail.com>
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

On Fri, 15 Nov 2019 at 22:43, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 15, 2019 at 2:59 AM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> >
> > On Fri, 15 Nov 2019 at 05:05, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 05:02:30PM +0800, Chunyan Zhang wrote:
> > > >
> > > > Add basic DT to support Unisoc's SC9863A, with this patch,
> > > > the board sp9863a-1h10 can run into console.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> > > >  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 536 ++++++++++++++++++=
++++
> > > >  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 188 ++++++++
> > > >  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  40 ++
> > > >  4 files changed, 766 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > >  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > > >  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dt=
s/sprd/Makefile
> > > > index 2bdc23804f40..f4f1f5148cc2 100644
> > > > --- a/arch/arm64/boot/dts/sprd/Makefile
> > > > +++ b/arch/arm64/boot/dts/sprd/Makefile
> > > > @@ -1,3 +1,4 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  dtb-$(CONFIG_ARCH_SPRD) +=3D sc9836-openphone.dtb \
> > > > -                     sp9860g-1h10.dtb
> > > > +                     sp9860g-1h10.dtb        \
> > > > +                     sp9863a-1h10.dtb
> > > > diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boo=
t/dts/sprd/sc9863a.dtsi
> > > > new file mode 100644
> > > > index 000000000000..578d71a932d9
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > > > @@ -0,0 +1,536 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Unisoc SC9863A SoC DTS file
> > > > + *
> > > > + * Copyright (C) 2019, Unisoc Inc.
> > > > + */
> > > > +
> > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +#include "sharkl3.dtsi"
> > > > +
> > > > +/ {
> > > > +     cpus {
> > > > +             #address-cells =3D <2>;
> > > > +             #size-cells =3D <0>;
> > > > +
> > > > +             cpu-map {
> > > > +                     cluster0 {
> > > > +                             core0 {
> > > > +                                     cpu =3D <&CPU0>;
> > > > +                             };
> > > > +                             core1 {
> > > > +                                     cpu =3D <&CPU1>;
> > > > +                             };
> > > > +                             core2 {
> > > > +                                     cpu =3D <&CPU2>;
> > > > +                             };
> > > > +                             core3 {
> > > > +                                     cpu =3D <&CPU3>;
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     cluster1 {
> > > > +                             core0 {
> > > > +                                     cpu =3D <&CPU4>;
> > > > +                             };
> > > > +                             core1 {
> > > > +                                     cpu =3D <&CPU5>;
> > > > +                             };
> > > > +                             core2 {
> > > > +                                     cpu =3D <&CPU6>;
> > > > +                             };
> > > > +                             core3 {
> > > > +                                     cpu =3D <&CPU7>;
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             CPU0: cpu@0 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x0>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU1: cpu@100 {
> > >
> > > Your numbering seems odd. This follows the MPIDR reg? Normally a clus=
ter
> > > would share the same number in one of the bytes.
> >
> > We're using A55, and the spec says that bit[15:8] identifies
> > individual cores within the local DynamIQ=E2=84=A2 cluster
>
> Okay.
>
> > Also, we only support one cluster.
>
> cpu-map shows 2 clusters.

From the scheduler view, we have two clusters, but there's actually
one physical cluster only.

>
> >
> > >
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x100>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU2: cpu@200 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x200>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU3: cpu@300 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x300>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU4: cpu@400 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x400>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU5: cpu@500 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x500>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU6: cpu@600 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x600>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +
> > > > +             CPU7: cpu@700 {
> > > > +                     device_type =3D "cpu";
> > > > +                     compatible =3D "arm,cortex-a55";
> > > > +                     reg =3D <0x0 0x700>;
> > > > +                     enable-method =3D "psci";
> > > > +                     cpu-idle-states =3D <&CORE_PD>;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     idle-states {
> > > > +             entry-method =3D "arm,psci";
> > > > +             CORE_PD: core_pd {
> > > > +                     compatible =3D "arm,idle-state";
> > > > +                     entry-latency-us =3D <4000>;
> > > > +                     exit-latency-us =3D <4000>;
> > > > +                     min-residency-us =3D <10000>;
> > > > +                     local-timer-stop;
> > > > +                     arm,psci-suspend-param =3D <0x00010000>;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     gic: interrupt-controller@14000000 {
> > >
> > > Should go under a bus node.
> >
> > I didn't get your point, can you give me more details about this?
>
> Memory mapped peripherals should go under a 'simple-bus' node rather
> than be at the top level.

Got it.

>
> > > > +             compatible =3D "arm,gic-v3";
> > > > +             #interrupt-cells =3D <3>;
> > > > +             #address-cells =3D <2>;
> > > > +             #size-cells =3D <2>;
> > > > +             ranges;
> > > > +             redistributor-stride =3D <0x0 0x20000>;   /* 128KB st=
ride */
> > > > +             #redistributor-regions =3D <1>;
> > > > +             interrupt-controller;
> > > > +             reg =3D <0x0 0x14000000 0 0x20000>,       /* GICD */
> > > > +                   <0x0 0x14040000 0 0x100000>;      /* GICR */
> > > > +             interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > > > +
> > > > +             v2m_0: v2m@0 {
> > > > +                     compatible =3D "arm,gic-v2m-frame";
> > >
> > > This is a GICv2 thing...
> >
> > Will remove it.
> >
> > >
> > > > +                     msi-controller;
> > >
> > > Goes in the parent. Please run your dts file with
> > > 'make W=3D12 dtbs_check' and fix the warnings.
> >
> > Ok (sorry for missing to do this check)
> >
> > >
> > > > +                     reg =3D <0 0 0 0x1000>;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     psci {
> > > > +             compatible =3D "arm,psci-0.2";
> > > > +             method =3D "smc";
> > > > +     };
> > > > +
> > > > +     timer {
> > > > +             compatible =3D "arm,armv8-timer";
> > > > +             interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* P=
hysical Secure PPI */
> > > > +                          <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Phy=
sical Non-Secure PPI */
> > > > +                          <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Vir=
tual PPI */
> > > > +                          <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hip=
ervisor PPI */
> > > > +     };
> > > > +
> > > > +     pmu {
> > > > +             compatible =3D "arm,armv8-pmuv3";
> > > > +             interrupts =3D <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                          <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> > > > +     };
> > > > +
> > > > +     soc {
> > > > +             funnel@10001000 {
> > > > +                     compatible =3D "arm,coresight-dynamic-funnel"=
, "arm,primecell";
> > > > +                     reg =3D <0 0x10001000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     funnel_soc_out_port: endpoint=
 {
> > > > +                                             remote-endpoint =3D <=
&etb_in>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-ports {
> > > > +                             #address-cells =3D <1>;
> > > > +                             #size-cells =3D <0>;
> > > > +
> > > > +                             port@0 {
> > > > +                                     reg =3D <0>;
> > > > +                                     funnel_soc_in_port: endpoint =
{
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_ca55_out_por=
t>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etb@10003000 {
> > > > +                     compatible =3D "arm,coresight-tmc", "arm,prim=
ecell";
> > > > +                     reg =3D <0 0x10003000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     in-ports {
> > > > +                             port {
> > > > +                                     etb_in: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_soc_out_port=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             funnel@12001000 {
> > > > +                     compatible =3D "arm,coresight-dynamic-funnel"=
, "arm,primecell";
> > > > +                     reg =3D <0 0x12001000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     funnel_little_out_port: endpo=
int {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&etf_little_in>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-ports {
> > > > +                             #address-cells =3D <1>;
> > > > +                             #size-cells =3D <0>;
> > > > +
> > > > +                             port@0 {
> > > > +                                     reg =3D <0>;
> > > > +                                     funnel_little_in_port0: endpo=
int {
> > > > +                                             remote-endpoint =3D <=
&etm0_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@1 {
> > > > +                                     reg =3D <1>;
> > > > +                                     funnel_little_in_port1: endpo=
int {
> > > > +                                             remote-endpoint =3D <=
&etm1_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@2 {
> > > > +                                     reg =3D <2>;
> > > > +                                     funnel_little_in_port2: endpo=
int {
> > > > +                                             remote-endpoint =3D <=
&etm2_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@3 {
> > > > +                                     reg =3D <3>;
> > > > +                                     funnel_little_in_port3: endpo=
int {
> > > > +                                             remote-endpoint =3D <=
&etm3_out>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etf@12002000 {
> > > > +                     compatible =3D "arm,coresight-tmc", "arm,prim=
ecell";
> > > > +                     reg =3D <0 0x12002000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etf_little_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_ca55_in_port=
0>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-port {
> > > > +                             port {
> > > > +                                     etf_little_in: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_little_out_p=
ort>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etf@12003000 {
> > > > +                     compatible =3D "arm,coresight-tmc", "arm,prim=
ecell";
> > > > +                     reg =3D <0 0x12003000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etf_big_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_ca55_in_port=
1>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-ports {
> > > > +                             port {
> > > > +                                     etf_big_in: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_big_out_port=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             funnel@12004000 {
> > > > +                     compatible =3D "arm,coresight-dynamic-funnel"=
, "arm,primecell";
> > > > +                     reg =3D <0 0x12004000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     funnel_ca55_out_port: endpoin=
t {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_soc_in_port>=
;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-ports {
> > > > +                             #address-cells =3D <1>;
> > > > +                             #size-cells =3D <0>;
> > > > +
> > > > +                             port@0 {
> > > > +                                     reg =3D <0>;
> > > > +                                     funnel_ca55_in_port0: endpoin=
t {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&etf_little_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@1 {
> > > > +                                     reg =3D <1>;
> > > > +                                     funnel_ca55_in_port1: endpoin=
t {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&etf_big_out>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             funnel@12005000 {
> > > > +                     compatible =3D "arm,coresight-dynamic-funnel"=
, "arm,primecell";
> > > > +                     reg =3D <0 0x12005000 0 0x1000>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     funnel_big_out_port: endpoint=
 {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&etf_big_in>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     in-ports {
> > > > +                             #address-cells =3D <1>;
> > > > +                             #size-cells =3D <0>;
> > > > +
> > > > +                             port@0 {
> > > > +                                     reg =3D <0>;
> > > > +                                     funnel_big_in_port0: endpoint=
 {
> > > > +                                             remote-endpoint =3D <=
&etm4_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@1 {
> > > > +                                     reg =3D <1>;
> > > > +                                     funnel_big_in_port1: endpoint=
 {
> > > > +                                             remote-endpoint =3D <=
&etm5_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@2 {
> > > > +                                     reg =3D <2>;
> > > > +                                     funnel_big_in_port2: endpoint=
 {
> > > > +                                             remote-endpoint =3D <=
&etm6_out>;
> > > > +                                     };
> > > > +                             };
> > > > +
> > > > +                             port@3 {
> > > > +                                     reg =3D <3>;
> > > > +                                     funnel_big_in_port3: endpoint=
 {
> > > > +                                             remote-endpoint =3D <=
&etm7_out>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13040000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13040000 0 0x1000>;
> > > > +                     cpu =3D <&CPU0>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm0_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_little_in_po=
rt0>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13140000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13140000 0 0x1000>;
> > > > +                     cpu =3D <&CPU1>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm1_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_little_in_po=
rt1>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13240000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13240000 0 0x1000>;
> > > > +                     cpu =3D <&CPU2>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm2_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_little_in_po=
rt2>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13340000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13340000 0 0x1000>;
> > > > +                     cpu =3D <&CPU3>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm3_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_little_in_po=
rt3>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13440000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13440000 0 0x1000>;
> > > > +                     cpu =3D <&CPU4>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm4_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_big_in_port0=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13540000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13540000 0 0x1000>;
> > > > +                     cpu =3D <&CPU5>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm5_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_big_in_port1=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13640000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13640000 0 0x1000>;
> > > > +                     cpu =3D <&CPU6>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm6_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_big_in_port2=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             etm@13740000 {
> > > > +                     compatible =3D "arm,coresight-etm4x", "arm,pr=
imecell";
> > > > +                     reg =3D <0 0x13740000 0 0x1000>;
> > > > +                     cpu =3D <&CPU7>;
> > > > +                     clocks =3D <&ext_26m>;
> > > > +                     clock-names =3D "apb_pclk";
> > > > +
> > > > +                     out-ports {
> > > > +                             port {
> > > > +                                     etm7_out: endpoint {
> > > > +                                             remote-endpoint =3D
> > > > +                                             <&funnel_big_in_port3=
>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boo=
t/dts/sprd/sharkl3.dtsi
> > > > new file mode 100644
> > > > index 000000000000..3ef233f70dc4
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > > > @@ -0,0 +1,188 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Unisoc Sharkl3 platform DTS file
> > > > + *
> > > > + * Copyright (C) 2019, Unisoc Inc.
> > > > + */
> > > > +
> > > > +/ {
> > > > +     interrupt-parent =3D <&gic>;
> > > > +     #address-cells =3D <2>;
> > > > +     #size-cells =3D <2>;
> > > > +
> > > > +     soc: soc {
> > > > +             compatible =3D "simple-bus";
> > > > +             #address-cells =3D <2>;
> > > > +             #size-cells =3D <2>;
> > > > +             ranges;
> > > > +
> > > > +             ap_ahb_regs: syscon@20e00000 {
> > > > +                     compatible =3D "syscon";
> > > > +                     reg =3D <0 0x20e00000 0 0x10000>;
> > > > +             };
> > > > +
> > > > +             pub_apb_regs: syscon@300e0000 {
> > > > +                     compatible =3D "syscon";
> > >
> > > "syscon" should also have a specific compatible. What are all these
> > > blocks? Looks like placeholders. If so, just drop them.
> >
> > The purppse is to make these addresses mapped for many peripharls
> > whose some controller registers are in the same address base with one
> > of syscons listed here.
> > Under those peripharl device nodes there's a property refer to syscon, =
like
> > https://elixir.bootlin.com/linux/v5.4-rc7/source/arch/arm64/boot/dts/sp=
rd/sc9860.dtsi#L227
>
> Okay, but you should have a specific compatible for each block in
> addition to 'syscon'.

Ok, will add a specific compatible string in the next version.

>
> Also, do you really have 64KB of registers in each block? Define
> what's actually there at least down to a page size to avoid
> unnecessary mappings.

Will make a clean.

Thanks,
Chunyan
