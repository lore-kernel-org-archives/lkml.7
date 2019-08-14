Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD2FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F5216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0DnvGoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfHNUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:47:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfHNUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:47:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so116034plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnJUpTOtemwk5nBGxuXtKYKIGvqrFiWTsA3kFNPOc2U=;
        b=P0DnvGoSrwfK7tVGPup1a5QgMqgGVOt4UFe/u0p4K9g7TrpXKxi9m6Swq7g9g9vvjF
         2y3UX12z3KOcwtga/K5WtTsRxa37WTRgu87XC5b+XfFI2QxdLpDRHayK9ceLwZ/kv0YW
         A+NznsUcBkM4ETkmjzF1dJj3H7/POGWxzBOANsjCJGnxD1EW8OVxCx90fn2Jfn0vx6Xg
         9LSx9h+lH4CLtsJL9jgZTHp2rHycRVUdmSiOFybzoVpEbOpB88wRj75IFfKU7Clo59XS
         ptaOFWqGwmCErkwBtZVcNowatCYII7mle0/2SmXPIZcmp24sKnvPJrXdfby9Mt7+bKUl
         DDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnJUpTOtemwk5nBGxuXtKYKIGvqrFiWTsA3kFNPOc2U=;
        b=HODdMm6U0OkqQJSn87QvPA8xz2OdyujfSAKVKLDMzT7maEMvtRt3jYDnIQHYIDausB
         zPICbu7UDkIhDsYRfB5E4umpM9mdD1lWTVeIH0Vt8ME+KlJ4IpcpjFPeI85ZWZVoAu/M
         0JzTFhnHwF8Ls2BMvYNnwFf3J93vI6MVbXPW7WYb5Mx4Wah7L8Uz/J4iaJnlcTugm1bR
         AYCT80xeysGGWpE9UYivKAf2+sR0+GYq/vrpS6Syzor67mWcd3exFkySUkkWCytWXrrT
         wC18vhRQpf6cFlSlO5dNenVJK+i3NYTSfRI5o8dRBY+E6K3TZWYYsWZi1sOHsRi/e21h
         Tkwg==
X-Gm-Message-State: APjAAAXIe0wa+mJ4TDd82I/AafxwJB1thLq+Pc2GpbzJYHs6VtPWMe4t
        14SDWU9k50MPXJDYIG2r0+y777ku9JFs5mqVQse9JA==
X-Google-Smtp-Source: APXvYqwFwL73FewY+t6WDHifLlHyJxqFoVB+Q/M8GXQlj0cCdI9a3zg5ZvS4Xu5Wpk+usZGn7RB7Q3TyzCyeQrr2U3U=
X-Received: by 2002:a17:902:3363:: with SMTP id a90mr1108882plc.119.1565815647717;
 Wed, 14 Aug 2019 13:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190813050731.57131-1-matthew@mjdsystems.ca>
In-Reply-To: <20190813050731.57131-1-matthew@mjdsystems.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Aug 2019 13:47:16 -0700
Message-ID: <CAKwvOdkVToVYnpWbvK65izUFG7KVX7J+h4NhsseHsiVU3Dpz9Q@mail.gmail.com>
Subject: Re: [PATCH] tools build: Fix clang detection with clang >= 8.0
To:     Matthew Dawson <matthew@mjdsystems.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:07 PM Matthew Dawson <matthew@mjdsystems.ca> wrote:
>
> The 8.0 release of clang/llvm moved the VirtualFileSystem.h header
> to from clang to llvm.  This change causes a compile error, causing
> perf to not detect clang/llvm.
>
> Fix by including the right header for the different versions of llvm,
> using the older header for llvm < 8, and the new header for llvm >= 8.
>
> Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>

Specifically the header was moved in svn revision r344140.
llvmorg-8.0.0 was tagged off of r356365, while llvmorg-7.0.0 is tagged
off of r342383.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/build/feature/test-clang.cpp | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
> index a2b3f092d2f0..313ef1568880 100644
> --- a/tools/build/feature/test-clang.cpp
> +++ b/tools/build/feature/test-clang.cpp
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "clang/Basic/VirtualFileSystem.h"
>  #include "clang/Driver/Driver.h"
>  #include "clang/Frontend/TextDiagnosticPrinter.h"
>  #include "llvm/ADT/IntrusiveRefCntPtr.h"
>  #include "llvm/Support/ManagedStatic.h"
>  #include "llvm/Support/raw_ostream.h"
> +#if LLVM_VERSION_MAJOR >= 8
> +#include "llvm/Support/VirtualFileSystem.h"
> +#else
> +#include "clang/Basic/VirtualFileSystem.h"
> +#endif

-- 
Thanks,
~Nick Desaulniers
