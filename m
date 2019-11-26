Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD673C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943AA2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfKZUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:15:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:45565 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfKZUPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:15:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 12:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="206558824"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2019 12:15:10 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 28B11300B64; Tue, 26 Nov 2019 12:15:10 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
References: <20191126112234.GA22393@zn.tnic>
Date:   Tue, 26 Nov 2019 12:15:10 -0800
In-Reply-To: <20191126112234.GA22393@zn.tnic> (Borislav Petkov's message of
        "Tue, 26 Nov 2019 12:22:34 +0100")
Message-ID: <87zhgie6nl.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:
> +int msr_filter_write(u32 reg)
> +{
> +	/* all perf counter MSRs */
> +	switch (reg) {
> +	case MSR_K7_EVNTSEL0:
> +	case MSR_K7_PERFCTR0:
> +	case MSR_F15H_PERF_CTL:
> +	case MSR_F15H_PERF_CTR:
> +	case MSR_AMD64_IBSBRTARGET:
> +	case MSR_AMD64_IBSCTL:
> +	case MSR_AMD64_IBSFETCHCTL:
> +	case MSR_AMD64_IBSOPCTL:
> +	case MSR_AMD64_IBSOPDATA4:
> +	case MSR_AMD64_IBSOP_REG_COUNT:
> +	case MSR_AMD64_IBSOP_REG_MASK:
> +	case MSR_AMD64_IBS_REG_COUNT_MAX:
> +	case MSR_ARCH_PERFMON_EVENTSEL0:
> +	case MSR_ARCH_PERFMON_FIXED_CTR0:
> +	case MSR_ARCH_PERFMON_FIXED_CTR_CTRL:
> +	case MSR_ARCH_PERFMON_PERFCTR0:
> +	case MSR_CORE_C1_RES:
> +	case MSR_CORE_C3_RESIDENCY:
> +	case MSR_CORE_C6_RESIDENCY:
> +	case MSR_CORE_C7_RESIDENCY:
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_STATUS:
> +	case MSR_DRAM_ENERGY_STATUS:
> +	case MSR_F15H_CU_MAX_PWR_ACCUMULATOR:
> +	case MSR_F15H_CU_PWR_ACCUMULATOR:
> +	case MSR_F15H_NB_PERF_CTL:
> +	case MSR_F15H_PTSC:
> +	case MSR_F16H_L2I_PERF_CTL:
> +	case MSR_F17H_IRPERF:
> +	case MSR_IA32_APERF:
> +	case MSR_IA32_DEBUGCTLMSR:
> +	case MSR_IA32_DS_AREA:
> +	case MSR_IA32_MISC_ENABLE:
> +	case MSR_IA32_MPERF:
> +	case MSR_IA32_PEBS_ENABLE:
> +	case MSR_IA32_PERF_CAPABILITIES:
> +	case MSR_IA32_PMC0:
> +	case MSR_IA32_RTIT_ADDR0_A:
> +	case MSR_IA32_RTIT_ADDR0_B:
> +	case MSR_IA32_RTIT_ADDR1_A:
> +	case MSR_IA32_RTIT_ADDR1_B:
> +	case MSR_IA32_RTIT_ADDR2_A:
> +	case MSR_IA32_RTIT_ADDR2_B:
> +	case MSR_IA32_RTIT_ADDR3_A:
> +	case MSR_IA32_RTIT_ADDR3_B:
> +	case MSR_IA32_RTIT_CTL:
> +	case MSR_IA32_RTIT_OUTPUT_BASE:
> +	case MSR_IA32_RTIT_OUTPUT_MASK:
> +	case MSR_IA32_RTIT_STATUS:
> +	case MSR_IA32_THERM_STATUS:
> +	case MSR_IA32_VMX_MISC:
> +	case MSR_KNC_EVNTSEL0:
> +	case MSR_KNC_IA32_PERF_GLOBAL_CTRL:
> +	case MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL:
> +	case MSR_KNC_IA32_PERF_GLOBAL_STATUS:
> +	case MSR_KNC_PERFCTR0:
> +	case MSR_KNL_CORE_C6_RESIDENCY:
> +	case MSR_LBR_CORE_FROM:
> +	case MSR_LBR_CORE_TO:
> +	case MSR_LBR_INFO_0:
> +	case MSR_LBR_NHM_FROM:
> +	case MSR_LBR_NHM_TO:
> +	case MSR_LBR_SELECT:
> +	case MSR_LBR_TOS:
> +	case MSR_OFFCORE_RSP_0:
> +	case MSR_OFFCORE_RSP_1:
> +	case MSR_P4_ALF_ESCR0:
> +	case MSR_P4_ALF_ESCR1:
> +	case MSR_P4_BPU_CCCR0:
> +	case MSR_P4_BPU_ESCR0:
> +	case MSR_P4_BPU_ESCR1:
> +	case MSR_P4_BPU_PERFCTR0:
> +	case MSR_P4_BSU_ESCR0:
> +	case MSR_P4_BSU_ESCR1:
> +	case MSR_P4_CRU_ESCR0:
> +	case MSR_P4_CRU_ESCR1:
> +	case MSR_P4_CRU_ESCR2:
> +	case MSR_P4_CRU_ESCR3:
> +	case MSR_P4_CRU_ESCR4:
> +	case MSR_P4_CRU_ESCR5:
> +	case MSR_P4_DAC_ESCR0:
> +	case MSR_P4_DAC_ESCR1:
> +	case MSR_P4_FIRM_ESCR0:
> +	case MSR_P4_FIRM_ESCR1:
> +	case MSR_P4_FLAME_ESCR0:
> +	case MSR_P4_FLAME_ESCR1:
> +	case MSR_P4_FSB_ESCR0:
> +	case MSR_P4_FSB_ESCR1:
> +	case MSR_P4_IQ_ESCR0:
> +	case MSR_P4_IQ_ESCR1:
> +	case MSR_P4_IS_ESCR0:
> +	case MSR_P4_IS_ESCR1:
> +	case MSR_P4_ITLB_ESCR0:
> +	case MSR_P4_ITLB_ESCR1:
> +	case MSR_P4_IX_ESCR0:
> +	case MSR_P4_IX_ESCR1:
> +	case MSR_P4_MOB_ESCR0:
> +	case MSR_P4_MOB_ESCR1:
> +	case MSR_P4_MS_ESCR0:
> +	case MSR_P4_MS_ESCR1:
> +	case MSR_P4_PEBS_MATRIX_VERT:
> +	case MSR_P4_PMH_ESCR0:
> +	case MSR_P4_PMH_ESCR1:
> +	case MSR_P4_RAT_ESCR0:
> +	case MSR_P4_RAT_ESCR1:
> +	case MSR_P4_SAAT_ESCR0:
> +	case MSR_P4_SAAT_ESCR1:
> +	case MSR_P4_SSU_ESCR0:
> +	case MSR_P4_SSU_ESCR1:
> +	case MSR_P4_TBPU_ESCR0:
> +	case MSR_P4_TBPU_ESCR1:
> +	case MSR_P4_TC_ESCR0:
> +	case MSR_P4_TC_ESCR1:
> +	case MSR_P4_U2L_ESCR0:
> +	case MSR_P4_U2L_ESCR1:
> +	case MSR_PEBS_FRONTEND:
> +	case MSR_PEBS_LD_LAT_THRESHOLD:
> +	case MSR_PKG_C10_RESIDENCY:
> +	case MSR_PKG_C2_RESIDENCY:
> +	case MSR_PKG_C3_RESIDENCY:
> +	case MSR_PKG_C6_RESIDENCY:
> +	case MSR_PKG_C7_RESIDENCY:
> +	case MSR_PKG_C8_RESIDENCY:
> +	case MSR_PKG_C9_RESIDENCY:
> +	case MSR_PKG_ENERGY_STATUS:
> +	case MSR_PLATFORM_ENERGY_STATUS:
> +	case MSR_PLATFORM_INFO:
> +	case MSR_PP0_ENERGY_STATUS:
> +	case MSR_PP1_ENERGY_STATUS:
> +	case MSR_PPERF:
> +	case MSR_RAPL_POWER_UNIT:
> +	case MSR_SMI_COUNT:
> +		return -EPERM;


This will break a bazillion of tools that rely on programing many of
those MSRs from user space. Just do a search on github for all the MSR
names you're blocking. PMU use from ring 3 is a fairly common use case.

just from the top of my head:

https://github.com/opcm/pcm
https://github.com/RRZE-HPC/likwid
... likely many more ...

There were patches in the past to allow a user configurable list.
Something like that can make sense for some use models.

But a hard coded list is just a terrible bad idea.

For a "locked down" kernel the only case that can make sense
is to block write to MSRs that control memory writes. But that's only
a small fraction of the MSRs (afaik only DS_BASE and RTIT_OUTPUT*
from your list, but there are more I believe)

Also if there are blocks they would need to be model specific,
e.g. the P4_* MSRs often mean something different on other parts.

-Andi
