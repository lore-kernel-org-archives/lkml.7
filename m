Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C855C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538CD206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNKSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:18:35 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:18:35 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7auJ-1iW2560BrR-0084OO; Thu, 14 Nov 2019 11:18:33 +0100
Received: by mail-qt1-f173.google.com with SMTP id o49so6165468qta.7;
        Thu, 14 Nov 2019 02:18:32 -0800 (PST)
X-Gm-Message-State: APjAAAV0CKdhq4zLm9AzNAcBgg2jN1FbV3XD4RALAGwmhokcqk9ShEQ/
        Cj8aJFA1gFMlNfQviLRvUfvsPAwHoR4DcPjS/q4=
X-Google-Smtp-Source: APXvYqxf7jqOy92oQ8J7dVMZ1gAY/ROPXnRDCOLWhtXkPZkB+KxCsNOrNtZ/uzBABTnFpdmM/gFPLhsC1OnrMwBz2q0=
X-Received: by 2002:aed:3e41:: with SMTP id m1mr7313515qtf.142.1573726711849;
 Thu, 14 Nov 2019 02:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-2-arnd@arndb.de>
 <20191112210915.GD5130@uranus> <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
 <20191114003822.6fjji26vm7yplaw2@wittgenstein>
In-Reply-To: <20191114003822.6fjji26vm7yplaw2@wittgenstein>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 11:18:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2JtyfFifSWNd2MA-J=6-NdgPd4eNva+u193bzQTX6Qig@mail.gmail.com>
Message-ID: <CAK8P3a2JtyfFifSWNd2MA-J=6-NdgPd4eNva+u193bzQTX6Qig@mail.gmail.com>
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ApSM7RO8KtyFVnWI/bza3Yt0UZnl7tNfl4o790jmI2+VkqGy6QL
 beQNEsUOyqiHptA8ER4CIPrnLoR+ftJN8Gobe27uOtpWal1SYqh01UL1EMeAgN/VKG/LREJ
 KPjm0fE8o3qndah2fHcq2bhG8DaJ7ZP2IRFYa1Ou9R00WezxZ5tn+CgmN1wjDPUkA/rWeod
 zVTRYHvsSPE5xHC0dP4SA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lfdc9JnNowA=:QfNga8qIHSeNbolzrtlISk
 fqAUQr+6Z68VxEfCFPOl0GrmzIU2tO8rgIOxjE6vQClIOApC0aFHvI7Yc5Q/GSB4BLYDHbDtD
 lu9NguWAoJqMqm+ohCnPoNaHG+OUiaQGA+O/FHSn+/O7yCC0D87nVil+OlNT2Q17tRWeJDn2c
 jj2hFhIxReNzSQqPSxsSu8afYT5iU0cu+/pkj+Vpd0+O4kf22mpNjgzuTcIekVtnQsdqNHBDQ
 BFjyXBmcTzjRXIp3n9+661ypJRclWvHFRpIP+kjDu9qQjB9zvgeZ2u2V9Z8RnjJI9mx12+3Yv
 DbjOanAsVUZpdXO/LcUFYGjQ2ln6Zth57cv9Sw3ssNE+UAp3zXzk7LbC7ZDql5QKrHuyVJ1Fp
 cMDwYYCQcpxbbqK4Uq3uz0cNWfpOe1Lk5hehJQL07AObWm7eBvEKZ+3l2qlwuvJRwnIis3LE8
 H7RPRqukMNT5j3r8LUB6j77ryIsIkNQIWZZAbOZhCZ+QT+oemf8E52WkruYRWVYY1qIZlsmUy
 hTRBkwFxm3pkrsf7oofxw8IJtq6kaE0rqfeuEmbQFoMTY5o8k6n2Tye8FGQL9DIf1oSx5O1Lx
 umHRFEcc5U9HMFwGyQVnlpZ4yZDalxXfYb/0CrqXKmYyqXuyzo1NW6N+rM3/C2Cq8eHK1Krd9
 aJVl8y3uDhA89/fBgbH1kzJHwmRtZXIFkDeKVS3u1xkOOPKm+8ityprBE0IQZBn/HITtXuJQX
 zQxy29LJ90GrLZQVIoid5L+aEFpuSrkaWYDqM3hQB/443pedAxDChB0S40grVaRU0H+32flB/
 48yR55tCdjNwAGh4OPCPU4QFhUsx8H/PgxmQkm7bVzD0OOw9xapa8eTmF3V2lZlzZJ5p0xWBA
 aA/oWmMFrbTJ6yXLQzLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:38 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Wed, Nov 13, 2019 at 11:02:12AM +0100, Arnd Bergmann wrote:
> > On Tue, Nov 12, 2019 at 10:09 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > >
> > > On Fri, Nov 08, 2019 at 10:12:10PM +0100, Arnd Bergmann wrote:
> >
> > > > ---
> > > > Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
> > > > here, to make them completely unambiguous?
> > >
> > > The patch looks ok to me. I must confess I looked into rusage long ago
> > > so __kernel_timespec type used in uapi made me nervious at first,
> > > but then i found that we've this type defined in time_types.h uapi
> > > so userspace should be safe. I also like the idea of __kernel_rusage
> > > but definitely on top of the series.
> >
> > There are clearly too many time types at the moment, but I'm in the
> > process of throwing out the ones we no longer need now.
> >
> > I do have a number patches implementing other variants for the syscall,
> > and I suppose that if we end up adding __kernel_rusage, that would
> > have to go with a set of syscalls using 64-bit seconds/nanoseconds
> > rather than the old 32/64 microseconds. I don't know what other
> > changes remain that anyone would want from sys_waitid() now that
> > it does support pidfd.
> >
> > If there is still a need for a new waitid() replacement, that should take
> > that new __kernel_rusage I think, but until then I hope we are fine
> > with today's getrusage+waitid based on the current struct rusage.
>
> Note, that glibc does _not_ expose the rusage argument, i.e. most of
> userspace is unaware that waitid() does allow you to get rusage
> information. So users first need to know that waitid() has an rusage
> argument and then need to call the waitid() syscall directly.

On architectures that don't have a wait4 syscall (riscv32 for now),
glibc uses waitid to implement wait4 and wait3.

> > BSD has wait6() to return separate rusage structures for 'self' and
> > 'children', but I could not find any application (using the freebsd
> > sources and debian code search) that actually uses that information,
> > so there might not be any demand for that.
>
> Speaking specifically for Linux now, I think that rusage does not
> actually expose the information most relevant users are interested in.
> On Linux nowadays it is _way_ more interesting to retrieve stats
> relative to the cgroup the task lived in etc.
> Doing a git grep -i rusage in the systemd source code shows that rusage
> is used _nowhere_. And I consider an init system to be the most likely
> candidate to be interested in rusage.

I looked at a couple of implementations of time(1), this is one example
that sometimes uses wait3(), though other implementations just call
getrusage() in the parent process before the fork/exec. None of them
actually seem to report better than millisecond resolution, so there is
not a strict reason to do a timespec replacement for these.

       Arnd
