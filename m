Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C4C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638A2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgAGOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:00:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:60315 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgAGOAt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:00:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 06:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="225676433"
Received: from xiangfum-mobl1.ccr.corp.intel.com (HELO [10.254.208.77]) ([10.254.208.77])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2020 06:00:46 -0800
Subject: Re: [PATCH v2 2/3] perf util: Flexible to set block info output
 formats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200106194525.12228-1-yao.jin@linux.intel.com>
 <20200106194525.12228-2-yao.jin@linux.intel.com>
 <20200107100637.GE290055@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <99bac5b2-4fa8-c3f4-e558-13b64de4378e@linux.intel.com>
Date:   Tue, 7 Jan 2020 22:00:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107100637.GE290055@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2020 6:06 PM, Jiri Olsa wrote:
> On Tue, Jan 07, 2020 at 03:45:24AM +0800, Jin Yao wrote:
>> Currently we use a predefined array to set the
>> block info output formats, it's fixed and inflexible.
>>
>> This patch adds two parameters "block_hpps" and "nr_hpps"
>> in block_info__create_report and other static functions,
>> in order to let user decide which columns to report and
>> with specified report ordering. It should be more flexible.
>>
>> Buffers will be allocated to contain the new fmts, of course,
>> we need to release them before perf exits.
>>
>>   v2:
>>   ---
>>   New patch created in v2.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c  | 25 +++++++++++---
>>   tools/perf/util/block-info.c | 64 ++++++++++++++++++++++++++----------
>>   tools/perf/util/block-info.h | 12 +++++--
>>   3 files changed, 76 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index de988589d99b..81ae1f862d11 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -104,6 +104,7 @@ struct report {
>>   	bool			symbol_ipc;
>>   	bool			total_cycles_mode;
>>   	struct block_report	*block_reports;
>> +	int			nr_block_reports;
>>   };
>>   
>>   static int report__config(const char *var, const char *value, void *cb)
>> @@ -503,7 +504,7 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>>   		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
>>   						 rep->min_percent, pos,
>>   						 &rep->session->header.env,
>> -						 &rep->annotation_opts);
>> +						 &rep->annotation_opts, true);
>>   		if (ret != 0)
>>   			return ret;
>>   	}
>> @@ -536,7 +537,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   		if (rep->total_cycles_mode) {
>>   			report__browse_block_hists(&rep->block_reports[i++].hist,
>>   						   rep->min_percent, pos,
>> -						   NULL, NULL);
>> +						   NULL, NULL, true);
>>   			continue;
>>   		}
>>   
>> @@ -966,8 +967,19 @@ static int __cmd_report(struct report *rep)
>>   	report__output_resort(rep);
>>   
>>   	if (rep->total_cycles_mode) {
>> +		int block_hpps[6] = {
>> +			PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>> +			PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>> +			PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>> +			PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>> +			PERF_HPP_REPORT__BLOCK_RANGE,
>> +			PERF_HPP_REPORT__BLOCK_DSO,
>> +		};
> 
> I'd understand this change if there was another place in the code using
> this, but it's not part of this patchset.. is it comming later?
> 

Yes, you guessed it. :)

I will have some follow-up patches, maybe post some weeks later.

Thanks
Jin Yao

> thanks,
> jirka
> 
