Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8251E2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DSuy0LLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfJ3Srd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:47:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfJ3Srd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1nzZur3YfoSXJfJqcb8vdwf0YnsifQ3iInz0JeAESnM=; b=DSuy0LLGbS6WvGW3toK6pj9Vh
        fmm+cUxHijD4K2csXzP3wpKc2iycMAsmVgmhEWsOP3EkdxXNl30gWTCL3/ekj1BLIe9UbB4WVonRi
        bIOG9sbEQxke3qOqJoSm916BzE5RMe0KGpPqSz76rQ0WRWRNr04SbMF3WL2lQfSD9/NCQ+0TmIPH5
        R4EUBJRY94a+lFWUp5K5Tl9UQwJfR2pop0+kbUnUvqoJsZWwuhJBHQl3KjQ71Cpy9VyHCMWleKQFA
        dEulRZFqSWHiF3bmAhfaEZy7NI4hw2oQmYjQooK8ZJMjKrKbRwKiwTF5r4XjNaq8hsAH0oTF3JfbG
        J7+azzWaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPt08-0005EA-VW; Wed, 30 Oct 2019 18:47:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1485630025A;
        Wed, 30 Oct 2019 19:46:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55D292B44D06F; Wed, 30 Oct 2019 19:47:23 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:47:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191030184723.GG5671@hirez.programming.kicks-ass.net>
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
> On Tue, Oct 29, 2019 at 07:47:39PM +0100, Peter Zijlstra wrote:
> > I've made these changes. Now let me go have a play with that second
> > waitqueue.
> 
> What I've ended up with is a 'custom' waitqueue and an rcuwait. The
> rcuwait conveniently got around the tedious preempt_enable/disable
> around the __percpu_up_read() wakeup.
> 
> I realized that up_read will only ever have to wake a (single) blocked
> writer, never a series of readers.
> 
> Compile tested only, I'll build and boot test once i've had dinner.

It seems to boot and build a kernel, it must be perfect ;-)

I think I'll go split this into a number of smaller patches:

 - move lockdep_map into percpu_rwsem and stop using the rwsem one
 - use bool
 - move the __this_cpu_{inc,dec} into the slowpath
 - rework __percpu_down_read() as per your earlier suggestion
 - replace rwsem with wait_queue + atomic_t

that might help make all this slightly easier to read.
