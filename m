Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C036C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C6B20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vbwJLkfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfGLOz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:55:27 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39764 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:55:26 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6CEtD9g020921
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 23:55:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6CEtD9g020921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562943314;
        bh=2pCn3yeZu/5Q2TZ7hwyekTh8gaDXfLpUYTMHRaRKfZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vbwJLkfhAyD6kysrcM2dBwlzd9/P4agKISRgG1KHBDsnjLPSxtMJUFtDQxXVdjrYd
         2lxM2g9nOjmUdc+25f1RYKJ/VItylPv4CwCO6XIgja3x+fYuuQs778NbE9NaQDCzeC
         XpoKcrITF+VnVhLgp8J0J0512FNW7m98T2gpzWcxMGFvviv4UfZWtwKm111aH5/Haz
         LLVS7B7vrH6riB0/bS3OE7mqUCKrj1weGoyGF7BqgwlUQ3Ys8D7LUP7/NoA4WpjMMt
         kfr8GktKxBofKDSOtN6T7mWeBwNn22iiBIo0SRHZsuVFfLRavSwZQxZK/Ef0bDrtdn
         9rg8xTtQ71hBQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id y16so6869036vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 07:55:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXXf9yFwta+1AsmOC3VsP6Uxc3n2dXMUOEIlhyPOkNKergbFZVT
        0yvPwIywlGMBs4TV51dtyc+8cIkOMkqdbZjx760=
X-Google-Smtp-Source: APXvYqyOblEoxiyJtJYBVHt1jiVIyAbvLUdk4h6mGGG8agisxPfBXzNJ9vXVUD4fHABlfzzua3TIhyZa7QPG+rEnIVM=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr8670685vsd.215.1562943313188;
 Fri, 12 Jul 2019 07:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
In-Reply-To: <20190712101556.17833-1-naohiro.aota@wdc.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Jul 2019 23:54:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBunev7O3k06hv22aPh9DuW53CKbuvM1TwscuM_5uOUg@mail.gmail.com>
Message-ID: <CAK7LNARBunev7O3k06hv22aPh9DuW53CKbuvM1TwscuM_5uOUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/vdso: fix flip/flop vdso build bug
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
> Two consecutive "make" on an already compiled kernel tree will show
> different behavior:
>
> $ make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
>   VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
> Kernel: arch/x86/boot/bzImage is ready  (#3)
>   Building modules, stage 2.
>   MODPOST 12 modules
>
> $ make
> make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   VDSO    arch/x86/entry/vdso/vdso64.so.dbg
>   OBJCOPY arch/x86/entry/vdso/vdso64.so
>   VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
>   CC      arch/x86/entry/vdso/vdso-image-64.o
>   VDSO    arch/x86/entry/vdso/vdso32.so.dbg
>   OBJCOPY arch/x86/entry/vdso/vdso32.so
>   VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
>   CC      arch/x86/entry/vdso/vdso-image-32.o
>   AR      arch/x86/entry/vdso/built-in.a
>   AR      arch/x86/entry/built-in.a
>   AR      arch/x86/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
> <snip>
>
> This is causing "LD vmlinux" once every two times even without any
> modifications. This is the same bug fixed in commit 92a4728608a8
> ("x86/boot: Fix if_changed build flip/flop bug"). We cannot use two
> "if_changed" in one target. Fix this build bug by merging two commands into
> one function.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
