Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2862C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1770206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNAic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:38:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49113 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:38:32 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iV39U-0000VZ-57; Thu, 14 Nov 2019 00:38:24 +0000
Date:   Thu, 14 Nov 2019 01:38:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        alpha <linux-alpha@vger.kernel.org>
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
Message-ID: <20191114003822.6fjji26vm7yplaw2@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-2-arnd@arndb.de>
 <20191112210915.GD5130@uranus>
 <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:02:12AM +0100, Arnd Bergmann wrote:
> On Tue, Nov 12, 2019 at 10:09 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> >
> > On Fri, Nov 08, 2019 at 10:12:10PM +0100, Arnd Bergmann wrote:
> 
> > > ---
> > > Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
> > > here, to make them completely unambiguous?
> >
> > The patch looks ok to me. I must confess I looked into rusage long ago
> > so __kernel_timespec type used in uapi made me nervious at first,
> > but then i found that we've this type defined in time_types.h uapi
> > so userspace should be safe. I also like the idea of __kernel_rusage
> > but definitely on top of the series.
> 
> There are clearly too many time types at the moment, but I'm in the
> process of throwing out the ones we no longer need now.
> 
> I do have a number patches implementing other variants for the syscall,
> and I suppose that if we end up adding __kernel_rusage, that would
> have to go with a set of syscalls using 64-bit seconds/nanoseconds
> rather than the old 32/64 microseconds. I don't know what other
> changes remain that anyone would want from sys_waitid() now that
> it does support pidfd.
> 
> If there is still a need for a new waitid() replacement, that should take
> that new __kernel_rusage I think, but until then I hope we are fine
> with today's getrusage+waitid based on the current struct rusage.

Note, that glibc does _not_ expose the rusage argument, i.e. most of
userspace is unaware that waitid() does allow you to get rusage
information. So users first need to know that waitid() has an rusage
argument and then need to call the waitid() syscall directly.

> 
> BSD has wait6() to return separate rusage structures for 'self' and
> 'children', but I could not find any application (using the freebsd
> sources and debian code search) that actually uses that information,
> so there might not be any demand for that.

Speaking specifically for Linux now, I think that rusage does not
actually expose the information most relevant users are interested in.
On Linux nowadays it is _way_ more interesting to retrieve stats
relative to the cgroup the task lived in etc.
Doing a git grep -i rusage in the systemd source code shows that rusage
is used _nowhere_. And I consider an init system to be the most likely
candidate to be interested in rusage.

	Christian
