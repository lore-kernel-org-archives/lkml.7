Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F05CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F019F2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i31MA9fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJ3Tbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:31:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3Tbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rfdo/rcazoLb0OWD+u7HbTHQ21RxReqCm8KyZ3FP7PY=; b=i31MA9fJrE2MbQkRP5Dz0+Lqk
        bKU67O1CWgakyLIZR7iNQztCC55hVphOJxSi5Ncpf1rdWY38haYOOV1gBjTJMn5M/42VKf3sRj8hL
        Cw1iw4GDbw5cv9O2LyNJXr1G1gHDdHZNiWhm5C4jUw4P8J1boL89KYFai/oBcgLY5EYoCT7WfHQ6z
        A4cnrIl/NQ8c4pvAlZ9ycMlCToh5rnoh4ozUVbS9CNoJGPzBFap3LL9fWRcGJXPIAHmQ1wBgvohFr
        WRC91W33ZYZfGGl8/BAJtMtnDZfalzVXExMBM7rQbBU+OYv9RAaR2l1d1QDZug5D3/5JemPluEZap
        QSJ1/t6mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPtgp-0003B1-GL; Wed, 30 Oct 2019 19:31:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA45230025A;
        Wed, 30 Oct 2019 20:30:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B2872022B9E2; Wed, 30 Oct 2019 20:31:29 +0100 (CET)
Date:   Wed, 30 Oct 2019 20:31:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030193129.GA32308@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
 <20191029184739.GA3079@worktop.programming.kicks-ass.net>
 <20191030175231.GF5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030175231.GF5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:52:31PM +0100, Peter Zijlstra wrote:
> @@ -58,16 +72,17 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
>  	preempt_enable();
>  }
>  
> -static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
> +static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
>  {
> -	int ret = 1;
> +	bool ret = true;
>  
>  	preempt_disable();
>  	/*
>  	 * Same as in percpu_down_read().
>  	 */
> -	__this_cpu_inc(*sem->read_count);
> -	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
> +	if (likely(!rcu_sync_is_idle(&sem->rss)))

That should obviously also loose the !

> +		__this_cpu_inc(*sem->read_count);
> +	else
>  		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
>  	preempt_enable();
>  	/*
