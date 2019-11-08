Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6238BC5DF61
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C022178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpfs89d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfKHBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:01:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHBB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:01:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so3028380pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8KhhIw9wq8fHDXSkpjCYpeDGqoOXr5BaNSyJb4i1mw=;
        b=Qpfs89d6fGcAFlekrUchama1AOuf5E4/QFpqPa2Xu9VaH7nkStcbpFX0g35zV+/Qw3
         GG7hFj49xatpbD98pPA9mcqSvzX2oOTlCzHMOgiguqm+dR8x9eqsOveK96MPVNC+A6kJ
         hRG7o0M8rBL2eLTYwuLc4Ng13+ZurItZHK3BW+wW46UQKi9RjHr6wTq3kExkdfBqsJDo
         dlk41x1XS073gg0eXTtzwSPTRLAhXA2qAaHrAM5Bddpw1TurCg5ra4ooRLVq91ZslgbX
         vbnVkwBIY2/2YL6VEmbdu0XYMXM14RPoPjxr0Skn7MtKsNr6ZdZzJmzCsVQyz220p1BG
         K0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8KhhIw9wq8fHDXSkpjCYpeDGqoOXr5BaNSyJb4i1mw=;
        b=ZkHIylA0J53NhRdeDA85LenYUIw3TaGj9F7WHAHroAfxmBMSIb9F12lLqzJp/pmSY/
         ieY6dEowb5WgfYM52U7ZIDfPpOQOmyF9p/FgAUwCzED6bwZEczgNVckwDlZlR7YhbTkA
         KWbKRR7Qx3lKAfiAt9pRV9TlIAIg7NvNmtk1q72SqooLqk2MAfpu/CzNmeInXaCctg+J
         k+aTLu+sLFOqE5MzvejtqnHc5xX/iljf6B9ZSnCgqFhRhrsc4yqiJOqiWp4v+bijjI03
         KcvTETEee46kWFwabgyIohSMu80utkUSROPRKkbFm1b9HCWucdONVYTX/7nPo9uRPRLW
         x42w==
X-Gm-Message-State: APjAAAWJ6pyBLpHttMxRKSABLU2AqbBseTqQvoMke6StxUFccortd+oy
        L/rA0R8cBc+M+t56clQ7UbkJe7tsPvnDrzS7823pRg==
X-Google-Smtp-Source: APXvYqyEgA8OqDaIdwEFVYc8KM0pSI9cIteIbXHyrzPaQ1d//xnKzVkvWRu4f3RpzZmU//TpVWQgTHPQR5i2uFe3ypA=
X-Received: by 2002:a63:4721:: with SMTP id u33mr8418057pga.159.1573174917129;
 Thu, 07 Nov 2019 17:01:57 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 17:01:46 -0800
Message-ID: <CAFd5g47WvXH9HKVumejWhUGtn5KL-XroTyskUs0rt5jqonfKRA@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 1/6] kunit: move string-stream.h
 to lib/kunit/string-stream-impl.h
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

On Thu, Oct 17, 2019 at 11:07 AM Alan Maguire <alan.maguire@oracle.com> wrote:

Sorry for taking so long to get to this.

> string stream interfaces are not intended for external use;
> move them from include/kunit to lib/kunit/string-stream-impl.h accordingly.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  include/kunit/assert.h         |  3 ++-
>  include/kunit/string-stream.h  | 51 ------------------------------------------
>  lib/kunit/assert.c             |  1 +
>  lib/kunit/string-stream-impl.h | 51 ++++++++++++++++++++++++++++++++++++++++++

I agree with the move of string-stream.h from include/kunit/ to
lib/kunit/, but can you keep the name string-stream.h?
string-stream-impl.h seems a little wonky to me. Otherwise, this patch
looks good to me.

>  lib/kunit/string-stream-test.c |  2 +-
>  lib/kunit/string-stream.c      |  3 ++-
>  lib/kunit/test.c               |  1 +
>  7 files changed, 58 insertions(+), 54 deletions(-)
>  delete mode 100644 include/kunit/string-stream.h
>  create mode 100644 lib/kunit/string-stream-impl.h
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index db6a0fc..ad889b5 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -9,10 +9,11 @@
>  #ifndef _KUNIT_ASSERT_H
>  #define _KUNIT_ASSERT_H
>
> -#include <kunit/string-stream.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
>
>  struct kunit;
> +struct string_stream;
>
>  /**
>   * enum kunit_assert_type - Type of expectation/assertion.
[...]
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 86013d4..d8ae94e 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -6,6 +6,7 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  #include <kunit/assert.h>
> +#include "string-stream-impl.h"
>
>  void kunit_base_assert_format(const struct kunit_assert *assert,
>                               struct string_stream *stream)
[...]
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 76cc05e..25b2cf3 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -6,9 +6,9 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> -#include <kunit/string-stream.h>
>  #include <kunit/test.h>
>  #include <linux/slab.h>
> +#include "string-stream-impl.h"
>
>  static void string_stream_test_empty_on_creation(struct kunit *test)
>  {
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index e6d17aa..a1e005d 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -6,11 +6,12 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> -#include <kunit/string-stream.h>
>  #include <kunit/test.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
>

very minor nit: Here you put a space in the include list, elsewhere
you did not. I don't really care whether you do put the space in or
you don't (I have a slight preference for the extra space as you have
done here), but I do think it would be better if we remain consistent.

> +#include "string-stream-impl.h"
> +
>  struct string_stream_fragment_alloc_context {
>         struct kunit *test;
>         int len;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c83c0fa..017d4fb 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -10,6 +10,7 @@
>  #include <kunit/try-catch.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/debug.h>
> +#include "string-stream-impl.h"
>
>  static void kunit_set_failure(struct kunit *test)
>  {
> --
> 1.8.3.1
>
