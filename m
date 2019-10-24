Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0657721D71
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OT4cDmsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503706AbfJXQjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54658 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503686AbfJXQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:39:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id g7so3573440wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6airdfmWbPo+9H8q8yF8Fow5EQ+bKYy5OYJZbu/8klg=;
        b=OT4cDmsUunbscfxvhDw+rIVX2AsuGIv9mDVd9Lz1JmIYVvwuXSxmr+inrLJOCkaPlp
         Z57x8PvO+vWADTq1pOJQK78YuP5oUWFPIpmVNDmTi+yAc0QbSG2tr9ojk+PQ6S98bUxo
         egLtniHBPwO+5iTboWMsWoM/TMqXQFup6d2H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6airdfmWbPo+9H8q8yF8Fow5EQ+bKYy5OYJZbu/8klg=;
        b=RnQd7p7uurChpbyg2lz3QPRNA89bGGlQ6rxqCwdAvHLn8RJWOb2SzgYHB7mC66xNHC
         jumWXAv012Zs7u0mLRKXYYZaRU4lYQjAwnGmmTTKBrBS9rQj0VclKhmDPNhnnsOndpkR
         Hpt91QGtraSXE0irZdeEo4qNhXgsbCjt79waAAEJ5v654spr0e6FO38a+IwxU695MCpe
         4lnvmkR5DfBifNe07MIBrOL5Z2IemBR72ykmJJoMio6FzdzyDyunA59whIvfwMz4qTfg
         NJD1xn4qJZ4JZpoHPmv3RU9PN5VJKoA4JgVrluXv056gf4kXHoaO9YUwRtdBAofLVCRS
         c6uQ==
X-Gm-Message-State: APjAAAVcAOVgeHw8OYBWsVjPd+E9MEBp0+eqVF8mb2zuaVYT68dFNZhZ
        OJX0pZeicqHUulVmDuxu0tKppECoHeSynYosz4n1Ic2vLT3oKub4RGfhj7+Zd1f7nCrgvujf8Xo
        7v8hrlTD4S5PG9p5wZOvUX9AyouY7cQ4zVVxNA333LYWhq6h00Cxqbtu/izGy61z8ZgvHAjGedv
        R2M5mdHwh9+3I=
X-Google-Smtp-Source: APXvYqz3vCdn5X+pVSPFYILymZ7NnZuRiPFSO7yPCexT8xbKvyQr1f9rcrSOfkcoYmxikGkdR5xgng==
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr5904648wma.27.1571935172517;
        Thu, 24 Oct 2019 09:39:32 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x7sm37064980wrg.63.2019.10.24.09.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 09:39:31 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: brcm: Add bindings for
 xgs-iproc
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191024004816.5539-1-chris.packham@alliedtelesis.co.nz>
 <20191024004816.5539-2-chris.packham@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <db6d6cc7-6844-7079-7115-da1eb9c1feac@broadcom.com>
Date:   Thu, 24 Oct 2019 09:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024004816.5539-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2019-10-23 5:48 p.m., Chris Packham wrote:
> This GPIO controller is present on a number of Broadcom switch ASICs
> with integrated SoCs. It is similar to the nsp-gpio and iproc-gpio
> blocks but different enough to require a separate driver.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>      Changes in v3:
>      - incorporate review comments from Rob and Bart
>      
>      Changes in v2:
>      - Document as DT schema
>      - Include ngpios, #gpio-cells and gpio-controller properties
>
>   .../bindings/gpio/brcm,xgs-iproc.yaml         | 70 +++++++++++++++++++
>   1 file changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
>
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml b/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
> new file mode 100644
> index 000000000000..ec1fd3a64aa2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
This doc needs to have gpio in the name to make all other gpio binding 
documents.
ie.
brcm,xgs-iproc-gpio.yaml.
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/brcm,xgs-iproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom XGS iProc GPIO controller
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +description: |
> +  This controller is the Chip Common A GPIO present on a number of Broadcom
> +  switch ASICs with integrated SoCs.
> +
> +properties:
> +  compatible:
> +    const: brcm,iproc-gpio-cca
> +
> +  reg:
> +    items:
> +      - description: the I/O address containing the GPIO controller
> +                     registers.
> +      - description: the I/O address containing the Chip Common A interrupt
> +                     registers.
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +      const: 2
> +
> +  ngpios:
> +    minimum: 0
> +    maximum: 32
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +dependencies:
> +  interrupt-controller: [ interrupts ]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    gpio@18000060 {
> +        compatible = "brcm,iproc-gpio-cca";
> +        #gpio-cells = <2>;
> +        reg = <0x18000060 0x50>,
> +              <0x18000000 0x50>;
> +        ngpios = <12>;
> +        gpio-controller;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +
> +...

