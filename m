Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12785C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74142084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROvJeYaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfJNKkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:40:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35040 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfJNKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:40:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so24785100qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YrhF1CY8Iis1JpXe2D3S6ZujIQpFi34GXY+qWGn3K4=;
        b=ROvJeYaFK/UErE1I8NcK2RXh5FOCiUehaOama+hKeRb6K0pU+BoWEggIDveJnxEDUy
         Ucpi3nVPGtyHOUKX7kAmQGQaiCfc5d8UVEJaiA+QujWXu+uBLr0cMVwJV8r/ebuc+ekE
         q/6vo8w+5ii/MJo6qEJCFuzsRSBCODdDphMVpChyoyOC/1m5B5j9xPGp8JzPVbZEdXFJ
         R1JBi7mm+KeNwdZ4GZaUG8QT3EvQpixIwU6nkcaWeVcTXrM+qyQyQuPiyip5D5SLHV3Z
         hpGz5rJz2gR3FpKjLbrFYBqgLfJW2iPOWL2FOtpBydYUw3a2NVKwVypmzK/zKYty5hMY
         zoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YrhF1CY8Iis1JpXe2D3S6ZujIQpFi34GXY+qWGn3K4=;
        b=K4/I/AVXppy8c9HqgB4Y4afUAuT4z55rV1KcebykNwG4OLRWehNierWPgZ+IJcH/LH
         miQzf7FE5EXDBV8a1rUVkUQELWlEC77um5KQ6utS3U1nVOsjtz76LB9oUwVbgvUD6eTE
         utxCnbNXjjRTw92k33LPQlFxipdXcERmSZbCSao9oSx9KNR0j1lnJh/gMczz+3QB8KMv
         bg8E0L4StR0Z5RC2etSD61m32t5RNuq3GVneS/HZ+l6jpL8rVFtD2+SNDBFXst5rJOdV
         8sQapuADgOzM55pMlcaG4xXV6Y+8+bhD+i9R87LETZbJLLtMbmLvgHIf9b3WrQttInYV
         aWrw==
X-Gm-Message-State: APjAAAUeErgCkPyh9cSSG++M+V9D+hJ7Cq2PWeqYnoLOMJg9XHfQm4A0
        Pgf9OacZ3Fzu4C4FXjtx91eynQi6Dnen26Bnyagqmw==
X-Google-Smtp-Source: APXvYqzFZN6AZNRHFN9kMSHww3z2LMClLWJn5P8w2ZzOop0SdLx+xfMbKdpOqyrk2p3husLubvv8FDO5kjHf1lEtBmQ=
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr30851968qvs.122.1571049647781;
 Mon, 14 Oct 2019 03:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191014103632.17930-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20191014103632.17930-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 12:40:36 +0200
