Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB88C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67EF21849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8mzWEN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfGQWBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:01:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40807 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfGQWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:01:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so11813117pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTLcLaPhVwoKKpKMc1I9xT0INE94L4TgQfexrydY+cA=;
        b=Z8mzWEN0CeWUNvwKhn1qfilBTBRC7WxTjomnVsKPHQU0ElCU8F0S+0b6hmIm7/nhch
         +DifBmtphlUm+XiggXkiUNvdXglwFDqpqRYwxBJ1aOOituDUlQ5cPcH9WfCGseEHOFw8
         dDQZwj8eABofHwsXh91agobn7fLXtduOSolkjgIHCQv/JlOq7DmttmbAYWr2vOlJHh/X
         phhszvm1zTiHpZUGPBawQGRzDFNXcee7ET2hvB3e81ksWT88LZYlNsbh3x47Hm/XlI/B
         u/OFwzWhaWgaDyCoNr42/zXR8ZJo1XWCYRP7jHIEVOQDhNfXPOTXnrdvEzUwqf+8fBHz
         lHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTLcLaPhVwoKKpKMc1I9xT0INE94L4TgQfexrydY+cA=;
        b=Pg1SFDOhbOEdE7qEpJqZD6yDRW+5DX14cE+f3SYkcKxgMqVmyj1tz623bdq4r5X9zS
         PBB9D8/OnCjbGI20p1r8cmg9WPRzaIsnD2zeu2zSM302fGf5XIJTR/2qeBv3P3Pe1Xgv
         ObNYLNpBSJdVXhg22AYPkNF0+nLzG4VWvEbZaeIzS2A6yFCSLmxPyznQi34ZZA9Clxvc
         MEigtUqqKdxYHRQ1jejjNqo3600ztocVSUHKYxE3hsfS/8WNFrpZB2zn6RO7ULureHLn
         hQhrSXb4FfeOMMMlgJ2JgofmNJy1/HwEBVqJWCZsvo2NKrBkMKfFMtZX3Ock/ukUUH3C
         WmvQ==
X-Gm-Message-State: APjAAAV3DVPBTkl+My4Mnf3hCBWhZhiHm9IFZVO/7Z9ciOtxjKTQ97JW
        kUzANvNb5pZqxiqVFD26L7zrLXAbnOnIAdkc8slXkA==
X-Google-Smtp-Source: APXvYqyNMgmaBD93cLMzjr2ceMGWNdB2nEoU4SUn3C4KPY9rINU9MjXlmnh0tT2J3vMVKPOps1R5xEFcGQ55emc7qr0=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr45895718pje.123.1563400889995;
 Wed, 17 Jul 2019 15:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190717033807.1207-1-cai@lca.pw>
In-Reply-To: <20190717033807.1207-1-cai@lca.pw>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Jul 2019 15:01:18 -0700
Message-ID: <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
To:     Qian Cai <cai@lca.pw>
Cc:     rafael.j.wysocki@intel.com, robert.moore@intel.com,
        erik.schmauss@intel.com, jkim@freebsd.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 8:38 PM Qian Cai <cai@lca.pw> wrote:
>
> Clang generate quite a few of those warnings.
>
> drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer
> treated as a cast from integer to pointer is a GNU extension
> [-Wnull-pointer-arithmetic]
>                 status = acpi_get_handle(ACPI_ROOT_OBJECT,
> obj->string.pointer,
>                                          ^~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:458:56: note: expanded from macro
> 'ACPI_ROOT_OBJECT'
>  #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
> (ACPI_MAX_PTR))
>                                                         ^~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:509:41: note: expanded from macro
> 'ACPI_TO_POINTER'
>  #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
> (acpi_size) (i))
>                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:503:84: note: expanded from macro
> 'ACPI_ADD_PTR'
>  #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
> (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>                                          ^~~~~~~~~~~~~~~~~
> ./include/acpi/actypes.h:501:66: note: expanded from macro
> 'ACPI_CAST_PTR'
>  #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>                                                                   ^
> This is because pointer arithmetic on a pointer not pointing to an array
> is an undefined behavior. Fix it by doing an integer arithmetic
> instead.

Hi Qian, thanks for the patch.  How do I reproduce this issue,
precisely?  I just tried:
$ make CC=clang -j71 drivers/acpi/scan.o
on linux-next today and don't observe the warning.  My clang is ToT
built sometime this week.  It looks like drivers/acpi/scan.o when
CONFIG_ACPI=y, which is set in the defconfig.  Is there another set of
configs to enable to observe the warning?

Also, the fix is curious.  Arithmetic on pointers to different
"objects" (with one element passed the end) may lead to provence
issues due to undefined behavior, but I would have expected some cases
to uintptr_t, then arithmetic on that type, as the solution (which is
what I suspect ACPI_CAST_PTR is doing).

Further, you seem to have modified ACPI_ADD_PTR but not ACPI_SUB_PTR;
I would have expected both to be afflicted together or not at all
based on their existing implementations.

>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  include/acpi/actypes.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index ad6892a24015..25b4a32da177 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
>
>  #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>  #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
> -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
> +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) + (acpi_size)(b))
>  #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>
>  /* Pointer/Integer type conversions */
>
> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
> +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0, (acpi_size) (i))

IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 == X ?
-- 
Thanks,
~Nick Desaulniers
