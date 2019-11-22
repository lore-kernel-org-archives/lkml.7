Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF9FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC622071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKVRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:22:49 -0500
Received: from foss.arm.com ([217.140.110.172]:50202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:22:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901CFDA7;
        Fri, 22 Nov 2019 09:22:46 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C19063F6C4;
        Fri, 22 Nov 2019 09:22:44 -0800 (PST)
Subject: Re: [PATCH 3/3] ARM: dts: at91: Remove the USB EP child node
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
References: <20191107153128.11038-1-gregory.clement@bootlin.com>
 <20191107153128.11038-4-gregory.clement@bootlin.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b13e902f-b375-02d3-e03d-80b5ae29f64c@arm.com>
Date:   Fri, 22 Nov 2019 17:22:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107153128.11038-4-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 3:31 pm, Gregory CLEMENT wrote:
> The endpoint configuration used to be stored in the device tree,
> however the configuration depend on the "version" of the controller
> itself.
> 
> Then the EP child node are useless and describe as deprecated in the
> documentation binding: remove all the nodes from the SoC device tree
> file.

Just as a drive-by comment, it's presumably worth getting rid of the 
#address-cells and #size-cells properties too (here and in the binding 
example).

Robin.

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>   arch/arm/boot/dts/at91sam9g45.dtsi |  52 -------------
>   arch/arm/boot/dts/at91sam9rl.dtsi  |  52 -------------
>   arch/arm/boot/dts/at91sam9x5.dtsi  |  52 -------------
>   arch/arm/boot/dts/sama5d2.dtsi     | 118 -----------------------------
>   arch/arm/boot/dts/sama5d3.dtsi     | 105 -------------------------
>   arch/arm/boot/dts/sama5d4.dtsi     | 118 -----------------------------
>   6 files changed, 497 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 691c95ea6175..63bfe546cd8d 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -1204,58 +1204,6 @@
>   				clocks = <&udphs_clk>, <&utmi>;
>   				clock-names = "pclk", "hclk";
>   				status = "disabled";
> -
> -				ep@0 {
> -					reg = <0>;
> -					atmel,fifo-size = <64>;
> -					atmel,nb-banks = <1>;
> -				};
> -
> -				ep@1 {
> -					reg = <1>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@2 {
> -					reg = <2>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@3 {
> -					reg = <3>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@4 {
> -					reg = <4>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@5 {
> -					reg = <5>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@6 {
> -					reg = <6>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
>   			};
>   
>   			clk32k: sckc@fffffd50 {
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index 8643b7151565..e118bacb7d7c 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -308,58 +308,6 @@
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>   				clock-names = "pclk", "hclk";
>   				status = "disabled";
> -
> -				ep@0 {
> -					reg = <0>;
> -					atmel,fifo-size = <64>;
> -					atmel,nb-banks = <1>;
> -				};
> -
> -				ep@1 {
> -					reg = <1>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@2 {
> -					reg = <2>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@3 {
> -					reg = <3>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@4 {
> -					reg = <4>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@5 {
> -					reg = <5>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@6 {
> -					reg = <6>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
>   			};
>   
>   			dma0: dma-controller@ffffe600 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 7c2eb93f8cac..685a1b9f3ae5 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -876,58 +876,6 @@
>   				clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 23>;
>   				clock-names = "hclk", "pclk";
>   				status = "disabled";
> -
> -				ep@0 {
> -					reg = <0>;
> -					atmel,fifo-size = <64>;
> -					atmel,nb-banks = <1>;
> -				};
> -
> -				ep@1 {
> -					reg = <1>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@2 {
> -					reg = <2>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <2>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@3 {
> -					reg = <3>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@4 {
> -					reg = <4>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -				};
> -
> -				ep@5 {
> -					reg = <5>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
> -
> -				ep@6 {
> -					reg = <6>;
> -					atmel,fifo-size = <1024>;
> -					atmel,nb-banks = <3>;
> -					atmel,can-dma;
> -					atmel,can-isoc;
> -				};
>   			};
>   
>   			watchdog: watchdog@fffffe40 {
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 2e2c1a7b1d1d..daafcffbe033 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -122,124 +122,6 @@
>   			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>   			clock-names = "pclk", "hclk";
>   			status = "disabled";
> -
> -			ep@0 {
> -				reg = <0>;
> -				atmel,fifo-size = <64>;
> -				atmel,nb-banks = <1>;
> -			};
> -
> -			ep@1 {
> -				reg = <1>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@2 {
> -				reg = <2>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@3 {
> -				reg = <3>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@4 {
> -				reg = <4>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@5 {
> -				reg = <5>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@6 {
> -				reg = <6>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@7 {
> -				reg = <7>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@8 {
> -				reg = <8>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@9 {
> -				reg = <9>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@10 {
> -				reg = <10>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@11 {
> -				reg = <11>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@12 {
> -				reg = <12>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@13 {
> -				reg = <13>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@14 {
> -				reg = <14>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@15 {
> -				reg = <15>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
>   		};
>   
>   		usb1: ohci@400000 {
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index f770aace0efd..dfd095f33f95 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -1402,111 +1402,6 @@
>   			clocks = <&udphs_clk>, <&utmi>;
>   			clock-names = "pclk", "hclk";
>   			status = "disabled";
> -
> -			ep@0 {
> -				reg = <0>;
> -				atmel,fifo-size = <64>;
> -				atmel,nb-banks = <1>;
> -			};
> -
> -			ep@1 {
> -				reg = <1>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@2 {
> -				reg = <2>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@3 {
> -				reg = <3>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -			};
> -
> -			ep@4 {
> -				reg = <4>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -			};
> -
> -			ep@5 {
> -				reg = <5>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -			};
> -
> -			ep@6 {
> -				reg = <6>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -			};
> -
> -			ep@7 {
> -				reg = <7>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -			};
> -
> -			ep@8 {
> -				reg = <8>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@9 {
> -				reg = <9>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@10 {
> -				reg = <10>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@11 {
> -				reg = <11>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@12 {
> -				reg = <12>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@13 {
> -				reg = <13>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@14 {
> -				reg = <14>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
> -
> -			ep@15 {
> -				reg = <15>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -			};
>   		};
>   
>   		usb1: ohci@600000 {
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 6ab27a7b388d..0ece6b22d287 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -105,124 +105,6 @@
>   			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>   			clock-names = "pclk", "hclk";
>   			status = "disabled";
> -
> -			ep@0 {
> -				reg = <0>;
> -				atmel,fifo-size = <64>;
> -				atmel,nb-banks = <1>;
> -			};
> -
> -			ep@1 {
> -				reg = <1>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@2 {
> -				reg = <2>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <3>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@3 {
> -				reg = <3>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@4 {
> -				reg = <4>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@5 {
> -				reg = <5>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@6 {
> -				reg = <6>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@7 {
> -				reg = <7>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-dma;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@8 {
> -				reg = <8>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@9 {
> -				reg = <9>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@10 {
> -				reg = <10>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@11 {
> -				reg = <11>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@12 {
> -				reg = <12>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@13 {
> -				reg = <13>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@14 {
> -				reg = <14>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
> -
> -			ep@15 {
> -				reg = <15>;
> -				atmel,fifo-size = <1024>;
> -				atmel,nb-banks = <2>;
> -				atmel,can-isoc;
> -			};
>   		};
>   
>   		usb1: ohci@500000 {
> 
