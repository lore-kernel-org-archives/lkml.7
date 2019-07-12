Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43CC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7935F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1i0PeyXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGLGZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:25:02 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38648 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfGLGZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:25:02 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6C6OcOi010876
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 15:24:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6C6OcOi010876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562912679;
        bh=beC6PlncI7VLFBQDho8ZRldcBbmcJMqjPnUh0ZyMQ1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1i0PeyXqnMbPUzkpzDnoUiwHVGyxLNFu+b3zOrSGYG/KRJQut/VaYFtoaF71Xrfrv
         1eyk31dFfOzIKyDfxh8xdB+af9I7ziI0k/Y+6FWVw+gZKNXm7m9wlQS9dAG/J8TMGy
         aKRDKtnBxoU/7Gjymez1744fS1sNQua7X8E7uKn+kd302PJHseDUpjv34zKanmPIJe
         HH4LOfHI9DGQYHAO7iFGq7goUqr0pl9AjjI5bLXV+NjGjYH9dixbgOiaHXUURZb4b1
         BolDm4DpMQJKwsIac6oHcs1+HPVfV5+YaUuMdmc6m2W7QrqKvYYlaRZYdQfn4j5iX4
         QXiWUTFfO3l5A==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id g11so3586369uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 23:24:38 -0700 (PDT)
X-Gm-Message-State: APjAAAX35i9qyr2nYWgOA2qzMaXQakhlFVAb408DK7/GxkDKg1uUH5N6
        vUIKaCaJ+yRDExQB/hX+2rrx5IBoCl07MqVgq1Q=
X-Google-Smtp-Source: APXvYqyG77NKkLEfjvk9tccV2S/mfm1w2Mnljrte9YX2RfJ87jgQC2i+nOjMV60Xi4I63bXGGCUOYU39jbWOVCnKa9U=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr7820294uag.40.1562912677515;
 Thu, 11 Jul 2019 23:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190712054350.12300-1-naohiro.aota@wdc.com>
In-Reply-To: <20190712054350.12300-1-naohiro.aota@wdc.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Jul 2019 15:24:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFRqRMbJb3d4JoMyCdHDQWxmx05wJ2yBXyukcj05Au-g@mail.gmail.com>
Message-ID: <CAK7LNATFRqRMbJb3d4JoMyCdHDQWxmx05wJ2yBXyukcj05Au-g@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso, arm64/vdso: fix flip/flop vdso build bug
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

On Fri, Jul 12, 2019 at 2:46 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
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
> ("x86/boot: Fix if_changed build flip/flop bug").  We cannot use two
> "if_changed" in one target. Fix this build bug by merging two commands
> into one function.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>


The code looks OK, but you should split this
into two patches, for arm64 and x86,
and then add Fixes: for each of them.



-- 
Best Regards
Masahiro Yamada
