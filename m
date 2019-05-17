Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A647C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F70206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xlq1AsNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfEQIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:41:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56318 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfEQIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:41:40 -0400
Received: by mail-it1-f195.google.com with SMTP id q132so10658225itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzAD5c2YizDdXZbA4lFyJqsN3eVyddIrW3Cl6aBVZRg=;
        b=Xlq1AsNGys96BcJAGk3jRBqqXiqDnK5XJM67Eue97/ry1AF7IBdBuiWHQqQt8ybR72
         turN3fd11DHO0M++Ig3/ByLeWYX4w6mK480OfEHBndQywtZ/KxrBuBlRHPutEkc93JQh
         wS8DPbkSd+GU+EjD5Y1YzoWf/hFXsM4Ud1ZixydW7cqiHx50m2u3ifeFFg008+JfPufC
         DciS5AmnXx6+pmy3bzhFCOOrHD+rrMVtdLUrN9JxhVVJN8M8BbM5PgLBniecKgNHiydU
         Zyl7gY5mGVtybOTP6jrLwWU/H1nIlDEh7Tf9wDJJXDETE4WxisDYJckOZLcLPNPA71H8
         Qv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzAD5c2YizDdXZbA4lFyJqsN3eVyddIrW3Cl6aBVZRg=;
        b=q/cVEXaytTVZwPISjuYnn7BWNTzQ6G552Jx1Tnfuyt68TBiGsVnFvKPAv8lm9lkNkN
         PDrYXXLN/cE7tBDKgwwAFHbOjGxNr5ZxMHWQPpH1o0mKBFpqT4agVy20ym66W2XP85cn
         c6RI0HJbCAU2nF37KMBrqD1e8epJ5SDEQM6CKMQ1H9+WTr5wnroU5lY817rjNf7qADui
         3XYaGOwv7pF/OjiGadsZ/3CZvIAVp9fLdOyh27p410JIwLffM/kSy4XOfVujV3iKrS4H
         daiOzqwIme5AZg7e7eQ5ndIqiWYH9zEUeddEpa28onEQvGro0Rm1bo2Hs/QYe3L2TvF3
         2zfg==
X-Gm-Message-State: APjAAAWgYl7YloAoMHjzE3mhV2kMOtsMB7bEZKT4CvivsHIvX+oNwdPF
        FXhbxIC4Q9iINkiOvwfIh1ucftzQgtlFk8+9yPFnZA==
X-Google-Smtp-Source: APXvYqxxG19vrc4zh9B8cysrofVDaZKTfnys80lHH5g51hp2fuu5wvhQpGmof7CNTeCpZzuD/GyqsNliegUDGmUlJpw=
X-Received: by 2002:a24:9fc5:: with SMTP id c188mr1592711ite.104.1558082499923;
 Fri, 17 May 2019 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ>
In-Reply-To: <20190517082633.GA3890@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 17 May 2019 10:41:28 +0200
Message-ID: <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
 of Linux 5.1
To:     Gen Zhang <blackgod016574@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gen,

Thanks for the patch.

On Fri, 17 May 2019 at 10:26, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> save_pgd is allocated by kmalloc_array. And it is dereferenced in the
> following codes. However, memory allocation functions such as
> kmalloc_array may fail. Dereferencing this save_pgd null pointer may
> cause the kernel go wrong. Thus we should check this allocation and add
> error handling code.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>
> ---
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index cf0347f..fb9ae57 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
>
>         n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
>         save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
> +       if (!save_pgd)
> +               goto err;
>
>         /*
>          * Build 1:1 identity mapping for efi=old_map usage. Note that
> @@ -142,6 +144,9 @@ pgd_t * __init efi_call_phys_prolog(void)
>         __flush_tlb_all();
>
>         return save_pgd;
> +err:
> +       __flush_tlb_all();

What is the point of the goto and the TLB flush?

> +       return ERR_PTR(-ENOMEM);

Returning an error here is not going to make much difference, given
that the caller of efi_call_phys_prolog() does not bother to check it,
and passes the result straight into efi_call_phys_epilog(), which
happily attempts to dereference it.

So if you want to fix this properly, please fix it at the call site as
well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
allocation though.

>  }
>
>  void __init efi_call_phys_epilog(pgd_t *save_pgd)
> ---
