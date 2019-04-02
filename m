Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90542084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1pq4FQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDBVbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:31:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36879 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBVbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:31:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so7677704vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvdaYGh67XZX3oPIZGd5pulj8w8ON/V4dWI5OeylBkk=;
        b=O1pq4FQTGoCZe80U3W78a3IwXgz1dzq4lVDTpN3Z5B19fEzomFbsQKqjGG/iyHWJZZ
         auEj091yYQ4MZw8pm1j15wJVPpyUzy/2OTXCK1GEFtEtoP++aQ8S9zrXN0sjhPFtohCK
         hgXGvkEiYfjm5AKfoh2R2dff/0LAGM+FlCKlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvdaYGh67XZX3oPIZGd5pulj8w8ON/V4dWI5OeylBkk=;
        b=tqzczeW4U2NS7QXJFXM1b0oudCpxV+cJ9yYZMVFKFNhlAuy/bWbJ2H417kw66uja99
         S62zfLT9XQgVbe2V98cHMOKx0I6o3e+qIHf8cXKV6Op5am0Mho17qhZmkYNxcixN1C+O
         sTjNOwS1mWvDYllBtu5oa3NYCb5eHYedT+hbW5rRyn5mcgbhWNQGPKNLQUfr5u7DQLDm
         NHqKIItm8SklzukznmdQ1c7f9ERidK0o4tM2HxClyzTxv/6iNEGXKd+YkudLvdcG/SbZ
         HrQwkCyN8IT93JLon4cwfS87F+bkS600UDAfeXirx6xvkE+nP382cxstuOWrjh/xz1by
         y3SA==
X-Gm-Message-State: APjAAAWH+UDWOlnZAFPquiqehPgNAWP9uXilxmFjDwj7JdJVIa6PGWS+
        aq1IQeQoxuaKg0iEKB6euCcomqE0FyQ=
X-Google-Smtp-Source: APXvYqwwU70VG+FJdD8VG0HDrETwATzcjjv6XfSkFvbOMd6pPdajDH6vhxNQpW5Z6G4S9b6aue9hLw==
X-Received: by 2002:a67:ff11:: with SMTP id v17mr41241115vsp.108.1554240682614;
        Tue, 02 Apr 2019 14:31:22 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id p29sm2843979vsl.9.2019.04.02.14.31.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:31:22 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id g8so4910823uaj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:31:22 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr58456uam.85.1554240681334;
 Tue, 02 Apr 2019 14:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-5-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-5-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:31:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Ux+w5KMYvGV+N_ZC-+tMQ=TpM3i5z-p1kCFnF0Ld9eA@mail.gmail.com>
Message-ID: <CAGXu5j+Ux+w5KMYvGV+N_ZC-+tMQ=TpM3i5z-p1kCFnF0Ld9eA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] kselftest: Add test module framework header
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
> kselftest runs as a userspace process.  Sometimes we need to test things
> from kernel space.  One way of doing this is by creating a test module.
> Currently doing so requires developers to write a bunch of boiler plate
> in the module if kselftest is to be used to run the tests.  This means
> we currently have a load of duplicate code to achieve these ends.  If we
> have a uniform method for implementing test modules then we can reduce
> code duplication, ensure uniformity in the test framework, ease code
> maintenance, and reduce the work required to create tests.  This all
> helps to encourage developers to write and run tests.
>
> Add a C header file that can be included in test modules.  This provides
> a single point for common test functions/macros.  Implement a few macros
> that make up the start of the test framework.
>
> Add documentation for new kselftest header and script to kselftest
> documentation.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

