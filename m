Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEBBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F420684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409770AbfJXPuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:50:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:24716 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409760AbfJXPuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:50:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 08:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="201513062"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2019 08:50:09 -0700
Received: from [10.251.0.130] (kliang2-mobl.ccr.corp.intel.com [10.251.0.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7349C580107;
        Thu, 24 Oct 2019 08:50:08 -0700 (PDT)
Subject: Re: [PATCH V3 01/13] perf/core: Add new branch sample type for LBR
 TOS
To:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com
References: <20191022171136.4022-1-kan.liang@linux.intel.com>
 <20191022171136.4022-2-kan.liang@linux.intel.com>
 <20191024134133.GC4114@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2acd43e0-0b78-44e5-7b4e-b87c251db284@linux.intel.com>
Date:   Thu, 24 Oct 2019 11:50:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024134133.GC4114@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2019 9:41 AM, Peter Zijlstra wrote:
> On Tue, Oct 22, 2019 at 10:11:24AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> In LBR call stack mode, the depth of reconstructed LBR call stack limits
>> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
>> perf tool may stitch the stacks of two samples. The reconstructed LBR
>> call stack can break the HW limitation.
>>
>> Add a new branch sample type to retrieve LBR TOS.
>>
>> Only when the new branch sample type is set, the TOS information is
>> dumped into the PERF_SAMPLE_BRANCH_STACK output.
>> Perf tool should check the attr.branch_sample_type, and apply the
>> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
>> Otherwise, some user case may be broken. For example, users may parse a
>> perf.data, which include the new branch sample type, with an old version
>> perf tool (without the check). Users probably get incorrect information
>> without any warning.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   include/linux/perf_event.h      |  2 ++
>>   include/uapi/linux/perf_event.h | 10 +++++++++-
>>   kernel/events/core.c            | 11 +++++++++++
>>   3 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 61448c19a132..2b229ea1cc15 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -92,6 +92,7 @@ struct perf_raw_record {
>>   /*
>>    * branch stack layout:
>>    *  nr: number of taken branches stored in entries[]
>> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
>>    *
>>    * Note that nr can vary from sample to sample
>>    * branches (to, from) are stored from most recent
>> @@ -100,6 +101,7 @@ struct perf_raw_record {
>>    */
>>   struct perf_branch_stack {
>>   	__u64				nr;
>> +	__u64				tos; /* PMU specific data */
>>   	struct perf_branch_entry	entries[0];
>>   };
>>   
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index bb7b271397a6..b1f022190571 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
>>   
>>   	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
>>   
>> +	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 17, /* save LBR TOS */
> 
> I think I prefer not having LBR here either, who knows what other
> hardware can make use of that.

Alternatively, we may put it at the end of perf_branch_sample_type_shift 
as below.

	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 63, /* save LBR TOS */

It looks like we just need to do a little bit extra work in 
perf_copy_attr() to specially handle the case.

> 
> On that, you've completely failed to Cc the other architecture that
> implement PERF_SAMPLE_BRANCH.

It looks like only PowerPC implement PERF_SAMPLE_BRANCH.
Michael, any comments?

Thanks,
Kan

> 
> Aside from that I can live with this version.
> 
>> +
>>   	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>>   };
>>   
>> @@ -207,6 +209,8 @@ enum perf_branch_sample_type {
>>   	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
>>   		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>>   
>> +	PERF_SAMPLE_BRANCH_LBR_TOS	= 1U << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
>> +
>>   	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>>   };
>>   
>> @@ -849,7 +853,11 @@ enum perf_event_type {
>>   	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>>   	 *
>>   	 *	{ u64                   nr;
>> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>> +	 *        { u64 from, to, flags } lbr[nr];
>> +	 *
>> +	 *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
>> +	 *        u64			tos;
>> +	 *      } && PERF_SAMPLE_BRANCH_STACK
>>   	 *
>>   	 * 	{ u64			abi; # enum perf_sample_regs_abi
>>   	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 9ec0b0bfddbd..18b0a7d2c67e 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6343,6 +6343,11 @@ static void perf_output_read(struct perf_output_handle *handle,
>>   		perf_output_read_one(handle, event, enabled, running);
>>   }
>>   
>> +static inline bool perf_sample_save_lbr_tos(struct perf_event *event)
>> +{
>> +	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
>> +}
>> +
>>   void perf_output_sample(struct perf_output_handle *handle,
>>   			struct perf_event_header *header,
>>   			struct perf_sample_data *data,
>> @@ -6432,6 +6437,8 @@ void perf_output_sample(struct perf_output_handle *handle,
>>   
>>   			perf_output_put(handle, data->br_stack->nr);
>>   			perf_output_copy(handle, data->br_stack->entries, size);
>> +			if (perf_sample_save_lbr_tos(event))
>> +				perf_output_put(handle, data->br_stack->tos);
>>   		} else {
>>   			/*
>>   			 * we always store at least the value of nr
>> @@ -6619,7 +6626,11 @@ void perf_prepare_sample(struct perf_event_header *header,
>>   		if (data->br_stack) {
>>   			size += data->br_stack->nr
>>   			      * sizeof(struct perf_branch_entry);
>> +
>> +			if (perf_sample_save_lbr_tos(event))
>> +				size += sizeof(u64);
>>   		}
>> +
>>   		header->size += size;
>>   	}
>>   
>> -- 
>> 2.17.1
>>
