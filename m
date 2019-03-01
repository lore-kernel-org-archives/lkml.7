Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A71A2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge6UMN32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfCAHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:33:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44534 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbfCAHd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:33:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id a81so18717194oii.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LL74di2v344wM5jh41gOcwxQavrMBr1e1kWEddpsDAo=;
        b=Ge6UMN32q80H4NWTgqeY6la8P8iKXGkYdUs74Fs+25y2PYpRZwS6UTT8BQUkcNRtDE
         YVD8fTB/TuM3XXIqMeO21O5ENo7r6oByXOL/FZnq0toVdNulYaj6VNGHECJNLD6FOmiQ
         6uFLqzlTAJ+uw5uW1H0KH14EA74ihvrzAW9LkzG7Pk64D9imcvhm6WDHeM/i2YpIh2GL
         OY0QABzfUQ2oW7Vbg2W3qWvltWdHACxmHthieBByIJTolqFe6jb/lE+bhxd2DCAuAsKU
         QQSmGBP/o78tInxKg6pt0k5no2mYs3WemeySHl8ZlT76jx0s240BbRPSNVm8EvIjuPXj
         unvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LL74di2v344wM5jh41gOcwxQavrMBr1e1kWEddpsDAo=;
        b=Mz/0XATRQ73rm5zzP3Ykzyoi4iLMXfJ8WK3S4wxWSkLj0chALgygWT50hYwEqSndvy
         VJ9VgdEBuJJjNnl21r/52xH/sXbNV9go7B7TpKTqRr0Jm7/+5V1Aa3gqTQ8XTwzw0/Lb
         lvKx/lb29nHOBvUAJkyuAl7CY3WwjA/luT+NMorEk5CocYeKqWaRRXd1SUFKn5evA0rr
         C3BRCw5obMAZMsrE95mRMx8P2DAh//EzlwVQAnzxSM8qSb4VV2WYGupUCrobMExqWGda
         VBQwePUjrqt5AW70KHrdAHj8L6iyaGitZE8XW+F6XwSZ52iwRpQnvQvH1W+i4GTjKl69
         Ux/A==
X-Gm-Message-State: APjAAAX1C+5P9p9J5xvM8aRSTCaJ/M+YbV6GyQ8rtoyrIkLpYgttToT+
        LAK/a3jok10/VZOacORCv6rnaw==
X-Google-Smtp-Source: AHgI3IZAiOfLSda77E3eMo+AXCcuQdUQLoojoDMVpNzCUMeXmr8JN5TTUzTFXIS+UyQvCQBtsPK7sg==
X-Received: by 2002:aca:6209:: with SMTP id w9mr2536810oib.47.1551425604738;
        Thu, 28 Feb 2019 23:33:24 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li921-208.members.linode.com. [45.56.71.208])
        by smtp.gmail.com with ESMTPSA id v2sm8432273otk.60.2019.02.28.23.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 23:33:23 -0800 (PST)
Date:   Fri, 1 Mar 2019 15:33:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, john.stultz@linaro.org,
        xuwei5@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzhuangluan@hisilicon.com
Subject: Re: [PATCH v2] dts: arm64: add CoreSight trace support for hi3660
Message-ID: <20190301073317.GC5925@leoy-ThinkPad-X240s>
References: <1551335603-38766-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551335603-38766-1-git-send-email-shiwanglai@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanglai,

