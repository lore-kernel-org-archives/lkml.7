Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A593AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A2F2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDAWdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:33:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:59571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfDAWdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:33:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 15:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="157822139"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2019 15:33:07 -0700
Received: from [10.254.82.10] (kliang2-mobl.ccr.corp.intel.com [10.254.82.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D1732580349;
        Mon,  1 Apr 2019 15:33:06 -0700 (PDT)
Subject: Re: [PATCH V4 01/23] perf/x86: Support outputting XMM registers
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
 <20190326160901.4887-2-kan.liang@linux.intel.com>
 <CABPqkBTQTFq73EJU_FR3Z0oFUiSei4gY1+sQgWgPgjX4AsiNhw@mail.gmail.com>
 <fb915f3a-0cb3-519b-c7e6-403dd8af5791@linux.intel.com>
 <CABPqkBSUi2ftjEiUXiCXLVZzmxAkJWAegFcgHzNTT2kQnVYntw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c9c816ef-66d7-604c-5390-cf8c9bd67779@linux.intel.com>
Date:   Mon, 1 Apr 2019 18:33:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBSUi2ftjEiUXiCXLVZzmxAkJWAegFcgHzNTT2kQnVYntw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/2019 5:11 PM, Stephane Eranian wrote:
>>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>>> index e2b1447192a8..9378c6b2128f 100644
>>>> --- a/arch/x86/events/core.c
>>>> +++ b/arch/x86/events/core.c
>>>> @@ -560,6 +560,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>>>>                           return -EINVAL;
>>>>           }
>>>>
>>>> +       if (event->attr.sample_regs_user & ~PEBS_REGS)
>>>> +               return -EINVAL;
>>>> +       /*
>>>> +        * Besides the general purpose registers, XMM registers may
>>>> +        * be collected in PEBS on some platforms, e.g. Icelake
>>>> +        */
>>>> +       if ((event->attr.sample_regs_intr & ~PEBS_REGS) &&
>>>> +           (!x86_pmu.has_xmm_regs || !event->attr.precise_ip))
>>>> +               return -EINVAL;
>>>> +
>>> Shouldn't you be testing on PEBS_REGS only if the user is asking for
>>> PEBS sampling?
>>> That is not because PEBS may not capture a register that the kernel
>>> could not do it
>>> without PEBS.
>> I will add is_sampling_event() check as below.
>>
>> if (is_sampling_event(event) &&
>>       (event->attr.sample_regs_user & ~PEBS_REGS))
>>            return -EINVAL;
>> if (is_sampling_event(event) &&
>>       (event->attr.sample_regs_intr & ~PEBS_REGS) &&
>>       (!x86_pmu.has_xmm_regs || !event->attr.precise_ip))
>>           return -EINVAL;
>>
> That is not enough. I can be sampling without PEBS and thus why I am comparing
> to PEBS_REGS? If I recall by the time the kernel gets to this code,
> the sample_regs_* has
> already been validated to contain only supported registers. So you
> need this extra check
> to make sure that WHEN you are sampling with PEBS, then they are also
> covered by PEBS.

Yes, the common code still validate the supported registers. However, it 
cannot check model specific registers, e.g. XMM.
The extra check here is only for XMM registers. If it's non-PEBS | 
non-sampling | pre-icl and XMM bit is set for sample_regs_intr, it 
should error out.

It looks like the PEBS_REGS is a very confused name? I can rename it 
PEBS_GPRS_REGS, and add a new name for PEBS_XMM_REGS.
How about the code as below? (not test yet)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..e93c43e54c75 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -560,6 +560,21 @@ int x86_pmu_hw_config(struct perf_event *event)
  			return -EINVAL;
  	}

+	/* sample_regs_user never support XMM registers */
+	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
+		return -EINVAL;
+	/*
+	 * Besides the general purpose registers, XMM registers may
+	 * be collected in PEBS on some platforms, e.g. Icelake
+	 */
+	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
+		if (!is_sampling_event(event) ||
+		    !event->attr.precise_ip ||
+		    x86_pmu.pebs_no_xmm_regs)
+			return -EINVAL;
+
+	}
+
  	return x86_setup_perfctr(event);
  }

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8baa441d8000..a9721457f187 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3131,7 +3131,7 @@ static unsigned long 
intel_pmu_large_pebs_flags(struct perf_event *event)
  		flags &= ~PERF_SAMPLE_TIME;
  	if (!event->attr.exclude_kernel)
  		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GPRS_REGS)
  		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
  	return flags;
  }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 10c99ce1fead..f57e6cb7fd99 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1628,8 +1628,10 @@ void __init intel_ds_init(void)
  	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
  	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4)
+	if (x86_pmu.version <= 4) {
  		x86_pmu.pebs_no_isolation = 1;
+		x86_pmu.pebs_no_xmm_regs = 1;
+	}
  	if (x86_pmu.pebs) {
  		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
  		int format = x86_pmu.intel_cap.pebs_format;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a75955741c50..3b195435b386 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -96,7 +96,7 @@ struct amd_nb {
  	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
  	PERF_SAMPLE_PERIOD)

-#define PEBS_REGS \
+#define PEBS_GPRS_REGS \
  	(PERF_REG_X86_AX | \
  	 PERF_REG_X86_BX | \
  	 PERF_REG_X86_CX | \
@@ -116,6 +116,24 @@ struct amd_nb {
  	 PERF_REG_X86_R14 | \
  	 PERF_REG_X86_R15)

+#define PEBS_XMM_REGS         \
+	(PERF_REG_X86_XMM0  | \
+	 PERF_REG_X86_XMM1  | \
+	 PERF_REG_X86_XMM2  | \
+	 PERF_REG_X86_XMM3  | \
+	 PERF_REG_X86_XMM4  | \
+	 PERF_REG_X86_XMM5  | \
+	 PERF_REG_X86_XMM6  | \
+	 PERF_REG_X86_XMM7  | \
+	 PERF_REG_X86_XMM8  | \
+	 PERF_REG_X86_XMM9  | \
+	 PERF_REG_X86_XMM10 | \
+	 PERF_REG_X86_XMM11 | \
+	 PERF_REG_X86_XMM12 | \
+	 PERF_REG_X86_XMM13 | \
+	 PERF_REG_X86_XMM14 | \
+	 PERF_REG_X86_XMM15)
+
  /*
   * Per register state.
   */
@@ -613,7 +631,8 @@ struct x86_pmu {
  			pebs_broken		:1,
  			pebs_prec_dist		:1,
  			pebs_no_tlb		:1,
-			pebs_no_isolation	:1;
+			pebs_no_isolation	:1,
+			pebs_no_xmm_regs	:1;
  	int		pebs_record_size;
  	int		pebs_buffer_size;
  	void		(*drain_pebs)(struct pt_regs *regs);
> 
> Also if I sample with sample_regs_users != 0 and sample_regs_intr != 0
> and PEBS, and
> I get a kernel sample, I wonder how sample_regs_users can be updated from PEBS.
> I think you can update from PEBS it ONLY when the sample was for a
> user-level instruction
> in which case both sample_regs_user and sample_regs_intr can be served
> from the PEBS
> machine state.
> 

AFAIK, the sample_regs_users is not from PEBS. So there is nothing 
changed for sample_regs_users. It doesn't support XMM registers.

Thanks,
Kan




