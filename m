Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8320C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47622075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ga0N9p2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfI3Pwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:52:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55262 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfI3Pwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mH7gQZaKxi2Jx9EMlvoafIvv+KMg8qLddjdePfPdPgg=; b=Ga0N9p2K+31NLEiYpk94Jc8Ya
        0vdGYwqVvH9qJCTg0eZrxf7/HZ5hNR7E6lvVqNB3PTPHYLYOOsBTgTNpA66YyVpse/ZgM2H0oBYca
        jDdmk0b8j94d5qlBaE220otsvZuIsqQHQAaJ2JiQCNzlpJGsbqMThnlCGm3/S/EJFE32CGqADjg7h
        RYUM/bFjzHTsSMtaMyMlgAgCrNqNe5woOkpjzVP687+vFTRd/7Io/SINSgwAmy4YCofI6NeLOYT9T
        wqI5CK/V5MUtt/IWNTP2ZLos0TYTGxlBCJj4up4oTMT0fqpsoEPO9pt+pPafVBLwSENhRw0LtYykk
        sbXXct5Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iExyh-0005bO-BX; Mon, 30 Sep 2019 15:52:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6913305DE2;
        Mon, 30 Sep 2019 17:51:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA1F8265261B4; Mon, 30 Sep 2019 17:52:44 +0200 (CEST)
Date:   Mon, 30 Sep 2019 17:52:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 08/14] perf/x86/intel: Support per thread RDPMC
 TopDown metrics
Message-ID: <20190930155244.GP4553@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-9-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916134128.18120-9-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:41:22AM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 71f3086a8adc..7ec0f350d2ac 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2262,6 +2262,11 @@ static int icl_set_topdown_event_period(struct perf_event *event)
>  		local64_set(&hwc->period_left, 0);
>  	}
>  
> +	if ((hwc->saved_slots) && is_first_topdown_event_in_group(event)) {
> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
> +		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
> +	}

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..c125068f2e16 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -133,6 +133,9 @@ struct hw_perf_event {
>  
>  			struct hw_perf_event_extra extra_reg;
>  			struct hw_perf_event_extra branch_reg;
> +
> +			u64		saved_slots;
> +			u64		saved_metric;
>  		};
>  		struct { /* software */
>  			struct hrtimer	hrtimer;

Normal counters save their counter value in hwc->period_left, why does
slots need a new word for that?

And since using METRIC means non-sampling, why can't we stick that
saved_metric field in one of the unused sampling fields?

ISTR asking this before...
