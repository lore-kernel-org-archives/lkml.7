Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4989EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280DD2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLJSce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:32:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:4871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJScd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:32:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 10:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="215659578"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2019 10:32:32 -0800
Received: from [10.125.249.44] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 77D7F5808CC;
        Tue, 10 Dec 2019 10:32:28 -0800 (PST)
Subject: Re: [PATCH v2 2/3] perf x86: Add compaction function for uncore
 attributes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexander.antonov@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
 <20191210091451.6054-3-roman.sudarikov@linux.intel.com>
 <20191210103710.GM2844@hirez.programming.kicks-ass.net>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <2a2dea60-4936-3124-4e1c-51aebeb82b95@linux.intel.com>
Date:   Tue, 10 Dec 2019 21:32:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210103710.GM2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2019 13:37, Peter Zijlstra wrote:
> On Tue, Dec 10, 2019 at 12:14:50PM +0300, roman.sudarikov@linux.intel.com wrote:
>> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>>
>> In current design, there is an implicit assumption that array of pointers
>> to uncore type attributes is NULL terminated. However, not all attributes
>> are mandatory for each Uncore unit type, e.g. "events" is required for
>> IMC but doesn't exist for CHA. That approach correctly supports only one
>> optional attribute which also must be the last in the row.
>> The patch removes limitation by safely removing embedded NULL elements.
>>
>> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
>> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
>> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>> ---
>>   arch/x86/events/intel/uncore.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 24e120289018..a05352c4fc01 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -923,6 +923,22 @@ static void uncore_types_exit(struct intel_uncore_type **types)
>>   		uncore_type_exit(*types);
>>   }
>>   
>> +static void uncore_type_attrs_compaction(struct intel_uncore_type *type)
>> +{
>> +	int i, j;
>> +	int size = ARRAY_SIZE(type->attr_groups);
>> +
>> +	for (i = 0, j = 0; i < size; i++) {
>> +		if (!type->attr_groups[i])
>> +			continue;
>> +		if (i > j) {
>> +			type->attr_groups[j] = type->attr_groups[i];
>> +			type->attr_groups[i] = NULL;
>> +		}
>> +		j++;
>> +	}
>> +}
> GregKH had objections to us playing silly games like that and made us
> use is_visible() for the regular PMU driver. Also see commit:
>
>    baa0c83363c7 ("perf/x86: Use the new pmu::update_attrs attribute group")

Hi Peter,

if I understand correctly, that commit is intended for graceful handling 
of cases where we need to
probe hardware first before making decision whether to show or not that 
particular event for that particular pmu.
What I'm doing has slightly different context - I'm creating the mapping 
per pmu type.
That mapping is not hardware dependent but implementation dependent 
meaning that if the mapping is not implemented
for some pmu type, then the mapping attribute has no way to show up 
following current implementation, right?
If the mapping is implemented then it shows up for all pmus of that type.

I can rework it following the approach implemented in the commit you 
mentioned but the benefit is not immediately obvious :-)

Thanks,
Roman
