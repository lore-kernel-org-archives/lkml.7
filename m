Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D97C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98C52083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVBVhho/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfDIKHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38304 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfDIKHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so9029721pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=63RC5yV5xPuk6vbHnpK6FXhUlEyzGfikDI5OAE5o4dw=;
        b=SVBVhho/CO1pj7d1xtD204w37VeuqYRg+2kyhK7a2g4ls69frxCc/QCr/+OivOcaLb
         sXqdV9a3hOyTsKAD3r5Ewnb7cFaRdHENj/q5aoOSJ1PvlTmlW+lGx5O9btIAzo7iZze1
         i+uFUZBqg2qCFqQtPAd/6P42OyF3JuZ+XrrSGxhNCv2ssVwzK1KBCpy2azIcKf5tRklI
         cxaqbBrjEyjiEmWd3aS7lmFVIqmSgCaIieLGGDy7JewPIKKr/dxs/wC5CfDJaXDr9V4Y
         ZG7b6/1/HVCtvZ8Xp6IBFFjg0WN5tgRYBMaIoRyFZ6h0NrNTtZqhVPaVlamkht+BylRB
         tCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63RC5yV5xPuk6vbHnpK6FXhUlEyzGfikDI5OAE5o4dw=;
        b=UFiWcyM3XFF+fNvjHdsLD54qWX1/I+zKIrQzb1VwEdxF62YoUv6feXwJrAwICOWpD7
         2+4ZQcKo98apMFdC737W2IjuIBWm+djsEtR29gSzNoc2qtXeCrFLStyRa7lzL2j2eS71
         i3wOTnMJ4ewxUl10cZItVsMmNfrkFI7Us1otbI8Vjiz0dvcNTMrgYy70EXwjZRex90Ao
         P6I0pty1qAjg8sPyj5Rg3AIt90UyrTIvw0towe4JX8CZvbHzAsstx5RBKhO//IVE42Oy
         Pm1o/rSLsyrDnQP0qVqiAM1JoM/iBHU1CybSHKf7PnKB0Y9mKROY9bseCjCenalBlrr9
         RyKg==
X-Gm-Message-State: APjAAAVVCjzltO5ak44GYMcN9q0kyLTs6O/XP/bhxHJQ48xgip6m9+Nt
        +Aumc+vVFQbua+cDbfj/FqJ8Mw==
X-Google-Smtp-Source: APXvYqxs5ramzBDSy8hQA1StgrIc+AZTeFh+vht56AKFMjRQvbnWuF9X4qGf1dEcFKRQHg9MhMTtaQ==
X-Received: by 2002:a63:c505:: with SMTP id f5mr34218953pgd.87.1554804453806;
        Tue, 09 Apr 2019 03:07:33 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id o81sm26333085pfa.156.2019.04.09.03.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:07:32 -0700 (PDT)
Date:   Tue, 9 Apr 2019 15:37:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Message-ID: <20190409100730.2rtxyy66knjning6@vireshk-i7>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
 <20190405102455.15311-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405102455.15311-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-19, 06:24, Yangtao Li wrote:
> +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +        };
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2-sunxi-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +		opp-shared;
> +
> +		opp-480000000-0 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-0 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-0 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-0 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <940000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-0 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <1060000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-0 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <1160000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-0 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <1160000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-480000000-1 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-1 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-1 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-1 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-1 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-1 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <940000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-1 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <1000000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-480000000-2 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-2 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-2 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-2 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-2 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <840000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-2 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <900000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-2 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <960000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +	};

Well, this is pure duplication of all the OPPs which isn't great. If I have
understood things correctly from the above example, then all you want is a
different microvolt value for each OPP, right ?

Then you are using the wrong feature of OPP core I am afraid. What you should
rather look for is opp-microvolt-<name> property, look in opp.txt bindings.

And these are the helper you need to use:
dev_pm_opp_set_prop_name()/dev_pm_opp_put_prop_name().

-- 
viresh