Message-ID: <CACT4Y+bQNDMZE72rcrpfA+eBizx8OGx-Ae78Ci5KU6AN-PBDqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: detect negative size in memory operation function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:36 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> KASAN missed detecting size is negative numbers in memset(), memcpy(),
> and memmove(), it will cause out-of-bounds bug, so needs to be detected
> by KASAN.
>
> If size is negative numbers, then it has three reasons to be
> defined as heap-out-of-bounds bug type.
> 1) Casting negative numbers to size_t would indeed turn up as
>    a large size_t and its value will be larger than ULONG_MAX/2,
>    so that this can qualify as out-of-bounds.
> 2) If KASAN has new bug type and user-space passes negative size,
>    then there are duplicate reports. So don't produce new bug type
>    in order to prevent duplicate reports by some systems (e.g. syzbot)
>    to report the same bug twice.
> 3) When size is negative numbers, it may be passed from user-space.
>    So we always print heap-out-of-bounds in order to prevent that
>    kernel-space and user-space have the same bug but have duplicate
>    reports.
>
> KASAN report:
>
>  BUG: KASAN: heap-out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
>  Read of size 18446744073709551608 at addr ffffff8069660904 by task cat/72
>
>  CPU: 2 PID: 72 Comm: cat Not tainted 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0x0/0x288
>   show_stack+0x14/0x20
>   dump_stack+0x10c/0x164
>   print_address_description.isra.9+0x68/0x378
>   __kasan_report+0x164/0x1a0
>   kasan_report+0xc/0x18
>   check_memory_region+0x174/0x1d0
>   memmove+0x34/0x88
>   kmalloc_memmove_invalid_size+0x70/0xa0
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Reported -by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c         | 13 ++++++++-----
>  mm/kasan/generic.c        |  5 +++++
>  mm/kasan/generic_report.c | 18 ++++++++++++++++++
>  mm/kasan/tags.c           |  5 +++++
>  mm/kasan/tags_report.c    | 18 ++++++++++++++++++
>  5 files changed, 54 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6814d6d6a023..6ef0abd27f06 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +               return NULL;
>
>         return __memset(addr, c, len);
>  }
> @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> +               return NULL;
>
>         return __memmove(dest, src, len);
>  }
> @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> +               return NULL;
>
>         return __memcpy(dest, src, len);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 616f9dd82d12..02148a317d27 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -173,6 +173,11 @@ static __always_inline bool check_memory_region_inline(unsigned long addr,
>         if (unlikely(size == 0))
>                 return true;
>
> +       if (unlikely((long)size < 0)) {
> +               kasan_report(addr, size, write, ret_ip);
> +               return false;
> +       }
> +
>         if (unlikely((void *)addr <
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>                 kasan_report(addr, size, write, ret_ip);
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 36c645939bc9..52a92c7db697 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * If access_size is negative numbers, then it has three reasons
> +        * to be defined as heap-out-of-bounds bug type.
> +        * 1) Casting negative numbers to size_t would indeed turn up as
> +        *    a large size_t and its value will be larger than ULONG_MAX/2,
> +        *    so that this can qualify as out-of-bounds.
> +        * 2) If KASAN has new bug type and user-space passes negative size,
> +        *    then there are duplicate reports. So don't produce new bug type
> +        *    in order to prevent duplicate reports by some systems
> +        *    (e.g. syzbot) to report the same bug twice.
> +        * 3) When size is negative numbers, it may be passed from user-space.
> +        *    So we always print heap-out-of-bounds in order to prevent that
> +        *    kernel-space and user-space have the same bug but have duplicate
> +        *    reports.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "heap-out-of-bounds";
> +
>         if (addr_has_shadow(info->access_addr))
>                 return get_shadow_bug_type(info);
>         return get_wild_bug_type(info);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 0e987c9ca052..b829535a3ad7 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>         if (unlikely(size == 0))
>                 return true;
>
> +       if (unlikely((long)size < 0)) {
> +               kasan_report(addr, size, write, ret_ip);
> +               return false;
> +       }
> +
>         tag = get_tag((const void *)addr);
>
>         /*
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index 969ae08f59d7..f7ae474aef3a 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -36,6 +36,24 @@
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * If access_size is negative numbers, then it has three reasons
> +        * to be defined as heap-out-of-bounds bug type.
> +        * 1) Casting negative numbers to size_t would indeed turn up as
> +        *    a large size_t and its value will be larger than ULONG_MAX/2,
> +        *    so that this can qualify as out-of-bounds.
> +        * 2) If KASAN has new bug type and user-space passes negative size,
> +        *    then there are duplicate reports. So don't produce new bug type
> +        *    in order to prevent duplicate reports by some systems
> +        *    (e.g. syzbot) to report the same bug twice.
> +        * 3) When size is negative numbers, it may be passed from user-space.
> +        *    So we always print heap-out-of-bounds in order to prevent that
> +        *    kernel-space and user-space have the same bug but have duplicate
> +        *    reports.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "heap-out-of-bounds";
> +
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         struct kasan_alloc_meta *alloc_meta;
>         struct kmem_cache *cache;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191014103632.17930-1-walter-zh.wu%40mediatek.com.
