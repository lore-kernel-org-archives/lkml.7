Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED2C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FDE208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfFYO6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbfFYO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C53E7FDEC;
        Tue, 25 Jun 2019 14:58:37 +0000 (UTC)
Received: from krava (unknown [10.40.205.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 080466012C;
        Tue, 25 Jun 2019 14:58:35 +0000 (UTC)
Date:   Tue, 25 Jun 2019 16:58:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, jolsa@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: Fix spurious NMI on fixed counter
Message-ID: <20190625145834.GA8480@krava>
References: <20190625142135.22112-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625142135.22112-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 25 Jun 2019 14:58:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:21:35AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> If a user first sample a PEBS event on a fixed counter, then sample a
> non-PEBS event on the same fixed counter on Icelake, it will trigger
> spurious NMI. For example,
> 
>   perf record -e 'cycles:p' -a
>   perf record -e 'cycles' -a
> 
> The error message for spurious NMI.
> 
>   [June 21 15:38] Uhhuh. NMI received for unknown reason 30 on CPU 2.
>   [  +0.000000] Do you have a strange power saving mode enabled?
>   [  +0.000000] Dazed and confused, but trying to continue
> 
> The issue was introduced by the following commit:
> 
>   commit 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
> 
> The commit moves the intel_pmu_pebs_disable() after
> intel_pmu_disable_fixed(), which returns immediately.
> The related bit of PEBS_ENABLE MSR will never be cleared for the fixed
> counter. Then a non-PEBS event runs on the fixed counter, but the bit
> on PEBS_ENABLE is still set, which trigger spurious NMI.
> 
> Check and disable PEBS for fixed counter after intel_pmu_disable_fixed().
> 
> Reported-by: Yi, Ammy <ammy.yi@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Fixes: 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
> ---
>  arch/x86/events/intel/core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4377bf6a6f82..464316218b77 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2160,12 +2160,10 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
>  	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
>  
> -	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
> +	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
>  		intel_pmu_disable_fixed(hwc);
> -		return;
> -	}
> -
> -	x86_pmu_disable_event(event);
> +	else
> +		x86_pmu_disable_event(event);
>  

oops, I overlooed this, looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  	/*
>  	 * Needs to be called after x86_pmu_disable_event,
> -- 
> 2.14.5
> 
