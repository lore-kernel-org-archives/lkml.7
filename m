Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F60420721
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfKTPGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:06:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:29232 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:06:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 07:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="259060986"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2019 07:06:21 -0800
Received: from [10.251.17.82] (kliang2-mobl.ccr.corp.intel.com [10.251.17.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 838135800FE;
        Wed, 20 Nov 2019 07:06:20 -0800 (PST)
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
 <6c233145-fb30-b629-2290-8595e192ba82@linux.intel.com>
 <CABPqkBREzL_k9noerYrYLq8UqTJsahQdNRT4vhFoNSub09xyoA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <42ece835-5d44-3364-6823-8bc9b723cde8@linux.intel.com>
Date:   Wed, 20 Nov 2019 10:06:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBREzL_k9noerYrYLq8UqTJsahQdNRT4vhFoNSub09xyoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2019 5:51 PM, Stephane Eranian wrote:
> On Tue, Nov 19, 2019 at 2:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 11/19/2019 2:02 PM, Stephane Eranian wrote:
>>> On Tue, Nov 19, 2019 at 6:35 AM<kan.liang@linux.intel.com>  wrote:
>>>> From: Kan Liang<kan.liang@linux.intel.com>
>>>>
>>>> In LBR call stack mode, the depth of reconstructed LBR call stack limits
>>>> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
>>>> perf tool may stitch the stacks of two samples. The reconstructed LBR
>>>> call stack can break the HW limitation.
>>>>
>>>> Add a new branch sample type to retrieve LBR TOS. The new type is PMU
>>>> specific. Add it at the end of enum perf_branch_sample_type.
>>>> Add a macro to retrieve defined bits of branch sample type.
>>>> Update perf_copy_attr() to handle the new bit.
>>>>
>>>> Only when the new branch sample type is set, the TOS information is
>>>> dumped into the PERF_SAMPLE_BRANCH_STACK output.
>>>> Perf tool should check the attr.branch_sample_type, and apply the
>>>> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
>>>> Otherwise, some user case may be broken. For example, users may parse a
>>>> perf.data, which include the new branch sample type, with an old version
>>>> perf tool (without the check). Users probably get incorrect information
>>>> without any warning.
>>>>
>>>> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
>>>> ---
>>>>    include/linux/perf_event.h      |  2 ++
>>>>    include/uapi/linux/perf_event.h | 16 ++++++++++++++--
>>>>    kernel/events/core.c            | 13 ++++++++++++-
>>>>    3 files changed, 28 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index 011dcbdbccc2..761021c7ee8a 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -93,6 +93,7 @@ struct perf_raw_record {
>>>>    /*
>>>>     * branch stack layout:
>>>>     *  nr: number of taken branches stored in entries[]
>>>> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
>>>>     *
>>>>     * Note that nr can vary from sample to sample
>>>>     * branches (to, from) are stored from most recent
>>>> @@ -101,6 +102,7 @@ struct perf_raw_record {
>>>>     */
>>>>    struct perf_branch_stack {
>>>>           __u64                           nr;
>>>> +       __u64                           tos; /* PMU specific data */
>>>>           struct perf_branch_entry        entries[0];
>>>>    };
>>>>
>>> Same remark as with the other patch. You need to abstract this.
>>> The TOS and PMU specific data should be limited to  x86/event/intel/*.[ch].
>>>
>>
>> If we change tos to a generic name, e.g. pmu_specific_data, can we still
>> keep it here?
>>
> It's not just about the name, it is about what it points to?
> What value does it return when the hw does not have a TOS?
> I added the PERF_SAMPLE_BRANCH_*. I did not just expose the
> raw LBR. There is an abstraction layer, so it is easier to map to other
> architectures, like IBM Power, for instance. You cannot just add a TOS
> and say it is PMU specific. If you do that for all architectures, then it
> becomes very messy and hard to understand and use especially for tools.
> 
> This is an interface you are trying to define. This needs to be specified
> precisely so that tools can make the right assumptions across hw platforms.
> 
> Note that the entries[] array is normally already sorted by most
> recent to least recent.
> So exporting a TOS there is bizarre. The TOS is likely always pointing to the
> most recent entry. The TOS you want is exposing a low level index which does not
> map to the abstracted branch stack. And that's a problem.  You need to reconcile
> your definition of TOS with the branch_sample_entry [] abstraction.
>

I plan to use hw_idx to replace tos, which indicates the low level index 
of raw branch records for the most recent branch aka entries[0].
For other architectures whose raw branch records are already stored in 
age order. The hw_idx should be 0.
If we don't know the order of raw branch records, the hw_idx should be 
-1ULL. I will set hw_idx to -1ULL for IBM Power for now. They can change 
it later if needed.

How about the changes as below?

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbdbccc2..e2de81372433 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -93,14 +93,26 @@ struct perf_raw_record {
  /*
   * branch stack layout:
   *  nr: number of taken branches stored in entries[]
+ *  hw_idx: The low level index of raw branch records
+ *          for the most recent branch.
+ *          -1ULL means invalid.
   *
   * Note that nr can vary from sample to sample
   * branches (to, from) are stored from most recent
   * to least recent, i.e., entries[0] contains the most
   * recent branch.
+ * The entries[] is an abstraction of raw branch records,
+ * which may not be stored in age order in HW, e.g. Intel LBR.
+ * The hw_idx is to expose the low level index of raw
+ * branch record for the most recent branch aka entries[0].
+ * For the architectures whose raw branch records are
+ * already stored in age order, the hw_idx should be 0.
+ * If we don't know the order of raw branch records,
+ * the hw_idx should be -1ULL.
   */
  struct perf_branch_stack {
         __u64                           nr;
+       __u64                           hw_idx;
         struct perf_branch_entry        entries[0];
  };
diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index bb7b271397a6..30f335f0d25e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -180,7 +180,9 @@ enum perf_branch_sample_type_shift {

         PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch 
type */

-       PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
+       PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT       = 17, /* save low level 
index of raw branch records */
+
+       PERF_SAMPLE_BRANCH_MAX_SHIFT            = 18, /* non-ABI */
  };

  enum perf_branch_sample_type {
@@ -207,6 +209,8 @@ enum perf_branch_sample_type {
         PERF_SAMPLE_BRANCH_TYPE_SAVE    =
                 1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,

+       PERF_SAMPLE_BRANCH_HW_INDEX     = 1U << 
PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
+
         PERF_SAMPLE_BRANCH_MAX          = 1U << 
PERF_SAMPLE_BRANCH_MAX_SHIFT,
  };

@@ -849,7 +853,11 @@ enum perf_event_type {
          *        char                  data[size];}&& PERF_SAMPLE_RAW
          *
          *      { u64                   nr;
-        *        { u64 from, to, flags } lbr[nr];} && 
PERF_SAMPLE_BRANCH_STACK
+        *        { u64 from, to, flags } lbr[nr];
+        *
+        *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
+        *        u64                   hw_idx;
+        *      } && PERF_SAMPLE_BRANCH_STACK
          *
          *      { u64                   abi; # enum perf_sample_regs_abi
          *        u64                   regs[weight(mask)]; } && 
PERF_SAMPLE_REGS_USER


Thanks,
Kan
