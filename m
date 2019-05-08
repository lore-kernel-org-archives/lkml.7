Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC09921479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mG9tL+gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEHJsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:48:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfEHJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v+71M332UXNBSlbUY7jj+oibuunkF96AhkeeWgjS37E=; b=mG9tL+gdBaPBW8xOKZfRz7U6L
        5tncrv4CVFt6B3yjUOwBWi7hM2OWFgzhQD8FUXgMOr3msbzlcblRj06YnOiL/1MqGwtQKvVoVRFiE
        0R6dzUbkKqp4hvIaj8R768F1Pyd/d/oTHZFBujieaKTNYGX+QgG1fMo4iavltX03VlZ7XGF8qtM2e
        7n/r2HrMqsltKDahm+GWRt8y17MZbd7tbbmYm653dcXLgullDXqAfA9dGkcwhv/WKGaGQC4wEJmok
        N6EVBHPB3RtOZNzVGLL7IfYrNpNfLjKC5zlSTdoYiGlwsc2CGlLDr3opVvnG+8P+v9GJFSoxnl6t8
        RVhYXgyJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOJBA-0007mW-N3; Wed, 08 May 2019 09:48:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE3092029F886; Wed,  8 May 2019 11:47:58 +0200 (CEST)
Date:   Wed, 8 May 2019 11:47:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Provide a pointer to the valid CPU mask
Message-ID: <20190508094758.GE2606@hirez.programming.kicks-ass.net>
References: <20190423142636.14347-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423142636.14347-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:26:36PM +0200, Sebastian Andrzej Siewior wrote:
> In commit 4b53a3412d66 ("sched/core: Remove the tsk_nr_cpus_allowed()
> wrapper") the tsk_nr_cpus_allowed() wrapper was removed. There was not
> much difference in !RT but in RT we used this to implement
> migrate_disable(). Within a migrate_disable() section the CPU mask is
> restricted to single CPU while the "normal" CPU mask remains untouched.
> 
> As an alternative implementation Ingo suggested to use
> 	struct task_struct {
> 		const cpumask_t		*cpus_ptr;
> 		cpumask_t		cpus_mask;
>         };
> with
> 	t->cpus_allowed_ptr = &t->cpus_allowed;
> 
> In -RT we then can switch the cpus_ptr to
> 	t->cpus_allowed_ptr = &cpumask_of(task_cpu(p));
> 
> in a migration disabled region. The rules are simple:
> - Code that 'uses' ->cpus_allowed would use the pointer.
> - Code that 'modifies' ->cpus_allowed would use the direct mask.
> 
> I proposed this patch as a series earlier and it was shutdown due to the
> migrate_disable() bits. It has been said that migrate_disable() should
> only be used with RT and thus not introduced without it.
> I hereby propose only the mask CPU-bits.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

OK I suppose; I still think that accessor was the nicer solution, but
whatever. Queued for after the merge window.
