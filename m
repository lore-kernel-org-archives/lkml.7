Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49594C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192EC218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIO9B22h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfDYMSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:18:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39928 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:18:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so202161ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Xj+VwBNrmuYIiQmlaEtZKGgTgdpVOMCnYWSIjQ09xY=;
        b=WIO9B22ht5A3k/qGbZfJZQYe3Nhr8xFAUhVZjLku76v+3r+u9YTYq/D3qHyh/P3WZt
         mfaK4x78K6kZJlRoV8x6OJ80NmCKs0sM+/q2cKY7pneqmEnC1zgbin/ArvYZM3POENFj
         6RBxRzpK0UmsE2k5eJyfiakNkGdj/vwX1OdXtS/w/dUUAOrrLtNspTijgd8v/8YqzTTo
         t9g4I4UGS+c5w5xZ0NhQn9W3RC9KfHJ/iyYv8yvwaEPJDsVwDO4KQrteu/RHChyyWEGf
         4l5o1toPygfBspuMLlkIjs1cjO1kVOXlx0uN64jDCe4vNFYvev/HmvyUP/4qwccLTqOY
         vs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Xj+VwBNrmuYIiQmlaEtZKGgTgdpVOMCnYWSIjQ09xY=;
        b=rVSm/Fea+0rHZ295ieWfgA4aZteaspPdxnCB/69j5Ffkgok1VgS36feTLGtKifW+qn
         pK/tqPj3kji0CnJV8s/BvZSQBQJcY5tTmdIXOVG6lT9Jc5bNcvZluUqq1geoQrxkhrZ3
         MF808RKyHfmqzIzs244or60nOsqTYltYMh44aNU4IY5Qbcj/2P+tRCwoUUPuEf8EGq+N
         WWBcZmiuIiP6bI7OLlJtv0+zdE17Zs7aFg1QVMGODh0g9LBKdjTQQ+oIu+bBxhHlRo1u
         Zo//OyK/LJPq/tyq6EHvySu3eyTF0jTqFG3zQZ8XYqdyd01NiLc2SwLgXPkpBUJ+rZZa
         hCPA==
X-Gm-Message-State: APjAAAXx96JClqe3/RvNkuFh/bTwBu8DGbGOQjcLC442u+1SQgkFQSbn
        ZR/9aY/ZmCWcysO3ZzDe4CnqTA==
X-Google-Smtp-Source: APXvYqx3HAIlMkMgRB5hQHapo9BaLSPBRo0bzeY60IpGrOsnjh0fMbgKF25Wtz/Yc0HqOod+hdnopw==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr11660165ljj.4.1556194688895;
        Thu, 25 Apr 2019 05:18:08 -0700 (PDT)
Received: from centauri (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id b12sm5008664lfa.74.2019.04.25.05.18.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 05:18:07 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:18:05 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: pms405: increase s3 max voltage
Message-ID: <20190425121805.GA17362@centauri>
References: <20190425113429.14321-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425113429.14321-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit description should be: arm64: dts: qcom: qcs404-evb:

(The s3 regulator node moved during upstreaming.)

Andy/Bjorn, could you please fix this before applying?

Kind regards,
Niklas

On Thu, Apr 25, 2019 at 01:34:29PM +0200, Niklas Cassel wrote:
> Increase s3 max voltage in accordance to QCS404 CPR Fusing Guide Rev 6.0
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 2c3127167e3c..6910fc663fe1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -64,7 +64,7 @@
>  		regulator-boot-on;
>  		regulator-name = "vdd_apc";
>  		regulator-min-microvolt = <1048000>;
> -		regulator-max-microvolt = <1352000>;
> +		regulator-max-microvolt = <1384000>;
>  	};
>  };
>  
> -- 
> 2.20.1
> 
