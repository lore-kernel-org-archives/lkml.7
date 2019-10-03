Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0161C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0614222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJCJiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:38:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31811 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728743AbfJCJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:38:52 -0400
X-UUID: 83d216c888f543e887d8043adfa60921-20191003
X-UUID: 83d216c888f543e887d8043adfa60921-20191003
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1843083875; Thu, 03 Oct 2019 17:38:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Oct 2019 17:38:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Oct 2019 17:38:44 +0800
Message-ID: <1570095525.19702.59.camel@mtksdccf07>
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
Date:   Thu, 3 Oct 2019 17:38:45 +0800
In-Reply-To: <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <1570018513.19702.36.camel@mtksdccf07>
         <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
         <1570069078.19702.57.camel@mtksdccf07>
         <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 08:26 +0200, Dmitry Vyukov wrote:
> On Thu, Oct 3, 2019 at 4:18 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > On Wed, 2019-10-02 at 15:57 +0200, Dmitry Vyukov wrote:
> > > On Wed, Oct 2, 2019 at 2:15 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > >
> > > > On Mon, 2019-09-30 at 12:36 +0800, Walter Wu wrote:
> > > > > On Fri, 2019-09-27 at 21:41 +0200, Dmitry Vyukov wrote:
> > > > > > On Fri, Sep 27, 2019 at 4:22 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > >
> > > > > > > On Fri, 2019-09-27 at 15:07 +0200, Dmitry Vyukov wrote:
> > > > > > > > On Fri, Sep 27, 2019 at 5:43 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > > > >
> > > > > > > > > memmove() and memcpy() have missing underflow issues.
> > > > > > > > > When -7 <= size < 0, then KASAN will miss to catch the underflow issue.
> > > > > > > > > It looks like shadow start address and shadow end address is the same,
> > > > > > > > > so it does not actually check anything.
> > > > > > > > >
> > > > > > > > > The following test is indeed not caught by KASAN:
> > > > > > > > >
> > > > > > > > >         char *p = kmalloc(64, GFP_KERNEL);
> > > > > > > > >         memset((char *)p, 0, 64);
> > > > > > > > >         memmove((char *)p, (char *)p + 4, -2);
> > > > > > > > >         kfree((char*)p);
> > > > > > > > >
> > > > > > > > > It should be checked here:
> > > > > > > > >
> > > > > > > > > void *memmove(void *dest, const void *src, size_t len)
> > > > > > > > > {
> > > > > > > > >         check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > > > >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > > > >
> > > > > > > > >         return __memmove(dest, src, len);
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > We fix the shadow end address which is calculated, then generic KASAN
> > > > > > > > > get the right shadow end address and detect this underflow issue.
> > > > > > > > >
> > > > > > > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > > > >
> > > > > > > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > > > > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > > > > ---
> > > > > > > > >  lib/test_kasan.c   | 36 ++++++++++++++++++++++++++++++++++++
> > > > > > > > >  mm/kasan/generic.c |  8 ++++++--
> > > > > > > > >  2 files changed, 42 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > > > > > > > index b63b367a94e8..8bd014852556 100644
> > > > > > > > > --- a/lib/test_kasan.c
> > > > > > > > > +++ b/lib/test_kasan.c
> > > > > > > > > @@ -280,6 +280,40 @@ static noinline void __init kmalloc_oob_in_memset(void)
> > > > > > > > >         kfree(ptr);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static noinline void __init kmalloc_oob_in_memmove_underflow(void)
> > > > > > > > > +{
> > > > > > > > > +       char *ptr;
> > > > > > > > > +       size_t size = 64;
> > > > > > > > > +
> > > > > > > > > +       pr_info("underflow out-of-bounds in memmove\n");
> > > > > > > > > +       ptr = kmalloc(size, GFP_KERNEL);
> > > > > > > > > +       if (!ptr) {
> > > > > > > > > +               pr_err("Allocation failed\n");
> > > > > > > > > +               return;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       memset((char *)ptr, 0, 64);
> > > > > > > > > +       memmove((char *)ptr, (char *)ptr + 4, -2);
> > > > > > > > > +       kfree(ptr);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static noinline void __init kmalloc_oob_in_memmove_overflow(void)
> > > > > > > > > +{
> > > > > > > > > +       char *ptr;
> > > > > > > > > +       size_t size = 64;
> > > > > > > > > +
> > > > > > > > > +       pr_info("overflow out-of-bounds in memmove\n");
> > > > > > > > > +       ptr = kmalloc(size, GFP_KERNEL);
> > > > > > > > > +       if (!ptr) {
> > > > > > > > > +               pr_err("Allocation failed\n");
> > > > > > > > > +               return;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       memset((char *)ptr, 0, 64);
> > > > > > > > > +       memmove((char *)ptr + size, (char *)ptr, 2);
> > > > > > > > > +       kfree(ptr);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static noinline void __init kmalloc_uaf(void)
> > > > > > > > >  {
> > > > > > > > >         char *ptr;
> > > > > > > > > @@ -734,6 +768,8 @@ static int __init kmalloc_tests_init(void)
> > > > > > > > >         kmalloc_oob_memset_4();
> > > > > > > > >         kmalloc_oob_memset_8();
> > > > > > > > >         kmalloc_oob_memset_16();
> > > > > > > > > +       kmalloc_oob_in_memmove_underflow();
> > > > > > > > > +       kmalloc_oob_in_memmove_overflow();
> > > > > > > > >         kmalloc_uaf();
> > > > > > > > >         kmalloc_uaf_memset();
> > > > > > > > >         kmalloc_uaf2();
> > > > > > > > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > > > > > > > index 616f9dd82d12..34ca23d59e67 100644
> > > > > > > > > --- a/mm/kasan/generic.c
> > > > > > > > > +++ b/mm/kasan/generic.c
> > > > > > > > > @@ -131,9 +131,13 @@ static __always_inline bool memory_is_poisoned_n(unsigned long addr,
> > > > > > > > >                                                 size_t size)
> > > > > > > > >  {
> > > > > > > > >         unsigned long ret;
> > > > > > > > > +       void *shadow_start = kasan_mem_to_shadow((void *)addr);
> > > > > > > > > +       void *shadow_end = kasan_mem_to_shadow((void *)addr + size - 1) + 1;
> > > > > > > > >
> > > > > > > > > -       ret = memory_is_nonzero(kasan_mem_to_shadow((void *)addr),
> > > > > > > > > -                       kasan_mem_to_shadow((void *)addr + size - 1) + 1);
> > > > > > > > > +       if ((long)size < 0)
> > > > > > > > > +               shadow_end = kasan_mem_to_shadow((void *)addr + size);
> > > > > > > >
> > > > > > > > Hi Walter,
> > > > > > > >
> > > > > > > > Thanks for working on this.
> > > > > > > >
> > > > > > > > If size<0, does it make sense to continue at all? We will still check
> > > > > > > > 1PB of shadow memory? What happens when we pass such huge range to
> > > > > > > > memory_is_nonzero?
> > > > > > > > Perhaps it's better to produce an error and bail out immediately if size<0?
> > > > > > >
> > > > > > > I agree with what you said. when size<0, it is indeed an unreasonable
> > > > > > > behavior, it should be blocked from continuing to do.
> > > > > > >
> > > > > > >
> > > > > > > > Also, what's the failure mode of the tests? Didn't they badly corrupt
> > > > > > > > memory? We tried to keep tests such that they produce the KASAN
> > > > > > > > reports, but don't badly corrupt memory b/c/ we need to run all of
> > > > > > > > them.
> > > > > > >
> > > > > > > Maybe we should first produce KASAN reports and then go to execute
> > > > > > > memmove() or do nothing? It looks like it’s doing the following.or?
> > > > > > >
> > > > > > > void *memmove(void *dest, const void *src, size_t len)
> > > > > > >  {
> > > > > > > +       if (long(len) <= 0)
> > > > > >
> > > > > > /\/\/\/\/\/\
> > > > > >
> > > > > > This check needs to be inside of check_memory_region, otherwise we
> > > > > > will have similar problems in all other places that use
> > > > > > check_memory_region.
> > > > > Thanks for your reminder.
> > > > >
> > > > >  bool check_memory_region(unsigned long addr, size_t size, bool write,
> > > > >                                 unsigned long ret_ip)
> > > > >  {
> > > > > +       if (long(size) < 0) {
> > > > > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > > > > +               return false;
> > > > > +       }
> > > > > +
> > > > >         return check_memory_region_inline(addr, size, write, ret_ip);
> > > > >  }
> > > > >
> > > > > > But check_memory_region already returns a bool, so we could check that
> > > > > > bool and return early.
> > > > >
> > > > > When size<0, we should only show one KASAN report, and should we only
> > > > > limit to return when size<0 is true? If yse, then __memmove() will do
> > > > > nothing.
> > > > >
> > > > >
> > > > >  void *memmove(void *dest, const void *src, size_t len)
> > > > >  {
> > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > +       if(!check_memory_region((unsigned long)src, len, false,
> > > > > _RET_IP_)
> > > > > +               && long(size) < 0)
> > > > > +               return;
> > > > > +
> > > > >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > >
> > > > >         return __memmove(dest, src, len);
> > > > >
> > > > > >
> > > > Hi Dmitry,
> > > >
> > > > What do you think the following code is better than the above one.
> > > > In memmmove/memset/memcpy, they need to determine whether size < 0 is
> > > > true. we directly determine whether size is negative in memmove and
> > > > return early. it avoid to generate repeated KASAN report. Is it better?
> > > >
> > > > void *memmove(void *dest, const void *src, size_t len)
> > > > {
> > > > +       if (long(size) < 0) {
> > > > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > > > +               return;
> > > > +       }
> > > > +
> > > >         check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > >
> > > >
> > > > check_memory_region() still has to check whether the size is negative.
> > > > but memmove/memset/memcpy generate invalid size KASAN report will not be
> > > > there.
> > >
> > >
> > > If check_memory_region() will do the check, why do we need to
> > > duplicate it inside of memmove and all other range functions?
> > >
> > Yes, I know it has duplication, but if we don't have to determine size<0
> > in memmove, then all check_memory_region return false will do nothing,
> 
> But they will produce a KASAN report, right? They are asked to check
> if 18446744073709551614 bytes are good. 18446744073709551614 bytes
> can't be good.
> 
> 
> > it includes other memory corruption behaviors, this is my original
> > concern.
> >
> > > I would do:
> > >
> > > void *memmove(void *dest, const void *src, size_t len)
> > > {
> > >         if (check_memory_region((unsigned long)src, len, false, _RET_IP_))
> > >                 return;
> > if check_memory_region return TRUE is to do nothing, but it is no memory
> > corruption? Should it return early when check_memory_region return a
> > FALSE?
> 
> Maybe. I just meant the overall idea: check_memory_region should
> detect that 18446744073709551614 bytes are bad, print an error, return
> an indication that bytes were bad, memmove should return early if the
> range is bad.
> 
ok, i will send new patch.
Thanks for your review.

> 
> > > This avoids duplicating the check, adds minimal amount of code to
> > > range functions and avoids adding kasan_report_invalid_size.
> > Thanks for your suggestion.
> > We originally want to show complete information(destination address,
> > source address, and its length), but add minimal amount of code into
> > kasan_report(), it should be good.
> >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1570069078.19702.57.camel%40mtksdccf07.


