Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F03BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D5217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XBE7graK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfJ3QJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:09:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3QJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kcPrqbVUnmfXQZmxrWepdMoXRQPJWzMjiVTgu7lJo9U=; b=XBE7graKfw5CoSs4BDB9obFE+
        lpm+Vjh1Coh4gSYp7gb47HnFnB4XJN81SVg4u0QHsaW62pHcTmv1zex8gLy8n4heGOQI7G3dGwT5T
        8au/pVIZ81ulYHvy2cKu6WK0Q8v6X75sUWGCDUr4KbQpKLsEDApEF/vogCA84M6whGPPh2S1xy6VI
        +AChjcy1vLjFYBKJkRUOqVUf5hnJ9VBUmwG7D/775qKc6+Hdjeoe+X7381eOHkuIoEKoG7XurrNYy
        V1cTJiqiwg7cuui9MWuP0GUXGYHZxRtxuTPPeTZc/NmrSgT8CJRQcCm1Sux7WHfUphKtuykMPxHRG
        lOobFwKeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPqX0-0003AQ-5l; Wed, 30 Oct 2019 16:09:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11FF9306098;
        Wed, 30 Oct 2019 17:08:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43F5620D7FEEB; Wed, 30 Oct 2019 17:09:08 +0100 (CET)
Date:   Wed, 30 Oct 2019 17:09:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030160908.GS4114@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
 <20191029184739.GA3079@worktop.programming.kicks-ass.net>
 <20191030142110.GA17800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030142110.GA17800@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 03:21:10PM +0100, Oleg Nesterov wrote:
> On 10/29, Peter Zijlstra wrote:
> >
> > I like that symmetry, but see below ...
> 
> ...
> 
> > > void __percpu_up_read(struct percpu_rw_semaphore *sem)
> > > {
> > > 	smp_mb();
> > >
> > > 	__this_cpu_dec(*sem->read_count);
> > >
> > 	preempt_enable();
> > > 	wake_up(&sem->waiters);
> > 	preempt_disable()
> >
> > and this (sadly) means there's a bunch of back-to-back
> > preempt_disable()+preempt_enable() calls.
> 
> Hmm. Where did these enable+disable come from?
> 
> 	void __percpu_up_read(struct percpu_rw_semaphore *sem)
> 	{
> 		smp_mb();
> 
> 		__this_cpu_dec(*sem->read_count);
> 
> 		wake_up(&sem->waiters);
> 	}
> 
> should work just fine?

Not on PREEMPT_RT, because wake_up() will take wait_queue_head::lock,
which is spin_lock_t and turns into a pi_mutex, which we cannot take
with preemption disabled.
