Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30682208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFUKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:43:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfFUKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:43:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BD5FAE76C3C2BD81D39E;
        Fri, 21 Jun 2019 18:43:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 18:43:04 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
To:     Jiri Olsa <jolsa@redhat.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
 <20190616095844.GC2500@krava>
 <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
 <20190620182519.GA15239@krava>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <ben@decadent.org.uk>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
Message-ID: <6257fc79-b737-e6ca-2fce-f71afa36e9aa@huawei.com>
Date:   Fri, 21 Jun 2019 11:42:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190620182519.GA15239@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2019 19:25, Jiri Olsa wrote:
> On Mon, Jun 17, 2019 at 10:06:08AM +0100, John Garry wrote:
>> On 16/06/2019 10:58, Jiri Olsa wrote:
>>> On Fri, Jun 14, 2019 at 10:08:00PM +0800, John Garry wrote:
>>>> The jevent "Unit" field is used for uncore PMU alias definition.
>>>>
>>>> The form uncore_pmu_example_X is supported, where "X" is a wildcard,
>>>> to support multiple instances of the same PMU in a system.
>>>>
>>>> Unfortunately this format not suitable for all uncore PMUs; take the Hisi
>>>> DDRC uncore PMU for example, where the name is in the form
>>>> hisi_scclX_ddrcY.
>>>>
>>>> For the current jevent parsing, we would be required to hardcode an uncore
>>>> alias translation for each possible value of X. This is not scalable.
>>>>
>>>> Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
>>>> we can match by hisi_scclX and ddrcY. Tokens in Unit field are
>>>> delimited by ','.
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> ---
>>>>  tools/perf/util/pmu.c | 39 ++++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index 7e7299fee550..bc71c60589b5 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -700,6 +700,39 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>>>>  	return map;
>>>>  }
>>>>
>>>> +static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>>> +{
>>>> +	char *tmp, *tok, *str;
>>>> +	bool res;
>>>> +
>>>> +	str = strdup(pmu_name);
>>>> +	if (!str)
>>>> +		return false;

Hi Jirka,

>>>> +
>>>> +	/*
>>>> +	 * uncore alias may be from different PMU with common
>>>> +	 * prefix or matching tokens.
>>>> +	 */
>>>> +	tok = strtok_r(str, ",", &tmp);

If str contains no delimiter, then it returns str in tok.

>>>> +	if (strncmp(pmu_name, tok, strlen(tok))) {

So this above check covers the case of str with and without a delimiter.

>>>
>>
>> Hi Jirka,
>
> heya,
> sry for late reply
>
>>
>>> if tok is NULL in here we crash
>>>
>>
>> As I see, tok could not be NULL. If str contains no delimiters, then we just
>> return same as str in tok.
>>
>> Can you see tok being NULL?
>
> well, if there's no ',' in the str it returns NULL, right?

No, it would return str in tok.

> and IIUC this function is still called for standard uncore
> pmu names
>
>>
>>>> +		res = false;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>>>
>>> why is name shifted in here?
>>
>> I want to ensure that we match the tokens in order and also guard against
>> possible repeated token matches in 'name'.
>
> i might not understand this correctly.. so
>
> str is the alias name that can contain ',' now, like:
>   hisi_sccl,ddrc

For example of pmu_nmame=hisi_sccl,ddrc and pmu=hisi_sccl1_ddrc0, we 
match in this sequence:

loop 1. tok=hisi_sccl name=hisi_sccl1_ddrc0
loop 2. tok=ddrc name=ddrc0
loop 3. tok=NULL -> breakout and return true

A couple of notes:
a. loop 1. could be omitted, but the code becomes a bit more complicated
2. I don't have to advance name. But then we would match something like 
hisi_ddrc0_sccl1. Maybe this is ok.

>
> and name is still pmu with no ',' ...
 > please make this or
> proper version that in some comment
>

I didn't really get your meaning here. Please check my replies and see 
if you have further doubt or concern.

Much appreciated,
John

> thanks,
> jirka
>
> .
>


