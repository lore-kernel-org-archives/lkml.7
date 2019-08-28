Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A694C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517DB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2qOK8B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1KAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:00:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1J77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:59:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so1812790wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Nz++kIJqul0wPSRdmkNJtLbYUtvatvDKV4U+pZdOE0E=;
        b=T2qOK8B5cENn8IcBsun1X2SLnMxW124L/fEq9S+YoGCnGJn1pztFayUK6kIrC69oD5
         CXNvDbc/oX9+12cns5eDBKnlrJ0dhdrpB2lpGNEWknF61CYC7b4rRQH/7L130Gf/Kk5y
         N+T+58J5s7k5qEUfszb3AhUsFrTGRStbYHYDr+6hSESObpHhUv7na8Y0ReyRJt2Ale0p
         ocNxuxVV7rGRaBdYvnjPF1vHC6W3pOuuGWw9ZsVB9K3MgVu0v93yYrSKLc+5is2isqNr
         T7MjXqtEytn8JnLbYTHGpawkof1ICiM+F0ghkuaJ5V3PuL6o+lGDdamrIwjdJ62ld4Iy
         owog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Nz++kIJqul0wPSRdmkNJtLbYUtvatvDKV4U+pZdOE0E=;
        b=rPZ1+3ka8RtIl+AwH4ZpyLNPn9HIFThfHK1UPaKHb3KbJnOguGA26FgkGdtlul2X6H
         9nk23Bf8ddCw49uCHkk/Qdyfxrq71llXi0jbhXIUyT7OL1cmzh28N+tuaqEDxAlq0IzE
         xAa8XyMKP0RKMUqn44fT51SMXDeMMTdkW2WGPoKZb3nDxqQMMba8o3A2pwn8GjzrSnv3
         g/EhvWBEFMC7OYAvZFBCUjzE5H6UgYx05mB3va7BNl9g9IGI764rW5vMHuAbAndVz5aA
         02vgYPOi+tw9pGkfGNg0jOPvnxjbIJlW4bRWFm7bhZ3PvIO0EizNIaUvtbNS3Y5putjU
         GHUQ==
X-Gm-Message-State: APjAAAUxyBjSLG2NwpHy99sUG3hdOuBAYnWxl33BC0a4kUE/k0AUNOmP
        GZkGpLiMl6bmvRpL7lEwCc53Pav4rbWiTCMMJfU=
X-Google-Smtp-Source: APXvYqxEMobkHphgNzEjtUwGaUgd4aS652PWaGrihjiEjENA35PF48nfug7PVU3eGUTYKxnsAbulOXR+9my5R6v9K/s=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr3425130wrb.261.1566986397568;
 Wed, 28 Aug 2019 02:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 28 Aug 2019 11:59:46 +0200
