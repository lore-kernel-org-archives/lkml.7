Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A818FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393449AbfJPNJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:09:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:23340 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391745AbfJPNJb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 06:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="195595361"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.210.124]) ([10.254.210.124])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2019 06:09:27 -0700
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
 <6882f3ae-0f8d-5a01-7fd5-5b9f9c93f9ac@linux.intel.com>
 <20191016101543.GC15580@krava>
 <456b8e97-dc50-449c-9999-0bddef0e9c4c@linux.intel.com>
 <20191016125325.GA10222@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3085326b-c3f1-7475-7e43-db46a749aa37@linux.intel.com>
Date:   Wed, 16 Oct 2019 21:09:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016125325.GA10222@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 8:53 PM, Jiri Olsa wrote:
> On Wed, Oct 16, 2019 at 06:51:07PM +0800, Jin, Yao wrote:
>>
>>
>> On 10/16/2019 6:15 PM, Jiri Olsa wrote:
>>> On Tue, Oct 15, 2019 at 10:53:18PM +0800, Jin, Yao wrote:
>>>
>>> SNIP
>>>
>>>>>> +static struct block_header_column{
>>>>>> +	const char *name;
>>>>>> +	int width;
>>>>>> +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
>>>>>> +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV] = {
>>>>>> +		.name = "Sampled Cycles%",
>>>>>> +		.width = 15,
>>>>>> +	},
>>>>>> +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
>>>>>> +		.name = "Sampled Cycles",
>>>>>> +		.width = 14,
>>>>>> +	},
>>>>>> +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
>>>>>> +		.name = "Avg Cycles%",
>>>>>> +		.width = 11,
>>>>>> +	},
>>>>>> +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
>>>>>> +		.name = "Avg Cycles",
>>>>>> +		.width = 10,
>>>>>> +	},
>>>>>> +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
>>>>>> +		.name = "[Program Block Range]",
>>>>>> +		.width = 70,
>>>>>> +	},
>>>>>> +	[PERF_HPP_REPORT__BLOCK_DSO] = {
>>>>>> +		.name = "Shared Object",
>>>>>> +		.width = 20,
>>>>>> +	}
>>>>>>     };
>>>>>
>>>>> so we already have support for multiple columns,
>>>>> why don't you add those as 'struct sort_entry' objects?
>>>>>
>>>>
>>>> For 'struct sort_entry' objects, do you mean I should reuse the "sort_dso"
>>>> which has been implemented yet in util/sort.c?
>>>>
>>>> For other columns, it looks we can't reuse the existing sort_entry objects.
>>>
>>> I did not mean reuse, just add new sort entries
>>> to current sort framework
>>>
>>
>> Does it seem like what the c2c does?
> 
> well c2c has its own data output with multiline column titles,
> hence it has its own separate dimension stuff, but your code
> output is within the standard perf report right? single column
> output.. why couldn't you use just sort_entry ?
> 
> jirka
> 

No, my output is probably not within standard perf report. They are
totally 6 columns but only one column ('Sampled Cycles%') needs to be 
sorted. Other columns are not sorted. They only output some information.

For sort_entry, maybe the sorted column ('Sampled Cycles%') can use 
sort_entry, but others may not need it. So I don't know if I really need 
the sort_entry for my case.

I just feel maybe I still misunderstand what you have suggested. :(

Thanks
Jin Yao
