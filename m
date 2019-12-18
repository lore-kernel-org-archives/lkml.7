Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC443C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B8206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLRHSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:18:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfLRHSJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:18:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 18:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="212570134"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.84]) ([10.239.196.84])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2019 18:29:43 -0800
Subject: Re: [PATCH v3 1/3] perf report: Change sort order by a specified
 event in group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191212123337.23600-1-yao.jin@linux.intel.com>
 <20191216073113.GB18240@krava>
 <fcedac74-7fb4-1c3b-67a3-9af24c256f40@linux.intel.com>
 <20191217090600.GA24766@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e0b69c6b-40b9-5d7f-dcc9-39fc4ef52700@linux.intel.com>
Date:   Wed, 18 Dec 2019 10:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217090600.GA24766@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/2019 5:06 PM, Jiri Olsa wrote:
> On Tue, Dec 17, 2019 at 09:47:01AM +0800, Jin, Yao wrote:
>>
>>
>> On 12/16/2019 3:31 PM, Jiri Olsa wrote:
>>> On Thu, Dec 12, 2019 at 08:33:35PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/Documentation/perf-report.txt |   4 +
>>>>    tools/perf/builtin-report.c              |  10 +++
>>>>    tools/perf/ui/hist.c                     | 108 +++++++++++++++++++----
>>>>    tools/perf/util/symbol_conf.h            |   1 +
>>>>    4 files changed, 108 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>>>> index 8dbe2119686a..9ade613ef020 100644
>>>> --- a/tools/perf/Documentation/perf-report.txt
>>>> +++ b/tools/perf/Documentation/perf-report.txt
>>>> @@ -371,6 +371,10 @@ OPTIONS
>>>>    	Show event group information together. It forces group output also
>>>>    	if there are no groups defined in data file.
>>>> +--group-sort-idx::
>>>> +	Sort the output by the event at the index n in group. If n is invalid,
>>>> +	sort by the first event. WARNING: This should be used with --group.
>>>
>>> --group in record or report?
>>>
>>
>> This --group is in perf-report. So even if it's not created with -e '{}' in
>> perf-record, it still supports to show event information together.
>>
>>> you can also create groups with -e '{}', not just --group option
>>>
>>> I wonder you could check early on 'evlist->nr_groups' and fail
>>> if there's no group defined if the option is enabled
>>>
>>
>> Maybe we don't need to check that because it supports the case of no group
>> defined.
>>
>> For example,
>> perf record -e cycles,instructions
>> perf report --group --group-sort-idx 1 --stdio
> 
> hum, --group will force evlist->nr_groups == 1, right?
> 
> so we could warn/fail on (group-sort-idx && !evlist->nr_groups)
> 
> 

Yes, we can. I have added this checking in v4.

> SNIP
> 
>>
>> Thanks. Can we say something as following?
>>
>> --group-sort-idx::
>> 	Sort the output by the event at the index n in group. If n is invalid, sort
>> by the first event. It can support multiple groups with different amount of
>> events. WARNING: This should be used with perf report --group.
> 
> if the events are already grouped you dont need --group ;-) how about:
> 
> 	This should be used on grouped events.
> 

OK, yes, that's better. I just post v4 which includes this update.

Thanks
Jin Yao

> thanks,
> jirka
> 
