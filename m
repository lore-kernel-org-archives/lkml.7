Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hntl32Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:01:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDKJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uLk5Lt/7u9SSuSoo5JHD01HsvL3KPbuFB2ScCD2RXZI=; b=Hntl32SkejER9RbTcw4PdyKEl
        BkeACRc6qBHUvZ65MtSHQaq/6tN9JwiBjSFVefCB944MYa1/vlHU6q3mdJRtjWwbS3SU1Z2neo70r
        po4Y9utBv+eiUkGL+CjDvZzAwSpi8qMoO24CGT/zMpok15XJjxalzk7kurCnm1AN+kW2HifDqDFmG
        /aV6H+/Xec0SmkwPr78hnjwGLua8jd6QV1TR+bNVRraZOYwxkgGnZyBaSk7uKwDKWsYZYUutdZ6Pf
        PCPikBfWJ9WHz9SuxzmXmkSWIRoULHCvPVe2ryFUF9oZKyg2nd5KOvUX2KQ16f1zco+IgQ7KhlGEG
        BuuUXrJSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEVZq-00018K-Kr; Thu, 11 Apr 2019 09:00:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 796A529AA8DD3; Thu, 11 Apr 2019 11:00:56 +0200 (CEST)
Date:   Thu, 11 Apr 2019 11:00:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
Message-ID: <20190411090056.GK14281@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
 <20190408150654.GV12232@hirez.programming.kicks-ass.net>
 <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
 <688804aa-b6eb-0f19-828c-99b901bbe554@linux.intel.com>
 <20190410194720.GC11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410194720.GC11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:47:20PM +0200, Peter Zijlstra wrote:
> Sure, those are actually forced 0 with the existing thing.
> 
> I'll go fold smething like back in. Thanks!

> > @@ -3472,7 +3475,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc,
> > int idx,
> >  	 * Force instruction:ppp in Fixed counter 0
> >  	 */
> >  	if ((event->attr.precise_ip == 3) &&
> > -	    (event->hw.config == X86_CONFIG(.event=0xc0)))
> > +	    (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0)))
> >  		return &fixed_counter0_constraint;
> > 
> >  	return hsw_get_event_constraints(cpuc, idx, event);

Staring at that I came up with the below; how does that look?

Note: FIXED_EVENT_CONSTRAINT(0x00c0, 0) has FIXED_EVENT_FLAGS for
->cmask and includes the correct event code.

---
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3433,7 +3433,7 @@ icl_get_event_constraints(struct cpu_hw_
 	 * Force instruction:ppp in Fixed counter 0
 	 */
 	if ((event->attr.precise_ip == 3) &&
-	    (event->hw.config == X86_CONFIG(.event=0xc0)))
+	    constraint_match(&fixed_counter0_constraint, event->hw.config))
 		return &fixed_counter0_constraint;
 
 	return hsw_get_event_constraints(cpuc, idx, event);
