Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD5FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0F5208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ni94Owio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFYU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:28:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44345 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFYU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:28:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so9493431pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq39ykktkvFBpmzRtbgM4tstWpOedFNE8kr26lh/InM=;
        b=ni94OwioZx/gzf2szVloCDZTFFpJCo2YKSFZ2X9qr6bxYnBeEpnnagfszyXnnz51L8
         DkJXaethFUsoHnz8KOQVG2ZSAlP6R4YiehiVV+cY7fw97Xus3XNQzLPLdgQULmgYaWnL
         GEAS55DRith5+cQIVd4nDD9PnOpK5SEC0mcAjXyMYNE83XKQ2Jfbx9GzYoD6pnR9q88y
         VjAnVY+gy9KsY/4+Tbda/+4DRlDyvSks4s9chgBxuZrKHnC3t/s2Oqm9eCfJpWO+nPcJ
         ixgXgEVA9P9D5QKdeUq3VIirHZ16lxLB0iDdlrfqM9fruDTYYR+l+8zODcodp3flRnlv
         dArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq39ykktkvFBpmzRtbgM4tstWpOedFNE8kr26lh/InM=;
        b=tqlzgClguFD4+8XxnQeiGYv9S1295tDjzjC1xb0WLThaawJ61DHnEls6UGLisewQik
         MLIu0ixvQnlDo/K/gH9k7YtkYzRtCID02W+770lckf76IVBVtzI9F0MsXncCE9P5ZEky
         Sk943FJ59SJfX242Ya2WRj0IunUvxJqYASy2tpLLVu6geQnvxwFTrLUw1DaCRDmyIRx8
         M8wC2QKZz4RpYvFZf/55ha+fWvVhulG9p5/1WDKePzZ9JRIFUbo9GBApcmMFNp1EuTGt
         xHEP27/PUb/y6Hoi47b/7avS3Kw5wBv35r9qXzsScaLJgVnpvV7Oev9Po8OWxGT37p/Y
         OALg==
X-Gm-Message-State: APjAAAV+8ZTKApiFYbnbeSNgLaEjzKG0yuSBTqzpMbxsEewg2LxJZ0Op
        wuN0K+l98LGlTKJ2Rs+VTyuR90Ignz9lAPx3jNo0Ag==
X-Google-Smtp-Source: APXvYqzvk20XXdVFtm6zl0X1nrjaH0TttItfcdP9iwaQ+JKQIeNhKF1pa7VSVvlXNPpMAUzP/tv1oR2JBEXuSnWnLw4=
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr754020pjb.117.1561494516332;
 Tue, 25 Jun 2019 13:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
In-Reply-To: <20190620001526.93426218BE@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Jun 2019 13:28:25 -0700
Message-ID: <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-17 01:25:56)
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..d05d254f1521f
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,210 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/sched/debug.h>
> > +#include <kunit/test.h>
> > +
> > +static bool kunit_get_success(struct kunit *test)
> > +{
> > +       unsigned long flags;
> > +       bool success;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       success = test->success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
>
> I still don't understand the locking scheme in this code. Is the
> intention to make getter and setter APIs that are "safe" by adding in a
> spinlock that is held around getting and setting various members in the
> kunit structure?

Yes, your understanding is correct. It is possible for a user to write
a test such that certain elements may be updated in different threads;
this would most likely happen in the case where someone wants to make
an assertion or an expectation in a thread created by a piece of code
under test. Although this should generally be avoided, it is possible,
and there are occasionally good reasons to do so, so it is
functionality that we should support.

Do you think I should add a comment to this effect?

> In what situation is there more than one thread reading or writing the
> kunit struct? Isn't it only a single process that is going to be

As I said above, it is possible that the code under test may spawn a
new thread that may make an expectation or an assertion. It is not a
super common use case, but it is possible.

> operating on this structure? And why do we need to disable irqs? Are we
> expecting to be modifying the unit tests from irq contexts?

There are instances where someone may want to test a driver which has
an interrupt handler in it. I actually have (not the greatest) example
here. Now in these cases, I expect someone to use a mock irqchip or
some other fake mechanism to trigger the interrupt handler and not
actual hardware; technically speaking in this case, it is not going to
be accessed from a "real" irq context; however, the code under test
should think that it is in an irq context; given that, I figured it is
best to just treat it as a real irq context. Does that make sense?

> > +
> > +       return success;
> > +}
> > +
> > +static void kunit_set_success(struct kunit *test, bool success)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       test->success = success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
> > +static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > +{
> > +       return vprintk_emit(0, level, NULL, 0, fmt, args);
> > +}
> > +
> > +static int kunit_printk_emit(int level, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       int ret;
> > +
> > +       va_start(args, fmt);
> > +       ret = kunit_vprintk_emit(level, fmt, args);
> > +       va_end(args);
> > +
> > +       return ret;
> > +}
> > +
> > +static void kunit_vprintk(const struct kunit *test,
> > +                         const char *level,
> > +                         struct va_format *vaf)
> > +{
> > +       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > +}
> > +
> > +static bool kunit_has_printed_tap_version;
>
> Can you please move this into function local scope in the function
> below?

Sure, that makes sense.

> > +
> > +static void kunit_print_tap_version(void)
> > +{
> > +       if (!kunit_has_printed_tap_version) {
> > +               kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > +               kunit_has_printed_tap_version = true;
> > +       }
> > +}
> > +
> [...]
> > +
> > +static bool kunit_module_has_succeeded(struct kunit_module *module)
> > +{
> > +       const struct kunit_case *test_case;
> > +       bool success = true;
> > +
> > +       for (test_case = module->test_cases; test_case->run_case; test_case++)
> > +               if (!test_case->success) {
> > +                       success = false;
> > +                       break;
>
> Why not 'return false'?

Also a good point. Will fix.

> > +               }
> > +
> > +       return success;
>
> And 'return true'?

Will fix.

> > +}
> > +
> > +static size_t kunit_module_counter = 1;
> > +
> > +static void kunit_print_subtest_end(struct kunit_module *module)
> > +{
> > +       kunit_print_ok_not_ok(false,
> > +                             kunit_module_has_succeeded(module),
> > +                             kunit_module_counter++,
> > +                             module->name);
> > +}
> > +
> > +static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> > +                                           size_t test_number)
> > +{
> > +       kunit_print_ok_not_ok(true,
> > +                             test_case->success,
> > +                             test_number,
> > +                             test_case->name);
> > +}
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       spin_lock_init(&test->lock);
> > +       test->name = name;
> > +       test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +       int ret = 0;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +
> > +       if (module->init) {
> > +               ret = module->init(&test);
> > +               if (ret) {
> > +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_success(&test, false);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       if (!ret)
> > +               test_case->run_case(&test);
>
> Do we need this if condition? ret can only be set to non-zero above but
> then we'll exit the function early so it seems unnecessary. Given that,
> ret should probably be moved into the module->init path.

Whoops. Sorry, another instance of how it evolved over time and I
forgot why I did the check. Will fix.

> > +
> > +       if (module->exit)
> > +               module->exit(&test);
> > +
> > +       test_case->success = kunit_get_success(&test);
> > +}
> > +

Thanks!
