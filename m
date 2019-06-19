Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E524C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLv5a3dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfFSTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:06:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35443 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:06:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so212504plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ML5TdHcdMxiU+u3GNvYmF9q/Wcykd3GF57yT+ShoBQ=;
        b=dLv5a3dYj6WUcr+5mCS9ysYf8eM+p2D25Chyxm8F+HWGU4A3+WHYA/u+8VZMCXYvQ+
         KRzJOCTCT5mPCHaHtGcGvWNjYuhjGTDveFPeRvJDIM142RwT1VqFxVx8PcSx//XskaBl
         KBA0lRgFjgVEuN0Dv9KiA7Ar8QwwyHZlg86OyIS2RtjWMmXCu2eI4HaOf+uJw9i5S/9p
         0OClM6XPehas4V1957qQnLx21VVaoHf9LIlcyzdR/GxiMQcS1dMjC03d8F/Erxv0T/ua
         JP1wt0FG1rAZgF7oQEZpE3MRN4nrrFrpzAuve4D6Dzpdh4fGVEOFt2zfLBjSSxnuL80j
         P09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ML5TdHcdMxiU+u3GNvYmF9q/Wcykd3GF57yT+ShoBQ=;
        b=nroVFlu+IEo44QJWlMHT/IXbzxQQlIbteYaJmxIie1TwHhw2FC2s8UlxLakE4prdTH
         x6Vaf5rSZhM4GDnMBtG2b53YfbL81pri5fAMs9EKGS865klm9VmmmFTMFCG761PC7kj2
         Jqf6EQewDyfQ3YVzZERtM0OwRu7uh8rF9MZoJfKOifpfPXQpkugidU6uPmQnOBW34/7A
         5OM1AZ+FWdhF94pONIoOVABzH63iFKQVwMm6Ga5h2PV0NmjU1T2Ts0pKs9zmXWtbA1sp
         NVJDSPVlpjJ+2c7b8Kp93msJWzcGEC+8H09biqhbitJuvMLvQeWWo8MHZEDQZbMHj1ql
         7MMg==
X-Gm-Message-State: APjAAAV2x/aDBcfBrXA4gRAWnAqBuIAmliwnq9JrDKTylRi6h3/SqZHU
        /AWCS60eaYFSYABymZWFbMV1X2dMYj4=
X-Google-Smtp-Source: APXvYqy4laGmYqXEM7cobrf93IQ6FOB66hNbrPcNqoVeHM42cBVcdC31Axc3brsx51ScTDIik709Eg==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr105115045plq.223.1560971160044;
        Wed, 19 Jun 2019 12:06:00 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p27sm32831691pfq.136.2019.06.19.12.05.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 12:05:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:05:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_spmi: Fix math of
 spmi_regulator_set_voltage_time_sel
Message-ID: <20190619190557.GL4814@minitux>
References: <20190619185636.10831-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619185636.10831-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jun 11:56 PDT 2019, Jeffrey Hugo wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

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
