Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C098C74A59
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgIByt6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfGKP2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:28:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36819 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGKP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:28:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3220536plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMsVDicDOb3lhj4yIbuOZntxA7sECtLuV+gybGzQqeU=;
        b=rgIByt6j+CT1bDeZ1dG5yEGPFHYKSyg+NPlvE5ax2UXaEqyinB3qWooX58sy7y537i
         ZMT7aafv0DVnlW86rYn2QMv02OMIB7hmQbR7pOKbj5YQlSuIYmFnTZXfPpASzu68AteA
         tkBbTDr89/zlXNs7mOSqOZs7UtNmCAqFBowjFlBGutQXB7GDTQCcVkeaGRknXA3q7wEJ
         fPUim1MajW40r4S/kv4z/xfVjvzYuMQIIbGx6u8Y2YmUjGw8MBjZABWJPxbQUx3b7Jmq
         /H+EFAin5UVLoubHVbRiwJwT3EiOnpBLZYYzNwkbjoigIhmnka0zO9EaM8nBu+OGgp3c
         UkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMsVDicDOb3lhj4yIbuOZntxA7sECtLuV+gybGzQqeU=;
        b=BPLnKfS7P31IKIGb4u3TaYSd5WESzOxqiKeFDRg9mn6dklOj0ndCChSLsjmzbPQKRY
         0QD4iaXGwheLw/QBqUT6LahCE6qGm3pFW80Nl9E5IRKVZiTnOTEqtr0MfrDH9A4EIRuS
         zgfM81hnBI63C//Th329AkoCobFKGrvo6/+cu5xUo+6C/vw2pk5fDNVNDbu/7oQEl+Dl
         6HQ8VExiPEbYC5TL3JiGUnWXjDIdroVB6we2DJZMQHMIblt7VAHuPb03bPu+sP9FVlKN
         ig02zPLbE1jT5cSDGkZKxHaXl34pw0TonufqrjfIWAdJGjxsgKWgFQ+ShDbKuTtmel4b
         YC5A==
X-Gm-Message-State: APjAAAUortjiT2W0laHWTCNpwMYYpe2wBEnwJTmJPez7tDAU5gTWLV25
        n48PiCitEtGjAvv5wsPc5eo/og==
X-Google-Smtp-Source: APXvYqwNbmI3JyRFZsBS7iOj0fl3s07h7X0FI9ixCmAonmnpaGSvvC0CiHoHMbDvsZcDftbZGo/7Rg==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr5168522plj.116.1562858879444;
        Thu, 11 Jul 2019 08:27:59 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h14sm6439150pfq.22.2019.07.11.08.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:27:58 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:29:09 -0700
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
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: qcs404: Add DVFS support
Message-ID: <20190711152909.GO7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-14-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-14-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Support dynamic voltage and frequency scaling on qcs404.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

I agree with Niklas on the possibility of squashing this with the opp
table. But unless you respin this

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9569686dbc41..4b4ce0b5df76 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -34,6 +34,9 @@
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&pms405_s3>;
>  		};
>  
>  		CPU1: cpu@101 {
> @@ -43,6 +46,9 @@
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&pms405_s3>;
>  		};
>  
>  		CPU2: cpu@102 {
> @@ -52,6 +58,9 @@
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&pms405_s3>;
>  		};
>  
>  		CPU3: cpu@103 {
> @@ -61,6 +70,9 @@
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&pms405_s3>;
>  		};
>  
>  		L2_0: l2-cache {
> -- 
> 2.21.0
> 
