Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7CC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F202253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273160;
	bh=cHQvTn7neSGVb/pJAX+zht/iZ9hKdS3WgUrR8EtAfe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brt4cs7ua8qrjr/4jmPS95PGKGtRPbomi/QXtI9WHRE6TCbotyA/0Ga8gSpFoYO9g
	 Rk39t7wVUKzY2WjhAX483jmvpZuyu9J+6ZPTtWaESsSAC/rNM2SwaKBhAOpo8GE1tU
	 +57CWs1CDLj1roIXX8X3SV4gSg4l8eb1B57EspCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLMVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:39:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33232 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:39:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so1984217oie.0;
        Fri, 13 Dec 2019 13:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCYACv29dkJEimAeryd7NAUvfts7axPZD4KOPwPhHhU=;
        b=aTWpmwKqhBUnLQu2km7LZQxuOu2yuIaXgQSu5KILl0YOPDx2Sm5YzbmC+VVT/RsTpZ
         YM4/Y/bMDrYUs1uwRpkoEJtRlWSKCEJ4K428T0UCCPCH0Qgs0VjQfeP0Dj1S5G1q+Wxf
         zk0mvic5kEw2G2RGueoddkJTthMrmlimcz4p5d0PikzmxRCfivpILIFYHYpCSTP0V9do
         k24JNPl1fe/fwzNly/FMPlsl/nhVN2c+aCwB67MwrcSpomQ0vd2itAbYuHWHgXmJoCYU
         kHyAMh6OmsTJ6P8bLKDnQIF5oNSW9FTHfa+nBwhR7kQL9/Bd+m3pNPMScHieoPPc38QW
         HfTQ==
X-Gm-Message-State: APjAAAWmQRdIiKsfZMc3dDbym9QE+VXc1iAWK5QzYP2uIm5XU+KemkzZ
        5UF7WEwFGz4osN9vqvkz+P2+TvE=
X-Google-Smtp-Source: APXvYqx8lp9CVw+D5kPH+eRXIzKkrTm4GjWilZZXwORT3uNCoTfc2EDpKa5QD1/v0PHo3VOao+xSTg==
X-Received: by 2002:aca:d706:: with SMTP id o6mr8416194oig.19.1576273158143;
        Fri, 13 Dec 2019 13:39:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm3687774oie.25.2019.12.13.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:39:17 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:39:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: Re: [PATCH] dt-bindings: stm32: convert mlahb to json-schema
Message-ID: <20191213213916.GA1292@bogus>
References: <20191128154603.6911-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128154603.6911-1-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 04:46:03PM +0100, Arnaud Pouliquen wrote:
> Convert the ML-AHB bus bindings to DT schema format using json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> Notice that this patch requests an update of the simple-bus schema to add
> the support of the "dma-ranges" property.
> A Pull request has been sent in parallel to the dt-schema github repo:
> https://github.com/devicetree-org/dt-schema/pull/30
> 
> To remind the topic around the use of "dma-ranges" please
> refer to following discussion: https://lkml.org/lkml/2019/4/3/1261
> ---
>  .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
>  .../bindings/arm/stm32/st,mlahb.yaml          | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> deleted file mode 100644
> index 25307aa1eb9b..000000000000
> --- a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -ML-AHB interconnect bindings
> -
> -These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> -a Cortex-M subsystem with dedicated memories.
> -The MCU SRAM and RETRAM memory parts can be accessed through different addresses
> -(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
> -Cortex-M firmware accesses among those ports allows to tune the system
> -performance.
> -
> -[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> -[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
> -
> -Required properties:
> -- compatible: should be "simple-bus"
> -- dma-ranges: describes memory addresses translation between the local CPU and
> -	   the remote Cortex-M processor. Each memory region, is declared with
> -	   3 parameters:
> -		 - param 1: device base address (Cortex-M processor address)
> -		 - param 2: physical base address (local CPU address)
> -		 - param 3: size of the memory region.
> -
> -The Cortex-M remote processor accessed via the mlahb interconnect is described
> -by a child node.
> -
> -Example:
> -mlahb {
> -	compatible = "simple-bus";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	dma-ranges = <0x00000000 0x38000000 0x10000>,
> -		     <0x10000000 0x10000000 0x60000>,
> -		     <0x30000000 0x30000000 0x60000>;
> -
> -	m4_rproc: m4@10000000 {
> -		...
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> new file mode 100644
> index 000000000000..8ad3f7c7f9ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: STMicroelectronics STM32 ML-AHB interconnect bindings
> +
> +maintainers:
> +  - Fabien Dessenne <fabien.dessenne@st.com>
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +
> +description: |
> +  These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> +  a Cortex-M subsystem with dedicated memories. The MCU SRAM and RETRAM memory
> +  parts can be accessed through different addresses (see "RAM aliases" in [1])
> +  using different buses (see [2]): balancing the Cortex-M firmware accesses
> +  among those ports allows to tune the system performance.
> +  [1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> +  [2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
> +
> +allOf:
> + - $ref: /schemas/simple-bus.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - st,mlahb
> +
> +  dma-ranges:
> +    description: |
> +      Describe memory addresses translation between the local CPU and the
> +      remote Cortex-M processor. Each memory region, is declared with
> +      3 parameters:
> +      - param 1: device base address (Cortex-M processor address)
> +      - param 2: physical base address (local CPU address)
> +      - param 3: size of the memory region.
> +    maxItems: 3
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - dma-ranges
> +
> +examples:
> +  - |
> +    mlahb: ahb {
> +      compatible = "st,mlahb", "simple-bus";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      reg = <0x10000000 0x40000>;
> +      dma-ranges = <0x00000000 0x38000000 0x10000>,
> +                   <0x10000000 0x10000000 0x60000>,
> +                   <0x30000000 0x30000000 0x60000>;
> +

Fails to build:

builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dt.yaml: 
ahb: 'ranges' is a required property

Run 'make dt_binding_check'

> +      m4_rproc: m4@10000000 {
> +       reg = <0x10000000 0x40000>;
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
