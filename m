Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OyJ+5Ff8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfE2JbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:31:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2Ja7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:30:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so1231542pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ohlWmHHIFRkvqwfurOwZvhZIyOaX8C5tuNXmlsaf2Zg=;
        b=OyJ+5Ff8qJKE4/SrSJjVedT9u/JhuA89rp+gKRux0xOcrVQdr0DCLLDSJUNszi2QSK
         rrnxsCj327DtOgihPRi8eeJoNQKuG/IkQLCadjzsSa5ZkLPngaiq3StBEzzeawMKH19S
         oCTk6l8vQZQSR6I09YtyEoRwlvPz+cgGEneCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ohlWmHHIFRkvqwfurOwZvhZIyOaX8C5tuNXmlsaf2Zg=;
        b=JOHH784XytZHFPLQUfU4PWbdh6ABMU3m+OhTfEx8PktwSPeU/MwO9J6jG5Xyk8YnOi
         dABHMo6a0aNX/OuZghpL55vZKz1b8yEDG0xu2lScJQmWYVdX0obN0hVJpTXNfN9fvI0G
         71cr2wo2mq6gSpUlHb8FRtn85a/eqHcnAfvTdDWkmg/jpR/ENis5XhRjSj2qYdt6ZKP+
         l4YoKUu/l5a3kdk3aGCJ+8fiYQjMMeMCH+eR5W1Sy66Y1OVPlHlNYJD1zgklqrhtnwnG
         dryBT7XyVHANTLP3pOlG9YjcDoUjzxaWp0Ac9nlO81afYVK+lrOkk/xzFf2PKNpc+Y5W
         RiiQ==
X-Gm-Message-State: APjAAAVZn8CeKszP8ZKCtHDrQlq7vnVDoyQoqbomrJ3am5/mRECz3lhn
        HczlW1HwoxE8Wf3p7MPo4QlK3g==
X-Google-Smtp-Source: APXvYqxgioU9CZJfrCSlykl2+7r5vNeFy9ypEHEzhyeGwV/Z5mUxy8uPnOjYSAl3KzFRAaYwViW48w==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr32947270pff.13.1559122258736;
        Wed, 29 May 2019 02:30:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l13sm4806102pjq.20.2019.05.29.02.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 02:30:57 -0700 (PDT)
Date:   Wed, 29 May 2019 05:30:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 1/3] softirq: Use preempt_latency_stop/start to trace
 preemption
Message-ID: <20190529093056.GA146079@google.com>
References: <cover.1559051152.git.bristot@redhat.com>
 <b6bb4705efb0c01c11008ae3c46bc74555245303.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bb4705efb0c01c11008ae3c46bc74555245303.1559051152.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:16:22PM +0200, Daniel Bristot de Oliveira wrote:
> prempt_disable/enable tracepoints occurs only in the preemption
> enabled <-> disable transition. As preempt_latency_stop() and
> preempt_latency_start() already do this control, avoid code
> duplication by using these functions in the softirq code as well.
> 
> RFC: Should we move preempt_latency_start/preempt_latency_stop
> to a trace source file... or even a header?

Yes, I think so. Also this patch changes CALLER_ADDR0 passed to the
tracepoint because there's one more level of a non-inlined function call
in the call chain right?  Very least the changelog should document this
change in functional behavior, IMO.

Looks like a nice change otherwise, thanks!


> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/core.c |  4 ++--
>  kernel/softirq.c    | 13 +++++--------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..8c0b414e45dc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3152,7 +3152,7 @@ static inline void sched_tick_stop(int cpu) { }
>   * If the value passed in is equal to the current preempt count
>   * then we just disabled preemption. Start timing the latency.
>   */
> -static inline void preempt_latency_start(int val)
> +void preempt_latency_start(int val)
>  {
>  	if (preempt_count() == val) {
>  		unsigned long ip = get_lock_parent_ip();
> @@ -3189,7 +3189,7 @@ NOKPROBE_SYMBOL(preempt_count_add);
>   * If the value passed in equals to the current preempt count
>   * then we just enabled preemption. Stop timing the latency.
>   */
> -static inline void preempt_latency_stop(int val)
> +void preempt_latency_stop(int val)
>  {
>  	if (preempt_count() == val)
>  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 2c3382378d94..c9ad89c3dfed 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -108,6 +108,8 @@ static bool ksoftirqd_running(unsigned long pending)
>   * where hardirqs are disabled legitimately:
>   */
>  #ifdef CONFIG_TRACE_IRQFLAGS
> +extern void preempt_latency_start(int val);
> +extern void preempt_latency_stop(int val);
>  void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  {
>  	unsigned long flags;
> @@ -130,12 +132,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>  		trace_softirqs_off(ip);
>  	raw_local_irq_restore(flags);
>  
> -	if (preempt_count() == cnt) {
> -#ifdef CONFIG_DEBUG_PREEMPT
> -		current->preempt_disable_ip = get_lock_parent_ip();
> -#endif
> -		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
> -	}
> +	preempt_latency_start(cnt);
> +
>  }
>  EXPORT_SYMBOL(__local_bh_disable_ip);
>  #endif /* CONFIG_TRACE_IRQFLAGS */
> @@ -144,8 +142,7 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	if (preempt_count() == cnt)
> -		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +	preempt_latency_stop(cnt);
>  
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -- 
> 2.20.1
> 
