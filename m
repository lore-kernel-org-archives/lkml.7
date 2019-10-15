Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8EBECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfJOOxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:53:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:2652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732567AbfJOOxW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:53:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 07:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="225443107"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.195]) ([10.254.211.195])
  by fmsmga002.fm.intel.com with ESMTP; 15 Oct 2019 07:53:19 -0700
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
 <20191015084102.GA10951@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
Date:   Tue, 15 Oct 2019 22:53:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015084102.GA10951@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2019 4:41 PM, Jiri Olsa wrote:
> On Tue, Oct 15, 2019 at 01:33:48PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +enum {
>> +	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV,
>> +	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>> +	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>> +	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>> +	PERF_HPP_REPORT__BLOCK_RANGE,
>> +	PERF_HPP_REPORT__BLOCK_DSO,
>> +	PERF_HPP_REPORT__BLOCK_MAX_INDEX
>> +};
>> +
>> +static struct block_fmt block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
>> +
>> +static struct block_header_column{
>> +	const char *name;
>> +	int width;
>> +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
>> +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV] = {
>> +		.name = "Sampled Cycles%",
>> +		.width = 15,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
>> +		.name = "Sampled Cycles",
>> +		.width = 14,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
>> +		.name = "Avg Cycles%",
>> +		.width = 11,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
>> +		.name = "Avg Cycles",
>> +		.width = 10,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
>> +		.name = "[Program Block Range]",
>> +		.width = 70,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_DSO] = {
>> +		.name = "Shared Object",
>> +		.width = 20,
>> +	}
>>   };
> 
> so we already have support for multiple columns,
> why don't you add those as 'struct sort_entry' objects?
> 

For 'struct sort_entry' objects, do you mean I should reuse the 
"sort_dso" which has been implemented yet in util/sort.c?

For other columns, it looks we can't reuse the existing sort_entry objects.

> SNIP
> 
>> +{
>> +	struct block_hist *bh = &rep->block_hist;
>> +
>> +	get_block_hists(hists, bh, rep);
>> +	symbol_conf.report_individual_block = true;
>> +	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
>> +		       stdout, true);
>> +	hists__delete_entries(&bh->block_hists);
>> +	return 0;
>> +}
>> +
>>   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   					 struct report *rep,
>>   					 const char *help)
>> @@ -500,6 +900,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   			continue;
>>   
>>   		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>> +
>> +		if (rep->total_cycles) {
>> +			hists__fprintf_all_blocks(hists, rep);
> 
> so this call kicks all the block info setup/count/print, right?
> 

Yes, all in this call.

> I thingk it shouldn't be in the output code, but in the code before..
> from what I see you could count block_info counts during the sample
> processing, no?
>

In sample processing, we just get all symbols and account the cycles per 
symbol. We need to create/count the block_info at some points after the 
sample processing.

Maybe it's not very good to put block info setup/count/print in a call, 
but it's really not easy to process the block_info during the sample 
processing.

Thanks
Jin Yao

> jirka
> 
