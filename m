Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED04C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E832087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv95OKfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfKHCnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:43:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44340 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKHCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:43:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id f19so3112561pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7ghc5DftJ1dJAFGG7geKIMSB0XHdAtyHWb1fKQe0ss=;
        b=Fv95OKfAjhccA38qGlkswPxYWtCbR279VGUGFr3KsVCn/eHl34M0jb1TfygFNNbKIU
         T/2VlJUyJroKPpb5Ej3+4kBCXen6m2VMg1MLOCY7UsqryzvgghQJtbundVmCHiTwgpgh
         VAQBdzwux0qEv+PPvtJMAwzXVOdZtTL+k4C8PKwczU89em4WnzfIP8ZIFneVHYmeL+D+
         ukumFNfa2FdVQT5y7CAPZNxYerq+Afvl3uHth9Zdf7pqWBrDzPT9UcWfeqhUqRx/PPTo
         gYkK2dPXgOQXh6YwUDpBIwuXkbynry9MYsY+IPXEV3gHjaQ3t6C0GgaUL1AfgY0fJQAP
         Rinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7ghc5DftJ1dJAFGG7geKIMSB0XHdAtyHWb1fKQe0ss=;
        b=t3ogR4GyldefAnvk5dEYiadfa9f7eMAklEuE+yeRrXwRR9aDA24OUqRmp6jzGBnFlZ
         VIVACwKUpe8n8C6Lc02paeqYJ2Gf1rP5E4V5j4vwBq2q5/bK1M7nhJp5SJwfkwNTcv0V
         MU9h19Nf8faQGQutkdffT07Y1ZQiAP5Pe66kul0lah3onRW0BFrKG7sCN/GzaCktRx45
         9xgLe3j1cRf17QhjY41pGS/4wobOv72pvEnNOJYQ8krpRsF3cxsom9Xiwh7d1xdySbdz
         19q1whFWg4u93W/k2iXPceUIIEJPrgf4FCl0TgWOjUGUmX1u79USUp2JCvmOJNnOOzmr
         I4xw==
X-Gm-Message-State: APjAAAWPpAbyN1r94zYhQXAkXO9ThuiyQN1H2xmvQKW38PBWMvCXfeXo
        7sbCC3FFoAG933+k+5cfeUPVXRQtryVNsAY8kRmBKQ==
X-Google-Smtp-Source: APXvYqwmr0Xk5qSCk6LJsKaE68DfwybqJtqkMDQUaniWJCkpnNU/JnviODiDeYpoCijj9Q+rcus/ybCUi0qX1DpuoRs=
X-Received: by 2002:a63:234c:: with SMTP id u12mr8550073pgm.384.1573181002849;
 Thu, 07 Nov 2019 18:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 18:43:11 -0800
Message-ID: <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
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

On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  lib/kunit/Kconfig     | 2 +-
>  lib/kunit/Makefile    | 4 +++-
>  lib/kunit/test.c      | 2 ++
>  lib/kunit/try-catch.c | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 9ebd5e6..065aa16 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -3,7 +3,7 @@
>  #
>
>  menuconfig KUNIT
> -       bool "KUnit - Enable support for unit tests"
> +       tristate "KUnit - Enable support for unit tests"
>         help
>           Enables support for kernel unit tests (KUnit), a lightweight unit
>           testing and mocking framework for the Linux kernel. These tests are
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 769d940..8e2635a 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,4 +1,6 @@
> -obj-$(CONFIG_KUNIT) +=                 test.o \
> +obj-$(CONFIG_KUNIT) +=                 kunit.o
> +
> +kunit-objs +=                          test.o \
>                                         string-stream.o \
>                                         assert.o \
>                                         try-catch.o
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e8b2443..c0ace36 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
>         return ERR_PTR(-ENOENT);
>  }
>  EXPORT_SYMBOL(kunit_find_symbol);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 1c1e9af..72fc8ed 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
>         complete_and_exit(try_catch->try_completion, 0);
>  }
>
> +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);

Can you just export sysctl_hung_task_timeout_secs?

I don't mean to make you redo all this work for one symbol twice, but
I thought we agreed on just exposing this symbol, but in a namespace.
It seemed like a good use case for that namespaced exporting thing
that Luis was talking about. As I understood it, you would have to
export it in the module that defines it, and then use the new
MODULE_IMPORT_NS() macro here.

> +
>  static unsigned long kunit_test_timeout(void)
>  {
>         unsigned long timeout_msecs;
> @@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
>          * For more background on this topic, see:
>          * https://mike-bland.com/2011/11/01/small-medium-large.html
>          */
> +       KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
>         if (sysctl_hung_task_timeout_secs) {
>                 /*
>                  * If sysctl_hung_task is active, just set the timeout to some
> --
> 1.8.3.1
>
