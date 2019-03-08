Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32928C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7F120675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqVNBM8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCHAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:53:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41131 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHAxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:53:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so12790120pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8W6S5iKr39raBNq/4dv8BZFgICTQEd0B5KANeyo3u38=;
        b=EqVNBM8fGEMge6t54wxaY9vdhLXm1vmOAdmhs7WDTsXOq29NY69Qe6SKLe3eqKn2pk
         wLO6wOZ/Mhy8Rw2mpDYZXoJNp3kiFUiV8SjMIzHG30wjQArilfh1BvCKDlvWc6np1xA7
         /cW5jtishUmU3L74bYAIaPNFqBR99C/2l7CicrtP7/8qxeri2dsL7nnsVf7InIOao5vG
         XjJJpjlaliYpT1I8H0sbuRE5dSwhHGGW8J0oeCXNVM6jYAukejXjZUX2kYVj7u4ipa1M
         gNM+qv0NScP08FhkSdXX4zUPZgcsRtJzc26/lP5L2rEZ0Ear81FIA9sbkQgQZiTpLJma
         rtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8W6S5iKr39raBNq/4dv8BZFgICTQEd0B5KANeyo3u38=;
        b=DxpImExgpN1KrVia9D3XCx1M++jRlU+yoFQn4PERd5lTXwen/IR8HaSaXFfxRD9mJO
         5zbwVaZaXSXaxsL+Ev0DmgM6/bg65kkfKvbG61KipRefMy7igc1Q5fch4XGkaqoT5Wdf
         Tp/Ds6tTXdYlsVH6HT1qyTW8Ig43hLdF2px7e9XmANYfQXCVmPxvD0PR+lmdYuHz04Qk
         wYg2iT4doDp7TvDL4/WjKbasPsXab60HU1QSQqGKrYp+xP0l91sSDhA1RqIKCYZu4EZo
         y3c4rPbmkCF7Bvkoa6duZMunSHUZilg54ZiBSquEMMiJ1B0bGxVRlB5yRbcvqOhZlffg
         GLJg==
X-Gm-Message-State: APjAAAX7kAisaZDuiM+MRHE8KslAggyiucDKPoJZldB8ampMYLWdWFMe
        rujzcwGBvU6Bq8oL4abLCXbj6wJQ1rMeGTQS6G8XcA==
X-Google-Smtp-Source: APXvYqxkqcq5o99GKkBedBLeP3OHsuzgv8cX2ClW3j6Cis6vXxBqdhiiM0sEoFTPM8yTQ3bBz+2Ofomb5WgfCZti4UE=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr13462963pga.225.1552006425266;
 Thu, 07 Mar 2019 16:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20190307212756.4648-1-natechancellor@gmail.com>
In-Reply-To: <20190307212756.4648-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:53:34 -0800
Message-ID: <CAKwvOdkjoavonG0siOmUq4X-Qngvkn3JHcQ3Hee_h2wJ1AZjeg@mail.gmail.com>
Subject: Re: [PATCH] x86/hw_breakpoints: Return -EINVAL in default case in hw_breakpoint_arch_parse
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> arch/x86/kernel/hw_breakpoint.c:355:2: warning: variable 'align' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>
> It's not wrong but we can see that arch_build_bp_info will only ever
> initialize hw->len to one of the specified switch cases. We can easily
> silence Clang by just returning -EINVAL in the default case so that we
> can never use align without initializing it first.

And the call site just bubbles up return codes anyways.  Thanks for sending.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/392
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/x86/kernel/hw_breakpoint.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index ff9bfd40429e..d73083021002 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -354,6 +354,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  #endif
>         default:
>                 WARN_ON_ONCE(1);
> +               return -EINVAL;
>         }
>
>         /*
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
