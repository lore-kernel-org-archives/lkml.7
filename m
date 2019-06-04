Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F180EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D95245BC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jRytlmPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfFDLrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:47:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfFDLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9wuTa603w+SqStPamvP3MUdukRk8xI2CxDP7Kut8vY0=; b=jRytlmPG1KD1jUNei/lIj+aVy
        0iVLl7FLtEYXL4AFb8/rF1RnkD5pn0ucGDVaH1a2rvvEzfiS8UkBLX4wDMEet88gjZ2xOp7YX8z87
        iJjkRgx4Y3hnHpZMW7OFgDSX+ckdsN/0YVE+HvPXWoJE6ekz1m+1dmNqnyGwrEdCAb4QB8+EdLreW
        bL/kO0RkQuj+vdtyqDo2LlhhP26U4qxRV4TsKd1tILh/hAG6f/jOuZJnyBqRoCW0TmfPSE4W5csJB
        OTF1dkNtU8SjWKv/hC4NBYvj4NeMZpDg0dRW/3JXxpLDTF/9CwOm9ZpyF3LHYr/5+SyIoz7E84ztX
        269eLr9gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY7uB-0004ZW-24; Tue, 04 Jun 2019 11:47:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 754BD20114D6C; Tue,  4 Jun 2019 13:47:01 +0200 (CEST)
Date:   Tue, 4 Jun 2019 13:47:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/fpu: Simplify kernel_fpu_begin
Message-ID: <20190604114701.GM3402@hirez.programming.kicks-ass.net>
References: <20190604071524.12835-1-hch@lst.de>
 <20190604071524.12835-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604071524.12835-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:15:23AM +0200, Christoph Hellwig wrote:
> +void kernel_fpu_begin(void)
>  {
> +	preempt_disable();
>  
>  	WARN_ON_FPU(!irq_fpu_usable());
> +	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>  
> +	this_cpu_write(in_kernel_fpu, true);
>  
> +	if (current->mm && !test_thread_flag(TIF_NEED_FPU_LOAD)) {

Did that want to be: !(current->flags & PF_KTHREAD), instead?

Because I'm thinking that kernel_fpu_begin() on a kthread that has
use_mm() employed shouldn't be doing this..

> +		set_thread_flag(TIF_NEED_FPU_LOAD);
> +		/*
> +		 * Ignore return value -- we don't care if reg state
> +		 * is clobbered.
> +		 */
> +		copy_fpregs_to_fpstate(&current->thread.fpu);
>  	}
>  	__cpu_invalidate_fpregs_state();
>  }
