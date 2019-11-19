Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59322449
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKSWZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:25:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:6439 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfKSWZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:25:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 14:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="381165579"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2019 14:25:47 -0800
Received: from [10.251.19.22] (kliang2-mobl.ccr.corp.intel.com [10.251.19.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0C4EC5800FE;
        Tue, 19 Nov 2019 14:25:45 -0800 (PST)
Subject: Re: [PATCH V4 01/13] perf/core: Add new branch sample type for LBR
 TOS
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
 <20191119143411.3482-2-kan.liang@linux.intel.com>
 <CABPqkBRrPgW+Kdkiqy0dTu6e_8G55XLfFh5mCLt1_UQEHU=Zbg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6c233145-fb30-b629-2290-8595e192ba82@linux.intel.com>
Date:   Tue, 19 Nov 2019 17:25:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBRrPgW+Kdkiqy0dTu6e_8G55XLfFh5mCLt1_UQEHU=Zbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2019 2:02 PM, Stephane Eranian wrote:
> On Tue, Nov 19, 2019 at 6:35 AM<kan.liang@linux.intel.com>  wrote:
>> From: Kan Liang<kan.liang@linux.intel.com>
>>
>> In LBR call stack mode, the depth of reconstructed LBR call stack limits
>> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
>> perf tool may stitch the stacks of two samples. The reconstructed LBR
>> call stack can break the HW limitation.
>>
>> Add a new branch sample type to retrieve LBR TOS. The new type is PMU
>> specific. Add it at the end of enum perf_branch_sample_type.
>> Add a macro to retrieve defined bits of branch sample type.
>> Update perf_copy_attr() to handle the new bit.
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
>> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
>> ---
>>   include/linux/perf_event.h      |  2 ++
>>   include/uapi/linux/perf_event.h | 16 ++++++++++++++--
>>   kernel/events/core.c            | 13 ++++++++++++-
>>   3 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 011dcbdbccc2..761021c7ee8a 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -93,6 +93,7 @@ struct perf_raw_record {
>>   /*
>>    * branch stack layout:
>>    *  nr: number of taken branches stored in entries[]
>> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
>>    *
>>    * Note that nr can vary from sample to sample
>>    * branches (to, from) are stored from most recent
>> @@ -101,6 +102,7 @@ struct perf_raw_record {
>>    */
>>   struct perf_branch_stack {
>>          __u64                           nr;
>> +       __u64                           tos; /* PMU specific data */
>>          struct perf_branch_entry        entries[0];
>>   };
>>
> Same remark as with the other patch. You need to abstract this.
> The TOS and PMU specific data should be limited to  x86/event/intel/*.[ch].
>

If we change tos to a generic name, e.g. pmu_specific_data, can we still 
keep it here?

If not, I think the only way is to introduce a new method, e.g. 
output_br_pmu_data(), at struct pmu.
When outputting the sample data, the generic code will call 
event->pmu->output_br_pmu_data() to retrieve the TOS in Intel code.
I think it's too complicated.

Thanks,
Kan




