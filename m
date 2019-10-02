Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBAFECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACF21D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOOnU4O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJBN5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:57:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35092 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:57:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so15063028qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V8brLeomy2wdADVlgEAXrAF/graRCxkPl6qeQ6D8/UY=;
        b=LOOnU4O6HcxEVeYMOxcLyNiuMD9UK6k0R1wPF+rwhxYGaqe/XchZ6Csj1aGv68sGmN
         PKQ3KzANtaY0LMUlkVOOzI6JQklPtF/el6EN2l7Nk2fe305qhqre7CAEehBp9mrJqyQ3
         tMJSjpFwxulrZz6rro8gay+6KIerqhJqR31JLqAqGBZ/fIWmK7IPkGchr1LxDknDi1Fq
         Rp//oB6uRcU2iFjwYvrlnq5P3wheTN97lNXsHU9yQUgFpq0w4L4b8vIKT0J4PYoVsXaf
         cuWGAmAgYkTu7xFeFIiLavBLXmAQi0EUoMiFL1pyJY8/zUco0XQdU8GjeQyjXc0HXN30
         wT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V8brLeomy2wdADVlgEAXrAF/graRCxkPl6qeQ6D8/UY=;
        b=h1uWaibi2RtnjTIjErE4wgYxHYBHoXcxoCi8KqGukK1O8Ypvn9RvWP7Ti55wfMUhCs
         z5A9NdbO5cTjyKoVMlhel0smYVbljjaan+bm+cYm3I0xy0z0BRfsaCxB+9DAWmD43Eo4
         D3905N7KkTiTMACN8EHGS5RejlBjEtV+BrwxV8Lq+58f2NK1D31xIKRE72wSi++JGgwj
         KS8nQhCTmbN7VzAucL7N8+9ztd245vGiqMvAunTxOMiVuQDuT4VuIFtuyMSfKRPfPoFq
         Rl2iMO18Tx8szG4eNE45hieXnAXxDFGpJT/UFTMmhOlWW2odSotriydDqllC9F5Y4q+x
         pwKA==
X-Gm-Message-State: APjAAAVuMTS61OkLuAAHW3J4nxzULLtx9SkKSLEBfk/OXx4AXpwPBZAO
        GY9CzvEIpa/j2vrj0J9S2Cq5jwbw3FhX3Z4AvCrOfQ==
X-Google-Smtp-Source: APXvYqx434i+iUN3OJfFezeHYd+JsYyA6TLa0wDk4YCxX6Uk6K4Yp35J4yfUIFzD0UAL5r7Psj+OiNGbCCdVnVKBQYc=
X-Received: by 2002:a37:d84:: with SMTP id 126mr3463814qkn.407.1570024648625;
 Wed, 02 Oct 2019 06:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <1570018513.19702.36.camel@mtksdccf07>
In-Reply-To: <1570018513.19702.36.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Oct 2019 15:57:16 +0200
Message-ID: <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:15 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2019-09-30 at 12:36 +0800, Walter Wu wrote:
> > On Fri, 2019-09-27 at 21:41 +0200, Dmitry Vyukov wrote:
> > > On Fri, Sep 27, 2019 at 4:22 PM Walter Wu <walter-zh.wu@mediatek.com>=
 wrote:
> > > >
> > > > On Fri, 2019-09-27 at 15:07 +0200, Dmitry Vyukov wrote:
> > > > > On Fri, Sep 27, 2019 at 5:43 AM Walter Wu <walter-zh.wu@mediatek.=
com> wrote:
> > > > > >
> > > > > > memmove() and memcpy() have missing underflow issues.
> > > > > > When -7 <=3D size < 0, then KASAN will miss to catch the underf=
low issue.
> > > > > > It looks like shadow start address and shadow end address is th=
e same,
> > > > > > so it does not actually check anything.
> > > > > >
> > > > > > The following test is indeed not caught by KASAN:
> > > > > >
> > > > > >         char *p =3D kmalloc(64, GFP_KERNEL);
> > > > > >         memset((char *)p, 0, 64);
> > > > > >         memmove((char *)p, (char *)p + 4, -2);
> > > > > >         kfree((char*)p);
> > > > > >
> > > > > > It should be checked here:
> > > > > >
> > > > > > void *memmove(void *dest, const void *src, size_t len)
> > > > > > {
> > > > > >         check_memory_region((unsigned long)src, len, false, _RE=
T_IP_);
> > > > > >         check_memory_region((unsigned long)dest, len, true, _RE=
T_IP_);
> > > > > >
> > > > > >         return __memmove(dest, src, len);
> > > > > > }
> > > > > >
> > > > > > We fix the shadow end address which is calculated, then generic=
 KASAN
