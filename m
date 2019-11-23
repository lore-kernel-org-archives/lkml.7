Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B85C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF45120719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574509286;
	bh=ngMp7fsUkEM35vFeaBws4aMpe9K1puuD9DJWsdHYSTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J6qkPh32TrAdG/VpU6x9zz77ijrMmAtGEDuwSkYFhD0xP6uF2jTbJ5wd0Dftfv/fc
	 S0F7ZaQDKPaAF7ot6E4/zX3azHuNePYTbG3qQFTIp4dwTSUfdzk/fKE08hjDemc9V8
	 wQQJQb1Kk/usE0FjUg8LHo02AfMw/hXF27JebOAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKWLlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 06:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKWLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 06:41:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB9220714;
        Sat, 23 Nov 2019 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574509284;
        bh=ngMp7fsUkEM35vFeaBws4aMpe9K1puuD9DJWsdHYSTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVI/DT6Qj5t3jg8aa0j25qR5uWr3gk08Y7DPmHTDRp8kZGAhSC7De+EaxgDY/f3ur
         +A1VM3Pd2spUdbh0DTRy06mLEC2OnTajsK4tcJHQ1WLAaZovlz7TbPWsJ/QRP4pcLR
         neZUnwcvrlJf5glZVbevRWJblF+CLHKHVk+CXVLo=
Date:   Sat, 23 Nov 2019 11:41:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     alexandru.ardelean@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20191123114119.7b0c3447@archlinux>
In-Reply-To: <20191123051927.5016-1-rodrigorsdc@gmail.com>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019 02:19:27 -0300
Rodrigo Carvalho <rodrigorsdc@gmail.com> wrote:

> This patch add device tree binding documentation for ADIS16240.
> 
> Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
No problem with this patch, but I definitely want to see an accompanying
one enforcing the SPI mode in the driver.

Right now the driver doesn't set it and so I'm fairly sure not putting
it in the binding will leave you with a non working device.

The right option if only one option is supported is for the driver
to call spi_setup with the relevant options.

Thanks,

Jonathan

> ---
> V4:
>    - Remove spi-cpha and spi-cpol in binding example, since this driver
> supports only one timing mode.
>  .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> new file mode 100644
> index 000000000000..8e902f7c49e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -0,0 +1,49 @@
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
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

