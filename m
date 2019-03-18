Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E454C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCRI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:28:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46600 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:28:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id i5so9076143qkd.13;
        Mon, 18 Mar 2019 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4f6/vJQVu39aS3HwEd/+DTkaIedt/YxrIiDh3jSmPPU=;
        b=G/2HiBBP51Wx+i6cZzL4Kma65mwyvW/Wti2dBq/BcGSCX8JLWngXcxErw3Ae8GuyuB
         dWLczHlbEXvYU2/iNBu3Bk27tWaML6HpWBy+TrEKxBH8iZf2nu08kYx3inJOxAqK5A1Z
         2akZidEELTtajejniATIqeMB0zHhuDFAOFkxmMomTWw5wYcxisMhABTuSJOTdsTwpdjt
         ZAFrB9Ft5xcngP93euSCpSCasTI2cQHQYENpHeSZfCkoyGotCYihLv/aFWOYH3/CQxb8
         xOSjNMClWebdx3jxNwnJU6w5rtu90ON+Sh4yLXxP+34bLBw82RntrWGvjs6T2G92PvqA
         gXLQ==
X-Gm-Message-State: APjAAAXc64NXnqHT3V9GlGRf7os4PZu7T8YXqm+1rkWvkMxr2n+Iv8Dh
        Wyx8fshv9GrrjNN4aBQcG6oXuRzCfLT+j0VA0XU=
X-Google-Smtp-Source: APXvYqzb4rCEkUy8eoJYN2wGHxZP2NpImAXELe/n7exQV5Ooh3XZck7qbTxo47ibm3r8LNQXBiBGGps9q+YCScFhfJY=
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr11956706qkj.173.1552897683269;
 Mon, 18 Mar 2019 01:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
 <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
 <87a7hvded7.fsf@mid.deneb.enyo.de> <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
In-Reply-To: <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Mar 2019 09:27:46 +0100
Message-ID: <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Law <law@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Fri, Mar 15, 2019 at 2:20 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> > > On Thu, Mar 14, 2019 at 7:41 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> > >> > diff --git a/arch/alpha/include/uapi/asm/socket.h
> > >> > b/arch/alpha/include/uapi/asm/socket.h
> > >> > index 0d0fddb7e738..976e89b116e5 100644
> > >> > --- a/arch/alpha/include/uapi/asm/socket.h
> > >> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > >> > @@ -2,8 +2,8 @@
> > >> >  #ifndef _UAPI_ASM_SOCKET_H
> > >> >  #define _UAPI_ASM_SOCKET_H
> > >> >
> > >> > +#include <linux/posix_types.h>
> > >> >  #include <asm/sockios.h>
> > >> > -#include <asm/bitsperlong.h>
> > >>
> > >> This breaks POSIX conformance in glibc because the
> > >> <linux/posix_types.h> header is not namespace clean.  It contains the
> > >> identifiers fds_bits and val:
> > >>
> > >>         unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
> > >>
> > >>         int     val[2];
> > >
> > > What is problematic about the struct members here? I had thought that
> > > only the struct names have to be in a namespace to be usable here,
> > > but not the members.
> >
> > According POSIX, a user can do this:
> >
> > #define fds_bits 1024
> >
> > before including the <sys/socket.h> header file.  Similarly for val.
> >
> > Since glibc pulls in <asm/socket.h> indirectly, the result is a parse
> > error, even though the programmer did nothing wrong (fds_bits is not
> > an identifier used by POSIX, nor is it in the implementation
> > namespace, ans <sys/socket.h> is a POSIX header).

Ok, I see. Thanks for the explanation!

> > > We could use asm/posix_types.h instead of linux/posix_types.h,
> > > would that address your concern?
> >
> > It should fix the fds_bits case, I think.  But
> > <asm-generic/posix_types.h> still uses val, so that part of the issue
> > remains.
>
> Would moving kernel namespace types(__kernel prefix) to a different
> header file(kernel_types.h?) and then including this from
> linux/posix_types.h.
> And, for socket.h just including kernel_types.h make sense?

I fear we have considered linux/posix_types.h to be something that
can be included anywhere for a long time, so it may be better to
ensure that this is actually the case, and avoid the problem with those
two structures but leave the rest untouched.

I think we can move  __kernel_fsid_t into include/uapi/asm-generic/statfs.h,
which is the only thing that needs it anyway. We have two definitions of
it today, the non-generic one being for mips32, but incidentally there was
a patch the other day to remove that and use the generic one instead.

With that done, we can change asm/socket.h to just use asm/posix_types.h.

I would still prefer to solve the problem for linux/posix_types.h as well,
but I'm not sure even how __kernel_fd_set  is used today in
user space, if at all. Commit 8ded2bbc1845 ("posix_types.h: Cleanup
stale __NFDBITS and related definitions") removed most of the fd_set
definition after a long discussion [1], and since then it has been
basically impossible to use 'struct fd_set'  from the kernel in a
meaningful way without including the libc headers or duplicating
them.

Should we just remove __kernel_fd_set from the exported headers and
define the internal fd_set directly in include/linux/types.h? (Adding the
folks from the old thread to Cc).

      Arnd

[1] https://lore.kernel.org/lkml/20120724181209.GA10534@zod.bos.redhat.com/t/
