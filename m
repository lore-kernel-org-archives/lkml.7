Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB3C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3779E216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDxdqNv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfEQPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:41:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42941 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfEQPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:41:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so7612252wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gj/3k+5YXyOcGv0iXoHljfz8L17O8uPATyM/pLVBy5g=;
        b=YDxdqNv4ZifPg1Yp3qKd9azdnjATJqAOh1+S48lTJkYpukVf6tSBt8AY8GKRB0nh/v
         pO/Mm586ywpXC7QFqp0LIZwVf2I+HI8qOQfAPRtj22XuALFEPOcoc2VCT9v9jqe8Jvyg
         /4PZI9MBy+HuCaNzbHlXvazj8LUiQ7DjcoJX4Oo7g+8BtFH/3uRNfPQHv7oYvDAJ7iB9
         xeziXpDTrlTutWkZPfjzZGOD+KfZ+SZKAJ9J7xCiOv9F/+e4UqNXwu5VimQzHVBbrioz
         Lh8UaK7kIWxUgyf3IbMj1teiiEnuENq7+AtzJaCbzmO2uOFP24EjEASBKbZlvo7Ufrqk
         gwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gj/3k+5YXyOcGv0iXoHljfz8L17O8uPATyM/pLVBy5g=;
        b=jSHLvqZGCn9W/2aiRz3CahAPf371CokgnYV+v6Vn9+aHT75ll9N7gvMIaEAXmeG0yj
         GG7Y8+V6vM4OFS4FhxgcWIBUAmuygu7Tf1I8Rj0HMYQioWiSERwOJRdzVkPL6XUkrtHR
         bR7sw4uQkGTp4iuRCfKyL/8YNc/DfLJmONJIB2kY2A25yEaRrC2m6oOimyNSaMSn7E4S
         DmzY+7Ccd8VkikOVcv9TOeTRcJ4cUi3rph/4vUcQdUAf3Vk1xU8ONE1D6jxK1fYRMIeD
         silMZN9hTVxbarrJWkqFBYFdF3RkFkrAA73Q299oN6o1kKaI3dYMk9w6LA2PILybKwNU
         U2jA==
X-Gm-Message-State: APjAAAUewmwHJOfoay6QuM2Z9Vwxs2Y1vngKDtKOaFDSD5G9557ZmfPL
        QCIkUX7WpCxpb+pNMbmNdb7how==
X-Google-Smtp-Source: APXvYqxpKXi79qSS1349vVVUIg8A1rucfiWHuUhRntac/YUjAckwQmm4o5RYFw85nlDp8nkt1gQsEA==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr3544035wrv.333.1558107664290;
        Fri, 17 May 2019 08:41:04 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l12sm8244563wmj.0.2019.05.17.08.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 08:41:03 -0700 (PDT)
Subject: Re: [PATCHv1 4/8] arm64: dts: qcom: msm8916: Use more generic idle
 state names
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c4751930-e176-881e-a3dc-cf1a2e8d5257@linaro.org>
Date:   Fri, 17 May 2019 17:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 13:29, Amit Kucheria wrote:
> Instead of using Qualcomm-specific terminology, use generic node names
> for the idle states that are easier to understand. Move the description
> into the "idle-state-name" property.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index ded1052e5693..400b609bb3fd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -110,7 +110,7 @@
>  			reg = <0x0>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -122,7 +122,7 @@
>  			reg = <0x1>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -134,7 +134,7 @@
>  			reg = <0x2>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -146,7 +146,7 @@
>  			reg = <0x3>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -160,8 +160,9 @@
>  		idle-states {
>  			entry-method="psci";
>  
> -			CPU_SPC: spc {
> +			CPU_SLEEP_0: cpu-sleep-0 {
>  				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
>  				arm,psci-suspend-param = <0x40000002>;
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

