Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D6CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6634E20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfKEDlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 22:41:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:16885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfKEDlt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:41:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 19:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,269,1569308400"; 
   d="scan'208";a="212450762"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.21]) ([10.239.196.21])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2019 19:41:46 -0800
Subject: Re: [PATCH v5 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-6-yao.jin@linux.intel.com>
 <20191104140438.GI8251@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7bb97f3e-5a45-3ad0-df0f-6e72f8afa4da@linux.intel.com>
Date:   Tue, 5 Nov 2019 11:41:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104140438.GI8251@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2019 10:04 PM, Jiri Olsa wrote:
> On Wed, Oct 30, 2019 at 02:04:28PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +static int hists__fprintf_all_blocks(struct block_hist *bh)
>> +{
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
>>   {
>>   	struct evsel *pos;
>> +	int i = 0;
>>   
>>   	if (!quiet) {
>>   		fprintf(stdout, "#\n# Total Lost Samples: %" PRIu64 "\n#\n",
>> @@ -494,12 +509,20 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   	evlist__for_each_entry(evlist, pos) {
>>   		struct hists *hists = evsel__hists(pos);
>>   		const char *evname = perf_evsel__name(pos);
>> +		struct block_hist *block_hist;
>>   
>>   		if (symbol_conf.event_group &&
>>   		    !perf_evsel__is_group_leader(pos))
>>   			continue;
>>   
>>   		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>> +
>> +		if (rep->total_cycles_mode) {
>> +			block_hist = &rep->block_reports[i++].hist;
>> +			hists__fprintf_all_blocks(block_hist);
>> +			continue;
>> +		}
> 
> hum, you don't need evsel in here, please make separate function like
> perf_evlist__tty_browse_block_hists, where you will iterate directly
> block_reports[i++]
> 
> IMO the best would be to have report__browse_block_hists in block-info.c
> and handle all display modes from there
> 
> that's probably the last thing that would be moved to block-info.c
> other than that I think the patchset is ok
> 
> thanks,
> jirka
> 

Thanks Jiri!

I just posted v6 which moved more block display codes from 
builtin-report.c to block-info.c. That should let the code be more clear.

Thanks
Jin Yao
