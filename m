Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8BC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E702085A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfGSOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:37:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfGSOhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E40D30860CC;
        Fri, 19 Jul 2019 14:37:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D35957984;
        Fri, 19 Jul 2019 14:37:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Jul 2019 16:37:46 +0200 (CEST)
Date:   Fri, 19 Jul 2019 16:37:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190719143742.GA32243@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190719134727.GV3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719134727.GV3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 19 Jul 2019 14:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Peter Zijlstra wrote:
>
> > > 	$ ./stime 300000
> > > 	start=300000000000000
> > > 	ut(diff)/st(diff):            299994875 (   0)             300009124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300011124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300013124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300015124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300017124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300019124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300021124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300023124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300025124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300027124 (2000)
> > > 	ut(diff)/st(diff):            299994875 (   0)             300029124 (2000)
> > > 	ut(diff)/st(diff):            299996875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            299998875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300000875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300002875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300004875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300006875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300008875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300010875 (2000)             300029124 (   0)
> > > 	ut(diff)/st(diff):            300012055 (1180)             300029944 ( 820)
> > > 	ut(diff)/st(diff):            300012055 (   0)             300031944 (2000)
> > > 	ut(diff)/st(diff):            300012055 (   0)             300033944 (2000)
> > > 	ut(diff)/st(diff):            300012055 (   0)             300035944 (2000)
> > > 	ut(diff)/st(diff):            300012055 (   0)             300037944 (2000)
> > >
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
>
> But I'm still confused, since in the long run, it should still end up
> with a proportionally divided user/system, irrespective of some short
> term wobblies.

Why?

Yes, statistically the numbers are proportionally divided.

but you will (probably) never see the real stime == 1000 && utime == 10000
numbers if you watch incrementally.

Just in case... yes I know that these numbers can only "converge" to the
reality, only their sum is correct. But people complain.

Oleg.

