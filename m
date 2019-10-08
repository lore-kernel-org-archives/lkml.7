Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCED206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfJHNx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:53:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:33349 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfJHNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:53:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 06:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="218288546"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2019 06:53:26 -0700
Received: from [10.254.92.181] (kliang2-mobl.ccr.corp.intel.com [10.254.92.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 64C7D580332;
        Tue,  8 Oct 2019 06:53:25 -0700 (PDT)
Subject: Re: [PATCH 01/10] perf/core, x86: Add PERF_SAMPLE_LBR_TOS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
 <20191007175910.2805-2-kan.liang@linux.intel.com>
 <20191008083141.GH2294@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3ac026c3-6b9c-a6c1-2c2b-c7ecdbb22b1d@linux.intel.com>
Date:   Tue, 8 Oct 2019 09:53:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008083141.GH2294@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2019 4:31 AM, Peter Zijlstra wrote:
> On Mon, Oct 07, 2019 at 10:59:01AM -0700, kan.liang@linux.intel.com wrote:
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 61448c19a132..ee9ef0c4cb08 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -100,6 +100,7 @@ struct perf_raw_record {
>>    */
>>   struct perf_branch_stack {
>>   	__u64				nr;
>> +	__u64				tos;
>>   	struct perf_branch_entry	entries[0];
>>   };
>>   
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index bb7b271397a6..fe36ebb7dc2e 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>>   	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>>   	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>>   	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>> +	PERF_SAMPLE_LBR_TOS			= 1U << 20,
>>   
>> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
>> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>>   
>>   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>>   };
>> @@ -864,6 +865,7 @@ enum perf_event_type {
>>   	 *	{ u64			abi; # enum perf_sample_regs_abi
>>   	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>>   	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>> +	 *	{ u64			tos;} && PERF_SAMPLE_LBR_TOS
>>   	 * };
>>   	 */
>>   	PERF_RECORD_SAMPLE			= 9,
> 
> I have problems with the API.. You're introducing the intel specific LBR
> naming, and adding a whole new sample type vs extending the existing
> BRANCH_STACK (like you really already do with struct perf_branch_stack). >
> So why not add a bit to PERF_SAMPLE_BRANCH_* to request the presence of
> the TOS field in the PERF_SAMPLE_BRANCH_STACK output?

We never store PERF_SAMPLE_BRANCH_* in a sample. The perf tool cannot 
tell if the sample includes TOS field.
There will be a problem when a new perf tool parsing the data generated 
by an old kernel.


Can we rename the new sample type PERF_SAMPLE_BRANCH_STACK_EXTENSION?

{ u64			version;
   u64			tos;} 		&& PERF_SAMPLE_LBR_TOS

If other platforms want to add their extension, we just need to increase 
the version number. Perf tool will check the version before parsing the 
sample.

Thanks,
Kan
