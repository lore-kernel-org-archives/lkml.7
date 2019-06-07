Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B11C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C085208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSmDgj/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfFGJoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:44:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45478 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfFGJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:44:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so975590oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SDwCL8ynt08bvLIbUkukhDwVZ2Lp8wrEvUT6aIHtho=;
        b=sSmDgj/netUoTayQS/G0n32VJ2yGicr7nD4lLeAJvhZKap+GB+aiknebS4oYPh/LcA
         rg1Uib01OFHv8TzKv+0IGIZ9JBFYe/NH5utLNF617EAy+hhrNHky+Z4XV2RWwG+D+3+J
         0qPAid+SzBF2sE0FAnkwvTZFv5k7o/KvcXmW1KXfyVDtqOm3RlitHnv3uDQiGXmsMQJO
         nrEApB2ia7hdP/3xjfeXcNf59r/NmEY6uMq7Wqh4YK3tBMx7LA4ObEH5usOs2QhkZVSo
         r37vEUoP7K6lbuuw494nSdW2nRGusQdvwDbzh3NzXLD2w39odZbHB2we1UTeVKSK2zvI
         2QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SDwCL8ynt08bvLIbUkukhDwVZ2Lp8wrEvUT6aIHtho=;
        b=ACEhl1gjTyimuc7sFnLIyGPR8+T2LFyDijYsf665Px3gQVoFYC3MUptKgPEMdAEdIe
         W2u0b/ORfoFGjnKJZJ4zpVYvEkg6cQ+4b8eQ40KV7bMYetidiIrAUyoae5pSh1Ywy2+x
         ndroACd0+yqYC/RcX0ccYSoQkNzgtIpPrCoOtGr9OhkEhZHop78F+I9IEfi8ODoP2Lkx
         cDNVAyrOSUa2Yx29BZOilnwIE4MjEiC5RX7fdAzSzzmNylJwxZHpFvi/SrHHE9tznsen
         1yO3uPx7nfr9x38vtO4ZweCgD5saVciGSiEhpx88G/nWr2g1xYd5gsh1UVLmcCcBwptH
         w6Gw==
X-Gm-Message-State: APjAAAUzKNWFWcD2wQAOqD7n1Y50RS+tWnov7E2A/HPGNqA/KD9AvBAk
        ENEQFf1/mrupxNOtNs7eGOTzhbX8Jri6C2DPouDeaQ==
X-Google-Smtp-Source: APXvYqyUnV95DjtunF7kRqhGq1TUW8NOTsRdj2Mmp2QLEwJTq7h5znkLAqfxXgHu45yWlnL8XVsRJeON5peA1ihRegE=
X-Received: by 2002:aca:e044:: with SMTP id x65mr3104140oig.70.1559900642006;
 Fri, 07 Jun 2019 02:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190531150828.157832-1-elver@google.com> <20190531150828.157832-3-elver@google.com>
In-Reply-To: <20190531150828.157832-3-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Jun 2019 11:43:50 +0200
Message-ID: <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.  I would appreciate quick feedback if this approach is reasonable.

Peter: since you suggested that we should not change objtool, did you
have a particular approach in mind that is maybe different from v2 and
v3? Or is this what you were thinking of?

Many thanks!

On Fri, 31 May 2019 at 17:11, Marco Elver <elver@google.com> wrote:
>
> This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> test_bit inside the uaccess region. With instrumentation, the KASAN
> check would otherwise be flagged by objtool.
>
> For consistency, kernel/signal.c was changed to mirror this change,
> however, is never instrumented with KASAN (currently unsupported under
> x86 32bit).
>
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> ---
> Changes in v3:
> * Use static_cpu_has instead of moving boot_cpu_has outside uaccess
>   region.
>
> Changes in v2:
> * Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
>   whitelist'
> ---
>  arch/x86/ia32/ia32_signal.c | 2 +-
>  arch/x86/kernel/signal.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 629d1ee05599..1cee10091b9f 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
>                 put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>
>                 /* Create the ucontext.  */
> -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> +               if (static_cpu_has(X86_FEATURE_XSAVE))
>                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>                 else
>                         put_user_ex(0, &frame->uc.uc_flags);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 364813cea647..52eb1d551aed 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>                 put_user_ex(&frame->uc, &frame->puc);
>
>                 /* Create the ucontext.  */
> -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> +               if (static_cpu_has(X86_FEATURE_XSAVE))
>                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>                 else
>                         put_user_ex(0, &frame->uc.uc_flags);
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
