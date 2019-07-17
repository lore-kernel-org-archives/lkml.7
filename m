Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C948C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A9F21851
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4ryglVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfGQAGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:06:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41618 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfGQAGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:06:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so21741804ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWTBDLfiOb7SnMw+N5GrAnIvY64tlXzQQdEdF/klawQ=;
        b=Y4ryglVJki1UmhEc9yquaMBLVlfvGa8LpjpLNuH/Mo0i/2hfTSvRE3LciZGI1uwSNs
         dXK0SyNQYwrhrZQqhnNSluMsrCXDUr1aXp3fQM/devAD77pINnGDqh//AnQDCY9gdQU8
         aA+TmVOdclNE7j2lGm79SGVvaxQCAojvI2UNOQTlwlqkXPzoXXaLuxVrFBNJ12vh/IY2
         hZpNQ6ndyv1NvXDtf/x/ERy3Cu1X45OZ1fc7G9UUYZkRPFYQuDgWIsWd4p0SsTY5vJrh
         PvcL4jAlgJNtkfROgv9Ag5w0G7J5QI+J8n9wu5kSJBeLOlVR2BVR4L1KmUmieMMIqh1j
         rxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWTBDLfiOb7SnMw+N5GrAnIvY64tlXzQQdEdF/klawQ=;
        b=ccLB6kmGSOqmjULDOSf/nGFXdi5FHl1sa/PPBP13L+wbPuBDNFbMGjOP/+MDNEWf9u
         JQCWNx9LbXoEJIXM5fo8IWrvj+jmURoULEPmmCYxpEV233/YvGnmKwbNnQbwUEIN8CZC
         V78tPSMa41ajsI7ZF1mbgxlfQltJqsS+gXKY1DAZPrkLW4nTnKEr+XZadNqXk4dOz+eT
         yNBxKOQB/kiJyFP9yZsok3eGYKb9qBbLv0ZH82VtV6IoFdHPu11dcAvJOFTwvbPA6zWP
         z5inAo4TI6qpkT2vuJtnxB7C/lTI3dKuRjXtfvAxakn9xILBsPaQWFwqdH+4Q54Dg7ke
         F83A==
X-Gm-Message-State: APjAAAUlSVtBFK4mzolhnhb5GiFvmxLto02KWd8B2DHulBCxV2FNpRuD
        mMPYHdXj9jMRP+TyE5seVtSX4aT+9XvDvgKiVyM=
X-Google-Smtp-Source: APXvYqxkBXVHeEGtHHCDP05ZT176lupNUH/6sG/syt+yImLexbxuHAheccjAZUPQY7Av1RxxLt7aWN/RqLZEeIJpXHQ=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr19318497ljg.119.1563321968194;
 Tue, 16 Jul 2019 17:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190703005202.7578-1-alistair.francis@wdc.com>
 <mvmk1czh9y6.fsf@suse.de> <CAKmqyKPn9GBg=n1j-ZpEdCN4Qfi5qfNtEVgpgF8rYRpof4eNDA@mail.gmail.com>
 <mvmpnmqfepx.fsf@suse.de> <CAK8P3a2NmdoHzFGKrzw4CBYDOBtZHDQCGsWE_L0UbG+w0bGWkA@mail.gmail.com>
