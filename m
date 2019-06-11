Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbfFKQXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:23:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391562AbfFKQXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:23:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3184D90254F032FD5765;
        Wed, 12 Jun 2019 00:23:16 +0800 (CST)
Received: from [127.0.0.1] (10.210.166.43) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 00:22:44 +0800
Subject: Re: [PATCH 2/5] perf pmu: Support more complex PMU event aliasing
To:     Jiri Olsa <jolsa@redhat.com>
References: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
 <1560160772-210844-3-git-send-email-john.garry@huawei.com>
 <20190611161023.GD18242@krava>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <ben@decadent.org.uk>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9c3ba12c-0621-0e28-ddeb-e1ebeb1674a5@huawei.com>
Date:   Tue, 11 Jun 2019 17:22:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190611161023.GD18242@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 17:10, Jiri Olsa wrote:
> On Mon, Jun 10, 2019 at 05:59:29PM +0800, John Garry wrote:
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
>> we can match by hisi_scclX and ddrcY. Tokens in Unit field
>> are delimited by ','.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/util/pmu.c | 45 ++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 036047f56efa..f00cae750086 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -700,6 +700,44 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>>  	return map;
>>  }
>>
>> +static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>> +{
>> +	/*
>> +	 * uncore alias may be from different PMU
>> +	 * with common prefix
>> +	 */
>> +	if (!strncmp(pmu_name, name, strlen(pmu_name)))
>> +		return true;
>> +
>> +	/* match strings with delimiter, ',' */
>> +	while (1) {
>> +		const char *delimiter;
>> +		char token[256] = {};
>> +		const char *found_token;
>> +		int token_len;
>> +
>> +		delimiter = strchr(pmu_name, ',');
>> +		if (delimiter) {
>> +			token_len = delimiter - pmu_name;
>> +		} else {
>> +			token_len = strlen(pmu_name);
>> +		}
>> +
>> +		memcpy(token, pmu_name, token_len);
>> +
>> +		found_token = strstr(name, token);
>> +		if (!found_token)
>> +			return false;
>> +
>> +		/* No more delimiters, so we must be a match */
>> +		if (!delimiter)
>> +			return true;
>> +
>> +		pmu_name += token_len + 1;
>> +		name = found_token + token_len;
>> +	}
>
> hum, would this be easier with strtok_r?

Yes, I think so.

Cheers,

>
> jirka
>
> .
>


