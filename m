Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0AC10F17
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B14A21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Tx+GE/ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDEEOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:14:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38845 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:14:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so5636558wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBHVrWRKGZevbfTKeXKRxI9gf6sJ5d1z7tzrVixC8Jk=;
        b=Tx+GE/kyMVuyulYFD856bWPolojQWzZWKuGBYAyKjK0wSk4YRKTXZo6o4ZTOpJgsos
         XQLvCcklGLmb66PPfiTWzUIWKIvNAVr6bC4EK1694Bit61uQlb1nNs67L+xwuxdl+PdX
         h4ivnwEstWB2XAVo/kCN4+ygPl9oCOa/pI2nucctjYQjixoE9p2B2NieLcCvq/smEOzv
         TWdJ2OrpLVzl1UGmcl93EOStMTOnOap/+WLoODhnByD6uG4l10NgxaH2EN6fKYZwp6i0
         DCLg5XXKc7J3QjtjAUdqw6/870X0w+b8BWvDHsIQYMwDs6d1as/suV81ZZ8FMq7MVqoA
         PVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBHVrWRKGZevbfTKeXKRxI9gf6sJ5d1z7tzrVixC8Jk=;
        b=GFSeHd8pO9rTHLjfK9YSQlhxgaYSaBr1cl/f38Z5yWKZ17djqR+dD36735kwyJagLj
         5dOk4y/ny7EraZJ8zsHEXLBiZAauzi8yyh1p7NqAm84FsBsgaDqhl+Zt4W0ypdqZ9ui4
         xpm+4GrL9HliSbpZOPUpQoSuveiQV70BznkqTYLqqnHYP3/mE5vmI+R6wDXs78iA9nhL
         de4aOzoqQXLzVaXXdlrsRB2+C9lQNvOZupY/w7yUzDBMInXcPxOhNhvGdZSQhkW7MsoX
         XGEkE4EvgNB3yEm9tW2TaoVGOMXH6SuhK/YLx5VjsHTcKOdpO4eNMGDxsCTiRWGFT5MQ
         UEKg==
X-Gm-Message-State: APjAAAVLYf2M5yLbIyRBC4roRDhFHJT54WXRrbJlr9jqFxQoN7upEjwR
        XPYDAARMCBNmZ3EflUy37wYf5q6uRQQfvgKpZ9Z/Pw==
X-Google-Smtp-Source: APXvYqwPwBhxwnnbbp3Ou8kLLLXWzsVJNsanwq1En96de4XmSJmraw5HwQdVPcemwbBdE1cB9aXLGHM13X9Zf6iRDW8=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr5700645wmf.97.1554437653482;
 Thu, 04 Apr 2019 21:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190403141627.11664-1-steven.price@arm.com> <20190403141627.11664-7-steven.price@arm.com>
In-Reply-To: <20190403141627.11664-7-steven.price@arm.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 5 Apr 2019 09:44:02 +0530
Message-ID: <CAAhSdy0Hz25LYwA6U0byRfbbmgorjiTUhyHs8sQ81=qvhPANrw@mail.gmail.com>
Subject: Re: [PATCH v8 06/20] riscv: mm: Add p?d_large() definitions
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:47 PM Steven Price <steven.price@arm.com> wrote:
>
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
>
> For riscv a page is large when it has a read, write or execute bit
> set on it.
>
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 7 +++++++
>  arch/riscv/include/asm/pgtable.h    | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7aa0ea9bd8bb..73747d9d7c66 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -51,6 +51,13 @@ static inline int pud_bad(pud_t pud)
>         return !pud_present(pud);
>  }
>
> +#define pud_large      pud_large
> +static inline int pud_large(pud_t pud)
> +{
> +       return pud_present(pud)
> +               && (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
>         *pudp = pud;
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 1141364d990e..9570883c79e7 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -111,6 +111,13 @@ static inline int pmd_bad(pmd_t pmd)
>         return !pmd_present(pmd);
>  }
>
> +#define pmd_large      pmd_large
> +static inline int pmd_large(pmd_t pmd)
> +{
> +       return pmd_present(pmd)
> +               && (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
>         *pmdp = pmd;
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
