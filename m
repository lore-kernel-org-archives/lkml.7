Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6503C74A59
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C99020872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yP5AghxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfGKPYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:24:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46526 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbfGKPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:24:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so3184181plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcLmOYH0hVh2GO1koR1B1MREnozzKIb98UGVyNhgyvA=;
        b=yP5AghxJlmtJT9xbQURe83C3Vwxw/WRT3XNabuFWiu318/gbotdiRT7Z7tPhhpQFG8
         ej1EBV9UPksoB+l1MbLLY7Nc68Jm+Lh66M8Bl8JHkNQ/t5yWWd+yECZ1TbWOa8zCScVl
         aduTGbyw2OUoZHevFxhupOs/QsvYLmHhKiPN/HGTeUnGnYzX/13uE0lvyzuFY3r6YBfL
         fLmvaB7xZCrTW4lcMxCKhbp+jkvPCDD0qk7QM2e9x4clRLaYcgmQtGEkNPus0YoH4pOj
         ansTGICILH19ax66lhpZAFTxcB5aEMVnC+lywHkC+aRcSz6n/jZ6l9cuLuGIRBk/zEZp
         S4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcLmOYH0hVh2GO1koR1B1MREnozzKIb98UGVyNhgyvA=;
        b=JQsYL47tQcuBcMHiTVpWqKODy26HXGfMIjFfhQ216F8bWFaHm0rpapl8FvnFyBHQz/
         X96tYPnvaVr0oxb3M9pT1hbwyLZB7GJ7dBemcpH66UVAgVz5oRo7bAv8w7XLhYr50gL+
         pDXsVWFDb6+PqZl9hDDbs9R74pkjq4jv4JtWgcRHSUqIJSgapcz+pnGvA7NeRVt/AsAw
         0tmp4RI25ME6WQqhq3Gsw054B7vm3olnPRwCx9PcGesEy3XdLDWvxI5LLtP/UpXOlgDQ
         Cg88+UwzdzU2hiJGIYLWn9nE/+EItr2yc4pBPGAvzlEOt4VIJM/bXYogYydix+PJC9mO
         8Q6A==
X-Gm-Message-State: APjAAAWjq3V52H4SqB7+dQEQnRdwhHodFb7DAYX8e97owU7MVrq8Ee9F
        EFBLA78uchyAiLjuBJput7/E9Q==
X-Google-Smtp-Source: APXvYqx2Z1YHM2uEn8vgbB85BAvb/nr89ZG+X9+PjmEwJWGS+XE9Jl6Xl4zcIMmxL/6Lwml7CDeZnw==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr5078309pla.50.1562858645425;
        Thu, 11 Jul 2019 08:24:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 201sm8703572pfz.24.2019.07.11.08.24.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:24:04 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:25:14 -0700
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
Subject: Re: [PATCH v3 10/14] arm64: dts: qcom: qcs404: Add OPP table
Message-ID: <20190711152514.GK7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-11-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-11-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Add a CPU OPP table to qcs404
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 3f17e1b09c13..d876dae5b0a5 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -83,6 +83,24 @@
>  		};
>  	};
>  
> +	cpu_opp_table: cpu-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1094400000 {
> +			opp-hz = /bits/ 64 <1094400000>;
> +			opp-microvolt = <1224000 1224000 1224000>;
> +		};
> +		opp-1248000000 {
> +			opp-hz = /bits/ 64 <1248000000>;
> +			opp-microvolt = <1288000 1288000 1288000>;
> +		};
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +			opp-microvolt = <1384000 1384000 1384000>;
> +		};
> +	};
> +
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-qcs404", "qcom,scm";
> -- 
> 2.21.0
> 
