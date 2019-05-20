Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D80C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DE320862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFj3iaOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfETXYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:24:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfETXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:24:10 -0400
Received: by mail-it1-f195.google.com with SMTP id i10so1909437ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFHn2CqQ9gIGiCfwRIFED96/AC2yUgVp/k9gB9+r5g4=;
        b=OFj3iaOZ5a55OcwXkN+86bx61mb+3FqV2wabBSAGzwE20pCc5qkwj979pSL5Gslifl
         +iC/scKSpjmt8kaeRFV4EJ9dYJKeqD81EfLeDod9dCRscurIAo70YjYptk7/+jOJeyHl
         fB+eF4eIDyqqsvSOdHhKqOOVUWMHZqTcKvpGq5Iw2Ghf8Pg3bPuGyFN1RB9seQJYAdnw
         lD5mV5SHQLVWxTPf/DCac7OXGY7ABb9CrzZXn+BuLM7MomEYpmXXQeIfOaF0LMbZQVXR
         cbLj/EqbOIg7DERQzsAUYhdBCfME8nhFD/gBBsFSTQOP0zYbj2p2a8ewhPtI/TEEjeze
         hgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFHn2CqQ9gIGiCfwRIFED96/AC2yUgVp/k9gB9+r5g4=;
        b=eL1HZhlXsZW0MU6PjbXqZwocVNQNcdNyNMR96nyhCY0jLg9z7gGHc1JwEF3uDmy2Sv
         GGHw39trrcSJQT4oeZd2h3C/8aAtOsKlHoSh+L97C3LkJEQxpRlsPW9aM4uSzjM5vFeE
         OmOCgQlaofb3bHvTfNo6/u8Iz6+LuHV6kyroXWszJLaPcNRD/uIfufezlLj3ZOa8tSIA
         NN1dSpwKMS1cTaWoGY9e3y1OL0O22YtBOi0PW74A4KocZI1bctRxDWmH9TVef20ff0fM
         XBzzXh4Aox9aCB6vvxy7x8KR2ZaE6CDzF2ub7EcLhEFJF3+blkKYxLss6Hz7q9ijD1ru
         vXrg==
X-Gm-Message-State: APjAAAWkM8Q5B5kK+rJrrH/du0XfdSattQGLH1nHPs9kXuX6CYMp1qfF
        0Qg8wOpFFoWkI5m/4HU7Bjpci2nMzT4GlG0rucWY0A==
X-Google-Smtp-Source: APXvYqxy4e7DPNMNpm9kxNQ/AJ/M2SyMLCx1E74a0FOLGrOJRBYTPEgnniKnIw0gU9OQyKwsEsfWnK6DxnfLuqNJhV0=
X-Received: by 2002:a02:ad09:: with SMTP id s9mr11578169jan.17.1558394649513;
 Mon, 20 May 2019 16:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231948.49693-1-thgarnie@chromium.org> <20190520231948.49693-3-thgarnie@chromium.org>
In-Reply-To: <20190520231948.49693-3-thgarnie@chromium.org>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Mon, 20 May 2019 16:23:58 -0700
Message-ID: <CAJcbSZEJBYOME2JqFdUxTVnb7F8uSY7PSaTDMEHf7vbEscUnbg@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] x86: Use symbol name in jump table for PIE support
To:     Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:20 PM Thomas Garnier <thgarnie@chromium.org> wrote:
>
> From: Thomas Garnier <thgarnie@google.com>
>
> Replace the %c constraint with %P. The %c is incompatible with PIE
> because it implies an immediate value whereas %P reference a symbol.
> Change the _ASM_PTR reference to .long for expected relocation size and
> add a long padding to ensure entry alignment.
>
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
>
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> ---
>  arch/x86/include/asm/jump_label.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 65191ce8e1cf..e47fad8ee632 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -25,9 +25,9 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>                 ".pushsection __jump_table,  \"aw\" \n\t"
>                 _ASM_ALIGN "\n\t"
>                 ".long 1b - ., %l[l_yes] - . \n\t"
> -               _ASM_PTR "%c0 + %c1 - .\n\t"
> +               _ASM_PTR "%P0 - .\n\t"
>                 ".popsection \n\t"
> -               : :  "i" (key), "i" (branch) : : l_yes);
> +               : :  "X" (&((char *)key)[branch]) : : l_yes);
>
>         return false;
>  l_yes:
> @@ -42,9 +42,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>                 ".pushsection __jump_table,  \"aw\" \n\t"
>                 _ASM_ALIGN "\n\t"
>                 ".long 1b - ., %l[l_yes] - . \n\t"
> -               _ASM_PTR "%c0 + %c1 - .\n\t"
> +               _ASM_PTR "%P0 - .\n\t"
>                 ".popsection \n\t"
> -               : :  "i" (key), "i" (branch) : : l_yes);
> +               : : "X" (&((char *)key)[branch]) : : l_yes);
>
>         return false;
>  l_yes:
> --
> 2.21.0.1020.gf2820cf01a-goog
>

Realized I forgot to address a feedback from the previous iteration on
this specific patch. Ignore it I will work to check if it can be
remove on the next iteration.


-- 
Thomas
