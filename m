Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B4CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCD92086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfJUG5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:57:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:15746 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfJUG47 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:56:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 23:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="209381582"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.71]) ([10.239.196.71])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2019 23:56:57 -0700
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
Message-ID: <2a16a22e-5bdd-949b-480f-1c0956e13c14@linux.intel.com>
Date:   Mon, 21 Oct 2019 14:56:57 +0800
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

Hi Jiri,

I've being thinking how to use sort_entry but I have some troubles.

In v2, I used "struct perf_hpp_fmt" to pass extra argument. For example,

static int64_t block_cycles_cov_sort(struct perf_hpp_fmt *fmt,
				     struct hist_entry *left,
				     struct hist_entry *right)
{
	struct block_fmt *block_fmt = container_of(fmt, ...);
	struct report *rep = block_fmt->rep;
	...
}

But if I just use sort_entry, I can't pass extra argument (it's not a 
good idea to add more fields in struct hist_entry).

int64_t sort__xxx_sort(struct hist_entry *left,
		       struct hist_entry *right)

And for entry print it's similar, I can't pass extra argument in.

In v2,
static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
				  struct perf_hpp *hpp,
				  struct hist_entry *he)
{
	struct block_fmt *block_fmt = container_of(fmt,...);
	struct report *rep = block_fmt->rep;
	...
}

But for se_snprintf, I can't pass extra argument in.

hist_entry__xxx_snprintf(struct hist_entry *he, char *bf,
			 size_t size, unsigned int width)

That's why I feel headache for just using the sort_entry. :(

Thanks
Jin Yao
