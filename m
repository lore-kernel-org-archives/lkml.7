Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E4BC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41D121743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjLQ3kgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfGQHjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:39:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J0DX3eo5YEZ7czByoiftQzjyznMsu/Ci0NQ1fe80Fhk=; b=rjLQ3kgp2imt9Tw8aCCls2UXV
        8rm2o/GZHLT7HQtRFT3j/Jid7nIOOfPDdBgX+t3RitxkA+6m59gFHdn6j+/5VlXZw3qeIx+YG+Nmd
        R5OxzI3p1RAKYpdlvaJIyNHP5RrW08vQVA1K/ZB9FiatcAWB09TxLBx/UCNAwsQfOSjOBAJooiqhs
        uwf/XsndXJMUVtsaE8qYAJZo3JhalQudl9GVbex/IFOcyNwTUOQl9NTIMrv1V13hzqgFA9iI2MdEy
        v8DL73Y8VoL/G8tXUX7TVYdIA4UC+zgCVzkBI0KvSgmXPKnpzM3VnKznDw6BAUV5TOUHbgD/j/F1h
        wrQO+iQsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hneWB-0008Jf-1f; Wed, 17 Jul 2019 07:38:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58BB92059DEA3; Wed, 17 Jul 2019 09:38:24 +0200 (CEST)
Date:   Wed, 17 Jul 2019 09:38:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Message-ID: <20190717073824.GT3419@hirez.programming.kicks-ass.net>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715150601.205143057@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 05:04:03PM +0200, Thomas Gleixner wrote:
> Add a new entry to the preemption menu which enables the real-time support
> for the kernel. The choice is only enabled when an architecture supports
> it.
> 
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/Kconfig           |    3 +++
>  kernel/Kconfig.preempt |   25 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -809,6 +809,9 @@ config ARCH_NO_COHERENT_DMA_MMAP
>  config ARCH_NO_PREEMPT
>  	bool
>  
> +config ARCH_SUPPORTS_RT
> +	bool
> +
>  config CPU_NO_EFFICIENT_FFS
>  	def_bool n
>  
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -35,10 +35,10 @@ config PREEMPT_VOLUNTARY
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT
> +config PREEMPT_LL
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_COUNT
> +	select PREEMPT
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>  	help
>  	  This option reduces the latency of the kernel by making
> @@ -55,7 +55,28 @@ config PREEMPT
>  	  embedded system with latency requirements in the milliseconds
>  	  range.
>  
> +config PREEMPT_RT
> +	bool "Fully Preemptible Kernel (Real-Time)"
> +	depends on EXPERT && ARCH_SUPPORTS_RT
> +	select PREEMPT
> +	help
> +	  This option turns the kernel into a real-time kernel by replacing
> +	  various locking primitives (spinlocks, rwlocks, etc) with
> +	  preemptible priority-inheritance aware variants, enforcing
> +	  interrupt threading and introducing mechanisms to break up long
> +	  non-preemtible sections. This makes the kernel, except for very
> +	  low level and critical code pathes (entry code, scheduler, low
> +	  level interrupt handling) fully preemtible and brings most
> +	  execution contexts under scheduler control.
> +
> +	  Select this if you are building a kernel for systems which
> +	  require real-time guarantees.
> +
>  endchoice
>  
>  config PREEMPT_COUNT
>         bool
> +
> +config PREEMPT
> +       bool
> +       select PREEMPT_COUNT
> 
> 
