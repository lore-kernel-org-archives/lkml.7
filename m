Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EAB2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDCLbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:31:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:31:02 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBe6R-0004at-NC; Wed, 03 Apr 2019 13:30:47 +0200
Date:   Wed, 3 Apr 2019 13:30:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     nelson.dsouza@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, vincent.weaver@maine.edu, eranian@google.com,
        hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        acme@redhat.com
cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Initialize TFA MSR
In-Reply-To: <tip-d7262457e35dbe239659e62654e56f8ddb814bed@git.kernel.org>
Message-ID: <alpine.DEB.2.21.1904031330060.1967@nanos.tec.linutronix.de>
References: <20190321123849.GN6521@hirez.programming.kicks-ass.net> <tip-d7262457e35dbe239659e62654e56f8ddb814bed@git.kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, tip-bot for Peter Zijlstra wrote:

> Commit-ID:  d7262457e35dbe239659e62654e56f8ddb814bed
> Gitweb:     https://git.kernel.org/tip/d7262457e35dbe239659e62654e56f8ddb814bed
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Thu, 21 Mar 2019 13:38:49 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 3 Apr 2019 11:40:32 +0200
> 
> perf/x86/intel: Initialize TFA MSR
> 
> Stephane reported that the TFA MSR is not initialized by the kernel,
> but the TFA bit could set by firmware or as a leftover from a kexec,
> which makes the state inconsistent.
> 
> Reported-by: Stephane Eranian <eranian@google.com>
> Tested-by: Nelson DSouza <nelson.dsouza@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vince Weaver <vincent.weaver@maine.edu>
> Cc: tonyj@suse.com
> Link: https://lkml.kernel.org/r/20190321123849.GN6521@hirez.programming.kicks-ass.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

This lacks:

 1) Fixes tag

 2) Cc: stable ....

Sigh.

> ---
>  arch/x86/events/intel/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 1539647ea39d..f61dcbef20ff 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
>  
>  	cpuc->lbr_sel = NULL;
>  
> +	if (x86_pmu.flags & PMU_FL_TFA) {
> +		WARN_ON_ONCE(cpuc->tfa_shadow);
> +		cpuc->tfa_shadow = ~0ULL;
> +		intel_set_tfa(cpuc, false);
> +	}
> +
>  	if (x86_pmu.version > 1)
>  		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
>  
> 
