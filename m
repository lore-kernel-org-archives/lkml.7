Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45519C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1184D218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itKCf7Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfDYMCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:02:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfDYMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1qJZVo8k8mfgYlmp5TlLC0v12e3deJx7zXBcLuuf09Y=; b=itKCf7UmuYpBuLWRVW2Bbm8gh
        Eu+0cXhmneoXZOnbipmmftF1WjzE0G/wpyQ38Uy9pfrFEaqqWy45fCY+vvi/by/YC31pQj0y/7lHp
        ygA+X46hJbobIbWwVh6nNxJ3sxwS1L3EfifLAgx9ylVR/1bVGwEVa97r7scrmrcquEceVsbF3qbxt
        g1mxIOpaZ362uDYeMnclHAN2Vg/uRhmD/Rh0CAwoRtrxdm4mcXrbyjD7F5e5Ud15VUxrmgYVdIcV8
        VDjlxiZMb+502NldtQH3Jb+AQwTNz0xu+aRZIkb6vN8AiVzusMN98hHOEqkD+os7O1i0Gkd5Apo8u
        +VshWaI7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJd55-00010Y-34; Thu, 25 Apr 2019 12:02:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9295A29C22B16; Thu, 25 Apr 2019 14:02:21 +0200 (CEST)
Date:   Thu, 25 Apr 2019 14:02:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Message-ID: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
 <20190411033448.20842-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411033448.20842-4-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
> opt-in to allowing suspend to occur on one of the housekeeping CPUs
> rather than hardcoded CPU0.
> 
> This will allow CPU0 to be a nohz_full CPU with a later change.
> 
> It may be possible for platforms with hardware/firmware restrictions
> on suspend/wake effectively support this by handing off the final
> stage to CPU0 when kernel housekeeping is no longer required. Another
> option is to make housekeeping / nohz_full mask dynamic at runtime,
> but the complexity could not be justified at this time.

Should we not tie this into whatever already allows an achitecture to
hotplug CPU-0? For instance, x86 default disallows this but has
cpu0_hotpluggable to allow this.

Presumably POWER already allows hotplugging CPU-0 ?


