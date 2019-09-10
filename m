Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4EC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084F2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2wbjYZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfIJL0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:26:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39573 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfIJL0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:26:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so19436455wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0TBNK8vrhm3gWofBEygsEx6r5o4+eQ+f+iikza6PCs=;
        b=C2wbjYZcrPtWqMbHCc0NFcjoE48uA90sIUxmZk904S9onpeCgpqxYF2+qlIGnesGzU
         FTaWBzTKFCuFhpbtGzkixNWaxtdnMv5OxYd0pTKhqUIhAOhp7pdrrzvlIpUFFWz/de2j
         PxwAkDn4Z9WnrJUTrue3rQbFWzYuUfV/AS6q23eYDus9TSGguBSNI5x7k4DN9HEBwjOE
         gi3/dGho7qOlXW9b8mTLMRAlMNi6+sITQ8BI5dV2iT73s24OXY1w03gVyYTIISHOPBeW
         tnNF8uULOaWfzCd4yVdZqgFAoJf+Z+Hzc7mguJWpDt0O+pymCAFq/EP5AXoFHmdM9WTZ
         TzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0TBNK8vrhm3gWofBEygsEx6r5o4+eQ+f+iikza6PCs=;
        b=LO648HDcmhctFjF/nE8pNXVrOtSlzCBbfHcNUwOZ6hkSPLyTiM6YYNIh9AtVqilklg
         D0hI1QKJtFknfRV0t+ZBmgejuR5QebKveGpLDb86TNmggdx94nT/2RjVPLWQucT7Dybh
         gb/LdXbt6xMmLLf5Qc9UMLxkrJaoQw3GMnRPYf4O8ozH4CzgaPq1pZvxygRcBWXy+L8V
         xBjTqp/FbLS0EkY71en0U1cvyQdAbbhpf2j42dHItCSH1+hR9CxQ+npPzst1qytHRbSy
         bVPITXnUaeYuBoc4fwj+pzXthhg2pDV46qwd9kDIYWv7S6T8rhIJ+w3OwuhH+1H0ilmu
         SYNw==
X-Gm-Message-State: APjAAAWYm/QbHojcDluZ2TpIIyVIsZz/L4HcqlzfDWBnQE0DxTzaGyAV
        ZCVhDT1klDrVSRtgd4iR7X6RSA==
X-Google-Smtp-Source: APXvYqy9l2m6tvel0D96cw1Y+Z7nXsZRSHOqRUjLgsUtGTNBvQhldiMJqmfTX5m82vMFJTeXKmkabA==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr26859432wrq.305.1568114803790;
        Tue, 10 Sep 2019 04:26:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l1sm20279280wrb.1.2019.09.10.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:26:43 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:26:41 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dridevel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v5 3/4] dt-bindings: backlight: Add led-backlight binding
Message-ID: <20190910112641.q4qpvhh6u6nqqw5z@holly.lan>
References: <20190910105946.23057-1-jjhiblot@ti.com>
 <20190910105946.23057-4-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910105946.23057-4-jjhiblot@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:59:45PM +0200, Jean-Jacques Hiblot wrote:
> Add DT binding for led-backlight.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  .../bindings/leds/backlight/led-backlight.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> new file mode 100644
> index 000000000000..4c7dfbe7f67a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> @@ -0,0 +1,28 @@
> +led-backlight bindings
> +
> +This binding is used to describe a basic backlight device made of LEDs.
> +It can also be used to describe a backlight device controlled by the output of
> +a LED driver.
> +
> +Required properties:
> +  - compatible: "led-backlight"
> +  - leds: a list of LEDs
> +
> +Optional properties:
> +  - brightness-levels: Array of distinct brightness levels. The levels must be
> +                       in the range accepted by the underlying LED devices.
> +                       This is used to translate a backlight brightness level
> +                       into a LED brightness level. If it is not provided, the
> +                       identity mapping is used.
> +
> +  - default-brightness-level: The default brightness level.
> +
> +Example:
> +
> +	backlight {
> +		compatible = "led-backlight";
> +
> +		leds = <&led1>, <&led2>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
> -- 
> 2.17.1
> 
