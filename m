Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A684C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFAC21734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZHdw82y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHEPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:37:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41539 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:37:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so29590537pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRP6laDcYsaagqowX6PM5vV1ql9YojC3f98ieQbfibw=;
        b=aZHdw82yWFty3hQVAzsHs2fUhyQvuwpZlVYSYWBLTB/8rupDAl0wKOFCYdmT2AVyM3
         bU4fhnvSzDKnLtiQ3rS7cijZ1Vv3IIZe4rRpc4rEibhv0ZDXZ9WOzma5OQlcS+kYc8Mt
         3aq2tOS5hdDp99Y8bIwoTjEQB80+ErgcnzBts/1QhdymZ2BjAdCta1VZ5xzoMpm6V2x1
         DZCYNyCjuRGW+uCHqJqV4KCP0MbZCeI9Yg5elIeOIapd0UtWSDxj7AOKYYjvTfNTK9V9
         yb22NKB3Py0XgnjBPYBGPZ2hy6herMOmpnsmUtGcyAepI5Z7zt4WR2w/bewU8Zp5+oIw
         3psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRP6laDcYsaagqowX6PM5vV1ql9YojC3f98ieQbfibw=;
        b=uC/pfhkN9+jAfrRERwqYn97QTwnCNdMslRztQgeHDrGcKVASpDOrP1IYtO670QwHwN
         WNQi2rJxmIIgYvr1n4+9bZsYs1mso3y5tKPUlkD3vwdLaFxw2cU7hNXSFW5viJvUx3Lw
         XZw5u1bO23si8oUvE8zD0dxh2wpY6m6Y6NeQgXFQdAaAUllrExmDQMPzgQZGlc8azCxy
         k9ea3zkCni2VRvzBCjKeqXkyR2IzNV4tVSo6iVVD3LxValIr0v+7ysX9ENvjKqA/wnht
         8Q/nokO9SYINeEhM6Z05A7IjPte+qHieACwsJJvzqiJXPBnrxsMXaUz7QiuR1kg5VIcC
         32+w==
X-Gm-Message-State: APjAAAWagMBGeeCYN+DTWdYUEW2IrZsHLi02kyO0TkfhIqA6Y2dQAMwf
        j2AlCb0GL4n02fQQw4+BAHxxTE5F6rR4Ps13bLjxaQ==
X-Google-Smtp-Source: APXvYqyQR0D20P/mnpoLOPlzIBaHmjQ7w8XW8u+YMSrUQUo8L+f9shx/FCzhOS5dVIpqRT8luECGQsvMeWq4moJNLGA=
X-Received: by 2002:aa7:97bb:: with SMTP id d27mr73075178pfq.93.1565019438226;
 Mon, 05 Aug 2019 08:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <1564670825-4050-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564670825-4050-1-git-send-email-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 5 Aug 2019 17:37:06 +0200
Message-ID: <CAAeHK+xMQ5m-_eeQUPM2DoN=6OV-1uC6NX3dVnSKcmEqwSM5ZA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/mm: fix variable 'tag' set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 4:47 PM Qian Cai <cai@lca.pw> wrote:
>
> When CONFIG_KASAN_SW_TAGS=n, set_tag() is compiled away. GCC throws a
> warning,
>
> mm/kasan/common.c: In function '__kasan_kmalloc':
> mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
> [-Wunused-but-set-variable]
>   u8 tag = 0xff;
>      ^~~
>
> Fix it by making __tag_set() a static inline function the same as
> arch_kasan_set_tag() in mm/kasan/kasan.h for consistency because there
> is a macro in arch/arm64/include/asm/kasan.h,
>
>  #define arch_kasan_set_tag(addr, tag) __tag_set(addr, tag)
>
> However, when CONFIG_DEBUG_VIRTUAL=n and CONFIG_SPARSEMEM_VMEMMAP=y,
> page_to_virt() will call __tag_set() with incorrect type of a
> parameter, so fix that as well. Also, still let page_to_virt() return
> "void *" instead of "const void *", so will not need to add a similar
> cast in lowmem_page_address().
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: Fix compilation warnings of CONFIG_DEBUG_VIRTUAL=n spotted by Will.
>
>  arch/arm64/include/asm/memory.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b7ba75809751..fb04f10a78ab 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_reset(addr)      untagged_addr(addr)
>  #define __tag_get(addr)                (__u8)((u64)(addr) >> 56)
>  #else
> -#define __tag_set(addr, tag)   (addr)
> +static inline const void *__tag_set(const void *addr, u8 tag)
> +{
> +       return addr;
> +}
> +
>  #define __tag_reset(addr)      (addr)
>  #define __tag_get(addr)                0
>  #endif
> @@ -301,8 +305,8 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define page_to_virt(page)     ({                                      \
>         unsigned long __addr =                                          \
>                 ((__page_to_voff(page)) | PAGE_OFFSET);                 \
> -       unsigned long __addr_tag =                                      \
> -                __tag_set(__addr, page_kasan_tag(page));               \
> +       const void *__addr_tag =                                        \
> +               __tag_set((void *)__addr, page_kasan_tag(page));        \
>         ((void *)__addr_tag);                                           \
>  })
>
> --
> 1.8.3.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
