Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F821855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCNORP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:17:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:53609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfCNORP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:17:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 07:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="151689620"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.155]) ([10.254.211.155])
  by fmsmga002.fm.intel.com with ESMTP; 14 Mar 2019 07:17:12 -0700
Subject: Re: [PATCH] perf annotate: Remove hist__account_cycles from callback
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552422174-27622-1-git-send-email-yao.jin@linux.intel.com>
 <20190314120434.GD4406@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <15be5d07-0d80-973b-d58b-e71b57018c07@linux.intel.com>
Date:   Thu, 14 Mar 2019 22:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314120434.GD4406@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2019 8:04 PM, Jiri Olsa wrote:
> On Wed, Mar 13, 2019 at 04:22:54AM +0800, Jin Yao wrote:
>> The hist__account_cycles is executed when the hist_iter__branch_callback
>> is called. But it looks it's not necessary. In hist__account_cycles, it
>> already walks on all branch entries.
>>
>> This patch moves the hist__account_cycles out of callback, now the data
>> processing is much faster than before.
>>
>> For example,
>> perf record -b ...
>> perf annotate
>>
>> The before/after output should be no change.
> 
> so in the old code it was called multiple times per sample,
> while after your change it's called just once per sample
> 
> it increases cycles stats for symbol, so it's strange
> the behaviour is the same.. could you please exaplin this
> in more detail?
> 

In __symbol__account_cycles,
ch[offset].num_aggr++;
ch[offset].cycles_aggr += cycles;

In annotation__compute_ipc,
al = notes->offsets[offset];
al->cycles = ch->cycles_aggr / ch->num_aggr;

So the num_aggr and cycles_aggr are both increased n times, then the 
final result is the same.

>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-annotate.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 67f9d9f..77deb3a 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>>   	struct perf_evsel *evsel = iter->evsel;
>>   	int err;
>>   
>> -	hist__account_cycles(sample->branch_stack, al, sample, false);
>> -
> 
> there's similar code in perf report, could you please cover
> that as well?
> 

Sure, let me have a try.

Thanks
Jin Yao

> thanks,
> jirka
> 
>>   	bi = he->branch_info;
>>   	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
>>   
>> @@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
>>   	if (a.map != NULL)
>>   		a.map->dso->hit = 1;
>>   
>> +	hist__account_cycles(sample->branch_stack, al, sample, false);
>> +
>>   	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
>>   	return ret;
>>   }
>> -- 
>> 2.7.4
>>
