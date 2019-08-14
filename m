Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D75214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfHNSAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:00:49 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:47316 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:00:49 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hxxZh-0005rd-00; Wed, 14 Aug 2019 18:00:41 +0000
Date:   Wed, 14 Aug 2019 14:00:41 -0400
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Alistair Francis <alistair23@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>, macro@wdc.com,
        Zong Li <zongbox@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814180041.GK9017@brightrain.aerifal.cx>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com>
 <20190814161517.ldbn62mulk2pmqo5@wittgenstein>
 <20190814163443.6odsksff4jbta7be@wittgenstein>
 <20190814165501.GJ9017@brightrain.aerifal.cx>
 <CAHk-=wgpoeAnhscv9+fKNLLJF0tvypGPAxyzBCa0rp5hppRDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpoeAnhscv9+fKNLLJF0tvypGPAxyzBCa0rp5hppRDRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:06:19AM -0700, Linus Torvalds wrote:
> On Wed, Aug 14, 2019 at 9:55 AM Rich Felker <dalias@libc.org> wrote:
> >
> > I don't think "downsides" sufficiently conveys that this is hard
> > breakage of a requirement for waitpid.
> 
> Well, let's be honest here. Who has _ever_ seen a signal handler
> changing the current process group?
> 
> In fact, the SYSV version of setpgid() takes a process ID to set it
> *for somebody else*, so the signal safety is not even necessarily
> relevant, since it might be racing with _another_ thread doing it
> (which even the kernel side won't fix - it's just user space doing odd
> things).

For that case, the operations are inherently unordered with respect to
each other, and assuming the interpretation that waitpid is allowed to
wait on "the pgid at the time of the call" rather than at the time of
child exit/status-change -- which was discussed thoroughly in the
thread leading up to this patch -- there is no conformance
distinction.

On the other hand, with changing your own pgid from a signal handler,
there is a clear observable ordering between the events. For example,
if the signal handler changes the pgid and forks a child with the new
pgid, waitpid for "own pgid" can be assumed to include the new child
in its wait set.

I agree this is not common usage, so impact of breakage is probably
low, but I'd rather not have wrong/racy hacks be something we're
committed to supporting indefinitely on the userspace side.

> So yes - it's technically true that it's impossible to emulate
> properly in user space.
> 
> But I doubt it makes _any_ difference what-so-ever, and glibc might as
> well do something like
> 
>      ret = waitid(P_PGID, 0, ..);
>      if (ret == -EINVAL) { do the emulation }
> 
> which makes it work with older kernels, and has zero downside in practice.
> 
> Hmm?

It only affects RV32 anyway; other archs all have a waitpid syscall
that can be used. Since there's not yet any official libc release with
RV32 support and AIUI the ABI is not considered "frozen" yet,
emulation doesn't seem useful here. Whatever kernel version fixes this
(or some later one, if nobody gets things together on upstreaming libc
support of RV32) will just become the minimum version for RV32.

Rich
