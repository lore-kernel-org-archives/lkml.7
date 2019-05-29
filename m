Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDFFC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CF92081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpWtvEz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2Ilz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:41:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2Ily (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ex7cwI1Y+T7IBQhxpqiVOAaTe/SzLACjja508VX2LQU=; b=gpWtvEz6EvTgc7TnciPDmZ0uZ
        nx6WzAdVB3SRP9VM+MVa2CYPHzeMWWzyMVIbRoNzwNqi9536+ODL7a5KcpE9D0mETIaVnuCP7Ghbj
        sxPjkMgUkCw/x78xOg15xQ+JR1isDEFx63hR5afjPWLdBhYEF4Qf9hZgiWpZ6HNKccLQh+ElgnplW
        RiBArqSiFDwFMdesPZSRP/yhzWz0GJaYA5tKORPTWGSxAcQ96dVO40xuK2ditoUdPISAOmRnJ/s3v
        LFtEQQlsXv394dFVSuvtKgMwEMhXQ8j9bHW+EhZmisHjMGbVaScf7bkXY8qP4EcasYZcMvig25eI6
        chdgLXsMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVu9B-0002aD-8s; Wed, 29 May 2019 08:41:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D228E201A7E41; Wed, 29 May 2019 10:41:18 +0200 (CEST)
Date:   Wed, 29 May 2019 10:41:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 3/3] preempt_tracer: Use a percpu variable to control
 traceble calls
Message-ID: <20190529084118.GG2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <9b0698774be3bb406e2b8b2c12dc1fb91532bff0.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0698774be3bb406e2b8b2c12dc1fb91532bff0.1559051152.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:16:24PM +0200, Daniel Bristot de Oliveira wrote:
>  #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
>  				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
> +
> +DEFINE_PER_CPU(int, __traced_preempt_count) = 0;
>  /*
>   * If the value passed in is equal to the current preempt count
>   * then we just disabled preemption. Start timing the latency.
>   */
>  void preempt_latency_start(int val)
>  {
> -	if (preempt_count() == val) {
> +	int curr = this_cpu_read(__traced_preempt_count);

We actually have this_cpu_add_return();

> +
> +	if (!curr) {
>  		unsigned long ip = get_lock_parent_ip();
>  #ifdef CONFIG_DEBUG_PREEMPT
>  		current->preempt_disable_ip = ip;
>  #endif
>  		trace_preempt_off(CALLER_ADDR0, ip);
>  	}
> +
> +	this_cpu_write(__traced_preempt_count, curr + val);
>  }
>  
>  static inline void preempt_add_start_latency(int val)
> @@ -3200,8 +3206,12 @@ NOKPROBE_SYMBOL(preempt_count_add);
>   */
>  void preempt_latency_stop(int val)
>  {
> -	if (preempt_count() == val)
> +	int curr = this_cpu_read(__traced_preempt_count) - val;

this_cpu_sub_return();

> +
> +	if (!curr)
>  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
> +	this_cpu_write(__traced_preempt_count, curr);
>  }

Can't say I love this, but it is miles better than the last patch.
