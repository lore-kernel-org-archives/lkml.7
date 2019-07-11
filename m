Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC28C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03E0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGKCX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:23:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbfGKCX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:23:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C7547EB2D4A2594F218;
        Thu, 11 Jul 2019 10:23:24 +0800 (CST)
Received: from [127.0.0.1] (10.34.174.125) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 10:23:16 +0800
Subject: Re: [PATCH v3 1/4] perf pmu: Support more complex PMU event aliasing
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
 <1561732552-143038-2-git-send-email-john.garry@huawei.com>
 <20190702190724.GM15462@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9d06a987-9b18-aa4e-ec8a-5afc2e1c92b5@huawei.com>
Date:   Thu, 11 Jul 2019 03:23:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190702190724.GM15462@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.34.174.125]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2019 20:07, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 28, 2019 at 10:35:49PM +0800, John Garry escreveu:
>> The jevent "Unit" field is used for uncore PMU alias definition.
>>
>> The form uncore_pmu_example_X is supported, where "X" is a wildcard,
>> to support multiple instances of the same PMU in a system.
>>
>> Unfortunately this format not suitable for all uncore PMUs; take the Hisi
>> DDRC uncore PMU for example, where the name is in the form
>> hisi_scclX_ddrcY.
>>
>> For for current jevent parsing, we would be required to hardcode an uncore
>> alias translation for each possible value of X. This is not scalable.
>>
>> Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
>> we can match by hisi_scclX and ddrcY. Tokens  in Unit field
>> are delimited by ','.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 7e7299fee550..cfc916819c59 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -700,6 +700,46 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
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
>> +	 * uncore alias may be from different PMU with common prefix
>> +	 */
>> +	tok = strtok_r(str, ",", &tmp);
>
> In some places, e.g. gcc version 4.1.2:
>
>   CC       /tmp/build/perf/util/pmu.o
> cc1: warnings being treated as errors
> util/pmu.c: In function ‘pmu_lookup’:
> util/pmu.c:706: warning: ‘tmp’ may be used uninitialized in this function
> mv: cannot stat `/tmp/build/perf/util/.pmu.o.tmp': No such file or directory
>

Hi Arnaldo,

Sorry for the delayed resposne. Your fix, below, looks ok.

Regards,
John

> This silences it, adding.
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 913633ae0bf8..55f4de6442e3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -703,7 +703,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>
>  static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>  {
> -	char *tmp, *tok, *str;
> +	char *tmp = NULL, *tok, *str;
>  	bool res;
>
>  	str = strdup(pmu_name);
>
>
>> +	if (strncmp(pmu_name, tok, strlen(tok))) {
>> +		res = false;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Match more complex aliases where the alias name is a comma-delimited
>> +	 * list of tokens, orderly contained in the matching PMU name.
>> +	 *
>> +	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
>> +	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
>> +	 *	    "pmunameY".
>> +	 */
>> +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
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
>> @@ -730,12 +770,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
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
>


