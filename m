Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A12C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3E2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDAKBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:01:02 -0400
Received: from foss.arm.com ([217.140.101.70]:59718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDAKBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:01:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54F1A78;
        Mon,  1 Apr 2019 03:01:00 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49BA23F690;
        Mon,  1 Apr 2019 03:00:59 -0700 (PDT)
Subject: Re: [PATCH v4] dt-bindings: gpu: add bindings for the ARM Mali
 Bifrost GPU
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190401080949.14550-1-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1640dd7b-3576-d9ce-0641-6b6a64a87275@arm.com>
Date:   Mon, 1 Apr 2019 11:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401080949.14550-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 09:09, Neil Armstrong wrote:
> Add the bindings for the Bifrost family of ARM Mali GPUs.
> 
> The Bifrost GPU architecture is similar to the Midgard family,
> but with a different Shader Core & Execution Engine structures.
> 
> Bindings are based on the Midgard family bindings, but the inner
> architectural changes makes it a separate family needing separate
> bindings.
> 
> The Bifrost GPUs are present in a number of recent SoCs, like the
> Amlogic G12A Family, and many other vendors.
> The Amlogic vendor specific compatible is added to handle the
> specific IP integration differences and dependencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.txt         | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> 
> Changes since v3:
> - Added note about discoverable model/revision
> - Enforced fixed defined irq order
> - Fixed typo in accommodate
> 
> Changes since v2:
> - moved to a single compatible since HW is fully discoverable
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> new file mode 100644
> index 000000000000..711c9ead17a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> @@ -0,0 +1,92 @@
> +ARM Mali Bifrost GPU
> +====================
> +
> +Required properties:
> +
> +- compatible :
> +  * Since Mali Bifrost GPU model/revision if fully discoverable by reading
                                             ^^
s/if/is/

> +    some determined registers, must contain the following:
> +    + "arm,mali-bifrost"
> +  * which must be preceded by one of the following vendor specifics:
> +    + "amlogic,meson-g12a-mali"
> +
> +- reg : Physical base address of the device and length of the register area.
> +
> +- interrupts : Contains the three IRQ lines required by Mali Bifrost devices,
> +  in the following defined order.
> +
> +- interrupt-names : Contains the names of IRQ resources in this exact defined
> +  order: "job", "mmu", "gpu".

Is there any point in having "interrupt-names" if we're fixing the
order? Although I guess it helps match the Midgard bindings.

Steve

> +
> +Optional properties:
> +
> +- clocks : Phandle to clock for the Mali Bifrost device.
> +
> +- mali-supply : Phandle to regulator for the Mali device. Refer to
> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +
> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> +  for details.
> +
> +- resets : Phandle of the GPU reset line.
> +
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accommodate those differences, you have the option
> +to specify one more vendor-specific compatible, among:
> +
> +- "amlogic,meson-g12a-mali"
> +  Required properties:
> +  - resets : Should contain phandles of :
> +    + GPU reset line
> +    + GPU APB glue reset line
> +
> +Example for a Mali-G31:
> +
> +gpu@ffa30000 {
> +	compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
> +	reg = <0xffe40000 0x10000>;
> +	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "job", "mmu", "gpu";
> +	clocks = <&clk CLKID_MALI>;
> +	mali-supply = <&vdd_gpu>;
> +	operating-points-v2 = <&gpu_opp_table>;
> +	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
> +};
> +
> +gpu_opp_table: opp_table0 {
> +	compatible = "operating-points-v2";
> +
> +	opp@533000000 {
> +		opp-hz = /bits/ 64 <533000000>;
> +		opp-microvolt = <1250000>;
> +	};
> +	opp@450000000 {
> +		opp-hz = /bits/ 64 <450000000>;
> +		opp-microvolt = <1150000>;
> +	};
> +	opp@400000000 {
> +		opp-hz = /bits/ 64 <400000000>;
> +		opp-microvolt = <1125000>;
> +	};
> +	opp@350000000 {
> +		opp-hz = /bits/ 64 <350000000>;
> +		opp-microvolt = <1075000>;
> +	};
> +	opp@266000000 {
> +		opp-hz = /bits/ 64 <266000000>;
> +		opp-microvolt = <1025000>;
> +	};
> +	opp@160000000 {
> +		opp-hz = /bits/ 64 <160000000>;
> +		opp-microvolt = <925000>;
> +	};
> +	opp@100000000 {
> +		opp-hz = /bits/ 64 <100000000>;
> +		opp-microvolt = <912500>;
> +	};
> +};
> 

