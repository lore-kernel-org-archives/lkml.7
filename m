Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4045C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96BE20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLJSJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:09:49 -0500
Received: from foss.arm.com ([217.140.110.172]:52716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJSJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:09:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4440C1FB;
        Tue, 10 Dec 2019 10:09:48 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC2E3F6CF;
        Tue, 10 Dec 2019 10:09:46 -0800 (PST)
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5b293a96-438e-e4f8-3fb0-3820c6d9651c@arm.com>
Date:   Tue, 10 Dec 2019 19:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203155907.2086-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 16:59, Valentin Schneider wrote:

[...]

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c735935..f1d035e5df7e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>  
>  static __always_inline
> -unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> -			      struct task_struct *p)
> +unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
> +			       struct task_struct *p)
>  {
> -	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> +	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> +	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>  
>  	if (p) {
> -		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +		min_util = max_t(unsigned long, min_util, uclamp_eff_value(p, UCLAMP_MIN));
> +		max_util = max_t(unsigned long, max_util, uclamp_eff_value(p, UCLAMP_MAX));
>  	}
>  
>  	/*
> @@ -2325,17 +2325,17 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>  	return clamp(util, min_util, max_util);
>  }
>  
> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>  {
>  	return uclamp_util_with(rq, util, NULL);
>  }
>  #else /* CONFIG_UCLAMP_TASK */
> -static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> -					    struct task_struct *p)
> +static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
> +					     struct task_struct *p)
>  {
>  	return util;
>  }
> -static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
>  {
>  	return util;
>  }

There doesn't seem to be any user of uclamp_util(), only uclamp_util_with()?

