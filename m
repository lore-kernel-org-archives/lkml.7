Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E1BC74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAcuVEQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfGKOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:44:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfGKOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:44:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so3051174pgj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AeWgNBL0vGG9Q0W1XyAtTTadhrtMpodZjMiQ47VNvNo=;
        b=jAcuVEQQIMZ8TtPCtZhvvkOswtz9kMXpu3/fl/zZ8r2p4lBere/WDYW8TgghDn2afu
         Fl6E9jUg+eQKbEvv/wdRFpHjhczPrnpR5mV+JSSzuFvBpBnBvIeuSylHd1+G+y4gm8m/
         WHejBbnCV+/tD3TGRTKQo0gCHz786gypWQuMPD6gZ5PqSYfzSg8ZJONaxqVNSimqfhfr
         z/qYC+ij9SNjlI/oFpP5tVSy2t785VOBlar9uPk9Q2NnaKVczX3MfmeWMQplMkOxL8FU
         rrVL4yRhgm7uTQBxiRofM6yk/8gBYjhhjLfj9GmvY5rUUnPYIc4CCwVzDDRjF12o1f8j
         DE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AeWgNBL0vGG9Q0W1XyAtTTadhrtMpodZjMiQ47VNvNo=;
        b=s26BH86TgBTUmRw/Waja0Bpeldg8lELhuap45lhyhYLdinih6MiAAhT2I/e93TN3j7
         wby6/XSQzBbhWUpetMIAW7DEsqVWpTF8YdM3liJGUiCLj/jUCFud/gmaqUs9dLwDMnUv
         y6Z90f+5pL0dS0sUDSe7/+rOm7cSP9NYAYKwRtVEy2zQLXTTEi08FuLA0Qg121K9hG5m
         NmUpSW72ivhXQwSyvfapsThgpEStambVP0zclNm0cPoo6/ur6zCHX50LhlXCf8gzKtnB
         h+aNIj7wlwr8KK7U3EsxxStTGAYF1VkYiIJPb9APlRHdKVXGitTst6ycbpftByoa1zXT
         zdFw==
X-Gm-Message-State: APjAAAXIioji5cGhLlMA27XZ4fA9AEAcy3cmelkxymdLuvBvQ8ltpcdj
        lCo3mhtEL72319zvgkMcUqMg6A==
X-Google-Smtp-Source: APXvYqzZnI4QvrJWH5nNTwi3+akS6nULSvCsZQrVF3PWvIzD3Iw3lEJpqz8SxmHZU7/6w9TFNAqhAA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr5299751pje.77.1562856287236;
        Thu, 11 Jul 2019 07:44:47 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a5sm4953523pjv.21.2019.07.11.07.44.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 07:44:46 -0700 (PDT)
Date:   Thu, 11 Jul 2019 07:45:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 04/14] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20190711144557.GE7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-5-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-5-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  .../mailbox/qcom,apcs-kpss-global.txt         | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> index 1232fc9fc709..b69310322b09 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
> @@ -18,10 +18,11 @@ platforms.
>  	Usage: required
>  	Value type: <prop-encoded-array>
>  	Definition: must specify the base address and size of the global block
> +
>  - clocks:
> -	Usage: required if #clocks-cells property is present
> -	Value type: <phandle>
> -	Definition: phandle to the input PLL, which feeds the APCS mux/divider
> +	Usage: required if #clock-names property is present
> +	Value type: <phandle array>
> +	Definition: phandles to the two parent clocks of the clock driver.
>  
>  - #mbox-cells:
>  	Usage: required
> @@ -33,6 +34,12 @@ platforms.
>  	Value type: <u32>
>  	Definition: as described in clock.txt, must be 0
>  
> +- clock-names:
> +	Usage: required if the platform data based clock driver needs to
> +	retrieve the parent clock names from device tree.
> +	This will requires two mandatory clocks to be defined.
> +	Value type: <string-array>
> +	Definition: must be "aux" and "pll"
>  
>  = EXAMPLE
>  The following example describes the APCS HMSS found in MSM8996 and part of the
> @@ -65,3 +72,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
>  		clocks = <&a53pll>;
>  		#clock-cells = <0>;
>  	};
> +
> +Below is another example of the APCS binding on QCS404 platforms:
> +
> +	apcs_glb: mailbox@b011000 {
> +		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
> +		reg = <0x0b011000 0x1000>;
> +		#mbox-cells = <1>;
> +		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +		clock-names = "aux", "pll";
> +		#clock-cells = <0>;
> +	};
> -- 
> 2.21.0
> 
