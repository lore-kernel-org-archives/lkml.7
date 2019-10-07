Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB1721655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlTtBxnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJGH36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:29:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33891 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGH35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:29:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so11703532qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/whrwnXmuipWLBmQ5DFzrwToiDCS8kW6Zb6tPW0PAM=;
        b=VlTtBxnDnz2gOXFcKHLxJrCmwuIHAFhvYEohGLPDScHToyjVcqP9Fnlnikxx2JB3sI
         Pgi0iyglqBz4t9T3eo9jCr2G4/WVkwDp6h6FSXkX1SLL3PwfbAbI8FoOg1w4QArLssUP
         /ARI7/r0DZ8BxPze494Co6Xr73xUw9TMpps7fXaYCH3dAtcFsIqQtxIEb2g5u1C5ncsf
         aGe3O0TOXxQld8+RvCS0xF0GA5oZXKPTe1WGp+nAjttefbShyeANE9d8y0OuatQZVGne
         a22PX/zouxEx1NbfOSj608JmefiMurh2Ff7Ewd+fufwmT6jevWEvOlEaQuMocUZ6o9I7
         OIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/whrwnXmuipWLBmQ5DFzrwToiDCS8kW6Zb6tPW0PAM=;
        b=S6OQUG6k4IaysXyETYks2fZph7tR8y5fKKrabJcplEI4VO2W4VeCfFe9xSO/lkoVOU
         odIzW2IZMVndq8gy44Y+g6AuOqvnzuUdFvJDBpimnIPVx3krZ4Ac5EVwVb1sOR/Hobe8
         i7/TfIDV5+y8cemUXg/htjYvhR9qRNB7w4YZpoZro8t+hwKlEPDl7stvLztX/d6+gebB
         +yDLST8ThWyiN2+zl8VIURS68+JWy1UheIxuNY0ktei5TgYwwXK5v0SQTMObpe/U8SKB
         3yXir5i9+H5tJBNkVC0EHK6eYud4wifamGVKXd8ZO67zNkBpZyHEiYc2yyIQIymTRcFb
         Q6Zw==
X-Gm-Message-State: APjAAAXqZoZfjoQLwmuAmPlY6z+tKikeQLsPly/8hXw/Eyp4mVbkkkKh
        5yM2ZlcTOopJqhkJh9VSja74sbhxZ8RaXZXphvxofA==
X-Google-Smtp-Source: APXvYqyvCiw7DR2qtcig/5oWesaQ40f5upQUYafN4az0Tkrn1yiR2sBersvbT4V5VzPn10V6DV6aC0V5uIkgr6uc2LQ=
X-Received: by 2002:a37:985:: with SMTP id 127mr21743116qkj.43.1570433396036;
 Mon, 07 Oct 2019 00:29:56 -0700 (PDT)
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
 <1570190718.19702.125.camel@mtksdccf07> <CACT4Y+YbkjuW3_WQJ4BB8YHWvxgHJyZYxFbDJpnPzfTMxYs60g@mail.gmail.com>
 <1570418576.4686.30.camel@mtksdccf07>
In-Reply-To: <1570418576.4686.30.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 09:29:44 +0200
Message-ID: <CACT4Y+aho7BEvQstd2+a2be-jJ0dEsjGebH7bcUFhYp-PoRDxQ@mail.gmail.com>
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

