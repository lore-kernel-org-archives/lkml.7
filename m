Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12009C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B5621738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556017398;
	bh=hOHMMIK8YJhoBNt6IMubNCxe3Gds0gx1M3Go4+P0VSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wEOkx2FeAP1OXIsmQPIoajlObRfzY9T0IT3VWl3tXQiWL+Lw/jpJsOVS33IB5eVp1
	 vk50iWlcdQKrOHB7XvgKcVZ/yQiI0xZ1SyDmchNRryodBvuXdZ1sUtEByKQfGKT+gH
	 Ksdo0qaF1j5G2kVkhNysxETuliX2Zx4vw6AdzDY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfDWLDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfDWLDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:03:17 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15420217D4;
        Tue, 23 Apr 2019 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556017395;
        bh=hOHMMIK8YJhoBNt6IMubNCxe3Gds0gx1M3Go4+P0VSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mX+NIEAM3rzR2FknXD6NR3Qa64g4d+jkA/iX9v3KFFNjc22QwFGVoQxIAECL+hSR6
         5hk6y6Aepc6vZSJX2tyXO0Tx2FXOH3yjDy4c3YzC6hJNxWXNauQJQKRBZkFJlLbnJs
         /ddOzBhQgeWFq8STXy7taZMj/i0qgDzq4wBpL4Ww=
Received: by mail-lj1-f170.google.com with SMTP id l23so2510617lja.3;
        Tue, 23 Apr 2019 04:03:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXf7TYP7Zi9GX3dLfoi1aMKBr22VFgkPRtw3RbOGxh2dQNqVBxN
        gCbWK8hbXp9aa6PpzUGNZkBSyCnZf8U1oOq5Ieo=
X-Google-Smtp-Source: APXvYqw/tp50vQEUwozb35XmiN8vnwOt06yho+vPB2c3tpYHGPeVd8GjjzJcP+skR3B78n7tVc8V5s+E7iy+9zTNHok=
X-Received: by 2002:a2e:9895:: with SMTP id b21mr13384386ljj.183.1556017393302;
 Tue, 23 Apr 2019 04:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb@eucas1p1.samsung.com>
 <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com> <1555683568-20882-10-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1555683568-20882-10-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Apr 2019 13:03:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfE2Kt_afkH6wryRgdVqfvDUH82rMf_iKFuvDVSH00LJw@mail.gmail.com>
Message-ID: <CAJKOXPfE2Kt_afkH6wryRgdVqfvDUH82rMf_iKFuvDVSH00LJw@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] ARM: dts: exynos: add DMC device for exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 at 16:19, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
> There is a definition of the memory chip, hwich is then used during

which

