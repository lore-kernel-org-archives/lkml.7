Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA8C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMcUEcj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbfGHUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:55:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfGHUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:55:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so3383383pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OQ0dQx7P10nSrLNC9w6ppz8v3IMRgqStNxoHDjwyqA=;
        b=VMcUEcj4pk2MTnNnVuyLOMBRvzg2v5kk2KKdmhndoED33Vc632wPL8Mvr5jZ2XwHGd
         UipZOvArKV2c3zFGzSTFh5PHr6XoXqxEraFY6ajTlvxsNsfXCt/sEvwYa4KcWlkh3HJe
         9DKynEcT71i5PXe+upcQp/QJ3YzlKNKsw5emG4c9QzmhgqXFFm0ophmf5hTZPJbuSI85
         KCSg7MIdU0hupAEXYVIQAfiBEhUrFCurgWixBiAKTWKeiFVJhmbLNga9ncCqDxf9A9pL
         BkfZIj80+kqNs51pGr8MDRZupR0eBdH9fxV9kgHAZhM8633TaN+phGYhuUWc7ydjgSJv
         m71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OQ0dQx7P10nSrLNC9w6ppz8v3IMRgqStNxoHDjwyqA=;
        b=Rt4ZWoah5MVIpU+R0fePSEcBvCtI67/8fD9bSAJvsTOcZzFpLv9TkqM26GW5ZCjSRQ
         RmMkSYceWasne/Rz6eifWH9qkjJMn2UZBoNnq5mmvqtWexmgqJEA60HXyMIYmgZ/ewx9
         AfaNTkNEbAkhkGrmS3rjlD61Rd7+2RS1EhRE+lpNepJHVQ1Txm14opxySvX99IEBr8A+
         pnFGXb/zxkM7o+HbKR+TBNn1XGZevJMCTCrQrSkSUcgO0Zqqyvr12LU2TVBMYv+BBzYP
         dao9+X7v6wK93m489CTo0vyvXK3VDUTslYgbpdHuZUc9glQDEhQwmbkvWFT5nDXxAI6w
         Q5rg==
X-Gm-Message-State: APjAAAWpC+Q9KRe1HWMr7nZXvRcUMXX5TBeFcJjyVJ4Z1gLjYtbSzs8z
        ib0GwpPw9fYmgao3HLFFg/D3qW5jQ/Pog77QecAXQQ==
X-Google-Smtp-Source: APXvYqwRPQwqOD6HYN8d9zvMYPi3wk2exR2+51Vt7ZmZTQZFupoguZAXmfakZ/cihZb38g4RudH37csZNQQWLXbjoK8=
X-Received: by 2002:a65:5687:: with SMTP id v7mr26574802pgs.263.1562619304436;
 Mon, 08 Jul 2019 13:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de>
In-Reply-To: <20190708203049.3484750-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Jul 2019 13:54:53 -0700
Message-ID: <CAKwvOdnt5Gb8YSZ848s1RsMSJV37iJJWCxu84kFnV0yv35VKAg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 1:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> llvm gets confused by inline asm with .rep directives, which
> can lead to miscalculating the number of instructions inside it,
> and in turn lead to an overflow for relative address calculation:
>
> /tmp/cfi_cmdset_0002-539a47.s: Assembler messages:
> /tmp/cfi_cmdset_0002-539a47.s:11288: Error: bad immediate value for offset (4100)
> /tmp/cfi_cmdset_0002-539a47.s:11289: Error: bad immediate value for offset (4100)
>
> This might be fixed in future clang versions, but is not hard
> to work around by just replacing the .rep with a series of
> eight unrolled nop instructions.

Seems like this is fixable on the Clang side as well. For now, thanks
for the patch.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42539
> https://godbolt.org/z/DSM2Jy

^ prefix with Link: on both lines?
also, linking to clang trunk will become stale once the issue is
fixed.  When possible, link to a release version of clang that's not
prone to change over time.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/mtd-xip.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/mtd-xip.h b/arch/arm/include/asm/mtd-xip.h
> index dfcef0152e3d..5ad0325604e4 100644
> --- a/arch/arm/include/asm/mtd-xip.h
> +++ b/arch/arm/include/asm/mtd-xip.h
> @@ -15,6 +15,8 @@
>  #include <mach/mtd-xip.h>
>
>  /* fill instruction prefetch */
> -#define xip_iprefetch()        do { asm volatile (".rep 8; nop; .endr"); } while (0)
> +#define xip_iprefetch()        do {                                            \
> +        asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");      \
> +} while (0)                                                            \
-- 
Thanks,
~Nick Desaulniers
