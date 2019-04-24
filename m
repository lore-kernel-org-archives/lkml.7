Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39142089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfDXH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:29:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37777 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfDXH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:29:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so10252730qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XapeRkWY7o+spNjWmUQhyJBsoa0At4KGBTfzOOUiPIM=;
        b=KUgI9FwyPGSeLOJZlcxyRfg9Qe/W9SHn4Z7wP17A1hM9vyY+/JQDyZ+R2GHAu1OVzK
         /wHaeXSROFM+KdcGk4/y1s/cBU0uFpI7DROK0QnbwnEcLqkUOpA0dSZFW8DG0VwY6ma3
         /Tg7ZvQumMerRyHyCrxZiXDR1p+l1Mq11Zq7sDppOnPYMsRUtO23q7LMa9sYslmFlCLq
         fgGJ8dNt6F7tkKZsVBe63qLKDYdmtwdJl5OqcjI3QlEMQneNmQq6Eg+Owts0d3wDcIdy
         r248ddzUXVZAhAg6QPU+AIMKpQFoMkzYX5wEar4KhouSA+p17w7cvVlzRjgxv0tFyZ7P
         TxAg==
X-Gm-Message-State: APjAAAVOl6x5SB4poPNMTFN+7Puag6pvDZY25xsLTvlJQPptO97FMzbX
        jjBYy0OISCZWyBXc4xen4KQwKA+Sj91Y08GcFVxYQXce
X-Google-Smtp-Source: APXvYqxPbcbpVM+mifN64GX7ZgCSQPjx3aIInu6c5ALadps2VDQnd6V3ly/9e8mSBxY1VO0pxRUkQSBFCUxgq3Gy2qw=
X-Received: by 2002:a37:49ce:: with SMTP id w197mr15032839qka.330.1556090979380;
 Wed, 24 Apr 2019 00:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181210223133.22667-1-ndesaulniers@google.com>
In-Reply-To: <20181210223133.22667-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 09:29:23 +0200
Message-ID: <CAK8P3a3At0Znn7BRxVxFdxcCa2=uJ9fAJYazKe3E9688axPj2g@mail.gmail.com>
Subject: Re: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:32 PM <ndesaulniers@google.com> wrote:
>
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/arm/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
>
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

The patch looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Adding Nathan Lynch to Cc though for further comments, he originally
added the Makefile flags here and might still remember why he did it.

Unless Nathan objects, please add the patch to Russell's patch tracker.

> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index f4efff9d3afb..8f2fac5acbc8 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -11,7 +11,7 @@ ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
>  VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
> -VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
>  VDSO_LDFLAGS += -nostdlib -shared
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> --
> 2.20.0.rc2.403.gdbc3b29805-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
