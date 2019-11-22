Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A37C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988E020714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t13lqmTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKVJHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:07:43 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38460 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfKVJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:07:43 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so2581962qvs.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 01:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ljr/rHZhX2cKSZOMtdFMLeDFfDK4qscTIQX92Z+51jk=;
        b=t13lqmTwW8+/JGno5Gk07nvJjaKYrR5f5FQtDf/FQuBJNqezdlfd+R1Lqo6u2sCE9o
         4CJ6U0irpU617kY74B7xZ6MfT4NFdXzJ5Aw0EUiuSfdsL3YYJiaqDkPZQkqFln3hAr+6
         lCgiZ22CmSJ/IT4/cyPr5v1VE9JpkXewlPyu9Z4PtyeC27Bg7NP5nCRuFrXFM+4vDjN+
         lYMhfaePSyn/RK2K5o9jQh5HNsh/GLlmWGIHSm+zRNzhE/Tp5DvutMQPpakvtVzRP8/y
         tiF5wJv8sZCez+gaEocICDbNCXycofg3bfXYVDBPpEZ2vY+nhsQQCvPB3ztg0MX3tLjk
         808A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ljr/rHZhX2cKSZOMtdFMLeDFfDK4qscTIQX92Z+51jk=;
        b=fls7ibdZECvQfpGdhDafzJKdQz/aXc1ctNZ5W/jfZbgRVCCDwRTDTvtOpdhaZJlTOS
         BrKr2cYWMObioLYXDMb15wCOC+bvlbuVrb4JGQz3Sf2tvm3MNDoChAMByVTZ7Qq2XVV1
         B7jDH3ERDnG9BOCsgP9hVLmhY6j2kDG1PRzSTfCLeiTKhdt810X6YrXZYbA+GBUpOwQa
         /6AO/LKm2pLYgaXvUJ2lfNYNrHkfcaC/5XDq5h+jDXROCvI3EczdnjMQqH4INcZNEukE
         Mgq0W6bhE/nk+WjObZHK6mM4Ujf9ctFn2m+nvWzhnwr945NwoCwP+g/mBDlgnis+GVET
         Fojw==
X-Gm-Message-State: APjAAAX2eh97Sk3bSfL+uiy/6/2pGVeohNCyE1GU8Vh0nDI2UP5c5JU7
        KOdH9hNgZtRqpNgzV/Wfi3gkleYFfA3L+id2/1Ijtg==
X-Google-Smtp-Source: APXvYqyuNa94PLnoPGiyrEBNkcWkeo4IQevYwXNAy+9m/OTWblAYAJgbB28j4btr7t9cSrDA+LBcxyqV3jdSyfW0U6o=
X-Received: by 2002:a0c:b446:: with SMTP id e6mr12863287qvf.159.1574413661601;
 Fri, 22 Nov 2019 01:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20191121181519.28637-1-keescook@chromium.org>
In-Reply-To: <20191121181519.28637-1-keescook@chromium.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Nov 2019 10:07:29 +0100
Message-ID: <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ubsan: Split out bounds checker
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 7:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> v2:
>     - clarify Kconfig help text (aryabinin)
>     - add reviewed-by
>     - aim series at akpm, which seems to be where ubsan goes through?
> v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org
>
> This splits out the bounds checker so it can be individually used. This
> is expected to be enabled in Android and hopefully for syzbot. Includes
> LKDTM tests for behavioral corner-cases (beyond just the bounds checker).
>
> -Kees

+syzkaller mailing list

This is great!

I wanted to enable UBSAN on syzbot for a long time. And it's
_probably_ not lots of work. But it was stuck on somebody actually
dedicating some time specifically for it.
Kees, or anybody else interested, could you provide relevant configs
that (1) useful for kernel, (2) we want 100% cleanliness, (3) don't
fire all the time even without fuzzing? Anything else required to
enable UBSAN? I don't see anything. syzbot uses gcc 8.something, which
I assume should be enough (but we can upgrade if necessary).



> Kees Cook (3):
>   ubsan: Add trap instrumentation option
>   ubsan: Split "bounds" checker from other options
>   lkdtm/bugs: Add arithmetic overflow and array bounds checks
>
>  drivers/misc/lkdtm/bugs.c  | 75 ++++++++++++++++++++++++++++++++++++++
>  drivers/misc/lkdtm/core.c  |  3 ++
>  drivers/misc/lkdtm/lkdtm.h |  3 ++
>  lib/Kconfig.ubsan          | 42 +++++++++++++++++++--
>  lib/Makefile               |  2 +
>  scripts/Makefile.ubsan     | 16 ++++++--
>  6 files changed, 134 insertions(+), 7 deletions(-)
>
> --
> 2.17.1
