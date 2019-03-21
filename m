Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F6820850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVuJNocC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfCUJyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:54:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44201 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfCUJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:54:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so5793236wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PtA00BZnGIQ1W8ogRfOhskhN2WYgip1xDULBJM774nI=;
        b=sVuJNocC8R0Oy50/uLP5LIkZbGBM704heNoDR56PXUXY+M+MZMtn5oTEnMs1vtdRQZ
         1DGDpj4bDMfJ1O9QqyGyh+QV0ZR6OKF3FuvSh9dSabhPLJ+CkwKj/67WycpgB55HcMtc
         +uE13NMzBYqEI+rf1eGDw43BT3KHZZQdXE+zAZMynIwbujH5gIA9pb/mhXWaB9asWLdQ
         xexXQNL4sT8u7nuOKNPkwoF9ekouUIhqSHFVjzmeItIvBfQJWuOU9UIDmXsMxywXV4L0
         Rpu3LzxUIaogdWpcOdBw+gGa1JvmwUdRWLH7CfCmgI29ifpUhXvRkbKltQCDgzlpnzr3
         BSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PtA00BZnGIQ1W8ogRfOhskhN2WYgip1xDULBJM774nI=;
        b=dHNo5rdknhHP5UdXOHTX8rFSeV/eb0YUxTer2Z7JzYOVRVm50GLMy2DE43g98h3QoL
         LHpMOCrFCoQ/27LHs0KByKcqEHxx/uEUk/nBo1d7RjP7uMzm1aZEuAeSgFSu7Qzuu7SP
         wcnvJH4CsfUdElG/zBFopKo/35XVqwTqlcqkALE3jexQZFLGW5Qr9jmbDEzbG/Hpp+bq
         9O5Cb+wAF539Jf0v/g/va4v8NQeL2AfprCdT88WeSNaOz9KdQcy1VhNb2awzXAZ2Ja1k
         jgvFcA683dLE+WwdJk9ZAQePq386Tv059qWdN9jBoLDEtRRUk54AEIXxEdAyni8p4nTZ
         fnjg==
X-Gm-Message-State: APjAAAVe7O34OXEwTjeOXUw+OJUKYnIYtNfwb8tc3UdP8Bz+gaRUmmz+
        KmU76raP6HWJsjUZM2We0ZOWq0PfVKw=
X-Google-Smtp-Source: APXvYqxzuvbZ9EU7qrrL/922RRnwPNOJAB+FljOJUAohU3XSit9TaRi+aLP8KcrWkMTd/pdt3/yetg==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr1979697wrv.70.1553162057843;
        Thu, 21 Mar 2019 02:54:17 -0700 (PDT)
Received: from [192.168.0.41] (27.78.95.92.rev.sfr.net. [92.95.78.27])
        by smtp.googlemail.com with ESMTPSA id h18sm2545971wrt.97.2019.03.21.02.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:54:17 -0700 (PDT)
Subject: Re: [PATCH v12 2/4] PM / Domains: Add support for CPU devices to
 genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-3-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3ceca6d2-c780-49e4-5c90-566a7e8433ce@linaro.org>
Date:   Thu, 21 Mar 2019 10:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227195836.24739-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 20:58, Ulf Hansson wrote:
> To enable a device belonging to a CPU to be attached to a PM domain managed
> by genpd, let's do a few changes to it, as to make it convenient to manage
> the specifics around CPUs.
> 
> To be able to quickly find out what CPUs that are attached to a genpd,
> which typically becomes useful from a genpd governor as following changes
> is about to show, let's add a cpumask to the struct generic_pm_domain. At
> the point when a CPU device gets attached to a genpd, let's update the
> genpd's cpumask. Moreover, let's also propagate changes to the cpumask
> upwards in the topology to the master PM domains. In this way, the cpumask
> for a genpd hierarchically reflects all CPUs attached to the topology below
> it.
> 
> Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> and the cpumask for a genpd that doesn't need it. For that reason, let's
> add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