On Mon, Oct 7, 2019 at 5:23 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > "out-of-bounds" is the _least_ frequent KASAN bug type. So saying
> > > > > > "out-of-bounds" has downsides of both approaches and won't prevent
> > > > > > duplicate reports by syzbot...
> > > > > >
> > > > > maybe i should add your comment into the comment in get_bug_type?
> > > >
> > > > Yes, that's exactly what I meant above:
> > > >
> > > > "I would change get_bug_type() to return "slab-out-of-bounds" (as the
> > > > most common OOB) in such case (with a comment)."
> > > >
> > > >  ;)
> > >
> > >
> > > The patchset help to produce KASAN report when size is negative size in
> > > memory operation function. It is helpful for programmer to solve the
> > > undefined behavior issue. Patch 1 based on Dmitry's suggestion and
> > > review, patch 2 is a test in order to verify the patch 1.
> > >
> > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
> > >
> > > Walter Wu (2):
> > > kasan: detect invalid size in memory operation function
> > > kasan: add test for invalid size in memmove
> > >
> > > lib/test_kasan.c          | 18 ++++++++++++++++++
> > > mm/kasan/common.c         | 13 ++++++++-----
> > > mm/kasan/generic.c        |  5 +++++
> > > mm/kasan/generic_report.c | 10 ++++++++++
> > > mm/kasan/tags.c           |  5 +++++
> > > mm/kasan/tags_report.c    | 10 ++++++++++
> > > 6 files changed, 56 insertions(+), 5 deletions(-)
> > >
> > >
> > >
> > >
> > > commit 0bc50c759a425fa0aafb7ef623aa1598b3542c67
> > > Author: Walter Wu <walter-zh.wu@mediatek.com>
> > > Date:   Fri Oct 4 18:38:31 2019 +0800
> > >
> > >     kasan: detect invalid size in memory operation function
> > >
> > >     It is an undefined behavior to pass a negative value to
> > > memset()/memcpy()/memmove()
> > >     , so need to be detected by KASAN.
> > >
> > >     If size is negative value, then it will be larger than ULONG_MAX/2,
> > >     so that we will qualify as out-of-bounds issue.
> > >
> > >     KASAN report:
> > >
> > >      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
> > >      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> > > cat/72
> > >
> > >      CPU: 2 PID: 72 Comm: cat Not tainted
> > > 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
> > >      Hardware name: linux,dummy-virt (DT)
> > >      Call trace:
> > >       dump_backtrace+0x0/0x288
> > >       show_stack+0x14/0x20
> > >       dump_stack+0x10c/0x164
> > >       print_address_description.isra.9+0x68/0x378
> > >       __kasan_report+0x164/0x1a0
> > >       kasan_report+0xc/0x18
> > >       check_memory_region+0x174/0x1d0
> > >       memmove+0x34/0x88
> > >       kmalloc_memmove_invalid_size+0x70/0xa0
> > >
> > >     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > >
> > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > >     Reported -by: Dmitry Vyukov <dvyukov@google.com>
> > >     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > >
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 6814d6d6a023..6ef0abd27f06 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> > >  #undef memset
> > >  void *memset(void *addr, int c, size_t len)
> > >  {
> > > -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > > +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > > +               return NULL;
> > >
> > >         return __memset(addr, c, len);
> > >  }
> > > @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
> > >  #undef memmove
> > >  void *memmove(void *dest, const void *src, size_t len)
> > >  {
> > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > +               return NULL;
> > >
> > >         return __memmove(dest, src, len);
> > >  }
> > > @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t
> > > len)
> > >  #undef memcpy
> > >  void *memcpy(void *dest, const void *src, size_t len)
> > >  {
> > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > +               return NULL;
> > >
> > >         return __memcpy(dest, src, len);
> > >  }
> > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > index 616f9dd82d12..02148a317d27 100644
> > > --- a/mm/kasan/generic.c
> > > +++ b/mm/kasan/generic.c
> > > @@ -173,6 +173,11 @@ static __always_inline bool
> > > check_memory_region_inline(unsigned long addr,
> > >         if (unlikely(size == 0))
> > >                 return true;
> > >
> > > +       if (unlikely((long)size < 0)) {
> > > +               kasan_report(addr, size, write, ret_ip);
> > > +               return false;
> > > +       }
> > > +
> > >         if (unlikely((void *)addr <
> > >                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > >                 kasan_report(addr, size, write, ret_ip);
> > > diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > > index 36c645939bc9..23951a453681 100644
> > > --- a/mm/kasan/generic_report.c
> > > +++ b/mm/kasan/generic_report.c
> > > @@ -107,6 +107,16 @@ static const char *get_wild_bug_type(struct
> > > kasan_access_info *info)
> > >
> > >  const char *get_bug_type(struct kasan_access_info *info)
> > >  {
> > > +       /*
> > > +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> > > +        * so that this can qualify as out-of-bounds.
> > > +        * out-of-bounds is the _least_ frequent KASAN bug type. So saying
> > > +        * out-of-bounds has downsides of both approaches and won't prevent
> > > +        * duplicate reports by syzbot.
> > > +        */
> > > +       if ((long)info->access_size < 0)
> > > +               return "out-of-bounds";
> > > +
> > >         if (addr_has_shadow(info->access_addr))
> > >                 return get_shadow_bug_type(info);
> > >         return get_wild_bug_type(info);
> > > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > > index 0e987c9ca052..b829535a3ad7 100644
> > > --- a/mm/kasan/tags.c
> > > +++ b/mm/kasan/tags.c
> > > @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t
> > > size, bool write,
> > >         if (unlikely(size == 0))
> > >                 return true;
> > >
> > > +       if (unlikely((long)size < 0)) {
> > > +               kasan_report(addr, size, write, ret_ip);
> > > +               return false;
> > > +       }
> > > +
> > >         tag = get_tag((const void *)addr);
> > >
> > >         /*
> > > diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> > > index 969ae08f59d7..19b9e364b397 100644
> > > --- a/mm/kasan/tags_report.c
> > > +++ b/mm/kasan/tags_report.c
> > > @@ -36,6 +36,16 @@
> > >
> > >  const char *get_bug_type(struct kasan_access_info *info)
> > >  {
> > > +       /*
> > > +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> > > +        * so that this can qualify as out-of-bounds.
> > > +        * out-of-bounds is the _least_ frequent KASAN bug type. So saying
> > > +        * out-of-bounds has downsides of both approaches and won't prevent
> > > +        * duplicate reports by syzbot.
> > > +        */
> > > +       if ((long)info->access_size < 0)
> > > +               return "out-of-bounds";
> >
> >
> > wait, no :)
> > I meant we change it to heap-out-of-bounds and explain why we are
> > saying this is a heap-out-of-bounds.
> > The current comment effectively says we are doing non useful thing for
> > no reason, it does not eliminate any of my questions as a reader of
> > this code :)
> >
> Ok, the current comment may not enough to be understood why we use OOB
> to represent size<0 bug. We can modify it as below :)
>
> If access_size < 0, then it has two reasons to be defined as
> out-of-bounds.
> 1) Casting negative numbers to size_t would indeed turn up as a "large"
> size_t and its value will be larger than ULONG_MAX/2, so that this can
> qualify as out-of-bounds.
> 2) Don't generate new bug type in order to prevent duplicate reports by
> some systems, e.g. syzbot."

