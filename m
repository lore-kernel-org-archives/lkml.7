Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D4ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E1A21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHYPKcnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfJGMUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:20:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43696 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:20:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id c4so6078143qtn.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foEkWUCM575fnsqo6dD50iM97OZJEympj2lwIIE9A5g=;
        b=LHYPKcnfysh/Caiq374/gthsrLoIyk3tHXauOq+eeVZLHdbJJfrDcvWMnP2YRDOG4y
         o5uB6vwOOlA557aaOrvSnrvdUsLdP6tDbE57H4KMJFVNh3LP+hyNKyQWB8mgP6sbfMwk
         7mj/gcuVz6UtV+hEqDDnDPAm8v9hZdZpVm3cCRfysjB5nenQdwqdBbxgL46F9xMZv/tY
         8lycVZo65X1EijvrwASG3VLPlK2s6MohOoUoZ9qq8JkoaFH4dF54hK4Bz5PT5q73wR72
         cEvq0/v0xrIYrPBFoQZotC6HP9bsE82nGsWHRSnVk6yzliex7OHgj34KO9NeiwPN+CYu
         4GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foEkWUCM575fnsqo6dD50iM97OZJEympj2lwIIE9A5g=;
        b=mki4muQbVXo9PbGa7BLhLJRaM1rtPqkkoUTrbSkmyKjI/XZT4JBqBnex32SuVFUamJ
         UbEPvt33dJtIjxv7KbJK9eCM1Kjbmg7auyKMhnxuuaDDyCiZudkypc8i63/72Ra4yMrf
         DKFpke9xLfrBW6HKgd79RvE5UIfs05IgAVHLJlRFggMiB7JeDDY6LtHA4l4IwXKSrl+f
         qQELTioiqs9/9IHvgSUht4TgsKIMA3BqlBwP5rEHwP55z+BMK1dMXeAAWqEy0o/16469
         j2Ht/Iwd3Tpu9RUaJhj+c0SrHRMR328yznab2a1NhkL2bySF6mH/T5k1eUPgkxPyg18x
         /DQA==
X-Gm-Message-State: APjAAAXs9CPmf84VZVLaDqFBR7UpdDnW0TCx64seWqiB/OCATJxrSiM8
        rXoMbJUGD2kQFt2N1/IoAemBkVrta7Lp9e5dtHqTDoD9KH4=
X-Google-Smtp-Source: APXvYqwd0VtKG/ssBM8w+azUJA7VLtUFK0uvly01KrSBiPL8XWh9b9V7ijucaxueKzu4MiMHLgWkXKNRUS58zXWZCeU=
X-Received: by 2002:ac8:108b:: with SMTP id a11mr29317165qtj.380.1570450806687;
 Mon, 07 Oct 2019 05:20:06 -0700 (PDT)
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
 <1570418576.4686.30.camel@mtksdccf07> <CACT4Y+aho7BEvQstd2+a2be-jJ0dEsjGebH7bcUFhYp-PoRDxQ@mail.gmail.com>
 <1570436289.4686.40.camel@mtksdccf07> <CACT4Y+Z6QObZ2fvVxSmvv16YQAu4GswOqfOVQK_1_Ncz0eir_g@mail.gmail.com>
 <1570438317.4686.44.camel@mtksdccf07> <CACT4Y+Yc86bKxDp4ST8+49rzLOWkTXLkjs0eyFtohCi_uSjmLQ@mail.gmail.com>
 <1570439032.4686.50.camel@mtksdccf07> <CACT4Y+YL=8jFXrj2LOuQV7ZyDe-am4W8y1WHEDJJ0-mVNJ3_Cw@mail.gmail.com>
 <1570440492.4686.59.camel@mtksdccf07> <1570441833.4686.66.camel@mtksdccf07>
 <CACT4Y+Z0A=Zi4AxEjn4jpHk0xG9+Nh2Q-OYEnOmooW0wN-_vfQ@mail.gmail.com> <1570449804.4686.79.camel@mtksdccf07>
In-Reply-To: <1570449804.4686.79.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 14:19:54 +0200
Message-ID: <CACT4Y+b4VX5cW3WhP6o3zyKxHjNZRo1Lokxr0+MwDcB5hV5K+A@mail.gmail.com>
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

