Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C31218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCOXIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:08:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:22732 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCOXIL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:08:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 16:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="155476321"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.155]) ([10.254.211.155])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 16:08:08 -0700
Subject: Re: [PATCH v1 2/3] perf stat: Support coresum event qualifier
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
 <1552665856-27741-3-git-send-email-yao.jin@linux.intel.com>
 <20190315133453.GB5200@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b2ba589e-d01a-18a1-57cc-3a6626961114@linux.intel.com>
Date:   Sat, 16 Mar 2019 07:08:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315133453.GB5200@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2019 9:34 PM, Jiri Olsa wrote:
> On Sat, Mar 16, 2019 at 12:04:15AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +static void print_counter_aggrdata(struct perf_stat_config *config,
>> +				   struct perf_evsel *counter, int s,
>> +				   char *prefix, bool metric_only,
>> +				   bool *first)
>> +{
>> +	struct aggr_data ad;
>> +	FILE *output = config->output;
>> +	u64 ena, run, val;
>> +	int id, nr;
>> +	double uval;
>> +
>> +	ad.id = id = config->aggr_map->map[s];
>> +	ad.val = ad.ena = ad.run = 0;
>> +	ad.nr = 0;
>> +	if (!collect_data(config, counter, aggr_cb, &ad))
>> +		return;
>> +
>> +	nr = ad.nr;
>> +	ena = ad.ena;
>> +	run = ad.run;
>> +	val = ad.val;
>> +	if (*first && metric_only) {
>> +		*first = false;
>> +		aggr_printout(config, counter, id, nr);
>> +	}
>> +	if (prefix && !metric_only)
>> +		fprintf(output, "%s", prefix);
>> +
>> +	uval = val * counter->scale;
>> +	printout(config, id, nr, counter, uval, prefix,
>> +		 run, ena, 1.0, &rt_stat);
>> +	if (!metric_only)
>> +		fputc('\n', output);
>> +}
> 
> plese put the factoring out of print_counter_aggrdata function
> into separate patch
> 
> thanks,
> jirka
> 
> 

OK!

Thanks
Jin Yao

>> +
>>   static void print_aggr(struct perf_stat_config *config,
>>   		       struct perf_evlist *evlist,
>>   		       char *prefix)
>> @@ -606,9 +649,7 @@ static void print_aggr(struct perf_stat_config *config,
>>   	bool metric_only = config->metric_only;
>>   	FILE *output = config->output;
>>   	struct perf_evsel *counter;
>> -	int s, id, nr;
>> -	double uval;
>> -	u64 ena, run, val;
>> +	int s;
>>   	bool first;
>>   
>>   	if (!(config->aggr_map || config->aggr_get_id))
>> @@ -621,36 +662,16 @@ static void print_aggr(struct perf_stat_config *config,
>>   	 * Without each counter has its own line.
>>   	 */
>>   	for (s = 0; s < config->aggr_map->nr; s++) {
>> -		struct aggr_data ad;
>>   		if (prefix && metric_only)
>>   			fprintf(output, "%s", prefix);
>>   
>> -		ad.id = id = config->aggr_map->map[s];
>>   		first = true;
>>   		evlist__for_each_entry(evlist, counter) {
>>   			if (is_duration_time(counter))
>>   				continue;
>> -
>> -			ad.val = ad.ena = ad.run = 0;
>> -			ad.nr = 0;
>> -			if (!collect_data(config, counter, aggr_cb, &ad))
>> -				continue;
>> -			nr = ad.nr;
>> -			ena = ad.ena;
>> -			run = ad.run;
>> -			val = ad.val;
>> -			if (first && metric_only) {
>> -				first = false;
>> -				aggr_printout(config, counter, id, nr);
>> -			}
>> -			if (prefix && !metric_only)
>> -				fprintf(output, "%s", prefix);
>> -
>> -			uval = val * counter->scale;
>> -			printout(config, id, nr, counter, uval, prefix,
>> -				 run, ena, 1.0, &rt_stat);
>> -			if (!metric_only)
>> -				fputc('\n', output);
>> +			print_counter_aggrdata(config, counter, s,
>> +					       prefix, metric_only,
>> +					       &first);
> 
> SNIP
> 
