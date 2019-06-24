Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B51DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2D42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezovdk0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfFXGGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:06:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36886 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFXGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:06:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so6251492plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rczLXy/YdSTRCqTeKDK2d2KcKBJ58Sk09VwtTR7c1D0=;
        b=ezovdk0fIqsbaH3BRH7IYNVk7pFaH+wp0P2j0nRBwNRuPMyUFoMbdVd+2jMTEDGVgo
         IZmW3IP4AXneC1YBX1129nHybakYDLNci6SALVR1OSMpqGN2hwHNlxo7C6EMmumZUC8P
         A50eUtMpOWgSRW6Kl0cjA31otm4ZsTHmV9fmDwu0B6gG8im13AwoVCybx5x4B08QQT4w
         79fTu8xIps8bOQdDhp1oBfMCnZ+siksJOS/Vh1zp6ndB1fyTJs6jJ8pJgMCrOhlY12p+
         DewbSP8RVVniYsQbxpu7TmpktfyQ1xPdQqJXtvBvoGaUMNbOLevIN5d9skSvnuqlKKxp
         lR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rczLXy/YdSTRCqTeKDK2d2KcKBJ58Sk09VwtTR7c1D0=;
        b=MUye3ecvHJQvHU7Q7Xz0aoKbPMa0YV/OqemOTBHbbiS7shzIL8dM9GJ6ChJXQjfOcN
         q6J1zwdhQeNtdoVRc57kOgILuqzGbXhLWQBww9QHjsebUEzPSHB1YizKqPdCgjAeY0W5
         fwKMeGZtnZgKqN+GFQpN18wcAeTUdH6q+NXSa1ZYNq6Mazbyl6bYKfxKStklUGJxjkGI
         c/ZiYpmGPAREfhM7YTO3t/2WIVSkgFyHQ6RqFNfaZpzp/THi+9PYFIHv3yJ2VLqcNIOF
         aLTUPP5mmKQSDWiwpwUV2IdBy3T6hNq8bsVo3ndz/9TgQo1dIbFH6RK816Hy8fzhoUks
         TG6g==
X-Gm-Message-State: APjAAAUbf0BS/Q5mSbliecOKo3ev35N+J/LMd3UVq/O5bgtzSgBVjioD
        ZmBOODVp6j5tq8vuIePwO+zHWg==
X-Google-Smtp-Source: APXvYqyE4KypheWDTMolsvMJk+gKBAPl1QkcrSeuna1NO+V0ysfH9LpuW1Ya22r7aLQvQAUZoZJ/BQ==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr110669295pld.16.1561356366447;
        Sun, 23 Jun 2019 23:06:06 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id w4sm10278398pfw.97.2019.06.23.23.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 23:06:05 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:36:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] thermal/drivers/imx: Remove cooling device usage
Message-ID: <20190624060604.v3docq36c4rmscja@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-5-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-19, 15:23, Daniel Lezcano wrote:
> The cpufreq_cooling_unregister() function uses now the policy to
> unregister itself. The only purpose of the cooling device pointer is
> to unregister the cpu cooling device.
> 
> As there is no more need of this pointer, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/imx_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 6746f1b73eb7..021c0948b740 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -203,7 +203,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
>  struct imx_thermal_data {
>  	struct cpufreq_policy *policy;
>  	struct thermal_zone_device *tz;
> -	struct thermal_cooling_device *cdev;
>  	enum thermal_device_mode mode;
>  	struct regmap *tempmon;
>  	u32 c1, c2; /* See formula in imx_init_calib() */
> @@ -656,6 +655,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  {
>  	struct device_node *np;
> +	struct thermal_cooling_device *cdev;
>  	int ret;
>  
>  	data->policy = cpufreq_cpu_get(0);
> @@ -667,9 +667,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  	np = of_get_cpu_node(data->policy->cpu, NULL);
>  
>  	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
> -		data->cdev = cpufreq_cooling_register(data->policy);
> -		if (IS_ERR(data->cdev)) {
> -			ret = PTR_ERR(data->cdev);
> +		cdev = cpufreq_cooling_register(data->policy);
> +		if (IS_ERR(cdev)) {
> +			ret = PTR_ERR(cdev);
>  			cpufreq_cpu_put(data->policy);
>  			return ret;
>  		}

This too..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
