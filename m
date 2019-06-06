Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF9C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752092070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFFBPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:15:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:41484 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfFFBPN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:15:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:15:12 -0700
X-ExtLoop1: 1
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.71]) ([10.239.196.71])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:15:10 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d85f2abc-c960-3736-545c-5cbe778c584b@linux.intel.com>
Date:   Thu, 6 Jun 2019 09:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605114417.GB5868@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2019 7:44 PM, Jiri Olsa wrote:
> On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index 43623fa..d1641da 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -79,6 +79,9 @@ struct hist_entry_diff {
>>   
>>   		/* HISTC_WEIGHTED_DIFF */
>>   		s64	wdiff;
>> +
>> +		/* PERF_HPP_DIFF__CYCLES */
>> +		s64	cycles;
>>   	};
>>   };
>>   
>> @@ -143,6 +146,9 @@ struct hist_entry {
>>   	struct branch_info	*branch_info;
>>   	long			time;
>>   	struct hists		*hists;
>> +	void			*block_hists;
>> +	int			block_idx;
>> +	int			block_num;
>>   	struct mem_info		*mem_info;
>>   	struct block_info	*block_info;
> 
> could you please not add the new block* stuff in here,
> and instead use the "c2c model" and use yourr own struct
> on top of hist_entry? we are trying to librarize this
> stuff and keep only necessary things in here..
> 
> you're already using hist_entry_ops, so should be easy
> 
> something like:
> 
> 	struct block_hist_entry {
> 		void			*block_hists;
> 		int			block_idx;
> 		int			block_num;
> 		struct block_info	*block_info;
> 
> 		struct hist_entry	he;
> 	};
> 
> 
> 
> jirka
> 

Oh, yes, I should refer to 'c2c_hist_entry'. That avoids to add more 
stuffs in hist_entry. That's a good idea!

Thanks
Jin Yao
