Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B31DC10F0D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C62A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWgpsEKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfDDITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:19:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39738 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfDDITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so781799plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=57oxX9qcqOphMVdsvnbzO1MKoW5/Uo3PTxng3ulbZxc=;
        b=DWgpsEKuCVhq3+qghF9Mje3JW4HLvMfnwvi9vAOgNIdTAmWFA84uv0F2lFJjeIIMz4
         11D8C0obQ9vcmoKkJTdnnLlMQXbt6BuaqkPgLKJtFbft7c+/+yhL3qYyZle/gdlHOOlJ
         FI6TTi09fxqT5Gd1tbq0rfWlCjG0B6VaMtmUoyZx0LbbklM9bGsTxIcX1CMb9/4nWBJ3
         BEuM88ma0g49xccFFMWvLJPjATrNxSEWp+JI52mDYFc9mHQxhQ41LOdYLpsCuSLLH0Jk
         8/jFrtLsaQ8Jx8Gr/nbCffDkMG6m7Pou5RB2DJxyUARNQ73Y1ZirJcoOOTQNwfUuTz/B
         gQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=57oxX9qcqOphMVdsvnbzO1MKoW5/Uo3PTxng3ulbZxc=;
        b=Xlk2nVdZQ7VqvfZJk1et/S5fEhUjBCC0Ii9xDio8NwM2xjzmsbXvpV7oizzoKbX0aZ
         D4V0XDKHvJBlIr/lLlCS9AW43p4G0/e7pnum3JLspAoE7WgKlY1+/sqzr3GVO88ypklw
         RL4PzJ9WS7cXSrxQxqnkwn3/XJ8FR4mKtZGKGeBvlEGDPBcXP1EbH2XAEQWseFKuW3ju
         82nqEows83lWVjlaKGsYDcgUuHVXq2AM7igYYDVpeif3LbnJtjWAJIwFlEy+WU4DRW3F
         +nYHcoQfY5+z5JsQYmMSI9Afg9whkch8vhvHE991iCfZ/5bNqf+EHRQsrTC4YxLsQ2gO
         oxaw==
X-Gm-Message-State: APjAAAX6NbxPZrhcTUjnhS5x0thulvkrspUSh68tt5byrcujueuX87vF
        lajfilgQBX0g7LympUB/3YD/bw==
X-Google-Smtp-Source: APXvYqxG4yu6j/4daY79hPbnOSByWUCvtGINPKzh6/WwG7DeTksBO1xJ6EU7ira/ifYUJ8eiaS10QA==
X-Received: by 2002:a17:902:e382:: with SMTP id ch2mr4882080plb.94.1554365955743;
        Thu, 04 Apr 2019 01:19:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p66sm7472793pfb.4.2019.04.04.01.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:19:15 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:19:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: mfd: Update the ramp up/down property
Message-ID: <20190404081907.GO6830@dell>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325142403.30447-2-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Dan Murphy wrote:

> Modify the ramp-up/down property and add the property description
> to the binding.

This is the 'what', but where is the 'why'?

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> index 980394d701a7..d9d529de6dc1 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -25,6 +25,12 @@ Required properties:
>  
>  Optional property:
>    - enable-gpios: A GPIO specifier for hardware enable pin.
> +  - ramp-up-ms: Current ramping from one brightness level to
> +		the a higher brightness level.
> +		Range from 2048 us - 117.44 s
> +  - ramp-down-ms: Current ramping from one brightness level to
> +		  the a lower brightness level.
> +		  Range from 2048 us - 117.44 s
>  
>  Required node:
>    - backlight: All LMU devices have backlight child nodes.
> @@ -90,7 +96,7 @@ lm3631@29 {
>  
>  		lcd_bl {
>  			led-sources = <0 1>;
> -			ramp-up-msec = <300>;
> +			ramp-up-ms = <300>;
>  		};
>  	};
>  };
> @@ -152,15 +158,15 @@ lm3633@36 {
>  		main {
>  			label = "main_lcd";
>  			led-sources = <1 2>;
> -			ramp-up-msec = <500>;
> -			ramp-down-msec = <500>;
> +			ramp-up-ms = <500>;
> +			ramp-down-ms = <500>;
>  		};
>  
>  		front {
>  			label = "front_lcd";
>  			led-sources = <0>;
> -			ramp-up-msec = <1000>;
> -			ramp-down-msec = <0>;
> +			ramp-up-ms = <1000>;
> +			ramp-down-ms = <0>;
>  		};
>  	};
>  
> @@ -212,8 +218,8 @@ lm3697@36 {
>  
>  		lcd {
>  			led-sources = <0 1 2>;
> -			ramp-up-msec = <200>;
> -			ramp-down-msec = <200>;
> +			ramp-up-ms = <200>;
> +			ramp-down-ms = <200>;
>  		};
>  	};
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
