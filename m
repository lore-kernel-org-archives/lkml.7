Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226D2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfG2JBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:01:01 -0400
Received: from foss.arm.com ([217.140.110.172]:40268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG2JBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:01:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01072337;
        Mon, 29 Jul 2019 02:01:01 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40AD3F575;
        Mon, 29 Jul 2019 02:00:59 -0700 (PDT)
Subject: Re: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running
 bw in push_dl_task()
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-2-dietmar.eggemann@arm.com>
 <20190726153002.5e49c666@sweethome>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <213a5bb3-208a-b8dc-0c80-175ceb4ae1dd@arm.com>
Date:   Mon, 29 Jul 2019 10:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726153002.5e49c666@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 2:30 PM, luca abeni wrote:
> Hi,
> 
> On Fri, 26 Jul 2019 09:27:52 +0100
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> [...]
>> @@ -2121,17 +2121,13 @@ static int push_dl_task(struct rq *rq)
>>  	}
>>  
>>  	deactivate_task(rq, next_task, 0);
>> -	sub_running_bw(&next_task->dl, &rq->dl);
>> -	sub_rq_bw(&next_task->dl, &rq->dl);
>>  	set_task_cpu(next_task, later_rq->cpu);
>> -	add_rq_bw(&next_task->dl, &later_rq->dl);
>>  
>>  	/*
>>  	 * Update the later_rq clock here, because the clock is used
>>  	 * by the cpufreq_update_util() inside __add_running_bw().
>>  	 */
>>  	update_rq_clock(later_rq);
>> -	add_running_bw(&next_task->dl, &later_rq->dl);
> 
> Looking at the code again and thinking a little bit more about this
> issue, I suspect a similar change is needed in pull_dl_task() too, no?

The code looks the same. Let me try to test it. I will add it in v2 then.

