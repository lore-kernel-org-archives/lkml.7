Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F638218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bzGEqf/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfDXQrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:47:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfDXQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dNi5KwP4lynMteREQ7r0+h3UYMU5MQJt6J0Mbq7DoEE=; b=bzGEqf/kHAcofHjhwQOzVt69G
        Y4aVy0iTohaWloSMfdnJSdzF1p58koNbllIzARfxA34coV3qvz043K3MHc3hS7gVSS95N8g8STkjU
        wX5PWZaxr8ujO24UyWXDcYXsxwV6CrjeblYGVhONOYnct+YOzMEPSGkW91MuAEhMuZi+okElwmFht
        heThNmOQoyDwQUqK9shLFH2bPoMorIw440bfWtVqy+Ox3LYhWI63ml+ad+TZlrAcDnB1A3H9yPadY
        zf5v0NJS9vs4+b/ktlx6VTHwQuY62MS3QVkX1EBdO8H3SGhjGqbgxZN8b4aQGGj/hwgXEUJBI6kv1
        9YjcxFfuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJL39-0005yK-8C; Wed, 24 Apr 2019 16:47:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0556E203C0A58; Wed, 24 Apr 2019 18:47:10 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20190424164709.GJ4038@hirez.programming.kicks-ass.net>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:38:41PM -0400, Thara Gopinath wrote:
> Enable cpufreq cooling device to update the thermal pressure in
> event of a capped maximum frequency or removal of capped maximum
> frequency.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6fff161..d5cc3c3 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/sched/thermal.h>
>  
>  #include <trace/events/thermal.h>
>  
> @@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  
>  		if (policy->max > clipped_freq)
>  			cpufreq_verify_within_limits(policy, 0, clipped_freq);
> +
> +		sched_update_thermal_pressure(policy->cpus,
> +				policy->max, policy->cpuinfo.max_freq);

If it's already telling the cpufreq thing, why not get it from sugov
instead?
