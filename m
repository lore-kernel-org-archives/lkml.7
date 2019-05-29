Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07441C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436420665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mso3y4TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfE2Iav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:30:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2Iat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qHlOuS3EPU1InrStLL0vWRkGRnAkkD7pqVRpdJuJgy8=; b=mso3y4TGmF//O2klOJuNi5Ofd
        Ae0hezHWGF3Isa/mqDehZennmq4YFa+C9l2QmT7+LM6OxEZLqIcZ7XXY4+XXwN3yW4ev75r/pUQ2d
        70WEW8k/NWN+oKT2AtMY4VQH/+0cD2ycbLeCdcJIRotXvkG/fPYrnN+sRnowaFc0KmT0NhPA2ivAf
        jjKdPideQFk4kJ/doFIzou6ooWrvGNXus3KmmsNX6eI/I96CPtlPAHEtKg3LCEx/BJz4AzI/vOT62
        xd/6eyZ8srT4S7rylnlCwOmApXl0ptqq5ykrYZU+tjxNADgj6WX5Oxuk55yRajvOEMvAxnIF9WjNo
        nCO47x4DQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVtxy-0002VE-OP; Wed, 29 May 2019 08:29:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EE30201A7E41; Wed, 29 May 2019 10:29:45 +0200 (CEST)
Date:   Wed, 29 May 2019 10:29:45 +0200
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
Subject: Re: [RFC 1/3] softirq: Use preempt_latency_stop/start to trace
 preemption
Message-ID: <20190529082945.GE2623@hirez.programming.kicks-ass.net>
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

Yeah, a header might not be a bad idea.

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

I'm thinking we can do without that empty line.

>  }
>  EXPORT_SYMBOL(__local_bh_disable_ip);
>  #endif /* CONFIG_TRACE_IRQFLAGS */
