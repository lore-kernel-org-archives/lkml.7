Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FEBCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2462720830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572367714;
	bh=qYhdmj6LOa85tTd/M8gUeBMklDOwq6QpZ7eRNZvgmDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2S+sNZozXLbqUu05XlSnZP3PJZgoGz8okUo+iZKZKB4RY1ecKgr/EYsXZV0PUhTFs
	 qz6vVcAJGhI/7ypjOy8Z1dC1f6uS0mqjKV+9J7yATfwzidYtgpgBLmRki6ZI9Oj7Os
	 FqfoEnE70zP+hDmYTrtYc89rRAanHVOswfcbJ2Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbfJ2Qsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:48:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39761 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfJ2Qsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:48:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so4231763otl.6;
        Tue, 29 Oct 2019 09:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RI8zG1ufEnYzuTEZN0YEn2eCjXsRH9KIe+0owaMHLI8=;
        b=Jp+EDBQ03Oi1hXUFxgucFPFvYyqIEQ7kTSRuJQLY6R4AggAZBPDLHaEusBN0PbrXGO
         NN4H6GPyNDHwCU+JF+hj3H3xo4ajTs8cFGlIdp7dUW04vDsUbGnr/hLF6HYd8DNXhHUU
         q5I+tk6ZO2QDs8XHsoBoqCLBXQkBSV5ctm03R4EuUHZCDeTryL/3T7PHgBOA2nMzzHHj
         tPEnVzB+LDotsaXlSOVukIk2mQRonRqNzJ5Nc8Uv/jpdayRMTmMa3u6rQ0QX1szUjPv6
         6arjpE5S19GWexPqr40daXmfSF2vQiH6MtYj6PH6AQAJnveHc99FGjPLhwYLDKGPwLeX
         5fQA==
X-Gm-Message-State: APjAAAVqdkjfMbutJM5Mn3oUB/Zkeukr692mi/ojPLDZrGg18cz18W9J
        LSWB7c2Ow/oQ0dpFG8woOA==
X-Google-Smtp-Source: APXvYqx+s5uJ0NhlC8JcM6u6lCZ7knvuS4ijj/TCsIhKf8B7RMJaGqDUPbcv5jvl2mAHW5AjZ8bxqg==
X-Received: by 2002:a9d:7756:: with SMTP id t22mr11833715otl.43.1572367711861;
        Tue, 29 Oct 2019 09:48:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm2365348ote.11.2019.10.29.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:48:31 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:48:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, paulmck@linux.ibm.com,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, biabeniamin@outlook.com
Subject: Re: [PATCH 3/4] dt-binding: iio: Add documentation for AD7091R5
Message-ID: <20191029164830.GA21417@bogus>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
 <20191021170608.26412-3-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021170608.26412-3-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 08:06:07PM +0300, Beniamin Bia wrote:
> Documentation for AD7091R5 ADC was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7091r5.yaml        | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> new file mode 100644
> index 000000000000..d041cd76804e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +
> +maintainers:
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091R5

lowercase 'r' or be consistent with the filename.

> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +    maxItems: 1

Not an array, so you can drop this.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {

adc@2f

> +                compatible = "adi,ad7091r5";

Doesn't match the schema.

> +                reg = <0x2F>;

Lowercase hex.

> +
> +                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +                interrupt-parent = <&gpio>;
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 
