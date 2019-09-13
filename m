Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313E52084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385381;
	bh=kvleeMKGJJ0KK5Ntya/QlTzNAhNAtbsg+v+BfS6AOSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fPkwBl1c8rXUgHQ6hdjT2oT8b7wQQTBYC6Wyc0JaT0KRfG12DD+ggdubr92XcO28o
	 ByoF1NPqK9CbPIDVMfGhSGBrb1+lZJBE4tqiKmz2eFCP8tK8otWgI+C0tUNflQyiIK
	 ZABpKTHtQ2zzIjHssuhGnhF30peXQY8lgu0Gz+9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfIMOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:36:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39912 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfIMOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id n7so29671090otk.6;
        Fri, 13 Sep 2019 07:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPil7naIVMsYQGDdFjyUh8y7gh27b0UjFHm5hhvq39I=;
        b=Mi7dDc4VjG0Ggby1qQGcMxB+7Zz9Dib+H/T4HUlYo73vaekvGPNPiI/5K7GDWgtbir
         ppdKZ1Ypj41hvM08FcBptKwdXpGmPEG48+gxyrpGzc8PLA479vXXoQXoGaUmK/WR321M
         2tcmxzsUl6dhL7xBEG/u7eeyystsR9wFtnicuYCJ4+W8OmZAGxRq5q+RJIqqFvZmqc77
         dLDYeiDpDhTwTmSx8Di5C7StHeMPpfkJWPyzssbMhgDBHP+8g+z8waXX7qTTGXtjZOPt
         7UujgDhAuKSttnuZV+/qGfQBJdYRbTS+F8qr+9nfoSzd2PAuvTW+4jfSr0P1mr/Wd94D
         zdxQ==
X-Gm-Message-State: APjAAAX3vGKR2Pd61WEvYtSl7Xu2XuDYGBhwg7T2Bc8FeTyG19YtXnN3
        1wAH6X8p/d74Tpq14gfqEw==
X-Google-Smtp-Source: APXvYqy9UfdHJCkKsInfemOdhROmQLnT8mAJxKh93E3hpPr0GDO3Y7CXrUsygxmMtbApr3jAKH3feA==
X-Received: by 2002:a9d:148:: with SMTP id 66mr11223347otu.1.1568385375377;
        Fri, 13 Sep 2019 07:36:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v2sm930279oic.49.2019.09.13.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:14 -0700 (PDT)
Message-ID: <5d7ba95e.1c69fb81.bba41.66c2@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:14 +0100
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: Convert Samsung Exynos
 SROM bindings to json-schema
References: <20190907144442.16788-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907144442.16788-1-krzk@kernel.org>
X-Mutt-References: <20190907144442.16788-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 04:44:42PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos SROM controller bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../memory-controllers/exynos-srom.txt        |  79 ----------
>  .../memory-controllers/exynos-srom.yaml       | 136 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml


> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> new file mode 100644
> index 000000000000..9573bcfd68bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/exynos-srom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC SROM Controller driver
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |+
> +  The SROM controller can be used to attach external peripherals. In this case
> +  extra properties, describing the bus behind it, should be specified.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: samsung,exynos4210-srom
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description: |
> +      Reflects the memory layout with four integer values per bank. Format:
> +      <bank-number> 0 <parent address of bank> <size>
> +
> +patternProperties:
> +  "^.*@[0-9]+,[0-9]+$":

How many chip selects? Can be a single digit?

Also, these should be hex values.

> +    type: object
> +    description:
> +      The actual device nodes should be added as subnodes to the SROMc node.
> +      These subnodes, in addition to regular device specification, should
> +      contain the following properties, describing configuration
> +      of the relevant SROM bank.
> +
> +    properties:
> +      reg:
> +        description:
> +          Bank number, base address (relative to start of the bank) and size
> +          of the memory mapped for the device. Note that base address will be
> +          typically 0 as this is the start of the bank.
> +        maxItems: 1
> +
> +      reg-io-width:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1, 2]
> +        description:
> +          Data width in bytes (1 or 2). If omitted, default of 1 is used.
> +
> +      samsung,srom-page-mode:
> +        description:
> +          If page mode is set, 4 data page mode will be configured,
> +          else normal (1 data) page mode will be set.
> +        type: boolean
> +
> +      samsung,srom-timing:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - items:
> +              minItems: 6
> +              maxItems: 6
> +        description: |
> +          Array of 6 integers, specifying bank timings in the following order:
> +          Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> +          Each value is specified in cycles and has the following meaning
> +          and valid range:
> +          Tacp: Page mode access cycle at Page mode (0 - 15)
> +          Tcah: Address holding time after CSn (0 - 15)
> +          Tcoh: Chip selection hold on OEn (0 - 15)
> +          Tacc: Access cycle (0 - 31, the actual time is N + 1)
> +          Tcos: Chip selection set-up before OEn (0 - 15)
> +          Tacs: Address set-up before CSn (0 - 15)
> +
> +    required:
> +      - reg
> +      - samsung,srom-timing
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      anyOf:
> +        - required: [ "#address-cells" ]
> +        - required: [ ranges ]
> +        - required: [ "#size-cells" ]
> +    then:
> +      required:
> +        - "#address-cells"
> +        - ranges
> +        - "#size-cells"

I don't think this is necessary as the core schema should take care of 
it. This can also be expressed using 'dependencies'. 

Rob

