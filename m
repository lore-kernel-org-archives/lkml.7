Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B585C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6720818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iv7w/Tb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfEQJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:07:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfEQJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2wSgE9jHWp8zeZBJCg0bOCUi1aKXMJLx0J1R6ddWCM=; b=iv7w/Tb+fLpedfpGrRNGzQZ5X
        GL8vRUa5YDhdjrqY+VtJ7VTXmLdJxq6wK6zbV12BJZhLSHW53PdbohFQopaG34eGf4s+PEZCnboHT
        KRyUaIi/tVgHXONylyWEXr7VY1ntwPVRm/8haMXOlNUenMMeFPxleR+fG8rK093vKaFwpxV6+hWuw
        vTS4fJNt5X1ktGymV9Q+yXJYQ45CNd2rc701woYh/du9wCcJwpyKy4BZj3EVF2wwvePgFh9qDX1PW
        W8C+0nnJWODLibPPFRKPHFJs763u20JGqCKWIwX9ouxMzXdJ71A3irPsmfnBYP8tHxbL4qHbxvuIJ
        SoNw+JqyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRYpe-0000u9-Fj; Fri, 17 May 2019 09:07:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0D422029B0A3; Fri, 17 May 2019 11:07:12 +0200 (CEST)
Date:   Fri, 17 May 2019 11:07:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org
Subject: Re: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Message-ID: <20190517090712.GR2650@hirez.programming.kicks-ass.net>
References: <20190516132148.10085-1-raphael.gault@arm.com>
 <20190516132148.10085-5-raphael.gault@arm.com>
 <20190517071018.GH2623@hirez.programming.kicks-ass.net>
 <20190517080419.dziz4iqc7t4mpoej@blommer>
 <20190517082655.GK2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517082655.GK2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:26:55AM +0200, Peter Zijlstra wrote:
> On Fri, May 17, 2019 at 09:04:20AM +0100, Mark Rutland wrote:
> 
> > Remember that this is in an undefined (trap) handler.
> > 
> > If userspace _attempts_ to write to the registers, the CPU will trap to the
> > kernel. The comment is perhaps misleading; when we "do nothing", the common
> > trap handling code will send a SIGILL to userspace.
> > 
> > It would probably be better to say something like:
> > 
> > 	/*
> > 	 * If userspace is tries to read a counter that doesn't exist on this
> > 	 * CPU, we emulate it as reading as zero. This happens if userspace is
> > 	 * preempted between reading the idx and actually reading the counter,
> > 	 * and the seqlock and idx have already changed, so it's as-if the
> > 	 * counter has been reprogrammed with a different event.
> 
> Might be good to mention that userspace will/should discard the value it
> reads, and therefore any value is good (including 0).
> 
> > 	 * We don't permit userspace to write to these registers, and will
> > 	 * inject a SIGILL.
> > 	 */
> > 
> > There is one caveat: userspace can write to PMSELR without trapping, so we will
> > have to context-switch with the task. That only affects indirect addressing of
> > PMU registers, and doesn't have a functional effect on the behaviour of the
> > PMU, so that's benign from the PoV of perf.
> 
> Sad though; ideally you'd state that indirect addressing is
> out-of-bounds and they get to keep the pieces. But I suspect you're
> right that people will do it anyway and complain once it comes apart.

I'm still not entirely convinced you need that context switching. If we
sched-out, the seqcount value will change, idem when we sched-in. So
under no circumstance (even if we stay on the same CPU), will the
seqcount match when we get back on.

So why preserve that register?
