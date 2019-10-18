Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08673CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81D21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsQmN/Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502024AbfJRRSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:18:53 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41963 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405285AbfJRRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:18:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id l13so1934180uap.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HIzf5D0wGbvpmxHvIyOvn+49UWE2lHPyTZCg3y02sw=;
        b=vsQmN/ApjkODa5g1BT612x/4GGL20gZVZE8EGaFhwsXbdCcFD/fycGlyho4gxOJTFH
         UNt9ub/I4P/h809X5D4yAx7rCwQfs1BEVFWXiVYtxsoUMxjlzIEJPcfVyB8tF344B2aC
         FjFd1SH8THaH/Pw81yxXP9FQn01T7I+/YsrNyL9mssL2T1CuwuFiQluKl0/fFUrg4HLq
         GlWt1dVIFhyf7eCqu7QIp5RVLWS2ZUOsoD7wzE3W1jtwUAY4NHDTbaS0+XPgu0S1K6/l
         VhJ5hk4oAgFzg9fAGqgifT4d4FsvndIJvJc42Q3EHtKExcLFN4z8Qliw6bt6wkdvd8lR
         FnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HIzf5D0wGbvpmxHvIyOvn+49UWE2lHPyTZCg3y02sw=;
        b=o5nY9p2w78LdFZgHE0oRQg52v3gaiPGxgV8bns1BX+IVs9gdwo3l3jD07/iKzc0BGS
         +e9VMLmmfaVBpQS7eTMU9L1dZ8GqJnB5eTt/eYouiNTj57DInjiM12b6Rkm3u2mzd7hu
         D37a2omtFiEJC+J6tXXg1g+y82XNJ3hv4Gevi+ObA9i0cECMZIWwcm6cvQELGKYNtykH
         +t/xcL1+QQXHMPnuRucPgIp3QPaYawWBD8WHUS68kjnG9du01YCV36IlxH3GM//NOtdt
         K413G6k5DrTX107DoOx0yQvI408KGtvDWtjGdsYKylSdkO7MOwIoPqdM1GcxOoO8x5Zd
         HNOA==
X-Gm-Message-State: APjAAAXhyEpPhbkm6caMDkgdKNxazToXohn9OfoIbk/Rex24Y3XmMlUH
        oGuo2xmZsQwTEHBpxbmOM+dMgcnDF3aBOYlmanlYeQ==
X-Google-Smtp-Source: APXvYqz95u8SOpZ8CKpbA/DJiP9eST+uXrcgaIItAAur7JD+mN8MzKVC12sI0+N58LUhcO4C5kYwuTsqYm/TbJd/HRQ=
X-Received: by 2002:ab0:6387:: with SMTP id y7mr6108565uao.110.1571419131321;
 Fri, 18 Oct 2019 10:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-19-samitolvanen@google.com> <CAG48ez2Z8=0__eoQ+Ekp=EApawZXR4ec_xd2TVPQExLoyMwtRQ@mail.gmail.com>
In-Reply-To: <CAG48ez2Z8=0__eoQ+Ekp=EApawZXR4ec_xd2TVPQExLoyMwtRQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 10:18:40 -0700
Message-ID: <CABCJKudM-Jupwj9eMMjg3rb1=6rTDBEcWi-KkzPSeSGd8tSxGg@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: implement Shadow Call Stack
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:13 AM Jann Horn <jannh@google.com> wrote:
> These things should probably be __always_inline or something like
> that? If the compiler decides not to inline them (e.g. when called
> from scs_thread_switch()), stuff will blow up, right?

Correct. I'll change these to __always_inline in v2. I think there
might be other places in the kernel where not inlining a static inline
function would break things, but there's no need to add more.

> This is different from the intended protection level according to
> <https://clang.llvm.org/docs/ShadowCallStack.html#security>, which
> talks about "a runtime that avoids exposing the address of the shadow
> call stack to attackers that can read arbitrary memory". Of course,
> that's extremely hard to implement in the context of the kernel, where
> you can see all the memory management data structures and all physical
> memory.

Yes, the security guarantees in the kernel are different as hiding
shadow stack pointers is more challenging.

> You might want to write something in the cover letter about what the
> benefits of this mechanism compared to STACKPROTECTOR are in the
> context of the kernel, including a specific description of which types
> of attacker capabilities this is supposed to defend against.

Sure, I'll add something about that in v2. Thanks.

Sami
