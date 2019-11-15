Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB7AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB1F2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Yp5VIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKOI7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:59:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:59:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so8597060wrj.8;
        Fri, 15 Nov 2019 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+zqtay00LLX5fuDdlzEy/bpAzFKBNj1kbuT2GPBI0Y=;
        b=r6Yp5VIetVw6oYDMjx61zDjlkGxkC5+oUZEUIUg6XPU1fkUy10vucwEhj3tLood9l/
         1gJpuqDH/TQ7qzBKO1z9TAr3HcsINc3+zUjX1gGJXsZyHOC8ksYdZSc++OOLOS6fzz+v
         e0IVliFvThGp7ihfeHmWVvYZZa/pW/gxEYQUfWMvWBO5AEQ6onw2XetOJJ4e+VsI2k2c
         VwwdgLOdlbmMQW1hxw4jf7qqEYgTA66qT4EAJYSIVn6/3jHeKjGfMzjExhLQvu/NyAt6
         K5c0Zo+6COpOKlYI06xk2Jg3OQfQdOJRdXNmWeIVLPQq9xitCXRtYwIHmbX8h3beDOZK
         g1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+zqtay00LLX5fuDdlzEy/bpAzFKBNj1kbuT2GPBI0Y=;
        b=fhDl5AkbSH7zXYvtkh0w6TY9/uGkKZ4CpxLm+QyCzIhylOs16Woctt80/4xU5763n4
         rl/lnM8axcJ+gBOd9iXxqHDCH4INVvtLLt2GN4+IjWURNF4V53L03l6nP5NOwk8jALfZ
         gzUmrFjX7usNfC+hb2nCZyJghlnXlpoHeHbh9MVj/w0eYwxjF1Er3Wk7VWe5ahwDMbdZ
         bA9oNxMdTMZvMvxJAzAMx3tVlqEp4YAqyzbyoLSDtinH4/HORTD/0yPxZrjonjc0VT6N
         qEwdrMM4DWbVbInWF0VsngOp1L7vbmA63wcWc/Cw65kCAvVh8Zq7VNjrJCiLiMxWrVlT
         FUFw==
X-Gm-Message-State: APjAAAVGSkb90A6HPNjG9TBc6hRRCEfSU678SK+5HPlsBckqI2Vm7c/s
        DG+48N2u8niW3oDlrll1zCsR7/hKHR+a4Zptvn8=
X-Google-Smtp-Source: APXvYqwaMpEECWbBd7LJ2cwaJFl3qVXwNcsDFFX4h4qsRoI2qfzG1NIMDHJwjzbyVHaT5HLedFiIE+yOgIpGRITcDnw=
X-Received: by 2002:adf:f547:: with SMTP id j7mr6010347wrp.69.1573808385432;
 Fri, 15 Nov 2019 00:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-6-chunyan.zhang@unisoc.com> <20191114210516.GB16668@bogus>
