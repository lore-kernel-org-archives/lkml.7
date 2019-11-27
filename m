Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EEAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3390C2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFiRlUNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0MHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:07:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42085 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfK0MHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:07:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id i5so2446113pgj.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2kUt+3Utv0U/lxz9Sn3u3UBpoDUITVmuY7QcGVxNzk=;
        b=TFiRlUNuKgtzuenkN7FjwVpZDCmhS3ME+j1NHP+zQLLgsZSTQI7Y+H1jzhCjaVATdj
         ACslhGynFMAoB0PCZYTJkn7wDFXmf5JpoF/NX+saZwsMAVpESmzLGkqTGoZICjaj8QZF
         NsOeLxvY2SQLU8jihNN9ZutsKem3btGs/pUtlzYfAqE/AF1wEMv8eZO5WJyKBbs4GXX4
         oSEjaSptzKuqD0eXtcwvwJaIBgTci4YNIAzELApikP9ajvAMkzEVjbf9oYpNdcQzXqpG
         Ckv6oNSCP9c9oWzIjO6pNDQ8lQCYfbfYWFB1zov5oH1o84nj+MCCBuTSgvxFOuuTOAUB
         jp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2kUt+3Utv0U/lxz9Sn3u3UBpoDUITVmuY7QcGVxNzk=;
        b=I0IufzhvwGrq6gRnL/AwLNBAtoXXUWtv5/387sBygWuDsJmIO6LTVZkEdibhXeaeBO
         Hh/L2iGoxMMqMqrB0uqgtNsAtmj8RR/pOYapf7KWDWutGvxEbfR2dgqeYzt9uWCOizSY
         FBKAL6fWGWLbPUQC1ynr1lAPxiRlJjFl9/EFyLywCoZMpO4d6lNtZAH6G9yNmUneFXQF
         4r7IITBqG4TtrR+vDRj8ubZfw8W1fsQerShP4pBj1t+STJ06lOulIBiAG+6zkVaaSNQ9
         m9Xl0ZKjM7d3JPtiX9uyIpNY5UTz+1rE5Vl31VwFYkoPKORrbD5ocvzSPOA47ZS55Xlp
         nJDA==
X-Gm-Message-State: APjAAAUMXAbGAIJ5RgkApJPA79gQPCK01c66BP2GlbClGDvEMTdh4+wZ
        K7sEUEDFoQFYiPqWuAbhB2GK/A==
X-Google-Smtp-Source: APXvYqzFJ3B2yRMuuWQYTrYHx8R6FxyuQQYlBZvpMqZgQZbJIZXWuMoIq2kRJTwIF2oUjuAhccJ11Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr4604261pgl.224.1574856467322;
        Wed, 27 Nov 2019 04:07:47 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s7sm1273794pfe.22.2019.11.27.04.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 04:07:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:37:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127120744.iivgw25nixovfj7i@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127114801.23837-1-dietmar.eggemann@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-19, 12:48, Dietmar Eggemann wrote:
> Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> functions.") the core cpumask has to be modified during cpu hotplug
> operations.
> 
> ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> driver.
> 
> During CPU hp stress operations on multiple CPUs, policy->related_cpus
> can be altered. This is wrong since this cpumask should contain the
> online and offline CPUs.
> 
> The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> cpufreq_online() triggers in this case.
> 
> The core cpumask can't be used to set the policy->cpus in
> ve_spc_cpufreq_init() anymore in case it is called via
> cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
> 
> An empty online() callback can be used to avoid that the init()
> driver function is called during CPU hotplug in so that
> policy->related_cpus will not be changed.
> 
> Implementing an online() also requires an offline() callback.
> 
> Tested on TC2 with CPU hp stress test (CPU hp from multiple CPUs at
> the same time).
> 
> [1]
> https://lore.kernel.org/r/20191127103353.12417-1-dietmar.eggemann@arm.com
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Wanna provide any fixes tag ?

> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This is 5.5 material or 5.6 ?

-- 
viresh
