Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B5C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5806B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7F7meZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfFMVcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:32:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:32:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so57519pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymOhlE+xa8t9JEEo9mNLV0I7BKApQL/CgsnjJcqWwnw=;
        b=W7F7meZmql+xmtsD6F8SeYXfmxj4ZMwphRvRIL3/3538NCpxSWiZbIScibSMYMBClF
         9ZGzcXlTIwjfTBg1NNgdVmrxiYNF1mDviKz8tX5gCGLknHfBAAjIjMngemnFdqAyFK0B
         Qe+6JV19LSXJFv4BG/z5tqga5W5pCLU1LddMNWJ4WkSkhuf4Xe2UvdM08TY4hrOCQbyq
         DGM8YDtQnyx2mUWyloVjyrMlita6lJzKoRW7Zeos5GwWM5i5dkC9CopLZE+vRxpGUKY8
         7x28RrnXLWlKu+Re0A+TdMVOpqmFma0pRY4uJUHSDhXgY8SNQUyP8xhoIRWLP5K231yj
         DHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymOhlE+xa8t9JEEo9mNLV0I7BKApQL/CgsnjJcqWwnw=;
        b=Ou1lCf3q4FFwdj6+38Z6i4jy8YunqmaWRxlew5XrqB/IhCA8uXESXVYOZuvjxwHQ4M
         m9ZXPwP3ohGf5jspkFWemE2KVXohJF0ZqogfC66gqXAheswhXAjuE2kYqxCYBG51o5kf
         a1uIeh0Vg0TXC8ulO02IrymKTSZEIjt20a98KCwTEoSP4Mizj7KJ6ZPJeMegkMQZbCJ1
         704PbudFXMVSt/SFx+5vZUfSjKvFERDlaL1/49hMUBALvUslycCfwGbmIfi/R2VmTHpL
         zAz/moNY57FSfBfW979q+S98LKP+rhPao35e/jexh/J3r9WQ0RsiZPjudFsFfZ/UyAGe
         oSqw==
X-Gm-Message-State: APjAAAX6OayG05J+MNGxGuOY3aRsYOPQDC5Ecii1cD3NJklVAv14yOvu
        l50NlHMOMF2inri5gIgC/aQTKw==
X-Google-Smtp-Source: APXvYqzGurJ91Zfd3l/UxqC3ptIHpGeO+A3L5IahoXBkAOKagO0xBVne2G0CxYJHJVoRCx57eCns/A==
X-Received: by 2002:a63:5207:: with SMTP id g7mr31497760pgb.356.1560461522867;
        Thu, 13 Jun 2019 14:32:02 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 23sm574395pfn.176.2019.06.13.14.32.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 14:32:02 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:32:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] regulator: qcom_spmi: Refactor get_mode/set_mode
Message-ID: <20190613213200.GC4814@minitux>
References: <20190613212436.6940-1-jeffrey.l.hugo@gmail.com>
 <20190613212531.10452-1-jeffrey.l.hugo@gmail.com>
 <20190613212531.10452-2-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613212531.10452-2-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Jun 14:25 PDT 2019, Jeffrey Hugo wrote:

> spmi_regulator_common_get_mode and spmi_regulator_common_set_mode use
> multi-level ifs which mirror a switch statement.  Refactor to use a switch
> statement to make the code flow more clear.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 26 +++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index 42c429d50743..1b3383a24c9d 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -911,13 +911,16 @@ static unsigned int spmi_regulator_common_get_mode(struct regulator_dev *rdev)
>  
>  	spmi_vreg_read(vreg, SPMI_COMMON_REG_MODE, &reg, 1);
>  
> -	if (reg & SPMI_COMMON_MODE_HPM_MASK)
> -		return REGULATOR_MODE_NORMAL;
> +	reg &= SPMI_COMMON_MODE_HPM_MASK | SPMI_COMMON_MODE_AUTO_MASK;
>  
> -	if (reg & SPMI_COMMON_MODE_AUTO_MASK)
> +	switch (reg) {
> +	case SPMI_COMMON_MODE_HPM_MASK:
> +		return REGULATOR_MODE_NORMAL;
> +	case SPMI_COMMON_MODE_AUTO_MASK:
>  		return REGULATOR_MODE_FAST;
> -
> -	return REGULATOR_MODE_IDLE;
> +	default:
> +		return REGULATOR_MODE_IDLE;
> +	}
>  }
>  
>  static int
> @@ -925,12 +928,19 @@ spmi_regulator_common_set_mode(struct regulator_dev *rdev, unsigned int mode)
>  {
>  	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
>  	u8 mask = SPMI_COMMON_MODE_HPM_MASK | SPMI_COMMON_MODE_AUTO_MASK;
> -	u8 val = 0;
> +	u8 val;
>  
> -	if (mode == REGULATOR_MODE_NORMAL)
> +	switch (mode) {
> +	case REGULATOR_MODE_NORMAL:
>  		val = SPMI_COMMON_MODE_HPM_MASK;
> -	else if (mode == REGULATOR_MODE_FAST)
> +		break;
> +	case REGULATOR_MODE_FAST:
>  		val = SPMI_COMMON_MODE_AUTO_MASK;
> +		break;
> +	default:
> +		val = 0;
> +		break;
> +	}
>  
>  	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
>  }
> -- 
> 2.17.1
> 
