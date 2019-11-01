Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13706CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A121906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKANFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:05:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:18063 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKANFS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:05:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 06:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,255,1569308400"; 
   d="scan'208";a="211781192"
Received: from xueyaoli-mobl.ccr.corp.intel.com (HELO [10.254.210.166]) ([10.254.210.166])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 06:05:16 -0700
Subject: Re: [PATCH v5 7/7] perf report: Sort by sampled cycles percent per
 block for tui
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-8-yao.jin@linux.intel.com>
 <20191101083426.GC2172@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <71901aab-bb1a-219a-a85c-e36dd66201a7@linux.intel.com>
Date:   Fri, 1 Nov 2019 21:05:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101083426.GC2172@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2019 4:34 PM, Jiri Olsa wrote:
> On Wed, Oct 30, 2019 at 02:04:30PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +
>>   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   					 struct report *rep,
>>   					 const char *help)
>> @@ -605,6 +624,11 @@ static int report__browse_hists(struct report *rep)
>>   
>>   	switch (use_browser) {
>>   	case 1:
>> +		if (rep->total_cycles_mode) {
>> +			ret = perf_evlist__tui_block_hists_browse(evlist, rep);
>> +			break;
>> +		}
> 
> does this have sense only for cycles event? what if I do:
>    # perf record -b -e cycles,cache-misses
> 
> jirka
> 

It can report both cycles and cache-misses. But I use a simple way.

When I run 'perf report --total-cycles', it displays the window for the 
first event ('cycles') by default. For example,

# Samples: 8384 of event 'cycles'
Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
...

Once I press 'q' to quit current window, it then switches to another 
window for the second event ('cache-misses'). For example,

# Samples: 7072 of event 'cache-misses'
Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
...

Thanks
Jin Yao

>> +
>>   		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
>>   						    rep->min_percent,
>>   						    &session->header.env,
>> @@ -1408,12 +1432,8 @@ int cmd_report(int argc, const char **argv)
>>   	if (report.total_cycles_mode) {
>>   		if (sort__mode != SORT_MODE__BRANCH)
>>   			report.total_cycles_mode = false;
>> -		else if (!report.use_stdio) {
>> -			pr_err("Error: --total-cycles can be only used together with --stdio\n");
>> -			goto error;
>> -		} else {
>> +		else
>>   			sort_order = "sym";
>> -		}
>>   	}
>>   
>>   	if (strcmp(input_name, "-") != 0)
> 
> SNIP
> 