Message-ID: <CA+icZUVT8GJCPSSB=jLKLu=-OrWAj5W3Rkbx1ar0SGcEq0-D0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, will@kernel.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        davem@davemloft.net, paul.burton@mips.com,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:40 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> GCC unescapes escaped string section names while Clang does not. Because
> __section uses the `#` stringification operator for the section name, it
> doesn't need to be escaped.
>
> This fixes an Oops observed in distro's that use systemd and not
> net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.
>
> Instead, we should:
> 1. Prefer __section(.section_name_no_quotes).
> 2. Only use __attribute__((__section(".section"))) when creating the
> section name via C preprocessor (see the definition of __define_initcall
> in arch/um/include/shared/init.h).
>
> This antipattern was found with:
> $ grep -e __section\(\" -e __section__\(\" -r
>

Hi Nick,

thanks for the v2 of your patch-series.

I just checked v2 on top of Linux v5.3-rc6...

sdi@iniza:~/src/linux-kernel/linux$ grep -e __section\(\" -e __section__\(\" -r
include/linux/compiler_attributes.h: *        __section(".foo")
include/linux/compiler_attributes.h: *        verbose
__attribute__((__section__(".foo" x))) should be preferred.

OK: Description of the problem ^^

arch/sh/include/asm/cache.h:#define __read_mostly
__attribute__((__section__(".data..read_mostly")))

PATCH next-20190827 ^^
sh: prefer __section from compiler_attributes.h
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190827&id=baf58858e8b6d853a7a8308901fcdd438e92a522

arch/arm64/kernel/smp_spin_table.c:volatile unsigned long
__section(".mmuoff.data.read")
arch/arm64/include/asm/cache.h:#define __read_mostly
__attribute__((__section__(".data..read_mostly")))

PATCH next-20190827 ^^
arm64: prefer __section from compiler_attributes.h
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190827&id=80d838122643a09a9f99824adea4b4261e4451e6

arch/um/include/shared/init.h:  __attribute__((__section__(".initcall"
level ".init"))) = fn

??? ^^

> See the discussions in:
> https://bugs.llvm.org/show_bug.cgi?id=42950
> https://marc.info/?l=linux-netdev&m=156412960619946&w=2
>

List CBL issue tracker to discussions:
https://github.com/ClangBuiltLinux/linux/issues/619

- Sedat -

> Changes V1 -> V2:
> * drop arm64, arc, and sh patches as they were picked up by their
>   maintainers.
> * Split the previous V1 hunk from include/linux that touched
>   include/linux/compiler.h off into its own patch for inclusion in
>   stable, as it fixes a user visible issue.
> * Collect Acks and Tested by tags.
>
> Nick Desaulniers (14):
>   s390/boot: prefer __section from compiler_attributes.h
>   include/linux/compiler.h: prefer __section from compiler_attributes.h
>   parisc: prefer __section from compiler_attributes.h
>   um: prefer __section from compiler_attributes.h
>   ia64: prefer __section from compiler_attributes.h
>   arm: prefer __section from compiler_attributes.h
>   mips: prefer __section from compiler_attributes.h
>   sparc: prefer __section from compiler_attributes.h
>   powerpc: prefer __section and __printf from compiler_attributes.h
>   x86: prefer __section from compiler_attributes.h
>   include/asm-generic: prefer __section from compiler_attributes.h
>   include/linux: prefer __section from compiler_attributes.h
>   include/linux/compiler.h: remove unused KENTRY macro
>   compiler_attributes.h: add note about __section
>
>  arch/arm/include/asm/cache.h          |  2 +-
>  arch/arm/include/asm/mach/arch.h      |  4 ++--
>  arch/arm/include/asm/setup.h          |  2 +-
>  arch/ia64/include/asm/cache.h         |  2 +-
>  arch/mips/include/asm/cache.h         |  2 +-
>  arch/parisc/include/asm/cache.h       |  2 +-
>  arch/parisc/include/asm/ldcw.h        |  2 +-
>  arch/powerpc/boot/main.c              |  3 +--
>  arch/powerpc/boot/ps3.c               |  6 ++----
>  arch/powerpc/include/asm/cache.h      |  2 +-
>  arch/powerpc/kernel/btext.c           |  2 +-
>  arch/s390/boot/startup.c              |  2 +-
>  arch/sparc/include/asm/cache.h        |  2 +-
>  arch/sparc/kernel/btext.c             |  2 +-
>  arch/um/kernel/um_arch.c              |  6 +++---
>  arch/x86/include/asm/cache.h          |  2 +-
>  arch/x86/include/asm/intel-mid.h      |  2 +-
>  arch/x86/include/asm/iommu_table.h    |  5 ++---
>  arch/x86/include/asm/irqflags.h       |  2 +-
>  arch/x86/include/asm/mem_encrypt.h    |  2 +-
>  arch/x86/kernel/cpu/cpu.h             |  3 +--
>  include/asm-generic/error-injection.h |  2 +-
>  include/asm-generic/kprobes.h         |  5 ++---
>  include/linux/cache.h                 |  6 +++---
>  include/linux/compiler.h              | 31 ++++-----------------------
>  include/linux/compiler_attributes.h   | 10 +++++++++
>  include/linux/cpu.h                   |  2 +-
>  include/linux/export.h                |  2 +-
>  include/linux/init_task.h             |  4 ++--
>  include/linux/interrupt.h             |  5 ++---
>  include/linux/sched/debug.h           |  2 +-
>  include/linux/srcutree.h              |  2 +-
>  32 files changed, 54 insertions(+), 74 deletions(-)
>
> --
> 2.23.0.187.g17f5b7556c-goog
>
