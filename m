Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC0C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC96520857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCLHbRFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDUMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 08:46:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42770 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 08:46:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id l124so3567786ybf.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myT7tykZSDSqli+c/3x9Y2IdDHrScUv8nPArHyOTp/g=;
        b=GCLHbRFO5E14+fWnUnZ69jnCVRmfqwEeX8bdJ1B3YjnjAoIpIuiTz45189eKkrHUDq
         sJXfMC5pkQS+J6yW3wMh8Ybl/m7+MNjxTgeWwqa9uif5zWwiKCl7emw5foDJhNzqyOOI
         aBOjj7lfIAxiJW2HZOf/2INgEVCQOgcwN6FhzzhGL5KgQepJuAWtosBRdnegSdtpKm/g
         lNoA/3qveWZKubw++B/q1nlbH7Yc0gePxR6Vbh5XDO6ufTb+ihRqmGj5Z1fpnDUzG6HX
         crTnUKAzntRMvMwHcVzfrmv7H51oEOR7x67YJixV8JHOWuLMpAlXxxkk/0nkR/s2by/3
         3R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myT7tykZSDSqli+c/3x9Y2IdDHrScUv8nPArHyOTp/g=;
        b=kRJAU3DomyP7q5Wn+4GcThv7aUPU2XmOJohMdxkyxWD2yZJXQN8O24NyH7Erkd/YnN
         AKdQVviBTtevfvvb45S2gntLaRe1Cpl0/0S5Wz7nlJSFRJA7hJV/+nklhQqGUaVD9XW0
         J3uT/O+l/VuKa4MFtR1RwUHkd40Rt/0qtiViIIlQ/nVKiZEr8bZXGOUlInzWzgytlvDu
         NG6wJVh6czcoPmUVI9uQLmhfxp5QRwHFiLHpfFEw8KVeAadz6Ft8RqH0ZqU6sEh1VeqY
         T7Ht3F/Zyy4PARKHSslqMHsjl9zhgfbWeZP16L+w0RQPDx/gjOF9fxk/LRnH8whCMQVM
         JdPw==
X-Gm-Message-State: APjAAAVlkXJ8WNp+a7VKgxzUmVo7z/0TjYJYgOShMv85NosfvFs+9H5c
        oPwosJZloWKbMuctyHo95wxWxQ==
X-Google-Smtp-Source: APXvYqy6Hpdbk9ShvRtua484kt3PjgRUcMQumFCMCcVgTFD1Yiywqc3xFUWyhdgL2DaTwneMGtgaww==
X-Received: by 2002:a25:2787:: with SMTP id n129mr12034354ybn.421.1555850783494;
        Sun, 21 Apr 2019 05:46:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id q81sm3390300ywb.87.2019.04.21.05.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 05:46:21 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:46:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzhuangluan@hisilicon.com
Subject: Re: [PATCH v4] arm64: dts: hi3660: Add CoreSight support
Message-ID: <20190421124606.GA12134@leoy-ThinkPad-X240s>
References: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 10:00:35PM +0800, Wanglai Shi wrote:
> This patch adds DT bindings for the CoreSight trace components
> on hi3660, which is used by 96boards Hikey960.
> 
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>

Reviewed this patch and tested on my Hikey960 board, FWIW:

Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 456 +++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   2 +
>  2 files changed, 458 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> new file mode 100644
> index 0000000..d607f2f
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
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
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
> +							<&combo_funnel_in0>;
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
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
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
> +							<&combo_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* An invisible combo funnel between clusters and top funnel */
> +		funnel {
> +			compatible = "arm,coresight-static-funnel";
> +			clocks = <&crg_ctrl HI3660_PCLK>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					combo_funnel_out: endpoint {
> +						remote-endpoint =
> +							<&top_funnel_in>;
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
> +					combo_funnel_in0: endpoint {
> +						remote-endpoint =
> +							<&cluster0_etf_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					combo_funnel_in1: endpoint {
> +						remote-endpoint =
> +							<&cluster1_etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Top internals */
> +		funnel@ec031000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
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
> +					top_funnel_in: endpoint {
> +						remote-endpoint =
> +							<&combo_funnel_out>;
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
> +			compatible = "arm,coresight-static-replicator";
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
> -- 
> 2.7.4
> 
