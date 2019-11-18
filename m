Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83154C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D021D7A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574099370;
	bh=DYKwlmeC3pvzPdhuAwx8vEQOqQjSiFtgJXHnMSifva8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N84o+JzQmZZZuDMhBvi26LHSp5WqJ8Cy3FC7HA57v9ei5T1cXFfE1KGp/pB0agllG
	 xXKO7EszDPrm8S0T6hPGfEd8dui+C9KT5EkTUWx+VQm+cb/f8AOYc6p2fFfJ1tk2AI
	 saqWc+IUvVlW/dD7wJgJQPxAdojLaRAMHwWxY7pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKRRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:49:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40938 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfKRRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:49:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so9166971oic.7;
        Mon, 18 Nov 2019 09:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y3Qx19fdBbWInRKoCFh0bqdIwNk3ZTrVmE+pGg14hpQ=;
        b=h0noQ2FxZivlx/wTDwE1+uCTMjePxZv0zsFWaYoZmOdPyKpCci3n5rvZtRrYlJdyF5
         CezX/ucEqF2TycneXd/LiaZ6LsBQ5G9+6Hk4FFHWshGWKf90+omkGukqQ81K6ip7Zwkp
         e0X/FPBVbTP8wy5xdkbpifBxzcc5wS32Y40C+W9ew2i2udzfhV2/QvdIPiBgmATt1laC
         zRNYVq9J6VmEIg73vrp0Q2Gf1HRbRMzUcIHbToUnAJnid7qwcxKJEfYQ/PcdujCY3b3Y
         fWx6t+Q9P3DYeQAI6EVZJyul0HLKW2smWtkBO1uIBIfyLe1ZrUXSJ7kDkLyzFEcxXUxU
         ZZZg==
X-Gm-Message-State: APjAAAXC3fKueP7/KDkeucPhPNlwKY6uaWnvX26d/MUkwjPqQv4k9YYV
        zZlBBVUV0jF6tSwGtijc4A==
X-Google-Smtp-Source: APXvYqxI/5VqcHNlQb1w8L6k5hQ217PuWT8L9RUidu7eci3tR2apxY3hjBJW0goFv+jkWcaFvmY3SQ==
X-Received: by 2002:aca:4fce:: with SMTP id d197mr147098oib.142.1574099368064;
        Mon, 18 Nov 2019 09:49:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s25sm6152148oic.13.2019.11.18.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:49:27 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:49:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, paulmck@linux.ibm.com,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, biabeniamin@outlook.com
Subject: Re: [PATCH 2/3] dt-binding: iio: Add documentation for ADM1177
Message-ID: <20191118174926.GA19914@bogus>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
 <20191112153552.27431-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112153552.27431-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 05:35:51PM +0200, Beniamin Bia wrote:
> Documentation for ADM1177 was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/adc/adi,adm1177.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,adm1177.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,adm1177.yaml b/Documentation/devicetree/bindings/iio/adc/adi,adm1177.yaml
> new file mode 100644
> index 000000000000..69a0230e59f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,adm1177.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,adm1177.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1177
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +  adi,r-sense-micro-ohms:
> +    description:
> +      The value of curent sense resistor in microohms.

s/curent/current/

Is there a range of values allowed?

> +
> +  adi,shutdown-threshold-microamp:
> +    description:
> +      Specifies the current level at which an over current alert occurs.
> +    maximum: 255
> +
> +  adi,vrange-high-enable:
> +    description:
> +      Specifies which internal voltage divider to be used. A 1 selects
> +      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
> +    type: boolean
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@b4 {
> +                compatible = "adi,adm1177";
> +                reg = <0xb4>;
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 
