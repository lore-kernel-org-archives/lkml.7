Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B3A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554988221;
	bh=Xy35SrYQLMKibKjChobT5LUTLz9B5on71DQVV0dz1hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HqaIcB6tbud5ufRGUE4ZrX8eT2RCNIOKtGI/nSwguqz1VRk+U1RMoPgIdpIEQzNpw
	 eMaM+JckWPqJ4uBTo5he29fkHPkBugm8+OoGi7TjmlYi7d1bPaPrb0mAL8MAufGyIH
	 g99jTODEBGG27a+mnyejvsDHh/SJRe4TM/DBk3nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDKNKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKNKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:10:19 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC29E2133D;
        Thu, 11 Apr 2019 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554988218;
        bh=Xy35SrYQLMKibKjChobT5LUTLz9B5on71DQVV0dz1hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dlXQ4DZUSMtZUNITLbqjP1ruGN8wVt2YDzISshha+pfUE6WyFOrPBc03gWa27GZbQ
         wAxS8L14AsfZxwNSS0srGTIf386y8g9Xcztgsey5ch2VSX7KIXe3StPUea6TAFt/l5
         To6SWUf3laONUW7r2wwgPWn5UH0kBXuWfUMk/1/8=
Received: by mail-qk1-f175.google.com with SMTP id k130so3388538qke.3;
        Thu, 11 Apr 2019 06:10:17 -0700 (PDT)
X-Gm-Message-State: APjAAAXrqGgyjhvnZjVNAK628oqLNy2W0UAlwuYVWLvqkc1mWyafFxdc
        jIa8qbbjHq8SsIpZiMj922QmUSWpBnSXNk+YMw==
X-Google-Smtp-Source: APXvYqwDT4riN1f0sWGggkDSJUaF5eW8M834SxDXilHv+2dgNAZQGdeXiBiM8HTaoHtlE6atHW481jU3zfNSIDqxT8M=
X-Received: by 2002:a37:6441:: with SMTP id y62mr38007553qkb.158.1554988217026;
 Thu, 11 Apr 2019 06:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411084304.5072-5-paul.walmsley@sifive.com>
In-Reply-To: <20190411084304.5072-5-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Apr 2019 08:10:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+VkYrm3ErGRBsVGbYhfd-UEJmBY9VVGsx9k3Ja_zsYPw@mail.gmail.com>
Message-ID: <CAL_Jsq+VkYrm3ErGRBsVGbYhfd-UEJmBY9VVGsx9k3Ja_zsYPw@mail.gmail.com>
Subject: Re: [PATCH 4/6] riscv: dts: add initial support for the SiFive
 FU540-C000 SoC
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:43 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
> based around the SiFive U54-MC core complex and a TileLink
> interconnect.
>
> This file is expected to grow as more device drivers are added to the
> kernel.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 207 +++++++++++++++++++++
>  1 file changed, 207 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> new file mode 100644
> index 000000000000..dd3b9395cedf
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0+)

You're okay with GPLv9 license?

You're free to license however you want, but most dts files use MIT
for permissive license.

> +/* Copyright (c) 2018-2019 SiFive, Inc */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/sifive-fu540-prci.h>
> +
> +/ {
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       compatible = "sifive,fu540-c000", "sifive,fu540";

No point in this as the board file overrides.

> +
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +       };
> +
> +       chosen {
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               timebase-frequency = <1000000>;
> +               cpu0: cpu@0 {
> +                       compatible = "sifive,e51", "sifive,rocket0", "riscv";
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <128>;
> +                       i-cache-size = <16384>;
> +                       reg = <0>;
> +                       riscv,isa = "rv64imac";
> +                       status = "okay";

okay is the default.

It is strange cpu@0 is missing many of the cache properties...

> +                       cpu0_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +               cpu1: cpu@1 {
> +                       compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <1>;
> +                       riscv,isa = "rv64imafdc";
> +                       status = "okay";
> +                       tlb-split;
> +                       cpu1_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +               cpu2: cpu@2 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <2>;
> +                       riscv,isa = "rv64imafdc";
> +                       status = "okay";
> +                       tlb-split;
> +                       cpu2_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +               cpu3: cpu@3 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <3>;
> +                       riscv,isa = "rv64imafdc";
> +                       status = "okay";
> +                       tlb-split;
> +                       cpu3_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +               cpu4: cpu@4 {
> +                       clock-frequency = <0>;
> +                       compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <64>;
> +                       d-cache-size = <32768>;
> +                       d-tlb-sets = <1>;
> +                       d-tlb-size = <32>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <64>;
> +                       i-cache-size = <32768>;
> +                       i-tlb-sets = <1>;
> +                       i-tlb-size = <32>;
> +                       mmu-type = "riscv,sv39";
> +                       reg = <4>;
> +                       riscv,isa = "rv64imafdc";
> +                       status = "okay";
> +                       tlb-split;
> +                       cpu4_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +       };
> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;

Really need 64-bits of address and size for peripherals?

> +               compatible = "sifive,fu540-c000", "sifive,fu540", "simple-bus";

Just simple-bus here. You can't reuse compatible strings.

> +               ranges;
> +               plic0: interrupt-controller@c000000 {
> +                       #interrupt-cells = <1>;
> +                       compatible = "sifive,plic-1.0.0";
> +                       reg = <0x0 0xc000000 0x0 0x4000000>;
> +                       interrupt-controller;
> +                       interrupts-extended = <
> +                               &cpu0_intc 11
> +                               &cpu1_intc 11 &cpu1_intc 9
> +                               &cpu2_intc 11 &cpu2_intc 9
> +                               &cpu3_intc 11 &cpu3_intc 9
> +                               &cpu4_intc 11 &cpu4_intc 9>;
> +               };
> +               prci: clock-controller@10000000 {
> +                       compatible = "sifive,fu540-c000-prci";
> +                       reg = <0x0 0x10000000 0x0 0x1000>;
> +                       clocks = <&hfclk>, <&rtcclk>;
> +                       #clock-cells = <1>;
> +               };
> +               uart0: serial@10010000 {
> +                       compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> +                       reg = <0x0 0x10010000 0x0 0x1000>;
> +                       interrupt-parent = <&plic0>;

Move all these up to the parent.

> +                       interrupts = <4>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +               };
> +               uart1: serial@10011000 {
> +                       compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> +                       reg = <0x0 0x10011000 0x0 0x1000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <5>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +               };
> +               qspi0: spi@10040000 {
> +                       compatible = "sifive,fu540-c000-spi", "sifive,spi0";
> +                       reg = <0x0 0x10040000 0x0 0x1000
> +                              0x0 0x20000000 0x0 0x10000000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <51>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +               qspi2: spi@10050000 {
> +                       compatible = "sifive,fu540-c000-spi", "sifive,spi0";
> +                       reg = <0x0 0x10050000 0x0 0x1000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <6>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +               qspi1: spi@10140000 {
> +                       compatible = "sifive,fu540-c000-spi", "sifive,spi0";
> +                       reg = <0x0 0x10140000 0x0 0x1000
> +                              0x0 0x30000000 0x0 0x10000000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <52>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +       };
> +};
> --
> 2.20.1
>
