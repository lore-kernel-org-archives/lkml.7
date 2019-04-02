Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D102084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTbTgpZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDBVgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:36:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45380 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:36:23 -0400
Received: by mail-vs1-f67.google.com with SMTP id n14so8664253vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Thd0jVX/63TwmadGEy08cy6JD5arknEdSADD6KbvAk=;
        b=aTbTgpZXxmL0d15A9fVapuLHwiohd4vv8+r96bHzRb2aCO5ipd5w2v78YQF1nUG6lB
         oyiM75pvGoHwuzz2RZRnUeDk0rETkdIQ6RWRLK4CSD7ekSghnmqDN1AfoJBlXwR4fcvN
         iDOO9NKY7sA5fnGctViNwSeOgFJGtzehTDcHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Thd0jVX/63TwmadGEy08cy6JD5arknEdSADD6KbvAk=;
        b=XyjSdwwq1TOrEuiG3O9yIbEnyP5kUBSz9r+8YNBF/rtxMP/6vvWS9mBJCMUXIzlHyW
         51bJvVfX2xkNWuD7rCyT1+GYCEBcP5LwdYxY7pL1wt2bYf7shA4ozvJFj8wU8GRtswYK
         L+a/zKTG1dIX8tUfka+Nk63/hbmOpaoZNoRh9qD5rDI3kgC5LGFIsmLs+kLgc85JwWEJ
         fvvdAfYVNHoLBnBnOQwEOKbnyf6CKReFd79hXB0VeN85z/QBe+R73pD+EUIKrYviK6qb
         Lj14heGbSh4sb12GcCrUU492H0qLRw3H1yjmD84IKsbo5OGYXmZQ44zHF4juMjy6r2uI
         a+LA==
X-Gm-Message-State: APjAAAXl8OyFWOHc59DKZMpxYozlGp7n+rzespwbiWNXsY0FHcpAvEH0
        hAIXgOWrteC152NPrc0Apn3wFfzTE+0=
X-Google-Smtp-Source: APXvYqx+jbkUjxG+8cM4MZLa0YPzvXDBQuw45SIqEii0znpLv4LWQOlsDEg1KZ5ehRS2eG272qiYXg==
X-Received: by 2002:a05:6102:401:: with SMTP id d1mr3635157vsq.178.1554240981435;
        Tue, 02 Apr 2019 14:36:21 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id y127sm3362038vsc.26.2019.04.02.14.36.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:36:18 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id c13so4909196uao.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:36:18 -0700 (PDT)
X-Received: by 2002:ab0:154e:: with SMTP id p14mr40436566uae.48.1554240977912;
 Tue, 02 Apr 2019 14:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-8-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-8-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:36:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKs7sTzd==6q1k+wti1eW0Dt7msgvHBupRNJv33CDPYWg@mail.gmail.com>
