Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12704C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFD206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHMAku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:40:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:25093 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfHMAku (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:40:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 17:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="259963261"
Received: from unknown (HELO [10.239.196.24]) ([10.239.196.24])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 17:40:47 -0700
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
 <20190812083543.GA11752@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <959b3b52-269c-8f23-9ac7-a881334ca904@linux.intel.com>
Date:   Tue, 13 Aug 2019 08:40:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812083543.GA11752@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2019 4:35 PM, Jiri Olsa wrote:
> On Sat, Aug 10, 2019 at 07:30:29AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   static int process_block_per_sym(struct hist_entry *he)
>> @@ -684,6 +694,21 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
>>   	return NULL;
>>   }
>>   
>> +static void init_spark_values(unsigned long *svals, int num)
>> +{
>> +	for (int i = 0; i < num; i++)
>> +		svals[i] = 0;
>> +}
>> +
>> +static void update_spark_value(unsigned long *svals, int num,
>> +			       struct stats *stats, u64 val)
>> +{
>> +	int n = stats->n;
>> +
>> +	if (n < num)
>> +		svals[n] = val;
>> +}
>> +
>>   static void compute_cycles_diff(struct hist_entry *he,
>>   				struct hist_entry *pair)
>>   {
>> @@ -692,6 +717,23 @@ static void compute_cycles_diff(struct hist_entry *he,
>>   		pair->diff.cycles =
>>   			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
>>   			he->block_info->cycles_aggr / he->block_info->num_aggr;
>> +
> 
> should below code be executed only for show_noisy?
> 
> jirka
> 

Oh, yes, following code should be executed only when show_noisy is 
enabled. Thanks for pointing out this issue. I will refine the code.

Thanks
Jin Yao

>> +		init_stats(&pair->diff.stats);
>> +		init_spark_values(pair->diff.svals, NUM_SPARKS);
>> +
>> +		for (int i = 0; i < pair->block_info->num; i++) {
>> +			u64 val;
>> +
>> +			if (i >= he->block_info->num || i >= NUM_SPARKS)
>> +				break;
>> +
>> +			val = labs(pair->block_info->cycles_spark[i] -
>> +				     he->block_info->cycles_spark[i]);
>> +
>> +			update_spark_value(pair->diff.svals, NUM_SPARKS,
>> +					   &pair->diff.stats, val);
>> +			update_stats(&pair->diff.stats, val);
>> +		}
>>   	}
>>   }
> 
> SNIP
> 
