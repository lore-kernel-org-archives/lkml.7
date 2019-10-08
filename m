Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F35C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3F20674
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QE7I8H1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfJHX7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:59:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42073 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJHX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:59:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id m22so308246vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiU+G19i3fEefcyixdkbPWCOAivgpSzN7Ja8u7mhp4s=;
        b=QE7I8H1ytClLEzAmAS2YYlkdF1hoiVCE3mVStGP8kG9+FmYjOL+9Hh08rTQMQ6a8ed
         rwuYfh11jL7xnriEb25eLvAITjhrqNIBMHH4wofzi0DYs8fLcnWzUDProyDlmNPQvvhA
         +pzzL1mBCaIw44nkyXEyPCAJrbFp3arxtFOrOL/zWf86gsBYWF8zlmRyY3kqIfwAcfUq
         0rgmZKwq1caJ8r9POkGC0jlLWbRK8dgC84ftkyWGVvk6sun0qkTnXGGOJs/kZLykRxOU
         laqIDkxdYUD9bOnnCXdzm9GdkBJxYo0/X0CPCOB6byVOhlFIp8NX/eC3QKLd/ocVXdJh
         jjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiU+G19i3fEefcyixdkbPWCOAivgpSzN7Ja8u7mhp4s=;
        b=O5ZNrFG0lvSqy0ctYraFK3+IBRzJdsR0/MJeAWad0wPSXrL8CXgyUwDQE6tGkKsSaV
         WxTfibuFCs6LpKmQDmEgDV6mKwqpUKMvgrdYZaMjr11y4vSqg8tTh4CPS/enhPA1RR2e
         xsj4ZmuhTJJh5dscwr1QFZ42z8zwKw5F8F+/FzYW7hnFFhNI+bQu/my7CTqJhjWgiLXL
         GzgIHYXNiaoOV93vDVNW2aGzIWoF9PpjDWPKjKWbmYiBdGoYFhsL47qpzOiIK+xROs5D
         /kOFNGUTPTs10OO/ddvlIUg781vH2cCZt01hiCeIugtmIYE6bECLY2DuFW6DhMyyHwnh
         //Zg==
X-Gm-Message-State: APjAAAVpWnqBCg3bUfrzly0espfdtMMETJFgbLI6nOfJ1EDXzSHsZB0M
        7IEnGB7eVx6NZmQZ8HT6dcazFlBo5aVYvu7tMCBLTg==
X-Google-Smtp-Source: APXvYqzjSnbHv+3VVaVj9p42YpDWNesyJDQY5JYN+n1lyXgb3MxLw2c0WokEdTnFX3I0WaBVLt00BfZK8NrVibAy+30=
X-Received: by 2002:a67:ffc7:: with SMTP id w7mr268399vsq.15.1570579176908;
 Tue, 08 Oct 2019 16:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com>
 <20191008212730.185532-1-samitolvanen@google.com> <20191008233137.GL42880@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191008233137.GL42880@e119886-lin.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 8 Oct 2019 16:59:25 -0700
Message-ID: <CABCJKufHzQamE5+JtH0J4TyS05kutkty_7GwJ6w8T-szdCwHvg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 4:31 PM Andrew Murray <andrew.murray@arm.com> wrote:
> This looks good to me. I can build and boot in a model with both Clang
> (9.0.6) and GCC (7.3.1) and boot a guest without anything going bang.

Great, thank you for testing this!

> Though when I build with AS=clang, e.g.
>
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang AS=clang Image

Note that this patch only fixes issues with inline assembly, which
should at some point allow us to drop -no-integrated-as from clang
builds. I believe there are still other fixes needed before AS=clang
works.

> I get errors like this:
>
>   CC      init/main.o
> In file included from init/main.c:17:
> In file included from ./include/linux/module.h:9:
> In file included from ./include/linux/list.h:9:
> In file included from ./include/linux/kernel.h:12:
> In file included from ./include/linux/bitops.h:26:
> In file included from ./arch/arm64/include/asm/bitops.h:26:
> In file included from ./include/asm-generic/bitops/atomic.h:5:
> In file included from ./include/linux/atomic.h:7:
> In file included from ./arch/arm64/include/asm/atomic.h:16:
> In file included from ./arch/arm64/include/asm/cmpxchg.h:14:
> In file included from ./arch/arm64/include/asm/lse.h:13:
> In file included from ./include/linux/jump_label.h:117:
> ./arch/arm64/include/asm/jump_label.h:24:20: error: expected a symbol reference in '.long' directive
>                  "      .align          3                       \n\t"
>                                                                   ^
> <inline asm>:4:21: note: instantiated into assembly here
>                 .long           1b - ., "" - .
>                                            ^
>
> I'm assuming that I'm doing something wrong?

No, this particular issue will be fixed in clang 10:
https://github.com/ClangBuiltLinux/linux/issues/500

Sami
