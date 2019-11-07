Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48501C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2206621D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKGGTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:19:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:38815 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfKGGTO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:19:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 22:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="200948309"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.43]) ([10.239.196.43])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2019 22:19:11 -0800
Subject: Re: [PATCH v6 7/7] perf report: Sort by sampled cycles percent per
 block for tui
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191105033611.25493-1-yao.jin@linux.intel.com>
 <20191105033611.25493-8-yao.jin@linux.intel.com>
 <20191106210106.GA12156@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cddb7e55-ae98-62c7-db9f-70e6fc734579@linux.intel.com>
Date:   Thu, 7 Nov 2019 14:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106210106.GA12156@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2019 5:01 AM, Jiri Olsa wrote:
> On Tue, Nov 05, 2019 at 11:36:11AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c    | 27 ++++++++++++---
>>   tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++++-
>>   tools/perf/ui/browsers/hists.h |  2 ++
>>   tools/perf/util/block-info.c   | 12 +++++++
>>   tools/perf/util/block-info.h   |  3 ++
>>   tools/perf/util/hist.h         | 12 +++++++
>>   6 files changed, 112 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 7a8b0be8f09a..af5a57d06f12 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -485,6 +485,22 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
>>   	return ret + fprintf(fp, "\n#\n");
>>   }
>>   
>> +static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>> +					       struct report *rep)
>> +{
>> +	struct evsel *pos;
>> +	int i = 0, ret;
>> +
>> +	evlist__for_each_entry(evlist, pos) {
>> +		ret = report__tui_browse_block_hists(&rep->block_reports[i++].hist,
>> +						     rep->min_percent, pos);
>> +		if (ret != 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   					 struct report *rep,
>>   					 const char *help)
>> @@ -595,6 +611,11 @@ static int report__browse_hists(struct report *rep)
>>   
>>   	switch (use_browser) {
>>   	case 1:
>> +		if (rep->total_cycles_mode) {
>> +			ret = perf_evlist__tui_block_hists_browse(evlist, rep);
>> +			break;
>> +		}
> 
> it's good that most of it is in the block-info.c,
> however what I mean was to have a single report
> function for rep->total_cycles_mode, like:
> 
> 	report__browse_block_hists()
> 	{
> 		switch (use_browser) {
> 		case 1:
> 			ret = perf_evlist__tui_block_hists_browse(evlist, rep);
> 			break;
> 		case 0:
> 			ret = perf_evlist__tty_block_hists_browse(evlist, rep);
> 			break;
> 		...
> 	}
> 
> preferable in block-info.c as well
> 
> which would be hooked in report__browse_hists:
> 
> 	report__browse_hists()
> 	{
> 		if (rep->total_cycles_mode)
> 			return report__browse_block_hists();
> 		...
> 	}
> 

If we move all block implementations from builtin-report.c to 
block-info.c, one difficulty is that we can't reuse some codes in 
builtin-report.c. For example, reuse the function which prints the event 
stats (hists__fprintf_nr_sample_events)

# Total Lost Samples: 0
#
# Samples: 2M of event 'cycles'
# Event count (approx.): 2753248

So I want to achieve a balance. I move most of block codes to 
builtin-report.c but I have to keep a bit of them in builtin-report.c. I 
will implement that in v7.

> plus below
> 
> SNIP
> 
>> +
>> +static int block_hists_browser__title(struct hist_browser *browser, char *bf,
>> +				      size_t size)
>> +{
>> +	struct hists *hists = evsel__hists(browser->block_evsel);
>> +	const char *evname = perf_evsel__name(browser->block_evsel);
>> +	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
>> +	int ret;
>> +
>> +	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
>> +	if (evname)
>> +		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
>> +
>> +	return 0;
>> +}
>> +
>> +int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>> +			   float min_percent)
>> +{
>> +	struct hists *hists = &bh->block_hists;
>> +	struct hist_browser *browser;
>> +	int key = -1;
>> +	static const char help[] =
>> +	" q             Quit \n";
>> +
>> +	browser = hist_browser__new(hists);
>> +	if (!browser)
>> +		return -1;
>> +
>> +	browser->block_evsel = evsel;
>> +	browser->title = block_hists_browser__title;
>> +	browser->min_pcnt = min_percent;
>> +
>> +	/* reset abort key so that it can get Ctrl-C as a key */
>> +	SLang_reset_tty();
>> +	SLang_init_tty(0, 0, 0);
>> +
>> +	while (1) {
>> +		key = hist_browser__run(browser, "? - help", true);
>> +
>> +		switch (key) {
>> +		case 'q':
>> +			goto out;
>> +		case '?':
>> +			ui_browser__help_window(&browser->b, help);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +out:
>> +	hist_browser__delete(browser);
>> +	return 0;
>> +}
> 
> also could this go to block-info.c as well?
> 
> thanks,
> jirka
> 

I will move them to block-info.c

Thanks
Jin Yao
