Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B172321841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eSTVvxeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCWR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:28:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfCWR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pb+nlZzB0UKrWEiXjipJ113WH1T6j+BFJ90ujudh600=; b=eSTVvxeqcEDfyG4wO42M9nPxA
        AzeuYU3Hz19RZfwkcEHDm1oBVEAANu3sK0O/KZYmeltHi3UpBbmjzhm0WEkpOue1iunJctHawURZ3
        5afLDsHtTwnNlfHZ3itm0C/u5ldHIlPdPUZY1c8F6sFArYyaT3qjv9oph8Chd2sh9S3JhSSsEgCBf
        UU9BqPgLC/F0z/uY0YI3Elu4jPDe6sOQ3NzrbI3NVrz5+iaLgM8x2Mss/uku0UYhammbEjtRBI7dd
        bAWofrkbCP5E4TcnGkFyahx9fCwYWb1CRJ1CgtYDaxX4QqTQ+5qZysbW3TcY25wOkyEcoG1xzGtQp
        p1hhEw9iQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7kR9-000526-2H; Sat, 23 Mar 2019 17:28:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AFFA203C06F3; Sat, 23 Mar 2019 18:28:00 +0100 (CET)
Date:   Sat, 23 Mar 2019 18:28:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
Message-ID: <20190323172800.GD6058@hirez.programming.kicks-ass.net>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:18:03PM +0800, Like Xu wrote:
> === Brief description ===
> 
> This proposal for Intel vPMU is still committed to optimize the basic
> functionality by reducing the PMU virtualization overhead and not a blind
> pass-through of the PMU. The proposal applies to existing models, in short,
> is "host perf would hand over control to kvm after counter allocation".
> 
> The pmc_reprogram_counter is a heavyweight and high frequency operation
> which goes through the host perf software stack to create a perf event for
> counter assignment, this could take millions of nanoseconds. The current
> vPMU always does reprogram_counter when the guest changes the eventsel,
> fixctrl, and global_ctrl msrs. This brings too much overhead to the usage
> of perf inside the guest, especially the guest PMI handling and context
> switching of guest threads with perf in use.

I think I asked for starting with making pmc_reprogram_counter() less
retarded. I'm not seeing that here.

> We optimize the current vPMU to work in this manner:
> 
> (1) rely on the existing host perf (perf_event_create_kernel_counter)
>     to allocate counters for in-use vPMC and always try to reuse events;
> (2) vPMU captures guest accesses to the eventsel and fixctrl msr directly
>     to the hardware msr that the corresponding host event is scheduled on
>     and avoid pollution from host is also needed in its partial runtime;

If you do pass-through; how do you deal with event constraints?

> (3) save and restore the counter state during vCPU scheduling in hooks;
> (4) apply a lazy approach to release the vPMC's perf event. That is, if
>     the vPMC isn't used in a fixed sched slice, its event will be released.
> 
> In the use of vPMC, the vPMU always focus on the assigned resources and
> guest perf would significantly benefit from direct access to hardware and
> may not care about runtime state of perf_event created by host and always
> try not to pay for their maintenance. However to avoid events entering into
> any unexpected state, calling pmc_read_counter in appropriate is necessary.

what?!

I can't follow that, and the quick look I had at the patches doesn't
seem to help. I did note it is intel only and that is really sad.

It also makes a mess of who programs what msr when.
