Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D675C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47084216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="I42Mz43w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfETUxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:53:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETUxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:53:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id c77so721403wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgtaH3BaB88SvVVWGIdw/jgKWg3CUtWtW+8PvA7IK1Q=;
        b=I42Mz43wtZ1nWQ3sKCUUx3kqQRt2Y/rpluQ5sNqCf53WVKOnn3Y7ddXUMvFSbJIASR
         JCb5HmK8niEMQ2s7Rsy+dfVGk9sphSLJsl1DNaLTbfTwvr+mf2X3X1jLtub4U7lVzR0Q
         0lZKwxt63wJK0O0iSXvIbfWc5CPz0pTJ8fjDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgtaH3BaB88SvVVWGIdw/jgKWg3CUtWtW+8PvA7IK1Q=;
        b=f1GJcvSJ6CQ5fuX5KL1c63iRhRxDfAzBfjFPS45VcTEZiP8FW7YklRHJyI7pkat9S4
         RGhKN/1WM32gzowzGnDWZ2CgPS+ZNBtb57QXnPKkOF9G9FDehVhHSlqqEKYnWjqy6mmx
         GbpKZyEhQ0qTx6vnxonY4zG4OQo1a1vaq7M5B/aCrvZr9tNp/+FyxbI2miOLW0uuIGav
         /t94rC/9Rnf+c6fXl6xwaFmspUqBddm/NIHcaC+DoLnVPvZcZDCB87j5Bxcle4zc9g9+
         3B2Z2Dv9/cfRj6zmWoXwojeTZD0529f7BkGLCcw5K3NvE3bCBPDecXLwjLioUo50JEd5
         tnAA==
X-Gm-Message-State: APjAAAUn+50xvv40aUjR5izRvOY5rydP9/rmlClGmiKF0noFi2yCAIio
        GmB/GoU+AP1FKBZ+8L68bbpcISNikJBOwG2KrtItRmIngoZYMA==
X-Google-Smtp-Source: APXvYqwn7d+GBWIk6fB8Qtd7qIDaU75cis6JBkvckAkTOPh7S3rk1cWh+F9D7HccbeLepmSD8dai4fjwKf+FmjSydAc=
X-Received: by 2002:a1c:c7c8:: with SMTP id x191mr674058wmf.126.1558385580358;
 Mon, 20 May 2019 13:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190517065424.24453-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190517065424.24453-1-yamada.masahiro@socionext.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 20 May 2019 15:52:49 -0500
Message-ID: <CAFxkdApsrU0tOmCnGDa6HRJ6R3T1gG7o-DN5pZXV0g4Oov6yrA@mail.gmail.com>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and cpacf_query_func()
 as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 1:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> was not enough to make sure to meet the 'i' (immediate) constraint for the
> asm operands.
>
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
>
>   In file included from arch/s390/crypto/prng.c:29:
>   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
>   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
>     170 |  asm volatile(
>         |  ^~~
>   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
>
> Add more __always_inline to force inlining.
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
Thanks for the fix, this does indeed fix the build issues for us.

Justin

Tested-by: Justin Forbes <jforbes@fedoraproject.org>

>  arch/s390/include/asm/cpacf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index f316de40e51b..19459dfb4295 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -177,7 +177,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>                 : "cc");
>  }
>
> -static inline int __cpacf_check_opcode(unsigned int opcode)
> +static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>  {
>         switch (opcode) {
>         case CPACF_KMAC:
> @@ -217,7 +217,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
>         return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
>  }
>
> -static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
> +static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
>  {
>         cpacf_mask_t mask;
>
> --
> 2.17.1
>
