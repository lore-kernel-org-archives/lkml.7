Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC972084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570468187;
	bh=sEUyCrkWSJhUAah+kIOaxdt7uVOhlnp+VLGnLHpIjVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ckyh9O1nrfNCRldmmX4p7WbVfj5SPTt8OVhQ8VFdpXrwph0NO5LZ8s1SdNshKuhVe
	 1D4vqzXkD0UXZkQr5u8uCIBTVDPkZmkObdRpWdoiQ662lkkrS2TinfCH50aLkXWW7I
	 cyPBiPCU8Bnj3J+uUEOdbiXAvf7Hnx/GKElr6P6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfJGRJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfJGRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:09:43 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F22E2084D;
        Mon,  7 Oct 2019 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570468181;
        bh=sEUyCrkWSJhUAah+kIOaxdt7uVOhlnp+VLGnLHpIjVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ATaDT6kBWMNjukC/v/xuTue6EoXEpuIRJV2osq04lQ9SO6aes/2hdxPxkHoQlSfE/
         Vi3r8BZKZQCx521H+zrpoi4RXtkHoKWQJRsC9wM1m5XRl7DARdZYaGUSXuMZqMhUtR
         XsKHHvf3LrQpfIG4qAaaeZmaxPTWHFVzEptLQdHM=
Received: by mail-lj1-f174.google.com with SMTP id y3so14522354ljj.6;
        Mon, 07 Oct 2019 10:09:41 -0700 (PDT)
X-Gm-Message-State: APjAAAW1dgKuC8cF5XrrS219pddV1cZo/k7VSyaDdGfLNMthT9u9bjZa
        pNHyZ/g56AwWlu+M4OyzQTQ+js93vAlSdh6txxE=
X-Google-Smtp-Source: APXvYqxsj2x2Dds3Uzee66b/2onTiWHkAnOmZ53UVQGb37tOsYvxS4qruO2qWrwZKDnFs80J+RochL5wu/NKYF+dsQE=
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr19200320ljm.93.1570468179431;
 Mon, 07 Oct 2019 10:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <5d9a8a3c.1c69fb81.14b6f.10d1@mx.google.com>
In-Reply-To: <5d9a8a3c.1c69fb81.14b6f.10d1@mx.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 7 Oct 2019 19:09:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeZQ_hZqUdtFrr-wGiwdM4KVjD_7CArEWhZgo+1EJPqew@mail.gmail.com>
Message-ID: <CAJKOXPeZQ_hZqUdtFrr-wGiwdM4KVjD_7CArEWhZgo+1EJPqew@mail.gmail.com>
Subject: Re: krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on peach-pi
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 at 02:43, kernelci.org bot <bot@kernelci.org> wrote:
>
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> krzysztof/for-next boot bisection: v5.4-rc1-48-g0bc9c79979ea on peach-pi
>
> Summary:
>   Start:      0bc9c79979ea Merge branch 'for-v5.5/memory-samsung-dmc-dt' into for-next
>   Details:    https://kernelci.org/boot/id/5d9a50af59b5141ce5857c07
>   Plain log:  https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.txt
>   HTML log:   https://storage.kernelci.org//krzysztof/for-next/v5.4-rc1-48-g0bc9c79979ea/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.html
>   Result:     0899a480ac65 ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800

Thanks for the report. Marek Szyprowski reported it on last Friday. I
dropped the patch as of now as it exposes some deadlock in regulator
code.

Best regards,
Krzysztof

