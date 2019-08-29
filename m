Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CBEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69A92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfH2RUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:20:52 -0400
Received: from foss.arm.com ([217.140.110.172]:48346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfH2RUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:20:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD061337;
        Thu, 29 Aug 2019 10:20:50 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37F943F59C;
        Thu, 29 Aug 2019 10:20:49 -0700 (PDT)
Subject: Re: [PATCH 13/15] sched,fair: propagate sum_exec_runtime up the
 hierarchy
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
References: <20190822021740.15554-1-riel@surriel.com>
 <20190822021740.15554-14-riel@surriel.com>
 <f940abf6-3020-014c-74d7-d9be334e201c@arm.com>
 <a35dd83b9ecadf4e136b588d7696a23e36ff2e9a.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1d631d5e-e606-4915-440f-fb00daa41fa5@arm.com>
Date:   Thu, 29 Aug 2019 19:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a35dd83b9ecadf4e136b588d7696a23e36ff2e9a.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 15:14, Rik van Riel wrote:
> On Wed, 2019-08-28 at 09:51 +0200, Dietmar Eggemann wrote:
>> On 22/08/2019 04:17, Rik van Riel wrote:
>>> Now that enqueue_task_fair and dequeue_task_fair no longer iterate
>>> up
>>> the hierarchy all the time, a method to lazily propagate
>>> sum_exec_runtime
>>> up the hierarchy is necessary.
>>>
>>> Once a tick, propagate the newly accumulated exec_runtime up the
>>> hierarchy,
>>> and feed it into CFS bandwidth control.
>>>
>>> Remove the pointless call to account_cfs_rq_runtime from
>>> update_curr,
>>> which is always called with a root cfs_rq.
>>
>> But what about the call to account_cfs_rq_runtime() in
>> set_curr_task_fair()? Here you always call it with the root cfs_rq.
>> Shouldn't this be called also in a loop over all se's until !se-
>>> parent
>> (like in propagate_exec_runtime() further below).
> 
> I believe that call should be only on the cgroup
> cfs_rq, with account_cfs_rq_runtime figuring out
> whether more runtime needs to be obtained from
> further up in the hierarchy.

So like this?

@@ -10248,7 +10248,8 @@ static void set_curr_task_fair(struct rq *rq)

        set_next_entity(cfs_rq, se);
        /* ensure bandwidth has been allocated on our new cfs_rq */
-       account_cfs_rq_runtime(cfs_rq, 0);
+       if (task_se_in_cgroup(se))
+               account_cfs_rq_runtime(group_cfs_rq_of_parent(se), 0);
 }

I fail to understand the second part of your sentence, and
how is this related to the code in propagate_exec_runtime():

for_each_sched_entity(se) {

    propagate_exec_runtime() {

        if (parent)
            account_cfs_rq_runtime(cfs_rq, diff);
    }
}

> By default we should probably work under the assumption
> that account_cfs_rq_runtime() will succeed at the current
> level, and no gymnastics are required to obtain CPU time.

Maybe this all will become clearer when the reworked CFS Bandwidth
support is ready ;-) I see this patch as the first part of it.
