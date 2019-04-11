Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58250C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4B2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555015484;
	bh=q66BQqnKckskSTecJ/LlsnJkkia2OlBOrQQyyB1+l1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XDVvy22o/+8idYP1hbigAdHcwI7ms0znlme+MOPJDZzxIpd+8UNSPwOwqirEg1Mge
	 iBsXUgHiiZx4RDXPvvbTDibkXszozls0jpQZbht1HmCvMG1vs7iMhHyOUfqp2+SB8s
	 XCPyB1RU0ZIrCc5MizBRsQ+kqSaxOysrxvvZ/qoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDKUom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:44:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46760 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:44:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so6097559oia.13;
        Thu, 11 Apr 2019 13:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLlC6X7IovyMMzQ0jkSm2PAnsWWLeJJTqcPx8mAOfwM=;
        b=jqwq1YNLE0bC/rlhg6ZmqZp09WTh5ccy872gzJo/jbeZCsHy3OunDLLy9uC5Y8eCoc
         WmFYlWqP073wWjHtA+4i7LjRwvy0fqXgVFL3cKWWrZDEr/IkShPDvjfUH+fksh9xrf3I
         NOgm0GWq99GpjAvZpWp2FAs4Lf0VFQzzhwnyNOlbAuoeZF34DTCuU3E0nE3crW6+m0SM
         lkPyVooJkTK6p/AjYY99iQpTjXAmLzmlzC4pPAzCbIulbGMqk57E1YHDLcjIx/8RFr1Q
         bswVY97OviCwGFSdEaYKApw5dXPBM2fh/BXPC30ffmb2z5wg3zoq3K6bvasvAQ1lxuay
         r7MA==
X-Gm-Message-State: APjAAAUKXkpEXOpYWYPhUL6qdY8VVwVnVuUyvvhjqWM87fyRqbxnPjnr
        k1jfyThs3RvDfLjXzr7510GNy/P2XHxj5r/sbgo=
X-Google-Smtp-Source: APXvYqyfZP+w+RFpgS9CgC/HXHhWnweUGlZbSPPOESFhgFzTYWiDGGLbTYFsWAfxtedmIgCPSM86fhuPZAS5UCP0F/g=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr7698757oib.95.1555015480675;
 Thu, 11 Apr 2019 13:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190411181733.21437-1-ulf.hansson@linaro.org>
In-Reply-To: <20190411181733.21437-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Apr 2019 22:44:29 +0200
Message-ID: <CAJZ5v0hVkgF2MYUh4VkXN0L2ZtxMoC8bUV6CY7=fAnSHRLpqUA@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] PM / Domains: Add genpd governor for CPUs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 8:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> After some preceding changes, PM domains managed by genpd may contain
> CPU devices, so idle state residency values should be taken into
> account during the state selection process. [The residency value is
> the minimum amount of time to be spent by a CPU (or a group of CPUs)
> in an idle state in order to save more energy than could be saved
> by picking up a shallower idle state.]
>
> For this purpose, add a new genpd governor, pm_domain_cpu_gov, to be
> used for selecting idle states of PM domains with CPU devices attached
> either directly or through subdomains.
>
> The new governor computes the minimum expected idle duration for all
> online CPUs attached to a PM domain and its subdomains.  Next, it
> finds the deepest idle state whose target residency is within the
> expected idle duration and selects it as the target idle state of
> the domain.
>
> It should be noted that the minimum expected idle duration computation
> is based on the closest timer event information stored in the per-CPU
> variables cpuidle_devices for all of the CPUs in the domain.  That
> needs to be revisited in future, as obviously there are other reasons
> why a CPU may be woken up from idle.
>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [ rjw: Changelog ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied instead of the previous version, thanks!
