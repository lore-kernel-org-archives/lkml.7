Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB4BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4982073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLJRHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:07:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfLJRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:07:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0FE41FB;
        Tue, 10 Dec 2019 09:07:12 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F623F6CF;
        Tue, 10 Dec 2019 09:07:11 -0800 (PST)
Subject: Re: [PATCH v2 3/4] sched/fair: Make task_fits_capacity() consider
 uclamp restrictions
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-4-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5549acc0-c5d6-a263-d995-edfeba467915@arm.com>
Date:   Tue, 10 Dec 2019 18:07:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203155907.2086-4-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 16:59, Valentin Schneider wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..dc3e86cb2b2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3711,6 +3711,22 @@ static inline unsigned long task_util_est(struct task_struct *p)
>  	return max(task_util(p), _task_util_est(p));
>  }
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +static inline
> +unsigned long uclamp_task_util(struct task_struct *p)
> +{
> +	return clamp(task_util_est(p),
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
> +}
> +#else
> +static inline
> +unsigned long uclamp_task_util(struct task_struct *p)

[...]

Save some lines?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc659a3944f1..ab921ee356a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3712,16 +3712,14 @@ static inline unsigned long task_util_est(struct
task_struct *p)
 }

 #ifdef CONFIG_UCLAMP_TASK
-static inline
-unsigned long uclamp_task_util(struct task_struct *p)
+static inline unsigned long uclamp_task_util(struct task_struct *p)
 {
        return clamp(task_util_est(p),
                     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
                     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
 }
 #else
-static inline
-unsigned long uclamp_task_util(struct task_struct *p)
+static inline unsigned long uclamp_task_util(struct task_struct *p)
 {
        return task_util_est(p);
 }

[...]
