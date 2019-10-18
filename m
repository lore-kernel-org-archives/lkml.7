Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BB0222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/FFYf/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633072AbfJRJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:51:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46082 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbfJRJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:51:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so3056434pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B1DJCyKm+S5XN5LjovT0twn7TgHW8lL5z4RVqMp1tlM=;
        b=V/FFYf/OuXCokyuYNICYTsOvDfHT2yoEM0xGfhHD0pEItrFk646z79oIUBDZPOYTBf
         FYFIA4K2n4IkuiyRgvs8Kui0DycUEheMtqBVWIiWlBZrHByWyG2UXLJPiJi+Ayh+6lO1
         YGgpnYDX21HkyArYX8kEhSlQqrotkzPmxk8jaLmd4ts2Wiepepys9WI+wNNnSvlilEAR
         QfkMNGklic/SUXOnvSmRPYpNpg4f1wVdIX87t22MfotD4805dB5R+QQ4PrRMB6gxULiC
         NMFMhmB5X1M1rzOoumdzXMuTjCdq18bYFHsORPSOt3Qgvfj7z+8H+4wULIo3HFoo0Wcl
         KjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B1DJCyKm+S5XN5LjovT0twn7TgHW8lL5z4RVqMp1tlM=;
        b=IMvtBWly3da7SpHNNqejtWVZCeYB34Ql2X77AUIobNl6vZnPumt33iW2gHkG6DeMh2
         xEnYKPw/h7KOCyPPvdzA4ukxuIltcndG3M14mnjHiMHNjJiGvLRAL4fKTAsMraKMo/NE
         nYLpywaGmbgt40W1M1FYShak91WxgdV185KCE7BLuZMNLgF96inyMRQCvL0tHUaN8ph/
         GC+/JXqx/h46rxqdHDGLwvwSgXG4xBnaUTBlg5QcvxRq+PjY3ArF2qxlzww2ONptjOQx
         JkbqLvWhJqOj+6IHydz6mhGd3xxGKTiS94V4/gwYTtGCSsAe3Nzb6wQMd+Om62Rj7Pd7
         h+/Q==
X-Gm-Message-State: APjAAAVf/04/XdIsP2qN+tYqmCMzOEsoTXPHmxUMtBW8xhQ2jwUkgm8H
        eSB/bbHh5uLiPICYalbZPJPlEw==
X-Google-Smtp-Source: APXvYqyNFkRvnZmGknv26Wp3KPaMZo7qL0J/v5oMpgC4CJHep/qjBswXaNrsjN566/STEj+4OQukbA==
X-Received: by 2002:a62:cf45:: with SMTP id b66mr5530793pfg.150.1571392308876;
        Fri, 18 Oct 2019 02:51:48 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id a13sm6722689pfg.10.2019.10.18.02.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:51:48 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:21:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/6] cpufreq: qcom-hw: Move driver initialisation
 earlier
Message-ID: <20191018095145.tdlozkz7qlb5z4r3@vireshk-i7>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 14:22, Amit Kucheria wrote:
> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a9ae2f84a4efc..fc92a8842e252 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -334,7 +334,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -device_initcall(qcom_cpufreq_hw_init);
> +postcore_initcall(qcom_cpufreq_hw_init);
>  
>  static void __exit qcom_cpufreq_hw_exit(void)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
