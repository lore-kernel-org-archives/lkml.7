Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB555C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A2320652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbfFKCWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 22:22:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:18331 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbfFKCWu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:22:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 19:22:49 -0700
X-ExtLoop1: 1
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.109]) ([10.239.196.109])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2019 19:22:46 -0700
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
 <20190605114417.GB5868@krava>
 <4bbc5085-c8b0-5e36-419c-6ee754186027@linux.intel.com>
Message-ID: <b6c07576-3ee1-487e-ad56-18d1f4eea140@linux.intel.com>
Date:   Tue, 11 Jun 2019 10:22:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4bbc5085-c8b0-5e36-419c-6ee754186027@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2019 7:41 PM, Jin, Yao wrote:
> 
> 
> On 6/5/2019 7:44 PM, Jiri Olsa wrote:
>> On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:
>>
>> SNIP
>>
>>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>>> index 43623fa..d1641da 100644
>>> --- a/tools/perf/util/sort.h
>>> +++ b/tools/perf/util/sort.h
>>> @@ -79,6 +79,9 @@ struct hist_entry_diff {
>>>           /* HISTC_WEIGHTED_DIFF */
>>>           s64    wdiff;
>>> +
>>> +        /* PERF_HPP_DIFF__CYCLES */
>>> +        s64    cycles;
>>>       };
>>>   };
>>> @@ -143,6 +146,9 @@ struct hist_entry {
>>>       struct branch_info    *branch_info;
>>>       long            time;
>>>       struct hists        *hists;
>>> +    void            *block_hists;
>>> +    int            block_idx;
>>> +    int            block_num;
>>>       struct mem_info        *mem_info;
>>>       struct block_info    *block_info;
>>
>> could you please not add the new block* stuff in here,
>> and instead use the "c2c model" and use yourr own struct
>> on top of hist_entry? we are trying to librarize this
>> stuff and keep only necessary things in here..
>>
>> you're already using hist_entry_ops, so should be easy
>>
>> something like:
>>
>>     struct block_hist_entry {
>>         void            *block_hists;
>>         int            block_idx;
>>         int            block_num;
>>         struct block_info    *block_info;
>>
>>         struct hist_entry    he;
>>     };
>>
>>
>>
>> jirka
>>
> 
> Hi Jiri,
> 
> After more considerations, maybe I can't move these stuffs from 
> hist_entry to block_hist_entry.
> 
> Actually we use 2 kinds of hist_entry in this patch series. On kind of 
> hist_entry is for symbol/function. The other kind of hist_entry is for 
> basic block.
> 
> @@ -143,6 +146,9 @@ struct hist_entry {
>        struct branch_info    *branch_info;
>        long            time;
>        struct hists        *hists;
> +    void            *block_hists;
> +    int            block_idx;
> +    int            block_num;
>        struct mem_info        *mem_info;
>        struct block_info    *block_info;
> 
> The above hist_entry is actually for symbol/function. This patch series 
> collects all basic blocks in a symbol/function, so it needs a hists in 
> struct hist_entry (block_hists) to point to the hists of basic blocks.
> 
> Correct me if I'm wrong.
> 
> Thanks
> Jin Yao
> 

Hi Jiri,

Either adding a new pointer 'priv' in 'struct map_symbol'?

struct map_symbol {
	struct map	*map;
	struct symbol	*sym;
+	void		*priv;
};

We create a struct outside and assign the pointer to priv. Logically it 
should make sense since the symbol/function may have private data for 
processing.

Any idea?

Thanks
Jin Yao




