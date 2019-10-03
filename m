Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AADC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA51A20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/HBctXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfJCOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:54:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41931 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJCOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:54:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so2623335qkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTr3LSymDwJchkLEsnB04LTDGo5fRwiRd1Hl9vtA70A=;
        b=R/HBctXOh2b5gWcxNHLyJTCkeKva5iwYrCxrcE6R5Y1O9nlRDO4z/lGH13YGw75OfM
         6YSngGCepkVmyIwZpc9TGweSQSORBzKXu49gCWDbAoBB0japKvEayqDsQOkTZ95lWJQB
         ReKTL14Cbr3rq8L2cJvaCq1fQZ8crfreSySCM2juzebn+6I+HgkdxoU9zYzFaP/Bw0/a
         Flo3SYHBZP/jzyTlEo8mqLaIFYo4RNN5IPpOKIlWzCrYF+P7TqAuiWcxYliuGb4RzwGB
         ctRZKPcuz+xoBv88DpG+lhZRJu8YzA4iHn1w4Gib8tRWzq+tjG68IVw4P4IorU/hWkgw
         uB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTr3LSymDwJchkLEsnB04LTDGo5fRwiRd1Hl9vtA70A=;
        b=HwNs/QAzW37sBvMz37UAceIW3JSvR5YCSWjqzyjASvZpascHp1xn7ZNte7pOqqrFZi
         p695BX3qmJ9N+jeilgSfhgAfaVLQJ0OQd6x83XjvBOpEQB/qu6tQfjo2lQSx2WabMSLh
         ppJzsVNJxMKlCQvUbATOOm5ra3WfGpoMwq9bzkDdBVurqjFzsJC033xjFJu/yEDopEKK
         ZkFI4zb40JPz2JOSFau6qrcK/0I01DoU7rDN6/PONl95gnukFk3Glz6hTDNkSsYs5Bul
         5SUMr+P0IPmNsgP5Mgm6Hn2/j0gwPgJKD6sfyDa71SImxB1pGrgUAuWABs2BeDOZ8zpP
         o56w==
X-Gm-Message-State: APjAAAWiWIVOQFdPybCqD/c4kqAIboJB0bARn5wz/ehH0qwggStLRdFn
        8UcQHN7kIt42jNQHMlfWl32HSPpV2h4vFpKm6XHWhg==
X-Google-Smtp-Source: APXvYqyL9WizUhZ+DgNHZ+OGEYdpizeohMbvftFIrAKWc94nnZw7UjpfApEzrSxwJaXoT0kur5Yzh12qcoxvOrP4t0k=
X-Received: by 2002:a37:985:: with SMTP id 127mr4662844qkj.43.1570114451897;
 Thu, 03 Oct 2019 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <1570018513.19702.36.camel@mtksdccf07>
 <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
 <1570069078.19702.57.camel@mtksdccf07> <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
 <1570095525.19702.59.camel@mtksdccf07> <1570110681.19702.64.camel@mtksdccf07>
In-Reply-To: <1570110681.19702.64.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Oct 2019 16:53:59 +0200
Message-ID: <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
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

On Thu, Oct 3, 2019 at 3:51 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:>
> how about this?
>
> commit fd64691026e7ccb8d2946d0804b0621ac177df38
> Author: Walter Wu <walter-zh.wu@mediatek.com>
> Date:   Fri Sep 27 09:54:18 2019 +0800
>
>     kasan: detect invalid size in memory operation function
>
>     It is an undefined behavior to pass a negative value to
> memset()/memcpy()/memmove()
>     , so need to be detected by KASAN.
>
>     KASAN report:
>
>      BUG: KASAN: invalid size 18446744073709551614 in
> kmalloc_memmove_invalid_size+0x70/0xa0
>
>      CPU: 1 PID: 91 Comm: cat Not tainted
> 5.3.0-rc1ajb-00001-g31943bbc21ce-dirty #7
>      Hardware name: linux,dummy-virt (DT)
>      Call trace:
>       dump_backtrace+0x0/0x278
>       show_stack+0x14/0x20
>       dump_stack+0x108/0x15c
>       print_address_description+0x64/0x368
>       __kasan_report+0x108/0x1a4
>       kasan_report+0xc/0x18
>       check_memory_region+0x15c/0x1b8
>       memmove+0x34/0x88
>       kmalloc_memmove_invalid_size+0x70/0xa0
>
>     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
>
>     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
>     Reported-by: Dmitry Vyukov <dvyukov@google.com>
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b63b367a94e8..e4e517a51860 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -280,6 +280,23 @@ static noinline void __init
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
> @@ -734,6 +751,7 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_oob_memset_4();
>         kmalloc_oob_memset_8();
>         kmalloc_oob_memset_16();
> +       kmalloc_memmove_invalid_size;
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2277b82902d8..5fd377af7457 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> +       if(!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +               return NULL;

Overall approach looks good to me.
A good question is what we should return here. All bets are off after
a report, but we still try to "minimize damage". One may argue for
returning addr here and in other functions. But the more I think about
this, the more I think it does not matter.


>         return __memset(addr, c, len);
>  }
> @@ -110,7 +111,8 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> +       if(!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> +               return NULL;
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>         return __memmove(dest, src, len);
> @@ -119,7 +121,8 @@ void *memmove(void *dest, const void *src, size_t
> len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> +       if(!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> +               return NULL;
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>         return __memcpy(dest, src, len);
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
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0e5f965f1882..0cd317ef30f5 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -68,11 +68,16 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
>
>  static void print_error_description(struct kasan_access_info *info)
>  {
> -       pr_err("BUG: KASAN: %s in %pS\n",
> -               get_bug_type(info), (void *)info->ip);
> -       pr_err("%s of size %zu at addr %px by task %s/%d\n",
> -               info->is_write ? "Write" : "Read", info->access_size,
> -               info->access_addr, current->comm, task_pid_nr(current));
> +       if ((long)info->access_size < 0) {
> +               pr_err("BUG: KASAN: invalid size %zu in %pS\n",
> +                       info->access_size, (void *)info->ip);

I would not introduce a new bug type.
These are parsed and used by some systems, e.g. syzbot. If size is
user-controllable, then a new bug type for this will mean 2 bug
reports.
It also won't harm to print Read/Write, definitely the address, so no
reason to special case this out of a dozen of report formats.
This can qualify as out-of-bounds (definitely will cross some
bounds!), so I would change get_bug_type() to return
"slab-out-of-bounds" (as the most common OOB) in such case (with a
comment).


> +       } else {
> +               pr_err("BUG: KASAN: %s in %pS\n",
> +                       get_bug_type(info), (void *)info->ip);
> +               pr_err("%s of size %zu at addr %px by task %s/%d\n",
> +                       info->is_write ? "Write" : "Read", info->access_size,
> +                       info->access_addr, current->comm, task_pid_nr(current));
> +       }
>  }
>
>  static DEFINE_SPINLOCK(report_lock);
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
>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1570110681.19702.64.camel%40mtksdccf07.
