Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F3C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857112070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6C39yJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfE0GhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:37:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43752 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfE0GhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:37:13 -0400
Received: by mail-io1-f66.google.com with SMTP id v7so12376669iob.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cz7k1/aeSQ6lJUhf4TTaRHWZVKKDJPrc6XkqBmFtX7k=;
        b=V6C39yJsgqp/vjEMFFVpBIYO4PxHfZocoyIdPwbRZ0a0w5U+7nPxv26SGypFYPKA1I
         c4XyGHAwj53O81+eGxtSc0y0Dp5C4fWKpzSy3041fX5p/KygS0WlDwSg2sEy76973qO2
         3R61loH1NA7IrnRzHFw8DMTB7A1ReXdoDoJDu0fzeTDD5bbLApUFddm16iEEXA0izpAE
         Ji2HlIfo7zURW3MzEyA8Qjid9v+PeXSKCRRy0wcyijJJ2gpoAiBPcXZVphnm4r/YFZht
         8GwWGfSqdiqDpV5cS0I6QPneIHoHUrL0eY8LT6I2Dd5d0tW328A1+C1zLyr/TI7tZdLv
         IeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cz7k1/aeSQ6lJUhf4TTaRHWZVKKDJPrc6XkqBmFtX7k=;
        b=eJJGPl7EEHTa0JbwfYkp759lvzv/fgQfY4Rmyh5vppRFlQi3V6XZscD0Ry8+B1IbNN
         fW+QK24YTUj+kpmTxqykrTGy7E//Arhr5YF7GZ0fui9WrJd5rhuDqyf9sjL31VcHLsNs
         C07npGxs2tfLo0/B20Tx1jLPltoUDnM0iuDp4UofQaj1wBjCSlaB5I5/pWQYSqIBzYpK
         m6m2mGwM8gOkRgxDGA10EKH2gZyDeb9tFeZ/hP/GD8P55KOVh0WDimERlfb3aXQSK51B
         rPoY7afzz+vkQzK1U3EfvzFdN6ZwMlj9GXgsKHAKr47JW+cwac/BHqTDyUyZUmAWVJab
         0EbA==
X-Gm-Message-State: APjAAAXyJ02CIbXqPL27Kb8WLvQ1pjai54TDJjwxS+phcv89aht4RE5U
        sXEKoPsekqdCD9BXoJcj2WUEpKxzT2ZCP7FANeUvcQ==
X-Google-Smtp-Source: APXvYqw2S0/3fnhssdZXUSPEvVyN98EsCdtKhEBQcJ6SoNNMaQ/TvElmw7BkQdY8sm55Mo53z3sVsDO2+OyUclDLg0s=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr34583348ion.49.1558939032282;
 Sun, 26 May 2019 23:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <1558929734-20051-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1558929734-20051-1-git-send-email-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 27 May 2019 08:37:00 +0200
Message-ID: <CAKv+Gu-OSkPWUACCt=hzQJbbNArjYzt_nyYXit-oMOZy8t3fTQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Drop BUG_ON() from [pmd|pud]_set_huge()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 at 06:02, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> There are no callers for the functions which will pass unaligned physical
> addresses. Hence just drop these BUG_ON() checks which are not required.
>

This might change in the future, right? Should we perhaps switch to
VM_BUG_ON() instead so they get compiled out unless CONFIG_VM_DEBUG is
enabled?

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 22c2e4f0768f..629011c6238d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -978,7 +978,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>                                    pud_val(new_pud)))
>                 return 0;
>
> -       BUG_ON(phys & ~PUD_MASK);
>         set_pud(pudp, new_pud);
>         return 1;
>  }
> @@ -992,7 +991,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>                                    pmd_val(new_pmd)))
>                 return 0;
>
> -       BUG_ON(phys & ~PMD_MASK);
>         set_pmd(pmdp, new_pmd);
>         return 1;
>  }
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
