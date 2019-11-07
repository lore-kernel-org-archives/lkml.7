Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B4C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FF02166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gXb7KSaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfKGJY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:24:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfKGJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tLGsy1KJjZYrj0OGk4yLffmLnEGEnnfdY+mEk/oaaoU=; b=gXb7KSaRJh4mThhk7wE+bKmn9
        fqBlFfeVbuUlrC/s0EX4NC7Jnvmf3yNwKXZxrgCPFzYVvfxIzqB5K8Q5cJ7rADa8npA6PeMa70MTL
        +Jd09qpgbroSse9rTnnVz/xUpL1hSt+VmsTsKvIsM0fCX30PHqHVaTDhYLVYPwR9UKbBo8k2OjwgK
        Cg37D6dfWcihfZA3ja76/Q1ZdMqL9xbjYegi3DUA7a9rXc6MLCaTqSXvmRX2hSKg1GEgk/vC4HwB0
        TOfIWphyruYYxG3lqbdT82Bg85PYbdWaE9pXQuQV7vuEpIW3JYHr//MqFf8iErhKPPCTM0qdm1+Ra
        /esi/j6vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSe24-0002gb-QB; Thu, 07 Nov 2019 09:24:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CD6B301747;
        Thu,  7 Nov 2019 10:23:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E39AF20D7FEFF; Thu,  7 Nov 2019 10:24:41 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:24:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 02/12] futex: Move futex exit handling into futex code
Message-ID: <20191107092441.GC4131@hirez.programming.kicks-ass.net>
References: <20191106215534.241796846@linutronix.de>
 <20191106224556.049705556@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106224556.049705556@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:55:36PM +0100, Thomas Gleixner wrote:

> -#ifdef CONFIG_FUTEX
> -	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list(tsk);
> -		tsk->robust_list = NULL;
> -	}
> -#ifdef CONFIG_COMPAT
> -	if (unlikely(tsk->compat_robust_list)) {
> -		compat_exit_robust_list(tsk);
> -		tsk->compat_robust_list = NULL;
> -	}
> -#endif
> -	if (unlikely(!list_empty(&tsk->pi_state_list)))
> -		exit_pi_state_list(tsk);
> -#endif

> +void futex_mm_release(struct task_struct *tsk)
> +{
> +	if (unlikely(tsk->robust_list)) {
> +		exit_robust_list(tsk);
> +		tsk->robust_list = NULL;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_COMPAT)) {
> +		if (unlikely(tsk->compat_robust_list)) {
> +			compat_exit_robust_list(tsk);
> +			tsk->compat_robust_list = NULL;
> +		}
> +	}

I suppose it is this substitution that causes the compile error mingo
found. The problem with IS_ENABLED() is that the whole block still needs
to compile (before it can be thrown out), and in this case
tsk->compat_robust_list doesn't exist.

> +
> +	if (unlikely(!list_empty(&tsk->pi_state_list)))
> +		exit_pi_state_list(tsk);
> +}
