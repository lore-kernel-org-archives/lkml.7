Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88D1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAEF2158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbV2WhvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfK1CbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:31:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfK1CbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:31:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id e6so12083903pgi.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3MhAgNwJCDzFmg83BGAd8t/eEyIf/GsxgnTUb2ToXs=;
        b=AbV2WhvURSc4H37cMnU1McRpKMN3PNtGgOrYok6XE+t9/06vmiOzXjxO8o2/A4nNp4
         Th474P4Odokl5RWixStRMW5aLqjuL+perV6RJMm+oYT0og/XFeKaql61vRSRiMJ2pq32
         0omD61mSXnitttdyY+8RdTvxmea7rn86qHhC8uuVGiCvCxLNuvzRjfd/GUuY0RIQYSP2
         cmdskrvBVEhe3S9Q8lDcJdRWRIlI7bSrEFH1y1U4Rk/tYvNaQaqZi/+FF5T+ytaNx+SZ
         qeKAzvV5MkymttKH0wbACMhRa1dZMoMvjL94xGienEDXbooxuQVYAxmfQ3NFUZlSxovl
         0VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3MhAgNwJCDzFmg83BGAd8t/eEyIf/GsxgnTUb2ToXs=;
        b=S7kwrNtwoaJx5kjWFxBfnGfldERq59X+ar2AgCXqJKCLITAaHm/SbCpyQRUlBl/09C
         nJTvP+88xVKpcuXIwm94bM0HY+UC0YV5A1yfRr+2M79fE/+1dxnexOZtQd97MOfE37Dt
         UYHtZL5aQAsXmv+dZP43Ruxa6sslOOAP6398HgDFm1WaL3FPB+Z3ZVYrqHyThGpoN2nD
         3+ZAJKHrBlxq++RFRypkN98WlPwmkQiPXCDRZJZhWIK4Em14gtyKCzfcFIb/0QS7YsXC
         KW8ZOOtni4xbgL420OiHu+E44DC/GrqW+7RJq3ntjv8B7qGocxfblAtMMju1PerubTCe
         RJvg==
X-Gm-Message-State: APjAAAU0LTdMMgEmNLUtfMoRq59JUqkExH9WKIEgZeqZDIBKMs8hgmVx
        EOQ84lTv6MFPo/CR7XEvEql1zl5HYOk=
X-Google-Smtp-Source: APXvYqx4TG+a8InkKBmHDvzMujmJEOUlgarnckvNwhCekHG+3RWiohoP5Zo9pN47GWMMV9wizulVyg==
X-Received: by 2002:a62:cf46:: with SMTP id b67mr30054210pfg.77.1574908280836;
        Wed, 27 Nov 2019 18:31:20 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id q15sm1312656pgi.55.2019.11.27.18.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 18:31:20 -0800 (PST)
Date:   Thu, 28 Nov 2019 08:01:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191128023116.3skwbeowk7wtjaxc@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus>
 <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
 <20191127133200.GE29301@bogus>
 <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
 <20191127154029.GA4826@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127154029.GA4826@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-19, 15:40, Sudeep Holla wrote:
> diff --git i/arch/arm/mach-vexpress/spc.c w/arch/arm/mach-vexpress/spc.c
> index 354e0e7025ae..e0e2e789a0b7 100644
> --- i/arch/arm/mach-vexpress/spc.c
> +++ w/arch/arm/mach-vexpress/spc.c
> @@ -551,8 +551,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
> 
>  static int __init ve_spc_clk_init(void)
>  {
> -       int cpu;
> +       int cpu, cluster;
>         struct clk *clk;
> +       bool init_opp_table[MAX_CLUSTERS] = { false };
> 
>         if (!info)
>                 return 0; /* Continue only if SPC is initialised */
> @@ -578,8 +579,17 @@ static int __init ve_spc_clk_init(void)
>                         continue;
>                 }
> 
> +               cluster = topology_physical_package_id(cpu_dev->id);
> +               if (init_opp_table[cluster])
> +                       continue;
> +
>                 if (ve_init_opp_table(cpu_dev))
>                         pr_warn("failed to initialise cpu%d opp table\n", cpu);
> +               else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
> +                        topology_core_cpumask(cpu_dev->id)))
> +                       pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
> +
> +               init_opp_table[cluster] = true;
>         }
> 
>         platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
> diff --git i/drivers/cpufreq/vexpress-spc-cpufreq.c w/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 506e3f2bf53a..83c85d3d67e3 100644
> --- i/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ w/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -434,7 +434,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>         if (cur_cluster < MAX_CLUSTERS) {
>                 int cpu;
> 
> -               cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
> +               dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);
> 
>                 for_each_cpu(cpu, policy->cpus)
>                         per_cpu(physical_cluster, cpu) = cur_cluster;

This is a better *work-around* I would say, as we can't break it the
way I explained earlier :)

-- 
viresh
