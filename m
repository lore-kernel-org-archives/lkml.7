Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52915C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E32168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cbrof+o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfJAVPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:15:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46422 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfJAVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:15:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so10543133pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yR6QAZIxj8BdIeH4VEqiELW6WVoCInWCfl/pknlmVH8=;
        b=Cbrof+o7xQMSQzUqDCjJtyBcCMDho4aZq6hwUAtaTOjTav6YBWsvLsybyIF7pJrQE2
         3RDkJEmIIt4UwCQB8fcHpthXCVDR2mCgh1wLFIvjqDLv1JfkOCUkoAuxme/5NAWbuIr8
         QcJ0UXf6ULrsqNQnqIyQ0ynM1bZH66pqhvA3k5P55JBr1ixxjd56695Ebq1kzO8Y4HhV
         o+ulfcF9V8D3Qi/mfSHCa8fLgCuyMeCMQsx7ZTaNlyP8+pFdiBB9aAFSav9msBTEjF0V
         0DKg+zS1LWsqMV2mQ1eFPz0Id4BrMCHvModm//fi6RnVbEdl6XWeb7bvzprVNAeF0Po4
         QqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yR6QAZIxj8BdIeH4VEqiELW6WVoCInWCfl/pknlmVH8=;
        b=BldQ6az3MwVDxCkRB6hQXwD4s7/2j285skQW6N2drQ5VOtTvkFs/VPTsN7URd0l90o
         5O/ww1Xnru6FQkvLaPc0W0FXCemdUHVnLHqgCasy1xNQwxrI5ZXq6MEEcOySgprv+fNM
         iuShgX+Qzw505te72MkkA4FMJmhesgAR1brvEnfbbL1mpiR6HObh0JszjUH/4xVql0yI
         scNYBKroAjqMECcOt0t+7TqRzM/yLYOhZmVlTmehBhpRWTiEBBuwgQNZosdaVSHVfncm
         2kuBmTnNv090/IoS9no1MoOFVopUi8Wmxd2+aUlA6GuEKTp/KCljl9DSR+KjyDG2udkT
         UpZg==
X-Gm-Message-State: APjAAAVPHdtxdNqAw+se/82tXPLV/pWZdBThgoHyHAFFQNlahTRWHHke
        0LmkEN437C6hYCaMmTgzLaHJ8qroJU3OhD/OJpILrw==
X-Google-Smtp-Source: APXvYqzDWPq3DdNtP1kUX8M+8ZtaNw+IASQVrJxtDiR+3uaM88dckEtaAid4msBLhBdfsNTTyvkHfDjpKHCrEOJDLgM=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr212343pja.73.1569964498583;
 Tue, 01 Oct 2019 14:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com> <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
In-Reply-To: <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 14:14:46 -0700
Message-ID: <CAKwvOdm1=9Gbia=9k1f=Vgu_QUSnmM8eKr0KkKOH6zifqtk+qA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 2:06 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 10:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > 1. is clearly the most common case, but there is also
> >
> > 4. Some compiler version (possibly long gone, possibly still current)
> > makes bad inlining decisions that result in horrible but functionally
> > correct object code for a particular function, and forcing a function to
> > be inlined results in what we had expected the compiler to do already.
>
> There is also 5. code that does not even compile without it, e.g.
> _static_cpu_has() in x86_64 which requires
> __attribute__((always_inline)), at least on GCC 9.2.

I assert that's just another case of 2, and should be investigated. (I
think I remember that from when I had to teach LLVM how to inline asm
goto; since the compiler can reject inlining if it doesn't know how to
do such a transform).

>
> For x64_64 it is the only one case I found, though. If you disable
> __always_inline everything else compiles and links (in a defconfig).

Cool, so one bug in arm32, one bug in arm64, one bug in x86_64.
Doesn't sound like too much work to fix.
-- 
Thanks,
~Nick Desaulniers
