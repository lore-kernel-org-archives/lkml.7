Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DDFC742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF852084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OtEP9Wdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfGLO4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:23 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42039 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:17 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6CEtk35021108
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 23:55:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6CEtk35021108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562943347;
        bh=6FhfPi35nywJuz76CvGaaD2GY6Th8cqwAFaZPK60WPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OtEP9WddgHX8iLcY6+MtcE1Q7uNpmugN2+PC2T0RWqFd/ywXmy+L++42o2SMQIBWA
         /1GcADf1FLaFVV1Xf/cHVW+BGkHcI8VyE5AQqyzHOowbv0e5EpqJnKFoGV1V8YJnRX
         60Fwd30GrO1SHO6DZfIiUW5exAduKP8PTl3P469C3Yy9Bndh040EPgSVw/GSV4o6xw
         zkx/KWmrdwVeGhKCmvMfL0F/NtNUXQ7ONhPbTYF1wvaTwc1ttwYQneER9LSvK49Qp7
         Ih6aa4xkOdzY5xD2p0h0mkNkQd+QFCMnBEvFoc6Bp2R1O/0bj5ymmNL50sFjK9pExz
         jkgr7JRmWh0Qg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id v129so6844588vsb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 07:55:47 -0700 (PDT)
X-Gm-Message-State: APjAAAXO8jGZp4jPLb3zDQBJGd27VvPiCJXtS/YxMkyYCnWChYs9Qfoq
        D/RI1syLwYezJxazaaCxj45Vb2/P7xeC/rcK9wg=
X-Google-Smtp-Source: APXvYqzQS0/29Qt4updS1sUcWeQlS15A6ishYNIxSYU+nuoKb9gD8iaF+UiiHqYuAcBI2W/oy3RUEwl/CswoBIzMSSE=
X-Received: by 2002:a67:d46:: with SMTP id 67mr9042919vsn.181.1562943346190;
 Fri, 12 Jul 2019 07:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190712101556.17833-1-naohiro.aota@wdc.com> <20190712101556.17833-2-naohiro.aota@wdc.com>
In-Reply-To: <20190712101556.17833-2-naohiro.aota@wdc.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Jul 2019 23:55:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARj+ZAdQVBOEJfq3h22g20d8DH6h83=4giBOD-NqQoNjg@mail.gmail.com>
Message-ID: <CAK7LNARj+ZAdQVBOEJfq3h22g20d8DH6h83=4giBOD-NqQoNjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64/vdso: fix flip/flop vdso build bug
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 7:16 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> Running "make" on an already compiled kernel tree will rebuild the kernel
> even without any modifications:
>
> $ make ARCH=arm64 CROSS_COMPILE=/usr/bin/aarch64-unknown-linux-gnu-
> arch/arm64/Makefile:58: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOSYM include/generated/vdso-offsets.h
>   CHK     include/generated/compile.h
>   CC      arch/arm64/kernel/signal.o
>   CC      arch/arm64/kernel/vdso.o
>   CC      arch/arm64/kernel/signal32.o
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   OBJCOPY arch/arm64/kernel/vdso/vdso.so
>   AS      arch/arm64/kernel/vdso/vdso.o
>   AR      arch/arm64/kernel/vdso/built-in.a
>   AR      arch/arm64/kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>
> This is the same bug fixed in commit 92a4728608a8 ("x86/boot: Fix
> if_changed build flip/flop bug"). We cannot use two "if_changed" in one
> target. Fix this build bug by merging two commands into one function.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
