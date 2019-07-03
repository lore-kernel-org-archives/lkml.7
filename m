Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA3C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E02085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGCTr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:47:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34435 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:47:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so3179844qtu.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu6djyiUlDtpTUUCZPiIMkZuBFC6UZao2Rv1MMbdJQY=;
        b=cdLp9xNSAFB8ZwXkLyYuvr9/9s/ufvuWYv1f3zZjCc+MAL1i8BzLkZ4B2qiI5YoBXq
         TpP525Qt+FVNkPgo5DSr2gQevZGcjIGcdBUg0saYWl4izRPFTyVJvEhu/VZy2lFCV4o2
         anJ2n5khLG+zRl+qEJHThFTn8EaqQxn3AxrmCpVpRjo5QrFd23ieCiNUhXx++eD4B3f7
         Lth+hBVQlffi4E4JKrcn3w+xdFgVmquFavh7F/oFi9GjdvPKO6f13R9rbOxRYbpvsU35
         S6YEp8rIimxLlRqzCCC5BjxT507jco5s/Se024+NQTvvHZJ+yUjFNxR31G5IC9EoCRBB
         Rs+g==
X-Gm-Message-State: APjAAAU1vwblyRn+jy8HD5ujXwWmVNZNlQdEWQwqCg/pva+e8QRza4s5
        oiWFwD36mfrRpzd7cpnFdMV50GQp1Omh1gTeC3zikko2cZU=
X-Google-Smtp-Source: APXvYqxRHjCsWv3BgWezeFdm/f6b8yCsD6b1irOI08KPrtXIRPdxw7qvycrMoq0HHUNFZUNv3CqEHHaZA24xicS4o8g=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr31341893qtn.304.1562183274631;
 Wed, 03 Jul 2019 12:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com>
 <20190703001842.12238-3-alistair.francis@wdc.com> <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
 <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com>
In-Reply-To: <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 21:47:36 +0200
Message-ID: <CAK8P3a1zJPiR06uxZ5QVoEyDU64v=oUu_p9X-mULLeXN-som8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 8:45 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Jul 3, 2019 at 1:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jul 3, 2019 at 2:21 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > The glibc implementation of siginfo_t results in an allignment of 8 bytes
> > > for the union _sifields on RV32. The kernel has an allignment of 4 bytes
> > > for the _sifields union. This results in information being lost when
> > > glibc parses the siginfo_t struct.
> >
> > I think the problem is that you incorrectly defined clock_t to 64-bit,
> > while it is 32 bit in the kernel. You should fix the clock_t definition
> > instead, it would otherwise cause additional problems.
>
> That is the problem. I assume we want to change the kernel to use a
> 64-bit clock_t.

Certainly not!

Doing so would likely involve deprecating all system calls that
take a clock_t (anything passing a struct siginfo or struct tms) and
replacements based on clock64_t.

> What I don't understand though is how that impacted this struct, it
> doesn't use clock_t at all, everything in the struct is an int or
> void*.

si_utime/si_stime in siginfo are clock_t.

      Arnd
