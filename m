Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB28C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6023429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhfqOxHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfH3Uyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:54:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34865 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3Uyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:54:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so4125501pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CVy2kCQ2mXWtQaNrZE0v2BXiv9fAYysPjc4OIAAcWY=;
        b=UhfqOxHMV3jQk1xxzvo2MP0OgXffqTvi1/n6Lctg168ayE83maKFExtHkHGK5bBAKc
         LQTKGr2hoMIQ4cc8ZfPZcHcoE0UBuAb5SNAATRwBIti1kBdiFoPvPOAXIYXeWDgPBmyx
         /fEZ9QGU+wM/ykDw3mJia1XcQ1Yu9GMgqPbXYqMGRQqri7Tf+Iiuj0G3HeZSJrUwAPlv
         1Fq24WLpFuL9jRHVzJk4g/NjLBaGISkhLfL9AIsxY5Wdm/RixZu+A4UaS1vO6RYNMkLj
         0cqI2pHgwClwRGjxOhwG97tpuYn44UtfsVkC63Dg0dpURoxZ4WUQ457JQq6CTLsnUVpj
         AQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CVy2kCQ2mXWtQaNrZE0v2BXiv9fAYysPjc4OIAAcWY=;
        b=XTEwQz3401xqte2iOTI8C/QCR/Z1a6s0WYWCvDIx6EGRLhHEyo6fV4xKAoNlOON1EH
         N2HdR68a0jHQfSDG91aXPRHrvNKteRBUbJgTIQ+BiORTIO+IZY9jOJ1HBc0spYt1evym
         NMq8WA7zHwtV+szICRPKIE84fRcCvonzBdna612iJ6Xw1zRRpGaZbOP33kfwpfhuPLxy
         /2LtGNGfYma85B7omvRuPgpGKh9oBDtqPumY3xnAJiQOX8A4AfaQP//cHmcvjZjcgMpf
         HKo6Jrlmu/N7f4h+1tuInGIKqzzJrZ1sDhiwsjp4QJY3650ll38KpAY24b69zS7jgIrZ
         sIzA==
X-Gm-Message-State: APjAAAVRt/2jBP37+HyiOq8RG08D2UpHyA6TAUf2DdvRX++v9OjKl3Mz
        HJ3XfU7IvPLMO0LpiqEqIS8dtEQ1s3o3xb2mtX1yYw==
X-Google-Smtp-Source: APXvYqwsXOV1dRnLgD4MbcsRYsF31p0wp2C5ruO6P/V4wXucFqSMQqLJAkuG/rT1pcvsF+xlHN56UaNtXKGfjIqj8IQ=
X-Received: by 2002:aa7:8085:: with SMTP id v5mr20489464pff.165.1567198477179;
 Fri, 30 Aug 2019 13:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190830034304.24259-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Aug 2019 13:54:26 -0700
Message-ID: <CAKwvOdmrVG8yYvaZ++r4GVKx_p3YaxdyA85H_roPJf8efQkoiw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> this option. A couple of build errors were reported by randconfig,
> but all of them have been ironed out.
>
> Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> (and it will simplify the 'inline' macro in compiler_types.h),
> this commit changes it to always-on option. Going forward, the
> compiler will always be allowed to not inline functions marked
> 'inline'.
>
> This is not a problem for x86 since it has been long used by
> arch/x86/configs/{x86_64,i386}_defconfig.
>
> I am keeping the config option just in case any problem crops up for
> other architectures.
>
> The code clean-up will be done after confirming this is solid.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Just saw akpm picked this up, but
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  lib/Kconfig.debug | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5960e2980a8a..e25493811df8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -327,7 +327,7 @@ config HEADERS_CHECK
>           relevant for userspace, say 'Y'.
>
>  config OPTIMIZE_INLINING
> -       bool "Allow compiler to uninline functions marked 'inline'"
> +       def_bool y
>         help
>           This option determines if the kernel forces gcc to inline the functions
>           developers have marked 'inline'. Doing so takes away freedom from gcc to
> @@ -338,8 +338,6 @@ config OPTIMIZE_INLINING
>           decision will become the default in the future. Until then this option
>           is there to test gcc for this.
>
> -         If unsure, say N.
> -
>  config DEBUG_SECTION_MISMATCH
>         bool "Enable full Section mismatch analysis"
>         help
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
