Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92320C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FA20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCEQWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:22:01 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:55292 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEQWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:22:01 -0500
X-Greylist: delayed 954 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 11:21:59 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 44DMFV0DxSzDV3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 11:06:05 -0500 (EST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 44DMFT1fPWz1np6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 11:06:04 -0500 (EST)
Received: by mail-oi1-f173.google.com with SMTP id s16so7215976oih.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 08:06:04 -0800 (PST)
X-Gm-Message-State: APjAAAWbiPMo4W58POVN1lJzW8DUrcdoq80yGbyeAoVJKHBDvUQ2W1P3
        v79M1V1OQhrpGe6KA4UHX3qV89zquyWItGMemHM=
X-Google-Smtp-Source: APXvYqyignllGMBUjwDbGk0rsHmnwjsOFlqJkn3PaOGzu5p90Y/a+yVmTR+ICKYJ3MiUqZqj5mY8pVnc9nD2+oq4ZQ8=
X-Received: by 2002:aca:4305:: with SMTP id q5mr14495990oia.121.1551801963809;
 Tue, 05 Mar 2019 08:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20190305162351.5aadde66@jawa>
In-Reply-To: <20190305162351.5aadde66@jawa>
From:   Zack Weinberg <zackw@panix.com>
Date:   Tue, 5 Mar 2019 11:05:52 -0500
X-Gmail-Original-Message-ID: <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
Message-ID: <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
Subject: Re: [Y2038] Question regarding support of old time interfaces beyond y2038
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de> wrote:
> From other discussion [4] - regarding the following system calls:
>  time, stime, gettimeofday, settimeofday, adjtimex, nanosleep, alarm,
>  getitimer, setitimer, select, utime, utimes, futimesat, and
>  {old,new}{l,f,}stat{,64}.
>
> "These all pass 32-bit time_t arguments on 32-bit
>  architectures and are replaced by other interfaces (e.g. posix
>  timers and clocks, statx). C libraries implementing 64-bit time_t in
>  32-bit architectures have to implement the handles by wrapping
>  around the newer interfaces."

1) We should be clear that most of these will continue to be supported
as C library interfaces even if they are not system calls.  Some of
them are obsolete enough and/or rarely used enough that we might not
bother (the older ways to set the system clock, for instance).

2) I know of one case where the new interfaces don't cover all of the
functionality of the old ones: timers started by setitimer continue to
run after an execve, timers started by timer_create don't.  This means
setitimer(ITIMER_VIRTUAL) can be used to impose a CPU time limit on a
program you didn't write, and timer_create can't.  If new kernels are
not going to have setitimer as a primitive, we need some other way of
getting the same effect.

zw