I like this!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/dev-tools/kselftest.rst      | 108 ++++++++++++++++++++-
>  tools/testing/selftests/kselftest_module.h |  48 +++++++++
>  2 files changed, 154 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kselftest_module.h
>
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 7756f7a7c23b..fb7790d47147 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -14,6 +14,10 @@ in safe mode with a limited scope. In limited mode, cpu-hotplug test is
>  run on a single cpu as opposed to all hotplug capable cpus, and memory
>  hotplug test is run on 2% of hotplug capable memory instead of 10%.
>
> +kselftest runs as a userspace process.  Tests that can be written/run in
> +userspace may wish to use the `Test Harness`_.  Tests that need to be
> +run in kernel space may wish to use a `Test Module`_.
> +
>  Running the selftests (hotplug tests are run in limited mode)
>  =============================================================
>
> @@ -161,11 +165,111 @@ Contributing new tests (details)
>
>     e.g: tools/testing/selftests/android/config
>
> +Test Module
> +===========
> +
> +Kselftest tests the kernel from userspace.  Sometimes things need
> +testing from within the kernel, one method of doing this is to create a
> +test module.  We can tie the module into the kselftest framework by
> +using a shell script test runner.  ``kselftest_module.sh`` is designed
> +to facilitate this process.  There is also a header file provided to
> +assist writing kernel modules that are for use with kselftest:
> +
> +- ``tools/testing/kselftest/kselftest_module.h``
> +- ``tools/testing/kselftest/kselftest_module.sh``
> +
> +How to use
> +----------
> +
> +Here we show the typical steps to create a test module and tie it into
> +kselftest.  We use kselftests for lib/ as an example.
> +
> +1. Create the test module
> +
> +2. Create the test script that will run (load/unload) the module
> +   e.g. ``tools/testing/selftests/lib/printf.sh``
> +
> +3. Add line to config file e.g. ``tools/testing/selftests/lib/config``
> +
> +4. Add test script to makefile  e.g. ``tools/testing/selftests/lib/Makefile``
> +
> +5. Verify it works:
> +
> +.. code-block:: sh
> +
> +   # Assumes you have booted a fresh build of this kernel tree
> +   cd /path/to/linux/tree
> +   make kselftest-merge
> +   make modules
> +   sudo make modules_install
> +   make TARGETS=lib kselftest
> +
> +Example Module
> +--------------
> +
> +A bare bones test module might look like this:
> +
> +.. code-block:: c
> +
> +   // SPDX-License-Identifier: GPL-2.0+
> +
> +   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +   #include "../tools/testing/selftests/kselftest_module.h"
> +
> +   KSTM_MODULE_GLOBALS();
> +
> +   /*
> +    * Kernel module for testing the foobinator
> +    */
> +
> +   static int __init test_function()
> +   {
> +           ...
> +   }
> +
> +   static void __init selftest(void)
> +   {
> +           KSTM_CHECK_ZERO(do_test_case("", 0));
> +   }
> +
> +   KSTM_MODULE_LOADERS(test_foo);
> +   MODULE_AUTHOR("John Developer <jd@fooman.org>");
> +   MODULE_LICENSE("GPL");
> +
> +Example test script
> +-------------------
> +
> +.. code-block:: sh
> +
> +    #!/bin/bash
> +    # SPDX-License-Identifier: GPL-2.0+
> +
> +    module_name="test_foo"             # Module name (without the .ko).
> +    description="foo"                  # Output prefix.
> +
> +    #
> +    # Shouldn't need to edit anything below here.
> +    #
> +
> +    file="kselftest_module.sh"
> +    path="../$file"
> +    if [[ ! $KBUILD_SRC == "" ]]; then
> +        path="${KBUILD_SRC}/tools/testing/selftests/$file"
> +    fi
> +
> +    $path $module_name $description
> +
> +
>  Test Harness
>  ============
>
> -The kselftest_harness.h file contains useful helpers to build tests.  The tests
> -from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as example.
> +The kselftest_harness.h file contains useful helpers to build tests.  The
> +test harness is for userspace testing, for kernel space testing see `Test
> +Module`_ above.
> +
> +The tests from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as
> +example.
>
>  Example
>  -------
> diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
> new file mode 100644
> index 000000000000..e8eafaf0941a
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_module.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __KSELFTEST_MODULE_H
> +#define __KSELFTEST_MODULE_H
> +
> +#include <linux/module.h>
> +
> +/*
> + * Test framework for writing test modules to be loaded by kselftest.
> + * See Documentation/dev-tools/kselftest.rst for an example test module.
> + */
> +
> +#define KSTM_MODULE_GLOBALS()                  \
> +static unsigned int total_tests __initdata;    \
> +static unsigned int failed_tests __initdata
> +
> +#define KSTM_CHECK_ZERO(x) do {                                                \
> +       total_tests++;                                                  \
> +       if (x) {                                                        \
> +               pr_warn("TC failed at %s:%d\n", __func__, __LINE__);    \
> +               failed_tests++;                                         \
> +       }                                                               \
> +} while (0)
> +
> +static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
> +{
> +       if (failed_tests == 0)
> +               pr_info("all %u tests passed\n", total_tests);
> +       else
> +               pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
> +
> +       return failed_tests ? -EINVAL : 0;
> +}
> +
> +#define KSTM_MODULE_LOADERS(__module)                  \
> +static int __init __module##_init(void)                        \
> +{                                                      \
> +       pr_info("loaded.\n");                           \
> +       selftest();                                     \
> +       return kstm_report(total_tests, failed_tests);  \
> +}                                                      \
> +static void __exit __module##_exit(void)               \
> +{                                                      \
> +       pr_info("unloaded.\n");                         \
> +}                                                      \
> +module_init(__module##_init);                          \
> +module_exit(__module##_exit)
> +
> +#endif /* __KSELFTEST_MODULE_H */
> --
> 2.20.1
>


-- 
Kees Cook
