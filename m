Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B255AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E820652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCEREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:04:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34938 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfCEREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:04:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so9700537qtk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4H29aknGGiQ/qyTi8W7fgHrEi65LlPNM72qkKP/f4mY=;
        b=grleLfxqhBX3Qu42rMzVf4UXOCRJ5ZcVpGqfN+ZeeBZpUYjFntUH5uNVdRlTG7JFEb
         V55z6Gl1CalfwY73G75LlKwE1Dhmx8MdlBB3Dotg+uUIt6St7+sHmddIBswyfW8S6spM
         Tvg9gOzDmxbU4OByO9N0pzRu7TRYmqBWV6Hb5rvcj0zyYVJ2Drflhx2NNAOblsJq+rZV
         FXgful+1mEWLEBx1xPQHcR7brBSAijsEeUz2/6stqlbtnbdUvYUGt7RjjllMqxnGeZIv
         z3rEvKFVTrACmgIUmgCf27D3+Hjcz7oS4ISHIgAykt8sSrXKUxSj4Jj5dRa8hpnx/RG5
         oCLw==
X-Gm-Message-State: APjAAAUSU3/4viowjBimkPFozzNSBNtPPfXUlT2Goem3lWlHQs9gaJAR
        uXr6vcTmaUpUuGZzOTbD1BwLkE4z58YrAigsg10=
X-Google-Smtp-Source: APXvYqxXAJp3Z7c+D8lA0uCHROOHXTtl0AQeTPAQ6qiEqT6qKCc8eDB/mAWuQhiiYFIARAKuUMyBIdV+LPQCepDaIqA=
X-Received: by 2002:ac8:3251:: with SMTP id y17mr2262407qta.152.1551805478252;
 Tue, 05 Mar 2019 09:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20190305162351.5aadde66@jawa>
In-Reply-To: <20190305162351.5aadde66@jawa>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 18:04:21 +0100
Message-ID: <CAK8P3a2J-NHyYASqUB=oNP++EgEV075fj=HapGU6-Gx_MXBGAQ@mail.gmail.com>
Subject: Re: [Y2038] Question regarding support of old time interfaces beyond y2038
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:24 PM Lukasz Majewski <lukma@denx.de> wrote:
>
> Dear Arnd,
>
> In your "playground" repository [1] (branch: y2038), the time functions
> (stime, settimeofday, etc) are not converted in Linux to be Y2038 aware
> (as for example clock_settime{64}() is).

Correct. FWIW, this is now merged into the mainline kernel.

> I've also searched on the Internet and I've found some old discussions
> regarding them:
>
> SHA1:  d33c577cccd0b3e5bb2425f85037f26714a59363 [2]
> From commit message:
>
> "The time, stime, utime, utimes, and futimesat system calls are only
> used on older architectures, and we do not provide y2038 safe variants
> of them, as they are replaced by clock_gettime64, clock_settime64,
> and utimensat_time64."
>
> Moreover, the stime has been even explicitly marked as obsolete [3].
>
>
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
>
>
>
>
> Has something changed since then? Has any new idea for conversion
> emerged?

No, this has been the plan for many years now.

> After observing the development of y2038 on playground [1], I can deduce
> that new interfaces are only going to be supported and converted
> (clock_settime64/clock_gettime64, etc.)
>
> Considering the above - would it be best to drop Y2038 support on 32
> bit machines for old syscalls (stime and friends) and for some others
> (settimeofday/gettimeofday) write Y2038 wrappers based on new time
> kernel API (clock_gettime/settime) in the C library (i.e. glibc)?

There are multiple dimensions to what you are asking here:

- On the user space interface, the C library (glibc, musl, uclibc, ...)
  implements a set of interfaces for time management. The
  set that is implemented here is defined by POSIX and other
  standards and decided by the respective C library implementation.
  All functions that get implemented here have to use the same
  definition of time_t however, so if there is both a clock_gettime()
  function and a time() function, they must either both use 32-bit
  time_t or both must use 64-bit time_t. Both can be implemented
  on top of any kernel interface for getting the time (time, gettimeofday,
  clock_gettime, clock_gettime64), but the only sensible implementation
  is to use clock_gettime64() in order to have the full range and
  resolution.

- The kernel has a growing set of system calls, i.e. we tend to
  only add new ones but not take old ones away. In many cases,
  a new syscall is a superset of the old one (e.g. oldstat, newstat
  stat64, xstat), any architecture that had an old version has
  to keep it around, but new architectures only ever provide the
  most recent variant.

     Arnd
