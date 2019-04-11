Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD812084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hgZfpnUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:07:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDKJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M8EKQqdIJNnXRMIhAuKgVm5lBvKXJ8T5nUQTD2mpWeE=; b=hgZfpnUFTYR2eT1/ca0p3F2Ar
        nnLMRypG7zUcTQpgYJ5ONzt4B5USe5plDGVxVL4LZMgIw+/AGnZo6ui9IbJttWyULbhNeq/5XTmyn
        F1fmnFyEdkQm9y5Wh69dzqmSEuxWlFIQJvADKnhSqHFyW08INiSf8i4RdF3kcytzEvx2HcY0NzoA7
        SbMk1e35+2AtmyA4kCwZ+hkubrquMmQnUgdFH9QmlVx9yzAQy2UytCR5k8NantjVSVPxKGcDAMrsI
        S6h7dEtn/X7sCmYUcMD9emVR8zXW1Nx89qRuXnKUCrPx0dPAZ+ScSJfQWd4RtAPJ6OYQIs4cRbwNu
        ahDrv8YfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEVff-0002A3-Ru; Thu, 11 Apr 2019 09:07:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 583A729AA8DEC; Thu, 11 Apr 2019 11:06:58 +0200 (CEST)
Date:   Thu, 11 Apr 2019 11:06:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 2/2] perf/x86/intel: Add Tremont core PMU support
Message-ID: <20190411090658.GD4038@hirez.programming.kicks-ass.net>
References: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
 <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:57:09AM -0700, kan.liang@linux.intel.com wrote:
> +static struct event_constraint *
> +tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
> +			  struct perf_event *event)

That 'tnt' still cracks me up, I keep seeing explosions.

> +{
> +	struct event_constraint *c;
> +
> +	/*
> +	 * :ppp means to do reduced skid PEBS,
> +	 * which is available on PMC0 and fixed counter 0.
> +	 */
> +	if (event->attr.precise_ip == 3) {
> +		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
> +		if (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0))
> +			return &fixed0_counter0_constraint;
> +
> +		return &counter0_constraint;
> +	}
> +
> +	c = intel_get_event_constraints(cpuc, idx, event);
> +
> +	return c;
> +}

I changed that like so:

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3508,7 +3508,7 @@ tnt_get_event_constraints(struct cpu_hw_
 	 */
 	if (event->attr.precise_ip == 3) {
 		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
-		if (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0))
+		if (constraint_match(&fixed_counter0_constraint, event->hw.config))
 			return &fixed0_counter0_constraint;
 
 		return &counter0_constraint;


And maybe we should do:

	s/fixed_counter0_constraint/fixed0_constraint/'

Those two constraints only differ by a single character, that's bad for
reading comprehension.

In fact, I just did that too.
