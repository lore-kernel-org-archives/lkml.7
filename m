Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABADA206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NcZl5aIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfKZNuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:50:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfKZNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:50:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so1452910edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=foSPG5b4GPTiNos5d2D1hghgoaS4XZmJhqxcKaf1/hY=;
        b=NcZl5aItp0okvqh8ywht5GEbFHQZpvRbSaZteZaOWnTT/+3a+lqpOUwD+y6lvbHc1+
         F2Z2YoeOlFbNXRkr+vLnML3XTByfa2aIyOkcK0G8uLGU4pVD+Hd34aEwxocvQEJ4pLxn
         a2CPLiynWbHRi3CWvIdJxAZs6uVKA+lLqEFVW2uolPSWZMwTxIJKAkFcBR7kz3aNDVzl
         KtHOYj9JRUMMIPasIqtmFYJLCsbKu59xf4XFl1EpCl8z3CSwNu9uZPH+ZC895N42pqwL
         k60YdofUhXq5ooa12uqxPihOwOLMlpzTIeJfF7lkUUyEvsHJ4Th6MvG6MR+6jjmd6M/z
         3JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=foSPG5b4GPTiNos5d2D1hghgoaS4XZmJhqxcKaf1/hY=;
        b=VEonNVMB1qEht4Is90/QBZBS4RTDG4LbvRv2MTr+s8kB6KgXk7sKInSunfLeshDN1u
         3GUPJFOjVKN0SRdeoPzWTO4qe6xa/oS1j33mEDU8ZI7vYYBfwdQ4F6FPowQwZPnj0UM/
         1Ed4yGV11RVzCj9jKtzfILmPJ5Mr6muo7gPFb7+x8IY8wCt3tjK8AtzBffesjsS4/fR6
         lvJTsmX1kWNRNpulWlZgqv1i/gjLdUHpu/hw7EJxcG8JFnUXL/lf0ICfbzTMPSXZEmyw
         EXPlGIFO9ZjaplpEp6dU7XFKZ9SybgKqzYgFIZo/MN+m4xVZ7I4QG5SvFsiUOeg5p6b5
         wwyg==
X-Gm-Message-State: APjAAAUFGFAoREXDqtlffYtUQm8prjC4cthiWnNRAfTxnY2UrWuByTXN
        1VNay22ZGcGZRnqh63ZQBnG9971UVmUk5bHIdhXsKw==
X-Google-Smtp-Source: APXvYqx/73kewLKTGG9V8bY7IVdZRVMPs089swKOBpgQRPlsJfFEGLkEpyKXCfAg+91rOQYdzSAPGhELagFggc29VvU=
X-Received: by 2002:aa7:cc0f:: with SMTP id q15mr24919188edt.71.1574776253232;
 Tue, 26 Nov 2019 05:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
In-Reply-To: <20191122022406.590141-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Nov 2019 08:50:42 -0500
Message-ID: <CA+CK2bCBS2fKOTmTFm13iv3u5TBPwpoCsYeeP352DVE-gs9GJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use C inlines for uaccess
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook mentioned that it is a good idea to assert the PAN state
during disable/enable. Since, with this change everything is moved to
the same C place, if this hardening is something others also want to
see, I could add it in the next revision of this series. Here are the
options to choose from:
1. Do something similar to what is done in preempt with
CONFIG_PREEMPT_COUNT:  keep a boolean (could be optionally enabled by
a config) that is checked when uaccess_enable()/uaccess_disable() are
called. This way we will always check that state even on processors
with hardware PAN and UAO, however, there is going to be this extra
overhead of checking/storing the variable on userland enter/exits even
on systems which have these marcos set to nothing otherwise.
2. Check only in __uaccess_ttbr0_disable()/__uaccess_ttbr0_enable()
that ttbr0_el1 is in the expected state, or add another boolean  for
this purpose to thread_info.
3. Keep as is, and do not add extra overhead for this hardening.

Thank you,
Pasha

On Thu, Nov 21, 2019 at 9:24 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Changelog
> v2:
>         - Addressed Russell King's concern by not adding
>           uaccess_* to ARM.
>         - Removed the accidental change to xtensa
>
> Convert the remaining uaccess_* calls from ASM macros to C inlines.
>
> These patches apply against linux-next. I boot tested ARM64, and
> compile tested ARM changes.
>
> Pavel Tatashin (3):
>   arm/arm64/xen: use C inlines for privcmd_call
>   arm64: remove uaccess_ttbr0 asm macros from cache functions
>   arm64: remove the rest of asm-uaccess.h
>
>  arch/arm/include/asm/assembler.h       |  2 +-
>  arch/arm/include/asm/xen/hypercall.h   | 10 +++++
>  arch/arm/xen/enlighten.c               |  2 +-
>  arch/arm/xen/hypercall.S               |  4 +-
>  arch/arm64/include/asm/asm-uaccess.h   | 60 --------------------------
>  arch/arm64/include/asm/cacheflush.h    | 38 ++++++++++++++--
>  arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++
>  arch/arm64/kernel/entry.S              |  6 +--
>  arch/arm64/lib/clear_user.S            |  2 +-
>  arch/arm64/lib/copy_from_user.S        |  2 +-
>  arch/arm64/lib/copy_in_user.S          |  2 +-
>  arch/arm64/lib/copy_to_user.S          |  2 +-
>  arch/arm64/mm/cache.S                  | 31 +++++--------
>  arch/arm64/mm/context.c                | 12 ++++++
>  arch/arm64/mm/flush.c                  |  2 +-
>  arch/arm64/xen/hypercall.S             | 19 +-------
>  include/xen/arm/hypercall.h            | 12 +++---
>  17 files changed, 115 insertions(+), 119 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/asm-uaccess.h
>
> --
> 2.24.0
>
