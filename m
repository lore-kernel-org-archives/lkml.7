Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2E218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGDJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:19:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33614 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfGDJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:19:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id h24so7378782qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UU1LRzgJ9KtlIamPG1rpTOdBbiRt377kXD3IRu4KTEc=;
        b=WgiZHTN9qZ6nFhuCUpG2LVjkyW3WX5VDZn4TPjBad3pSSXROgjqBp1RCASoCNesZKM
         uKmDqEW+/vZyuouz5O1CbpKmDHpq7hwd6G9I6i2VnFgXheNpwr9VuM67k6yFhqS0Nxda
         t2kkB3GVbtz+tlKxd6aKOBM6sI/DHcRznSwyXPHaPQNeW+V20ZId5LiEchdeyP4HD4G1
         InWh36VgRRFtPKRVPfxoBRTv+5IP97KvQb05+UqZAbKjaFQNWzavpl17tDkOP69sL4N+
         bvPgwVWmrywkbqOZJytsNfl27XaLTd+7vrR23siorcjR2VjOb8K5CZfzRiBxsakmIHY7
         y7UA==
X-Gm-Message-State: APjAAAWwpLPfQQ9zlqsA41v6erOc3/EE5CD3kwd9KJJf2ylWTgpDDKxg
        suJPIJdFEdA4dl8tboiStjZYPys6Dx/MghUj62wk8IhE34o=
X-Google-Smtp-Source: APXvYqz9HnBRmgYL+EgQde6QoC+3TNiwekg2y+kqVusM0V3Keg/hNYgvdDkMLVnEv4+p3P8DAILsb6JwSzdx30DpREE=
X-Received: by 2002:aed:3363:: with SMTP id u90mr2705494qtd.7.1562231969777;
 Thu, 04 Jul 2019 02:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190703005202.7578-1-alistair.francis@wdc.com>
 <mvmk1czh9y6.fsf@suse.de> <CAKmqyKPn9GBg=n1j-ZpEdCN4Qfi5qfNtEVgpgF8rYRpof4eNDA@mail.gmail.com>
 <mvmpnmqfepx.fsf@suse.de>
