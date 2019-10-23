Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24EBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668B20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391969AbfJWMyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:54:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:36025 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390962AbfJWMyF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:54:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 05:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196768236"
Received: from shilongz-mobl.ccr.corp.intel.com (HELO [10.254.210.50]) ([10.254.210.50])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 05:54:03 -0700
Subject: Re: [PATCH v3 5/5] perf report: Sort by sampled cycles percent per
 block for tui
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-6-yao.jin@linux.intel.com>
 <20191023113656.GP22919@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <67f89552-dec9-e42e-0e3c-b55d9f5b92f4@linux.intel.com>
Date:   Wed, 23 Oct 2019 20:54:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023113656.GP22919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 7:36 PM, Jiri Olsa wrote:
> On Tue, Oct 22, 2019 at 04:07:10PM +0800, Jin Yao wrote:
>> Previous patch has implemented a new sort option "total_cycles".
>> But there was only stdio mode supported.
>>
>> This patch supports the tui mode and support '--percent-limit'.
>>
>> For example,
>>
>>   perf record -b ./div
>>   perf report -s total_cycles --percent-limit 1
>>
>>   # Samples: 2753248 of event 'cycles'
>>   Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
>>            26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
>>            15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
>>             5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
>>             4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
>>             4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
>>             3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
>>             3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
>>             3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
>>             2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
>>             2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
>>             2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
>>             2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
>>             2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
>>             2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
>>             1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
>>             1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
>>             1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so
>>
>>   v3:
>>   ---
>>   Minor change since the function name is changed:
>>   block_total_cycles_percent -> block_info__total_cycles_percent
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c    | 30 +++++++++++++---
>>   tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++++-
>>   tools/perf/ui/browsers/hists.h |  2 ++
>>   tools/perf/util/hist.h         | 12 +++++++
>>   4 files changed, 101 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index dbae1812ce47..707512f177cb 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -800,6 +800,27 @@ static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
>>   	return 0;
>>   }
>>   
>> +static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>> +					       struct report *rep)
>> +{
>> +	struct block_hist *bh = &rep->block_hist;
>> +	struct evsel *pos;
>> +	int ret;
>> +
>> +	evlist__for_each_entry(evlist, pos) {
>> +		struct hists *hists = evsel__hists(pos);
>> +
>> +		get_block_hists(hists, bh, rep);
> 
> same here, this is display function, compute the data before
> 
> thanks,
> jirka
>

That will be a little bit complicated. But OK, I will try that.

Thanks
Jin Yao

>> +		symbol_conf.report_individual_block = true;
>> +		ret = block_hists_tui_browse(bh, pos, rep->min_percent);
>> +		hists__delete_entries(&bh->block_hists);
>> +		if (ret != 0)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> SNIP
> 
