Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A051C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A120842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551785837;
	bh=zBK6Uvjj83Qq3JNg4jN/KAq++Jb6uDkpVNeD1bowK00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p3KKPNwuA4SUnXBKhpzI7WijlgJU2C3pPnzhiSooLKyN3gqqZm4uSUn6EbHUS5+1a
	 +zGACjAHu60Zyu1YWfE0Ms9TVs0pXQ8JUbMMgIrkjN6dm/TmWnJb1F2pb8Hc4fM25O
	 CwQdgqfUe6xD0RCGB4u56S5ClMJO3FUfXDnAV0V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCELhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfCELhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:37:14 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381612084F;
        Tue,  5 Mar 2019 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551785833;
        bh=zBK6Uvjj83Qq3JNg4jN/KAq++Jb6uDkpVNeD1bowK00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vykRdKzI81zfHO/TKWh5ptXiCN99IFu/Tihs0vYRsiB7KOYyFVeiBH4jqNdE9H/sH
         SNMUr1hmgRG46EjvkdUfoPtw34GoHKOrUrlJ3tWgFK6s9cyrldnEjjvx+nnoqmN1oS
         UJnHhpiJZ0ZM0QSyIfRekwOvBU863GTfjmn0QOj4=
Received: by mail-lj1-f182.google.com with SMTP id g80so7296184ljg.6;
        Tue, 05 Mar 2019 03:37:13 -0800 (PST)
X-Gm-Message-State: APjAAAV0Vf0kLdd3ru+FE9cW4YmW2++86vMwMR80P94L2h/7oSlW1UBM
        6l63WlRQbNJmjv/Z2JATkfa/EanQlH/Zfu9uUms=
X-Google-Smtp-Source: APXvYqxdQTU0XwBbzevBzjqIHkbV1xwi5zK3g84AA3Z+yy7tmPyGZ5uBtk4O94i0Y1OaaNYJ83zew+5WS9iKhoX515s=
X-Received: by 2002:a2e:780a:: with SMTP id t10mr11796636ljc.19.1551785831283;
 Tue, 05 Mar 2019 03:37:11 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023@eucas1p2.samsung.com>
 <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com> <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 5 Mar 2019 12:36:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdXQuGotKONE4GR8AZr1gMZHM3dgAu-TSKSDqVeYw5zWw@mail.gmail.com>
Message-ID: <CAJKOXPdXQuGotKONE4GR8AZr1gMZHM3dgAu-TSKSDqVeYw5zWw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] DT: arm: exynos: add DMC device for exynos5422
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
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 at 11:19, Lukasz Luba <l.luba@partner.samsung.com>
wrote:>> Add description of Dynamic Memory Controller and PPMU
counters.> They are used by exynos5422-dmc driver.>> Signed-off-by:
Lukasz Luba <l.luba@partner.samsung.com>In previous email I asked to
fix the subject prefix in case of resend. Please fix it.

> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 83 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 87 +++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..fc00fda 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -235,6 +235,41 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10000000 0x1000>;
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
> +                                <&clock CLK_CLKM_PHY1>,
> +                                <&clock CLK_CDREX_PAUSE>,
> +                                <&clock CLK_CDREX_TIMING_SET>;
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
> +                                     "clkm_phy1",
> +                                     "clk_cdrex_pause",
> +                                     "clk_cdrex_timing_set";
> +                       status = "disabled";
> +               };
> +
>                 nocp_mem0_0: nocp@10ca1000 {
>                         compatible = "samsung,exynos5420-nocp";
>                         reg = <0x10CA1000 0x200>;
> @@ -271,6 +306,54 @@
>                         status = "disabled";
>                 };
>
> +               ppmu_dmc0_0: ppmu@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
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
> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
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
> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                               };
> +                       };
> +               };
> +
>                 gsc_pd: power-domain@10044000 {
>                         compatible = "samsung,exynos4210-pd";
>                         reg = <0x10044000 0x20>;
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index bf09eab..6b28fb3 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -34,6 +34,69 @@
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
> +       dmc_bypass_mode: bypass_mode {
> +               compatible = "samsung,dmc-bypass-mode";
> +
> +               freq-hz = <400000000>;
> +               volt-uv = <887500>;
> +               dram-timing-row = <0x365a9713>;
> +               dram-timing-data = <0x4740085e>;
> +               dram-timing-power = <0x543a0446>;
> +       };
> +
> +       dram_timing: timing {
> +               compatible = "samsung,dram-timing";
> +
> +               dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
> +                                   "543MHz", "633MHz", "728MHz", "825MHz";
> +               dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
> +                                 <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
> +                                 <0x30598651>, <0x365A9713>;
> +               dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
> +                                  <0x2720085E>, <0x3730085E>, <0x3730085E>,
> +                                  <0x3730085E>, <0x4740085E>;
> +               dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
> +                                   <0x2C1D0225>, <0x38270335>, <0x402D0335>,
> +                                   <0x4C330336>, <0x543A0446>;
> +       };
>  };
>
>  &bus_wcore {
> @@ -127,6 +190,14 @@
>         cpu-supply = <&buck2_reg>;
>  };
>
> +&dmc {
> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +
> +       operating-points-v2 = <&dmc_opp_table>;

The opp-tables have voltage entry but I do not see the regulator
supply. How do you change the voltage?

Best regards,
Krzysztof