On Thu, Feb 28, 2019 at 02:33:23PM +0800, Wanglai Shi wrote:
> This patch adds devicetree entries for the CoreSight trace
>  components on hi3660.
> 
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>
> ---
>  .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 429 +++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   2 +
>  2 files changed, 431 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> new file mode 100644
> index 0000000..d651a8b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> @@ -0,0 +1,429 @@
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
> +	soc {
> +		/* A53 cluster internals */
> +		etm@ecc40000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xecc40000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +							<&cluster0_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ecd40000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xecd40000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +							<&cluster0_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ece40000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xece40000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +							<&cluster0_funnel_in2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ecf40000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xecf40000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +							<&cluster0_funnel_in3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@ec801000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0xec801000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					cluster0_funnel_out: endpoint {
> +						remote-endpoint =
> +							<&cluster0_etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					cluster0_funnel_in0: endpoint {
> +						remote-endpoint = <&etm0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					cluster0_funnel_in1: endpoint {
> +						remote-endpoint = <&etm1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					cluster0_funnel_in2: endpoint {
> +						remote-endpoint = <&etm2_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					cluster0_funnel_in3: endpoint {
> +						remote-endpoint = <&etm3_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf@ec802000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0xec802000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					cluster0_etf_in: endpoint {
> +						remote-endpoint =
> +							<&cluster0_funnel_out>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					cluster0_etf_out: endpoint {
> +						remote-endpoint =
> +							<&top_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* A73 cluster internals */
> +		etm@ed440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xed440000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +							<&cluster1_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ed540000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xed540000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +							<&cluster1_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ed640000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xed640000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +							<&cluster1_funnel_in2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@ed740000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0xed740000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +							<&cluster1_funnel_in3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@ed001000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0xed001000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +			out-ports {
> +				port {
> +					cluster1_funnel_out: endpoint {
> +						remote-endpoint =
> +							<&cluster1_etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					cluster1_funnel_in0: endpoint {
> +						remote-endpoint = <&etm4_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					cluster1_funnel_in1: endpoint {
> +						remote-endpoint = <&etm5_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					cluster1_funnel_in2: endpoint {
> +						remote-endpoint = <&etm6_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					cluster1_funnel_in3: endpoint {
> +						remote-endpoint = <&etm7_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf@ed002000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0xed002000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					cluster1_etf_in: endpoint {
> +						remote-endpoint =
> +							<&cluster1_funnel_out>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					cluster1_etf_out: endpoint {
> +						remote-endpoint =
> +							<&top_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Top internals */
> +		funnel@ec031000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0xec031000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					top_funnel_out: endpoint {
> +						remote-endpoint =
> +							<&top_etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					top_funnel_in0: endpoint {
> +						remote-endpoint =
> +							<&cluster0_etf_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <0>;

Here should s/<0>/<1>; otherwise DTC will complain warning for
mismatching between 'port@1' and 'reg = <0>'.

> +					/* there's an invisible funnel combo */
> +					/*   between clusters and top funnel */
> +					top_funnel_in1: endpoint {
> +						remote-endpoint =
> +							<&cluster1_etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf@ec036000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0xec036000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					top_etf_in: endpoint {
> +						remote-endpoint =
> +							<&top_funnel_out>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					top_etf_out: endpoint {
> +						remote-endpoint =
> +							<&replicator_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator {
> +			compatible = "arm,coresight-replicator";
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					replicator_in: endpoint {
> +						remote-endpoint =
> +							<&top_etf_out>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					replicator0_out0: endpoint {
> +						remote-endpoint = <&etr_in>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					replicator0_out1: endpoint {
> +						remote-endpoint = <&tpiu_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr@ec033000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0xec033000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint =
> +							<&replicator0_out0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tpiu@ec032000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0 0xec032000 0 0x1000>;
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					tpiu_in: endpoint {
> +						remote-endpoint =
> +							<&replicator0_out1>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index a4a3d08..8f2fede 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1246,3 +1246,5 @@
>  		};
>  	};
>  };
> +
> +#include "hi3660-coresight.dtsi"

Except the up mentioned issue, this patch looks good to me.

After applying this patch though I can see Coresight devices
under /sys/bus/coresight, but I cannot capture ETM trace data by
using below two commands:

  perf record -e cs_etm/@ec036000.etf/ --per-thread ./main
  perf record -e cs_etm/@ec033000.etr/ --per-thread ./main

I checked perf report command with '-D' option, I can see the
perf.data file doesn't contain any trace data from ETM.  could you
tell me which test command you are using?  At my side I will debug a
bit on my Hikey960 board and will keep you posted if find anything.

Thanks,
Leo Yan
