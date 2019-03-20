Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24F82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fhmK4rN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCTNzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:55:51 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50353 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:55:51 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2KDtgAS020630
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 22:55:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2KDtgAS020630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553090143;
        bh=hiiGyh7YSFui/vJJXdCRF4SiqT/SlOJQDxwe8vaqJyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fhmK4rN4zlHQmTZERE7VFrmW+dQfjiCgVCjGfPPTBtmyceN7deqR0YEuQQ04iexcS
         rXUhCUla45YYE2Y8i1PRtzk3MP0bL1tXamBWji6hyoH2JO2IpD39Wr/bKzA/tvNZiE
         DjUWuE8IQBrT7jDKapX0aHaAe8W6/0kDZfJGc41prqchL1eeUVlrdX8CKNtGI/l0d4
         /MiMughaMmm3V/2l+pSgWzr0SR2eh1hb+E2ltLaO47X5s+tUF+2jiW0xxyYJ8v7ucu
         51qqAsoHC2mixGk2P/EoPJGtKNL+cJ3re+oWRqZpfCv5EnQeMBTJX+DqXAjI6J+to2
         0LVX1vVo1E9PQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id w13so1526185vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:55:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXceKdAl011NoN81mgK0QkZcTLIoksFq89yJjgAF9Bpby3k3Mxa
        80Ld37bhwSlC6z15zw28/STFZGnu5meIx+ax1xc=
X-Google-Smtp-Source: APXvYqzCph8ErPSuaG/0pGj1kaBQrITvbuYIbvaFsjbDFfZ15oWd4Hgf3K/zLOGQwVDabnyD45jDUa0kEMpAy//NiHM=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr4891528vso.179.1553090142407;
 Wed, 20 Mar 2019 06:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
In-Reply-To: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Mar 2019 22:55:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASv1BybFUDZ0KippC216i4k51iX42DL-HCHHxZWM2oz+A@mail.gmail.com>
Message-ID: <CAK7LNASv1BybFUDZ0KippC216i4k51iX42DL-HCHHxZWM2oz+A@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 4:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Building the 32-bit vDSO with a recent clang version fails due
> to undefined symbols:
>
> arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
>
> The undefined symbol in this case is __lshrdi3, which is part of
> the compiler runtime library, however the vDSO isn't linked against
> this library.
>
> Include the kernel version of __lshrdi3 in the 32-bit vDSO build.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
> index 99cfa5721f2d..8a4fc6bcf3a4 100644
> --- a/lib/lshrdi3.c
> +++ b/lib/lshrdi3.c
> @@ -16,7 +16,7 @@
>   * to the Free Software Foundation, Inc.
>   */
>
> -#include <linux/module.h>
> +#include <linux/export.h>
>  #include <linux/libgcc.h>
>
>  long long notrace __lshrdi3(long long u, word_type b)
> @@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u, word_type b)
>
>         return w.ll;
>  }
> +#ifndef BUILD_VDSO
>  EXPORT_SYMBOL(__lshrdi3);
> +#endif


I picked up
https://patchwork.kernel.org/patch/10858565/



I do not know if this patch is still needed.

FYI, just a tip to turn EXPORT_SYMBOL into no-op cleanly.

You can use __DISABLE_EXPORTS
as drivers/firmware/efi/libstub/Makefile does.

See commit f922c4abdf76.


-- 
Best Regards
Masahiro Yamada
