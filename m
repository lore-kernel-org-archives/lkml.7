Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6A921920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfJJHjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:39:45 -0400
Received: from mail1.windriver.com ([147.11.146.13]:44333 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733084AbfJJHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:36:16 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id x9A7ZqPj005366
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 10 Oct 2019 00:35:52 -0700 (PDT)
Received: from [128.224.158.243] (128.224.158.243) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Thu, 10 Oct 2019
 00:35:52 -0700
Subject: Re: [PATCH] ARM: dts: zynq: enablement of coresight topology
To:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>
CC:     Zumeng Chen <zumeng.chen@windriver.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-boot@lists.denx.de>
References: <a38ab93d870a3b1b341a5c0da14fc7f3d4056684.1570630040.git.michal.simek@xilinx.com>
From:   qwang2 <quanyang.wang@windriver.com>
Message-ID: <eb198b89-3b4a-4090-acc5-db036dd0be69@windriver.com>
Date:   Thu, 10 Oct 2019 15:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a38ab93d870a3b1b341a5c0da14fc7f3d4056684.1570630040.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/19 10:07 PM, Michal Simek wrote:
> From: Zumeng Chen <zumeng.chen@windriver.com>
>
> This patch is to build the coresight topology structure of zynq-7000
> series according to the docs of coresight and userguide of zynq-7000.
>
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>   arch/arm/boot/dts/zynq-7000.dtsi | 158 +++++++++++++++++++++++++++++++
>   1 file changed, 158 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index ca6425ad794c..86430ad76fee 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -59,6 +59,40 @@
>   		regulator-always-on;
>   	};
>   
> +	replicator {
> +		compatible = "arm,coresight-static-replicator";
> +		clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +		clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +		out-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* replicator output ports */
> +			port@0 {
> +				reg = <0>;
> +				replicator_out_port0: endpoint {
> +					remote-endpoint = <&tpiu_in_port>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				replicator_out_port1: endpoint {
> +					remote-endpoint = <&etb_in_port>;
> +				};
> +			};
> +		};
> +		in-ports {
> +			/* replicator input port */
> +			port {
> +				replicator_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&funnel_out_port>;
> +				};
> +			};
> +		};
> +	};
> +
>   	amba: amba {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
> @@ -365,5 +399,129 @@
>   			reg = <0xf8005000 0x1000>;
>   			timeout-sec = <10>;
>   		};
> +
> +		etb@f8801000 {
> +			compatible = "arm,coresight-etb10", "arm,primecell";
> +			reg = <0xf8801000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			in-ports {
> +				port {
> +					etb_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tpiu@f8803000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0xf8803000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			in-ports {
> +				port {
> +					tpiu_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@f8804000 {
> +			compatible = "arm,coresight-static-funnel", "arm,primecell";
> +			reg = <0xf8804000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +			/* funnel output ports */
> +			out-ports {
> +				port {
> +					funnel_out_port: endpoint {
> +						remote-endpoint =
> +							<&replicator_in_port0>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel input ports */
> +				port@0 {
> +					reg = <0>;
> +					funnel0_in_port0: endpoint {
> +						remote-endpoint = <&ptm0_out_port>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					funnel0_in_port1: endpoint {
> +						remote-endpoint = <&ptm1_out_port>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					funnel0_in_port2: endpoint {
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					funnel0_in_port3: endpoint {
> +						remote-endpoint = <&itm_out_port>;
> +					};
> +				};
> +				/* The other input ports are not connect to anything */
> +			};
> +		};
> +
> +		/* ITM is not supported by kernel, only leave device node here */
> +		itm@f8805000 {
> +			compatible = "arm,coresight-etm3x", "arm,primecell";

The "arm,coresight-etm3x" shouldn't be the compatible property for ITM. 
Had better remove it.

Thanks,

Quanyang

> +			reg = <0xf8805000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			out-ports {
> +				port {
> +					itm_out_port: endpoint {
> +						remote-endpoint = <&funnel0_in_port3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ptm@f889c000 {
> +			compatible = "arm,coresight-etm3x", "arm,primecell";
> +			reg = <0xf889c000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			cpu = <&cpu0>;
> +			out-ports {
> +				port {
> +					ptm0_out_port: endpoint {
> +						remote-endpoint = <&funnel0_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ptm@f889d000 {
> +			compatible = "arm,coresight-etm3x", "arm,primecell";
> +			reg = <0xf889d000 0x1000>;
> +			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +			cpu = <&cpu1>;
> +			out-ports {
> +				port {
> +					ptm1_out_port: endpoint {
> +						remote-endpoint = <&funnel0_in_port1>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   };
