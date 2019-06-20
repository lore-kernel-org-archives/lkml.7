Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1595DC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E275E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpiTkvyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfFTNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:55:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45630 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbfFTNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:55:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so2472797lfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gN9npDHvtiiw+G2OoIFVUnj6VlGP4K5Eq9adoB+2oMU=;
        b=vpiTkvyhchnCX87L9RpguVX9W+ZOULusr83tywsfahrLDjqKS4sZtLQspABrwh/8z3
         jOD2p8Vmr6oJ2ib0+dqq04dPWeAZm4U2a4YggfcP47StLqDA+zKpQwUDb8sMYCYyu5m5
         I6eSciPi7SMC3CeBp3eBKY+/Qt3cA9NCgE8oylHZ8SOfpEBl7JsldDcFFggN6oDkkUji
         bph5yeRp2QSwDGT9MoqNLZaHtxC94bA7cJNZkaDvKNTvwa5I1tOvmjhQP3RuZoGRYCxW
         NUSA4bNHeX2xbMlUbNLoqxzYUW72GjSlqU8GeAxzdAaPV1MKz3qBvVDP79EZ4fPz7YlM
         oKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gN9npDHvtiiw+G2OoIFVUnj6VlGP4K5Eq9adoB+2oMU=;
        b=Pk+XYFPxhz5dAvFvLBCowUi8UHhK3Li7GcpAOeTdF8YvPk6LWqE6BfXX53cv+2av+t
         2U2RgWjGMo2KYKZ3ktPuBXd8D9Do0zV45pR31TpH+SmusnM0XmI2pQirka9q5+NO78fy
         f6NRTlmjSfj9Y0VaG847seAwD2YPkHjG4tKPZM5elCHAFA0qS19ZZFua1muopMgfUL4b
         1AVZPtV/iBqJsFZzq6Yfaby76MfJz4hbPQZoNbpN3VSnqy/CbprPNIh31LhU9u8Rpjqs
         pxNFhnoYK9/GcHAXQ3CpRhnBdZb2Y8V2we8wZkkSE4LzalNuGGF26KTXn6ytcUkbZVGz
         DbJA==
X-Gm-Message-State: APjAAAVmlQpLqRS2A4EPnxIN6iUCPFXlsPpMThttElFbe4rCTitpQTnc
        fYABygTfZqKywXei/u1R0+BnKw==
X-Google-Smtp-Source: APXvYqyayvTh+dPs4kMq3+axhwB2kmLsJ7NqxVlYh6eIdfY+ZFp0xPODSAwSeEynyDiKLh6cCAdeng==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr51672020lfj.167.1561038932548;
        Thu, 20 Jun 2019 06:55:32 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id h18sm3148646lfc.40.2019.06.20.06.55.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 06:55:32 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:55:29 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_spmi: Fix math of
 spmi_regulator_set_voltage_time_sel
Message-ID: <20190620135529.GB16411@centauri>
References: <20190619185636.10831-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619185636.10831-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:56:36AM -0700, Jeffrey Hugo wrote:
> spmi_regulator_set_voltage_time_sel() calculates the amount of delay
> needed as the result of setting a new voltage.  Essentially this is the
> absolute difference of the old and new voltages, divided by the slew rate.
> 
> The implementation of spmi_regulator_set_voltage_time_sel() is wrong.
> 
> It attempts to calculate the difference in voltages by using the
> difference in selectors and multiplying by the voltage step between
> selectors.  This ignores the possibility that the old and new selectors
> might be from different ranges, which have different step values.  Also,
> the difference between the selectors may encapsulate N ranges inbetween,
> so a summation of each selector change from old to new would be needed.
> 
> Lets avoid all of that complexity, and just get the actual voltage
> represented by both the old and new selector, and use those to directly
> compute the voltage delta.  This is more straight forward, and has the
> side benifit of avoiding issues with regulator implementations that don't
> have hardware register support to get the current configured range.
> 
> Fixes: e92a4047419c ("regulator: Add QCOM SPMI regulator driver")
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reported-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index 13f83be50076..877df33e0246 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -813,14 +813,10 @@ static int spmi_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
>  		unsigned int old_selector, unsigned int new_selector)
>  {
>  	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
> -	const struct spmi_voltage_range *range;
>  	int diff_uV;
>  
> -	range = spmi_regulator_find_range(vreg);
> -	if (!range)
> -		return -EINVAL;
> -
> -	diff_uV = abs(new_selector - old_selector) * range->step_uV;
> +	diff_uV = abs(spmi_regulator_common_list_voltage(rdev, new_selector) -
> +		      spmi_regulator_common_list_voltage(rdev, old_selector));
>  
>  	return DIV_ROUND_UP(diff_uV, vreg->slew_rate);
>  }
> -- 
> 2.17.1
> 

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
