Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FBC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C1A20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRnSx9s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfIKQwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:52:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55463 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfIKQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:52:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so4302068wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3ECIsRGngFyFH2jbVLH1ZsB1j4Lio7jznUTM12k5iY=;
        b=IRnSx9s7SGPyQDYBtwkGT+C2HJBmux4cX3LA4BXnurVeqPWx0EP8o2Ufhr+KO9n/z8
         N4qlTgJj9ufybjzzgfsRuqW+wWnA8RTLuCIg9ScooMYGPwv0/42uq/gEDyLbB7ThGgZ9
         BFJsEE9avk8cp33uOWhlBR0blkSQc/ipzCw4iGpaLocv8PpmlNmVKll80E4p3DDz/IBT
         vAZBEwS8LKPIy9EmdXeyf8udo8dLWl7Zi84/bdJtn/GaNYduECEMUujTe3t03buQ5rTO
         G1lmAdpqNSEvzSyxx6MBgQ2jBwRKQQZgdWKlwNoghzrIb7oFZ/MQ9VroVEbddGAqp7tV
         95PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3ECIsRGngFyFH2jbVLH1ZsB1j4Lio7jznUTM12k5iY=;
        b=nXwFxjlV0X20s52h7D6/1JDvJTIBmD9nowdo2PRb8RmBhBF4yqeKQUxVJEsjqHYabO
         dJCHYcvC903/lRFCbfr9jbpYuTHTWWU6ef+kx4hf6OZMuIh6hMXFGrihrXAZQA6yMP7F
         +dupGcoDC5QTZmfqxvdpSWtp/FNb42p2XCtCq5Cjf4vQ4oOrhVgLw2hiCjJeF0WvRdhg
         QoEz+v3dPcTFsUoAuMxzqthbOZbAHaW14vopjOPwa6c165jhn3MxXrUGruRKb+Htsw9n
         qw283UjTVWWcdk5X7+l3Airh7iqWNZ5Wvm1tSN9WwqWHaPo0NYue/j6NDoXWjaZKodmZ
         LGfQ==
X-Gm-Message-State: APjAAAWvIxSI1jjweGqu9KlPcQRgypJpAKwTZY09IYFxRBabDIZjvK/5
        br3xZZCQYqlwhhEhBu8PxK5ql+L9yq77R4Ln8zynwXapLJqm+Rx+
X-Google-Smtp-Source: APXvYqyAjDbqgEWsrcWwkGWJfLGnYNI/WRtw7/SvGsIIBoId+xJQcgCq6of6P7BahKsjibuh05TdGkeMujrV8W/eY4g=
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr390682wmz.61.1568220718948;
 Wed, 11 Sep 2019 09:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190911122646.13838-1-will@kernel.org>
In-Reply-To: <20190911122646.13838-1-will@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Sep 2019 17:51:38 +0100
Message-ID: <CAKv+Gu8G_HHE+xerEQpGoy0wJ1iqhuFqRpL34At9ue2BpT+XeA@mail.gmail.com>
Subject: Re: [PATCH] module: Fix link failure due to invalid relocation on
 namespace offset
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 13:26, Will Deacon <will@kernel.org> wrote:
>
> Commit 8651ec01daed ("module: add support for symbol namespaces.")
> broke linking for arm64 defconfig:
>
>   | lib/crypto/arc4.o: In function `__ksymtab_arc4_setkey':
>   | arc4.c:(___ksymtab+arc4_setkey+0x8): undefined reference to `no symbol'
>   | lib/crypto/arc4.o: In function `__ksymtab_arc4_crypt':
>   | arc4.c:(___ksymtab+arc4_crypt+0x8): undefined reference to `no symbol'
>
> This is because the dummy initialisation of the 'namespace_offset' field
> in 'struct kernel_symbol' when using EXPORT_SYMBOL on architectures with
> support for PREL32 locations uses an offset from an absolute address (0)
> in an effort to trick 'offset_to_pointer' into behaving as a NOP,
> allowing non-namespaced symbols to be treated in the same way as those
> belonging to a namespace.
>
> Unfortunately, place-relative relocations require a symbol reference
> rather than an absolute value and, although x86 appears to get away with
> this due to placing the kernel text at the top of the address space, it
> almost certainly results in a runtime failure if the kernel is relocated
> dynamically as a result of KASLR.
>
> Rework 'namespace_offset' so that a value of 0, which cannot occur for a
> valid namespaced symbol, indicates that the corresponding symbol does
> not belong to a namespace.
>
> Cc: Matthias Maennich <maennich@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> Please note that I've not been able to test this at LPC, but it's been
> submitted to kernelci.
>

The build tests all passed, and the boot tests that have completed by
now all look fine, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>  include/asm-generic/export.h | 2 +-
>  include/linux/export.h       | 2 +-
>  kernel/module.c              | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index e2b5d0f569d3..d0912c7ac2fc 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -17,7 +17,7 @@
>
>  .macro __put, val, name
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> -       .long   \val - ., \name - ., 0 - .
> +       .long   \val - ., \name - ., 0
>  #elif defined(CONFIG_64BIT)
>         .quad   \val, \name, 0
>  #else
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 2c5468d8ea9a..ef5d015d754a 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -68,7 +68,7 @@ extern struct module __this_module;
>             "__ksymtab_" #sym ":                                \n"     \
>             "   .long   " #sym "- .                             \n"     \
>             "   .long   __kstrtab_" #sym "- .                   \n"     \
> -           "   .long   0 - .                                   \n"     \
> +           "   .long   0                                       \n"     \
>             "   .previous                                       \n")
>
>  struct kernel_symbol {
> diff --git a/kernel/module.c b/kernel/module.c
> index f76efcf2043e..7ab244c4e1ba 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -547,6 +547,8 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>  static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
>  {
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +       if (!sym->namespace_offset)
> +               return NULL;
>         return offset_to_ptr(&sym->namespace_offset);
>  #else
>         return sym->namespace;
> --
> 2.23.0.162.g0b9fbb3734-goog
>
