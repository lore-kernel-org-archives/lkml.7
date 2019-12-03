Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702F20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL7geI4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLCRyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:54:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32772 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:54:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1826318pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMR4WSw9F9B8/N0dfexGWtdZzcUtKJESett3rr24Dyo=;
        b=PL7geI4O2Fegkq9yVA+r/GhMN4DROVlNgMIuRR9dEPslr5jnEu/k2ykh47MLjQ9s4B
         A8hXLjzFm2rX9taFdenyTtLyS/xz2RqrOOdcUWfUrCem8+qIF6AxZDy0z6H3LmnqFAAC
         StlGOh8VJ+JMbnkCwYuEEBpY9NMV0mSRNzFKIvuWc8KCD4txqAHLCMN+T8OWf+F1DGEb
         Z3WlFR9nkh+yUbnN6ThV2BOHs9dp0Kd1ZqtPmgyfHH3VJQD1yNnnSBXo12EU1z3IZT8w
         +QIwtR5O+j2PjTH4oYvqBdZ2L/EOAth91+DFGmi+Faliyp013UcmyJZyuujnzD3mELTy
         tt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMR4WSw9F9B8/N0dfexGWtdZzcUtKJESett3rr24Dyo=;
        b=HKf+ZfAHHl0RKCmrx64VzvEE9UEESa7BPAcGgL4axdZtCL0eufWYZPKNfeqN/GWUvq
         /ZfOSQBJQzHTTPH9M51+cNpAdUMJJ33E665NNmOdAb8nqWPGl0NkbGzST7MFUv6IKP5c
         mKsSATVf56lFAVfViQd1ITxpB19S5ztnsM1gOCvnTS/WC4Og/kBtmLpIyO/m9w/YMgXU
         c7MRhr/b6G5gfUJcaBgr8eMlVQFyNOPFVOJFFoJlVscPU8uKvb0WYqqxr1ZdKEoDcZ18
         e1SBXNKlbd/R7VeLSH3ePcy8Xlw+REAFTgn65L18Zb/wWbJqT71+FYYo2QkBXsyF3HHm
         jeSw==
X-Gm-Message-State: APjAAAVgbD64vFzv5nGe+pxgo9/QW7vzyBlk3quty3JdoyEvyhQ/x3cy
        126kP1jrr2e1vqA/F37Vu6ykA4eaid9kmRxHM+NG0A==
X-Google-Smtp-Source: APXvYqwzA5c1dosL6azbOI6mxwJKJwVTHQFZgXh+dkZsKqQMYvUExNucuTAYkzJJB5rdeM4ynwUTKNPgznxOPpjFWnc=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr6899357pjt.131.1575395677060;
 Tue, 03 Dec 2019 09:54:37 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 09:54:25 -0800
Message-ID: <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> As tests are added to kunit, it will become less feasible to execute
> all built tests together.  By supporting modular tests we provide
> a simple way to do selective execution on a running system; specifying
>
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=m
>
> ...means we can simply "insmod example-test.ko" to run the tests.
>
> To achieve this we need to do the following:
>
> o export the required symbols in kunit
> o string-stream tests utilize non-exported symbols so for now we skip
>   building them when CONFIG_KUNIT_TEST=m.
> o support a new way of declaring test suites.  Because a module cannot
>   do multiple late_initcall()s, we provide a kunit_test_suites() macro
>   to declare multiple suites within the same module at once.
> o some test module names would have been too general ("test-test"
>   and "example-test" for kunit tests, "inode-test" for ext4 tests);
>   rename these as appropriate ("kunit-test", "kunit-example-test"
>   and "ext4-inode-test" respectively).
>
> Co-developed-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  fs/ext4/Kconfig                                    |  2 +-
>  fs/ext4/Makefile                                   |  5 ++++
>  fs/ext4/inode-test.c                               |  4 ++-
>  include/kunit/test.h                               | 35 +++++++++++++++-------
>  kernel/sysctl-test.c                               |  4 ++-
>  lib/Kconfig.debug                                  |  4 +--
>  lib/kunit/Kconfig                                  |  4 +--
>  lib/kunit/Makefile                                 | 10 +++++--
>  lib/kunit/assert.c                                 |  8 +++++
>  lib/kunit/{example-test.c => kunit-example-test.c} |  4 ++-
>  lib/kunit/{test-test.c => kunit-test.c}            |  5 ++--
>  lib/kunit/string-stream-test.c                     |  2 +-
>  lib/kunit/test.c                                   |  8 +++++
>  lib/kunit/try-catch.c                              |  2 ++
>  lib/list-test.c                                    |  4 ++-
>  15 files changed, 76 insertions(+), 25 deletions(-)
>  rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
>  rename lib/kunit/{test-test.c => kunit-test.c} (98%)

Ted, David, and Iurii, can you each review/ack for the bits that each
of you own?

Thanks for all your hard work on this Alan!
