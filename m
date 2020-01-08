Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9FC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9000205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHHZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:25:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:32482 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgAHHZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:25:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 23:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="254135755"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.32]) ([10.239.196.32])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2020 23:25:25 -0800
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
Date:   Wed, 8 Jan 2020 15:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108065844.4030-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2020 2:58 PM, Kajol Jain wrote:
> Commit f01642e4912b ("perf metricgroup: Support multiple
> events for metricgroup") introduced support for multiple events
> in a metric group. But with the current upstream, metric events
> names are not printed properly incase we try to run multiple
> metric groups with overlapping event.
> 
> With current upstream version, incase of overlapping metric events
> issue is, we always start our comparision logic from start.
> So, the events which already matched with some metric group also
> take part in comparision logic. Because of that when we have overlapping
> events, we end up matching current metric group event with already matched
> one.
> 
> For example, in skylake machine we have metric event CoreIPC and
> Instructions. Both of them need 'inst_retired.any' event value.
> As events in Instructions is subset of events in CoreIPC, they
> endup in pointing to same 'inst_retired.any' value.
> 
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>   Performance counter stats for 'CPU(s) 0':
> 
>       1,254,992,790      inst_retired.any          # 1254992790.0
> 						    Instructions
>                                                    #      1.3 CoreIPC
>         977,172,805      cycles
>       1,254,992,756      inst_retired.any
> 
>         1.000802596 seconds time elapsed
> 
> command:# sudo ./perf stat -M UPI,IPC sleep 1
> 
>     Performance counter stats for 'sleep 1':
> 
>             948,650      uops_retired.retire_slots
>             866,182      inst_retired.any          #      0.7 IPC
>             866,182      inst_retired.any
>           1,175,671      cpu_clk_unhalted.thread
> 
> Patch fixes the issue by adding a static variable 'iterator_perf_evlist'
> to keep track of events which already matched with some group. It points
> to event in perf_evlist from where next match should start. Because we
> need to make sure, we match correct set of events belongs to
> corresponding metric group.
> 
> With this patch:
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>   Performance counter stats for 'CPU(s) 0':
> 
>         149,481,533      inst_retired.any          #      0.8 CoreIPC
>         186,244,218      cycles
>         149,479,362      inst_retired.any          # 149479362.0
> 							Instructions
> 
>         1.001655885 seconds time elapsed
> 
> command:# ./perf stat -M UPI,IPC sleep 1
>   Performance counter stats for 'CPU(s) 0':
> 
>          16,858,849      uops_retired.retire_slots #      1.3 UPI
>          12,529,178      inst_retired.any
>          12,529,558      inst_retired.any          #      0.3 IPC
>          39,936,071      cpu_clk_unhalted.thread
> 
>         1.001413978 seconds time elapsed
> 
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   tools/perf/util/metricgroup.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 35e151b8359b..58889b0496fb 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -90,16 +90,21 @@ struct egroup {
>   	const char *metric_unit;
>   };
>   
> +static int iterator_perf_evlist;
> +
>   static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   				      const char **ids,
>   				      int idnum,
>   				      struct evsel **metric_events)
>   {
>   	struct evsel *ev;
> -	int i = 0;
> +	int i = 0, j = 0;
>   	bool leader_found;
>   
>   	evlist__for_each_entry (perf_evlist, ev) {
> +		j++;
> +		if (j <= iterator_perf_evlist)
> +			continue;
>   		if (!strcmp(ev->name, ids[i])) {
>   			if (!metric_events[i])
>   				metric_events[i] = ev;
> @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			}
>   		}
>   	}
> +	iterator_perf_evlist = j;
>   
>   	return metric_events[0];
>   }
> 

Thanks for reporting and fixing this issue.

I just have one question, do we really need a *static variable* to track 
the matched events? Perhaps using an input parameter?

Thanks
Jin Yao

