Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B8C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528AE21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJBKus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:50:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJBKus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:50:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944F41000;
        Wed,  2 Oct 2019 03:50:47 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527983F739;
        Wed,  2 Oct 2019 03:50:45 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
Date:   Wed, 2 Oct 2019 11:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 09:30, Vincent Guittot wrote:
>> Isn't that one somewhat risky?
>>
>> Say both groups are classified group_has_spare and we do prefer_sibling.
>> We'd select busiest as the one with the maximum number of busy CPUs, but it
>> could be so that busiest.sum_h_nr_running < local.sum_h_nr_running (because
>> pinned tasks or wakeup failed to properly spread stuff).
>>
>> The thing should be unsigned so at least we save ourselves from right
>> shifting a negative value, but we still end up with a gygornous imbalance
>> (which we then store into env.imbalance which *is* signed... Urgh).
> 
> so it's not clear what happen with a right shift on negative signed
> value and this seems to be compiler dependent so even
> max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1) might be wrong
> 

Yeah, right shift on signed negative values are implementation defined. This
is what I was worried about initially, but I think the expression resulting
from the subtraction is unsigned (both terms are unsigned) so this would
just wrap when busiest < local - but that is still a problem.


((local->idle_cpus - busiest->idle_cpus) >> 1) should be fine because we do
have this check in find_busiest_group() before heading off to
calculate_imbalance():

  if (busiest->group_type != group_overloaded &&
      (env->idle == CPU_NOT_IDLE ||
       local->idle_cpus <= (busiest->idle_cpus + 1)))
	  /* ... */
	  goto out_balanced;

which ensures the subtraction will be at least 2. We're missing something
equivalent for the sum_h_nr_running case.

> I'm going to update it
> 
> 
>>
>> [...]
