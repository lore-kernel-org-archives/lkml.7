Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B05C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B162239F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aHJnx8Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfGVT4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:56:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfGVT4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OGtQKQCt9khEkE8et59U9zQKandJb/SEJEAAfyIeOb4=; b=aHJnx8Iqh/XfDZqqNQ6GJLyYI
        tfjoh1xVn33wxYQvWAZVI8WUPVBPClZQROz4SxMdJYtuctwG2nKiFc8X20XqUsJQYolgEGyU/+7S+
        Ms4r6hT+aBIG5FQ5fEfPQR0EfgjvjpeBOqchoAzulewc8e0pg3NDtU220sZSw1NiDe7VTFYxtA3YC
        y8ilQjovM84gTUlCY8zU/2ggKMf1nqHDMjtnnIAYnq+dKnvPR1igpCWKAB67sO+dwpYZexK3SSseb
        1MV8zMX6jfidtITgnDeeh10sLH39UtABcKnviMCCaY5GtDkLjwsdXDj9IzVAwQgMIHeGyjUkxdj7i
        1V0EaXtdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpePo-0006rj-Iw; Mon, 22 Jul 2019 19:56:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4A49980C59; Mon, 22 Jul 2019 21:56:05 +0200 (CEST)
Date:   Mon, 22 Jul 2019 21:56:05 +0200
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
Message-ID: <20190722195605.GI6698@worktop.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190719134727.GV3463@hirez.programming.kicks-ass.net>
 <20190719143742.GA32243@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719143742.GA32243@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 04:37:42PM +0200, Oleg Nesterov wrote:
> On 07/19, Peter Zijlstra wrote:

> > But I'm still confused, since in the long run, it should still end up
> > with a proportionally divided user/system, irrespective of some short
> > term wobblies.
> 
> Why?
> 
> Yes, statistically the numbers are proportionally divided.

This; due to the loss in precision the distribution is like a step
function around the actual s:u ratio line, but on average it still is
s:u.

Even if it were a perfect function, we'd still see increments in stime even
if the current program state never does syscalls, simply because it
needs to stay on that s:u line.

> but you will (probably) never see the real stime == 1000 && utime == 10000
> numbers if you watch incrementally.

See, there are no 'real' stime and utime numbers. What we have are user
and system samples -- tick based.

If the tick lands in the kernel, we get a system sample, if the tick
lands in userspace we get a user sample.

What we do have is an accurate (ns) based runtime accounting, and we
(re)construct stime and utime from this; we divide the total known
runtime in stime and utime pro-rata.

Sure, we take a shortcut, it wobbles a bit, but seriously, the samples
are inaccurate anyway, so who bloody cares :-)

You can construct a program that runs 99% in userspace but has all
system samples. All you need to do is make sure you're in a system call
when the tick lands.

> Just in case... yes I know that these numbers can only "converge" to the
> reality, only their sum is correct. But people complain.

People always complain, just tell em to go pound sand :-)

