Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E85EC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C81C217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfJOB5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:57:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:43047 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfJOB5g (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:57:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 18:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; 
   d="scan'208";a="220278332"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.81]) ([10.239.196.81])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2019 18:57:33 -0700
Subject: Re: [PATCH] perf stat: Support --all-kernel/--all-user
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20191011050545.3899-1-yao.jin@linux.intel.com>
 <20191014144208.GC9700@krava> <20191014162339.GN19627@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2672b8ea-06f2-d828-3da0-da0e59f2eb9d@linux.intel.com>
Date:   Tue, 15 Oct 2019 09:57:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014162339.GN19627@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2019 12:23 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 14, 2019 at 04:42:08PM +0200, Jiri Olsa escreveu:
>> On Fri, Oct 11, 2019 at 01:05:45PM +0800, Jin Yao wrote:
>>> perf record has supported --all-kernel / --all-user to configure all
>>> used events to run in kernel space or run in user space. But perf
>>> stat doesn't support these options.
>>>
>>> It would be useful to support these options in perf-stat too to keep
>>> the same semantics.
>>>
>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> What happens if one asks for both? From the patch only the --all-kernel
> will stick, right? Is that the behaviour for 'perf record'? Lemme see,
> as I recall having this discussion at that time...
> 
> Yeah, same thing, and looking at that I wonder why we dong use
> perf_evsel__config() in 'perf stat'...
> 
> Ok, I'm going to apply it.
>

Hi Arnaldo,

If we specify both, we will see the error.

root@kbl:~# perf stat --all-kernel --all-user -a -- sleep 1
  Error: option `all-user' cannot be used with all-kernel

root@kbl:~# perf record --all-kernel --all-user -a -- sleep 1
  Error: option `all-user' cannot be used with all-kernel

For why I don't set them in perf_evsel__config, because 
perf_evsel__config is called in record but not called in stat.

Thanks for reviewing and applying this patch.

Thanks
Jin Yao

>> thanks,
>> jirka
>>
>>> ---
>>>   tools/perf/Documentation/perf-stat.txt |  6 ++++++
>>>   tools/perf/builtin-stat.c              |  6 ++++++
>>>   tools/perf/util/stat.c                 | 10 ++++++++++
>>>   tools/perf/util/stat.h                 |  2 ++
>>>   4 files changed, 24 insertions(+)
>>>
>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>> index 930c51c01201..a9af4e440e80 100644
>>> --- a/tools/perf/Documentation/perf-stat.txt
>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>> @@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
>>>   
>>>   Users who wants to get the actual value can apply --no-metric-only.
>>>   
>>> +--all-kernel::
>>> +Configure all used events to run in kernel space.
>>> +
>>> +--all-user::
>>> +Configure all used events to run in user space.
>>> +
>>>   EXAMPLES
>>>   --------
>>>   
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index 468fc49420ce..c88d4e118409 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -803,6 +803,12 @@ static struct option stat_options[] = {
>>>   	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>>>   		     "monitor specified metrics or metric groups (separated by ,)",
>>>   		     parse_metric_groups),
>>> +	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
>>> +			 "Configure all used events to run in kernel space.",
>>> +			 PARSE_OPT_EXCLUSIVE),
>>> +	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
>>> +			 "Configure all used events to run in user space.",
>>> +			 PARSE_OPT_EXCLUSIVE),
>>>   	OPT_END()
>>>   };
>>>   
>>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>>> index ebdd130557fb..6822e4ffe224 100644
>>> --- a/tools/perf/util/stat.c
>>> +++ b/tools/perf/util/stat.c
>>> @@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
>>>   	if (config->identifier)
>>>   		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
>>>   
>>> +	if (config->all_user) {
>>> +		attr->exclude_kernel = 1;
>>> +		attr->exclude_user   = 0;
>>> +	}
>>> +
>>> +	if (config->all_kernel) {
>>> +		attr->exclude_kernel = 0;
>>> +		attr->exclude_user   = 1;
>>> +	}
>>> +
>>>   	/*
>>>   	 * Disabling all counters initially, they will be enabled
>>>   	 * either manually by us or by kernel via enable_on_exec
>>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>>> index edbeb2f63e8d..081c4a5113c6 100644
>>> --- a/tools/perf/util/stat.h
>>> +++ b/tools/perf/util/stat.h
>>> @@ -106,6 +106,8 @@ struct perf_stat_config {
>>>   	bool			 big_num;
>>>   	bool			 no_merge;
>>>   	bool			 walltime_run_table;
>>> +	bool			 all_kernel;
>>> +	bool			 all_user;
>>>   	FILE			*output;
>>>   	unsigned int		 interval;
>>>   	unsigned int		 timeout;
>>> -- 
>>> 2.17.1
>>>
> 
