Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A462C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD021773
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfF1KqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:46:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbfF1KqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:46:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E14F48D31486AA4B2C7;
        Fri, 28 Jun 2019 18:46:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 18:45:51 +0800
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
To:     Jiri Olsa <jolsa@redhat.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
 <20190616095844.GC2500@krava>
 <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
 <20190620182519.GA15239@krava>
 <6257fc79-b737-e6ca-2fce-f71afa36e9aa@huawei.com>
 <cafed7d6-13c7-3a92-a826-024698bc6cc8@huawei.com>
 <20190628104040.GA15960@krava>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <ben@decadent.org.uk>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <004cb11b-e0ee-5af1-33d4-437fb8be03c0@huawei.com>
Date:   Fri, 28 Jun 2019 11:45:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190628104040.GA15960@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2019 11:40, Jiri Olsa wrote:
> On Thu, Jun 27, 2019 at 05:27:32PM +0100, John Garry wrote:
>
> SNIP
>
>>>>
>>>> heya,
>>>> sry for late reply
>>>>
>>>>>
>>>>>> if tok is NULL in here we crash
>>>>>>
>>>>>
>>>>> As I see, tok could not be NULL. If str contains no delimiters, then
>>>>> we just
>>>>> return same as str in tok.
>>>>>
>>>>> Can you see tok being NULL?
>>>>
>>>> well, if there's no ',' in the str it returns NULL, right?
>>>
>>> No, it would return str in tok.
>
> ok
>
>>>
>>>> and IIUC this function is still called for standard uncore
>>>> pmu names
>>>>
>>>>>
>>>>>>> +        res = false;
>>>>>>> +        goto out;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",",
>>>>>>> &tmp)) {
>>>>>>
>>>>>> why is name shifted in here?
>>>>>
>>>>> I want to ensure that we match the tokens in order and also guard
>>>>> against
>>>>> possible repeated token matches in 'name'.
>>>>
>>>> i might not understand this correctly.. so
>>>>
>>>> str is the alias name that can contain ',' now, like:
>>>>   hisi_sccl,ddrc
>>>
>>> For example of pmu_nmame=hisi_sccl,ddrc and pmu=hisi_sccl1_ddrc0, we
>>> match in this sequence:
>>>
>>> loop 1. tok=hisi_sccl name=hisi_sccl1_ddrc0
>>> loop 2. tok=ddrc name=ddrc0
>>> loop 3. tok=NULL -> breakout and return true
>

Hi jirka,

> ok, plz put something like above into comment
>

ok, can do.

Thanks again,
John

> thanks,
> jirka
>
> .
>


