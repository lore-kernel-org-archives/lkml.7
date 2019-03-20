Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75189C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0F021873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Psmztk+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCTRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37729 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfCTRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:35 -0400
Received: by mail-it1-f193.google.com with SMTP id z124so93877itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKVkMXmFVhKKZKF6y1mxqqvisMr1eOf6CiGQJGgUXTA=;
        b=Psmztk+xV8+nQ38OR9y1P1Rz6TAsFWzGPbCl+cu+JLnLCzF69XkrXPEGfie2bv870j
         fr+fuhqOWM4KZLobtj2lRGpZXM19mTQYDEnhq8ZD2HTnLdxmh4g2wggdzrGm0ff1L8kW
         co2dMs0vve+UC72DIHJPUElVsOaJwq2iBVDjm/kWj/B6OdkGK8Sx1SrrCrIJlKBVE1b8
         kfRUClamIv6anEt8vxvXb9eyHiG+jNaLSnrPilFgxeo0TvwIlrCfrLxSnGSbGfpelKCm
         SgpA2NtrKm91KzgDXd/Rvzd3mwrZ7CG0MzRM1QF9FBuMLEMwr0AecgD91LKSmPaolPQ+
         BwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKVkMXmFVhKKZKF6y1mxqqvisMr1eOf6CiGQJGgUXTA=;
        b=hVwsbZRDXaAjAwuGXvEZbTtbmkvTZ5unwrJD7TdI2Kf4grZ19ngV9PYiB4BHImCxMM
         naHrYEUkCMwJ94rgT+GXq9HeEL8N26xnHgFJsWLQC4pSuX2Dbxg1QFJCymll84gywlgt
         K8anEDtqSTfQG2s5yaVZzYrYk6zbwnzKkNp75dtnALagXb9wRedyLgrIXHNyI4kheDCQ
         dvGjYgnl1g5dlCFfQeXoCw6MgfJHwsMB1Arhjf6gD4zGUyu91PYLeUsjYO4yucGN6aI1
         trxncVgemwiDW8eDR1rIHgPgqaAHV4KlUDY500xeesLPORWZsuf5gdpM1hKiucIXeQB1
         MvuA==
X-Gm-Message-State: APjAAAWuIUSnzC2sY8Pwxi1m3VzkobgHSOitA5Y7w3pkNm/DE+fOm57T
        vewyp6mqkIDMF6lWfLT+Dx20+EV6BcpSG9iGBye4Pq+I
X-Google-Smtp-Source: APXvYqwJZ/VrHU9bqQ6doYwg5WdT0eP/ZRroVZij1/Zi8ovopiZThJqB0yBpCmHM7U5QNIN3iNgU4HtjNIsj1/LZVrs=
X-Received: by 2002:a02:b883:: with SMTP id p3mr5881426jam.71.1553103334513;
 Wed, 20 Mar 2019 10:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com> <1553085490-42870-4-git-send-email-shiwanglai@hisilicon.com>
In-Reply-To: <1553085490-42870-4-git-send-email-shiwanglai@hisilicon.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 20 Mar 2019 11:35:23 -0600
Message-ID: <CANLsYkzPV9t=wxOZjFDmxX+PUDhTo2i53cGrBBVUOmaVFijYsQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: hi3660: Add CoreSight support
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        xuwei <xuwei5@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 06:54, Wanglai Shi <shiwanglai@hisilicon.com> wrote:
>
> This patch adds DT bindings for the CoreSight trace components
> on hi3660, which is used by 96boards Hikey960.
>
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>

This patch too needs to be on its own since it is maintained by Wei.

