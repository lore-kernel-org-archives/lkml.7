Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC5C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0F420693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t23I+rpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJJDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:03:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34768 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfGJJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:03:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so936572pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NZ04dqkp5PZfb0iXau7OgJEqRReEfjejYdtenD28ag=;
        b=t23I+rpKmwsx6L9Q4vUWFIrJBxJxq3TYfSJJPSu/DjOD1DCo6AlHTwiZJlR7EcNGLO
         GcQlUTbk8YYTWXMsTz7Ef3BZFWCqFrJHdwQJnu1FY5awvwwGJ0c2XwZ8QwIsysig7Ih3
         tY04e41XUxPfvyCqSBO3x1irGqEIENikMgzQBi4MZ4IdKu0Zx0koI4Yp/RMuYBu0enit
         0Lsxto60XXj2SyuYhy6rrP8meO/YIeFPeGY5iNej4rSHjrjV86VWSjpA/QCxHNdTt5I6
         qHBx7HRK6cDVRQ7y+2ZpeyJApVKKrYbHzVzKOl0ckKy1KNxZuK/6Z3vXfmAAzmEvpGUs
         uLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NZ04dqkp5PZfb0iXau7OgJEqRReEfjejYdtenD28ag=;
        b=gufGFjciiwBUp7cfQw0oQPRdAui6v6nieG32DJTHEIE1qHnliKRoQu1Ewak+fALR5E
         EZ31+xv/X2ZZ5sjDwYiAtjNhdLrBYbqBJzDV625/8K9srmTBOGWNjNrPk7lH/DTIzABg
         N3+BssR4F5nSK5xCDx2poYUGLhIE5hP+PgRmHJFptmIfvnFzyn/lMfMLF3VI+J5qOSAB
         Fa3+VWHO4xGm9iZaxD3hGh5RRhaf/Og2wP5nfrOPIFcbCGEpCbegRyqJHFcBnrng22rR
         s8cbJhdY0oOgquhIN/v4mr4GjRhMMWCf89RFHJfk0UR9wMMg1ejz1GMrkyaOvoo40GiD
         Y8lQ==
X-Gm-Message-State: APjAAAUkRijGA6GET5v+ha3xUL2M8jfiXqKHAJnY7kNcZxFRNTGsYw5x
        45Ap9s3o5vjitrs4wNpJg8ZMhA==
X-Google-Smtp-Source: APXvYqxK+S0LBckyQx94QVniKkTJ+/+6VuQvBLPkooC8SUohB+Wy0vvz/pDDQjQLOEljUV6HT7fR5w==
X-Received: by 2002:a63:ad07:: with SMTP id g7mr33649130pgf.405.1562749386689;
        Wed, 10 Jul 2019 02:03:06 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id x65sm1633917pfd.139.2019.07.10.02.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 02:03:06 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:33:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: qcom: qcs404: Add CPR and populate OPP
 table
Message-ID: <20190710090303.tb5ue3wq6r7ofyev@vireshk-i7>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-12-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-12-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-19, 11:57, Niklas Cassel wrote:
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>  	cpu_opp_table: cpu-opp-table {
> -		compatible = "operating-points-v2";
> +		compatible = "operating-points-v2-kryo-cpu";
>  		opp-shared;
>  
>  		opp-1094400000 {
>  			opp-hz = /bits/ 64 <1094400000>;
> -			opp-microvolt = <1224000 1224000 1224000>;
> +			required-opps = <&cpr_opp1>;
>  		};
>  		opp-1248000000 {
>  			opp-hz = /bits/ 64 <1248000000>;
> -			opp-microvolt = <1288000 1288000 1288000>;
> +			required-opps = <&cpr_opp2>;
>  		};
>  		opp-1401600000 {
>  			opp-hz = /bits/ 64 <1401600000>;
> -			opp-microvolt = <1384000 1384000 1384000>;
> +			required-opps = <&cpr_opp3>;
> +		};
> +	};
> +
> +	cpr_opp_table: cpr-opp-table {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		cpr_opp1: opp1 {
> +			opp-level = <1>;
> +			qcom,opp-fuse-level = <1>;
> +			opp-hz = /bits/ 64 <1094400000>;
> +		};
> +		cpr_opp2: opp2 {
> +			opp-level = <2>;
> +			qcom,opp-fuse-level = <2>;
> +			opp-hz = /bits/ 64 <1248000000>;
> +		};
> +		cpr_opp3: opp3 {
> +			opp-level = <3>;
> +			qcom,opp-fuse-level = <3>;
> +			opp-hz = /bits/ 64 <1401600000>;
>  		};
>  	};

- Do we ever have cases more complex than this for this version of CPR ?

- What about multiple devices with same CPR table, not big LITTLE
  CPUs, but other devices like two different type of IO devices ? What
  will we do with opp-hz in those cases ?

- If there are no such cases, can we live without opp-hz being used
  here and reverse-engineer the highest frequency by looking directly
  at CPUs OPP table ? i.e. by looking at required-opps field.

-- 
viresh
