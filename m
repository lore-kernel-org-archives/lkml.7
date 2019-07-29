Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A15C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBF7205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SN8oRnKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfG2UDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:03:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390053AbfG2TqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=arjAFJhp7h7y5/Rhm9vbvSAfd/7R4cvilJkOjN26CHs=; b=SN8oRnKNdwiYVQc5vagAqPbm+
        nhxf5g6kbo+jKIaT6WgKBcfCA8UcqWtLb5tfvvfPr0DnCW4uPrM2lOtfI2Fox14O7d9d/Bl0Hvb2X
        OQBjh31Ya9sBlmKEvwiddNcyOKFWtTMswOB+Iobowmyi48gpJUkxMGD1ABNN7QrOWfmR4/zORTOjr
        ePtw/rxjoexYv6kZpzSRnYMWA6r+WBQxmFTho+98N2VB2Z6XXL5C1yglMxjq2KMDaoGzdMBu049b2
        c8uWJ1RE7Qal8WtUdrLdzFAuyUPkktjOOqxfaZPtxSJvHqAhYYRA9B+mApJCjR2WJH+7hqvKtJp6r
        gwnx5hhLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsBaj-0006AY-6P; Mon, 29 Jul 2019 19:45:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C45020C9B161; Mon, 29 Jul 2019 21:45:50 +0200 (CEST)
Date:   Mon, 29 Jul 2019 21:45:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/12] (hr)timers: Prepare for PREEMPT_RT support
Message-ID: <20190729194550.GP31398@hirez.programming.kicks-ass.net>
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726183048.982726647@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:30:48PM +0200, Thomas Gleixner wrote:
> The following series brings the bulk of PREEMPT_RT specific changes for the
> (hr)timer code:
> 
>   - Handle timer deletion correctly under RT to avoid priority inversion
>     and life locks
> 
>     This mechanism might be useful for VMs as well when a vCPU
>     executing a timer callback gets scheduled out and on another vCPU
>     del_timer_sync() or hrtimer_cancel() is invoked.
> 
>     The mitigation would only work when paravirt spinlocks are
>     enabled. I've not implemented that, as I don't know whether this is a
>     real world issue. I just noticed that it is basically the same
>     problem. Adding it would be trivial.
> 
>   - Prepare for moving most hrtimer callbacks into softirq context and mark
>     timers which need to expire in hard interrupt context even on RT so
>     they don't get moved.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
