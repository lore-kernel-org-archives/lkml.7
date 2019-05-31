Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1041C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8705F26555
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEaIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:05:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33071 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaIFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:05:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so10372413qtf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsWPoelIonqgtQjEjEZhAHR4HHsLSmBSBxOwcnV/0ek=;
        b=QS+YTDED4M9owOqk+LUPrm5h4rAvT0GPEKEE9M2BeZJu9aKRbl6ZEeGx0Td1LrC1yS
         HSWAwOWru83CA+WoUw/1nc7SFKUZUy/mM9/EZWIp7bxPHau4UVaVTbLTTi3nwyeAL0Zo
         xXKWD1WZyegMA2OdfQL5K1HNeOrdw2vjwcMZeGGz+VyCMDSNRlhlauDcZ+ta5A6f4ZPb
         uQMMb+8u+fBExMkaia+jXXOrrX13l8Q2mIpk80rNTnA2t6PDNZga1T7i8kknwOO7d5ai
         HRAcqEhixuD3m/lHUVUZ5ZHw+qnaqsYN0CYEkAd0h8e+QU4WVoytdTmu6coJWA609kic
         CXLQ==
X-Gm-Message-State: APjAAAXQ8VULpzZyIVzrDw6wAvSOGT0qGQatgDYjQrbqANR+8hdikECl
        Db6XHD3KbeKmP3MaVCFyk3rdhsoZFyGvNyjjAVg=
X-Google-Smtp-Source: APXvYqxpUebMd4P6HeLcNgjp63Kigfm6+Toh9gpYgK7tKsqGakdyNSwEH4MHbH8rOHyEAgWuOxDPZhRFFQ2E/WINNSM=
X-Received: by 2002:a0c:e78b:: with SMTP id x11mr3752479qvn.93.1559289938144;
 Fri, 31 May 2019 01:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235742.105510-1-natechancellor@gmail.com>
In-Reply-To: <20190528235742.105510-1-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:05:22 +0200
Message-ID: <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:57 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, when compiling this code with clang, the following warning is
> emitted:
>
>     CC      arch/arm/lib/xor-neon.o
>   arch/arm/lib/xor-neon.c:33:2: warning: This code requires at least
>   version 4.6 of GCC [-W#warnings]
>
> This is because clang poses as GCC 4.2.1 with its __GNUC__ conditionals
> for glibc compatibility[1]:
>
> $ echo | clang -dM -E -x c /dev/null | grep GNUC | awk '{print $2" "$3}'
> __GNUC_MINOR__ 2
> __GNUC_PATCHLEVEL__ 1
> __GNUC_STDC_INLINE__ 1
> __GNUC__ 4
>
> As pointed out by Ard Biesheuvel and Arnd Bergmann in an earlier
> thread[2], the oldest version of GCC that is currently supported is gcc
> 4.6 after commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6") so we do not need to check for anything older anymore.
>
> However, just removing the version check is not enough to silence clang
> because it does not recognize '#pragma GCC optimize':
>
>   arch/arm/lib/xor-neon.c:25:13: warning: unknown pragma ignored
>   [-Wunknown-pragmas]
>   #pragma GCC optimize "tree-vectorize"
>
> Looking into it further, -ftree-vectorize (which '#pragma GCC optimize
> "tree-vectorize"' enables) is an alias in clang for -fvectorize[3],
> which according to the documentation is on by default[4] (at least at
> -O2 or -Os).
>
> Just add the pragma when compiling with GCC so that clang does not
> unnecessarily warn.

If I remember correctly, we also had the same issue with older versions
of clang, possibly even newer ones. Shouldn't we check for a minimum
compiler version when building with clang to ensure that the code is
really vectorized?

       Arnd
