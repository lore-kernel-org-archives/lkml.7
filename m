Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48ECC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8992087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COv+Fw3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfD3UZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:25:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33339 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3UZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:25:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so7380242pgh.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PumMms/fmvRZNGgk1wpaT/iecwtP2mfoCrsOEiXiMBw=;
        b=COv+Fw3qYpQJGBIu/FlHN4GwAnWb+mBOMG3BzMpMWRcjr0uvOtAeIxDScZFZT+bw7k
         nvDtQ1BYuJQ9P1OVIjzsX8vbEFl6U9x1i62pua//qQiKBVPaM0GruaoDc01Sgq5ZCvEO
         zAeBrm73peFGCc4ffFShl5jVh79XwrcrTrS/600nprTYXF/O60fZtpjAMDo+sfyXoiAh
         U0j6I2sp7hCnCLsoE8QzLLeGghv6zAIxRTrar+5bEildulXLpmV+svPWfe+WSqap9x+2
         o0gDraqO7iUecqRNdiF7D2r0Y5GD7l6giiH+OWVuccUhC9mCOSPv3XgOrD7uurIhnkQF
         JbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PumMms/fmvRZNGgk1wpaT/iecwtP2mfoCrsOEiXiMBw=;
        b=bp+1+io4Bnp6UoWbvsrBetujsW5BGpRxnOtfQVZCcR3vT98Z5lEq7vGHijJPlEsxuJ
         Z8z3eTmAfe5rJacjjPoU/ebUjvjPcs9ZqAOuSGIjWJj1GIgmCJBQzd1j6p7RGlgCQH6w
         JFjIrQvbEGwXcjaeSIuA+DmIYc0vKAYchilic7dTm7W9xv7vGMTEzeO2pkYfRJCHVcRJ
         wEKy0Mn3+KXFJJebUTbG2SU0hIJu4aKIayzp2hlb2ociP7LYvgpEDAwHqvyYNAyrihS6
         yAK+90CVGJHFsQdLmRAQ/3E41pwGcCSDD2Atg+DR7eQU28I16NlcM98qd9j0xTp2txlE
         x9Cg==
X-Gm-Message-State: APjAAAWoqg7l+KIj0RPiIFu13CD0wkitWcwQ2YaNj4Uqhr9uF47S8vc4
        5Sx0LQM05T8JxADmIVMGwjbIOYdsvIWSnakExDOv8Q==
X-Google-Smtp-Source: APXvYqxPruPo3q2EEOLkAgwqeO24bHPYSbHgRM4IkVR8xVhZ8jhDuWMYQDccRT/raKHKAmEfAQt5wvtxASCfnyBCnjc=
X-Received: by 2002:a63:f817:: with SMTP id n23mr27483996pgh.302.1556655950636;
 Tue, 30 Apr 2019 13:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190423211116.261111-1-ndesaulniers@google.com>
In-Reply-To: <20190423211116.261111-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 13:25:39 -0700
Message-ID: <CAKwvOd=dBLXQUzv8R3-JqF=pUTH0-5O3v+_ceekT3W23VxtDbg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: vdso: drop unnecessary cc-ldoption
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 2:11 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
>
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/powerpc/kernel/vdso32/Makefile | 5 ++---
>  arch/powerpc/kernel/vdso64/Makefile | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index ce199f6e4256..06f54d947057 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -26,9 +26,8 @@ GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>
> -ccflags-y := -shared -fno-common -fno-builtin
> -ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
> +       -Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
>  asflags-y := -D__VDSO32__ -s
>
>  obj-y += vdso32_wrapper.o
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 28e7d112aa2f..32ebb3522ea1 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -12,9 +12,8 @@ GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>
> -ccflags-y := -shared -fno-common -fno-builtin
> -ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
> +       -Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
>  asflags-y := -D__VDSO64__ -s
>
>  obj-y += vdso64_wrapper.o
> --
> 2.21.0.593.g511ec345e18-goog
>

bumping for review
-- 
Thanks,
~Nick Desaulniers
