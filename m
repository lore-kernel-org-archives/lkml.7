Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A669CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A0420684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPLfFB5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbfJVIYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:24:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfJVIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:24:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so10175566pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CFxsIRuWp0vZOhj5hNfLUpeIE+LAy3dw4lXkf3DFfzY=;
        b=dPLfFB5HlI1vxlm6xwyWMAkwYK1XgdGYUOsJABhScpDE68bXbwNVmd3f5NAfyNHfjp
         dLRcCje0HninXq48K2NRwHW9wI6byotZRh0rjqKzTUDIrXHu042N9LIon4kRGTOgAheq
         QF5DkB+WnNPD0hrMZnBHsMVVSBMrse5N2veykCoaT0JtGFaylXi5ftca8464RZ+XOdYS
         j20qPsv5rDTHJ/IFNAhrjz33IK0KxyOJoQV3SQ6jvYx4psr5kr9Qj5tCHlBSwsDj1/Gq
         uS01RuVEx3owJRqM5VwgO2u7NQDj+HJq8cyx4emNGip8Ub04zLl1iJbMEh7Td42LnATW
         VqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFxsIRuWp0vZOhj5hNfLUpeIE+LAy3dw4lXkf3DFfzY=;
        b=br6bC2BxDuhF6dptxeyFTbewUFW5HBcjlXODZw1oqJ0jSdEIYzMgXV+ONoTmuFDtGK
         T3RZtHZfh18CY4Qvzz/XpmikbOxsklyTFPCinh2CylsBNiiS692Wgd1m/S9QaAO9Wokz
         T7ptIvRFuQ52r+JggjJrI0CYn91NHJ2P4X1yVoxjscA9SiBwjuGNZ9Qua6KGXVnsEM+s
         CipubhBQCQfdT/48VTluqP6eugH+niKs45E0KinG9JBXLQjSwaE6aD+TEYKOBqkt8ybH
         5p8jS8IeAsoe3CHLDiKNYVdSO0tUXCkhsjIlAUvq0Y063je4eKwsIGxdjEHgKKZIpeN0
         HOWQ==
X-Gm-Message-State: APjAAAVpPE4LWqv+X3GJpwZMN92vU4B/R4poClW4Xy1Po0rOIItvtCQH
        z1lMGh7N50uaKOdL/3K6DNBP0g==
X-Google-Smtp-Source: APXvYqwh0aapj+IGEAdyDy5qrmKxfmWmhi4mI6YhmF2/pKB2NYd5J2n5ygBLARHWTjZ56Zt5fUPgJg==
X-Received: by 2002:a62:61c7:: with SMTP id v190mr1966243pfb.47.1571732644743;
        Tue, 22 Oct 2019 01:24:04 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y138sm18875546pfb.174.2019.10.22.01.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 01:24:03 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:54:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rafael.j.wysocki@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed
 grade value
Message-ID: <20191022082400.7dsoo57mt7wfpqs7@vireshk-i7>
References: <1571719179-23316-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571719179-23316-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 12:39, Anson Huang wrote:
> i.MX8MN has different speed grade definition compared to
> i.MX8MQ/i.MX8MM, when fuses are NOT written, the default
> speed_grade should be set to minimum available OPP defined
> in DT which is 1.2GHz, the corresponding speed_grade value
> should be 0xb.
> 
> Fixes: 5b8010ba70d5 ("cpufreq: imx-cpufreq-dt: Add i.MX8MN support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index 35db14c..26531f0 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -44,19 +44,19 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
>  	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
>  
>  	/*
> -	 * Early samples without fuses written report "0 0" which means
> -	 * consumer segment and minimum speed grading.
> -	 *
> -	 * According to datasheet minimum speed grading is not supported for
> -	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
> +	 * Early samples without fuses written report "0 0" which may NOT
> +	 * match any OPP defined in DT. So clamp to minimum OPP defined in
> +	 * DT to avoid warning for "no OPPs".
>  	 *
>  	 * Applies to i.MX8M series SoCs.
>  	 */
> -	if (mkt_segment == 0 && speed_grade == 0 && (
> -			of_machine_is_compatible("fsl,imx8mm") ||
> -			of_machine_is_compatible("fsl,imx8mn") ||
> -			of_machine_is_compatible("fsl,imx8mq")))
> -		speed_grade = 1;
> +	if (mkt_segment == 0 && speed_grade == 0) {
> +		if (of_machine_is_compatible("fsl,imx8mm") ||
> +			of_machine_is_compatible("fsl,imx8mq"))

of_machine_is_compatible should come right below the above
of_machine_is_compatible here, instead of a leading tab.

> +			speed_grade = 1;
> +		if (of_machine_is_compatible("fsl,imx8mn"))
> +			speed_grade = 0xb;
> +	}
>  
>  	supported_hw[0] = BIT(speed_grade);
>  	supported_hw[1] = BIT(mkt_segment);
> -- 
> 2.7.4

-- 
viresh
