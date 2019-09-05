Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3BC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A09B22CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFscreOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfIEATF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:19:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41497 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIEATE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:19:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so338047pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvl67MVvuI7hrqwUxQ6/9R19L/ScUzDtg4FInDuKyNs=;
        b=RFscreOg08IfubTlLj2YYhjd0OvNG3zaaPaFHTZbdCE9qdNznzVZhaZ2UKIvwlvkjr
         3wVdpNot1KLmfS5xwyOtVNZwTO42xUVmrhtIi5I+eTVXcJOzQUm7FwuSETQypmJPjTlF
         bGFoZxRct4EUSawtVplUB9tyGqQ4TBIszPJDwUMWTw8mP3UPkXUagFieaKDRAyl60Zht
         bDD6K4I/k21yxuQK3G85JyC1IEFHUrOpL7+N9AM11LFk7NaE5F/GcWG1PJ77pP5mtUWF
         aCckbTvvevKqzwE4iWinj1k432oGbcxdo0ICucsmQh5sm5FFkyR2qY/NC1BawKPm3YnD
         9WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvl67MVvuI7hrqwUxQ6/9R19L/ScUzDtg4FInDuKyNs=;
        b=Kzt2Z5Jyqdn1z7Nh5XPoRzZSsSBajEnRA446Ajjr2ioPmMRij1TgMgxzabWyTh+zjh
         I/jrGv45Ha0ln9RsnERP+u68y/dh4QPZBPwLbFmcT2pTybNBGqAkrw3eGTG2IFyuxhB7
         xHN0eEcn1bZjayiVst49mFHeh8Tut88CbGf+HmIxBNnBfSx7CLEulAe/vXJ+eLC93vGk
         R2NGwNRgE0iH3ACUdfC2Qocg9JVDHP7rttomj1937bsF7BYqVV53Vzb50itvv1HsnyG7
         ZAUF9WgfrEPqySL7E9BWXPgIGIU24/c7437asLB+q3ik/SstMU/n/FwHLMn7SI53R4EF
         dr7Q==
X-Gm-Message-State: APjAAAW3qN+XX+DCZXzfwAlyQ3EjRzRIfRRWp/emMvMi+FLMXRpQmKIW
        NEUbe15/Qo/lASPo/cd1JbgLZlhw0MD3VEgMok7HlA==
X-Google-Smtp-Source: APXvYqzEOCkCAIB1YFUArWFiPwMn0AJJ8uD2OG1xz/LXXXe9XB6CELnv3wFQJEXjQepqihUzvqJYtvdGAdPstYJqHh4=
X-Received: by 2002:aa7:8085:: with SMTP id v5mr439950pff.165.1567642743648;
 Wed, 04 Sep 2019 17:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
In-Reply-To: <20190830231527.22304-5-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 17:18:52 -0700
Message-ID: <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> This adds an asm_inline macro which expands to "asm inline" [1] when gcc
> is new enough (>= 9.1), and just asm for older gccs and other
> compilers.
>
> Using asm inline("foo") instead of asm("foo") overrules gcc's
> heuristic estimate of the size of the code represented by the asm()
> statement, and makes gcc use the minimum possible size instead. That
> can in turn affect gcc's inlining decisions.
>
> I wasn't sure whether to make this a function-like macro or not - this
> way, it can be combined with volatile as
>
>   asm_inline volatile()
>
> but perhaps we'd prefer to spell that
>
>   asm_inline_volatile()
>
> anyway.
>
> [1] Technically, asm __inline, since both inline and __inline__
> are macros that attach various attributes, making gcc barf if one
> literally does "asm inline()". However, the third spelling __inline is
> available for referring to the bare keyword.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/compiler-gcc.h   | 4 ++++
>  include/linux/compiler_types.h | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index d7ee4c6bad48..544b87b41b58 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -172,3 +172,7 @@
>  #endif
>
>  #define __no_fgcse __attribute__((optimize("-fno-gcse")))
> +
> +#if GCC_VERSION >= 90100

Is it too late to ask for a feature test macro? Maybe one already
exists?  I was not able to find documentation or a bug on `asm
inline`.  I'm quite curious how you even found or heard of this
feature.  To the source we must go...

> +#define asm_inline asm __inline
> +#endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index ee49be6d6088..ba8d81b716c7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -198,6 +198,10 @@ struct ftrace_likely_data {
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
>
> +#ifndef asm_inline
> +#define asm_inline asm
> +#endif
> +
>  #ifndef __no_fgcse
>  # define __no_fgcse
>  #endif
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
