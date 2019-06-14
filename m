Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E03C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A94F20851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RqOZRS7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfFNNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:34:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfFNNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C0nBHLDkMzGog27NgS5rehy1Wv/08uCW/YzQiNw7nNs=; b=RqOZRS7urkSMLctNG2/1Ak12G
        f/4kQHDb+UbN4+940BDAXkw1woJik4UQ0ENEMnpn29ly5gI/CXJdX+l08QcStbFkmC0zMpWNGjc4C
        WEk5rb584twn+em5U7jBNkLRnOLXdnSoKmJzLWr5MOv/hEv/jGeWsDCFM4fe0ZKCQPzAMmm2+DDAa
        HwPEfLEaIUktNrPdwIKJ4a6E58LjOYEDRRGDcxDDJpiH9chmHcjMMzS7cfxAacSXSzFrdBbDhteHl
        GfdnjQgCFpUYAhbI88l+XnPm8iSKqpuDlMnxBcMLo5SMoBRwmD7NLqJJtqQBtdQRQBPcp5J+DrcXR
        TkIwqv4fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbmL2-00082H-Eq; Fri, 14 Jun 2019 13:33:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAAE520A3149A; Fri, 14 Jun 2019 15:33:50 +0200 (CEST)
Date:   Fri, 14 Jun 2019 15:33:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Tom Vaden <tom.vaden@hpe.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190614133350.GT3436@hirez.programming.kicks-ass.net>
References: <20190614112853.GC4325@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614112853.GC4325@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:28:53PM +0200, Jiri Olsa wrote:
> hi,
> the HPE server can do POST tracing and have enabled LBR
> tracing during the boot, which makes check_msr fail falsly.
> 
> It looks like check_msr code was added only to check on guests
> MSR access, would it be then ok to disable check_msr for real
> hardware? (as in patch below)
> 
> We could also check if LBR tracing is enabled and make
> appropriate checks, but this change is simpler ;-)
> 
> ideas? thanks,
> jirka
> 
> 
> ---
>  arch/x86/events/intel/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 71001f005bfe..1194ae7e1992 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -20,6 +20,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/apic.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/hypervisor.h>
>  
>  #include "../perf_event.h"
>  
> @@ -4050,6 +4051,13 @@ static bool check_msr(unsigned long msr, u64 mask)
>  {
>  	u64 val_old, val_new, val_tmp;
>  
> +	/*
> +	 * Disable the check for real HW, so we don't
> +	 * mess up with potentionaly enabled regs.
> +	 */
> +	if (hypervisor_is_type(X86_HYPER_NATIVE))
> +		return true;

Yeah, I think that works, or !boot_cpu_has(X86_FEATURE_HYPERVISOR).

>  	/*
>  	 * Read the current value, change it and read it back to see if it
>  	 * matches, this is needed to detect certain hardware emulators
> -- 
> 2.21.0
> 
