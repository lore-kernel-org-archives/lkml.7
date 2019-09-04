Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCAC22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ytr3Kn9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfIDPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:53:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfIDPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8TDR/c+lAQCA6VzFgOc66YwWj1UooKlQYcDecK0A9vs=; b=Ytr3Kn9fyUxNRw1W4bEBoF4oR
        5EDayrOSS3bOKASvQq+H8bguHpglNFb6LSOccRrq963PygUUb91gdd+41PqWONWXxopWueVUT4MiA
        Ew4ow2y7RnSyHx7PIT38IDFipl/WhBj87VKr2TX7v46l2JsGR27nAek+gZ/JzMqaSoMl9FwGwuzj3
        QihvI3sUf3QvprAlcyL3Ql7bHkyTz/uej7RiBknu5EzsiTCQNOsm84y7TBzqODWvL1B7GqABotU4s
        O13JV8Hts0FZi1XR+Qsz0Du/SF8lLTxeZDwyx2GJvJJYqlS/Dgp3/cKM9tcmIedksr30Vg4gwte1R
        fvmsx/vKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5XaE-0007eX-Kk; Wed, 04 Sep 2019 15:52:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D24A83011DF;
        Wed,  4 Sep 2019 17:51:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63F2F29D8ACE7; Wed,  4 Sep 2019 17:52:29 +0200 (CEST)
Date:   Wed, 4 Sep 2019 17:52:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, kernel-team@android.com,
        will.deacon@arm.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190904155229.GT2332@hirez.programming.kicks-ass.net>
References: <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
 <20190831144117.GA133727@google.com>
 <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
 <20190904061616.25ce79e1@oasis.local.home>
 <20190904113038.GE2349@hirez.programming.kicks-ass.net>
 <20190904132418.GA237277@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904132418.GA237277@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:24:18AM -0400, Joel Fernandes wrote:
> On Wed, Sep 04, 2019 at 01:30:38PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 04, 2019 at 06:16:16AM -0400, Steven Rostedt wrote:
> > > On Mon, 2 Sep 2019 11:16:23 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > in sched_dl_period_handler(). And do:
> > > > 
> > > > +	preempt_disable();
> > > > 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> > > > 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> > > > +	preempt_enable();
> > > 
> > > Hmm, I'm curious. Doesn't the preempt_disable/enable() also add
> > > compiler barriers which would remove the need for the READ_ONCE()s here?
> > 
> > They do add compiler barriers; but they do not avoid the compiler
> > tearing stuff up.
> 
> Neither does WRITE_ONCE() on some possibly buggy but currently circulating
> compilers :(

Yes, I'm aware :/
