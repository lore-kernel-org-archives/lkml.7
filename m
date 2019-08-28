Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z7WlfHTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfH1HsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:48:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45132 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfH1HsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dtTOSEa7QGacXIdkTihnnzRJrhurHQuvQ1mNkz9ZHnA=; b=z7WlfHTD850qSMQMdAc/lI+W9
        BoNYDXuvq8n1kyAUdtPm/x5s5BOqxwj75NlT/JhAoYgDKxs54aJXBnS81njYVpWzV+yoEnOzMWjhV
        BzI6AbAplNLsWiBAROUMijmpbabP03Now9RF+V9ZtqzRdzAXDNQ6yH1Qmccpr4s+9Rg+//p9zxjTs
        tnB7ZUB8iu0dkR8z8XdfLD9/HSdJwcx+zQtMbjLRKrK/gN2Q1k82D8KEEw7KTkB0eb7jh2MgtrIYa
        /W/W92gFZ1oSksiWvYSRjS7e53Agr7Kc2NTvd+jDDBYWsf4aeKxrMNFW6RzwF3uHl+YCx/VuTRpCC
        o1jAwfcjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2sgX-0007D7-O1; Wed, 28 Aug 2019 07:48:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B3A93070F4;
        Wed, 28 Aug 2019 09:47:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6678420230B05; Wed, 28 Aug 2019 09:48:02 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:48:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 1/8] perf/x86/intel: Set correct mask for
 TOPDOWN.SLOTS
Message-ID: <20190828074802.GZ2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:33AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> TOPDOWN.SLOTS(0x0400) is not a generic event. It is only available on
> fixed counter3.
> 
> Don't extend its mask to generic counters.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>


> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 1392d5e6e8d6..457d35a75ad3 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -167,6 +167,11 @@ struct x86_pmu_capability {
>  #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
>  #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
>  
> +/* TOPDOWN.SLOTS: */
> +#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
> +#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
> +#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
> +
>  /*
>   * We model BTS tracing as another fixed-mode PMC.
>   *


This whole second hunk does not belong in this patch, probably the next
one.
