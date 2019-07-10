Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D6C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B072087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562779288;
	bh=ykkW+RCuCVFo3XxyHIgZTHkLYsqZ8MJSznrovAxQz9s=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=jqQeqRWW0M90IXsF+zw4YPG9tzlC8Pddlh0EqaWS741wcmaPEvUMidI/9txotwfy5
	 pleyLL8w3JawePrmqH43a5g+pn2QpYBA3TgzEIyua9VsiCZwMZXWovo0UxSWQUBiXu
	 4+Ya3ATmoTPjWUB9CaN/52MirdOr4pv+4vHQqyZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfGJRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfGJRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:21:26 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA3B20844;
        Wed, 10 Jul 2019 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562779285;
        bh=ykkW+RCuCVFo3XxyHIgZTHkLYsqZ8MJSznrovAxQz9s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=mY5nOM6TU2C4v3OmdQJZc/MkGN+6/S2nw/sL2EhmE9fmvmFFBqMo9XDaSutguXwDh
         QlEWZRXpY3rpqC3Psi/1FNE2DGsLFymRUaIN8jQNMxdAobNdsDaRS50w6aCGHLGOg8
         HSuIaWgI/IQ0CNAUSSzb8GndmGWHiZIAnei4+dAc=
Date:   Wed, 10 Jul 2019 10:21:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
Message-ID: <20190710172123.GC801@sol.localdomain>
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710170057.GB801@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:00:59AM -0700, Eric Biggers wrote:
> On Wed, Jul 10, 2019 at 07:19:55AM -0700, Bart Van Assche wrote:
> > On 7/9/19 10:30 PM, Eric Biggers wrote:
> > > [Moved most people to Bcc; syzbot added way too many random people to this.]
> > > 
> > > Hi Bart,
> > > 
> > > On Sat, Mar 30, 2019 at 07:17:09PM -0700, Bart Van Assche wrote:
> > > > On 3/30/19 2:58 PM, syzbot wrote:
> > > > > syzbot has bisected this bug to:
> > > > > 
> > > > > commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
> > > > > Author: Bart Van Assche <bvanassche@acm.org>
> > > > > Date:   Thu Feb 14 23:00:54 2019 +0000
> > > > > 
> > > > >       kernel/workqueue: Use dynamic lockdep keys for workqueues
> > > > > 
> > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f1bacd200000
> > > > > start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of
> > > > > git://git.kernel..
> > > > > git tree:       upstream
> > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1409bacd200000
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1009bacd200000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> > > > > dashboard link:
> > > > > https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1bacd200000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120fe0f200000
> > > > > 
> > > > > Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com
> > > > > Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
> > > > > workqueues")
> > > > > 
> > > > > For information about bisection process see:
> > > > > https://goo.gl/tpsmEJ#bisection
> > > > 
> > > > Hi Dmitry,
> > > > 
> > > > This bisection result doesn't make sense to me. As one can see, the message
> > > > "BUG: MAX_STACK_TRACE_ENTRIES too low!" does not occur in the console output
> > > > the above console output URL points at.
> > > > 
> > > > Bart.
> > > 
> > > This is still happening on mainline, and I think this bisection result is
> > > probably correct.  syzbot did start hitting something different at the very end
> > > of the bisection ("WARNING: CPU: 0 PID: 9153 at kernel/locking/lockdep.c:747")
> > > but that seems to be just because your commit had a lot of bugs in it, which had
> > > to be fixed by later commits.  In particular, the WARNING seems to have been
> > > fixed by commit 28d49e282665e ("locking/lockdep: Shrink struct lock_class_key").
> > > 
> > > What seems to still be happening is that the dynamic lockdep keys which you
> > > added make it possible for an unbounded number of entries to be added to the
> > > fixed length stack_trace[] array in kernel/locking/lockdep.c.  Hence the "BUG:
> > > MAX_STACK_TRACE_ENTRIES too low!".
> > > 
> > > Am I understanding it correctly?  How did you intend this to work?
> > 
> > The last two paragraphs do not make sense to me. My changes do not increase
> > the number of stack traces that get recorded by the lockdep code.
> > 
> > Bart.
> > 
> 
> Interesting.  How do we explain that repeatedly allocating and freeing a
> workqueue is causing the number of lockdep stack trace entries to grow without
> bound, though?
> 
> This can be reproduced with the following (which I simplified from the C
> reproducer that syzbot generated and used for its bisection):
> 
> 	#include <fcntl.h>
> 	#include <unistd.h>
> 
> 	int main()
> 	{
> 		for (;;) {
> 			int fd = open("/dev/infiniband/rdma_cm", O_RDWR);
> 
> 			close(fd);
> 		}
> 	}
> 
> The workqueue is allocated in ucma_open() and freed in ucma_close().  If I run
> 'grep stack-trace /proc/lockdep_stats' while reproducer is running, I can see
> the number is growing continuously until it hits the limit.
> 
> There is also a reproducer using io_uring instead of rdma_cm
> (https://syzkaller.appspot.com/text?tag=ReproC&x=16483bf8600000).
> In both cases the workqueue is associated with a file descriptor; the workqueue
> is allocated and freed as the file descriptor is opened and closed.
> 
> Anyone have any ideas?
> 
> - Eric

With my simplified reproducer, on commit 669de8bda87b ("kernel/workqueue: Use
dynamic lockdep keys for workqueues") I see:

	WARNING: CPU: 3 PID: 189 at kernel/locking/lockdep.c:747 register_lock_class+0x4f6/0x580

and then somewhat later:

	BUG: MAX_LOCKDEP_KEYS too low!

If on top of that I cherry pick commit 28d49e282665 ("locking/lockdep: Shrink
struct lock_class_key"), I see instead:

	BUG: MAX_STACK_TRACE_ENTRIES too low!

I also see that on mainline.

Alternatively, if I check out 669de8bda87b and revert it, I don't see anything.

- Eric