> calculation of timings for each OPP.
> The algorithm in the driver needs these two sets to bound the timings.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 120 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 120 ++++++++++++++++++++++++++
>  2 files changed, 240 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..b687cd7 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/exynos5420.h>
>  #include <dt-bindings/clock/exynos-audss-clk.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pmu/exynos_ppmu.h>
>
>  / {
>         compatible = "samsung,exynos5420", "samsung,exynos5";
> @@ -235,6 +236,37 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,

I think in the driver you access range up to 0xff of each DREX memory
region. Do not map entire 0x10000 if not needed.


> +                               <0x10000000 0x1000>, <0x10030000 0x1000>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                                <&clock CLK_MOUT_SCLK_SPLL>,
> +                                <&clock CLK_FF_DOUT_SPLL2>,
> +                                <&clock CLK_FOUT_BPLL>,
> +                                <&clock CLK_MOUT_BPLL>,
> +                                <&clock CLK_SCLK_BPLL>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                                <&clock CLK_MOUT_MCLK_CDREX>,
> +                                <&clock CLK_DOUT_CLK2X_PHY0>,
> +                                <&clock CLK_CLKM_PHY0>,
> +                                <&clock CLK_CLKM_PHY1>;
> +                       clock-names = "fout_spll",
> +                                     "mout_sclk_spll",
> +                                     "ff_dout_spll2",
> +                                     "fout_bpll",
> +                                     "mout_bpll",
> +                                     "sclk_bpll",
> +                                     "mout_mx_mspll_ccore",
> +                                     "mout_mx_mspll_ccore_phy",
> +                                     "mout_mclk_cdrex",
> +                                     "dout_clk2x_phy0",
> +                                     "clkm_phy0",
> +                                     "clkm_phy1";
> +                       status = "disabled";
> +               };
> +
>                 nocp_mem0_0: nocp@10ca1000 {
>                         compatible = "samsung,exynos5420-nocp";
>                         reg = <0x10CA1000 0x200>;
> @@ -271,6 +303,94 @@
>                         status = "disabled";
>                 };
>
> +               ppmu_dmc0_0: ppmu@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc0_0: ppmu-event0-dmc0_0 {
> +                                       event-name = "ppmu-event0-dmc0_0";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc0_0: ppmu-event1-dmc0_0 {
> +                                       event-name = "ppmu-event1-dmc0_0";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc0_1: ppmu@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d10000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc0_1: ppmu-event0-dmc0_1 {
> +                                       event-name = "ppmu-event0-dmc0_1";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc0_1: ppmu-event1-dmc0_1 {
> +                                       event-name = "ppmu-event1-dmc0_1";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu@10d60000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc1_0: ppmu-event0-dmc1_0 {
> +                                       event-name = "ppmu-event0-dmc1_0";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc1_0: ppmu-event1-dmc1_0 {
> +                                       event-name = "ppmu-event1-dmc1_0";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_1: ppmu@10d70000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d70000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event0_dmc1_1: ppmu-event0-dmc1_1 {
> +                                       event-name = "ppmu-event0-dmc1_1";
> +                                       event-data-type = <PPMU_RO_DATA_CNT>;
> +                               };
> +                               ppmu_event1_dmc1_1: ppmu-event1-dmc1_1 {
> +                                       event-name = "ppmu-event1-dmc1_1";
> +                                       event-data-type = <PPMU_WO_DATA_CNT>;
> +                               };
> +                               ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                                       event-data-type = <(PPMU_RO_DATA_CNT |
> +                                               PPMU_WO_DATA_CNT)>;
> +                               };
> +                       };
> +               };
> +
>                 gsc_pd: power-domain@10044000 {
>                         compatible = "samsung,exynos4210-pd";
>                         reg = <0x10044000 0x20>;
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 25d95de1..76bf0dbf 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -34,6 +34,95 @@
>                         clock-frequency = <24000000>;
>                 };
>         };
> +
> +       dmc_opp_table: opp_table2 {
> +               compatible = "operating-points-v2";
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <165000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <206000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <275000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <413000000>;
> +                       opp-microvolt = <887500>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <543000000>;
> +                       opp-microvolt = <937500>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <633000000>;
> +                       opp-microvolt = <1012500>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <728000000>;
> +                       opp-microvolt = <1037500>;
> +               };
> +               opp07 {
> +                       opp-hz = /bits/ 64 <825000000>;
> +                       opp-microvolt = <1050000>;
> +               };
> +       };
> +
> +       samsung_K3QF2F20DB: lpddr3 {
> +               compatible      = "Samsung,K3QF2F20DB","jedec,lpddr3";

Missing space after coma.

> +               density         = <16384>;
> +               io-width        = <32>;
> +
> +               tRFC-min-tck            = <17>;
> +               tRRD-min-tck            = <2>;
> +               tRPab-min-tck           = <2>;
> +               tRPpb-min-tck           = <2>;
> +               tRCD-min-tck            = <3>;
> +               tRC-min-tck             = <6>;
> +               tRAS-min-tck            = <5>;
> +               tWTR-min-tck            = <2>;
> +               tWR-min-tck             = <7>;
> +               tRTP-min-tck            = <2>;
> +               tW2W-C2C-min-tck        = <0>;
> +               tR2R-C2C-min-tck        = <0>;
> +               tWL-min-tck             = <8>;
> +               tDQSCK-min-tck          = <5>;
> +               tRL-min-tck             = <14>;
> +               tFAW-min-tck            = <5>;
> +               tXSR-min-tck            = <12>;
> +               tXP-min-tck             = <2>;
> +               tCKE-min-tck            = <2>;
> +               tCKESR-min-tck          = <2>;
> +               tMRD-min-tck            = <5>;
> +
> +               timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {

@0 does not look correct... you do not have <reg>. No DTC warnings here?

Best regards,
Krzysztof
