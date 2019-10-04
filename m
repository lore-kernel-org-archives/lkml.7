Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC75C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FEF21848
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfJDEma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:42:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727589AbfJDEma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:42:30 -0400
X-UUID: a5b84de73c1b4932be65f10a106b7541-20191004
X-UUID: a5b84de73c1b4932be65f10a106b7541-20191004
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 935648087; Fri, 04 Oct 2019 12:42:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Oct 2019 12:42:20 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Oct 2019 12:42:20 +0800
Message-ID: <1570164140.19702.97.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 4 Oct 2019 12:42:20 +0800
In-Reply-To: <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <1570018513.19702.36.camel@mtksdccf07>
         <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
         <1570069078.19702.57.camel@mtksdccf07>
         <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
         <1570095525.19702.59.camel@mtksdccf07>
         <1570110681.19702.64.camel@mtksdccf07>
         <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 16:53 +0200, Dmitry Vyukov wrote:
> On Thu, Oct 3, 2019 at 3:51 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:>
> > how about this?
> >
> > commit fd64691026e7ccb8d2946d0804b0621ac177df38
> > Author: Walter Wu <walter-zh.wu@mediatek.com>
> > Date:   Fri Sep 27 09:54:18 2019 +0800
> >
> >     kasan: detect invalid size in memory operation function
> >
> >     It is an undefined behavior to pass a negative value to
> > memset()/memcpy()/memmove()
> >     , so need to be detected by KASAN.
> >
> >     KASAN report:
> >
> >      BUG: KASAN: invalid size 18446744073709551614 in
> > kmalloc_memmove_invalid_size+0x70/0xa0
> >
> >      CPU: 1 PID: 91 Comm: cat Not tainted
> > 5.3.0-rc1ajb-00001-g31943bbc21ce-dirty #7
> >      Hardware name: linux,dummy-virt (DT)
> >      Call trace:
> >       dump_backtrace+0x0/0x278
> >       show_stack+0x14/0x20
> >       dump_stack+0x108/0x15c
> >       print_address_description+0x64/0x368
> >       __kasan_report+0x108/0x1a4
> >       kasan_report+0xc/0x18
> >       check_memory_region+0x15c/0x1b8
> >       memmove+0x34/0x88
> >       kmalloc_memmove_invalid_size+0x70/0xa0
> >
> >     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> >
> >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> >     Reported-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index b63b367a94e8..e4e517a51860 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -280,6 +280,23 @@ static noinline void __init
> > kmalloc_oob_in_memset(void)
> >         kfree(ptr);
> >  }
> >
> > +static noinline void __init kmalloc_memmove_invalid_size(void)
> > +{
> > +       char *ptr;
> > +       size_t size = 64;
> > +
> > +       pr_info("invalid size in memmove\n");
> > +       ptr = kmalloc(size, GFP_KERNEL);
> > +       if (!ptr) {
> > +               pr_err("Allocation failed\n");
> > +               return;
> > +       }
> > +
> > +       memset((char *)ptr, 0, 64);
> > +       memmove((char *)ptr, (char *)ptr + 4, -2);
> > +       kfree(ptr);
> > +}
> > +
> >  static noinline void __init kmalloc_uaf(void)
> >  {
> >         char *ptr;
> > @@ -734,6 +751,7 @@ static int __init kmalloc_tests_init(void)
> >         kmalloc_oob_memset_4();
> >         kmalloc_oob_memset_8();
> >         kmalloc_oob_memset_16();
> > +       kmalloc_memmove_invalid_size;
> >         kmalloc_uaf();
> >         kmalloc_uaf_memset();
> >         kmalloc_uaf2();
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 2277b82902d8..5fd377af7457 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> >  #undef memset
> >  void *memset(void *addr, int c, size_t len)
> >  {
> > -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > +       if(!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > +               return NULL;
> 
> Overall approach looks good to me.
> A good question is what we should return here. All bets are off after
> a report, but we still try to "minimize damage". One may argue for
> returning addr here and in other functions. But the more I think about
> this, the more I think it does not matter.
> 
agreed

> 
> >         return __memset(addr, c, len);
> >  }
> > @@ -110,7 +111,8 @@ void *memset(void *addr, int c, size_t len)
> >  #undef memmove
> >  void *memmove(void *dest, const void *src, size_t len)
> >  {
> > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > +       if(!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> > +               return NULL;
> >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> >
> >         return __memmove(dest, src, len);
> > @@ -119,7 +121,8 @@ void *memmove(void *dest, const void *src, size_t
> > len)
> >  #undef memcpy
> >  void *memcpy(void *dest, const void *src, size_t len)
> >  {
> > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > +       if(!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> > +               return NULL;
> >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> >
> >         return __memcpy(dest, src, len);
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index 616f9dd82d12..02148a317d27 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -173,6 +173,11 @@ static __always_inline bool
> > check_memory_region_inline(unsigned long addr,
> >         if (unlikely(size == 0))
> >                 return true;
> >
> > +       if (unlikely((long)size < 0)) {
> > +               kasan_report(addr, size, write, ret_ip);
> > +               return false;
> > +       }
> > +
> >         if (unlikely((void *)addr <
> >                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> >                 kasan_report(addr, size, write, ret_ip);
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 0e5f965f1882..0cd317ef30f5 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -68,11 +68,16 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
> >
> >  static void print_error_description(struct kasan_access_info *info)
> >  {
> > -       pr_err("BUG: KASAN: %s in %pS\n",
> > -               get_bug_type(info), (void *)info->ip);
> > -       pr_err("%s of size %zu at addr %px by task %s/%d\n",
> > -               info->is_write ? "Write" : "Read", info->access_size,
> > -               info->access_addr, current->comm, task_pid_nr(current));
> > +       if ((long)info->access_size < 0) {
> > +               pr_err("BUG: KASAN: invalid size %zu in %pS\n",
> > +                       info->access_size, (void *)info->ip);
> 
> I would not introduce a new bug type.
> These are parsed and used by some systems, e.g. syzbot. If size is
> user-controllable, then a new bug type for this will mean 2 bug
> reports.
> It also won't harm to print Read/Write, definitely the address, so no
> reason to special case this out of a dozen of report formats.
> This can qualify as out-of-bounds (definitely will cross some
> bounds!), so I would change get_bug_type() to return
> "slab-out-of-bounds" (as the most common OOB) in such case (with a
> comment).
> 
Print Read/Write and address information, it is ok.
But if we can directly point to the root cause of this problem, why we
not do it?  see 1) and 2) to get a point, if we print OOB, then user
needs one minute to think what is root case of this problem, but if we
print invalid size, then user can directly get root case. this is my
original thinking.
1)Invalid size is true then OOB is true.
2)OOB is true then invalid size may be true or false.

But I see you say some systems have used bug report so that avoid this
trouble, i will print the wrong type is "out-of-bound" in a unified way
when size<0.


