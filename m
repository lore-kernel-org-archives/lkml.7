Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A06C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D0220674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKSWRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:17:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:31988 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfKSWRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:17:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 14:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="215631259"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 14:17:14 -0800
Received: from [10.251.19.22] (kliang2-mobl.ccr.corp.intel.com [10.251.19.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D28485800FE;
        Tue, 19 Nov 2019 14:17:13 -0800 (PST)
Subject: Re: [PATCH V4 03/13] perf tools: Support new branch sample type for
 LBR TOS
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
 <20191119143411.3482-4-kan.liang@linux.intel.com>
 <CABPqkBSkTgvbz0S_iv-F5DkUKdqA49k_dLtoh0wbE49ePQ6V=A@mail.gmail.com>
 <20191119213124.GO3079@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <91cf3b08-c0ec-9bcd-669e-c5c91bda71ce@linux.intel.com>
Date:   Tue, 19 Nov 2019 17:17:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119213124.GO3079@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2019 4:31 PM, Peter Zijlstra wrote:
> On Tue, Nov 19, 2019 at 11:00:00AM -0800, Stephane Eranian wrote:
>> On Tue, Nov 19, 2019 at 6:35 AM <kan.liang@linux.intel.com> wrote:
> 
>>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>>> index bb7b271397a6..c2da61c9ace7 100644
>>> --- a/tools/include/uapi/linux/perf_event.h
>>> +++ b/tools/include/uapi/linux/perf_event.h
>>> @@ -180,7 +180,10 @@ enum perf_branch_sample_type_shift {
>>>
>>>          PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch type */
>>>
>>> -       PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
>>> +       PERF_SAMPLE_BRANCH_MAX_SHIFT            = 17, /* non-ABI */
>>> +
>>> +       /* PMU specific */
>>
>> No! You must abstract this.
>>
>>> +       PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT        = 63, /* save LBR TOS */
>>>   };
>>>
>> I don't like this because this is too Intel specific.
>> What is the meaning of this field? You need a clear definition so it can be used
>> with other PERF_SAMPLE_BRANCH_* implementations.
> 
> I also detest the MSB usage. Normal pattern is that any bit >= MAX
> will be rejected by the kernel.
>

OK. I will still use bit 17 for the new branch sample type.

I can change the Intel specific name, and use a generic name. How about 
PERF_SAMPLE_BRANCH_PMU_SPECIFIC?

If we make it generic, there will be another question. How much space 
should we reserve for this new branch sample type?
For LBR TOS, we only need a u64.
I'm not sure if it's good enough for other platforms.

Or maybe we want a flexible space as below?
@@ -849,7 +854,12 @@ enum perf_event_type {
          *        char                  data[size];}&& PERF_SAMPLE_RAW
          *
          *      { u64                   nr;
-        *        { u64 from, to, flags } lbr[nr];} && 
PERF_SAMPLE_BRANCH_STACK
+        *        { u64 from, to, flags } lbr[nr];
+        *
+        *        # only available if PERF_SAMPLE_BRANCH_PMU_SPECIFIC is set
+        *        u64                   nr;
+        *        u64                   data[nr];
+        *      } && PERF_SAMPLE_BRANCH_STACK
          *
          *      { u64                   abi; # enum perf_sample_regs_abi
          *        u64                   regs[weight(mask)]; } && 
PERF_SAMPLE_REGS_USER


Thanks,
Kan

