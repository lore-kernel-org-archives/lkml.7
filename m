Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35025C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A66D2073C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578095948;
	bh=WSINDlYZOXc0c43h2uDaVzqFajUYWMCcqAmGeej/xUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=US8OJMSmBkLKKcUHkANUl4zvUBVnE8n19Gt2A8Sv2Kidkw19ZWlEgM10oqXF1p0Q3
	 VAoSmtsFU1r2dGLMY0DEM+SZD0HbzDc+VsHyBa8ccuRsvRpz/t6khd565klAoCirSv
	 4nZOTBQOfUT72fUPXiFfJPhbIm+gYDQTJH1iURuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgACX7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:59:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41114 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgACX7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:59:06 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so39494631ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 15:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LACUrtg785uiAnshI5y6g26nVt7CN5SDOx6ApB3lhZY=;
        b=dY9+kM2XibTyASC9wKH5IDdZvoMcD1rHqrdX5DGXKinJkfP0rMKcmQ+BrVE+/xGZ5h
         1k6iisFJlL7Ys+T9FiDeA5M1gP/GQycAwVZpHaB8g6u4SpC+TCxeIP0g8Cq+3HouNMo5
         b3JyHa3K9JGGEIH6IvFASrUqgVfjv7kjGJ0qocZA9fbYwIO3GDNOANt+gfCA5J3bDTOg
         KhEn0C972m9Gv7AsMT9Mei0WFAlWqCKB3ZuqN5S2vr3EEUW4EIZpAYFYeVGjUOhW0fAi
         pPOIZa8lDHJ4iHW5uM7SmxsRqYQiqJJ1yLC1K/N63wesE8qTHcIZcU5wuf1fyrf2hMNg
         jQTw==
X-Gm-Message-State: APjAAAVJeu5C5h+7kWOS1igbqqHaZgABsduOHTrf6/aCWcL6nf6/G4Ao
        K7ydLcLL9eNLGoOqw2Gxi6G9ckU=
X-Google-Smtp-Source: APXvYqxUsh6VH9I+tNCFP/Wyfmkgtn6NIH0hWiWFHe2SDlOXqH2Ivteoo0FRrRuC5IFFAmBQZe31ag==
X-Received: by 2002:a5e:8516:: with SMTP id i22mr62561144ioj.130.1578095945212;
        Fri, 03 Jan 2020 15:59:05 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 8sm21435502ilq.85.2020.01.03.15.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:59:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 16:59:02 -0700
Date:   Fri, 3 Jan 2020 16:59:02 -0700
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org
Subject: Re: [PATCH v3 06/12] dt-bindings: media: venus: Convert msm8916 to
 DT schema
Message-ID: <20200103235902.GA7619@bogus>
References: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
 <20191223113311.20602-7-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223113311.20602-7-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 01:33:05PM +0200, Stanimir Varbanov wrote:
> Convert qcom,msm8916-venus Venus binding to DT schema
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,msm8916-venus.yaml    | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> new file mode 100644
> index 000000000000..14331c16135c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Venus video encode and decode accelerators
> +
> +maintainers:
> +  - Stanimir Varbanov <stanimir.varbanov@linaro.org>
> +
> +description: |
> +  The Venus IP is a video encode and decode accelerator present
> +  on Qualcomm platforms
> +
> +properties:
> +  compatible:
> +    const: "qcom,msm8916-venus"

No need for quotes.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +      - const: bus
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 20

You can have 20 IOMMUs attached to the Venus IP? The binding is for 1 
SoC, you should know how many IOMMUs there are.

> +
> +  memory-region:
> +    maxItems: 1
> +
> +  video-decoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: "venus-decoder"
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  video-encoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: "venus-encoder"
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  video-firmware:
> +    type: object
> +
> +    description: |
> +      Firmware subnode is needed when the platform does not
> +      have TrustZone.
> +
> +    properties:
> +      iommus:
> +        minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - memory-region
> +  - video-decoder
> +  - video-encoder
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +
> +        video-codec@1d00000 {
> +                compatible = "qcom,msm8916-venus";
> +                reg = <0x01d00000 0xff000>;
> +                interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
> +                        <&gcc GCC_VENUS0_AHB_CLK>,
> +                        <&gcc GCC_VENUS0_AXI_CLK>;
> +                clock-names = "core", "iface", "bus";
> +                power-domains = <&gcc VENUS_GDSC>;
> +                iommus = <&apps_iommu 5>;
> +                memory-region = <&venus_mem>;
> +
> +                video-decoder {
> +                        compatible = "venus-decoder";
> +                };
> +
> +                video-encoder {
> +                        compatible = "venus-encoder";
> +                };
> +        };
> -- 
> 2.17.1
> 