In-Reply-To: <mvmpnmqfepx.fsf@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jul 2019 11:19:13 +0200
Message-ID: <CAK8P3a2NmdoHzFGKrzw4CBYDOBtZHDQCGsWE_L0UbG+w0bGWkA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
To:     Andreas Schwab <schwab@suse.de>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 9:20 AM Andreas Schwab <schwab@suse.de> wrote:
>
> On Jul 03 2019, Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Wed, Jul 3, 2019 at 12:08 AM Andreas Schwab <schwab@suse.de> wrote:
> >>
> >> On Jul 02 2019, Alistair Francis <alistair.francis@wdc.com> wrote:
> >>
> >> > In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
> >> > doesn't line up with the struct in glibc. In glibc world the _sifields
> >> > union is 8 byte alligned (although I can't figure out why)
> >>
> >> Try ptype/o in gdb.
> >
> > That's a useful tip, I'll be sure to use that next time.
>
> It was a serious note.  If the structs don't line up then there is a
> mismatch in types that cannot be solved by adding spurious padding.  You
> need to fix the types instead.

Would it be an option to align all the basic typedefs (off_t, time_t,
clock_t, ...)
between glibc and kernel then, and just use the existing
sysdeps/unix/sysv/linux/generic/bits/typesizes.h after all to avoid
surprises like this?

As of v2 the functional difference is

-#define __INO_T_TYPE        __ULONGWORD_TYPE
+#define __INO_T_TYPE    __UQUAD_TYPE
 #define __INO64_T_TYPE        __UQUAD_TYPE
 #define __MODE_T_TYPE        __U32_TYPE
-#define __NLINK_T_TYPE        __U32_TYPE
-#define __OFF_T_TYPE        __SLONGWORD_TYPE
+#define __NLINK_T_TYPE    __UQUAD_TYPE
+#define __OFF_T_TYPE    __SQUAD_TYPE
 #define __OFF64_T_TYPE        __SQUAD_TYPE
-#define __RLIM_T_TYPE        __ULONGWORD_TYPE
+#define __RLIM_T_TYPE      __UQUAD_TYPE
 #define __RLIM64_T_TYPE        __UQUAD_TYPE
-#define    __BLKCNT_T_TYPE        __SLONGWORD_TYPE
+#define __BLKCNT_T_TYPE    __SQUAD_TYPE
 #define    __BLKCNT64_T_TYPE    __SQUAD_TYPE
-#define    __FSBLKCNT_T_TYPE    __ULONGWORD_TYPE
+#define __FSBLKCNT_T_TYPE  __UQUAD_TYPE
 #define    __FSBLKCNT64_T_TYPE    __UQUAD_TYPE
-#define    __FSFILCNT_T_TYPE    __ULONGWORD_TYPE
+#define __FSFILCNT_T_TYPE  __UQUAD_TYPE
 #define    __FSFILCNT64_T_TYPE    __UQUAD_TYPE
-#define    __FSWORD_T_TYPE        __SWORD_TYPE
+#define __FSWORD_T_TYPE   __SQUAD_TYPE
-#define __CLOCK_T_TYPE        __SLONGWORD_TYPE
-#define __TIME_T_TYPE        __SLONGWORD_TYPE
+#define __CLOCK_T_TYPE     __SQUAD_TYPE
+#define __TIME_T_TYPE      __SQUAD_TYPE
 #define __USECONDS_T_TYPE    __U32_TYPE
-#define __SUSECONDS_T_TYPE    __SLONGWORD_TYPE
+#define __SUSECONDS_T_TYPE __SQUAD_TYPE
-#define __BLKSIZE_T_TYPE    __S32_TYPE
+#define __BLKSIZE_T_TYPE   __SQUAD_TYPE
 #define __FSID_T_TYPE        struct { int __val[2]; }
 #define __SSIZE_T_TYPE        __SWORD_TYPE
-#define __SYSCALL_SLONG_TYPE    __SLONGWORD_TYPE
-#define __SYSCALL_ULONG_TYPE    __ULONGWORD_TYPE
-#define __CPU_MASK_TYPE     __ULONGWORD_TYPE
+#define __SYSCALL_SLONG_TYPE __SQUAD_TYPE
+#define __SYSCALL_ULONG_TYPE __UQUAD_TYPE
+#define __CPU_MASK_TYPE    __UQUAD_TYPE

-#ifdef __LP64__
 # define __RLIM_T_MATCHES_RLIM64_T    1
-#else
-# define __RLIM_T_MATCHES_RLIM64_T    0
-#endif

+#define __ASSUME_TIME64_SYSCALLS 1
+#define __ASSUME_RLIM64_SYSCALLS 1

Since the sysdeps/unix/sysv/linux/generic/bits/typesizes.h definitions
generally match the kernel, anything diverging from that has the potential
of breaking it, so the difference should probably be kept to the absolute
minimum.

I think these ones are wrong and will cause bugs similar to the clock_t
issue if they are used with kernel interfaces:
__NLINK_T_TYPE, __FSWORD_T_TYPE, __CLOCK_T_TYPE,
__BLKSIZE_T_TYPE, __SYSCALL_ULONG_TYPE,
__SYSCALL_SLONG_TYPE, __CPU_MASK_TYPE

These are fine as long as they are only used in user space and to
wrap kernel syscalls, but I think most of them can end up being
passed to the kernel, so it seems safer not to have rv32 diverge
without a good reason.

The remaining ones (__INO_T_TYPE, __OFF_T_TYPE, __BLKCNT_T_TYPE,
__FSBLKCNT_T_TYPE, __FSFILCNT_T_TYPE, __TIME_T_TYPE) all
follow the pattern where the kernel has an old 32-bit type and a new
64-bit type, but the kernel tries not to expose the 32-bit interfaces
to user space on new architectures and only provide the 64-bit
replacements, but there are a couple of interfaces that never got
replaced, typically in driver and file system ioctls.

Since glibc already has code to deal with the 64-bit types and that
is well tested, it would seem safer to me to just #undef the old
types completely rather than defining them to 64-bit, which would
make them incompatible with the kernel's types.

       Arnd
