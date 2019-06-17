Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA3C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E0A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfFQJGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:06:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727899AbfFQJGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:06:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC84D6217BBE20132385;
        Mon, 17 Jun 2019 17:06:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 17:06:16 +0800
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
To:     Jiri Olsa <jolsa@redhat.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
 <20190616095844.GC2500@krava>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <ben@decadent.org.uk>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a27e65b4-b487-9206-6dd0-6f9dcec0f1f5@huawei.com>
Date:   Mon, 17 Jun 2019 10:06:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190616095844.GC2500@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2019 10:58, Jiri Olsa wrote:
> On Fri, Jun 14, 2019 at 10:08:00PM +0800, John Garry wrote:
>> The jevent "Unit" field is used for uncore PMU alias definition.
>>
>> The form uncore_pmu_example_X is supported, where "X" is a wildcard,
>> to support multiple instances of the same PMU in a system.
>>
>> Unfortunately this format not suitable for all uncore PMUs; take the Hisi
>> DDRC uncore PMU for example, where the name is in the form
>> hisi_scclX_ddrcY.
>>
>> For the current jevent parsing, we would be required to hardcode an uncore
>> alias translation for each possible value of X. This is not scalable.
>>
>> Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
>> we can match by hisi_scclX and ddrcY. Tokens in Unit field are
>> delimited by ','.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/util/pmu.c | 39 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 7e7299fee550..bc71c60589b5 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -700,6 +700,39 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>>  	return map;
>>  }
>>
>> +static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>> +{
>> +	char *tmp, *tok, *str;
>> +	bool res;
>> +
>> +	str = strdup(pmu_name);
>> +	if (!str)
>> +		return false;
>> +
>> +	/*
>> +	 * uncore alias may be from different PMU with common
>> +	 * prefix or matching tokens.
>> +	 */
>> +	tok = strtok_r(str, ",", &tmp);
>> +	if (strncmp(pmu_name, tok, strlen(tok))) {
>

Hi Jirka,

> if tok is NULL in here we crash
>

As I see, tok could not be NULL. If str contains no delimiters, then we 
just return same as str in tok.

Can you see tok being NULL?

>> +		res = false;
>> +		goto out;
>> +	}
>> +
>> +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>
> why is name shifted in here?

I want to ensure that we match the tokens in order and also guard 
against possible repeated token matches in 'name'.

Thanks,
John

>
> jirka
>
>> +		name = strstr(name, tok);
>> +		if (!name) {
>> +			res = false;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	res = true;
>> +out:
>> +	free(str);
>> +	return res;
>> +}
>> +
>>  /*
>>   * From the pmu_events_map, find the table of PMU events that corresponds
>>   * to the current running CPU. Then, add all PMU events from that table
>> @@ -730,12 +763,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>>  			break;
>>  		}
>>
>> -		/*
>> -		 * uncore alias may be from different PMU
>> -		 * with common prefix
>> -		 */
>>  		if (pmu_is_uncore(name) &&
>> -		    !strncmp(pname, name, strlen(pname)))
>> +		    pmu_uncore_alias_match(pname, name))
>>  			goto new_alias;
>>
>>  		if (strcmp(pname, name))
>> --
>> 2.17.1
>>
>
> .
>


