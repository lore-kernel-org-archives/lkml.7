Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A636C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfCZNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:15:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:57517 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZNPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:15:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="217668673"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 06:15:00 -0700
Received: from [10.254.89.90] (kliang2-mobl.ccr.corp.intel.com [10.254.89.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 92798580107;
        Tue, 26 Mar 2019 06:14:59 -0700 (PDT)
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1903260106210.1789@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5533614f-3d97-6e50-c63c-bee33c00c93b@linux.intel.com>
Date:   Tue, 26 Mar 2019 09:14:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903260106210.1789@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 8:11 PM, Thomas Gleixner wrote:
> On Fri, 22 Mar 2019, kan.liang@linux.intel.com wrote:
>>
>> +	PERF_REG_X86_XMM15 = 62,
>> +
>> +	/* All registers include the XMMX registers */
>> +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
> 
> Ergo: PERF_REG_X86_MAX == 64
> 
>> -#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
>> +#define REG_RESERVED \
>> +	(PERF_REG_X86_MAX == 64 ? 0 : ~((1ULL << PERF_REG_X86_MAX)) - 1ULL)
> 
> So what the heck is this conditional for?
> 
> But now 32bit has also access to the upper 8 GPRs simply because
> REG_RESERVED is now 0 and REG_NOSUPPORT is not excluding them either.
>

The patch as below fixes the name issue, removes unnecessary check for 
REG_RESERVED, and adds REG_NOSUPPORT for 32bit to exclude unsupported 
registers.

I will also change the user space patch accordingly and send out the V4.

Thanks,
Kan

------

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..9378c6b2128f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -560,6 +560,16 @@ int x86_pmu_hw_config(struct perf_event *event)
  			return -EINVAL;
  	}

+	if (event->attr.sample_regs_user & ~PEBS_REGS)
+		return -EINVAL;
+	/*
+	 * Besides the general purpose registers, XMM registers may
+	 * be collected in PEBS on some platforms, e.g. Icelake
+	 */
+	if ((event->attr.sample_regs_intr & ~PEBS_REGS) &&
+	    (!x86_pmu.has_xmm_regs || !event->attr.precise_ip))
+		return -EINVAL;
+
  	return x86_setup_perfctr(event);
  }

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a75955741c50..6428941a5073 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -657,6 +657,8 @@ struct x86_pmu {
  	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
  	 */
  	int (*check_period) (struct perf_event *event, u64 period);
+
+	unsigned int	has_xmm_regs : 1; /* support XMM regs */
  };

  struct x86_perf_task_context {
diff --git a/arch/x86/include/asm/perf_event.h 
b/arch/x86/include/asm/perf_event.h
index 8bdf74902293..d9f5bbe44b3c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -248,6 +248,11 @@ extern void perf_events_lapic_init(void);
  #define PERF_EFLAGS_VM		(1UL << 5)

  struct pt_regs;
+struct x86_perf_regs {
+	struct pt_regs	regs;
+	u64		*xmm_regs;
+};
+
  extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
  extern unsigned long perf_misc_flags(struct pt_regs *regs);
  #define perf_misc_flags(regs)	perf_misc_flags(regs)
diff --git a/arch/x86/include/uapi/asm/perf_regs.h 
b/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..ac67bbea10ca 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,8 +27,29 @@ enum perf_event_x86_regs {
  	PERF_REG_X86_R13,
  	PERF_REG_X86_R14,
  	PERF_REG_X86_R15,
-
+	/* These are the limits for the GPRs. */
  	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
  	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+
+	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_XMM0  = 32,
+	PERF_REG_X86_XMM1  = 34,
+	PERF_REG_X86_XMM2  = 36,
+	PERF_REG_X86_XMM3  = 38,
+	PERF_REG_X86_XMM4  = 40,
+	PERF_REG_X86_XMM5  = 42,
+	PERF_REG_X86_XMM6  = 44,
+	PERF_REG_X86_XMM7  = 46,
+	PERF_REG_X86_XMM8  = 48,
+	PERF_REG_X86_XMM9  = 50,
+	PERF_REG_X86_XMM10 = 52,
+	PERF_REG_X86_XMM11 = 54,
+	PERF_REG_X86_XMM12 = 56,
+	PERF_REG_X86_XMM13 = 58,
+	PERF_REG_X86_XMM14 = 60,
+	PERF_REG_X86_XMM15 = 62,
+
+	/* These include both GPRs and XMMX registers */
+	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
  };
  #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index c06c4c16c6b6..9e2f6be1e770 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -59,20 +59,41 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {

  u64 perf_reg_value(struct pt_regs *regs, int idx)
  {
+	struct x86_perf_regs *perf_regs;
+
+	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		if (!perf_regs->xmm_regs)
+			return 0;
+		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+	}
+
  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
  		return 0;

  	return regs_get_register(regs, pt_regs_offset[idx]);
  }

-#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
+#define REG_RESERVED	0

  #ifdef CONFIG_X86_32
+#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
+		       (1ULL << PERF_REG_X86_R9) | \
+		       (1ULL << PERF_REG_X86_R10) | \
+		       (1ULL << PERF_REG_X86_R11) | \
+		       (1ULL << PERF_REG_X86_R12) | \
+		       (1ULL << PERF_REG_X86_R13) | \
+		       (1ULL << PERF_REG_X86_R14) | \
+		       (1ULL << PERF_REG_X86_R15))
+
  int perf_reg_validate(u64 mask)
  {
  	if (!mask || mask & REG_RESERVED)
  		return -EINVAL;

+	if (mask & REG_NOSUPPORT)
+		return -EINVAL;
+
  	return 0;
  }


