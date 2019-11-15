Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22DC206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKOC7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:59:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbfKOC7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:59:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3BF4703125ED2C8AE1E;
        Fri, 15 Nov 2019 10:59:50 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 10:59:45 +0800
Subject: Re: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
To:     James Clark <James.Clark@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
 <20191024144830.16534-5-tanxiaojun@huawei.com>
 <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
 <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
 <609eb078-7998-9e4a-ca04-6c40a8a47f84@arm.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Message-ID: <7137fecb-a0bd-6dee-14c9-5753e56d39a1@huawei.com>
Date:   Fri, 15 Nov 2019 10:59:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <609eb078-7998-9e4a-ca04-6c40a8a47f84@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/13 22:47, James Clark wrote:
> Hi Xiaojun,
> 
>> I can't reproduce this problem. If the current system doesn't support spe, it shouldn't report an error. I use the latest codes of the mainline:
> 
> I think the problem is related to the 'type' attribute of the event. To open the SPE PMU the event type on the platform I'm using is '7'. If I change
> the code like this, the problem is fixed:
> 
> @@ -914,13 +914,27 @@ void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel)
>                 pmu = perf_pmu__find("arm_spe_0");
>                 if (pmu) {
>                         evsel->pmu_name = pmu->name;
> -                       evsel->core.attr.type = PERF_RECORD_AUXTRACE;
> -                       evsel->core.attr.config = SPE_ATTR_TS_ENABLE
> -                                               | SPE_ATTR_PA_ENABLE
> -                                               | SPE_ATTR_JITTER
> +                       evsel->core.attr.type = pmu->type;
> +                       evsel->core.attr.config |= SPE_ATTR_TS_ENABLE
>                                                 | SPE_ATTR_BRANCH_FILTER;
> 

Hi, James,
OK. Thank you for your fix.

> Also do you think jitter should be enabled by default? I thought that it might make the data less precise, so I removed it here.

Since the interval for sampling without "jitter" is fixed (default 1024 on our server), I was worried that not adding it would result in the same result for each record, and some instructions could not be collected each time.

However, after many tests, it is not clear from the results that there is a significant difference between them (enable it or not).

So I am confused, whether to enable it or not.

Thanks.
Xiaojun.

> 
> -James
> 
>>
>> commit f116b96685a046a89c25d4a6ba2da489145c8888 (mainline/master)
>> Merge: f632bfaa33ed 603d9299da32
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Thu Oct 24 06:13:45 2019 -0400
>>
>>     Merge tag 'mfd-fixes-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
>>
>> I will go and see why this will be reported.
>>
>>>
>>>
>>> I would have expected to use the event name that is listed in the SPE documentation for branch misses which is br_mis_pred or br_mis_pred_retired:
>>>
>>>     E[7], byte 0 bit [7]
>>>     Mispredicted. The defined values of this bit are:
>>>     0 Did not cause correction to the predicted program flow.
>>>     1 A branch that caused a correction to the predicted program flow.
>>>
>>>     If PMUv3 is implemented this Event is required to be implemented consistently with either BR_MIS_PRED or BR_MIS_PRED_RETIRED.
>>>
>>
>> Do you mean that I can add these as new events to perf? If we think of them as new events, what should we do if the user does not add :pp for them?
>> (Or for these events, users can only add :pp to use them?)
>>
>>>
>>> +       if (!strcmp(perf_env__arch(evlist->env), "arm64")
>>> +                       && evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
>>> +                       && evsel->core.attr.precise_ip) {
>>>
>>> As I mentioned above PERF_COUNT_HW_BRANCH_MISSESdoesn't seem to match up with the actual event counter that is associated with this SPE event (BR_MIS_PRED). The fix for this is probably as simple as adding an OR for the other aliases for branch mispredicts.
>>
>> What you mean is that we can filter with spe events(like BR_MIS_PRED) first, and if we have other events that are exactly the same(no more for now), then we can handle them by adding OR in the future?
>>
>>>
>>> +               pmu = perf_pmu__find("arm_spe_0");
>>> +               if (pmu) {
>>> +                       evsel->pmu_name = pmu->name;
>>> +                       evsel->core.attr.type = PERF_RECORD_AUXTRACE;
>>> +                       evsel->core.attr.config = SPE_ATTR_TS_ENABLE
>>> +                                               | SPE_ATTR_PA_ENABLE
>>>
>>> I wouldn't set physical addresses by default as this requires root. I would leave that to the user if they want to manually configure SPE.
>>
>> Yes. You are right. I got a error for this case. I will fix it.
>>
>> ------------------
>> ./perf record -e branch-misses:p ls
>> Error:
>> You may not have permission to collect stats.
>> ...
>> ------------------
>>
>> Thanks.
>> Xiaojun.
>>
>>>
>>> I have only looked briefly and I will do some more testing.
>>>
>>>
>>> Thanks
>>> James
>>>
>>>
>>
>>