> > > > > > get the right shadow end address and detect this underflow issu=
e.
> > > > > >
> > > > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D199341
> > > > > >
> > > > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > ---
> > > > > >  lib/test_kasan.c   | 36 ++++++++++++++++++++++++++++++++++++
> > > > > >  mm/kasan/generic.c |  8 ++++++--
> > > > > >  2 files changed, 42 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > > > > index b63b367a94e8..8bd014852556 100644
> > > > > > --- a/lib/test_kasan.c
> > > > > > +++ b/lib/test_kasan.c
> > > > > > @@ -280,6 +280,40 @@ static noinline void __init kmalloc_oob_in=
_memset(void)
> > > > > >         kfree(ptr);
> > > > > >  }
> > > > > >
> > > > > > +static noinline void __init kmalloc_oob_in_memmove_underflow(v=
oid)
> > > > > > +{
> > > > > > +       char *ptr;
> > > > > > +       size_t size =3D 64;
> > > > > > +
> > > > > > +       pr_info("underflow out-of-bounds in memmove\n");
> > > > > > +       ptr =3D kmalloc(size, GFP_KERNEL);
> > > > > > +       if (!ptr) {
> > > > > > +               pr_err("Allocation failed\n");
> > > > > > +               return;
> > > > > > +       }
> > > > > > +
> > > > > > +       memset((char *)ptr, 0, 64);
> > > > > > +       memmove((char *)ptr, (char *)ptr + 4, -2);
> > > > > > +       kfree(ptr);
> > > > > > +}
> > > > > > +
> > > > > > +static noinline void __init kmalloc_oob_in_memmove_overflow(vo=
id)
> > > > > > +{
> > > > > > +       char *ptr;
> > > > > > +       size_t size =3D 64;
> > > > > > +
> > > > > > +       pr_info("overflow out-of-bounds in memmove\n");
> > > > > > +       ptr =3D kmalloc(size, GFP_KERNEL);
> > > > > > +       if (!ptr) {
> > > > > > +               pr_err("Allocation failed\n");
> > > > > > +               return;
> > > > > > +       }
> > > > > > +
> > > > > > +       memset((char *)ptr, 0, 64);
> > > > > > +       memmove((char *)ptr + size, (char *)ptr, 2);
> > > > > > +       kfree(ptr);
> > > > > > +}
> > > > > > +
> > > > > >  static noinline void __init kmalloc_uaf(void)
> > > > > >  {
> > > > > >         char *ptr;
> > > > > > @@ -734,6 +768,8 @@ static int __init kmalloc_tests_init(void)
> > > > > >         kmalloc_oob_memset_4();
> > > > > >         kmalloc_oob_memset_8();
> > > > > >         kmalloc_oob_memset_16();
> > > > > > +       kmalloc_oob_in_memmove_underflow();
> > > > > > +       kmalloc_oob_in_memmove_overflow();
> > > > > >         kmalloc_uaf();
> > > > > >         kmalloc_uaf_memset();
> > > > > >         kmalloc_uaf2();
> > > > > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > > > > index 616f9dd82d12..34ca23d59e67 100644
> > > > > > --- a/mm/kasan/generic.c
> > > > > > +++ b/mm/kasan/generic.c
> > > > > > @@ -131,9 +131,13 @@ static __always_inline bool memory_is_pois=
oned_n(unsigned long addr,
> > > > > >                                                 size_t size)
> > > > > >  {
> > > > > >         unsigned long ret;
> > > > > > +       void *shadow_start =3D kasan_mem_to_shadow((void *)addr=
);
> > > > > > +       void *shadow_end =3D kasan_mem_to_shadow((void *)addr +=
 size - 1) + 1;
> > > > > >
> > > > > > -       ret =3D memory_is_nonzero(kasan_mem_to_shadow((void *)a=
ddr),
> > > > > > -                       kasan_mem_to_shadow((void *)addr + size=
 - 1) + 1);
> > > > > > +       if ((long)size < 0)
> > > > > > +               shadow_end =3D kasan_mem_to_shadow((void *)addr=
 + size);
> > > > >
> > > > > Hi Walter,
> > > > >
> > > > > Thanks for working on this.
> > > > >
> > > > > If size<0, does it make sense to continue at all? We will still c=
heck
> > > > > 1PB of shadow memory? What happens when we pass such huge range t=
o
> > > > > memory_is_nonzero?
> > > > > Perhaps it's better to produce an error and bail out immediately =
if size<0?
> > > >
> > > > I agree with what you said. when size<0, it is indeed an unreasonab=
le
> > > > behavior, it should be blocked from continuing to do.
> > > >
> > > >
> > > > > Also, what's the failure mode of the tests? Didn't they badly cor=
rupt
> > > > > memory? We tried to keep tests such that they produce the KASAN
> > > > > reports, but don't badly corrupt memory b/c/ we need to run all o=
f
> > > > > them.
> > > >
> > > > Maybe we should first produce KASAN reports and then go to execute
> > > > memmove() or do nothing? It looks like it=E2=80=99s doing the follo=
wing.or?
> > > >
> > > > void *memmove(void *dest, const void *src, size_t len)
> > > >  {
> > > > +       if (long(len) <=3D 0)
> > >
> > > /\/\/\/\/\/\
> > >
> > > This check needs to be inside of check_memory_region, otherwise we
> > > will have similar problems in all other places that use
> > > check_memory_region.
> > Thanks for your reminder.
> >
> >  bool check_memory_region(unsigned long addr, size_t size, bool write,
> >                                 unsigned long ret_ip)
> >  {
> > +       if (long(size) < 0) {
> > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > +               return false;
> > +       }
> > +
> >         return check_memory_region_inline(addr, size, write, ret_ip);
> >  }
> >
> > > But check_memory_region already returns a bool, so we could check tha=
t
> > > bool and return early.
> >
> > When size<0, we should only show one KASAN report, and should we only
> > limit to return when size<0 is true? If yse, then __memmove() will do
> > nothing.
> >
> >
> >  void *memmove(void *dest, const void *src, size_t len)
> >  {
> > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > +       if(!check_memory_region((unsigned long)src, len, false,
> > _RET_IP_)
> > +               && long(size) < 0)
> > +               return;
> > +
> >         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> >
> >         return __memmove(dest, src, len);
> >
> > >
> Hi Dmitry,
>
> What do you think the following code is better than the above one.
> In memmmove/memset/memcpy, they need to determine whether size < 0 is
> true. we directly determine whether size is negative in memmove and
> return early. it avoid to generate repeated KASAN report. Is it better?
>
> void *memmove(void *dest, const void *src, size_t len)
> {
> +       if (long(size) < 0) {
> +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> +               return;
> +       }
> +
>         check_memory_region((unsigned long)src, len, false, _RET_IP_);
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>
> check_memory_region() still has to check whether the size is negative.
> but memmove/memset/memcpy generate invalid size KASAN report will not be
> there.


If check_memory_region() will do the check, why do we need to
duplicate it inside of memmove and all other range functions?

I would do:

void *memmove(void *dest, const void *src, size_t len)
{
        if (check_memory_region((unsigned long)src, len, false, _RET_IP_))
                return;

This avoids duplicating the check, adds minimal amount of code to
range functions and avoids adding kasan_report_invalid_size.
