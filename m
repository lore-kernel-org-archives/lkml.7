Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE57BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8BD218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfGVKwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfGVKwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:52:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A766307D914;
        Mon, 22 Jul 2019 10:52:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E31905D9D3;
        Mon, 22 Jul 2019 10:52:42 +0000 (UTC)
Date:   Mon, 22 Jul 2019 12:52:41 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190722105240.GA27219@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719110349.GG3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Jul 2019 10:52:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:03:49PM +0200, Peter Zijlstra wrote:
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
> 
> Your proposed function works; but is atrocious, esp. on 32bit. That
> said, before we 'fixed' it, it had similar horrible divisions in, see
> commit 55eaa7c1f511 ("sched: Avoid cputime scaling overflow").
> 
> Included below is also an x86_64 implementation in 2 instructions.
> 
> I'm still trying see if there's anything saner we can do...

I was always proponent of removing scaling and export raw values
and sum_exec_runtime. But that has obvious drawback, reintroduce
'top hiding' issue.

But maybe we can export raw values in separate file i.e.
/proc/[pid]/raw_cpu_times ? So applications that require more precise
cputime values for very long-living processes can use this file.

Stanislaw