>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       krzysztof
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>   Branch:     for-next
>   Target:     peach-pi
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 0899a480ac658144b1fa351bb880c2858d43f824
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Thu Oct 3 12:08:14 2019 +0200
>
>     ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
>
>     Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
>     bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
>     be in 300mV range.
>
>     Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>     [k.konieczny: add missing patch description]
>     Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>     Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>     Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 2c131ad78c09..d08101b1018c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -48,62 +48,62 @@
>
>                 opp-1800000000 {
>                         opp-hz = /bits/ 64 <1800000000>;
> -                       opp-microvolt = <1250000>;
> +                       opp-microvolt = <1250000 1250000 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1700000000 {
>                         opp-hz = /bits/ 64 <1700000000>;
> -                       opp-microvolt = <1212500>;
> +                       opp-microvolt = <1212500 1212500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1600000000 {
>                         opp-hz = /bits/ 64 <1600000000>;
> -                       opp-microvolt = <1175000>;
> +                       opp-microvolt = <1175000 1175000 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1500000000 {
>                         opp-hz = /bits/ 64 <1500000000>;
> -                       opp-microvolt = <1137500>;
> +                       opp-microvolt = <1137500 1137500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1400000000 {
>                         opp-hz = /bits/ 64 <1400000000>;
> -                       opp-microvolt = <1112500>;
> +                       opp-microvolt = <1112500 1112500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1300000000 {
>                         opp-hz = /bits/ 64 <1300000000>;
> -                       opp-microvolt = <1062500>;
> +                       opp-microvolt = <1062500 1062500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1200000000 {
>                         opp-hz = /bits/ 64 <1200000000>;
> -                       opp-microvolt = <1037500>;
> +                       opp-microvolt = <1037500 1037500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1100000000 {
>                         opp-hz = /bits/ 64 <1100000000>;
> -                       opp-microvolt = <1012500>;
> +                       opp-microvolt = <1012500 1012500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-1000000000 {
>                         opp-hz = /bits/ 64 <1000000000>;
> -                       opp-microvolt = < 987500>;
> +                       opp-microvolt = < 987500 987500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-900000000 {
>                         opp-hz = /bits/ 64 <900000000>;
> -                       opp-microvolt = < 962500>;
> +                       opp-microvolt = < 962500 962500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-800000000 {
>                         opp-hz = /bits/ 64 <800000000>;
> -                       opp-microvolt = < 937500>;
> +                       opp-microvolt = < 937500 937500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>                 opp-700000000 {
>                         opp-hz = /bits/ 64 <700000000>;
> -                       opp-microvolt = < 912500>;
> +                       opp-microvolt = < 912500 912500 1500000>;
>                         clock-latency-ns = <140000>;
>                 };
>         };
> @@ -1097,23 +1097,23 @@
>
>                         opp00 {
>                                 opp-hz = /bits/ 64 <84000000>;
> -                               opp-microvolt = <925000>;
> +                               opp-microvolt = <925000 925000 1400000>;
>                         };
>                         opp01 {
>                                 opp-hz = /bits/ 64 <111000000>;
> -                               opp-microvolt = <950000>;
> +                               opp-microvolt = <950000 950000 1400000>;
>                         };
>                         opp02 {
>                                 opp-hz = /bits/ 64 <222000000>;
> -                               opp-microvolt = <950000>;
> +                               opp-microvolt = <950000 950000 1400000>;
>                         };
>                         opp03 {
>                                 opp-hz = /bits/ 64 <333000000>;
> -                               opp-microvolt = <950000>;
> +                               opp-microvolt = <950000 950000 1400000>;
>                         };
>                         opp04 {
>                                 opp-hz = /bits/ 64 <400000000>;
> -                               opp-microvolt = <987500>;
> +                               opp-microvolt = <987500 987500 1400000>;
>                         };
>                 };
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 829147e320e0..9b8de61b0385 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -524,6 +524,8 @@
>                                 regulator-max-microvolt = <1400000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-coupled-with = <&buck2_reg>;
> +                               regulator-coupled-max-spread = <300000>;
>
>                                 regulator-state-mem {
>                                         regulator-off-in-suspend;
> @@ -544,6 +546,8 @@
>                                 regulator-max-microvolt = <1500000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-coupled-with = <&buck3_reg>;
> +                               regulator-coupled-max-spread = <300000>;
>
>                                 regulator-state-mem {
>                                         regulator-off-in-suspend;
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 60ca3d685247..c1e38139ce4f 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -257,6 +257,8 @@
>                                 regulator-always-on;
>                                 regulator-boot-on;
>                                 regulator-ramp-delay = <12500>;
> +                               regulator-coupled-with = <&buck3_reg>;
> +                               regulator-coupled-max-spread = <300000>;
>                                 regulator-state-mem {
>                                         regulator-off-in-suspend;
>                                 };
> @@ -269,6 +271,8 @@
>                                 regulator-always-on;
>                                 regulator-boot-on;
>                                 regulator-ramp-delay = <12500>;
> +                               regulator-coupled-with = <&buck2_reg>;
> +                               regulator-coupled-max-spread = <300000>;
>                                 regulator-state-mem {
>                                         regulator-off-in-suspend;
>                                 };
> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> index de639eecc5c9..27789f5f9798 100644
> --- a/arch/arm/boot/dts/exynos5800.dtsi
> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> @@ -22,61 +22,61 @@
>
>  &cluster_a15_opp_table {
>         opp-1700000000 {
> -               opp-microvolt = <1250000>;
> +               opp-microvolt = <1250000 1250000 1500000>;
>         };
>         opp-1600000000 {
> -               opp-microvolt = <1250000>;
> +               opp-microvolt = <1250000 1250000 1500000>;
>         };
>         opp-1500000000 {
> -               opp-microvolt = <1100000>;
> +               opp-microvolt = <1100000 1100000 1500000>;
>         };
>         opp-1400000000 {
> -               opp-microvolt = <1100000>;
> +               opp-microvolt = <1100000 1100000 1500000>;
>         };
>         opp-1300000000 {
> -               opp-microvolt = <1100000>;
> +               opp-microvolt = <1100000 1100000 1500000>;
>         };
>         opp-1200000000 {
> -               opp-microvolt = <1000000>;
> +               opp-microvolt = <1000000 1000000 1500000>;
>         };
>         opp-1100000000 {
> -               opp-microvolt = <1000000>;
> +               opp-microvolt = <1000000 1000000 1500000>;
>         };
>         opp-1000000000 {
> -               opp-microvolt = <1000000>;
> +               opp-microvolt = <1000000 1000000 1500000>;
>         };
>         opp-900000000 {
> -               opp-microvolt = <1000000>;
> +               opp-microvolt = <1000000 1000000 1500000>;
>         };
>         opp-800000000 {
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>         };
>         opp-700000000 {
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>         };
>         opp-600000000 {
>                 opp-hz = /bits/ 64 <600000000>;
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>                 clock-latency-ns = <140000>;
>         };
>         opp-500000000 {
>                 opp-hz = /bits/ 64 <500000000>;
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>                 clock-latency-ns = <140000>;
>         };
>         opp-400000000 {
>                 opp-hz = /bits/ 64 <400000000>;
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>                 clock-latency-ns = <140000>;
>         };
>         opp-300000000 {
>                 opp-hz = /bits/ 64 <300000000>;
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>                 clock-latency-ns = <140000>;
>         };
>         opp-200000000 {
>                 opp-hz = /bits/ 64 <200000000>;
> -               opp-microvolt = <900000>;
> +               opp-microvolt = <900000 900000 1500000>;
>                 clock-latency-ns = <140000>;
>         };
>  };
> -------------------------------------------------------------------------------
>
>
> Git bisection log:
>
> -------------------------------------------------------------------------------
> git bisect start
> # good: [2924a93b4c2b1934c0ec59d28f46814a83259f11] Merge branch 'for-v5.5/memory-samsung-dmc-dt' into for-next
> git bisect good 2924a93b4c2b1934c0ec59d28f46814a83259f11
> # bad: [0bc9c79979ea0b607a0751968840483fd296f6ef] Merge branch 'for-v5.5/memory-samsung-dmc-dt' into for-next
> git bisect bad 0bc9c79979ea0b607a0751968840483fd296f6ef
> # bad: [0899a480ac658144b1fa351bb880c2858d43f824] ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
> git bisect bad 0899a480ac658144b1fa351bb880c2858d43f824
> # good: [56c126e87e2980d5e2ca5d77b28899f8521af9d7] ARM: dts: exynos: Rename SysRAM node to "sram"
> git bisect good 56c126e87e2980d5e2ca5d77b28899f8521af9d7
> # first bad commit: [0899a480ac658144b1fa351bb880c2858d43f824] ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
> -------------------------------------------------------------------------------