Message-ID: <CAGXu5jKs7sTzd==6q1k+wti1eW0Dt7msgvHBupRNJv33CDPYWg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] lib: Add test module for strscpy_pad
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
> Add a test module for the new strscpy_pad() function.  Tie it into the
> kselftest infrastructure for lib/ tests.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Yay! :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/Kconfig.debug                      |   3 +
>  lib/Makefile                           |   1 +
>  lib/test_strscpy.c                     | 150 +++++++++++++++++++++++++
>  tools/testing/selftests/lib/Makefile   |   2 +-
>  tools/testing/selftests/lib/config     |   1 +
>  tools/testing/selftests/lib/strscpy.sh |  17 +++
>  6 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 lib/test_strscpy.c
>  create mode 100755 tools/testing/selftests/lib/strscpy.sh
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..441c1571495c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1805,6 +1805,9 @@ config TEST_HEXDUMP
>  config TEST_STRING_HELPERS
>         tristate "Test functions located in the string_helpers module at runtime"
>
> +config TEST_STRSCPY
> +       tristate "Test strscpy*() family of functions at runtime"
> +
>  config TEST_KSTRTOX
>         tristate "Test kstrto*() family of functions at runtime"
>
> diff --git a/lib/Makefile b/lib/Makefile
> index e1b59da71418..82e027f73a3e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> +obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
>  obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
>  obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
> diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
> new file mode 100644
> index 000000000000..95665e8a0f97
> --- /dev/null
> +++ b/lib/test_strscpy.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/string.h>
> +
> +#include "../tools/testing/selftests/kselftest_module.h"
> +
> +/*
> + * Kernel module for testing 'strscpy' family of functions.
> + */
> +
> +KSTM_MODULE_GLOBALS();
> +
> +/*
> + * tc() - Run a specific test case.
> + * @src: Source string, argument to strscpy_pad()
> + * @count: Size of destination buffer, argument to strscpy_pad()
> + * @expected: Expected return value from call to strscpy_pad()
> + * @terminator: 1 if there should be a terminating null byte 0 otherwise.
> + * @chars: Number of characters from the src string expected to be
> + *         written to the dst buffer.
> + * @pad: Number of pad characters expected (in the tail of dst buffer).
> + *       (@pad does not include the null terminator byte.)
> + *
> + * Calls strscpy_pad() and verifies the return value and state of the
> + * destination buffer after the call returns.
> + */
> +static int __init tc(char *src, int count, int expected,
> +                    int chars, int terminator, int pad)
> +{
> +       int nr_bytes_poison;
> +       int max_expected;
> +       int max_count;
> +       int written;
> +       char buf[6];
> +       int index, i;
> +       const char POISON = 'z';
> +
> +       total_tests++;
> +
> +       if (!src) {
> +               pr_err("null source string not supported\n");
> +               return -1;
> +       }
> +
> +       memset(buf, POISON, sizeof(buf));
> +       /* Future proofing test suite, validate args */
> +       max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
> +       max_expected = count - 1;     /* Space for the null */
> +       if (count > max_count) {
> +               pr_err("count (%d) is too big (%d) ... aborting", count, max_count);
> +               return -1;
> +       }
> +       if (expected > max_expected) {
> +               pr_warn("expected (%d) is bigger than can possibly be returned (%d)",
> +                       expected, max_expected);
> +       }
> +
> +       written = strscpy_pad(buf, src, count);
> +       if ((written) != (expected)) {
> +               pr_err("%d != %d (written, expected)\n", written, expected);
> +               goto fail;
> +       }
> +
> +       if (count && written == -E2BIG) {
> +               if (strncmp(buf, src, count - 1) != 0) {
> +                       pr_err("buffer state invalid for -E2BIG\n");
> +                       goto fail;
> +               }
> +               if (buf[count - 1] != '\0') {
> +                       pr_err("too big string is not null terminated correctly\n");
> +                       goto fail;
> +               }
> +       }
> +
> +       for (i = 0; i < chars; i++) {
> +               if (buf[i] != src[i]) {
> +                       pr_err("buf[i]==%c != src[i]==%c\n", buf[i], src[i]);
> +                       goto fail;
> +               }
> +       }
> +
> +       if (terminator) {
> +               if (buf[count - 1] != '\0') {
> +                       pr_err("string is not null terminated correctly\n");
> +                       goto fail;
> +               }
> +       }
> +
> +       for (i = 0; i < pad; i++) {
> +               index = chars + terminator + i;
> +               if (buf[index] != '\0') {
> +                       pr_err("padding missing at index: %d\n", i);
> +                       goto fail;
> +               }
> +       }
> +
> +       nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
> +       for (i = 0; i < nr_bytes_poison; i++) {
> +               index = sizeof(buf) - 1 - i; /* Check from the end back */
> +               if (buf[index] != POISON) {
> +                       pr_err("poison value missing at index: %d\n", i);
> +                       goto fail;
> +               }
> +       }
> +
> +       return 0;
> +fail:
> +       failed_tests++;
> +       return -1;
> +}
> +
> +static void __init selftest(void)
> +{
> +       /*
> +        * tc() uses a destination buffer of size 6 and needs at
> +        * least 2 characters spare (one for null and one to check for
> +        * overflow).  This means we should only call tc() with
> +        * strings up to a maximum of 4 characters long and 'count'
> +        * should not exceed 4.  To test with longer strings increase
> +        * the buffer size in tc().
> +        */
> +
> +       /* tc(src, count, expected, chars, terminator, pad) */
> +       KSTM_CHECK_ZERO(tc("a", 0, -E2BIG, 0, 0, 0));
> +       KSTM_CHECK_ZERO(tc("", 0, -E2BIG, 0, 0, 0));
> +
> +       KSTM_CHECK_ZERO(tc("a", 1, -E2BIG, 0, 1, 0));
> +       KSTM_CHECK_ZERO(tc("", 1, 0, 0, 1, 0));
> +
> +       KSTM_CHECK_ZERO(tc("ab", 2, -E2BIG, 1, 1, 0));
> +       KSTM_CHECK_ZERO(tc("a", 2, 1, 1, 1, 0));
> +       KSTM_CHECK_ZERO(tc("", 2, 0, 0, 1, 1));
> +
> +       KSTM_CHECK_ZERO(tc("abc", 3, -E2BIG, 2, 1, 0));
> +       KSTM_CHECK_ZERO(tc("ab", 3, 2, 2, 1, 0));
> +       KSTM_CHECK_ZERO(tc("a", 3, 1, 1, 1, 1));
> +       KSTM_CHECK_ZERO(tc("", 3, 0, 0, 1, 2));
> +
> +       KSTM_CHECK_ZERO(tc("abcd", 4, -E2BIG, 3, 1, 0));
> +       KSTM_CHECK_ZERO(tc("abc", 4, 3, 3, 1, 0));
> +       KSTM_CHECK_ZERO(tc("ab", 4, 2, 2, 1, 1));
> +       KSTM_CHECK_ZERO(tc("a", 4, 1, 1, 1, 2));
> +       KSTM_CHECK_ZERO(tc("", 4, 0, 0, 1, 3));
> +}
> +
> +KSTM_MODULE_LOADERS(test_strscpy);
> +MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> index 70d5711e3ac8..9f26635f3e57 100644
> --- a/tools/testing/selftests/lib/Makefile
> +++ b/tools/testing/selftests/lib/Makefile
> @@ -3,6 +3,6 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>
> -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
> +TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
>
>  include ../lib.mk
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 126933bcc950..14a77ea4a8da 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,3 +1,4 @@
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_BITMAP=m
>  CONFIG_PRIME_NUMBERS=m
> +CONFIG_TEST_STRSCPY=m
> diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
> new file mode 100755
> index 000000000000..f3ba4b90e602
> --- /dev/null
> +++ b/tools/testing/selftests/lib/strscpy.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +module=test_strscpy
> +description="strscpy"
> +
> +#
> +# Shouldn't need to edit anything below here.
> +#
> +
> +file="kselftest_module.sh"
> +path="../$file"
> +if [[ ! $KBUILD_SRC == "" ]]; then
> +    path="${KBUILD_SRC}/tools/testing/selftests/$file"
> +fi
> +
> +$path $module $description
> --
> 2.20.1
>


-- 
Kees Cook
