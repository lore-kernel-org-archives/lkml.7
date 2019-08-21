Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE09A2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566419491;
	bh=qmr3EkBxegCW1cVj9TcBMOwuGqBhPKJInp6kC6+owFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b2VB0L4+4yKt9/8kyDxQ+SY9jxGQ8f93e2fWif9FMUslIX6shvUK7BprbhV2kUH5H
	 fDbcYteRvJbo9RrvxAWLaIA0JQFQq/VYw5N+NOiCXy/4D3VFhuOoldMO3HOmXln7Tl
	 8XaOqnyWbJK/g7O8+mKSYJbwhFiao/Q4R7R/bci8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfHUUba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:31:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfHUUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:31:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so3361351otp.1;
        Wed, 21 Aug 2019 13:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iabTxjGtNwFPz618omlBwY8T1BonwpR5OPoPhDx+RAI=;
        b=WYbOEE9Gy49PJrRZIF4UzXIVNnr3FJk4n4J+C/Tb1KQz9hvmb1uczkBPxMBKM/igic
         0SNsn4mNhaeqU/Tb5AS8Ni2Rpxxh0j+0WWN/5WrfIZKcY5/63lI2NMfwf6PK3BVqdPN7
         DLwab1EEfwZ9T2vS9ceWnkIJ9hGAkJy2bszpoRGNyKJsgu0XQj6i0Ig1ziJW4CM6RPau
         cowsQARkeHukD1/vawY5anj2mN2vbrYwmeTtCyUQ84uswelQdf7WQIOBV64CU1Rw5I+W
         CJAZry04iuRsvm0CC4NOIPbEQg/SmOfaANmd0lA+ZgZxDdT0rpkkQkqr2eWD+2GPtH/k
         /45Q==
X-Gm-Message-State: APjAAAVoW7QyrpPLjF+scMFmsL/Rg9cl9HWIKDAC+JUaS/iUwjv1Cu7P
        0C+M/iPipBU9yGSzkHGDtA==
X-Google-Smtp-Source: APXvYqxA5DddGYiMIluqgvMEXnIjXJXPtUYSn4UKKWLOHwak79bzGLItjFHyJqv8AZhca2/koFNGsw==
X-Received: by 2002:a9d:7a5a:: with SMTP id z26mr26056383otm.348.1566419488855;
        Wed, 21 Aug 2019 13:31:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d22sm6221319oic.23.2019.08.21.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:31:28 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:31:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: counter: new bindings for TI eQEP
Message-ID: <20190821203127.GA29308@bogus>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807194023.15318-3-david@lechnology.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 02:40:20PM -0500, David Lechner wrote:
> This documents device tree binding for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> - convert to .yaml format
> - rename clock to "sysclkout"
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> new file mode 100644
> index 000000000000..8f8b2e87e5c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/ti-eqep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
> +
> +maintainers:
> +  - David Lechner <david@lechnology.com>
> +
> +properties:
> +  compatible:
> +    const: "ti,am3352-eqep"

No need for quotes

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: The eQEP event interrupt

Don't really have to have a description when there is only 1 entry.

> +    maxItems: 1
> +
> +  clocks:
> +    description: The clock that determines the SYSCLKOUT rate for the eQEP
> +                 peripheral.

Same here. 2 spaces in from description is the normal indentation.

> +    maxItems: 1
> +
> +  clock-names:
> +    const: sysclkout
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    eqep0: eqep@180 {

counter@...

> +        compatible = "ti,am3352-eqep";
> +        reg = <0x180 0x80>;
> +        clocks = <&l4ls_gclk>;
> +        clock-names = "sysclkout";
> +        interrupts = <79>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