Thanks,
Mathieu
> ---
>  .../boot/dts/hisilicon/hi3660-coresight.dtsi  | 456 ++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   2 +
>  2 files changed, 458 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> new file mode 100644
> index 000000000000..b6271fb407b7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * dtsi for Hisilicon Hi3660 Coresight
> + *
> + * Copyright (C) 2016-2018 Hisilicon Ltd.
> + *
> + * Author: Wanglai Shi <shiwanglai@hisilicon.com>
> + *
> + */
> +/ {
> +       soc {
> +               /* A53 cluster internals */
> +               etm@ecc40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xecc40000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu0>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm0_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ecd40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xecd40000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu1>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm1_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ece40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xece40000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu2>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm2_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ecf40000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xecf40000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu3>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm3_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_funnel_in3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@ec801000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0xec801000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       cluster0_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_etf_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       cluster0_funnel_in0: endpoint {
> +                                               remote-endpoint = <&etm0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       cluster0_funnel_in1: endpoint {
> +                                               remote-endpoint = <&etm1_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +                                       cluster0_funnel_in2: endpoint {
> +                                               remote-endpoint = <&etm2_out>;
> +                                       };
> +                               };
> +
> +                               port@3 {
> +                                       reg = <3>;
> +                                       cluster0_funnel_in3: endpoint {
> +                                               remote-endpoint = <&etm3_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@ec802000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0 0xec802000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       cluster0_etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       cluster0_etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&combo_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               /* A73 cluster internals */
> +               etm@ed440000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xed440000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu4>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm4_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_funnel_in0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ed540000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xed540000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu5>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm5_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ed640000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xed640000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu6>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm6_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_funnel_in2>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm@ed740000 {
> +                       compatible = "arm,coresight-etm4x", "arm,primecell";
> +                       reg = <0 0xed740000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       cpu = <&cpu7>;
> +
> +                       out-ports {
> +                               port {
> +                                       etm7_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_funnel_in3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@ed001000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0xed001000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +                       out-ports {
> +                               port {
> +                                       cluster1_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_etf_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       cluster1_funnel_in0: endpoint {
> +                                               remote-endpoint = <&etm4_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       cluster1_funnel_in1: endpoint {
> +                                               remote-endpoint = <&etm5_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +                                       cluster1_funnel_in2: endpoint {
> +                                               remote-endpoint = <&etm6_out>;
> +                                       };
> +                               };
> +
> +                               port@3 {
> +                                       reg = <3>;
> +                                       cluster1_funnel_in3: endpoint {
> +                                               remote-endpoint = <&etm7_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@ed002000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0 0xed002000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       cluster1_etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       cluster1_etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&combo_funnel_in1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               /* An invisible combo funnel between clusters and top funnel */
> +               funnel {
> +                       compatible = "arm,coresight-funnel";
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       combo_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&top_funnel_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       combo_funnel_in0: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster0_etf_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       combo_funnel_in1: endpoint {
> +                                               remote-endpoint =
> +                                                       <&cluster1_etf_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               /* Top internals */
> +               funnel@ec031000 {
> +                       compatible = "arm,coresight-funnel", "arm,primecell";
> +                       reg = <0 0xec031000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       top_funnel_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&top_etf_in>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       top_funnel_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&combo_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etf@ec036000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0 0xec036000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       top_etf_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&top_funnel_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               port {
> +                                       top_etf_out: endpoint {
> +                                               remote-endpoint =
> +                                                       <&replicator_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               replicator {
> +                       compatible = "arm,coresight-replicator";
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       replicator_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&top_etf_out>;
> +                                       };
> +                               };
> +                       };
> +
> +                       out-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       replicator0_out0: endpoint {
> +                                               remote-endpoint = <&etr_in>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       replicator0_out1: endpoint {
> +                                               remote-endpoint = <&tpiu_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etr@ec033000 {
> +                       compatible = "arm,coresight-tmc", "arm,primecell";
> +                       reg = <0 0xec033000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       etr_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&replicator0_out0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               tpiu@ec032000 {
> +                       compatible = "arm,coresight-tpiu", "arm,primecell";
> +                       reg = <0 0xec032000 0 0x1000>;
> +                       clocks = <&crg_ctrl HI3660_PCLK>;
> +                       clock-names = "apb_pclk";
> +
> +                       in-ports {
> +                               port {
> +                                       tpiu_in: endpoint {
> +                                               remote-endpoint =
> +                                                       <&replicator0_out1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 57ebefbd156f..36fdc9cd443d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1216,3 +1216,5 @@
>                 };
>         };
>  };
> +
> +#include "hi3660-coresight.dtsi"
> --
> 2.17.1
>