In-Reply-To: <CAK8P3a2NmdoHzFGKrzw4CBYDOBtZHDQCGsWE_L0UbG+w0bGWkA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 16 Jul 2019 17:02:50 -0700
Message-ID: <CAKmqyKPvqBZeL-R3no59XXieGo8qspoyEDYCWD3WR=ni-PRz3w@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andreas Schwab <schwab@suse.de>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 2:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 4, 2019 at 9:20 AM Andreas Schwab <schwab@suse.de> wrote:
> >
> > On Jul 03 2019, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > > On Wed, Jul 3, 2019 at 12:08 AM Andreas Schwab <schwab@suse.de> wrote:
> > >>
> > >> On Jul 02 2019, Alistair Francis <alistair.francis@wdc.com> wrote:
> > >>
> > >> > In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
> > >> > doesn't line up with the struct in glibc. In glibc world the _sifields
> > >> > union is 8 byte alligned (although I can't figure out why)
> > >>
> > >> Try ptype/o in gdb.
> > >
> > > That's a useful tip, I'll be sure to use that next time.
> >
> > It was a serious note.  If the structs don't line up then there is a
> > mismatch in types that cannot be solved by adding spurious padding.  You
> > need to fix the types instead.
>
> Would it be an option to align all the basic typedefs (off_t, time_t,
> clock_t, ...)
> between glibc and kernel then, and just use the existing
> sysdeps/unix/sysv/linux/generic/bits/typesizes.h after all to avoid
> surprises like this?
>
> As of v2 the functional difference is
>
> -#define __INO_T_TYPE        __ULONGWORD_TYPE
> +#define __INO_T_TYPE    __UQUAD_TYPE
>  #define __INO64_T_TYPE        __UQUAD_TYPE
>  #define __MODE_T_TYPE        __U32_TYPE
> -#define __NLINK_T_TYPE        __U32_TYPE
> -#define __OFF_T_TYPE        __SLONGWORD_TYPE
> +#define __NLINK_T_TYPE    __UQUAD_TYPE
> +#define __OFF_T_TYPE    __SQUAD_TYPE
>  #define __OFF64_T_TYPE        __SQUAD_TYPE
> -#define __RLIM_T_TYPE        __ULONGWORD_TYPE
> +#define __RLIM_T_TYPE      __UQUAD_TYPE
>  #define __RLIM64_T_TYPE        __UQUAD_TYPE
> -#define    __BLKCNT_T_TYPE        __SLONGWORD_TYPE
> +#define __BLKCNT_T_TYPE    __SQUAD_TYPE
>  #define    __BLKCNT64_T_TYPE    __SQUAD_TYPE
> -#define    __FSBLKCNT_T_TYPE    __ULONGWORD_TYPE
> +#define __FSBLKCNT_T_TYPE  __UQUAD_TYPE
>  #define    __FSBLKCNT64_T_TYPE    __UQUAD_TYPE
> -#define    __FSFILCNT_T_TYPE    __ULONGWORD_TYPE
> +#define __FSFILCNT_T_TYPE  __UQUAD_TYPE
>  #define    __FSFILCNT64_T_TYPE    __UQUAD_TYPE
> -#define    __FSWORD_T_TYPE        __SWORD_TYPE
> +#define __FSWORD_T_TYPE   __SQUAD_TYPE
> -#define __CLOCK_T_TYPE        __SLONGWORD_TYPE
> -#define __TIME_T_TYPE        __SLONGWORD_TYPE
> +#define __CLOCK_T_TYPE     __SQUAD_TYPE
> +#define __TIME_T_TYPE      __SQUAD_TYPE
>  #define __USECONDS_T_TYPE    __U32_TYPE
> -#define __SUSECONDS_T_TYPE    __SLONGWORD_TYPE
> +#define __SUSECONDS_T_TYPE __SQUAD_TYPE
> -#define __BLKSIZE_T_TYPE    __S32_TYPE
> +#define __BLKSIZE_T_TYPE   __SQUAD_TYPE
>  #define __FSID_T_TYPE        struct { int __val[2]; }
>  #define __SSIZE_T_TYPE        __SWORD_TYPE
> -#define __SYSCALL_SLONG_TYPE    __SLONGWORD_TYPE
> -#define __SYSCALL_ULONG_TYPE    __ULONGWORD_TYPE
> -#define __CPU_MASK_TYPE     __ULONGWORD_TYPE
> +#define __SYSCALL_SLONG_TYPE __SQUAD_TYPE
> +#define __SYSCALL_ULONG_TYPE __UQUAD_TYPE
> +#define __CPU_MASK_TYPE    __UQUAD_TYPE
>
> -#ifdef __LP64__
>  # define __RLIM_T_MATCHES_RLIM64_T    1
> -#else
> -# define __RLIM_T_MATCHES_RLIM64_T    0
> -#endif
>
> +#define __ASSUME_TIME64_SYSCALLS 1
> +#define __ASSUME_RLIM64_SYSCALLS 1
>
> Since the sysdeps/unix/sysv/linux/generic/bits/typesizes.h definitions
> generally match the kernel, anything diverging from that has the potential
> of breaking it, so the difference should probably be kept to the absolute
> minimum.
>
> I think these ones are wrong and will cause bugs similar to the clock_t
> issue if they are used with kernel interfaces:
> __NLINK_T_TYPE, __FSWORD_T_TYPE, __CLOCK_T_TYPE,
> __BLKSIZE_T_TYPE, __SYSCALL_ULONG_TYPE,
> __SYSCALL_SLONG_TYPE, __CPU_MASK_TYPE
>
> These are fine as long as they are only used in user space and to
> wrap kernel syscalls, but I think most of them can end up being
> passed to the kernel, so it seems safer not to have rv32 diverge
> without a good reason.
>
> The remaining ones (__INO_T_TYPE, __OFF_T_TYPE, __BLKCNT_T_TYPE,
> __FSBLKCNT_T_TYPE, __FSFILCNT_T_TYPE, __TIME_T_TYPE) all
> follow the pattern where the kernel has an old 32-bit type and a new
> 64-bit type, but the kernel tries not to expose the 32-bit interfaces
> to user space on new architectures and only provide the 64-bit
> replacements, but there are a couple of interfaces that never got
> replaced, typically in driver and file system ioctls.
>
> Since glibc already has code to deal with the 64-bit types and that
> is well tested, it would seem safer to me to just #undef the old
> types completely rather than defining them to 64-bit, which would
> make them incompatible with the kernel's types.

#undef-ing these results in build failures unfortunately, it seems
like they are required.

I'm sending a v3 RFC to the glibc list right now. We can continue the
discussion there.

Alistair

>
>        Arnd
