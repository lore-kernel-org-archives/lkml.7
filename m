Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B32C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AA520674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCLkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:40:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:48897 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCLkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:40:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 03:40:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="204945807"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2019 03:40:32 -0800
Received: from [10.125.253.16] (abudanko-mobl.ccr.corp.intel.com [10.125.253.16])
        by linux.intel.com (Postfix) with ESMTP id EF06A58033E;
        Tue,  3 Dec 2019 03:40:29 -0800 (PST)
Subject: Re: [PATCH v4 3/3] perf record: adapt affinity to machines with #CPUs
 > 1K
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f1e6e809-9e41-e410-57eb-1740512285a1@linux.intel.com>
 <2095b034-bf53-c374-0e34-adc006b00fbb@linux.intel.com>
 <20191203101252.GD17468@krava>
 <cc0dd7dc-400f-7097-b371-e895c016aaae@linux.intel.com>
 <20191203112335.GF17468@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9737af83-3c6d-d96a-d297-bdfb15594416@linux.intel.com>
Date:   Tue, 3 Dec 2019 14:40:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203112335.GF17468@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12.2019 14:23, Jiri Olsa wrote:
> On Tue, Dec 03, 2019 at 01:48:05PM +0300, Alexey Budankov wrote:
>>
>>
>> On 03.12.2019 13:12, Jiri Olsa wrote:
>>> On Mon, Dec 02, 2019 at 09:58:48AM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>>  
>>>> -static void build_node_mask(int node, cpu_set_t *mask)
>>>> +static void build_node_mask(int node, struct mmap_cpu_mask *mask)
>>>>  {
>>>>  	int c, cpu, nr_cpus;
>>>>  	const struct perf_cpu_map *cpu_map = NULL;
>>>> @@ -240,17 +242,23 @@ static void build_node_mask(int node, cpu_set_t *mask)
>>>>  	for (c = 0; c < nr_cpus; c++) {
>>>>  		cpu = cpu_map->map[c]; /* map c index to online cpu index */
>>>>  		if (cpu__get_node(cpu) == node)
>>>> -			CPU_SET(cpu, mask);
>>>> +			set_bit(cpu, mask->bits);
>>>>  	}
>>>>  }
>>>>  
>>>> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>>> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>>>  {
>>>> -	CPU_ZERO(&map->affinity_mask);
>>>> +	map->affinity_mask.nbits = cpu__max_cpu();
>>>> +	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
>>>> +	if (!map->affinity_mask.bits)
>>>> +		return -1;
>>>
>>> hum, this one should be also behind (rec->opts.affinity != PERF_AFFINITY_SYS)
>>> condition, right? sry I haven't noticed that before..
>>
>> That has not been so far, but, probably like this:
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 7f573f646431..832d2cb94b2c 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -269,7 +269,8 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>>                 return -1;
>>         }
>>  
>> -       if (perf_mmap__setup_affinity_mask(map, mp)) {
>> +       if (mp->affinity != PERF_AFFINITY_SYS &&
>> +               perf_mmap__setup_affinity_mask(map, mp)) {
>>                 pr_debug2("failed to alloc mmap affinity mask, error %d\n",
>>                           errno);
>>                 return -1;
> 
> yes, that works too

Included into v5.

Thanks,
Alexey
