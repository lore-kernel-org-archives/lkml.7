Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D886C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4012075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dh5XugVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfD2RfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:35:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45326 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfD2RfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:35:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2032102pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kM8XyTuKXCw/0VhDx0EpsJTgk6kLql0lEsb7+DZlns=;
        b=dh5XugVNe0puvkDeCqwzeG18FWp/5XbFOyuGLNw7+8E5AlJh2gujXqo27m2hlqbeMN
         aoQ3qFCgsNieB+uvlBChFOzwnZVpe+8lrSo4Rduy65FMiHqKULm+FBSzYeKhlkKHJhiV
         8EXCznDKlX8MdjQ5/ajab1o0SyffoXlFNQufQrze+Odf7mAiydHdYBAl1/+IrrdtGqJJ
         hTHe3RmvTYudiA30jwC+5MzvoQNXpoPu9ws7whaO1jpD+fa59TdaZLw8DbQwkUFUEgDM
         3nj1Ci0MnWIZ40WUwPsdanhHbGxSEOzZbJ34vFkEp4+aRu44pwQUvzc5+EoN08dtXvIS
         YOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kM8XyTuKXCw/0VhDx0EpsJTgk6kLql0lEsb7+DZlns=;
        b=rm74PfASD/fk9AQ6voy4GHD4F/DELEjKBk4RYnp3etUarAqSMMHEfY8r+g5IyCu5hr
         zi4NKdchKP8qrVd87pQfj2EcgiYZjPFICPpiYmIDCkt0Gy3I0544m/6qTL7+BIcu32rF
         3sdq8703aDOljFk+e3Bzv0pH7uRbVm8oIuh5lIPM749HwXMQf7KnBZftWDqO5PCfznyX
         ohYp3cRGtoEwfVo3B74X9KOYd3SXVUw/g+Mcs/iMy/i5CJ7CJSty/sDiW9wGHkonfY/H
         3Lu2zCZxmNQciLMSmpMcXTuURm6F0eJlcNFQBQ14IwQNvYvFn1SrmwfK+SZ183TkynQi
         FRCQ==
X-Gm-Message-State: APjAAAUxA90H8UYuibzE2OH+q8hwSZ9Zq3uf4jmXwFHMTKxAGsFMAUgN
        YL2++tOOadpSCopWDpf28bTRo2m+Weu46oQCZcA/bw==
X-Google-Smtp-Source: APXvYqyF4Z7BwUGF0kVmWLTqE2/dQ7UhZFi3PwcdVX7M6ya+BIelyPKfjymosKZyj06QgDVvgqPAS6PdbSbMbNTt5n0=
X-Received: by 2002:a63:c702:: with SMTP id n2mr21522880pgg.255.1556559304964;
 Mon, 29 Apr 2019 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190426130015.GA12483@archlinux-i9> <20190426190603.5982-1-linux@rasmusvillemoes.dk>
 <20190426190603.5982-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20190426190603.5982-2-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Apr 2019 10:34:53 -0700
Message-ID: <CAKwvOdm95LvKXFw3fartoAh0JFMJsHi5Nm1n9400L8gKgk4-Yw@mail.gmail.com>
Subject: Re: [PATCH 12/10] powerpc: unbreak DYNAMIC_DEBUG=y build with clang
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:06 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Current versions of clang does not like the %c modifier in inline
> assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
> fails on ppc64. A fix is likely to land in 9.0 (see
> https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
> build for older versions.
>
> Fixes: powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks for fixing the build.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Andrew, please apply and/or fold into 10/10.
>
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6821c8ae1d62..8511137ab963 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -155,7 +155,7 @@ config PPC
>         select BUILDTIME_EXTABLE_SORT
>         select CLONE_BACKWARDS
>         select DCACHE_WORD_ACCESS               if PPC64 && CPU_LITTLE_ENDIAN
> -       select DYNAMIC_DEBUG_RELATIVE_POINTERS  if PPC64
> +       select DYNAMIC_DEBUG_RELATIVE_POINTERS  if PPC64 && (CC_IS_GCC || CLANG_VERSION >= 90000)
>         select DYNAMIC_FTRACE                   if FUNCTION_TRACER
>         select EDAC_ATOMIC_SCRUB
>         select EDAC_SUPPORT
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
