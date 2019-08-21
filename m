Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E946C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F73F2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566394568;
	bh=/NmeYW95Exo7cKy4d0fywRhRlKRIlx9ue+Ya7TM9/fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x9jidPKmaB+SfJ1PjPpO5fCKBG8st9AdbqDIosUtYHWEKgSLNi4lHlnpPfZQT97Mz
	 XLTS3py8CPaSJy/89nXq3Y7Bo1JXA6899riO6s2xjTGogKohymA4D1GMtQ+fjX1LS1
	 Fr5R8l7ptNLq176P9ZR0G/9EWQEwG8w7soTcVJB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfHUNgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfHUNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:36:07 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA06F233A1;
        Wed, 21 Aug 2019 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566394566;
        bh=/NmeYW95Exo7cKy4d0fywRhRlKRIlx9ue+Ya7TM9/fY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QjIyG27vI7EvoSIXoKX79El+gjRukM9gfyxCM4f1AF5hhT6Ft4+2C9PGPVPX7OCJc
         CPGylJR0wMuzBY2HImXWScou9vol0g4TvEfTiUjzWOQIbC37AIEseL5VZ1EGg6tK2j
         CggsMXtIRWVG8EcTG3fZxP5Z3KN6QpwDYJYlTnKY=
Received: by mail-qk1-f176.google.com with SMTP id 201so1775952qkm.9;
        Wed, 21 Aug 2019 06:36:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWt2yBHYAVQHOGI7cM97oZXOYEv4UImANGqwQrhhn3oWxsYCYVK
        tyusDmXzP7xXtywcgfchS3yVRhi5M5N2lw3Nlw==
X-Google-Smtp-Source: APXvYqze9zflmjiULS8riuGVsf57QEagyQh2riNNX9RcdFJpRRR+77eiOBy9RbP2XMx/Tl7n5fDa8Vk8PVe+GEsiHwo=
X-Received: by 2002:a37:a010:: with SMTP id j16mr32191854qke.152.1566394565049;
 Wed, 21 Aug 2019 06:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Aug 2019 08:35:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pyaYD2C8G1WZm1fL-wgkJvDYBkp0TwJTmQVKP-gHPXQ@mail.gmail.com>
Message-ID: <CAL_Jsq+pyaYD2C8G1WZm1fL-wgkJvDYBkp0TwJTmQVKP-gHPXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:11 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
> changes in v3:
>   - resolve 'make dt_binding_check' warnings
>
> changes in v2:
>   As per Rob Herring review comments, the following updates
>  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>  - filename is the compatible string plus .yaml
>  - LGM: Lightning Mountain
>  - update maintainer
>  - add intel,syscon under property list
>  - keep one example instead of two
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..9342e33d8b02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    const: intel,lgm-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  syscon:

intel,syscon like the example. You must have used 5.2 as on 5.3-rc the
example will fail validation.

> +    items:

Drop items as there is only 1.

> +      $ref: "/schemas/types.yaml#definitions/phandle"
> +
> +  clocks:
> +    items:
> +      - description: e-MMC phy module clock
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - ref

Not documented.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    emmc_phy: emmc_phy {
> +        compatible = "intel,lgm-emmc-phy";
> +        reg = <0xe0020000 0x100>;
> +        intel,syscon = <&sysconf>;
> +        clocks = <&emmc>;
> +        clock-names = "emmcclk";
> +        #phy-cells = <0>;
> +    };
> +
> +...
> --
> 2.11.0
>
