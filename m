Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778221D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6NiituZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfKHBYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:24:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHBYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:24:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id w11so3027476pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fARBDWwNTT6jT5EhjTe8Lj8RdP+sxXD4YhlXUehOu+w=;
        b=u6NiituZ4gJAngALm2Ceb+veH0GCGvTP3iMM0TWVojT6zqDvkU3+nSyLxF5Bh3CjI9
         kveET2xCthvDfHV8PF/U6yEoC6B9JNRoRugHviJu/aQBZ4T2Ed34Mt6yBHnRbbCL90Bi
         SxEMw+hfd2ExQ/KHIqDXZZHFAtlNJI8wdx3YT3nOOyDjFgGZZdKeROd640GdnImC91iu
         eAOQksB8hI256CzeLfcZMm5OAjHM2wZ9yJBNNMaKUVflwqacV03AwXqKzDRwgI6354Jv
         bsh9+Br3tK69PxyYO13EyBn/oIYOSuxRr17cREL4OVgowia9K3HnLY7CVRwBgztI5WR/
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fARBDWwNTT6jT5EhjTe8Lj8RdP+sxXD4YhlXUehOu+w=;
        b=liW6cAurjZ2jM2j9WQkJFbXsaA16Rqb0YbX9553a+I6n9TWv5AEJFDmD1zqcz16tEa
         wYD510EH9pey6zTM/DGEdmYHk8lMV843/vMIk7ra/7PNhYJti2D44vErgn7dMJmhDP0e
         QeTiROafgxJOwQ9S+MVqJyib2LG/lCFEVfh7oop23YqPmmFHlALSM5nlXM7pFUV3+Yvw
         TTJ/1ALrfdU1PENTcHjdfIoiUaTN98qZx0jVDbFx+0Y1OBALTPFj9aioB09fcUO6+GIP
         s6/fjSKPiBwJsLF1l4vjIgkY6QcYVAnyf7GpQU9vUt3ZmcjgnN2UPmN92/Lz/CMdVPUP
         HptA==
X-Gm-Message-State: APjAAAVjddARFXy3kdtC4Xm68CuL8Paa7T+F4FQ5+f9we8R4Tqa9XpWR
        isW/2LFSBTcc3Qkeq16PCho6TeS7/ElUSrrSYjbOYA==
X-Google-Smtp-Source: APXvYqzGujOAvUTcF0qo1Y8Zaf9OqgTljDoiGnRaCMwuBJj2U1UfGVK7ai9s/7BkaMWvUrVSBPiiM19eE9AJ+dBTQLM=
X-Received: by 2002:a63:234c:: with SMTP id u12mr8210833pgm.384.1573176272237;
 Thu, 07 Nov 2019 17:24:32 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 17:24:21 -0800
Message-ID: <CAFd5g46s=zgJXKRKj8iw5Bng=a06wb-PmDs_7-c7c-MiryrnAg@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 3/6] kunit: add
 kunit_find_symbol() function for symbol lookup
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In preparation for module support for kunit and kunit tests,
> we need a way of retrieving non-exported symbols from the
> core kernel and modules.  kunit_find_symbol() supports this.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>

I think you suggested on another thread that splitting this patch out
of this patchset might be a good idea. I agree with that. Can you send
this patch separately?

> ---
>  include/kunit/test.h  |  8 ++++++++
>  lib/kunit/test-test.c | 19 +++++++++++++++++++
>  lib/kunit/test.c      | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index dba4830..c645d18 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -339,6 +339,14 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>
>  void kunit_cleanup(struct kunit *test);
>
> +/**
> + * kunit_find_symbol() - lookup un-exported symbol in kernel or modules.
> + * @sym: symbol name.
> + *
> + * Returns symbol or ERR_PTR value on error.

Can you document which ERR_PTRs it returns?

> + */
> +void *kunit_find_symbol(const char *sym);
> +
>  #define kunit_printk(lvl, test, fmt, ...) \
>         printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
>
> diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
> index c4162a9..7f09dd0 100644
> --- a/lib/kunit/test-test.c
> +++ b/lib/kunit/test-test.c
> @@ -330,3 +330,22 @@ static void kunit_resource_test_exit(struct kunit *test)
>         .test_cases = kunit_resource_test_cases,
>  };
>  kunit_test_suite(kunit_resource_test_suite);
> +
> +/*
> + * Find non-exported kernel symbol; we use the modules list as a safe
> + * choice that should always be present.
> + */
> +static void kunit_find_symbol_kernel(struct kunit *test)
> +{
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kunit_find_symbol("modules"));

I think this should be a KUNIT_EXPECT_... here since nothing in this
test case depends on this check passing.

> +}
> +
> +static struct kunit_case kunit_find_symbol_test_cases[] = {
> +       KUNIT_CASE(kunit_find_symbol_kernel),
> +};
> +
> +static struct kunit_suite kunit_find_symbol_test_suite = {
> +       .name = "kunit-find-symbol",
> +       .test_cases = kunit_find_symbol_test_cases,
> +};
> +kunit_test_suite(kunit_find_symbol_test_suite);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49ac5fe..a2b1b46 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -8,6 +8,7 @@
>
>  #include <kunit/test.h>
>  #include <kunit/try-catch.h>
> +#include <linux/kallsyms.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/debug.h>
>  #include "string-stream-impl.h"
> @@ -478,3 +479,38 @@ void kunit_cleanup(struct kunit *test)
>                 kunit_resource_free(test, resource);
>         }
>  }
> +
> +/*
> + * Support for looking up kernel/module internal symbols to enable testing.
> + */
> +void *kunit_find_symbol(const char *sym)
> +{
> +       unsigned long (*modlookup)(const char *name);
> +       unsigned long addr = 0;
> +
> +       if (!sym || strlen(sym) > KSYM_NAME_LEN)
> +               return ERR_PTR(-EINVAL);
> +
> +       /*
> +        * Try for kernel-internal symbol first; fall back to modules
> +        * if that fails.
> +        */
> +       addr = kallsyms_lookup_name(sym);
> +       if (addr)
> +               return (void *)addr;

nit: please add a newline here.

> +       modlookup = (void *)kallsyms_lookup_name("module_kallsyms_lookup_name");

Can you add a comment here explaining what module_kallsyms_lookup_name
is and why you need to look it up this way?

> +       if (modlookup)
> +               addr = modlookup(sym);
> +       if (addr)
> +               return (void *)addr;
> +
> +#ifndef CONFIG_KALLSYMS_ALL
> +       WARN_ONCE(true,
> +                 "CONFIG_KALLSYMS_ALL is not set, so unexported symbols like '%s' are not available\n",
> +                 sym);
> +       return ERR_PTR(-ENOTSUPP);
> +#else
> +       WARN_ONCE(true, "symbol '%s' is not available\n", sym);
> +#endif
> +       return ERR_PTR(-ENOENT);
> +}
> --
> 1.8.3.1
>
