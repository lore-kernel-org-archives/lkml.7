Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3DBC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4385820693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqDSHKiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfGPSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:17:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41120 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbfGPSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:17:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so10477113pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PCmnEjxa8jVhQ5Y+ipRDtHB/zOes0Ts0DJ57OSlDPs=;
        b=fqDSHKizju/U6jeZLueR4OQSpF8PEOXMW6z5aFvAgfBV8FvsSQ1CRSEGX9sxBI9Brz
         4ongTd9rvptHyC60FYEgdRSo/ILx3qBb1lj4WtoGIjVLNEnzJYYgQYPawvR6p1MmkmtA
         Y3zx6/ghagpymQwtepNA++GQFqNj0NKCskAsSNKLvjH3Ou1//MpP9Xs/IDIeJ73VEaL6
         kizz9RjXrpfYvhpMxKMZj+aAHvNcjCWY46ojShJ37bHZZUCWDSavp795/oXTSi8PUgVt
         sFnxRCJpStWDuz/50lzB1/GpWVK2+yLXYlxwkiq5X2STo5p3dSNf1rCLBNWhC0xDbEQr
         LMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PCmnEjxa8jVhQ5Y+ipRDtHB/zOes0Ts0DJ57OSlDPs=;
        b=tEQsoAoDJoXtyknvETxXZRu5ykVZ2W35rWZyFLnNjN+JHge+GnUA7Bz94FnQfDb2aS
         xi4Xwn808vlPwLrsN0lmtupflrEwGJSvNZsUNd0KdsdHTTuDzSGFCWlZmhG1pIqO3KN8
         9kozsn0ceRZzLvzfp3NjJ4oWJ+eITTIzGkLYK0PaNF//Q/X/5Gkir8L48iD4Tvo91Hii
         iB0bRp0KbXwbAkjDwnDFyXA2/YDO/66iU2qlz4w7ToVqNIgsP00XnkHXtfkr0i6cVays
         ZaKMSQjym8JhATIm6W6SpQZUCCwW8X9ffRnc+extW6/DZzZNHEpUu2NHp/wFa5sSTb5K
         klnw==
X-Gm-Message-State: APjAAAVZH6g0gaqe9VTCImQrPlb3oqryhEHh6FQPki4PUqDhE8AUMdL9
        SvrzOJtY8HYqgN64p2HXPtyah/2rYRTYEV3ka2De9Q==
X-Google-Smtp-Source: APXvYqxrM8lA2nuQ1vQH1iFJ9rvDKTJXsBIvDqF1cNARw+aM+/CiHn1w9IDzXcD3maCpqOahaq34RNasQzK8HN1QaSU=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr35998528pld.119.1563301019650;
 Tue, 16 Jul 2019 11:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <6166ec9ce99e5af2721793eaf4a769aaa881e14d.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <6166ec9ce99e5af2721793eaf4a769aaa881e14d.1563150885.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 11:16:48 -0700
Message-ID: <CAKwvOdn2ZEe6y=TZ2OyphR7CrC3yJgDEUVtwSX_5fXGtYAQ=bA@mail.gmail.com>
Subject: Re: [PATCH 07/22] x86/uaccess: Remove ELF function annotation from copy_user_handle_tail()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> After an objtool improvement, it's complaining about the CLAC in
> copy_user_handle_tail():
>
>   arch/x86/lib/copy_user_64.o: warning: objtool: .altinstr_replacement+0x12: redundant UACCESS disable
>   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x6: (alt)
>   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x2: (alt)
>   arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x0: <=== (func)
>
> copy_user_handle_tail() is incorrectly marked as a callable function, so
> objtool is rightfully concerned about the CLAC with no corresponding
> STAC.
>
> Remove the ELF function annotation.  The copy_user_handle_tail() code
> path is already verified by objtool because it's jumped to by other
> callable asm code (which does the corresponding STAC).

What is CLAC and STAC?

>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/lib/copy_user_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 378a1f70ae7d..4fe1601dbc5d 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -239,7 +239,7 @@ copy_user_handle_tail:
>         ret
>
>         _ASM_EXTABLE_UA(1b, 2b)
> -ENDPROC(copy_user_handle_tail)
> +END(copy_user_handle_tail)
>
>  /*
>   * copy_user_nocache - Uncached memory copy with exception handling
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
