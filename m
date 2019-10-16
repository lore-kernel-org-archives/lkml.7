Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383DECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B322067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbfJPAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:43:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:10490 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfJPAnJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:43:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 17:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="370639667"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.98]) ([10.239.196.98])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2019 17:43:06 -0700
Subject: Re: [PATCH] perf stat: Support --all-kernel/--all-user
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20191011050545.3899-1-yao.jin@linux.intel.com>
 <20191014144208.GC9700@krava> <20191014162339.GN19627@kernel.org>
 <2672b8ea-06f2-d828-3da0-da0e59f2eb9d@linux.intel.com>
 <20191015151121.GD25820@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cb21485a-cb69-c417-b584-49dde33442e0@linux.intel.com>
Date:   Wed, 16 Oct 2019 08:43:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015151121.GD25820@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2019 11:11 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 15, 2019 at 09:57:33AM +0800, Jin, Yao escreveu:
>>
>>
>> On 10/15/2019 12:23 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Oct 14, 2019 at 04:42:08PM +0200, Jiri Olsa escreveu:
>>>> On Fri, Oct 11, 2019 at 01:05:45PM +0800, Jin Yao wrote:
>>>>> perf record has supported --all-kernel / --all-user to configure all
>>>>> used events to run in kernel space or run in user space. But perf
>>>>> stat doesn't support these options.
>>>>>
>>>>> It would be useful to support these options in perf-stat too to keep
>>>>> the same semantics.
>>>>>
>>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>>
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>> What happens if one asks for both? From the patch only the --all-kernel
>>> will stick, right? Is that the behaviour for 'perf record'? Lemme see,
>>> as I recall having this discussion at that time...
>>>
>>> Yeah, same thing, and looking at that I wonder why we dong use
>>> perf_evsel__config() in 'perf stat'...
>>>
>>> Ok, I'm going to apply it.
>>>
>>
>> Hi Arnaldo,
>>
>> If we specify both, we will see the error.
> 
> Cool, I looked for this code and couldn't quickly spot it nor tried
> running with both to see what happened, my bad, thanks for replying and
> making sure that that is the behaviour.
>   
>> root@kbl:~# perf stat --all-kernel --all-user -a -- sleep 1
>>   Error: option `all-user' cannot be used with all-kernel
>>
>> root@kbl:~# perf record --all-kernel --all-user -a -- sleep 1
>>   Error: option `all-user' cannot be used with all-kernel
>>
>> For why I don't set them in perf_evsel__config, because perf_evsel__config
>> is called in record but not called in stat.
> 
> Ok, at some point we should try and check if we could make 'perf stat'
> use perf_evsel__config(), even if we have to separate what is shared
> into some __perf_evsel__config() that then gets called by 'perf stat'
> while the preexisting perf_evsel__config() calls it and does things
> that don't make sense for 'perf stat'.
>   

Yes, fully agree, that should be better. If we reconstruct the 
perf_evsel__config() and make it be shared by perf stat, perf record and 
others, that would be nice. :)

Thanks
Jin Yao

>> Thanks for reviewing and applying this patch.
> 
> You're welcome!
> 
> - Arnaldo
>   
>> Thanks
>> Jin Yao
>>
>>>> thanks,
>>>> jirka
>>>>
>>>>> ---
>>>>>    tools/perf/Documentation/perf-stat.txt |  6 ++++++
>>>>>    tools/perf/builtin-stat.c              |  6 ++++++
>>>>>    tools/perf/util/stat.c                 | 10 ++++++++++
>>>>>    tools/perf/util/stat.h                 |  2 ++
>>>>>    4 files changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>>>> index 930c51c01201..a9af4e440e80 100644
>>>>> --- a/tools/perf/Documentation/perf-stat.txt
>>>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>>>> @@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
>>>>>    Users who wants to get the actual value can apply --no-metric-only.
>>>>> +--all-kernel::
>>>>> +Configure all used events to run in kernel space.
>>>>> +
>>>>> +--all-user::
>>>>> +Configure all used events to run in user space.
>>>>> +
>>>>>    EXAMPLES
>>>>>    --------
>>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>>> index 468fc49420ce..c88d4e118409 100644
>>>>> --- a/tools/perf/builtin-stat.c
>>>>> +++ b/tools/perf/builtin-stat.c
>>>>> @@ -803,6 +803,12 @@ static struct option stat_options[] = {
>>>>>    	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>>>>>    		     "monitor specified metrics or metric groups (separated by ,)",
>>>>>    		     parse_metric_groups),
>>>>> +	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
>>>>> +			 "Configure all used events to run in kernel space.",
>>>>> +			 PARSE_OPT_EXCLUSIVE),
>>>>> +	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
>>>>> +			 "Configure all used events to run in user space.",
>>>>> +			 PARSE_OPT_EXCLUSIVE),
>>>>>    	OPT_END()
>>>>>    };
>>>>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>>>>> index ebdd130557fb..6822e4ffe224 100644
>>>>> --- a/tools/perf/util/stat.c
>>>>> +++ b/tools/perf/util/stat.c
>>>>> @@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
>>>>>    	if (config->identifier)
>>>>>    		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
>>>>> +	if (config->all_user) {
>>>>> +		attr->exclude_kernel = 1;
>>>>> +		attr->exclude_user   = 0;
>>>>> +	}
>>>>> +
>>>>> +	if (config->all_kernel) {
>>>>> +		attr->exclude_kernel = 0;
>>>>> +		attr->exclude_user   = 1;
>>>>> +	}
>>>>> +
>>>>>    	/*
>>>>>    	 * Disabling all counters initially, they will be enabled
>>>>>    	 * either manually by us or by kernel via enable_on_exec
>>>>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>>>>> index edbeb2f63e8d..081c4a5113c6 100644
>>>>> --- a/tools/perf/util/stat.h
>>>>> +++ b/tools/perf/util/stat.h
>>>>> @@ -106,6 +106,8 @@ struct perf_stat_config {
>>>>>    	bool			 big_num;
>>>>>    	bool			 no_merge;
>>>>>    	bool			 walltime_run_table;
>>>>> +	bool			 all_kernel;
>>>>> +	bool			 all_user;
>>>>>    	FILE			*output;
>>>>>    	unsigned int		 interval;
>>>>>    	unsigned int		 timeout;
>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>
> 
