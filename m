Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A856DC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DE321D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572985177;
	bh=GyelMJW25YnnMBPhUYz/eAXNyRrneJFGG4HtJzJDBBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NRlrK1vTcvhbhF6SMv3N9DoSbeDPoYM2DKNI5RjcwTu5YlICoet7PvE2I6uF7Fg1h
	 z9VxIe/KAMdEs1Jakc85RVOMUSQABYK/rNBgdqLc7yvyn5/0NGWI/oZWtmDwA7l01B
	 4btsVpoJaaKFZu6dMT+kR1wxnojviJo9VcYW45cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfKEUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:19:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43531 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKEUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:19:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id l20so6701223oie.10;
        Tue, 05 Nov 2019 12:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nx7kJTn3OdCopAIR7Uif4GRlSRK0moBADISBNdcfrTs=;
        b=CfErN2/fXneyoKLva9QaXEWV9InFtjqfbLUF4t/NjrhOI69gK5iCHtRaHP31DywgYl
         VL5lrVQYAkIejBB36NkBTJ0fm3YrGyBjB0bH0Okjw+Wkxaa4vah32sKoanlNABehmpQv
         ol+xK9XIHDTwMR8Wo7CSYCr81LRgQCKpyFCwbQgInUrlRCiij3USuzKX7TWqbkqMMU54
         UIObKILHW/NKnsE1Ct2MD7FFkBJHbsIemKEjm6kWPfs15WovkDAqFK5GwZXVJASNm/1c
         9awtmKjWCYWcp8YDU2eYE6Ep99eR7OnuY0ZzJTYGYcD2jBK9Y7QKXGP0Obs5KYUYndYy
         C/7g==
X-Gm-Message-State: APjAAAVBypSyKfNEr4Ap9aCecBk5ayKrFI4sPJtf64GqAbBb+10mwZ/R
        pXrVjvm+9DmMAhZhWhoLTg==
X-Google-Smtp-Source: APXvYqzcwQTTuh/ucjVOm77Dw2qQBBOp4x78YLgbH+mDcvDa5vMIG9/s7Mrn5jjgeZmF/Hy7tj1Clw==
X-Received: by 2002:aca:dd0a:: with SMTP id u10mr766731oig.130.1572985173589;
        Tue, 05 Nov 2019 12:19:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v26sm2778262oic.5.2019.11.05.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 12:19:32 -0800 (PST)
Date:   Tue, 5 Nov 2019 14:19:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v3] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20191105201932.GA24515@bogus>
References: <20191101000301.12901-1-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101000301.12901-1-rodrigorsdc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:03:01PM -0300, Rodrigo Carvalho wrote:
> This patch add device tree binding documentation for ADIS16240.
> 
> Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> ---
> V3:
>    - Remove spi-cpol and spi-cpha field. They don't seem necessary

Not necessary to document or use? The latter requires the former.

If your device only supports one timing mode, then you don't need them 
because it should be implied and the driver can just tell the SPI 
subsystem what mode it requires. If the device can support multiple 
timing modes, then you should document that you are using the 
properties.

>  .../bindings/iio/accel/adi,adis16240.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> new file mode 100644
> index 000000000000..9a4cd12c4818
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADIS16240 Programmable Impact Sensor and Recorder driver
> +
> +maintainers:
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> +  SPI interface.
> +    https://www.analog.com/en/products/adis16240.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16240
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adis16240";
> +            reg = <0>;
> +            spi-max-frequency = <2500000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> -- 
> 2.23.0
> 
