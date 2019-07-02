Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EFC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8E20665
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hr43SDcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:36:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfGBJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BBG6bPdmW3gWi45R/ShI4W1/ImwhZrKR4xXlIZYIT54=; b=Hr43SDcNGpOHMQ/2snUHP8TGV
        7RELT1lQHtfv6j9nA26i5KlnglXEtRBhM3UMCe3bFpXYTDrKmUkAeMlz8DrukCpn7Q+MZ6oyxrarZ
        /e9/YLOizswR6PGHoEQat5L7VdQz9U/mhTZSOwPhZzGiIrbAzLbT4SpJNt5vadB9Q8mdxbXQGbMTJ
        DqjqfBbpMr7YxopiAJ3C8nPm/dJ4ytJ2uuVO1w+V5AaKvA8AelF0BXA3Sxc/WnX3R2/kqRDX8iIRL
        idqPHW0TtjKqkx24FRmNERHO0nCZr1+qYIlb8CXMg/vLhYh2PQawgcIWvv1vr7KJmZh7xqZ0yMMfn
        80fpZ6sNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiFCt-0005tb-2G; Tue, 02 Jul 2019 09:36:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 763EA2021E58F; Tue,  2 Jul 2019 11:36:08 +0200 (CEST)
Date:   Tue, 2 Jul 2019 11:36:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+8cc1843d4eec9c0dfb35@syzkaller.appspotmail.com>,
        aarcange@redhat.com, avagin@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        oleg@redhat.com, prsood@codeaurora.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: INFO: task hung in exit_mm
Message-ID: <20190702093608.GG3463@hirez.programming.kicks-ass.net>
References: <000000000000a193aa058c9a6499@google.com>
 <20190701171412.d0c69b9d1657bf632f44e6de@linux-foundation.org>
 <20190702090608.GA3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702090608.GA3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:06:08AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 01, 2019 at 05:14:12PM -0700, Andrew Morton wrote:
> > On Mon, 01 Jul 2019 01:27:04 -0700 syzbot <syzbot+8cc1843d4eec9c0dfb35@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > 
> > At a guess I'd say that perf_mmap() hit a deadlock on event->mmap_mutex
> > while holding down_write(mmap_sem) (via vm_mmap_pgoff).  The
> > down_read(mmap_sem) in do_exit() happened to stumble across this and
> > that's what got reported.
> 
> lockdep never reported that and I don't see event->mmap_mutex being held
> anywhere.
> 
> AFAICT CPU0 is running 8355 and only 'has' mmap_sem -- it's blocked
> waiting to acquire.
> 
> CPU1 is running 8354 and has mmap_sem and is waiting to acquire
> event->mmap_mutex.
> 
> But nobody is actually owning it
> 
> We take mmap_mutex in:
> 
>   perf_mmap() - called with mmap_sem held
>   perf_mmap_close() - called with mmap_sem held
> 
>   _free_event() - no faults/mmap while holding it
>   perf_poll() - idem
>   perf_event_set_output() - idem
> 
> I don't see any of those functions in the below stacktrace, and having
> just looked them over, I don't see how they would end up trying to
> acquire mmap_sem and AB-BA.
> 
> Now, clearly there's something screwy, but I'm not seeing a deadlock.
> Let me go play with that reproducer.
> 
> > > HEAD commit:    249155c2 Merge branch 'parisc-5.2-4' of git://git.kernel.o..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1306be61a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8cc1843d4eec9c0dfb35
> > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang  

Also note that I very much do not trust that compiler to build a working
kernel. There's still known code-gen bugs with it.
