Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9B208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kH0Y5j1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436789AbfHIRAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:00:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43659 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407439AbfHIRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:00:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so38193567pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQe6ew6EIuFXeLlZv8LtrdQvCD02fcDe9gmuPP3qi/s=;
        b=kH0Y5j1nHYWzkDq/Qoxxr4NC+cgj7xa9ho1tUL8KA3hZmnbes2pVZZBrUehMulpgE9
         ibMetjDE0ZoqqFdfeAqlc83Fgvp/MFu1J3JFJiQ7ej+YSW1Zind6hD5/Y3sx/KtmUfOu
         WSEPt8T+XVfhruKADp6OaFA7jcNxhqICyhEdeP2uA3HrcwuTy0TqEqNTWjlY5Doftboi
         2kOCzU6+nkze2uRTYir0coAyGplP2+rQR8Z1fd1rI5aEYCpiaAHzmkzSfu0H6KiAVM/S
         Dzu9mdpMeRnVI5DtT1/SqUh7GwG56TX+t/RR1tLTxmflgFXk+cp4orm9bfcz+wW5QcTp
         deBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQe6ew6EIuFXeLlZv8LtrdQvCD02fcDe9gmuPP3qi/s=;
        b=oMOxHgW27UfyPz4kZf9EPREFV5UCVzhXhOBy0A6uMk6dKtyCeX4cZkgIGDConsHEfv
         ZZdqTtrxce+HdSkXkrqSUwrSGVmogBUIYjGdL70S0/5notFHrO1WkdIN6VY+Sbt4XfHb
         +jipnxIycZXXbtxyuJglkrHX2pfW2U7IjO1iOyiO/w3FUHc9OZ/Nd1nHYPOUb0xXjJVL
         R6AfCCyMjE50F3SntKtOlJPjWwxPqZtWiPcHa/Pu2WPf1jiwXd6qOgIjKZftC0YqlHTO
         DSzR8v7toNal7YxbI2TTdsctw50b0qzBYBJq4O2oGM6usIRaL6hD2qg/zNNN7jU/D7vQ
         vKsg==
X-Gm-Message-State: APjAAAXk2Ybei9ma9+3Z902YMfQDTNT9TtsEy4Yk+tY5Q47qBrgB3FDs
        lLg8hYS6Au/tYCSPuXsXxsozqw==
X-Google-Smtp-Source: APXvYqyH7lr5etiJgvdBKU7PpRWbpeGLt963jNmcvwdSEeNDY0Eij8BM6SIM9Ih5P6YBlGFRLHaavg==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr9943532pld.284.1565370039322;
        Fri, 09 Aug 2019 10:00:39 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 5sm35954078pgh.93.2019.08.09.10.00.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:00:38 -0700 (PDT)
Date:   Fri, 9 Aug 2019 10:02:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] regulator: qcom-rpmh: Sort the compatibles
Message-ID: <20190809170213.GN26807@tuxbook-pro>
References: <20190809073616.1235-1-vkoul@kernel.org>
 <20190809073616.1235-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809073616.1235-2-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Aug 00:36 PDT 2019, Vinod Koul wrote:

> It helps to keep sorted order for compatibles, so sort them
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 693ffec62f3e..0ef2716da3bd 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -878,18 +878,14 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id rpmh_regulator_match_table[] = {
> -	{
> -		.compatible = "qcom,pm8998-rpmh-regulators",
> -		.data = pm8998_vreg_data,
> -	},
> -	{
> -		.compatible = "qcom,pmi8998-rpmh-regulators",
> -		.data = pmi8998_vreg_data,
> -	},
>  	{
>  		.compatible = "qcom,pm8005-rpmh-regulators",
>  		.data = pm8005_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pm8009-rpmh-regulators",
> +		.data = pm8009_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pm8150-rpmh-regulators",
>  		.data = pm8150_vreg_data,
> @@ -899,8 +895,12 @@ static const struct of_device_id rpmh_regulator_match_table[] = {
>  		.data = pm8150l_vreg_data,
>  	},
>  	{
> -		.compatible = "qcom,pm8009-rpmh-regulators",
> -		.data = pm8009_vreg_data,
> +		.compatible = "qcom,pm8998-rpmh-regulators",
> +		.data = pm8998_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pmi8998-rpmh-regulators",
> +		.data = pmi8998_vreg_data,
>  	},
>  	{}
>  };
> -- 
> 2.20.1
> 
