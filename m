Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227BDC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC24B2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axLrHVbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfGSNrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:47:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Hokg8oUCnTJMdm04EjJEy1G6bBUYjC7FCjqYdguhZU=; b=axLrHVblj6QSmD96ZBPWWhsJ7
        ZTNj+ezWX4oz/SJj96v9eF1lNLXZD3Tcmeq0s0Ibn0Om7SNSHLlJY0j0awyDs2pP7INXSVnVwIzKi
        qvFs3W15ircRizWGrn1Vz9ddCg9IFrkXJeHv+kK9tDpRIe4DXZBD9UP6Gcwm9Ne3LSRtwcliVLWvQ
        TMco3z8JAlX27HCKEdYvuFSJBf4Uihx58ZhJ4yhuI8CDOUS4NnkQZfsLSSDOBuPuL3/P+dPq/ptmf
        exyAQ+twVE8tg/sHgus0qBOev9FkWPIwOPI2VrRkaTc+qAoFgE7GRbEQqdMqfnUNDlAywrV0Dxthi
        /+fIfHq+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoTEP-0001Lb-5Q; Fri, 19 Jul 2019 13:47:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B95820B4B7B6; Fri, 19 Jul 2019 15:47:27 +0200 (CEST)
Date:   Fri, 19 Jul 2019 15:47:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190719134727.GV3463@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719110349.GG3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:03:49PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 18, 2019 at 03:18:34PM +0200, Oleg Nesterov wrote:
> > People report that utime and stime from /proc/<pid>/stat become very wrong
> > when the numbers are big enough. In particular, the monitored application
> > can run all the time in user-space but only stime grows.
> > 
> > This is because scale_stime() is very inaccurate. It tries to minimize the
> > relative error, but the absolute error can be huge.
> > 
> > Andrew wrote the test-case:
> > 
> > 	int main(int argc, char **argv)
> > 	{
> > 	    struct task_cputime c;
> > 	    struct prev_cputime p;
> > 	    u64 st, pst, cst;
> > 	    u64 ut, put, cut;
> > 	    u64 x;
> > 	    int i = -1; // one step not printed
> > 
> > 	    if (argc != 2)
> > 	    {
> > 		printf("usage: %s <start_in_seconds>\n", argv[0]);
> > 		return 1;
> > 	    }
> > 	    x = strtoull(argv[1], NULL, 0) * SEC;
> > 	    printf("start=%lld\n", x);
> > 
> > 	    p.stime = 0;
> > 	    p.utime = 0;
> > 
> > 	    while (i++ < NSTEPS)
> > 	    {
> > 		x += STEP;
> > 		c.stime = x;
> > 		c.utime = x;
> > 		c.sum_exec_runtime = x + x;
> > 		pst = cputime_to_clock_t(p.stime);
> > 		put = cputime_to_clock_t(p.utime);
> > 		cputime_adjust(&c, &p, &ut, &st);
> > 		cst = cputime_to_clock_t(st);
> > 		cut = cputime_to_clock_t(ut);
> > 		if (i)
> > 		    printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
> > 			cut, cut - put, cst, cst - pst);
> > 	    }
> > 	}
> > 
> > For example,
> > 
> > 	$ ./stime 300000
> > 	start=300000000000000
> > 	ut(diff)/st(diff):            299994875 (   0)             300009124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300011124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300013124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300015124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300017124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300019124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300021124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300023124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300025124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300027124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300029124 (2000)
> > 	ut(diff)/st(diff):            299996875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            299998875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300000875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300002875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300004875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300006875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300008875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300010875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300012055 (1180)             300029944 ( 820)
> > 	ut(diff)/st(diff):            300012055 (   0)             300031944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300033944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300035944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300037944 (2000)
> > 
> > shows the problem even when sum_exec_runtime is not that big: 300000 secs.
> > 
> > The new implementation of scale_stime() does the additional div64_u64_rem()
> > in a loop but see the comment, as long it is used by cputime_adjust() this
> > can happen only once.
> 
> That only shows something after long long staring :/ There's no words on
> what the output actually means or what would've been expected.
> 
> Also, your example is incomplete; the below is a test for scale_stime();
> from this we can see that the division results in too large a number,
> but, important for our use-case in cputime_adjust(), it is a step
> function (due to loss in precision) and for every plateau we shift
> runtime into the wrong bucket.

But I'm still confused, since in the long run, it should still end up
with a proportionally divided user/system, irrespective of some short
term wobblies.

So please, better articulate the problem.
