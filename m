Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986CAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683112750D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtqdNP4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfFCPsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:48:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFCPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RHZ0xaAf/ckgPfj0zlFSV1kVsqjqoOm1zs8CgP8zISg=; b=EtqdNP4ltpzt4uTJqo5dA9Act
        MyEcDGtD9kzTFBGJHfXbYuBcW90l/2a4WwN3iiaLCEKzQ4S3t7K++jeHWY5Y6VwODX/+iuxXqduTZ
        HgN2/BCUqT+E7hc1Ze4c5c3JHX+6UDSVmg2tK//fryiFvubqmTZ52IgDVO82QqtOAGj86/fgMzlvv
        uNfBmxuvCLda1Uwvn0H5AaMZDhsecYz2MZPPJ3V1b9/Qy4pRPp0ClcUKaNI7t/dJF6NGfsKM1WXb2
        Xo8ReH/UB8I49VGHxyiPmFqzCWcT4/GsctlSrMaaI2ouUkgtBU3NYqE/U7PKrr6f9OsL89EwCHGJ6
        SOSEKAdtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXpBg-0004EG-8h; Mon, 03 Jun 2019 15:47:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5E1E2066CC1B; Mon,  3 Jun 2019 17:47:50 +0200 (CEST)
Date:   Mon, 3 Jun 2019 17:47:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, qiuxu.zhuo@intel.com,
        tony.luck@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH 2/3] perf/x86/intel: Add more Icelake CPUIDs
Message-ID: <20190603154750.GA3402@hirez.programming.kicks-ass.net>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190603134122.13853-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603134122.13853-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
> @@ -4962,7 +4965,9 @@ __init int intel_pmu_init(void)
>  		x86_pmu.cpu_events = get_icl_events_attrs();
>  		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
>  		x86_pmu.lbr_pt_coexist = true;
> -		intel_pmu_pebs_data_source_skl(false);
> +		intel_pmu_pebs_data_source_skl(
> +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_X) ||
> +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_XEON_D));

That's pretty sad, a model switch inside a model switch :/

>  		pr_cont("Icelake events, ");
>  		name = "icelake";
>  		break;

Would something like so not be nicer?

---
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4485,6 +4485,7 @@ __init int intel_pmu_init(void)
 	struct event_constraint *c;
 	unsigned int unused;
 	struct extra_reg *er;
+	bool pmem = false;
 	int version, i;
 	char *name;
 
@@ -4936,9 +4937,10 @@ __init int intel_pmu_init(void)
 		name = "knights-landing";
 		break;
 
+	case INTEL_FAM6_SKYLAKE_X:
+		pmem = true;
 	case INTEL_FAM6_SKYLAKE_MOBILE:
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
-	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
 		x86_add_quirk(intel_pebs_isolation_quirk);
@@ -4970,8 +4972,7 @@ __init int intel_pmu_init(void)
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
-		intel_pmu_pebs_data_source_skl(
-			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
+		intel_pmu_pebs_data_source_skl(pmem);
 
 		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
 			x86_pmu.flags |= PMU_FL_TFA;
@@ -4985,7 +4986,11 @@ __init int intel_pmu_init(void)
 		name = "skylake";
 		break;
 
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_XEON_D:
+		pmem = true;
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_DESKTOP:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -5009,7 +5014,7 @@ __init int intel_pmu_init(void)
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_skl(false);
+		intel_pmu_pebs_data_source_skl(pmem);
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
