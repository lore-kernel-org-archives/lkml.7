Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D06C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8921620873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3wWmtC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfJDNw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:52:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34319 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfJDNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:52:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so5872438qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Soan35jSNw0pBZHNZx4RYBGEDn5tQAp2CqUTHCkSaUU=;
        b=F3wWmtC0mbYcjGyjEM64p+UQxuXlOFpJRIWcSSIG5ICG0bGXsunoJLAiTWaHb/S9np
         WAIQVmzaXRMGtKKvCvnfFIHSQKl/zAgcD0jgUuCZ/FDoNnxGdQV/BqmBT98ac7TJkkZo
         VnCFkYkWmeNgHVdpxXY0bY36/THZklIHcuJIvr0Pjg1r14MdRWVSJN1pxv7nrwKKcJQj
         pq4Cexzu8soNezZdRgeCgjePP4AtwQD2LrwfSUQqRmJm7q1jwLOP32ieAwBwcEgmjsns
         2OCq0wIUTGulmbCnudAs8kAFyPvn10WSzR2SOr4WVR+wQt5n4W7SUhttThd2XeiwMEKs
         tJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Soan35jSNw0pBZHNZx4RYBGEDn5tQAp2CqUTHCkSaUU=;
        b=piMYhcG54L2qzUxDPYUL/efWtErOeitezMtibXV0KYxCvtpuZgkuXPxkeh3d/191wb
         YAYVu6z68wR/eEiemqbPVCIel/Sy1a1CgwR9pR0dCDpJtAX6XiqgB/AlOg1GIT7Av5vI
         throCC7zUMODVsxXmWTh7vDDOf15UdUv4KTxE8KXpNHInkpk77odhmfbma1DO7Teo6Fd
         jusR5G96+sVPiZD5dt0PXJTBvi4Lo/pg4WOhko8EgcgnTKxwdkD8ewgud/a0ItKAkyJ8
         1daTjrOsa/Ybfjl4tUTcraU/XblAeteFRhX2vX1/5Ui+7CYxtVGNBaeJ0xyxjtw1rkH0
         bhvQ==
X-Gm-Message-State: APjAAAVP2wPg7JxQ9ktf7jjcVY/gMpcx49kiuUgBuwwBHy/EZQGld3aU
        j4hixpO68qbVimB60UZuUausiN6sDFehULkijaRDRA==
X-Google-Smtp-Source: APXvYqySAzGQFwUKiVRpYAGufaY4Ueqo8hcp857y9UldclJTSmWozxMAehbcGlTq/jDhdwuSuwFWjgCSDJXYbpaD4ww=
X-Received: by 2002:a37:d84:: with SMTP id 126mr9297358qkn.407.1570197144318;
 Fri, 04 Oct 2019 06:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <1570018513.19702.36.camel@mtksdccf07>
 <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
 <1570069078.19702.57.camel@mtksdccf07> <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
 <1570095525.19702.59.camel@mtksdccf07> <1570110681.19702.64.camel@mtksdccf07>
 <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
 <1570164140.19702.97.camel@mtksdccf07> <1570176131.19702.105.camel@mtksdccf07>
 <CACT4Y+ZvhomaeXFKr4za6MJi=fW2SpPaCFP=fk06CMRhNcmFvQ@mail.gmail.com>
 <1570182257.19702.109.camel@mtksdccf07> <CACT4Y+ZnWPEO-9DkE6C3MX-Wo+8pdS6Gr6-2a8LzqBS=2fe84w@mail.gmail.com>
 <1570190718.19702.125.camel@mtksdccf07>
In-Reply-To: <1570190718.19702.125.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Oct 2019 15:52:12 +0200
Message-ID: <CACT4Y+YbkjuW3_WQJ4BB8YHWvxgHJyZYxFbDJpnPzfTMxYs60g@mail.gmail.com>
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

