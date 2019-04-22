Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfDVVqH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:46:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39755 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDVVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:46:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id h16so3533405qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 14:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tt+a5M/B7TQLGucHULuqskJ+Z0GUmxyy6884GCd0AyU=;
        b=T3nZa8OL/bbarOFwaZHwsM7/9VSCKacmDuPWWE94MU+H5EXAIgFb8S/ud+DudTo6Lk
         gM+t0sez8lHdYnu3zCYlzemQWgvfYn41DJ/kWekmVAbTfdGiM+wuxmmOcc7MosbaaAUI
         mIVE7VCuu8xxTdFnYaZdgDGXVsrheQaLNf5wnZreYb6ofGfFPpVZTXTE84Vx96IhYvXr
         n/Jv7YzpIfDyfzG+2AjP6y2wkdqKurAxZlabnuWHyZ3UzIMg3ySRzoVRyPZjq+KCjC3K
         FA/cswxcqbIY1nmv3+ZP/XR8M9cJN5GVLRYg/QyrjUbKihWTUXuuw/hFVbPyxmahfamp
         TxgQ==
X-Gm-Message-State: APjAAAW1i9cCkwqqE6T7o1iLaLmS83604N940UrsQFXHyNeQEa0qswqS
        9b6JcRb8vQQqN5bvVmAeE2gHJ8czPaU6qxdL84Y=
X-Google-Smtp-Source: APXvYqwM/nbe1A4zyuT6kP7w9hIpLc6FF4rcQkRNl31jEHxPf+MCl+SrovB4iX5UMLsbAs8m7gI+YZ7c2Q95s+K77EM=
X-Received: by 2002:ac8:3f38:: with SMTP id c53mr6541591qtk.152.1555969565823;
 Mon, 22 Apr 2019 14:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190414220841.20243-1-lukma@denx.de> <20190414220841.20243-4-lukma@denx.de>
 <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru> <20190420132112.131f449b@jawa>
 <20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru>
In-Reply-To: <20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Apr 2019 23:45:49 +0200
Message-ID: <CAK8P3a1+2H_XAZVivutv98S5Op8HENVfxP=zh39VPcLCx2okQg@mail.gmail.com>
Subject: Re: [PATCH 3/6] y2038: linux: Provide __clock_settime64 implementation
To:     Stepan Golosunov <stepan@golosunov.pp.ru>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:07 AM Stepan Golosunov
<stepan@golosunov.pp.ru> wrote:
> 20.04.2019 в 13:21:12 +0200 Lukasz Majewski написал:
> Is it? The kernel (5.1-rc6) code looks to me like
>
>         /* Zero out the padding for 32 bit systems or in compat mode */
>         if (false && false)
>                 kts.tv_nsec &= 0xFFFFFFFFUL;
>
> in 32-bit kernels. And like
>
>         if (false && true)
>                 kts.tv_nsec &= 0xFFFFFFFFUL;
>
> for COMPAT syscalls in 64-bit kernels.
>
> It should probably be changed into
>
>         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
>                 kts.tv_nsec &= 0xFFFFFFFFUL;
>
> (Or into something like
>
>         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall() && !COMPAT_USE_64BIT_TIME)
>                 kts.tv_nsec &= 0xFFFFFFFFUL;
>
> if x32 should retain 64-bit tv_nsec.)

I think the problem is that at some point CONFIG_64BIT_TIME was
meant to be enabled on both 32-bit and 64-bit kernels, but the
definition got changed along  the way.

We probably just want

        if (in_compat_syscall() )
               kts.tv_nsec &= 0xFFFFFFFFUL;

here, which would then truncate the nanoseconds for all compat
mode including x32. For native mode, we don't need to truncate
it, since timespec64 has a 32-bit 'tv_nsec' field in the kernel.

> > However, I would prefer not to pass random data
> > to the kernel, and hence I do clear it up explicitly in glibc.
>
> If the kernel does not ignore padding on its own, then zeroing it out
> is required everywhere timespec is passed to kernel, including via
> code not known to glibc. (Does anyone promise that there won't be any
> ioctls that accept timespec, for example?) That seems to be
> error-prone (and might requre copying larger structes).
>
> On the other hand, if kernel 5.1+ ignores padding as intended there is
> no need to create additional copy of structs in glibc code that calls
> into clock_settime64 (or into timer_settime64 that accepts larger
> struct, for example).

The intention is that the kernel ignores the padding. If you find
another place in the kernel that forget that, we should fix it.

> > > And, hmm, is CONFIG_64BIT_TIME enabled anywhere?
>
> I guess that the remaining CONFIG_64BIT_TIME in kernel should be
> replaced with CONFIG_COMPAT_32BIT_TIME or removed.

We should remove CONFIG_64BIT_TIME. CONFIG_COMPAT_32BIT_TIME
is still needed to identify architectures that don't have it, in
particular riscv32.

       Arnd
