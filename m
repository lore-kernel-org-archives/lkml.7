Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74EE2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554987812;
	bh=9XTYCCyJm+fbwpelfocSJVzlq8fNSgae63WzueN6KF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TPQANigEVutwnS4+7DdEDHYrAWN6FfqsexAab1D3zTKC2IT/mrnBccgr9CfCyH8at
	 1qEMUPwyuLxi4QjwEhDDFZ9FH1VKjzhiwxSeg4b8VMTG0cn81qGLJp3D4c7m39aZ0U
	 GNBuCvpZ1PzRea3QOX/i+stMqE4Tdnw6+vUQd454=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKNDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:03:30 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE2A21850;
        Thu, 11 Apr 2019 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554987808;
        bh=9XTYCCyJm+fbwpelfocSJVzlq8fNSgae63WzueN6KF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cofgem3ndsI06Xs8x9qplIdwBEHqQGWHYEGTrm4Pb1L+0DKpYnn5YRtBA4z/o0IX0
         DYb44pquD02iUawKhlqwAVd5Iy5UhSkRcMC0d5tEZIfBJJFg7wkXzgoYJQz7Y1FUXb
         1aV3HYbm+AS+4rkS45nVbCIx7x72o62GdzY5abzU=
Received: by mail-qt1-f170.google.com with SMTP id k14so6970200qtb.0;
        Thu, 11 Apr 2019 06:03:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVEFQYJxWBxCxJX0tTre9R6r3RD2GyCFc7qlBGaEZEIXBAzdbEI
        wWuN3ITOL9RRniaWGFyjxxu4M/qBNKil3dLfzQ==
X-Google-Smtp-Source: APXvYqyKqshKFZvGidjWRZTIr5iIb0RBzNZgkIQWM4X1rEDTWqFLfA3D0CJ7vYpeef7un8R0LKvwiPuXkBMKWGZ1LW4=
X-Received: by 2002:ac8:3f6f:: with SMTP id w44mr39624776qtk.59.1554987807959;
 Thu, 11 Apr 2019 06:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411084304.5072-6-paul.walmsley@sifive.com>
In-Reply-To: <20190411084304.5072-6-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Apr 2019 08:03:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ-tF081FoK3_O6vR-MUjefvEqTGWKRpW7K33nzav8eXA@mail.gmail.com>
Message-ID: <CAL_JsqJ-tF081FoK3_O6vR-MUjefvEqTGWKRpW7K33nzav8eXA@mail.gmail.com>
Subject: Re: [PATCH 5/6] riscv: dts: add initial board data for the SiFive
 HiFive Unleashed
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
> Add initial board data for the SiFive HiFive Unleashed A00.
>
> Currently the data populated in this DT file describes the board
> DRAM configuration and the external clock sources that supply the
> PRCI.
>
> This second version adds onboard SPI device data, fixes the board's
> memory size, and adds changes based on comments from Rob Herring
> <robh+dt@kernel.org>.
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
>  arch/riscv/boot/dts/sifive/Makefile           |  2 +
>  .../dts/sifive/hifive-unleashed-a00-fu540.dts | 69 +++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sifive/Makefile
>  create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
>
> diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
> new file mode 100644
> index 000000000000..fb825db888df
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00-fu540.dtb
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> new file mode 100644
> index 000000000000..9d35e811a3aa
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0+)
> +/* Copyright (c) 2018-2019 SiFive, Inc */
> +
> +/dts-v1/;
> +
> +#include "fu540-c000.dtsi"
> +
> +/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
> +#define RTCCLK_FREQ            1000000
> +
> +/ {
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       model = "SiFive HiFive Unleashed A00 (FU540-C000)";
> +       compatible = "sifive,hifive-unleashed-a00-fu540",
> +               "sifive,hifive-unleashed-fu540",
> +               "sifive,fu540-c000", "sifive-fu540";

This doesn't match your schema which has 3 entries. Really, 4 entries
is kind of pointless typically. Usually, just a board and SoC
compatible are enough.

> +
> +       chosen {
> +       };
> +
> +       cpus {
> +               timebase-frequency = <RTCCLK_FREQ>;
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x2 0x00000000>;
> +       };
> +
> +       soc {
> +       };
> +
> +       hfclk: hfclk {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <33333333>;
> +               clock-output-names = "hfclk";
> +       };
> +
> +       rtcclk: rtcclk {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <RTCCLK_FREQ>;
> +               clock-output-names = "rtcclk";
> +       };
> +};
> +
> +&qspi0 {
> +       flash@0 {
> +               compatible = "issi,is25wp256d", "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <50000000>;
> +               m25p,fast-read;
> +               spi-tx-bus-width = <4>;
> +               spi-rx-bus-width = <4>;
> +       };
> +};
> +
> +&qspi2 {
> +       status = "okay";
> +       mmc@0 {
> +               compatible = "mmc-spi-slot";
> +               reg = <0>;
> +               spi-max-frequency = <20000000>;
> +               voltage-ranges = <3300 3300>;
> +               disable-wp;
> +       };
> +};
> --
> 2.20.1
>
