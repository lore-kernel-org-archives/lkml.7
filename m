Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3AFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EEE2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NS3pQoXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfH2Rzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:55:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfH2Rzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:55:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so2565012pfz.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTiBhHkHMJRRmQp07hUV0eTzQBNN9VPe28f+dHC32dM=;
        b=NS3pQoXOlk00UmrmHrPEqnCHWkBOdmybZhoBYlRrrTrQU4XeHRJlHepqqzCHaudweq
         nozNVhD6dU3HvOMUJoSosGKcZo6Wml/oo8lo9ByhvBDc9FIAZvk+KRHuZ1v9VevA9gLk
         td8G6R4rcfnAMfcTDBIonCHxcHaG5Vb3j4Emd0gBswHlS687CitNrP2YSbdbSgYfBIxt
         2DQY8vQG8buTm7B9zF8YNNBk4101xhrLsWIaZYvYPWwpNqmfPN8qFw0wV9R/FG12jye6
         JzcEXtr3XUPcJxQSIG5ggs3ue0i0/ZPXIsurvTwkPoc92xzUuSmx4H0wzpdohrk1GZOq
         If6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTiBhHkHMJRRmQp07hUV0eTzQBNN9VPe28f+dHC32dM=;
        b=I43NA0/wnRQpJrb0AeCcQiivCOgcPAhjDcyXG9ejqIlBhsju15gVJrprKq1lje9dvq
         2Rx3JlbdgAkKYOuyem+g2GYM75XWT6hw7oytAYIbVppHLfS0jtwkEA/1o2kEHYfv219M
         cG+XOXL5kCYFuDuJQmg9w+5LdpprVCQTGQXgYYGq1DertXNVvEqkAb7cwVhWk7ZTzSZ1
         R9tmVmjD5Vl5imfxl6VQLVKEzUtUkzSVGaFDR7DSpOUdHey944Q0lodLuDJB+Y+pTnZx
         B4fHEeAywH8fUNmIKOMspOAmeiZIiWr8EDTOJlgbajVnilttQSReqc70lACd3ehOXksF
         PW3Q==
X-Gm-Message-State: APjAAAUQKukITjn9M9WNMgiCcZDvWo04AHRTK3ozVgxEH+RaqcFV7naN
        Sz3IEnj+ZTz/nbfCv99405swVuAgOjn2C43DKIfETQ==
X-Google-Smtp-Source: APXvYqwmiSojdNKlubI2KCVcr3kC3Pv2OqAeJD8KlOzXov8+oindrhkau4GKVBYmSkoU6p6dVPaOPeMV5OZOmuzhjtg=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr12922205pfg.84.1567101339951;
 Thu, 29 Aug 2019 10:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190829062635.45609-1-natechancellor@gmail.com>
In-Reply-To: <20190829062635.45609-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Aug 2019 10:55:28 -0700
Message-ID: <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> with clang:
>
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> softirq.c:(.text+0x504): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> softirq.c:(.text+0x58c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> softirq.c:(.text+0x6c8): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> softirq.c:(.text+0x75c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> softirq.c:(.text+0x840): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
>
> clang can emit a working mcount symbol, __gnu_mcount_nc, when
> '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> broken and caused the kernel not to boot because the calling
> convention was not correct. Now that it is fixed, add this to
> the command line when clang is 10.0.0 or newer so everything
> works properly.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/35
> Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c3624ca6c0bc..7b5a26a866fc 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> +ifeq ($(CONFIG_CC_IS_CLANG),y)
> +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
> +CFLAGS_ABI     +=-meabi gnu
> +endif
> +endif
> +

Thanks for the patch!  I think this is one of the final issues w/ 32b
ARM configs when building w/ Clang.

I'm not super enthused about the version check.  The flag is indeed
not recognized by GCC, but I think it would actually be more concise
with $(cc-option) and no compiler or version check.

Further, I think that the working __gnu_mcount_nc in Clang would
better be represented as marking the arch/arm/KConfig option for
CONFIG_FUNCTION_TRACER for dependent on a version of Clang greater
than or equal to Clang 10, not conditionally adding this flag. (We
should always add the flag when supported, IMO.  __gnu_mcount_nc's
calling convention being broken is orthogonal to the choice of
__gnu_mcount_nc vs mcount, and it's the former's that should be
checked, not the latter as in this patch.

>  # Accept old syntax despite ".syntax unified"
>  AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
