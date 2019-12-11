Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B120C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727A22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfLKOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:21:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:40036 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbfLKOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:21:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 06:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225542708"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 06:21:49 -0800
Received: from [10.125.249.93] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6AF1E580297;
        Wed, 11 Dec 2019 06:21:46 -0800 (PST)
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
Message-ID: <8e198b00-2e43-8f85-ec13-714433681f20@linux.intel.com>
Date:   Wed, 11 Dec 2019 17:21:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210103710.GM2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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


Removed theuncore_type_attrs_compaction() function and implemented Kan's
suggestion to replace NULL events_group by the empty attributes group:


diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e8532923bd45..110b3603f56f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -923,6 +923,14 @@ static void uncore_types_exit(struct 
intel_uncore_type **types)
                 uncore_type_exit(*types);
  }

+static struct attribute *empty_attrs[] = {
+       NULL,
+};
+
+static const struct attribute_group empty_group = {
+       .attrs = empty_attrs,
+};
+
  static int __init uncore_type_init(struct intel_uncore_type *type, 
bool setid)
  {
         struct intel_uncore_pmu *pmus;
@@ -968,7 +976,8 @@ static int __init uncore_type_init(struct 
intel_uncore_type *type, bool setid)
                         attr_group->attrs[j] = 
&type->event_descs[j].attr.attr;

                 type->events_group = &attr_group->group;
-       }
+       } else
+               type->events_group = &empty_group;

         type->pmu_group = &uncore_pmu_attr_group;

