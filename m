Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39793FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A23C207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfKHLwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:52:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390287AbfKHLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:52:00 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iT2ny-0008Jb-Dv; Fri, 08 Nov 2019 12:51:55 +0100
Date:   Fri, 8 Nov 2019 12:51:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
In-Reply-To: <alpine.DEB.2.21.1911081136450.26566@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1911081223110.26566@nanos.tec.linutronix.de>
References: <20191106215534.241796846@linutronix.de> <87zhh78gnf.fsf@oldenburg2.str.redhat.com> <87v9rv8g44.fsf@oldenburg2.str.redhat.com> <87o8xm95rt.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911080912520.27903@nanos.tec.linutronix.de>
 <87o8xm65ar.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911081136450.26566@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Thomas Gleixner wrote:
> On Fri, 8 Nov 2019, Florian Weimer wrote:
> > > On Fri, 8 Nov 2019, Florian Weimer wrote:
> > > Unpatched 5.4-rc6:
> > >
> > > FAIL: nptl/tst-thread-affinity-pthread
> > > original exit status 1
> > > info: Detected CPU set size (in bits): 225
> > > info: Maximum test CPU: 255
> > > error: pthread_create for thread 253 failed: Resource temporarily unavailable
> > 
> > Huh.  Reverting your patches (at commit 26bc672134241a080a83b2ab9aa8abede8d30e1c)
> > fixes the test for me.
> > 
> > > TBH, the futex changes have absolutely nothing to do with that resource
> > > fail.
> > 
> > I suspect that there are some changes to task exit latency, which
> > triggers the latent resource management bug.
> 
> Right, and depending on which hardware you run, this changes. On the big
> testbox I use the failure is also bouncing around between thread 252 and
> 254.

Which was just an assumption and is completely wrong.

The fail is expected and the failure output of that test is totally
bonkers:

Tracing shows that clone is not failing at all:

   ld-linux.so.2-26694 [060] ....  6477.924785: sys_enter: NR 120 (3d0f00, f7cda424, f7cdaba8, ff819790, f7cdaba8, f7edd000)
   ld-linux.so.2-26694 [060] ....  6477.924867: sys_exit: NR 120 = 26695

...

   ld-linux.so.2-26694 [191] ....  6477.985139: sys_enter: NR 120 (3d0f00, fef27424, fef27ba8, ff819790, fef27ba8, f7edd000)
   ld-linux.so.2-26694 [191] ....  6477.985220: sys_exit: NR 120 = 27203

That's a total of 509 threads created. And then right after that:

   ld-linux.so.2-26694 [191] ....  6477.985221: sys_enter: NR 192 (0, 801000, 0, 20022, ffffffff, 0)
   ld-linux.so.2-26694 [191] ....  6477.985222: sys_exit: NR 192 = -12

mmap2 fails with ENOMEM which is not really surprising. The map length is
0x801000 which means that the already started threads have already consumed

   509 * 0x801000 == 4073.99 MB == 3.9785 GB

The next mmap2 fails for a 32bit process for pretty obvious reasons and
rightfully so.

pthread_create() returns EAGAIN while the underlying problem is ENOMEM
which causes this bonkers output:

  error: pthread_create for thread 253 failed: Resource temporarily unavailable

There is nothing temporarily. The process has its address space exhausted.

That test's output is anyway strange:

 info: Detected CPU set size (in bits): 225
 info: Maximum test CPU: 255

Interesting how it fits 256 CPUs into a cpuset with a size of 225 bits.

/me goes back to stare into iopl().

Thanks,

	tglx