In-Reply-To: <20191114210516.GB16668@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 15 Nov 2019 16:59:08 +0800
Message-ID: <CAAfSe-tg2Jp-kuKW5QC4cAityDiuEhMuDfDDyUgt1YZ4eXte7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 05:05, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 11, 2019 at 05:02:30PM +0800, Chunyan Zhang wrote:
> >
> > Add basic DT to support Unisoc's SC9863A, with this patch,
> > the board sp9863a-1h10 can run into console.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
> >  arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 536 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 188 ++++++++
> >  arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  40 ++
> >  4 files changed, 766 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
> >  create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
> >  create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> >
> > diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sp=
rd/Makefile
> > index 2bdc23804f40..f4f1f5148cc2 100644
> > --- a/arch/arm64/boot/dts/sprd/Makefile
> > +++ b/arch/arm64/boot/dts/sprd/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_SPRD) +=3D sc9836-openphone.dtb \
> > -                     sp9860g-1h10.dtb
> > +                     sp9860g-1h10.dtb        \
> > +                     sp9863a-1h10.dtb
> > diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dt=
s/sprd/sc9863a.dtsi
> > new file mode 100644
> > index 000000000000..578d71a932d9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> > @@ -0,0 +1,536 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Unisoc SC9863A SoC DTS file
> > + *
> > + * Copyright (C) 2019, Unisoc Inc.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include "sharkl3.dtsi"
> > +
> > +/ {
> > +     cpus {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <0>;
> > +
> > +             cpu-map {
> > +                     cluster0 {
> > +                             core0 {
> > +                                     cpu =3D <&CPU0>;
> > +                             };
> > +                             core1 {
> > +                                     cpu =3D <&CPU1>;
> > +                             };
> > +                             core2 {
> > +                                     cpu =3D <&CPU2>;
> > +                             };
> > +                             core3 {
> > +                                     cpu =3D <&CPU3>;
> > +                             };
> > +                     };
> > +
> > +                     cluster1 {
> > +                             core0 {
> > +                                     cpu =3D <&CPU4>;
> > +                             };
> > +                             core1 {
> > +                                     cpu =3D <&CPU5>;
> > +                             };
> > +                             core2 {
> > +                                     cpu =3D <&CPU6>;
> > +                             };
> > +                             core3 {
> > +                                     cpu =3D <&CPU7>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             CPU0: cpu@0 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x0>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU1: cpu@100 {
>
> Your numbering seems odd. This follows the MPIDR reg? Normally a cluster
> would share the same number in one of the bytes.

We're using A55, and the spec says that bit[15:8] identifies
individual cores within the local DynamIQ=E2=84=A2 cluster

Also, we only support one cluster.

>
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x100>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU2: cpu@200 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x200>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU3: cpu@300 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x300>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU4: cpu@400 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x400>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU5: cpu@500 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x500>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU6: cpu@600 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x600>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +
> > +             CPU7: cpu@700 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a55";
> > +                     reg =3D <0x0 0x700>;
> > +                     enable-method =3D "psci";
> > +                     cpu-idle-states =3D <&CORE_PD>;
> > +             };
> > +     };
> > +
> > +     idle-states {
> > +             entry-method =3D "arm,psci";
> > +             CORE_PD: core_pd {
> > +                     compatible =3D "arm,idle-state";
> > +                     entry-latency-us =3D <4000>;
> > +                     exit-latency-us =3D <4000>;
> > +                     min-residency-us =3D <10000>;
> > +                     local-timer-stop;
> > +                     arm,psci-suspend-param =3D <0x00010000>;
> > +             };
> > +     };
> > +
> > +     gic: interrupt-controller@14000000 {
>
> Should go under a bus node.

I didn't get your point, can you give me more details about this?

>
> > +             compatible =3D "arm,gic-v3";
> > +             #interrupt-cells =3D <3>;
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +             redistributor-stride =3D <0x0 0x20000>;   /* 128KB stride=
 */
> > +             #redistributor-regions =3D <1>;
> > +             interrupt-controller;
> > +             reg =3D <0x0 0x14000000 0 0x20000>,       /* GICD */
> > +                   <0x0 0x14040000 0 0x100000>;      /* GICR */
> > +             interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +             v2m_0: v2m@0 {
> > +                     compatible =3D "arm,gic-v2m-frame";
>
> This is a GICv2 thing...

Will remove it.

>
> > +                     msi-controller;
>
> Goes in the parent. Please run your dts file with
> 'make W=3D12 dtbs_check' and fix the warnings.

Ok (sorry for missing to do this check)

>
> > +                     reg =3D <0 0 0 0x1000>;
> > +             };
> > +     };
> > +
> > +     psci {
> > +             compatible =3D "arm,psci-0.2";
> > +             method =3D "smc";
> > +     };
> > +
> > +     timer {
> > +             compatible =3D "arm,armv8-timer";
> > +             interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physi=
cal Secure PPI */
> > +                          <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physica=
l Non-Secure PPI */
> > +                          <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual=
 PPI */
> > +                          <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervi=
sor PPI */
> > +     };
> > +
> > +     pmu {
> > +             compatible =3D "arm,armv8-pmuv3";
> > +             interrupts =3D <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> > +     };
> > +
> > +     soc {
> > +             funnel@10001000 {
> > +                     compatible =3D "arm,coresight-dynamic-funnel", "a=
rm,primecell";
> > +                     reg =3D <0 0x10001000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_soc_out_port: endpoint {
> > +                                             remote-endpoint =3D <&etb=
_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
> > +                                     funnel_soc_in_port: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_ca55_out_port>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etb@10003000 {
> > +                     compatible =3D "arm,coresight-tmc", "arm,primecel=
l";
> > +                     reg =3D <0 0x10003000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     etb_in: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_soc_out_port>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@12001000 {
> > +                     compatible =3D "arm,coresight-dynamic-funnel", "a=
rm,primecell";
> > +                     reg =3D <0 0x12001000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_little_out_port: endpoint =
{
> > +                                             remote-endpoint =3D
> > +                                             <&etf_little_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
> > +                                     funnel_little_in_port0: endpoint =
{
> > +                                             remote-endpoint =3D <&etm=
0_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg =3D <1>;
> > +                                     funnel_little_in_port1: endpoint =
{
> > +                                             remote-endpoint =3D <&etm=
1_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@2 {
> > +                                     reg =3D <2>;
> > +                                     funnel_little_in_port2: endpoint =
{
> > +                                             remote-endpoint =3D <&etm=
2_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@3 {
> > +                                     reg =3D <3>;
> > +                                     funnel_little_in_port3: endpoint =
{
> > +                                             remote-endpoint =3D <&etm=
3_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etf@12002000 {
> > +                     compatible =3D "arm,coresight-tmc", "arm,primecel=
l";
> > +                     reg =3D <0 0x12002000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etf_little_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_ca55_in_port0>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-port {
> > +                             port {
> > +                                     etf_little_in: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_little_out_port>=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etf@12003000 {
> > +                     compatible =3D "arm,coresight-tmc", "arm,primecel=
l";
> > +                     reg =3D <0 0x12003000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etf_big_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_ca55_in_port1>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     etf_big_in: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_big_out_port>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@12004000 {
> > +                     compatible =3D "arm,coresight-dynamic-funnel", "a=
rm,primecell";
> > +                     reg =3D <0 0x12004000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_ca55_out_port: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_soc_in_port>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
> > +                                     funnel_ca55_in_port0: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&etf_little_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg =3D <1>;
> > +                                     funnel_ca55_in_port1: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&etf_big_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@12005000 {
> > +                     compatible =3D "arm,coresight-dynamic-funnel", "a=
rm,primecell";
> > +                     reg =3D <0 0x12005000 0 0x1000>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_big_out_port: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&etf_big_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
> > +                                     funnel_big_in_port0: endpoint {
> > +                                             remote-endpoint =3D <&etm=
4_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg =3D <1>;
> > +                                     funnel_big_in_port1: endpoint {
> > +                                             remote-endpoint =3D <&etm=
5_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@2 {
> > +                                     reg =3D <2>;
> > +                                     funnel_big_in_port2: endpoint {
> > +                                             remote-endpoint =3D <&etm=
6_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@3 {
> > +                                     reg =3D <3>;
> > +                                     funnel_big_in_port3: endpoint {
> > +                                             remote-endpoint =3D <&etm=
7_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13040000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13040000 0 0x1000>;
> > +                     cpu =3D <&CPU0>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm0_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_little_in_port0>=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13140000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13140000 0 0x1000>;
> > +                     cpu =3D <&CPU1>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm1_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_little_in_port1>=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13240000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13240000 0 0x1000>;
> > +                     cpu =3D <&CPU2>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm2_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_little_in_port2>=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13340000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13340000 0 0x1000>;
> > +                     cpu =3D <&CPU3>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm3_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_little_in_port3>=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13440000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13440000 0 0x1000>;
> > +                     cpu =3D <&CPU4>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm4_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_big_in_port0>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13540000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13540000 0 0x1000>;
> > +                     cpu =3D <&CPU5>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm5_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_big_in_port1>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13640000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13640000 0 0x1000>;
> > +                     cpu =3D <&CPU6>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm6_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_big_in_port2>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@13740000 {
> > +                     compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> > +                     reg =3D <0 0x13740000 0 0x1000>;
> > +                     cpu =3D <&CPU7>;
> > +                     clocks =3D <&ext_26m>;
> > +                     clock-names =3D "apb_pclk";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm7_out: endpoint {
> > +                                             remote-endpoint =3D
> > +                                             <&funnel_big_in_port3>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dt=
s/sprd/sharkl3.dtsi
> > new file mode 100644
> > index 000000000000..3ef233f70dc4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Unisoc Sharkl3 platform DTS file
> > + *
> > + * Copyright (C) 2019, Unisoc Inc.
> > + */
> > +
> > +/ {
> > +     interrupt-parent =3D <&gic>;
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +
> > +     soc: soc {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             ap_ahb_regs: syscon@20e00000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x20e00000 0 0x10000>;
> > +             };
> > +
> > +             pub_apb_regs: syscon@300e0000 {
> > +                     compatible =3D "syscon";
>
> "syscon" should also have a specific compatible. What are all these
> blocks? Looks like placeholders. If so, just drop them.

The purppse is to make these addresses mapped for many peripharls
whose some controller registers are in the same address base with one
of syscons listed here.
Under those peripharl device nodes there's a property refer to syscon, like
https://elixir.bootlin.com/linux/v5.4-rc7/source/arch/arm64/boot/dts/sprd/s=
c9860.dtsi#L227

In this way, devices can use the virtual address base which were
mapped by syscon driver.

You can also refer to the commit massage in the patch-set:
https://lkml.org/lkml/2019/11/14/368

>
> > +                     reg =3D <0 0x300e0000 0 0x10000>;
> > +             };
> > +
> > +             pub_ahb_regs: syscon@300f0000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x300f0000 0 0x10000>;
> > +             };
> > +
> > +             aon_intc_regs: syscon@40200000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40200000 0 0x10000>;
> > +             };
> > +
> > +             pmu_regs: syscon@402b0000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x402b0000 0 0x10000>;
> > +             };
> > +
> > +             aon_apb_regs: syscon@402e0000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x402e0000 0 0x10000>;
> > +             };
> > +
> > +             anlg_phy_g1_regs: syscon@40350000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40350000 0 0x3000>;
> > +             };
> > +
> > +             anlg_phy_g2_regs: syscon@40353000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40353000 0 0x6000>;
> > +             };
> > +
> > +             anlg_phy_g4_regs: syscon@40359000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40359000 0 0x3000>;
> > +             };
> > +
> > +             anlg_phy_g5_regs: syscon@4035c000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x4035c000 0 0x3000>;
> > +             };
> > +
> > +             anlg_phy_g7_regs: syscon@40363000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40363000 0 0x3000>;
> > +             };
> > +
> > +             anlg_wrap_wcn_regs: syscon@40366000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40366000 0 0x3000>;
> > +             };
> > +
> > +             wcn_regs: syscon@403a0000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x403a0000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc0_regs: syscon@40500000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40500000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc1_regs: syscon@40510000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40510000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc2_regs: syscon@40520000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40520000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc3_regs: syscon@40530000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40530000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc4_regs: syscon@40540000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40540000 0 0x10000>;
> > +             };
> > +
> > +             ap_intc5_regs: syscon@40550000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x40550000 0 0x10000>;
> > +             };
> > +
> > +             mm_ahb_regs: syscon@60800000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x60800000 0 0x10000>;
> > +             };
> > +
> > +             mm_vsp_ahb_regs: syscon@62000000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x62000000 0 0x10000>;
> > +             };
> > +
> > +             ap_apb_regs: syscon@71300000 {
> > +                     compatible =3D "syscon";
> > +                     reg =3D <0 0x71300000 0 0x40000>;
> > +             };
> > +
> > +             ap-apb {
>
> apb@70000000

Got it.

>
> > +                     compatible =3D "simple-bus";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0 0x0 0x70000000 0x10000000>;
> > +
> > +                     uart0: serial@0 {
> > +                             compatible =3D "sprd,sc9863a-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg =3D <0x0 0x100>;
> > +                             interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_=
HIGH>;
> > +                             clocks =3D <&ext_26m>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     uart1: serial@100000 {
> > +                             compatible =3D "sprd,sc9863a-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg =3D <0x100000 0x100>;
> > +                             interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_=
HIGH>;
> > +                             clocks =3D <&ext_26m>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     uart2: serial@200000 {
> > +                             compatible =3D "sprd,sc9863a-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg =3D <0x200000 0x100>;
> > +                             interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_=
HIGH>;
> > +                             clocks =3D <&ext_26m>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     uart3: serial@300000 {
> > +                             compatible =3D "sprd,sc9863a-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg =3D <0x300000 0x100>;
> > +                             interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_=
HIGH>;
> > +                             clocks =3D <&ext_26m>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     uart4: serial@400000 {
> > +                             compatible =3D "sprd,sc9863a-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg =3D <0x400000 0x100>;
> > +                             interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_=
HIGH>;
> > +                             clocks =3D <&ext_26m>;
> > +                             status =3D "disabled";
> > +                     };
> > +             };
> > +     };
> > +
> > +     ext_26m: ext-26m {
> > +             compatible =3D "fixed-clock";
> > +             #clock-cells =3D <0>;
> > +             clock-frequency =3D <26000000>;
> > +             clock-output-names =3D "ext-26m";
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boo=
t/dts/sprd/sp9863a-1h10.dts
> > new file mode 100644
> > index 000000000000..b6fbb5ca37e1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Unisoc SP9863A-1h10 boards DTS file
> > + *
> > + * Copyright (C) 2019, Unisoc Inc.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sc9863a.dtsi"
> > +
> > +/ {
> > +     model =3D "Spreadtrum SP9863A-1H10 Board";
> > +
> > +     compatible =3D "sprd,sp9863a-1h10", "sprd,sc9863a";
> > +
> > +     sprd,sc-id =3D <9863 1 0x20000>;
>
> Not documented.

Ok, will add.

Thanks for the review,
Chunyan

>
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +             serial1 =3D &uart1;
> > +     };
> > +
> > +     memory {
>
> memory@80000000
>
> > +             device_type =3D "memory";
> > +             reg =3D <0x0 0x80000000 0x0 0x80000000>;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial1:115200n8";
> > +     };
> > +};
> > +
> > +&uart0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +     status =3D "okay";
> > +};
> > --
> > 2.20.1
> >
> >
