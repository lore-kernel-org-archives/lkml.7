Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D17C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B68F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JG5j09Ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405059AbfHIDbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:31:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35920 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403873AbfHIDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:31:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so45125666pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8mOaONbQIagSdJ4scl2hu9XLlJCapqfCQXNLNTlJDAM=;
        b=JG5j09Ckfh88SlbgQq2fowNEBhoJu3CqiqU13VdP0+EHZrUK57Hwcpp7ncz474b2Qa
         3X2+xEEb47PsdWA+I15QkU1fyOZypORAZ85xcdXnD+6IrB9d9PprLkNkkTBUWJCr8EHb
         dj9FqWUI5C5eouktQwq24BYenAgkORnaw82YHU/gbflTRwRne+l4KWGBflTFhnEOuicO
         UYG/ToflKEoDj6WStjmu8fBgFNauOTbQnoQRrMpF/gaV4GydcD5q+ZGM9nMTmwyyvhQn
         UuZIC7V/kqUNEzcgfjODcMk6/ttR9EnVchZhr0RHk88eSn/V8eyNKhApDafcUWmfXfYw
         id3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mOaONbQIagSdJ4scl2hu9XLlJCapqfCQXNLNTlJDAM=;
        b=ESILwufSH5DxnN0oznkzDb/qJbxkM5ILKCwXPwJjA/FrIDGpLNeEvgPEtnTG/+8OpL
         5njLEx+F3M3VPtojp+JtiaFH8lLBfBV+jcKRBkz2+/Y7+B/bjwRsLPGNg/wRb+E5zK67
         tbZLCsAXh+MpCcrO4KlvHA/l6Q9vXmC3uVmQ7YHUzAN5mI5IwkZHP6qCcHPupYtiCyZO
         NoR7IPL/IiN3YypOEG3YwDV9oLTT6mmXGSAL4908BXJ6/eiJVkaiTkUq3nu6YvaY+smY
         DAjD4N1XUg7iW3KmW2Q4EjjBFmG1flgXs82xWIINDcyBkJqg/660zugrG4yfU4HsffLN
         mFQg==
X-Gm-Message-State: APjAAAVOAJtaeICFRGqAsQuTBkmnp8qZsdrtJUSPMpnd62JUqv/vq8SE
        7sjOutYIQSSQVJ+bvXXT/TzaJg==
X-Google-Smtp-Source: APXvYqwPQLcbYoC7IQrEKTJfa5wSrqNMVp1E/hA5pk7ynvnkI3COuoNbD8Qonx0+mtzPR+dhnm9ruQ==
X-Received: by 2002:a17:90a:710c:: with SMTP id h12mr7181024pjk.36.1565321482989;
        Thu, 08 Aug 2019 20:31:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b6sm83794448pgq.26.2019.08.08.20.31.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:31:22 -0700 (PDT)
Date:   Thu, 8 Aug 2019 20:32:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: qcom-rpmh: Add support for SM8150
Message-ID: <20190809033255.GL26807@tuxbook-pro>
References: <20190808093343.5600-1-vkoul@kernel.org>
 <20190808093343.5600-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808093343.5600-2-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Aug 02:33 PDT 2019, Vinod Koul wrote:
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
[..]
> +static const struct rpmh_vreg_hw_data pmic5_bob = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_bypass_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 135, 32000),
> +	.n_voltages = 135,

There are 136 voltages in [0,135]

> +	.pmic_mode_map = pmic_mode_map_pmic4_bob,
> +	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
> +};
> +
[..]
> @@ -755,6 +890,18 @@ static const struct of_device_id rpmh_regulator_match_table[] = {
>  		.compatible = "qcom,pm8005-rpmh-regulators",
>  		.data = pm8005_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pm8150-rpmh-regulators",
> +		.data = pm8150_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pm8150l-rpmh-regulators",
> +		.data = pm8150l_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pm8009-rpmh-regulators",
> +		.data = pm8009_vreg_data,
> +	},

Sort order...

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);

Apart from these nits this looks good.

Regards,
Bjorn
