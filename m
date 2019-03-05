Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE07C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0859F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCEQ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:56:35 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50114 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfCEQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:56:35 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h1DMk-00057N-Fp; Tue, 05 Mar 2019 16:56:30 +0000
Message-ID: <1551804989.2925.283.camel@codethink.co.uk>
Subject: Re: [Y2038] Question regarding support of old time interfaces
 beyond y2038
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Zack Weinberg <zackw@panix.com>, Lukasz Majewski <lukma@denx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Date:   Tue, 05 Mar 2019 16:56:29 +0000
In-Reply-To: <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
References: <20190305162351.5aadde66@jawa>
         <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 11:05 -0500, Zack Weinberg wrote:
> > On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de> wrote:
> > From other discussion [4] - regarding the following system calls:
> >  time, stime, gettimeofday, settimeofday, adjtimex, nanosleep, alarm,
> >  getitimer, setitimer, select, utime, utimes, futimesat, and
> >  {old,new}{l,f,}stat{,64}.
> > 
> > "These all pass 32-bit time_t arguments on 32-bit
> >  architectures and are replaced by other interfaces (e.g. posix
> >  timers and clocks, statx). C libraries implementing 64-bit time_t in
> >  32-bit architectures have to implement the handles by wrapping
> >  around the newer interfaces."
> 
> 1) We should be clear that most of these will continue to be supported
> as C library interfaces even if they are not system calls.  Some of
> them are obsolete enough and/or rarely used enough that we might not
> bother (the older ways to set the system clock, for instance).
> 
> 2) I know of one case where the new interfaces don't cover all of the
> functionality of the old ones: timers started by setitimer continue to
> run after an execve, timers started by timer_create don't.  This means
> setitimer(ITIMER_VIRTUAL) can be used to impose a CPU time limit on a
> program you didn't write, and timer_create can't.  If new kernels are
> not going to have setitimer as a primitive, we need some other way of
> getting the same effect.

{get,set}itimer() are still implemented on all architectures, and I
don't see any sign that that's going to change.  There aren't 64-bit
versions on 32-bit architectures though.  This is explained in the
message for commit 48166e6ea47d23984f0b481ca199250e1ce0730a:

"...these can all be safely implemented in the C library by wrapping
around the existing system calls because the 32-bit time_t they pass
only counts elapsed time, not time since the epoch."

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
