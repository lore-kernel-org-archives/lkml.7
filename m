Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528AC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF98E205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoJbCJ7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfEVDuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:50:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42089 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfEVDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:50:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so365898plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7Biagvh6d4wrBsXZmdQpJBIYqCgkhGLw5kNc+TIy7I=;
        b=DoJbCJ7LcTJv/2630kZj1+P9sznq9t9odB/UFqEtILVxEiqhGDoiUhzxjoATb3BvdZ
         eWhpn7j3D2bK4yxTPSA05UcTXgNixl4QfnMx0iRQWT3vOZSnAFgw5ucAvqD4it+5C0y0
         ECK3i0iWLv6e2BsCChu9LXYHnASqVgsVfpHfcHz7iu9VlpoDskoQ/g8Hb7NkS2sE51n2
         KD8roIiwMS1zpPOcUjA+mzPeQx3PwoZb+NQXvqoR/tzWfyqXsgi6UbGu3BFEezgdkwI1
         XmNi4QR2ljf51GIQJtcU44dyxY5bbvHhwnlPE/GF56za24MjKguKpEf66bbfovipgsnZ
         WbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7Biagvh6d4wrBsXZmdQpJBIYqCgkhGLw5kNc+TIy7I=;
        b=DbGbIwxzQabdBw4oFSn42cj7cpTjAtEFe1/IfcfC4FJC71LrwDoh4EvMLOWAR7eLLZ
         5cl/zftSTIdU2P88mNtCTrV4u2opO+CSP2W4lb0T99B0hYzoCFxw9MtCcAKu/syU+Igo
         saDi/AUhXqRLoXeZiAKYWLDRbxbU56E5JCq44J+b2pybiRnDW0LFdLj7Kt8J0WU2foj3
         AdW8PFfXekVKe0sygoeXT6PbUmY69CIatndNAqocB6wlficQY+v5eSsQMV1Ut6AcZazu
         3pWswv56dc95P/Jaqyw8aTnod4BS+lU2nC18aDKT9miJRH5TNrsa1pNSbKWbpifDtFLl
         cPCw==
X-Gm-Message-State: APjAAAUHmfdV+r06SRdw5I2+WzEJBuXBk5hgUCzkTQRrSN96a0HQjrGu
        Qf8EE+WftB6k21r1lDCW1R7ZMQ==
X-Google-Smtp-Source: APXvYqwt+6GFj/6qsn+20G3WhDulea0NuX31G2lC09L7iKXZ97YCD+AR8K2z+YCPHEa1qaQEhUbQPA==
X-Received: by 2002:a17:902:158b:: with SMTP id m11mr46473194pla.268.1558497031162;
        Tue, 21 May 2019 20:50:31 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g8sm282837pgq.33.2019.05.21.20.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 20:50:30 -0700 (PDT)
Date:   Tue, 21 May 2019 20:50:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, niklas.cassel@linaro.org,
        marc.w.gonzalez@free.fr, sibis@codeaurora.org,
        daniel.lezcano@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 9/9] arm64: dts: msm8996: Add proper capacity scaling
 for the cpus
Message-ID: <20190522035028.GN3137@builder>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <5224535a7ef5b257e3baa698991bf6deeefccc36.1558430617.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5224535a7ef5b257e3baa698991bf6deeefccc36.1558430617.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 02:35 PDT 2019, Amit Kucheria wrote:

> msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
> the same microarchitecture and the two clusters only differ in the
> maximum frequency attainable by the CPUs.
> 
> Add capacity-dmips-mhz property to allow the topology code to determine
> the actual capacity by taking into account the highest frequency for
> each CPU.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 4f2fb7885f39..e0e8f30ce11a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -96,6 +96,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  			      compatible = "cache";
> @@ -109,6 +110,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -118,6 +120,7 @@
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  			      compatible = "cache";
> @@ -131,6 +134,7 @@
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_1>;
>  		};
>  
> -- 
> 2.17.1
> 
