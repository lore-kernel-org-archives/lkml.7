Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80181C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDLKlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:41:06 -0400
Received: from foss.arm.com ([217.140.101.70]:57922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLKlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:41:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0123B15AB;
        Fri, 12 Apr 2019 03:41:05 -0700 (PDT)
Received: from [10.37.13.120] (unknown [10.37.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10173F718;
        Fri, 12 Apr 2019 03:41:02 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: coresight: Unify funnel DT
 binding
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shiwanglai@hisilicon.com
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-4-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <63901a4c-2f34-a688-48b3-77b3dd8bb5d9@arm.com>
Date:   Fri, 12 Apr 2019 11:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190412102738.12679-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 11:27 AM, Leo Yan wrote:
> Following the same fashion with replicator DT binding, this patch is to
> unify the DT binding for funnel to support static and dynamic modes;
> finally we get the funnel DT binding as below:
> 
> Before patch:
> 
>    Static funnel, aka. non-configurable funnel:
>      Not supported;
> 
>    Dynamic funnel, aka. configurable funnel:
>      "arm,coresight-funnel", "arm,primecell";
> 
> After patch:
> 
>    Static funnel:
>      "arm,coresight-static-funnel";
> 
>    Dynamic funnel:
>      "arm,coresight-dynamic-funnel", "arm,primecell";
>      "arm,coresight-funnel", "arm,primecell"; (obsolete)
> 
> At the end of this patch, it gives an example for static funnel DT
> binding, and updates the dynamic funnel example.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   .../devicetree/bindings/arm/coresight.txt     | 53 +++++++++++++++++--
>   1 file changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d02d160fa8ac..8a88ddebc1a2 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -8,7 +8,8 @@ through the intermediate links connecting the source to the currently selected
>   sink. Each CoreSight component device should use these properties to describe
>   its hardware characteristcs.
>   
> -* Required properties for all components *except* non-configurable replicators:
> +* Required properties for all components *except* non-configurable replicators
> +  and non-configurable funnels:
>   
>   	* compatible: These have to be supplemented with "arm,primecell" as
>   	  drivers are using the AMBA bus interface.  Possible values include:
> @@ -24,8 +25,10 @@ its hardware characteristcs.
>   		  discovered at boot time when the device is probed.
>   			"arm,coresight-tmc", "arm,primecell";
>   
> -		- Trace Funnel:
> -			"arm,coresight-funnel", "arm,primecell";
> +		- Trace Programmable Funnel:
> +			"arm,coresight-dynamic-funnel", "arm,primecell";
> +			"arm,coresight-funnel", "arm,primecell"; (OBSOLETE. For
> +				backward compatibility and will be removed)
>   
>   		- Embedded Trace Macrocell (version 3.x) and
>   					Program Flow Trace Macrocell:
> @@ -65,7 +68,7 @@ its hardware characteristcs.
>   	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
>   
>   * Required properties for devices that don't show up on the AMBA bus, such as
> -  non-configurable replicators:
> +  non-configurable replicators and non-configurable funnels:
>   
>   	* compatible: Currently supported value is (note the absence of the
>   	  AMBA markee):
> @@ -74,6 +77,9 @@ its hardware characteristcs.
>   			"arm,coresight-replicator"; (OBSOLETE. For backward
>   				compatibility and will be removed)
>   
> +		- Coresight Non-configurable Funnel:
> +			"arm,coresight-static-funnel";
> +
>   	* port or ports: see "Graph bindings for Coresight" below.
>   
>   * Optional properties for ETM/PTMs:
> @@ -203,8 +209,45 @@ Example:
>   		};
>   	};
>   
> +	funnel {
> +		/*
> +		 * non-configurable funnel don't show up on the AMBA
> +		 * bus.  As such no need to add "arm,primecell".
> +		 */
> +		compatible = "arm,coresight-static-funnel";
> +		clocks = <&crg_ctrl HI3660_PCLK>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				combo_funnel_out: endpoint {
> +					remote-endpoint = <&top_funnel_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				combo_funnel_in0: endpoint {
> +					remote-endpoint = <&cluster0_etf_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				combo_funnel_in1: endpoint {
> +					remote-endpoint = <&cluster1_etf_out>;
> +				};
> +			};
> +		};
> +	};
> +
>   	funnel@20040000 {
> -		compatible = "arm,coresight-funnel", "arm,primecell";
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>   		reg = <0 0x20040000 0 0x1000>;
>   
>   		clocks = <&oscclk6a>;
> 


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


