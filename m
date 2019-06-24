Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6222054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCyHBpwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfFXJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:39:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46818 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFXJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:39:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so6551166pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xq4Hf3p8ZFDHvrAu4X/XVuAS4nlGCqTsPVT41F3h+A=;
        b=VCyHBpwOAxYJLGT3NUX1EldqHeUq4P8q3nWC/ggkGk83WZP0Bdz4M70ji4gMknvKuG
         lSXTS4CenwFe2vme1ep79JzwnKdJxMFE9YMXFU1dsSEdjuokcf1MVi5syKRTLeYr5raR
         j95F+KOseTPvwsmEqD1WwduScRG6Zd/zZEYJvCuMxMdFIUACQoPdR9pTO8xyDTGhe2kI
         cLnIvMl/lhW3iVY+8+SL6wlvssIsO14aONeLkxL7WB9fzf3HyEH0qTmE6WNqEvbGy+d5
         aShUU5ZwdHp3f/7NXDZPw07J6OciSPGUsjNgrboTyZdeaMq40mHR41rQiyH/7fWHRG+U
         qGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xq4Hf3p8ZFDHvrAu4X/XVuAS4nlGCqTsPVT41F3h+A=;
        b=E+RM+tp2JpruHpdhHmGFwkUdOOUi+YF0sdYrDIbIpxDntA3TYtCR+SiQx+7i8ATLT6
         WdjpqfIMN15fs08vWDtwlgvkfZPGM3Dide70kxid6j0OE3J3etB4v4HjbfblnRhtczsz
         2sxA0QejVsdIrOh3yBH+kW33LHw6HeCDnnugAH/4j5JuVOR406n5zrfW+gi1svRHXOTE
         yH5U9+Fy92pkufoP2YhT0BMOpza8QDTvJfRjOieMMWyvTO4UTH1KY3PNKOdo4SZp1ts5
         AtrI8kQ7qTOLJpFnVx3JryFHgEQa8vbZ4p9RQWRSMsmJng8PYmORX2/IqIZD32HCEQW4
         9Bzg==
X-Gm-Message-State: APjAAAUOFzcg5qc0eZzJKAJFPNUKgyblBpeT8idqQ/jMxHyckSKFZCHs
        DxMtoGgpFM9ri0gq+bgqqmQY/Q==
X-Google-Smtp-Source: APXvYqx0+2hKXME82DJG31VBC8K3kY/7y2gRKipDpmCiTehdcrm7FLF0wonH5OMqNa4QeSarJjGr7w==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr111526412pld.16.1561369179880;
        Mon, 24 Jun 2019 02:39:39 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id 12sm10459621pfi.60.2019.06.24.02.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:39:39 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:09:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Message-ID: <20190624093937.hmfzfm2s46hfhvhm@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
 <20190624060334.kak2mjuou4napi4x@vireshk-i7>
 <3f324189-aa1e-ae78-1d69-61e00c5d033a@linaro.org>
 <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
 <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 09:45, Daniel Lezcano wrote:
> Actually I'm asking your opinion :)
> 
> The structure in drivers/thermal/imx_thermal.c
> 
> struct imx_thermal_data {
>         struct cpufreq_policy *policy; <<<< in the thermal data ?!
> 	[ ... ]
> };
> 
> And then:
> 
> #ifdef CONFIG_CPU_FREQ
> /*
>  * Create cooling device in case no #cooling-cells property is available in
>  * CPU node
>  */
> static int imx_thermal_register_legacy_cooling(struct imx_thermal_data
> *data)
> {
>         struct device_node *np;
>         int ret;
> 
>         data->policy = cpufreq_cpu_get(0);
>         if (!data->policy) {
>                 pr_debug("%s: CPUFreq policy not found\n", __func__);
>                 return -EPROBE_DEFER;
>         }
> 
>         np = of_get_cpu_node(data->policy->cpu, NULL);
> 
>         if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
>                 data->cdev = cpufreq_cooling_register(data->policy);
>                 if (IS_ERR(data->cdev)) {
>                         ret = PTR_ERR(data->cdev);
>                         cpufreq_cpu_put(data->policy);
>                         return ret;
>                 }
>         }
> 
>         return 0;
> }
> 
> [ ... ]
> 
> Shouldn't this be move in the drivers/cpufreq/<whatever driver> ?

Sure, we have platform specific drivers where this can be moved :)

-- 
viresh
