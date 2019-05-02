Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA53C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2C920C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pW9Mlh00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfEBQlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:41:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36430 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:41:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so1316774pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92karzGId4kTiPxbclHEQu/kjCIMGVKlDvLxWKLPllQ=;
        b=pW9Mlh00pTbPzKKMewhu5d9r6gm71AyCd5VE3PXTq9/6KeJWTWX9VAdyklQe4wuYb3
         hw6/lCKfgP3MBQuvHSNTnDii93JeoAZ1tz36Ilk1XAnuH2tR8iS45vHy63ek7KeVo8Kv
         pPaZFSX+7KB1/bAO/KXNp2pKUm1C86PLwVWmBVtbE1JqIgA3KIcb1b/b7Ng6bjqelicY
         6DQAN7is5Vz8aCc+ZcoCa9As2irNjbQGXPT3N7cDSP18s23973KvWfDy7jubbL2cvXcF
         9fU8o6qOaaYqh7iOQW85PTkzEhusyPBLF2Ti3wgqhnyl9L/q3tU0Sq/+WyRxSAFHojV5
         aVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92karzGId4kTiPxbclHEQu/kjCIMGVKlDvLxWKLPllQ=;
        b=aDe0Mw5+P0zit0alm2dP5evf5vyzOQKDKv68h5vX7mDZNfZ6sT6aNlQ+E1SklY6Wf2
         HoPikNYHKlwGh2pNPxAviEvpOZ5TbXZpt5bP1S1KyFZQZTWID+9m3tuWJxpzWFtqxcIw
         TOx8Yz288Ig4djbVokOkT8m9gDZEtdCbqzQSc11FEtelW6bvRvA27HnvQw1ait0j+SGL
         XRDj/lc+9rFnGnlMDqOb1TxsH8Fg0VKVrFthnOnciIHGXvoh9BBEULCu8hvaBJeRLT1j
         H1yHVWTWBhonk4TqtZUklGKL0lkAj6r7EmZuxGpatzLZyLf4lUsKvNmojzm+VQYPtN81
         mVFg==
X-Gm-Message-State: APjAAAV5IZ3KTLlpZ7vdzy3kBZsikS/q/AYVadyLNCmUeDWrWQeA/Ald
        WxbNXj1j2J7zSlDtqnEITRgGZVLoNrCnLtY73V0rYA==
X-Google-Smtp-Source: APXvYqxEpi/34FQTQo/i2+QqbKQVsIw9n+cFj3zq5T2pXhuwK8N3k0YF3vpXL1+twKXJJwXv+Ny1FxDYEUV2ic9nRnQ=
X-Received: by 2002:a62:46c7:: with SMTP id o68mr5390737pfi.54.1556815263742;
 Thu, 02 May 2019 09:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190502153538.2326-1-natechancellor@gmail.com> <20190502163057.6603-1-natechancellor@gmail.com>
In-Reply-To: <20190502163057.6603-1-natechancellor@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 May 2019 18:40:52 +0200
Message-ID: <CAAeHK+wzuSKhTE6hjph1SXCUwH8TEd1C+J0cAQN=pRvKw+Wh_w@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Initialize tag to 0xff in __kasan_kmalloc
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 6:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
> warns:
>
> mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
> used here [-Wuninitialized]
>         kasan_unpoison_shadow(set_tag(object, tag), size);
>                                               ^~~
>
> set_tag ignores tag in this configuration but clang doesn't realize it
> at this point in its pipeline, as it points to arch_kasan_set_tag as
> being the point where it is used, which will later be expanded to
> (void *)(object) without a use of tag. Initialize tag to 0xff, as it
> removes this warning and doesn't change the meaning of the code.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/465
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>
> v1 -> v2:
>
> * Initialize tag to 0xff at Andrey's request
>
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 36afcf64e016..242fdc01aaa9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -464,7 +464,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  {
>         unsigned long redzone_start;
>         unsigned long redzone_end;
> -       u8 tag;
> +       u8 tag = 0xff;
>
>         if (gfpflags_allow_blocking(flags))
>                 quarantine_reduce();
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190502163057.6603-1-natechancellor%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
