Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA67FC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9559120838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7jCP9O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfIKVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:02:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfIKVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:02:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so14451459pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmSGku8jGWaQdEnWgjS8EmzhMwO0vQvjKEtMVStz3ho=;
        b=o7jCP9O619jk1A8fcSgzAWayhUVzV5ZQt3XJGgqVC4Cr2Y27xwM0ppsCKWoztQnBFe
         tlxVQygRIqQmFJPuPR0h2TaKn4X28eymj7iEHy5QfNAzcyw+h1PHy6PhWu/NIY0vZMBD
         n8pKo9xFCJvpTQpvkgIwlpo9ZNi2ZaT4Bkcdn6IxwAkMN5z2jFsk2bu8EFNjZl6wMEPv
         YZC/7ZBuOj536hHif/679mreNnVxNJUZkYm1f6nUwWPEsPE5MNIzLc6w4DQkazrLePDv
         5uZcD2N56xzSI7oEnq+PfQ5t/ZsBvVzrsSMF1zLSk6B4FwV1Anb0Q3Zq6mkj+Sm0LfyE
         8ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmSGku8jGWaQdEnWgjS8EmzhMwO0vQvjKEtMVStz3ho=;
        b=bPM1U3QdDe3MAIZfv9LqEm2z8WiUQeFED0OTo8Fcq7i6pUZ9YtAk0vWPhQbWHA7ph3
         lBDnnCQOG0hvKJ4t6b9hXX4qiWQ+flVnfIwsbt5AdFVpeu4FFwKOhbuRvv915J4j076U
         OT+TSkC3gcYgZTazklBtiKTMYxwievMdhkPQ4lwcMucIiSuBXeXccVoLEh73qpycGP9p
         m4lbxb9Sg4zxfBHI0S0dB4n0+qSHZ8WuRw4xK1OuGc9/pGlBLWrQxgpRZFWExlopSq3J
         dueTEuKCxJaFDBPHqRGWoZUsCPUXiSUnXd4JHM9osVnBxokXSRpzqAGXXPtD49SuMDRu
         tp9A==
X-Gm-Message-State: APjAAAUB+m3df2jO5TVHRHp6qKA8J0Pyyqt7jAnBKYexqKzFJrSGDA3c
        ugaKtliDO3W257IFvexaZ9fG7RP1KR35V5LydcCIVg==
X-Google-Smtp-Source: APXvYqypx9sTdaUqWPw1cVmR3te2mC9wx57XFuE4p0MZXxepRD5h/5pwdXHJeHB20U1iiWL6kUo2AHVEcIsr6mTHga0=
X-Received: by 2002:a65:690b:: with SMTP id s11mr34339694pgq.10.1568235730928;
 Wed, 11 Sep 2019 14:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com> <20190911182049.77853-4-natechancellor@gmail.com>
In-Reply-To: <20190911182049.77853-4-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Sep 2019 14:01:59 -0700
Message-ID: <CAKwvOdnh+YoACaX4Oxk7ZiEQAQ2VgA6W=Dtbk7gzK5yJduFvGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:21 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> r370454 gives LLVM the ability to convert certain loops into a reference
> to bcmp as an optimization; this breaks prom_init_check.sh:
>
>   CALL    arch/powerpc/kernel/prom_init_check.sh
> Error: External symbol 'bcmp' referenced from prom_init.c
> make[2]: *** [arch/powerpc/kernel/Makefile:196: prom_init_check] Error 1
>
> bcmp is defined in lib/string.c as a wrapper for memcmp so this could be
> added to the whitelist. However, commit 450e7dd4001f ("powerpc/prom_init:
> don't use string functions from lib/") copied memcmp as prom_memcmp to
> avoid KASAN instrumentation so having bcmp be resolved to regular memcmp
> would break that assumption. Furthermore, because the compiler is the
> one that inserted bcmp, we cannot provide something like prom_bcmp.
>
> To prevent LLVM from being clever with optimizations like this, use
> -ffreestanding to tell LLVM we are not hosted so it is not free to make
> transformations like this.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/647
> Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002

The above link doesn't work for me (HTTP 404).  PEBKAC?
https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> New patch in the series so no previous version.
>
>  arch/powerpc/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 19f19c8c874b..aa78b3f6271e 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -21,7 +21,7 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>
> -CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
> +CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector) -ffreestanding
>
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early boot code
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
