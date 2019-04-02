Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D725DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B2C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSztmzH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDBVjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:39:39 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40796 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:39:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id f22so8721200vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sb1t6f7PMkPhKdCQnKJiIIJA0EVTSKOkOLlWb1FyN24=;
        b=jSztmzH8j4Mx9qsc3jFlYQaQJUCAk0juoz8VnhUdBr5DNPPg/LZRNS9LNcZtoSCQw9
         df7rtCdE3iBDQb4xaqxx3ubV1BYDMFfYCvkzZNc11f1h/8VA76bSdYyiOA2TGUkWhSBu
         yqT/KsTqNHh8kvcfTQghaR9w4mW5JTqtGeyHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb1t6f7PMkPhKdCQnKJiIIJA0EVTSKOkOLlWb1FyN24=;
        b=g620Fkp7lM4H+lzBB42mJSDa3YSSQ5Slo7sFvXlJ87J6QqP0jWvaYRTs1xS8cm1wRu
         PA6dB7v4Ai1DLCpwKyKJUYGwSEELNJQIBaQnMAx9MdzXVfRWdvN0L3hCwIPvDE7gckE9
         jm1mWGgVUQSp29+6JQzIJTeWVLwTSwwrE3PwxGcoQlGlkOWrX6OcJzFK9Dn9E4H9Wb9N
         ZlRHdIgfC/TPAMHeOZ7SS6FLpwwrTiqBGFcC4SRoe6A0ef+51UFesLUHAqcxjRaQ56VJ
         x+0Xkr91teEtOuAAPosa7Ltm+70fbXLAqEsBNkVRlJ7pDwql24L4lwMkJwLaudCksMXD
         oQrg==
X-Gm-Message-State: APjAAAWSYfm6cgyd1nRVDdrgOzjSEgfGIpt9G2UdyXD7JBBvO52S12x6
        tkMA/U88RUz9KvQiGwpKY65lU5XLcQM=
X-Google-Smtp-Source: APXvYqxiTfC1Fc93NNHezohfDjZAs5G7h7YMWoLkL98lJyMPxRz2Pdbvpza8JekNhmLz3mnH4X0iHA==
X-Received: by 2002:a67:ea53:: with SMTP id r19mr26081890vso.12.1554241177538;
        Tue, 02 Apr 2019 14:39:37 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id r199sm4613238vke.30.2019.04.02.14.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:39:37 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id v7so4904006uak.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:39:37 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr3213192uah.123.1554240751192;
 Tue, 02 Apr 2019 14:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-6-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-6-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:32:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLpC8tGNfa2N3H24eby6j=HMWZKgkQaM=3W8MznLQsAOw@mail.gmail.com>
Message-ID: <CAGXu5jLpC8tGNfa2N3H24eby6j=HMWZKgkQaM=3W8MznLQsAOw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] lib: Use new kselftest header
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> We just added a new C header file for use with test modules that are
> intended to be run with kselftest.  We can reduce code duplication by
> using this header.
>
> Use new kselftest header to reduce code duplication in test_printf and
> test_bitmap test modules.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Nice consolidation.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_bitmap.c | 20 ++++----------------
>  lib/test_printf.c | 23 +++++------------------
>  2 files changed, 9 insertions(+), 34 deletions(-)
>
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 6cd7d0740005..792d90608052 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -12,6 +12,8 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>
> +#include "../tools/testing/selftests/kselftest_module.h"
> +
>  static unsigned total_tests __initdata;
>  static unsigned failed_tests __initdata;
>
> @@ -361,7 +363,7 @@ static void noinline __init test_mem_optimisations(void)
>         }
>  }
>
> -static int __init test_bitmap_init(void)
> +static void __init selftest(void)
>  {
>         test_zero_clear();
>         test_fill_set();
> @@ -369,22 +371,8 @@ static int __init test_bitmap_init(void)
>         test_bitmap_arr32();
>         test_bitmap_parselist();
>         test_mem_optimisations();
> -
> -       if (failed_tests == 0)
> -               pr_info("all %u tests passed\n", total_tests);
> -       else
> -               pr_warn("failed %u out of %u tests\n",
> -                       failed_tests, total_tests);
> -
> -       return failed_tests ? -EINVAL : 0;
>  }
>
> -static void __exit test_bitmap_cleanup(void)
> -{
> -}
> -
> -module_init(test_bitmap_init);
> -module_exit(test_bitmap_cleanup);
> -
> +KSTM_MODULE_LOADERS(test_bitmap);
>  MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 601e8519319a..f4fcc1c43739 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -21,6 +21,8 @@
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
>
> +#include "../tools/testing/selftests/kselftest_module.h"
> +
>  #define BUF_SIZE 256
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
> @@ -590,12 +592,11 @@ test_pointer(void)
>         flags();
>  }
>
> -static int __init
> -test_printf_init(void)
> +static void __init selftest(void)
>  {
>         alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
>         if (!alloced_buffer)
> -               return -ENOMEM;
> +               return;
>         test_buffer = alloced_buffer + PAD_SIZE;
>
>         test_basic();
> @@ -604,22 +605,8 @@ test_printf_init(void)
>         test_pointer();
>
>         kfree(alloced_buffer);
> -
> -       if (failed_tests == 0)
> -               pr_info("all %u tests passed\n", total_tests);
> -       else
> -               pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
> -
> -       return failed_tests ? -EINVAL : 0;
>  }
>
> -module_init(test_printf_init);
> -
> -static void __exit test_printf_exit(void)
> -{
> -}
> -
> -module_exit(test_printf_exit);
> -
> +KSTM_MODULE_LOADERS(test_printf);
>  MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
>  MODULE_LICENSE("GPL");
> --
> 2.20.1
>


-- 
Kees Cook
