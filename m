Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B0C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4479F21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530851;
	bh=XZkPg42MjxDTEdJlMwmA1I7MMJCM567vKaDFFQO/D4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lGUu5jHU2HsK0eHrcVK6bL7CsBTVbcJ03Wc5MHUbtse7JEG7g398EHZmybuG8nJRG
	 eEZSULf9fix/HZfgoYrMWJ2AySTqNDoZHMFRWQ12uSl0PNVGSNbrR4gIXQbqj9WJOd
	 ACWM4JAyBniisHDZ6SsXNA8eIcBxsefhkP4d28Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDFGHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so4457752pfn.3;
        Fri, 05 Apr 2019 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=R0cBTNmYa5ZMa7v6+KWY6z9n/NLmb68qLhUTjr5EjE4=;
        b=m3icVLiL5JZAJJJFCJ+JLNQdpEJryBl5xXUoeR77OfBWhKLuAQwfZCtIBBBW3S4kpQ
         0YJT5TCoInVqPvUV4NGuebHEHorIXRLQHD/W2zfUJEU34JuSJmx0ZbPVxk5TqsxBSbZP
         1vv4c4RsJ20PkLs6IfJhgZ8hSyx8GZe+i7wcZYcwcYiJPI+4b4paBMejxcbVz/wBvXXI
         6G/argBD+iU+NfCDAmJ0+voG1n/29V80S7br7dltL5NhJzIupW9VDvOHwbH98JCCF7vF
         YEF3ko8GzwM0V5VA/zuMeIIeG+Ki2pLkCinKX4NlZaK/MUp33mUrnv9lzZ8P8qSM0cth
         J0OA==
X-Gm-Message-State: APjAAAUhqnrW008XIVBZIzCNCqvI8vJQ0TGiGZ4E+zjH090BML+jpVAj
        vGepuxZetw1Ljn1TvSuOGw==
X-Google-Smtp-Source: APXvYqwJHnb6B8VkTgSLH+GFvvHsyKelqgzPSbLzvBuQ+RgwX5JVCKzY8MildZUkARJlHb+2xR/7xg==
X-Received: by 2002:a65:6645:: with SMTP id z5mr16356135pgv.251.1554530846692;
        Fri, 05 Apr 2019 23:07:26 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id o76sm61402541pfa.156.2019.04.05.23.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:26 -0700 (PDT)
Message-ID: <5ca8421e.1c69fb81.42211.e57b@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-3-niklas.cassel@linaro.org>
X-Mutt-References: <20190404050931.9812-3-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:09:23AM +0200, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |  16 +--

Please make DT bindings a separate patch.

>  drivers/cpufreq/Kconfig.arm                   |   4 +-
>  drivers/cpufreq/Makefile                      |   2 +-
>  ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} | 124 +++++++++++-------
>  4 files changed, 85 insertions(+), 61 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (97%)
>  rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (69%)
> 
> diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> similarity index 97%
> rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index c2127b96805a..f4a7123730c3 100644
> --- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -1,13 +1,13 @@
> -Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
> +Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
>  ===================================
>  
> -In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> -that have KRYO processors, the CPU ferequencies subset and voltage value
> -of each OPP varies based on the silicon variant in use.
> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> +the CPU frequencies subset and voltage value of each OPP varies based on
> +the silicon variant in use.
>  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>  defines the voltage and frequency value based on the msm-id in SMEM
>  and speedbin blown in the efuse combination.
> -The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> +The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
>  to provide the OPP framework with required information (existing HW bitmap).
>  This is used to determine the voltage and frequency value for each OPP of
>  operating-points-v2 table when it is parsed by the OPP framework.
> @@ -19,7 +19,7 @@ In 'cpus' nodes:
>  
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.

You can't just change this. In any case, it's just a string. Use it even 
if it applies to more than just kryo cpus.

>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>  		efuse registers that has information about the
>  		speedbin that is used to select the right frequency/voltage
> @@ -127,7 +127,7 @@ Example 1:
>  	};
>  
>  	cluster0_opp: opp_table0 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  
> @@ -338,7 +338,7 @@ Example 1:
>  	};
>  
>  	cluster1_opp: opp_table1 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  

