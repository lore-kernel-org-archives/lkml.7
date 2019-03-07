Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B13C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCGP1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:27:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44866 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:27:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id d2so17467526qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5xTH+/6WdNJ/as9PcGJiAcRYVVnpI+EDPMYTZd1JOI=;
        b=Mu1b4BhbB1lrs4bVMWv4ydbpf1OhwQDyvpBGXEn+0Ii1HTRnVTKhHhaf0mnQK0/KNq
         89KV0SHiZE4Bjvgb3EE27xPi/UXSHEHzrw4DDQ/hSZo1spCcAO15zNLvuiLtOHNeY12k
         1EFkWuJYxX0VJG2N4NiwRRxI828LtDAKGN0wSoDEGjLR9R1b5a7MHvcpFgmlksDCRy3P
         rtk359YsUKdugOkirQlKBBfnPTALWZQv4E0+HarecDKKEa3tu89lp8bHbcJkgNky35u2
         81UueCPkTE3+ywd15l4TuHGfrc4RCyhTwVSGqORNyxwp86jpd6N/HUb15u7n41mengAs
         g1dw==
X-Gm-Message-State: APjAAAWdq8RVZDMScfQzUWKFHqnukJti2WFSzTbDE8Kd+CSIJeQxflYq
        YjaLC7Q9Bu4+ScT9MduLFdSxS8CFWxu/hmTEYL2pN2a/
X-Google-Smtp-Source: APXvYqwCQQDvIBgaimQ8HFq3KZxCrfmb96rdkGyx3+l/Mm3XKFhIQn+rAD+jGNduRtDv2lXSSF/U+ozLoglvqMGPGy4=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr11022112qve.149.1551972432079;
 Thu, 07 Mar 2019 07:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20190305162351.5aadde66@jawa> <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
 <20190307085329.2b6cbeb7@jawa> <CAK8P3a3GotM4WY9dJK8yPujxLgHXtnes=nMUKq5fJ4hTkZWqzg@mail.gmail.com>
 <20190307154310.677b59dd@jawa>
In-Reply-To: <20190307154310.677b59dd@jawa>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:26:54 +0100
Message-ID: <CAK8P3a0OBBEwU044jbe-YK2CmCnpNpUSiCA9uRo-8EwtcUva6g@mail.gmail.com>
Subject: Re: [Y2038] Question regarding support of old time interfaces beyond y2038
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Zack Weinberg <zackw@panix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:43 PM Lukasz Majewski <lukma@denx.de> wrote:
> > On Thu, Mar 7, 2019 at 8:53 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > > On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de>

> To be more specific:
>
> I'm thinking of settimeofday/gettimeofday syscalls.
>
> In the kernel we use internally do_sys_settimeofday64() to support
> clock_settime() and settimeofday()
>
> The internal (in-kernel) representation for those two is struct
> timespec64.
>
> If I may ask - why settimeofday64() and gettimeofday64() are not
> implemented?
>
> Is it because the same result can be achieved with clock_settime64(tv64)
> + settimeofday(NULL, tz) ?
> (The drawback is two syscalls instead of one).

Yes, that is the idea. I don't see the drawback as significant here,
since settimeofday() is not performance critical.

> I've also stumbled upon the __kernel_timex introduction on the
> playground branch:
>
> "time: Add struct __kernel_timex"
> 2c620ff93d9fbd5d644760d4c21d389078ec1080
>
> This one introduces the:
> struct __kernel_timex_timeval {
>         __kernel_time64_t tv_sec;
>         long long tv_usec;
> };
>
> This code is "protected" by CONFIG_64BIT_TIME.
>
> Is there any plan to explicitly introduce:
>
> struct __kernel_timeval {
>        __kernel_time64_t tv_sec;
>        long ong tv_usec;
> }
>
> and convert settimeofday()/gettimeofday() ?

No, see above. Basically all system calls that take a 'timeval'
already have a replacement that uses a 'timespec' with
nanosecond resolution, so the idea was that by not having
a new timeval, we make sure to catch any calls that need a
nanosecond based version as well.

clock_adjtime() is a bit of a special case here because
it uses a timeval structure but passes nanoseconds in it
when ADJ_NANO is set.

      Arnd
