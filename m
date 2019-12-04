Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F963C43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315142080A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU3RI8Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLDAzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:55:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39945 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLDAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:55:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so6416915wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 16:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2Azc16Vw4ryTYqh29ZhrpRERgOlPUdv16uA7Ge2ox4=;
        b=oU3RI8RuGAnLzan6JzZGxTOz1LeLVBDqbni8Ea82NabY23NmjsmEKWvosJld0Nya7e
         yNhnapLfvI+dxZ93IOdQFMvKBH0/NUoAimXLZGhjxTCOVKOFjIFNZ1sqJQXHiiL0SN2A
         lyYssl2AANQxxbHpV+pxJv0U/m1euUdsRGRbveXcXt1DX9p0a66xfME1bfdZYMbNk+DW
         ElCWJ1pO4V469mxDQQhr+WcZpCyMt0GMQWRWYdw+Lgl2URh0IUewq6cfBFmfqYyzEyyE
         mfwaWFcZ2+Y0DZK3Qv257QkcYKvd/KrS1AimIrlpa667CinHXdgaR/nW/cCWdHzI1CmZ
         0bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2Azc16Vw4ryTYqh29ZhrpRERgOlPUdv16uA7Ge2ox4=;
        b=FRcMlKrLvfsa9SsUO1jBSOnjs2qYL+BoxxTZkDV3IcnNWgYMWKkNtASDB8xOgkw5sK
         0t0zLc6QJEscr3GzywuYdSqU6aIbmlA8mspaYUguVxVcCDdiT+NAIH/Z4u4wDQnGQQSD
         z12qhvtUhpb42AUspb6VI1oGCLgzEnIQ7couZ1P1QmYCJnGCLgKdrUAX+UBFhjFUi51w
         CGHbtLi9cUP0CA0o/eQkts7ZMF4v5e6uRvDgOBAbzFEGhVu6XIMsSQqBsa0YKhh24sH1
         WjScFb9lPIH+B9lOjdVD9jUv1Dfl7EYuY7y9DqI6Cjtv7JzFJwypToQ4W41KqHRy+6Pr
         nMGw==
X-Gm-Message-State: APjAAAUknK8yPxD10uPTB8pvqOAVZWVAnG11EuRmdEbzhrj3oyshy6ZU
        1YSj0IDeXoPDUjZ2SbVbelwXyHa6Dg7M0kar1YNmtg==
X-Google-Smtp-Source: APXvYqwaXcNZHm6NG4ULW38X0tHXZZUc4SvPr+46VmXZB3u1NEBvvPM0cY/ZXqxxyo3blM69EXP/X9UTvUJxLArinaA=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr968333wrp.2.1575420923180;
 Tue, 03 Dec 2019 16:55:23 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 3 Dec 2019 16:55:11 -0800
Message-ID: <CABVgOSnEKQGdzdjLAuGDXMF1WB5ga-ePqmMzQhbCWP=2qiv7ew@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        tytso@mit.edu, Luis Chamberlain <mcgrof@kernel.org>,
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
> ---

Acked-by: David Gow <davidgow@google.com> # For list-test
