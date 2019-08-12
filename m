Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B8A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SokAhW9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLRuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:50:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41865 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLRuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:50:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so9150455ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh/TAVkIHkjw7wbFiAXoulegggwXhgu3dpeEPlXbbTY=;
        b=SokAhW9TXd9Q5100mLJ6XjNOP42lNy06oZpwonmrYqth7B51usfE3DgJjtV8ZY0cvc
         aehw1AaVCMJyLNBMH92d9Zda3ebSSw3XmaCgkT2ir37hzJhtYmZSUL6J2bWn+g0IArrA
         fCjDf5b9dEzfmCZGzWEoMVyNYGTFX2iWtF7RYuU172zjKe2CG3Rmd0LC90VZD+95+kwc
         QGaNY1ioc5eO74g4wWXNtisPo1Gi5W8EGNnopYM87uBruicBBDHKGZ2FyjRMZAOgEu5P
         K/5VjsIp121YfUfoMr4lXZzRbEvUsHGCagQQEXeK+3kAxH6RyP1ZVc9UrGCMgTYYKpJj
         M0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh/TAVkIHkjw7wbFiAXoulegggwXhgu3dpeEPlXbbTY=;
        b=pxsrMPVHFZLLpzdpKojkMYf/vzuHhsEtFGsJ7J0duPBvf6gYJRzMhwaS+Hl5jDJvqS
         hC84i00GJsrBakSXTN5ZXf72usUWDx27vwVIrV4c9O4lkHOOIoptxzSbq5YRnlJHUrs5
         4Sxi+ZbgTyAxHV8ccxbADu+uHC5YkCBWCArI5LDRcS1G3hD7iggND0SRDisoGCoAUxjG
         R5S4qhtyI5uKam3EFai8Ugi2LgFuK3/C7x+owJKHfICz5tEanf3Ioh6kcR3i/qpFFcZd
         ymAkvnZhYQCn7PefYNlAxs1vuqTJVfzlO/drPz7JB9+i1BDxYWMOuLV6z6+w3ABvG7xO
         0+GQ==
X-Gm-Message-State: APjAAAVB8KlivOJLZsWuJzIUbaTmSor+O1qMSYpwJ0E567LEtltw0rEY
        FcjYLviI2X/kzXoTR9qpDA5YbMQYwLIw9jfn/E5N9VOpxHfjXA==
X-Google-Smtp-Source: APXvYqzReVmTJaevXF+CS2yxduFJc6vhYut6UbJQPwN7A4Oplun6ql0Zcg/gZalAgHyARd+q4BHOg44/vfZytLZWHos=
X-Received: by 2002:a63:f94c:: with SMTP id q12mr30756736pgk.10.1565631762244;
 Mon, 12 Aug 2019 10:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190812033120.43013-1-natechancellor@gmail.com> <20190812033120.43013-5-natechancellor@gmail.com>
In-Reply-To: <20190812033120.43013-5-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 10:42:31 -0700
Message-ID: <CAKwvOd=BYmsExYeOQmuEJ-Yybgqd_22vQ_WwU0jEXTXAaKpQVw@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib/mpi: Fix for building for MIPS64 with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Werner Koch <wk@gnupg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 8:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> From: Werner Koch <wk@gnupg.org>
>
> * mpi/longlong.h [MIPS64][__clang__]: Use the C version like we
> already do for 32 bit MIPS
>
> clang errors:
>
> lib/mpi/generic_mpih-mul1.c:37:24: error: invalid use of a cast in a
> inline asm context requiring an l-value: remove the cast or build with
> -fheinous-gnu-extensions

Reminds me of:
https://github.com/ClangBuiltLinux/linux/commit/7b7c1df2883dd4393592859758c3e76207da8b1d

>                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/mpi/longlong.h:652:20: note: expanded from macro 'umul_ppmm'
>         : "=l" ((USItype)(w0)), \
>                 ~~~~~~~~~~^~~
> lib/mpi/generic_mpih-mul1.c:37:3: error: invalid output constraint '=h'
> in asm
>                 umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                 ^
> lib/mpi/longlong.h:653:7: note: expanded from macro 'umul_ppmm'
>              "=h" ((USItype)(w1)) \
>              ^
> 2 errors generated.
>
> Fixes: 5ce3e312ec5c ("crypto: GnuPG based MPI lib - header files (part 2)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/605
> Link: https://github.com/gpg/libgcrypt/commit/e7ae0ae243c8978a67c802169183187d88557be8
> Signed-off-by: Werner Koch <wk@gnupg.org>
> [nc: Added build error and tags to commit message
>      Modified subject line
>      Removed GnuPG-bug-id
>      Removed space between defined and (__clang__)]
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  lib/mpi/longlong.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
> index 8a1507fc94dd..5636e6a09f7a 100644
> --- a/lib/mpi/longlong.h
> +++ b/lib/mpi/longlong.h
> @@ -688,7 +688,8 @@ do {                                                                        \
>                  : "d" ((UDItype)(u)),                                  \
>                    "d" ((UDItype)(v)));                                 \
>  } while (0)
> -#elif (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
> +#elif defined(__clang__) || (__GNUC__ >= 5) || (__GNUC__ == 4 && \
> +                                               __GNUC_MINOR__ >= 4)

So the minimum supported version of GCC to build the kernel is
currently 4.6, so we can clean up a lot more here.  I'd remove the
check, and delete the #elif and #else implementations.

>  #define umul_ppmm(w1, w0, u, v) \
>  do {                                                                   \
>         typedef unsigned int __ll_UTItype __attribute__((mode(TI)));    \
> --
> 2.23.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
