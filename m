Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F1BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3532064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCGPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:38:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34566 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfCGPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:38:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so17554111qtc.1;
        Thu, 07 Mar 2019 07:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkXGilJKTSdO40PgePMAV7Pj8MUYdEkZ8wYhenCp+lw=;
        b=jbE17J4pqBSbTdr8RUejvUCY58RamvW8NBWJrY+wyQDPT3SjKUmJnbU6kJ7hpEmFOc
         apEerpP/jCDQNNlltC79PC5BaxdbSbFa3hv/eciYXoUZVr6oM5L7FzjGYj9XpFyz/sPO
         sy/u1BT9UApZ4lHkmWjF9UX6VjzWlCXfrg7znqt+uu/Zdj3eLXQ9DUv4/ctTBMhX5xsN
         +zFmdmq7wSxvQJzpBKhM+tPUfggPIg1f1xUmLFhGp3UOhHRYddnaSZoUg4JUW8l6MwIp
         c1EGT4IP7/gZmQ4nE9tCPjr9VGNYfAkuSM1/C4KVgNIxpx9MWYYcDd6Xo5N8nFsaMFAM
         rLtg==
X-Gm-Message-State: APjAAAWzRhKPG3FUTjqp8YRjPqwOnATnIOfqGbrplPFV+/SRhSelx8R3
        Xkj7rbR8xUyrx7NZxIWhNrrKclA+bnMCVXWtHaw=
X-Google-Smtp-Source: APXvYqz0Y7a0DUFsdJKB7R6zj7SgorZ08vC5y3TlZm3XZjpfXKIZ68TRH2JkMGuRfpB5i0Kg9a2OytUlEc+/XiS4AVM=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr11295988qve.115.1551973081153;
 Thu, 07 Mar 2019 07:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
In-Reply-To: <20190307152805.GA25101@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:37:42 +0100
Message-ID: <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 03/07, Arnd Bergmann wrote:
> >
> > clang warns about the sigset_t manipulating functions (sigaddset, sigdelset,
> > sigisemptyset, ...) because it performs semantic analysis before discarding
> > dead code, unlike gcc that does this in the reverse order.
> >
> > The result is a long list of warnings like:
> >
> > In file included from arch/arm64/include/asm/ftrace.h:21:
> > include/linux/compat.h:489:10: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
> >         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
>
> stupid question... I have no idea if this can work or not, but may be we can just do
>
>         --- x/Makefile
>         +++ x/Makefile
>         @@ -701,6 +701,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-Qun
>          KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
>          KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>          KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>         +KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
>          # Quiet clang warning: comparison of unsigned expression < 0 is always false
>          KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
>          # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
>
> ?

I would definitely not go that far, since the warning is generally
rather useful,
but we could try something more localized

__diag_push();
__diag_ignore(clang, 7, "-Warray-bounds");
...
__diag_pop();

> > I turn the nice switch()/case statements
> > into preprocessor conditionals, and where that is not possible, use the
> > '%' operator
>
> I can't say what looks worse... to me it would be either use ifdef's or %'s
> everywhere in signal.h, with this patch the code doesn't look consistent.
> But I won't insist.

I tried using just #ifdefs, but that did not work inside of macros.
We could use % everywhere, or possible wrap it inside of another
macro.

        Arnd