Looks good to me. I think it should provide enough hooks for future
readers to understand why we do this.

> > > +
> > >  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > >         struct kasan_alloc_meta *alloc_meta;
> > >         struct kmem_cache *cache;
> > >
> > >
> > >
> > > commit fb5cf7bd16e939d1feef229af0211a8616c9ea03
> > > Author: Walter Wu <walter-zh.wu@mediatek.com>
> > > Date:   Fri Oct 4 18:32:03 2019 +0800
> > >
> > >     kasan: add test for invalid size in memmove
> > >
> > >     Test size is negative vaule in memmove in order to verify
> > >     if it correctly produce KASAN report.
> > >
> > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index 49cc4d570a40..06942cf585cc 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -283,6 +283,23 @@ static noinline void __init
> > > kmalloc_oob_in_memset(void)
> > >         kfree(ptr);
> > >  }
> > >
> > > +static noinline void __init kmalloc_memmove_invalid_size(void)
> > > +{
> > > +       char *ptr;
> > > +       size_t size = 64;
> > > +
> > > +       pr_info("invalid size in memmove\n");
> > > +       ptr = kmalloc(size, GFP_KERNEL);
> > > +       if (!ptr) {
> > > +               pr_err("Allocation failed\n");
> > > +               return;
> > > +       }
> > > +
> > > +       memset((char *)ptr, 0, 64);
> > > +       memmove((char *)ptr, (char *)ptr + 4, -2);
> > > +       kfree(ptr);
> > > +}
> > > +
> > >  static noinline void __init kmalloc_uaf(void)
> > >  {
> > >         char *ptr;
> > > @@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
> > >         kmalloc_oob_memset_4();
> > >         kmalloc_oob_memset_8();
> > >         kmalloc_oob_memset_16();
> > > +       kmalloc_memmove_invalid_size();
> > >         kmalloc_uaf();
> > >         kmalloc_uaf_memset();
> > >         kmalloc_uaf2();
>
>
