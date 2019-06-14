Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3818021537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfFNPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:04:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfFNPEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:04:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3ABFC8AF69B1F40DE6E4;
        Fri, 14 Jun 2019 23:04:45 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:04:35 +0800
Subject: Re: [PATCH v2 1/5] perf pmu: Fix uncore PMU alias list for ARM64
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-2-git-send-email-john.garry@huawei.com>
 <20190614144656.GF1402@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <275d1699-23a3-f06b-3fad-750784318cc1@huawei.com>
Date:   Fri, 14 Jun 2019 16:04:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190614144656.GF1402@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2019 15:46, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 14, 2019 at 10:07:59PM +0800, John Garry escreveu:
>> In commit 292c34c10249 ("perf pmu: Fix core PMU alias list for X86
>> platform"), we fixed the issue of CPU events being aliased to uncore
>> events.
>>
>> Fix this same issue for ARM64, since the said commit left the (broken)
>> behaviour untouched for ARM64.
>
> So I added:
>
> Cc: stable@vger.kernel.org
> Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
>
> So that the stable trees get this fix and add it to the versions where
> it should have been together with the x86 fix, ok?

Hi Arnaldo,

I have a slight hesitation about this qualifying for the stable.

It's fixing uncore pmu aliasing for arm64. But this series is also the 
first to introduce any actual arm64 uncore pmu aliases.

Thanks,
John

>
> - Arnaldo
>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/util/pmu.c | 28 ++++++++++++----------------
>>  1 file changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index f2eff272279b..7e7299fee550 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -709,9 +709,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>>  {
>>  	int i;
>>  	struct pmu_events_map *map;
>> -	struct pmu_event *pe;
>>  	const char *name = pmu->name;
>> -	const char *pname;
>>
>>  	map = perf_pmu__find_map(pmu);
>>  	if (!map)
>> @@ -722,28 +720,26 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>>  	 */
>>  	i = 0;
>>  	while (1) {
>> +		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
>> +		struct pmu_event *pe = &map->table[i++];
>> +		const char *pname = pe->pmu ? pe->pmu : cpu_name;
>>
>> -		pe = &map->table[i++];
>>  		if (!pe->name) {
>>  			if (pe->metric_group || pe->metric_name)
>>  				continue;
>>  			break;
>>  		}
>>
>> -		if (!is_arm_pmu_core(name)) {
>> -			pname = pe->pmu ? pe->pmu : "cpu";
>> -
>> -			/*
>> -			 * uncore alias may be from different PMU
>> -			 * with common prefix
>> -			 */
>> -			if (pmu_is_uncore(name) &&
>> -			    !strncmp(pname, name, strlen(pname)))
>> -				goto new_alias;
>> +		/*
>> +		 * uncore alias may be from different PMU
>> +		 * with common prefix
>> +		 */
>> +		if (pmu_is_uncore(name) &&
>> +		    !strncmp(pname, name, strlen(pname)))
>> +			goto new_alias;
>>
>> -			if (strcmp(pname, name))
>> -				continue;
>> -		}
>> +		if (strcmp(pname, name))
>> +			continue;
>>
>>  new_alias:
>>  		pr_err("%s new_alias name=%s pe->name=%s\n", __func__, name, pe->name);
>> --
>> 2.17.1
>


