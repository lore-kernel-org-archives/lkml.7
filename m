Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAFBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475E12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgAGN56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:57:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:33814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGN56 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:57:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 05:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="225675747"
Received: from xiangfum-mobl1.ccr.corp.intel.com (HELO [10.254.208.77]) ([10.254.208.77])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2020 05:57:56 -0800
Subject: Re: [PATCH v2 1/3] perf util: Move block_pair_cmp to block-info
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200106194525.12228-1-yao.jin@linux.intel.com>
 <20200107095733.GD290055@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2e4be21f-cd40-7d7f-4894-b9245de723e9@linux.intel.com>
Date:   Tue, 7 Jan 2020 21:57:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107095733.GD290055@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2020 5:57 PM, Jiri Olsa wrote:
> On Tue, Jan 07, 2020 at 03:45:23AM +0800, Jin Yao wrote:
>> block_pair_cmp() is a function which is used to compare
>> two blocks. Moving it from builtin-diff.c to block-info.c
>> to let it be used by other builtins.
>>
>> In block_pair_cmp, there is a minor change. It checks valid
>> for map, dso and sym first. If they are invalid, we will not
>> compare the address because the address might not make sense.
> 
> please separate the change as well, it's hard to track
> what you did when the whole function is moved
> 

Got it, thanks! I will separate this too.

>>
>>   v2:
>>   ---
>>   New patch created in v2
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-diff.c    | 17 -----------------
>>   tools/perf/util/block-info.c | 23 +++++++++++++++++++++++
>>   tools/perf/util/block-info.h |  2 ++
>>   3 files changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>> index f8b6ae557d8b..5ff1e21082cb 100644
>> --- a/tools/perf/builtin-diff.c
>> +++ b/tools/perf/builtin-diff.c
>> @@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
>>   	bh->valid = true;
>>   }
>>   
>> -static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
>> -{
>> -	struct block_info *bi_a = a->block_info;
>> -	struct block_info *bi_b = b->block_info;
>> -	int cmp;
>> -
>> -	if (!bi_a->sym || !bi_b->sym)
>> -		return -1;
>> -
>> -	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
>> -
>> -	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
>> -		return 0;
>> -
>> -	return -1;
>> -}
>> -
>>   static struct hist_entry *get_block_pair(struct hist_entry *he,
>>   					 struct hists *hists_pair)
>>   {
>> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
>> index c4b030bf6ec2..18a445938681 100644
>> --- a/tools/perf/util/block-info.c
>> +++ b/tools/perf/util/block-info.c
>> @@ -475,3 +475,26 @@ float block_info__total_cycles_percent(struct hist_entry *he)
>>   
>>   	return 0.0;
>>   }
>> +
>> +int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he)
>> +{
>> +	struct block_info *bi_p = pair->block_info;
>> +	struct block_info *bi_h = he->block_info;
>> +	struct map_symbol *ms_p = &pair->ms;
>> +	struct map_symbol *ms_h = &he->ms;
>> +	int cmp;
>> +
>> +	if (!ms_p->map || !ms_p->map->dso || !ms_p->sym ||
>> +	    !ms_h->map || !ms_h->map->dso || !ms_h->sym) {
>> +		return -1;
>> +	}
>> +
>> +	cmp = strcmp(ms_p->sym->name, ms_h->sym->name);
>> +	if (cmp)
>> +		return -1;
> 
> should this return cmp? also you don't mention this change in the changelog
> 

Yes, return cmp should be OK.

It's changed from "strcmp(bi_a->sym->name, bi_b->sym->name)" to 
"strcmp(ms_p->sym->name, ms_h->sym->name)" is because we don't need an 
additional checking for bi_a->sym and bi_b->sym.

If we use "strcmp(bi_a->sym->name, bi_b->sym->name)" here, I think we'd 
better check the sym first. I will mention that in changelog.

Thanks
Jin Yao

> thanks,
> jirka
> 
