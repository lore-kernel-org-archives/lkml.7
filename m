Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4A02087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9c8wTs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfCYR5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:57:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35821 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfCYR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:57:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so6966112pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0H6tmkxza/8d0+N913JHZ3De4yw9yKeqvruKlu2rc4=;
        b=D9c8wTs0NkN7Uh8lWSEvsILq9RHew5bXj8s5S7P4xFoAEVAJph4XOii7koKyaN03i8
         deWHhDjYPVRem2gGURMZ4Ohsf8uM4V/U/UpNEB+4oujSICm/Yu9uSBz6zYpjqpq88aps
         cD7SPllYvd/Jqcqd0e0eGx0eoKh3AOqaK95m4iv0n/x/ImLIzC4k0BE7x9+W+jQYGaDC
         5Pkw7EfoSMGMfnnVei/F5Afk4POU8ucNH2QlzZoD+DTO0pgEXDTNILnRmkQmguEoqK+O
         ZNiPL/1e2LV2uHetTFT8HX5GxMyJBBBi+3I/EvxmmFCe3Es+fd2RuuWVFPctk/7DXEt3
         iwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0H6tmkxza/8d0+N913JHZ3De4yw9yKeqvruKlu2rc4=;
        b=YfOM25VzNJaPHEnY2U7NHB2cn6Uto5cSqKQ897RN2HgccUQssQmesD3kC7C3SOT+YU
         Y/mErCp0U+oszAwwuE6r1EU7ozL/C815ReMaJE/EDBtfPRIedjYnwtRNheNTOCrt+v0B
         sw1pf5A4jpewwsjvjdxNWRHyX5oSubFXZXkDAoa21kx4l/GtqWB5WRrnCQH+Nro7lRI/
         mvJJAyybm3vyHn7HZdP3+Xjt8ghHN/EakX8VKCOFdkWCnuBIiWBshplUm7fXCeq+0l4A
         g4JlmpSRbJE7eGI66xUzbEYukCdfP6LyeWUxYDuJyMgvPMfLLuv1sIvtBFsFSJUn0m8D
         s0MQ==
X-Gm-Message-State: APjAAAU9AdVoFt3nvkuG4ECN2wztnF5/dBMafAuX3nif0hos1fZxh9/G
        1RU6hitmgULXsjPYTe+DI9qUSLDenrA6iEZn69KJtw==
X-Google-Smtp-Source: APXvYqzyuJ7+cZVdUhdxPd44AK/Lb7S1zjwyVJIgc78P3c9DApdnlx6RPs+bTeyQ6ch6HV72IUo+B3dO5vYPXABBB6E=
X-Received: by 2002:a63:84c7:: with SMTP id k190mr24506978pgd.255.1553536631433;
 Mon, 25 Mar 2019 10:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190324194505.3244479-1-arnd@arndb.de>
In-Reply-To: <20190324194505.3244479-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Mar 2019 10:57:00 -0700
Message-ID: <CAKwvOdmH+G6asuizkYJ-A6OTepQ6MXKzTmLYoWrCK8nhXxYahw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: work around high stack usage with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building this file with clang can result in large stack usage as seen from
> this warning:
>
> fs/ubifs/auth.c:78:5: error: stack frame size of 1152 bytes in function 'ubifs_prepare_auth_node'
>
> The problem is that inlining ubifs_hash_calc_hmac() leads to
> two SHASH_DESC_ON_STACK() blocks in the same function, and clang
> for some reason does not reuse the stack space as it should.
>
> Putting the first declaration into a separate basic block avoids
> this problem and reduces the stack allocation to 640 bytes.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM; in general, it can be useful to always include a comment before
a new scope like:

/* New scope to limit lifetime of large stack allocated hash_desc. */

but folks can always refer to the git blame/log for reasoning as to
why a new scope was added.

I plan on working on a pass in LLVM to improve stack slot reuse
sometime in 2019Q2.  Thanks for this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/ubifs/auth.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> index 5bf5fd08879e..5d3d0b37a908 100644
> --- a/fs/ubifs/auth.c
> +++ b/fs/ubifs/auth.c
> @@ -78,7 +78,6 @@ static int ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
>  int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
>                              struct shash_desc *inhash)
>  {
> -       SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
>         struct ubifs_auth_node *auth = node;
>         u8 *hash;
>         int err;
> @@ -87,13 +86,17 @@ int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
>         if (!hash)
>                 return -ENOMEM;
>
> -       hash_desc->tfm = c->hash_tfm;
> -       hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> -       ubifs_shash_copy_state(c, inhash, hash_desc);
> +       {
> +               SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
>
> -       err = crypto_shash_final(hash_desc, hash);
> -       if (err)
> -               goto out;
> +               hash_desc->tfm = c->hash_tfm;
> +               hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +               ubifs_shash_copy_state(c, inhash, hash_desc);
> +
> +               err = crypto_shash_final(hash_desc, hash);
> +               if (err)
> +                       goto out;
> +       }
>
>         err = ubifs_hash_calc_hmac(c, hash, auth->hmac);
>         if (err)
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