On Mon, Oct 7, 2019 at 2:03 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > > > > On Mon, Oct 7, 2019 at 10:18 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > > > > > The patchsets help to produce KASAN report when size is negative numbers
> > > > > > > > > > in memory operation function. It is helpful for programmer to solve the
> > > > > > > > > > undefined behavior issue. Patch 1 based on Dmitry's review and
> > > > > > > > > > suggestion, patch 2 is a test in order to verify the patch 1.
> > > > > > > > > >
> > > > > > > > > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > > > > > [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
> > > > > > > > > >
> > > > > > > > > > Walter Wu (2):
> > > > > > > > > > kasan: detect invalid size in memory operation function
> > > > > > > > > > kasan: add test for invalid size in memmove
> > > > > > > > > >
> > > > > > > > > >  lib/test_kasan.c          | 18 ++++++++++++++++++
> > > > > > > > > >  mm/kasan/common.c         | 13 ++++++++-----
> > > > > > > > > >  mm/kasan/generic.c        |  5 +++++
> > > > > > > > > >  mm/kasan/generic_report.c | 12 ++++++++++++
> > > > > > > > > >  mm/kasan/tags.c           |  5 +++++
> > > > > > > > > >  mm/kasan/tags_report.c    | 12 ++++++++++++
> > > > > > > > > >  6 files changed, 60 insertions(+), 5 deletions(-)
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > commit 5b3b68660b3d420fd2bd792f2d9fd3ccb8877ef7
> > > > > > > > > > Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
> > > > > > > > > > Date:   Fri Oct 4 18:38:31 2019 +0800
> > > > > > > > > >
> > > > > > > > > >     kasan: detect invalid size in memory operation function
> > > > > > > > > >
> > > > > > > > > >     It is an undefined behavior to pass a negative numbers to
> > > > > > > > > > memset()/memcpy()/memmove()
> > > > > > > > > >     , so need to be detected by KASAN.
> > > > > > > > > >
> > > > > > > > > >     If size is negative numbers, then it has two reasons to be defined
> > > > > > > > > > as out-of-bounds bug type.
> > > > > > > > > >     1) Casting negative numbers to size_t would indeed turn up as a
> > > > > > > > > > large
> > > > > > > > > >     size_t and its value will be larger than ULONG_MAX/2, so that this
> > > > > > > > > > can
> > > > > > > > > >     qualify as out-of-bounds.
> > > > > > > > > >     2) Don't generate new bug type in order to prevent duplicate reports
> > > > > > > > > > by
> > > > > > > > > >     some systems, e.g. syzbot.
> > > > > > > > > >
> > > > > > > > > >     KASAN report:
> > > > > > > > > >
> > > > > > > > > >      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > > > > > >      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> > > > > > > > > > cat/72
> > > > > > > > > >
> > > > > > > > > >      CPU: 2 PID: 72 Comm: cat Not tainted
> > > > > > > > > > 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
> > > > > > > > > >      Hardware name: linux,dummy-virt (DT)
> > > > > > > > > >      Call trace:
> > > > > > > > > >       dump_backtrace+0x0/0x288
> > > > > > > > > >       show_stack+0x14/0x20
> > > > > > > > > >       dump_stack+0x10c/0x164
> > > > > > > > > >       print_address_description.isra.9+0x68/0x378
> > > > > > > > > >       __kasan_report+0x164/0x1a0
> > > > > > > > > >       kasan_report+0xc/0x18
> > > > > > > > > >       check_memory_region+0x174/0x1d0
> > > > > > > > > >       memmove+0x34/0x88
> > > > > > > > > >       kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > > > > > >
> > > > > > > > > >     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > > > > >
> > > > > > > > > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > > > > > >     Reported -by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > > > > >     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > > > > >
> > > > > > > > > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > > > > > > > > index 6814d6d6a023..6ef0abd27f06 100644
> > > > > > > > > > --- a/mm/kasan/common.c
> > > > > > > > > > +++ b/mm/kasan/common.c
> > > > > > > > > > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> > > > > > > > > >  #undef memset
> > > > > > > > > >  void *memset(void *addr, int c, size_t len)
> > > > > > > > > >  {
> > > > > > > > > > -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > > > > > > > > > +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > > > > > > > > > +               return NULL;
> > > > > > > > > >
> > > > > > > > > >         return __memset(addr, c, len);
> > > > > > > > > >  }
> > > > > > > > > > @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
> > > > > > > > > >  #undef memmove
> > > > > > > > > >  void *memmove(void *dest, const void *src, size_t len)
> > > > > > > > > >  {
> > > > > > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > > > > > +               return NULL;
> > > > > > > > > >
> > > > > > > > > >         return __memmove(dest, src, len);
> > > > > > > > > >  }
> > > > > > > > > > @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t
> > > > > > > > > > len)
> > > > > > > > > >  #undef memcpy
> > > > > > > > > >  void *memcpy(void *dest, const void *src, size_t len)
> > > > > > > > > >  {
> > > > > > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > > > > > +               return NULL;
> > > > > > > > > >
> > > > > > > > > >         return __memcpy(dest, src, len);
> > > > > > > > > >  }
> > > > > > > > > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > > > > > > > > index 616f9dd82d12..02148a317d27 100644
> > > > > > > > > > --- a/mm/kasan/generic.c
> > > > > > > > > > +++ b/mm/kasan/generic.c
> > > > > > > > > > @@ -173,6 +173,11 @@ static __always_inline bool
> > > > > > > > > > check_memory_region_inline(unsigned long addr,
> > > > > > > > > >         if (unlikely(size == 0))
> > > > > > > > > >                 return true;
> > > > > > > > > >
> > > > > > > > > > +       if (unlikely((long)size < 0)) {
> > > > > > > > > > +               kasan_report(addr, size, write, ret_ip);
> > > > > > > > > > +               return false;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > >         if (unlikely((void *)addr <
> > > > > > > > > >                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > > > > > > > > >                 kasan_report(addr, size, write, ret_ip);
> > > > > > > > > > diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > > > > > > > > > index 36c645939bc9..ed0eb94cb811 100644
> > > > > > > > > > --- a/mm/kasan/generic_report.c
> > > > > > > > > > +++ b/mm/kasan/generic_report.c
> > > > > > > > > > @@ -107,6 +107,18 @@ static const char *get_wild_bug_type(struct
> > > > > > > > > > kasan_access_info *info)
> > > > > > > > > >
> > > > > > > > > >  const char *get_bug_type(struct kasan_access_info *info)
> > > > > > > > > >  {
> > > > > > > > > > +       /*
> > > > > > > > > > +        * If access_size is negative numbers, then it has two reasons
> > > > > > > > > > +        * to be defined as out-of-bounds bug type.
> > > > > > > > > > +        * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > > > > > > +        * a 'large' size_t and its value will be larger than ULONG_MAX/2,
> > > > > > > > > > +        * so that this can qualify as out-of-bounds.
> > > > > > > > > > +        * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > > > > > reports
> > > > > > > > > > +        * by some systems, e.g. syzbot.
> > > > > > > > > > +        */
> > > > > > > > > > +       if ((long)info->access_size < 0)
> > > > > > > > > > +               return "out-of-bounds";
> > > > > > > > >
> > > > > > > > > "out-of-bounds" is the _least_ frequent KASAN bug type. It won't
> > > > > > > > > prevent duplicates. "heap-out-of-bounds" is the frequent one.
> > > > > > > >
> > > > > > > >
> > > > > > > >     /*
> > > > > > > >      * If access_size is negative numbers, then it has two reasons
> > > > > > > >      * to be defined as out-of-bounds bug type.
> > > > > > > >      * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > > > >      * a  "large" size_t and its value will be larger than ULONG_MAX/2,
> > > > > > > >      *    so that this can qualify as out-of-bounds.
> > > > > > > >      * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > > > reports
> > > > > > > >      *    by some systems, e.g. syzbot. "out-of-bounds" is the _least_
> > > > > > > > frequent KASAN bug type.
> > > > > > > >      *    It won't prevent duplicates. "heap-out-of-bounds" is the
> > > > > > > > frequent one.
> > > > > > > >      */
> > > > > > > >
> > > > > > > > We directly add it into the comment.
> > > > > > >
> > > > > > >
> > > > > > > OK, let's start from the beginning: why do you return "out-of-bounds" here?
> > > > > > >
> > > > > > Uh, comment 1 and 2 should explain it. :)
> > > > >
> > > > > The comment says it will cause duplicate reports. It does not explain
> > > > > why you want syzbot to produce duplicate reports and spam kernel
> > > > > developers... So why do you want that?
> > > > >
> > > > We don't generate new bug type in order to prevent duplicate by some
> > > > systems, e.g. syzbot. Is it right? If yes, then it should not have
> > > > duplicate report.
> > > >
> > > Sorry, because we don't generate new bug type. it should be duplicate
> > > report(only one report which may be oob or size invlid),
> > > the duplicate report goal is that invalid size is oob issue, too.
> > >
> > > I would not introduce a new bug type.
> > > These are parsed and used by some systems, e.g. syzbot. If size is
> > > user-controllable, then a new bug type for this will mean 2 bug
> > > reports.
> >
> > To prevent duplicates, the new crash title must not just match _any_
> > crash title that kernel can potentially produce. It must match exactly
> > the crash that kernel produces for this bug on other input data.
> >
> > Consider, userspace passes size=123, KASAN produces "heap-out-of-bounds in foo".
> > Now userspace passes size=-1 and KASAN produces "invalid-size in foo".
> > This will be a duplicate bug report.
> > Now if KASAN will produce "out-of-bounds in foo", it will also lead to
> > a duplicate report.
> > Only iff KASAN will produce "heap-out-of-bounds in foo" for size=-1,
> > it will not lead to a duplicate report.
>
> I think it is not easy to avoid the duplicate report(mentioned above).
> As far as my knowledge is concerned, KASAN is memory corruption detector
> in kernel space, it should only detect memory corruption and don't
> distinguish whether it is passed by userspace. if we want to do, then we
> may need to parse backtrace to check if it has copy_form_user() or other
> function?

My idea was just to always print "heap-out-of-bounds" and don't
differentiate if the size come from userspace or not.
