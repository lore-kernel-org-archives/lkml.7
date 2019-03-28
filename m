Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1KQt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:16:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52093 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:16:49 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 985856673ac3a6de; Thu, 28 Mar 2019 11:16:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent =?ISO-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: scpi: fix use after free
Date:   Thu, 28 Mar 2019 11:14:47 +0100
Message-ID: <3545642.ato4ToQdI5@aspire.rjw.lan>
In-Reply-To: <20190327220642.8117-1-vincent.stehle@laposte.net>
References: <20190327220642.8117-1-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 27, 2019 11:06:42 PM CET Vincent Stehlé wrote:
> Free the priv structure only after we are done using it.
> 
> Fixes: 1690d8bb91e370ab ("cpufreq: scpi/scmi: Fix freeing of dynamic OPPs")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 3f49427766b88..2b51e0718c9f6 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -189,8 +189,8 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  	clk_put(priv->clk);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> -	kfree(priv);
>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> +	kfree(priv);
>  
>  	return 0;
>  }
> 

I've queued this one up, thanks!


