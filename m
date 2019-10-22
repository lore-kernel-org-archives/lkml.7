Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8660CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B732084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfJVPjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:39:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:52305 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfJVPjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:39:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 08:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,216,1569308400"; 
   d="scan'208";a="222854370"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2019 08:39:30 -0700
Received: from [10.251.14.17] (kliang2-mobl.ccr.corp.intel.com [10.251.14.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 79C2558048F;
        Tue, 22 Oct 2019 08:39:29 -0700 (PDT)
Subject: Re: [PATCH V2 01/13] perf/core: Add new branch sample type for LBR
 TOS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
 <20191021200314.1613-2-kan.liang@linux.intel.com>
 <20191022093926.GH1800@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3b013646-8aaa-56b2-74a1-ff04a4af3a26@linux.intel.com>
Date:   Tue, 22 Oct 2019 11:39:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022093926.GH1800@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2019 5:39 AM, Peter Zijlstra wrote:
> On Mon, Oct 21, 2019 at 01:03:02PM -0700, kan.liang@linux.intel.com wrote:
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
>>   include/linux/perf_event.h      |  4 ++++
>>   include/uapi/linux/perf_event.h | 10 +++++++++-
>>   kernel/events/core.c            | 10 ++++++++++
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 61448c19a132..0cebc8ec44fa 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -972,6 +972,10 @@ struct perf_sample_data {
>>   	u64				stack_user_size;
>>   
>>   	u64				phys_addr;
>> +
>> +	/* PMU specific data */
>> +	u64				lbr_tos;
>> +
>>   } ____cacheline_aligned;
> 
> Last time you put this in perf_branch_stack, that was a much better
> place. Can't this work now?

It should still work.
I just thought perf_branch_stack is a generic structure for branches.
TOS is Intel specific for LBR call stack. Maybe it's better to move it out.
Also, I wanted to make it consistent as perf tool struct branch_stack.
But those should not be big deals.

I will move tos to perf_branch_stack in V3 as below.

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0cebc8ec44fa..c8bf40e608b6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -92,6 +92,7 @@ struct perf_raw_record {
  /*
   * branch stack layout:
   *  nr: number of taken branches stored in entries[]
+ *  tos: Top-of-Stack (TOS) information. PMU specific data.
   *
   * Note that nr can vary from sample to sample
   * branches (to, from) are stored from most recent
@@ -100,6 +101,7 @@ struct perf_raw_record {
   */
  struct perf_branch_stack {
  	__u64				nr;
+	__u64				tos; /* PMU specific data */
  	struct perf_branch_entry	entries[0];
  };


Thanks,
Kan
