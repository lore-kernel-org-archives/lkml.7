Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD29C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1CD206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfLDQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:03:31 -0500
Received: from foss.arm.com ([217.140.110.172]:57984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfLDQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:03:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F76231B;
        Wed,  4 Dec 2019 08:03:30 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33FE33F52E;
        Wed,  4 Dec 2019 08:03:29 -0800 (PST)
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com>
 <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com>
Date:   Wed, 4 Dec 2019 16:03:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 15:22, Vincent Guittot wrote:
>> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> 
> Why not changing uclamp_eff_value to return unsigned long too ? The
> returned value represents a utilization to be compared with other
> utilization value
> 

IMO uclamp_eff_value() is a simple accessor to uclamp_se.value
(unsigned int), which is why I didn't want to change its return type.
I see it as being the task equivalent of rq->uclamp[clamp_id].value, IOW
"give me the uclamp value for that clamp index". It just happens to be a
bit more intricate for tasks than for rqs.

uclamp_util() & uclamp_util_with() do explicitly return a utilization,
so here it makes sense (in my mind, that is) to return UL.
