Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA45AC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829BA20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfgFzyXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfGKPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:23:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42775 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfGKPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:23:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so3199059plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CSfzn244zMxZzCnzEJ3aLKTkuzXbWd6fbHt5WU7kz70=;
        b=bfgFzyXO2fBQCSypPnFTn+swixOumjnXHhHumedREAjORqwINppI7oBdn7JVXBZRP1
         SBG3MN9K7Y8oMszK9cPs22p1SwNWQzZKY0UhQjtBkgIvPSR3jNjwslOPLCc+t1ZnaIz6
         vRLNVftkxpDQTfwUYShAk/WmPxOFd5L+dXDn7qNKXZ/02M3d2iyEZJHdsOIgELYSc+Pb
         /eOwGYeNsg+jtpRIMohfcX57KX2iyWjg758Xf6uVtIu88pKaAEuFS69GVhzM5l7wDi8Z
         G8QHOxO6E7g5kstUcj2BpC7mKw+2NgKFqhu6V077ipaZRPsxVHrpV+uQiKhDKauLWSh7
         Lw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSfzn244zMxZzCnzEJ3aLKTkuzXbWd6fbHt5WU7kz70=;
        b=EX3kvzqP1y4TivCOdKr9TEG0nU/MvVeRL5Kho2+c4hYaB+/qmlb7jXj6p4vEmw6HDw
         QEYPqllzpwjh6T03tSHiR51p49l9rys2PKKfPLqFn2AK+H/C+vKEIohSTdGr4Tv9LmgI
         WRtHvD9w1uL1K4VgE0a067LwIeyUQ2kw+FgPAMfQigxYw4V1pQCdLXCQvIYZ2r2sY871
         FoZFcTxWLhsmtWB1MalrWwEJeePBdV87h0x8i8Qw3MqnS1Y29fdOwWSvJ/yWqeYy9al1
         O9OmqWep3nJ5zIEOwMK0fOaaLjQUdvF8W1AIPqk4mxJuoQZ8OG6iCaMXqSR4cgGLhLQv
         PMiw==
X-Gm-Message-State: APjAAAWy1J8Q4C5JeYx/2+egyJSu/FQCj8guXjlyHjYmEDyN9BUzwXnR
        xUowAccIHlgvsowO5RDQxr/I0g==
X-Google-Smtp-Source: APXvYqzC8zW9AaWRDb9ZlRE16EvYVQBSACMCbbatUXf1UeDd0+O1VMv1PBXTJBbV67HowoIWiWdnlQ==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr5011846plg.142.1562858623622;
        Thu, 11 Jul 2019 08:23:43 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r1sm5002102pgv.70.2019.07.11.08.23.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:23:42 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:24:52 -0700
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
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: msm8916: Add the clocks for
 the APCS mux/divider
Message-ID: <20190711152452.GJ7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-10-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-10-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Specify the clocks that feed the APCS mux/divider instead of using
> default hardcoded values in the source code.
> 
> The driver still supports the previous bindings; however with this
> update it we allow the msm8916 to access the parent clock names
> required by the driver operation using the device tree node.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 5ea9fb8f2f87..96dc7a12aa94 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -429,7 +429,8 @@
>  			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>  			reg = <0xb011000 0x1000>;
>  			#mbox-cells = <1>;
> -			clocks = <&a53pll>;
> +			clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
> +			clock-names = "aux", "pll";
>  			#clock-cells = <0>;
>  		};
>  
> -- 
> 2.21.0
> 
