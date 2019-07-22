Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17555C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABCF218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muJwJujm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfGVUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:00:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfGVUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bgrSV0iH6PoJUEGrX+zUcLrEKRIw3yppNHGnzix3ExI=; b=muJwJujmHPKcbzGauOJj+9guK
        3l4QPtqfA/yv05XnvYkbRWKAw7faO0d5ixnYA8TcM2BBK+i96WhasI2iCxYuni0LiQDeZkuRssTrK
        16Fk52gO46BREz3dPlSBgOZUr/9Hilj/0cDGZNL+gUIBFlzxYTWGBgjLTJDwGNRDyyrAcBw0VzU9k
        MnJvkwJpx0es3FpMPCTRJ1PiSAYUQXufrri7jtoPVv/R/RZ/qR85K7yga7t9b28KMiiNh5OWhb9oC
        GZMutp4CRa2N3Wp+y07S+r53XmUr/jIHTvtnLBqjrOVTWWLrAmgE1MQuo7zxka53SO+AYaDD+/yOQ
        5pZc9Oaeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpeUD-0006ah-Du; Mon, 22 Jul 2019 20:00:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF758980C59; Mon, 22 Jul 2019 22:00:34 +0200 (CEST)
Date:   Mon, 22 Jul 2019 22:00:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190722200034.GJ6698@worktop.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190722105240.GA27219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722105240.GA27219@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:52:41PM +0200, Stanislaw Gruszka wrote:
> On Fri, Jul 19, 2019 at 01:03:49PM +0200, Peter Zijlstra wrote:
> > > shows the problem even when sum_exec_runtime is not that big: 300000 secs.
> > > 
> > > The new implementation of scale_stime() does the additional div64_u64_rem()
> > > in a loop but see the comment, as long it is used by cputime_adjust() this
> > > can happen only once.
> > 
> > That only shows something after long long staring :/ There's no words on
> > what the output actually means or what would've been expected.
> > 
> > Also, your example is incomplete; the below is a test for scale_stime();
> > from this we can see that the division results in too large a number,
> > but, important for our use-case in cputime_adjust(), it is a step
> > function (due to loss in precision) and for every plateau we shift
> > runtime into the wrong bucket.
> > 
> > Your proposed function works; but is atrocious, esp. on 32bit. That
> > said, before we 'fixed' it, it had similar horrible divisions in, see
> > commit 55eaa7c1f511 ("sched: Avoid cputime scaling overflow").
> > 
> > Included below is also an x86_64 implementation in 2 instructions.
> > 
> > I'm still trying see if there's anything saner we can do...
> 
> I was always proponent of removing scaling and export raw values
> and sum_exec_runtime. But that has obvious drawback, reintroduce
> 'top hiding' issue.

I think (but didn't grep) that we actually export sum_exec_runtime in
/proc/ *somewhere*.

> But maybe we can export raw values in separate file i.e.
> /proc/[pid]/raw_cpu_times ? So applications that require more precise
> cputime values for very long-living processes can use this file.

There are no raw cpu_times, there are system and user samples, and
samples are, by their very nature, an approximation. We just happen to
track the samples in TICK_NSEC resolution these days, but they're still
ticks (except on s390 and maybe other archs, which do time accounting in
the syscall path).

But I think you'll find x86 people are quite opposed to doing TSC reads
in syscall entry and exit :-)

