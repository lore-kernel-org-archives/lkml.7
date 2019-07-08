Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232FDC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED74920665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcOUQmSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfGHDvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:51:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46212 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfGHDvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:51:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so2236171pfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1pK4KTnhC89gqGYh7RqYsGWCRyTdp8pAHVuXCVYQM0=;
        b=rcOUQmSGNhVpug3mIyjRLWjXiIaNo6rSisJB7mCEu56J3i3r5wszqroltHwaefo8vt
         FJDolSTb9COCAUPHEGmXp44a6WgYMNaoFB4kjRxvZjojSvG8SQMDG6OYic4T1MQE6uA2
         7Vrndp5vb1fxgXpz4LpAvyqwp0UnYxe4Ggcp7XsuGSF4TAzn/Biuj8atuRDXEXY5mUtJ
         KEZfwdEobRo9Gd/bIam2/We+/7UualkhGP2pQR2FafF5FOQ8LRRCWVZOW096GA+lW5Fm
         LZcUyPzr5ka9SttykNopIJMhRkEI2r8N8aBTz7NxcdIA/4wmiwDRB5HqwB831axXIcfV
         WuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1pK4KTnhC89gqGYh7RqYsGWCRyTdp8pAHVuXCVYQM0=;
        b=CGMfdEjhMNq7jsCVx/DSyEov4roqlqNu4txNApVoi9QuURtO8BHOSI9utsJ9gE/wQc
         V4IQNwk0tJXkd5vNgWifTK9LRlHzcLJd1lareKYcmuBnYsF9lWQ9uSdUHJXW/r3DIszC
         LNR/Q3HAZSBp290TOUN1X7uXTCNLNJ6rgdYoWahvVxhjQlW+x3/aT0GHO05E6Z1WJCGY
         xjeQz6a2zvh8Jaf+LOcntxzxEb+jigbB3U55pIADwg7yLiTeUEG/UGYtZMOWoVJcDAut
         V3DdrXkp6W5uIXInl8ITUWkTemqTSAUka55PiaRpctvFprxmumls7WYFEw5eVH4nMVzd
         wF4w==
X-Gm-Message-State: APjAAAUkj9QqDPulzqx0c7qTuXJNUEjLurM5QEqubKp+vXnyg7svJxYp
        F9b5lv/6V5p2vzxYsEoh4yw8vg==
X-Google-Smtp-Source: APXvYqwChaIoPvXaa69JPPf8K46yTRYkCg4Tm7IDyulcIk9nICKW8Ynmx8kiGVyy7hwFcgTvMhQjWg==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr19550031pgc.14.1562557861027;
        Sun, 07 Jul 2019 20:51:01 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id b1sm16054904pfi.91.2019.07.07.20.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 20:51:00 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:20:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Add i.MX8MN support
Message-ID: <20190708035057.h2lgadm56tgdqsor@vireshk-i7>
References: <20190708030308.1815-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708030308.1815-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 11:03, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MN is a new SoC of i.MX8M series, it also uses speed
> grading and market segment fuses for OPP definitions, add
> support for this SoC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index b54fd26..4f85f31 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -44,10 +44,11 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
>  	 * According to datasheet minimum speed grading is not supported for
>  	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
>  	 *
> -	 * Applies to 8mq and 8mm.
> +	 * Applies to i.MX8M series SoCs.
>  	 */
>  	if (mkt_segment == 0 && speed_grade == 0 && (
>  			of_machine_is_compatible("fsl,imx8mm") ||
> +			of_machine_is_compatible("fsl,imx8mn") ||
>  			of_machine_is_compatible("fsl,imx8mq")))
>  		speed_grade = 1;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: Can you pick this one directly, no point sending another pull request
for just one patch. Thanks.

-- 
viresh
