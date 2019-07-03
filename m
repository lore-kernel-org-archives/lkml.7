Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587382187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xs4/fc3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGCHRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfGCHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so698807pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gD99gW/9Dg7lSZ/4ExF0SOAREijwbKmAygBAmas+l1E=;
        b=Xs4/fc3wUU0BjPfez//n1hFSTApxGZt/f5sN8ydx3jr2T+YuwntUIRbP00ajGFtjd9
         pqAgn6jbVIFdSl6Sky9lsttNNv+PwgG6kDXqSKUk4NDJFhXfs0Qqw3wMMRDH1ptU3QeE
         OOBEL4Kkln9iaRo7wwBh0UB6Op1nbZ/fOu/MYHLekuTyISo2lTPJ4DwHf56XL7k8nK/3
         4F+DYAp2O8dLLSh61YrKewlq7iqfO1e8LaIOAhenP9S5Xg9OYqMWv3m/DPIENzY6sOzx
         vrvb/B+lqnOkI+5FmcNT22x9AR/QHZmESNgYCZcJipcnPkjMeB27MoJGyoCixk8RgdG4
         ndUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gD99gW/9Dg7lSZ/4ExF0SOAREijwbKmAygBAmas+l1E=;
        b=cUj8b5UFIAvz2WmD8c2CMw/vmRHBa8hcIBQXA6mkzerQtCcTa8IRh0EZZGcAyTjMAY
         3zGObT4I23vbV2DVAnJa8GUN2+VrlC6sDpvjfHA3wA9qwcOw/OcC+yI2fmLoZzwiEceJ
         sU7t2oFkNEHnrcW1hFA3Nb4Hdnj3CGDcAALXQ/Fu7XWGrwLQffoJW9CItKWNYrfh/JOh
         7pKb6FSgP56C/GEiSBD9Hj9CQcztfehx/8dW/H29o69lIp4ov3w+SrTVMxNxKC/X3Lwm
         f10pbNq0YWS5gw+HLOtW/dBwlTbJ7v3UUZq/11Hxany7/plWMj4kJNMpgLA5U1PTj3hd
         l9zg==
X-Gm-Message-State: APjAAAU+L35KKr1bImk7b4k0euezHtebt+51Sv+G7DGlhTjQ+vk8Abfj
        XD3eJeWZLpFqz93kFok4pIyH8g==
X-Google-Smtp-Source: APXvYqz6a7i3FBX0Z/mT9l7rrv9hlBKZdLz5qbZnHXqJktyXNzhS0O8tKhenjnDF5zoastU4pcmleA==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr38737100plb.316.1562138223442;
        Wed, 03 Jul 2019 00:17:03 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q144sm1662568pfc.103.2019.07.03.00.17.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:17:02 -0700 (PDT)
Date:   Wed, 3 Jul 2019 00:17:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom: Document missing gpio
 nodes
Message-ID: <20190703071755.GG12249@tuxbook-pro>
References: <20190702105045.27646-1-vkoul@kernel.org>
 <20190702105045.27646-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702105045.27646-2-vkoul@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Jul 03:50 PDT 2019, Vinod Koul wrote:

> The bindings for msm8998-pinctrl was missing gpio-ranges and
> gpio-reserved-ranges, so document them as well
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  .../bindings/pinctrl/qcom,msm8998-pinctrl.txt          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
> index e70c79bbbc5b..280af41eb86e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
> @@ -40,6 +40,14 @@ MSM8998 platform.
>  	Definition: must be 2. Specifying the pin number and flags, as defined
>  		    in <dt-bindings/gpio/gpio.h>
>  
> +- gpio-ranges:
> +	Usage: required
> +	Definition:  see ../gpio/gpio.txt
> +
> +- gpio-reserved-ranges:
> +	Usage: optional
> +	Definition: see ../gpio/gpio.txt
> +
>  Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
>  a general description of GPIO and interrupt bindings.
>  
> @@ -175,6 +183,8 @@ Example:
>  		interrupts = <0 208 0>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		gpio-ranges = <&tlmm 0 0 175>;
> +		gpio-reserved-ranges = <0 4>, <81 4>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>  
> -- 
> 2.20.1
> 
