Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DEFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676F22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572386807;
	bh=GsWtfZrelbRzE6pizQLf+50Tmch918LtZ4T05e9esIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hMCZrvnQzcY9bL0cdMV3RgCOuEhpKCdOCZgSQSUjdCWNR++a9u8DucAOoMaDH1ck1
	 bT4zVTeundODz0LZjsxNC/+h9iXvIJlMrXlXeKa3Abi8SfmtTV+z0E+2HaSAyjguqd
	 mr/zTnsExAXP+jt4E626L3xOHZm7mYhvibz7ScjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfJ2WGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:06:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45588 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfJ2WGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:06:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id k2so198358oij.12;
        Tue, 29 Oct 2019 15:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfqb9iayrD7twK1Yov7mjax5KVdTInGQjQseAedA/Nc=;
        b=odIb8YvScJrkMmLmKHNymP0waXURvKZmCG5AtQ5ZHAJkGrMRbawhvdrjdElcVoWzkV
         gRo8f5DzndHwcwpSg1ZWrBh/S5hPKmvubD9goCGzKWBv24+yk1yJoeqICS2p2tot//Bt
         8qa2SFVmMQIhjTGAuHBBqSbx7MMjK+UAneeXAxZftG2OoSvs4gHLQJaKoDw2lRvJziaF
         1plGzbndhd5s25zr6NEdMeQfNzcXOZWr6c1TWzgm4FJiLflHf/3MlWiQO3I0WdQawWgH
         vxrgl5wO85vpSM5upH9PpEJxrB0S0UzSdDuIKNOIYtlwr+kVj2zzBOE1xXZsaxY04U1B
         cgTQ==
X-Gm-Message-State: APjAAAUyTJZjyDBmYiDJGKkBb7Y3Eu0zwLfrOUBwSf43rioVrKpooJVg
        wsUwCOt/HYovSP4oO9fcZA==
X-Google-Smtp-Source: APXvYqxwuc2I1yytREdN+EWBcO63dl9Z8r2Iv+fVZtPjjtDikI1+tT3JcyRAJk+RU3PXiiEyUtzOXg==
X-Received: by 2002:aca:e104:: with SMTP id y4mr6256504oig.117.1572386781514;
        Tue, 29 Oct 2019 15:06:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm90777otj.64.2019.10.29.15.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:20 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:06:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v11 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI
 controller
Message-ID: <20191029220620.GA14316@bogus>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025175625.8011-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:26:19PM +0530, Jagan Teki wrote:
> The MIPI DSI controller in Allwinner A64 is similar to A33.
> 
> But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> to have separate compatible for A64 on the same driver.
> 
> DSI_SCLK uses mod clock-names on dt-bindings, so the same
> is not required for A64.
> 
> On that note
> - A64 require minimum of 1 clock like the bus clock
> - A33 require minimum of 2 clocks like both bus, mod clocks
> 
> So, update dt-bindings so-that it can document both A33,
> A64 bindings requirements.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index dafc0980c4fa..2b7016ca382c 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -15,7 +15,9 @@ properties:
>    "#size-cells": true
>  
>    compatible:
> -    const: allwinner,sun6i-a31-mipi-dsi
> +    oneOf:
> +      - const: allwinner,sun6i-a31-mipi-dsi
> +      - const: allwinner,sun50i-a64-mipi-dsi

Use 'enum' instead of oneOf+const.

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

>  
>    reg:
>      maxItems: 1
> @@ -24,6 +26,8 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 1
> +    maxItems: 2
>      items:
>        - description: Bus Clock
>        - description: Module Clock
> @@ -63,13 +67,25 @@ required:
>    - reg
>    - interrupts
>    - clocks
> -  - clock-names
>    - phys
>    - phy-names
>    - resets
>    - vcc-dsi-supply
>    - port
>  
> +allOf:
> +  - if:
> +      properties:
> +         compatible:
> +           contains:
> +             const: allwinner,sun6i-a31-mipi-dsi
> +      then:
> +        properties:
> +          clocks:
> +            minItems: 2
> +        required:
> +          - clock-names
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.18.0.321.gffc6fa0e3
> 
