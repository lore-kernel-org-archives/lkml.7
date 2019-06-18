Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58082206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfFRJIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:08:13 -0400
Received: from foss.arm.com ([217.140.110.172]:58294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbfFRJIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:08:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C5F344;
        Tue, 18 Jun 2019 02:08:12 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971A63F246;
        Tue, 18 Jun 2019 02:08:10 -0700 (PDT)
Subject: Re: [PATCH 3/8] sched,fair: redefine runnable_load_avg as the sum of
 task_h_load
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-4-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <750a19c9-d0b2-baa1-2d2f-756e3bff1892@arm.com>
Date:   Tue, 18 Jun 2019 11:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-4-riel@surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On 6/12/19 9:32 PM, Rik van Riel wrote:

[...]

> @@ -379,17 +368,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)
>   	 * We can safely remove running from rq->clock because
>   	 * rq->clock += delta with delta >= running
>   	 */
> -	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
> -				0,
> -				0,
> -				0);
> -	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
> -				1,
> -				1,
> -				1);
> +	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq, 0);
> +	ret += ___update_load_sum(rq->clock, &rq->avg_irq, 1);

The 'int running' argument in the two ___update_load_sum() calls is 
missing. Doesn't compile for me (arm64 defconfig w/ 
CONFIG_IRQ_TIME_ACCOUNTING=y).

[...]

