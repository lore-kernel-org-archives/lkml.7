Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B17C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1459D21743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409187AbfFLMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:54:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:25054 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfFLMyG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:54:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 05:54:06 -0700
X-ExtLoop1: 1
Received: from hjin5-mobl1.ccr.corp.intel.com (HELO [10.254.211.209]) ([10.254.211.209])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2019 05:54:04 -0700
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
 <20190605114417.GB5868@krava>
 <4bbc5085-c8b0-5e36-419c-6ee754186027@linux.intel.com>
 <20190611085606.GA11510@krava>
 <c46ee356-9765-42cc-8cff-221bacb63c3d@linux.intel.com>
 <20190612074417.GC6455@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c9d5e3b1-63a1-c87d-32c2-4c3b25642d1a@linux.intel.com>
Date:   Wed, 12 Jun 2019 20:54:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612074417.GC6455@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2019 3:44 PM, Jiri Olsa wrote:
> On Wed, Jun 12, 2019 at 02:11:44PM +0800, Jin, Yao wrote:
>>
>>
>> On 6/11/2019 4:56 PM, Jiri Olsa wrote:
>>> On Sat, Jun 08, 2019 at 07:41:47PM +0800, Jin, Yao wrote:
>>>>
>>>>
>>>> On 6/5/2019 7:44 PM, Jiri Olsa wrote:
>>>>> On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:
>>>>>
>>>>> SNIP
>>>>>
>>>>>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>>>>>> index 43623fa..d1641da 100644
>>>>>> --- a/tools/perf/util/sort.h
>>>>>> +++ b/tools/perf/util/sort.h
>>>>>> @@ -79,6 +79,9 @@ struct hist_entry_diff {
>>>>>>     		/* HISTC_WEIGHTED_DIFF */
>>>>>>     		s64	wdiff;
>>>>>> +
>>>>>> +		/* PERF_HPP_DIFF__CYCLES */
>>>>>> +		s64	cycles;
>>>>>>     	};
>>>>>>     };
>>>>>> @@ -143,6 +146,9 @@ struct hist_entry {
>>>>>>     	struct branch_info	*branch_info;
>>>>>>     	long			time;
>>>>>>     	struct hists		*hists;
>>>>>> +	void			*block_hists;
>>>>>> +	int			block_idx;
>>>>>> +	int			block_num;
>>>>>>     	struct mem_info		*mem_info;
>>>>>>     	struct block_info	*block_info;
>>>>>
>>>>> could you please not add the new block* stuff in here,
>>>>> and instead use the "c2c model" and use yourr own struct
>>>>> on top of hist_entry? we are trying to librarize this
>>>>> stuff and keep only necessary things in here..
>>>>>
>>>>> you're already using hist_entry_ops, so should be easy
>>>>>
>>>>> something like:
>>>>>
>>>>> 	struct block_hist_entry {
>>>>> 		void			*block_hists;
>>>>> 		int			block_idx;
>>>>> 		int			block_num;
>>>>> 		struct block_info	*block_info;
>>>>>
>>>>> 		struct hist_entry	he;
>>>>> 	};
>>>>>
>>>>>
>>>>>
>>>>> jirka
>>>>>
>>>>
>>>> Hi Jiri,
>>>>
>>>> After more considerations, maybe I can't move these stuffs from hist_entry
>>>> to block_hist_entry.
>>>
>>> why?
>>>
>>>>
>>>> Actually we use 2 kinds of hist_entry in this patch series. On kind of
>>>> hist_entry is for symbol/function. The other kind of hist_entry is for basic
>>>> block.
>>>
>>> correct
>>>
>>> so the way I see it the processing goes like this:
>>>
>>>
>>> 1) there's standard hist_entry processing ending up
>>>      with evsel->hists->rb_root full of hist entries
>>>
>>> 2) then you process every hist_entry and create
>>>      new 'struct hists' for each and fill it with
>>>      symbol counts data
>>>
>>>
>>>
>>> you could add 'struct hist_entry_ops' for the 1) processing
>>> that adds the 'struct hists' object for each hist_entry
>>>
>>> and add another 'struct hist_entry_ops' for 2) processing
>>> to carry the block data for each hist_entry
>>>
>>> jirka
>>>
>>
>> Hi Jiri,
>>
>> Yes, I can use two hist_entry_ops but one thing is still difficult to handle
>> that is the printing of blocks.
>>
>> One function may contain multiple blocks so I add 'block_num' in 'struct
>> hist_entry' to record the number of blocks.
>>
>> In patch "perf diff: Print the basic block cycles diff", I reuse most of
>> current code to print the blocks. The major change is:
>>
>>   static int hist_entry__fprintf(struct hist_entry *he, size_t size,
>>                                 char *bf, size_t bfsz, FILE *fp,
>>                                 bool ignore_callchains) {
>>
>> +       if (he->block_hists)
>> +               return hist_entry__block_fprintf(he, bf, size, fp);
>> +
> 
> 
> you could do it the way we do hierarchy and have
> something like 'symbol_conf.report_block'
> 
>          if (symbol_conf.report_hierarchy)
>                  return hist_entry__hierarchy_fprintf(he, &hpp, hists, fp);
> 
> and in hist_entry__block_fprintf you cast the hist_entry
> to your struct.. so you'll have all the data
> 
> jirka
> 

Thanks Jiri. So it looks I need to define 'struct block_hist_entry' in 
util/sort.h, then hist_entry__block_fprintf can know this struct. 
Previously I just defined this struct in builtin-diff.c.

Thanks
Jin Yao