On Fri, Oct 4, 2019 at 2:05 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Fri, 2019-10-04 at 11:54 +0200, Dmitry Vyukov wrote:
> > > > "out-of-bounds" is the _least_ frequent KASAN bug type. So saying
> > > > "out-of-bounds" has downsides of both approaches and won't prevent
> > > > duplicate reports by syzbot...
> > > >
> > > maybe i should add your comment into the comment in get_bug_type?
> >
> > Yes, that's exactly what I meant above:
> >
> > "I would change get_bug_type() to return "slab-out-of-bounds" (as the
> > most common OOB) in such case (with a comment)."
> >
> >  ;)
>
>
> The patchset help to produce KASAN report when size is negative size in
> memory operation function. It is helpful for programmer to solve the
> undefined behavior issue. Patch 1 based on Dmitry's suggestion and
> review, patch 2 is a test in order to verify the patch 1.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
>
> Walter Wu (2):
> kasan: detect invalid size in memory operation function
> kasan: add test for invalid size in memmove
>
> lib/test_kasan.c          | 18 ++++++++++++++++++
> mm/kasan/common.c         | 13 ++++++++-----
> mm/kasan/generic.c        |  5 +++++
> mm/kasan/generic_report.c | 10 ++++++++++
> mm/kasan/tags.c           |  5 +++++
> mm/kasan/tags_report.c    | 10 ++++++++++
> 6 files changed, 56 insertions(+), 5 deletions(-)
>
>
>
>
> commit 0bc50c759a425fa0aafb7ef623aa1598b3542c67
> Author: Walter Wu <walter-zh.wu@mediatek.com>
> Date:   Fri Oct 4 18:38:31 2019 +0800
>
>     kasan: detect invalid size in memory operation function
>
>     It is an undefined behavior to pass a negative value to
> memset()/memcpy()/memmove()
>     , so need to be detected by KASAN.
>
>     If size is negative value, then it will be larger than ULONG_MAX/2,
>     so that we will qualify as out-of-bounds issue.
>
>     KASAN report:
>
>      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
>      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> cat/72
>
>      CPU: 2 PID: 72 Comm: cat Not tainted
> 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
>      Hardware name: linux,dummy-virt (DT)
>      Call trace:
>       dump_backtrace+0x0/0x288
>       show_stack+0x14/0x20
>       dump_stack+0x10c/0x164
>       print_address_description.isra.9+0x68/0x378
>       __kasan_report+0x164/0x1a0
>       kasan_report+0xc/0x18
>       check_memory_region+0x174/0x1d0
>       memmove+0x34/0x88
>       kmalloc_memmove_invalid_size+0x70/0xa0
>
>     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
>
>     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
>     Reported -by: Dmitry Vyukov <dvyukov@google.com>
>     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
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
> @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t
> len)
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
> @@ -173,6 +173,11 @@ static __always_inline bool
> check_memory_region_inline(unsigned long addr,
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
> index 36c645939bc9..23951a453681 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -107,6 +107,16 @@ static const char *get_wild_bug_type(struct
> kasan_access_info *info)
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        * out-of-bounds is the _least_ frequent KASAN bug type. So saying
> +        * out-of-bounds has downsides of both approaches and won't prevent
> +        * duplicate reports by syzbot.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "out-of-bounds";
> +
>         if (addr_has_shadow(info->access_addr))
>                 return get_shadow_bug_type(info);
>         return get_wild_bug_type(info);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 0e987c9ca052..b829535a3ad7 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t
> size, bool write,
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
> index 969ae08f59d7..19b9e364b397 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -36,6 +36,16 @@
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        * out-of-bounds is the _least_ frequent KASAN bug type. So saying
> +        * out-of-bounds has downsides of both approaches and won't prevent
> +        * duplicate reports by syzbot.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "out-of-bounds";


wait, no :)
I meant we change it to heap-out-of-bounds and explain why we are
saying this is a heap-out-of-bounds.
The current comment effectively says we are doing non useful thing for
no reason, it does not eliminate any of my questions as a reader of
this code :)




> +
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         struct kasan_alloc_meta *alloc_meta;
>         struct kmem_cache *cache;
>
>
>
> commit fb5cf7bd16e939d1feef229af0211a8616c9ea03
> Author: Walter Wu <walter-zh.wu@mediatek.com>
> Date:   Fri Oct 4 18:32:03 2019 +0800
>
>     kasan: add test for invalid size in memmove
>
>     Test size is negative vaule in memmove in order to verify
>     if it correctly produce KASAN report.
>
>     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 49cc4d570a40..06942cf585cc 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -283,6 +283,23 @@ static noinline void __init
> kmalloc_oob_in_memset(void)
>         kfree(ptr);
>  }
>
> +static noinline void __init kmalloc_memmove_invalid_size(void)
> +{
> +       char *ptr;
> +       size_t size = 64;
> +
> +       pr_info("invalid size in memmove\n");
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
>  static noinline void __init kmalloc_uaf(void)
>  {
>         char *ptr;
> @@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_oob_memset_4();
>         kmalloc_oob_memset_8();
>         kmalloc_oob_memset_16();
> +       kmalloc_memmove_invalid_size();
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
