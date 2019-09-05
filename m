Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C6C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61141206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sESb1zCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfIEAOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:14:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35358 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIEAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:14:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so350697pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqXDsnhRAVwDuK0gKJwtjan7LRWZdWfzvhtIzVr2bFM=;
        b=sESb1zCW39GG4zVbQ+4oDeaqbZQaVItq5P1SFuwmFWeHIjmdw6qD0GQlqh6pOhlyXO
         vOBs76MHChzhDgQpuFEdXLFusLnVnGYnKbbJ/iRJeOdbK3MVZGeXr7H4tP0bF65KP8VS
         8QYYjg5/GKOOv6kWkKvpR0a4tyvs1J2GYLkbuw2fIv2bbJXfU6W7fvJ3qzvh0evVjbUA
         wWDxAGcGy5V3JrZPzrRCZP+JizVUV0s6OEjKfhmCksH6huJLsD2E8RheY1L/Ue3Wuj3v
         Zi5PKJYMqRbJd6ufwjdzeza5U+GFtpKqq8tL9RBmhz++2+6mpdXStWs8etCO567geQqQ
         c67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqXDsnhRAVwDuK0gKJwtjan7LRWZdWfzvhtIzVr2bFM=;
        b=lySidTPAPX3EmA7b2ptiIvtO838olKcje7x7eCQkNXKn7hu5RgOPJxMGU/LPQ27EIK
         jbGj5V4lMJr4AAQbC08TLa3IjIrhZA5SysF82zH6rcn1j46eBqc/ml2T7hvJar0Mhh8C
         CDAZbRU1Z+VUsTc8qRK5l4ud7urzi7Cbks+wz94G86RJhvSv3pNfLGdAX5DHN05/0wfX
         wXZCHAkT+xC03Ki83Oc0g7Bc6Xvr2UBU8Dd9Em5ybCWXGxY5UxFsvIJ9bR7zdOOC4+or
         DaWh+f4owGz/IzNinNrAIlyMBMXDoIj9oP+ezzGjoZg9zxO+0qj0hkGGk2emUn9DpIZR
         WjEg==
X-Gm-Message-State: APjAAAUQ8e/tWbllft0eI7D5gyPz/lOGxz7V7F3jiZViatySLs+xqr3a
        88n7bFgt5UozlQa7YajZxSxylqDvThKHNnsjeP47Yg==
X-Google-Smtp-Source: APXvYqwZs2PLIjSBeps3r67lUXVSbgoQrz83k9KZ1wop9wPnt2rIz4maD7yzLfIEudO1JUgSXgLgp9zK82NsPf1RmY0=
X-Received: by 2002:aa7:8481:: with SMTP id u1mr447193pfn.3.1567642444107;
 Wed, 04 Sep 2019 17:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-4-linux@rasmusvillemoes.dk>
In-Reply-To: <20190830231527.22304-4-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 17:13:53 -0700
Message-ID: <CAKwvOdn2zbRCL+L92zjjuyhj4NLLtOEWd3pjady9KyYb7PAbmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] compiler_types.h: don't #define __inline
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The spellings __inline and __inline__ should be reserved for uses
> where one really wants to refer to the inline keyword, regardless of
> whether or not the spelling "inline" has been #defined to something
> else. Due to use of __inline__ in uapi headers, we can't easily get
> rid of the definition of __inline__. However, almost all users of
> __inline has been converted to inline, so we can get rid of that
> #define.

Besides patch 1 and 2 of this series, I also see:
Documentation/trace/tracepoint-analysis.rst
318:         :      extern __inline void
__attribute__((__gnu_inline__, __always_inline__, _

scripts/kernel-doc
1574:    $prototype =~ s/^__inline +//;

>
> The exception is include/acpi/platform/acintel.h. However, that header
> is only included when using the intel compiler (does anybody actually
> build the kernel with that?), and the ACPI_INLINE macro is only used

In my effort to make the kernel slightly more compiler-portable, I
have not yet found anyone building with ICC.  I would love to be
proven wrong.  Let me go ask some of my Intel friends.

> in the definition of utterly trivial stub functions, where I doubt a

See:
include/acpi/platform/acenv.h
146 #elif defined(__INTEL_COMPILER)
147 #include <acpi/platform/acintel.h>

> small change of semantics (lack of __gnu_inline) changes anything.

include/acpi/platform/acintel.h
25:#define ACPI_INLINE                 __inline
include/acpi/platform/acgcc.h
29:#define ACPI_INLINE             __inline__

lol wut

I mean, you just would have to change that one line in
include/acpi/platform/acintel.h, right?  I'd sign off on this patch
with such a patch added to the series.

>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/compiler_types.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 599c27b56c29..ee49be6d6088 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -150,8 +150,17 @@ struct ftrace_likely_data {
>         __maybe_unused notrace
>  #endif
>
> +/*
> + * gcc provides both __inline__ and __inline as alternate spellings of
> + * the inline keyword, though the latter is undocumented. New kernel
> + * code should only use the inline spelling, but some existing code
> + * uses __inline__. Since we #define inline above, to ensure
> + * __inline__ has the same semantics, we need this #define.
> + *
> + * However, the spelling __inline is strictly reserved for referring
> + * to the bare keyword.
> + */
>  #define __inline__ inline
> -#define __inline   inline
>
>  /*
>   * Rather then using noinline to prevent stack consumption, use
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
