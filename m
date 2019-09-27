Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9102C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35A207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCGU90/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfI0NHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:07:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36120 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:07:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so1874278qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFGrykQPVrfrF/RCxAyujZ2hxx3LnFuQxZYE85jjQVw=;
        b=eCGU90/xZEVHkKCXyCx9dXZYOtfiWFMq7pEiL6sVql5nIOuzUZmap6FW0TUmXa8+PU
         W7QjgFFyd0b7aGdzPj7JWFAaCxxkWHiLoAbcLFEFqS/5ZZWYoKcTAaAWkUAHhbeUW1FR
         kx/2TVbuRs9rN+dyRdEJw/yO/C/kppDIKK1TIs7Y2hIspTSWOLca0dGiNdfPh1ytEa0t
         tgfvgh7hlc9wXM1pdjaDWdUEQRj7Q+Yf8araXc0PrH+FuFKSfGxMA51kOFodqv3P89X3
         ClaMNs+Rr9x6+jwHltu3agDcuMkJqn+LiYWQhxmIonMqgaCA+H/rdfPLRojuTZgYyNZ0
         eSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFGrykQPVrfrF/RCxAyujZ2hxx3LnFuQxZYE85jjQVw=;
        b=mk0Ji5LRlm+oy7rGHTkfiPLpboCn4dpfD1o27TGybXKHKPYHDqqrryn3LiI/GM+xrg
         0bauqhtkOMcFUjwBcDEELXCxPi6Gg9v5jl76KtjlZtmyFRvJoLhCfa44Cey1+3KCZBck
         jVjjoS+zalEjDU8x2O8Nz2zTCCLnrve3pMgWOvoIQp2L6yc8w/00rAnsaXTybDfh80Q2
         5SZjhcz8uPZtFHR4RqqTfIemyW+yFpPQWBBgI5U6PNWw3IQv/z6zN5eAJjDoBHQMZmW7
         fKuEN8IX1O2ESKSTmdfWMnLifYwHlXEcnQqW5YzsKpJtvVBMQsvHRGqDnwcSvZTZMSIv
         ItWA==
X-Gm-Message-State: APjAAAUGtD6+hPe7Zdwqyx/Qx2g/SPX9HraYIFNLTiflm5umBz7ZYaM1
        YVT9zvjBB/Js+TM102xwj4Xql4jpMAU5cxcTcToZVQ==
X-Google-Smtp-Source: APXvYqxSbPuLXB+yACgf7+ApwenZVI+V5HXnmMTKT9MisInSMbZ2ml/YIzKWfIjHD4YHiq/qrRKp5M1XDxBptaLE7RY=
X-Received: by 2002:a37:9202:: with SMTP id u2mr4399020qkd.8.1569589657502;
 Fri, 27 Sep 2019 06:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Sep 2019 15:07:25 +0200
Message-ID: <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:43 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> memmove() and memcpy() have missing underflow issues.
> When -7 <= size < 0, then KASAN will miss to catch the underflow issue.
> It looks like shadow start address and shadow end address is the same,
> so it does not actually check anything.
>
> The following test is indeed not caught by KASAN:
>
>         char *p = kmalloc(64, GFP_KERNEL);
>         memset((char *)p, 0, 64);
>         memmove((char *)p, (char *)p + 4, -2);
>         kfree((char*)p);
>
> It should be checked here:
>
> void *memmove(void *dest, const void *src, size_t len)
> {
>         check_memory_region((unsigned long)src, len, false, _RET_IP_);
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>         return __memmove(dest, src, len);
> }
>
> We fix the shadow end address which is calculated, then generic KASAN
> get the right shadow end address and detect this underflow issue.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/test_kasan.c   | 36 ++++++++++++++++++++++++++++++++++++
>  mm/kasan/generic.c |  8 ++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b63b367a94e8..8bd014852556 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -280,6 +280,40 @@ static noinline void __init kmalloc_oob_in_memset(void)
>         kfree(ptr);
>  }
>
> +static noinline void __init kmalloc_oob_in_memmove_underflow(void)
> +{
> +       char *ptr;
> +       size_t size = 64;
> +
> +       pr_info("underflow out-of-bounds in memmove\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       memset((char *)ptr, 0, 64);
> +       memmove((char *)ptr, (char *)ptr + 4, -2);
> +       kfree(ptr);
> +}
> +
> +static noinline void __init kmalloc_oob_in_memmove_overflow(void)
> +{
> +       char *ptr;
> +       size_t size = 64;
> +
> +       pr_info("overflow out-of-bounds in memmove\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       memset((char *)ptr, 0, 64);
> +       memmove((char *)ptr + size, (char *)ptr, 2);
> +       kfree(ptr);
> +}
> +
>  static noinline void __init kmalloc_uaf(void)
>  {
>         char *ptr;
> @@ -734,6 +768,8 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_oob_memset_4();
>         kmalloc_oob_memset_8();
>         kmalloc_oob_memset_16();
> +       kmalloc_oob_in_memmove_underflow();
> +       kmalloc_oob_in_memmove_overflow();
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 616f9dd82d12..34ca23d59e67 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -131,9 +131,13 @@ static __always_inline bool memory_is_poisoned_n(unsigned long addr,
>                                                 size_t size)
>  {
>         unsigned long ret;
> +       void *shadow_start = kasan_mem_to_shadow((void *)addr);
> +       void *shadow_end = kasan_mem_to_shadow((void *)addr + size - 1) + 1;
>
> -       ret = memory_is_nonzero(kasan_mem_to_shadow((void *)addr),
> -                       kasan_mem_to_shadow((void *)addr + size - 1) + 1);
> +       if ((long)size < 0)
> +               shadow_end = kasan_mem_to_shadow((void *)addr + size);

Hi Walter,

Thanks for working on this.

If size<0, does it make sense to continue at all? We will still check
1PB of shadow memory? What happens when we pass such huge range to
memory_is_nonzero?
Perhaps it's better to produce an error and bail out immediately if size<0?
Also, what's the failure mode of the tests? Didn't they badly corrupt
memory? We tried to keep tests such that they produce the KASAN
reports, but don't badly corrupt memory b/c/ we need to run all of
them.




> +       ret = memory_is_nonzero(shadow_start, shadow_end);
>
>         if (unlikely(ret)) {
>                 unsigned long last_byte = addr + size - 1;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190927034338.15813-1-walter-zh.wu%40mediatek.com.
