Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44947C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2021849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A87ug+yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfGRQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:06:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CDwEGY8hvSUCeppe1h5aNTwi/2OwtesE3l3LkHtIONs=; b=A87ug+yJ6JdD5GxZM0VjyV94v
        D+s34s4VvEiaTkb0MAwDZxmSltvwXYkxINrX0eAdGn0rluGitXOJ/VyqiqPefzttMqN0C4QGd240y
        A933wTHLOzorZSf1Hlm6GpKKzMJ5ma/wVNMbyjm2HuRNQujyp9ER/+T634O4ags4rUMevh64p5wkC
        qxIlYf0f9jHrUfFn/PwWCDxXtdlkL/2UXOc6/zc8n2eBDvTHvbyyzP5Syck3bOVd0a52v6XrbIk3w
        5NvpG+N5/VpMTznyKbzUguHYF/nO8BgjSeyB4xZPJV3yjf9qpKonYjjdsRNEowgavdZ8UjLIkQy0h
        jnPWFUS9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho8uy-0001XW-MG; Thu, 18 Jul 2019 16:06:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0679C20B94DC4; Thu, 18 Jul 2019 18:06:02 +0200 (CEST)
Date:   Thu, 18 Jul 2019 18:06:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     luferry <luferry@163.com>, Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] smp: avoid generic_exec_single cause system lockup
Message-ID: <20190718160601.GP3402@hirez.programming.kicks-ass.net>
References: <20190718080308.48381-1-luferry@163.com>
 <alpine.DEB.2.21.1907181007340.1778@nanos.tec.linutronix.de>
 <5f5fbd7.1073c.16c0446ea63.Coremail.luferry@163.com>
 <alpine.DEB.2.21.1907181122240.1984@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907181122240.1984@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:58:47AM +0200, Thomas Gleixner wrote:
> Subject: smp: Warn on function calls from softirq context
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 18 Jul 2019 11:20:09 +0200
> 
> It's clearly documented that smp function calls cannot be invoked from
> softirq handling context. Unfortunately nothing enforces that or emits a
> warning.
> 
> A single function call can be invoked from softirq context only via
> smp_call_function_single_async().
> 
> Reported-by: luferry <luferry@163.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/smp.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -291,6 +291,15 @@ int smp_call_function_single(int cpu, sm
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>  		     && !oops_in_progress);
>  
> +	/*
> +	 * Can deadlock when the softirq is executed on return from
> +	 * interrupt and the interrupt hit between llist_add() and
> +	 * arch_send_call_function_single_ipi() because then this
> +	 * invocation sees the list non-empty, skips the IPI send
> +	 * and waits forever.
> +	 */
> +	WARN_ON_ONCE(is_serving_softirq() && wait);
> +
>  	csd = &csd_stack;
>  	if (!wait) {
>  		csd = this_cpu_ptr(&csd_data);
> @@ -416,6 +425,13 @@ void smp_call_function_many(const struct
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>  		     && !oops_in_progress && !early_boot_irqs_disabled);
>  
> +	/*
> +	 * Bottom half handlers are not allowed to call this as they might
> +	 * corrupt cfd_data when the interrupt which triggered softirq
> +	 * processing hit this function.
> +	 */
> +	WARN_ON_ONCE(is_serving_softirq());
> +
>  	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
>  	cpu = cpumask_first_and(mask, cpu_online_mask);
>  	if (cpu == this_cpu)

As we discussed on IRC, it is worse, we can only use these functions
from task/process context. We need something like the below.

I've build a kernel with this applied and nothing went *splat*.

diff --git a/kernel/smp.c b/kernel/smp.c
index 616d4d114847..7dbcb402c2fc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -291,6 +291,14 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	csd = &csd_stack;
 	if (!wait) {
 		csd = this_cpu_ptr(&csd_data);
@@ -416,6 +424,14 @@ void smp_call_function_many(const struct cpumask *mask,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress && !early_boot_irqs_disabled);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
