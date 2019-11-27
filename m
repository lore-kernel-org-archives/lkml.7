Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D83C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287822084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJV43Ktf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK0MOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:14:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfK0MOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:14:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so10916160pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BbLhqWTTG2Etn1jUokhvCpbFC9M+0mSaR7SHkjHB38=;
        b=MJV43KtfU5dh6w6aXoZKp8+WYygfis1sjvm07Kl9Wd2wNneinEn9vQZrPavzQrE2CW
         An4nyqIzxlGj2Uo04rQvD5QQ8E2bKZvL3K7REcobBBGj+ZIeP45pAwN51u05YbYjMYpI
         k0cJPlotmo9gi6yJxu6kZX7dwVfqaZoZ0xos/iPV1VMqs84HRBSw0mfakGzaZU7YJjT7
         /enzk9H6qXC02B3XolxZ9hyB0j/3AKfz03WOdPpltou7SEkO3bdeCatGXYnCp3Nml1f+
         Px8qwJrGFvmCqWMZvTF+k1Vcxj8wZf+r6TJgOp3FB3DagUvJWrOycjBoRDKl7DkFqDGF
         PtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BbLhqWTTG2Etn1jUokhvCpbFC9M+0mSaR7SHkjHB38=;
        b=kPxSk9fBFpXXUxgklfrpo+rjT8crrF6dARr7uAA0TmkF4ljActR2XurGEtNey6+dTk
         7YNe8BWQvPnoLJtfzIV8M4DFddU2Fx5jXlocpnxZjxNrx5226SxqDWSHVnSldOdvFsit
         xHP2LG50Tit9YgeEgATScK4tYhQQVFCVS0PrsEluY7QwM2rdpOQA2Jr8LsH91nY0mjDX
         a80TXueh06uPw1Stitf8cLGgqMVdwWH5I3npC9bgrPbgZ60TCqF8BvS3kYiL6as8blW7
         YZOnW7gwt2NtESANKyg4O3/PNBFxxgxXw/upEVfBVI7IzO7geCYiVmNoe23culx02dJa
         p61A==
X-Gm-Message-State: APjAAAXTEqL+ZUou2y9BgQJMnEleT4eF3WHB/OQK0GMQBVuIV4+1Cz+H
        eVsAAqYcN9jsVGpl3Hu7uTrGWg==
X-Google-Smtp-Source: APXvYqwzOguWLwbfuOMSUTEFzH0IEWbfLeEU8s4GwdBdvUFeC/cQe/AC6XVbhE9JsWqq2Fvg6hcDAw==
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr46113496pfq.94.1574856844848;
        Wed, 27 Nov 2019 04:14:04 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id z10sm16126812pgg.39.2019.11.27.04.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 04:14:04 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:44:02 +0530
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
Message-ID: <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127120816.GC29301@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-19, 12:08, Sudeep Holla wrote:
> On Wed, Nov 27, 2019 at 12:48:01PM +0100, Dietmar Eggemann wrote:
> > Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> > functions.") the core cpumask has to be modified during cpu hotplug
> > operations.
> >
> > ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> > [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> > driver.
> >
> > During CPU hp stress operations on multiple CPUs, policy->related_cpus
> > can be altered. This is wrong since this cpumask should contain the
> > online and offline CPUs.
> >
> > The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> > cpufreq_online() triggers in this case.
> >
> > The core cpumask can't be used to set the policy->cpus in
> > ve_spc_cpufreq_init() anymore in case it is called via
> > cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
> >
> > An empty online() callback can be used to avoid that the init()
> > driver function is called during CPU hotplug in so that
> > policy->related_cpus will not be changed.
> >
> 
> Unlike DT based drivers, it not easy to get the fixed cpumask unless we
> add some mechanism to extract it based on clks/OPP added. I prefer
> this simple solution instead.

I will call this a work-around for the problem and not really the
solution, though I won't necessarily oppose it. There are cases which
will break even with this solution.

- Boot board with cpufreq driver as module.
- Offline all CPUs except CPU0.
- insert cpufreq driver.
- online all CPUs.

Now there is no guarantee that the last online will get the mask
properly, if I have understood the problem well :)

But yeah, who does this kind of messy work anyway :)

FWIW, we need a proper way (may be from architecture code) to find
list of all CPUs that share clock line.

-- 
viresh
