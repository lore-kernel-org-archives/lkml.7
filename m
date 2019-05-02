Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A380C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7B820645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjkcsxEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEBQY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:24:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44369 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEBQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:24:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so1254075plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEKMwcrb+5WeSacp64Kz5FEoKnzrouBIBJCgUjJL8pw=;
        b=LjkcsxEigQRyF9OlwvXAi/j2a8iR0fHL5qiD6sBguYmhHkAwawMycCLskwUcIIVTez
         CARFExgvCLEQQCTf2E6r+e/meuaODxpr49RcPwVp/36qPFt1+sx/X1LnGMKdEJqDhoTt
         Fu6/5vIrBNQOofwhZEXvdJ14D4CTnasVx2JM5ifN5CyQsm31ZeWd696LBSmDM9RzQGQJ
         guhg0kow6boUf322o8sKzF7b0iL4J5xuKIjbTMQ54M1M+7mQ226GtBNEuJFBXykGgk9O
         dDy2mzG25rY1ChIRqqe+crGrlLlOel5BrkV7w9iYOIwiX+ULaQY5Q/sieG6s2iPjtIPT
         WKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEKMwcrb+5WeSacp64Kz5FEoKnzrouBIBJCgUjJL8pw=;
        b=LqhmwLcwD2GFvXvWVXvT57MSSelPEpHpLMKRW17jEpJlVFDHrUw7l8MrUkZRwqYKON
         /aC9j9LSUyLCLBDfH+HNp1Y8cNHuDUzgWIuMhGmRW7LBe6uhF2pP3GcMpWTgaWXf6oyr
         mx+/tUUZZG5HN4H0zn46v6NoUANu9RdxEG/kIQI0sOx5UIsOysdwIFgZqimCd7NgfsRH
         +QCtlOE/T2NccjiWjA8bvoDlxlqlokfNiCfDkc+pNCgigaawr3AoKarckHGIYMsyXxB+
         NPRDhUgznbke5gtcxlcN4ijJQ2fIlknfPpI33VdZEKS0HW0ejl++L/ydDWnvxqtvYL+y
         xXNA==
X-Gm-Message-State: APjAAAVudX3xH37xsBdsT341tASw/zrCBKaC+ZIBY2NiK8xHz7p2OzXe
        DMHAhLJoTwiA++XqZXrxJ0KGS6jhFgCpbNQJ5uYv0g==
X-Google-Smtp-Source: APXvYqwQ47Ewt1KF1SgJkAi9tpyduw0g1Ut08HvBNe2zOaZpXpsTNjFCl7vVftdeSPPrkrdgyQP/QgozrrqKX6+qO+o=
X-Received: by 2002:a17:902:56d:: with SMTP id 100mr1090671plf.246.1556814298380;
 Thu, 02 May 2019 09:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190502153538.2326-1-natechancellor@gmail.com>
In-Reply-To: <20190502153538.2326-1-natechancellor@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 May 2019 18:24:47 +0200
Message-ID: <CAAeHK+xb8oV_YuVHJivW9c1R0h=AWA_-G1K28GPiZmF9LO_FAw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Zero initialize tag in __kasan_kmalloc
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

On Thu, May 2, 2019 at 5:36 PM Nathan Chancellor
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
> (void *)(object) without a use of tag. Just zero initialize tag, as it
> removes this warning and doesn't change the meaning of the code.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/465
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 36afcf64e016..4c5af68f2a8b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -464,7 +464,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  {
>         unsigned long redzone_start;
>         unsigned long redzone_end;
> -       u8 tag;
> +       u8 tag = 0;

Hi Nathan,

Could you change this value to 0xff? This doesn't make any difference,
since set_tag() ignores the tag anyway, but is less confusing, as all
the non-tagged kernel pointers have 0xff in the top byte.

Thanks!

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
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190502153538.2326-1-natechancellor%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
