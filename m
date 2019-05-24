Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797DC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFEA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpMoa01N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbfEXQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:07:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33425 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389888AbfEXQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:07:22 -0400
Received: by mail-it1-f193.google.com with SMTP id j17so11368795itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F51aUjlAcqEydtw/abs3ans4pwxkW6lbFz/6ZM6GbTY=;
        b=qpMoa01Nr6q98RY9URswE31bXIom/0XVP8pqvsALmpMM+lROv9SlDc/sFfcFS9f+lb
         7NSkiPcVnyTEWYQgvqGTDVilgbIM+pxgO5gSWljvE8YzbuTIXsajSA3nRpgSwfTeWKl/
         2Sv8jFS0JOZ/6D7nKvCzZYm0eGDkRRdpwU6E6qsMMcn9bS+jeZByzO+H+9nJSpuHY0N8
         YjwSNbcjr1ZfxRSMaSq8UrGeP4ksjiqynFtkLWPrn8A/KdYUSBJZ0Pww0ha7dx1ILssU
         pXYrVHaxp+WZvevnABkNklvmiy0gaYvXAh54CaS5Exs9uMvu49yNQGejtfSEg9fkAlxn
         TQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F51aUjlAcqEydtw/abs3ans4pwxkW6lbFz/6ZM6GbTY=;
        b=BIpA1Av/ex3oA4otD8W2OB2cCFwTn58ChDCBup1t5sZOdCCLRi/D0meMoRhMUSieqX
         +dYDd0EUUhzqNAIv92nxsgWUxpBaIp/4oxgLeUVtD2x419GTK4HLJNeQKNc9ItMUtzNC
         LjO9eNbX55AkfBoyPL4z5sBuq2R4ZOrf+7zgndTuPgLrPRhd28zVufbZ/UycLVAuyBlj
         ZOon4wWaHydTvMb2UkeuSItd7S2Rl3BhMXPLAS7F0ewuO43ilbyq2nzcJLX/G5MCR6yc
         SXbFfVONp/ymYsjQ/T94Wm4hPtlwY77wgq2ZOwAlbxHCTkDZRXJS2srkV8jKtj/25Ohw
         b6KA==
X-Gm-Message-State: APjAAAUeU8W7YD1WI6MpiqSWMD1AJ0pJdNz7Svl4AG13Y1+pb3vMxgOY
        bTUnLvxs6uZxbSdxupKRI3DdEfhmCewDDhO2nzz8ZA==
X-Google-Smtp-Source: APXvYqwWGKSkuIwcjfo3DOKE37Iaan3beO3UWxqHzJZRo2ZSSoO3FCyCbj6drihvINLMWgP9KLmQfsYCCKGIkYN8qU0=
X-Received: by 2002:a02:a494:: with SMTP id d20mr4001601jam.62.1558714042097;
 Fri, 24 May 2019 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ> <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ>
In-Reply-To: <20190523005133.GA14881@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 May 2019 18:07:10 +0200
Message-ID: <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 at 02:51, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In efi_call_phys_prolog(), save_pgd is allocated by kmalloc_array().
> And it is dereferenced in the following codes. However, memory
> allocation functions such as kmalloc_array() may fail. Dereferencing
> this save_pgd null pointer may cause the kernel go wrong. Thus we
> should check this allocation.
> Further, if efi_call_phys_prolog() returns NULL, we should abort the
> process in phys_efi_set_virtual_address_map(), and return EFI_ABORTED.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>
> ---
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e1cb01a..a7189a3 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
>         pgd_t *save_pgd;
>
>         save_pgd = efi_call_phys_prolog();
> +       if (!save_pgd)
> +               return EFI_ABORTED;
>
>         /* Disable interrupts around EFI calls: */
>         local_irq_save(flags);
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index cf0347f..828460a 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
>
>         n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
>         save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
> +       if (!save_pgd)
> +               return NULL;
>
>         /*
>          * Build 1:1 identity mapping for efi=old_map usage. Note that
> ---

Apologies for only spotting this now, but I seem to have given some bad advice.

efi_call_phys_prolog() in efi_64.c will also return NULL if
(!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
that occurrence has to be updated: please return efi_mm.pgd instead.
