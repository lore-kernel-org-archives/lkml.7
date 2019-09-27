Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC301C388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B0E21920
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd7UFaaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfI0TmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:42:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39550 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0TmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:42:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so8727321qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdzRgDBYfpDpx6nQGoKtzOVBfnyfeeybzCuIbLx6fB0=;
        b=vd7UFaaCwZgwqj99f2MT2fg1i7UohnHUXSkw5kpwYYUuVyfF4NY7tXNUGXOUsiEO3P
         shdnQNc5wxu1/O33dxfYRABCvuhgeW4T6LLI7tdyA07lQ47bZXE0aiwnmHVBazIp+3a7
         iwOr3AAltu1Cestvony074R+ccYJqgPHN1Akym1g1Tf7rGXjIIh1JOa+SSnK7nW02eLY
         h4qjRMGCsXcpObwDuRS5McCmDPPJD8LHAC/vLTRxYxqLydRfv0Yz8D7kq2v2blrRjCp9
         J72ozpCexcuAdzPZbjlNJuPxLZc2LG5oyM/lDXxwWoJiX7bKdEC22v4kTrOHkXUDtTjp
         Hhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdzRgDBYfpDpx6nQGoKtzOVBfnyfeeybzCuIbLx6fB0=;
        b=fdQz4Un1/Ho4j9wcLNQDvBGXt5dQ3FiVML9VnMkMslM6wkBM51duKewhPigFo8aCfh
         U5D6Mv7VKF9K8gFSr5Q11O1szsI+8ILBQJLXqYN+MNt+7euOlvsSB9y6FbZ6ve0fq+7z
         GOP64zWypUVac3qcG4s/CqqeEkK7pyvfE0ATQ/bxQWi7v+gSOpW5Q1638qaX/0Svb9sh
         DHeQlsxncJcI4uENuVVvnrJwKxbJFLYi7b6I4XoLpFvZHGXpKOlpryYRuEFQ1VP73u83
         1W01UwnBuBzPZ94glzM/dOqsnjWpzQUaLVo9IOlLpUeXxZGaku2Md1AYZ1HezC6oqDnv
         ntPQ==
X-Gm-Message-State: APjAAAXet5xotA7bSQImb69tnqpKxaP9MD+dX/QOjZSOJeGTfNmwqqlU
        OqFyejJ5A1I00bpJaUSg6uE6/imYDpUc6m3Ie1BT7Rd4NlypFA==
X-Google-Smtp-Source: APXvYqzqpcwN1/R5qfSA7dnHPXsglqSOVgIT6kFMUwfYvP8xw2g7HmTutaLnVS58EaBwe1aQG/qkZ5GWj85+rzJ42MA=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr12175862qtr.50.1569613322867;
 Fri, 27 Sep 2019 12:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com> <1569594142.9045.24.camel@mtksdccf07>
In-Reply-To: <1569594142.9045.24.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Sep 2019 21:41:51 +0200
Message-ID: <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
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

On Fri, Sep 27, 2019 at 4:22 PM Walter Wu <walter-zh.wu@mediatek.com> wrote=
:
>
> On Fri, 2019-09-27 at 15:07 +0200, Dmitry Vyukov wrote:
> > On Fri, Sep 27, 2019 at 5:43 AM Walter Wu <walter-zh.wu@mediatek.com> w=
rote:
> > >
> > > memmove() and memcpy() have missing underflow issues.
> > > When -7 <=3D size < 0, then KASAN will miss to catch the underflow is=
sue.
> > > It looks like shadow start address and shadow end address is the same=
,
> > > so it does not actually check anything.
> > >
> > > The following test is indeed not caught by KASAN:
> > >
> > >         char *p =3D kmalloc(64, GFP_KERNEL);
> > >         memset((char *)p, 0, 64);
> > >         memmove((char *)p, (char *)p + 4, -2);
> > >         kfree((char*)p);
> > >
> > > It should be checked here:
> > >
> > > void *memmove(void *dest, const void *src, size_t len)
> > > {
> > >         check_memory_region((unsigned long)src, len, false, _RET_IP_)=
;
> > >         check_memory_region((unsigned long)dest, len, true, _RET_IP_)=
;
> > >
> > >         return __memmove(dest, src, len);
> > > }
> > >
> > > We fix the shadow end address which is calculated, then generic KASAN
> > > get the right shadow end address and detect this underflow issue.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D199341
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > ---
> > >  lib/test_kasan.c   | 36 ++++++++++++++++++++++++++++++++++++
> > >  mm/kasan/generic.c |  8 ++++++--
> > >  2 files changed, 42 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index b63b367a94e8..8bd014852556 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -280,6 +280,40 @@ static noinline void __init kmalloc_oob_in_memse=
t(void)
> > >         kfree(ptr);
> > >  }
> > >
> > > +static noinline void __init kmalloc_oob_in_memmove_underflow(void)
> > > +{
> > > +       char *ptr;
> > > +       size_t size =3D 64;
> > > +
> > > +       pr_info("underflow out-of-bounds in memmove\n");
> > > +       ptr =3D kmalloc(size, GFP_KERNEL);
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
> > > +static noinline void __init kmalloc_oob_in_memmove_overflow(void)
> > > +{
> > > +       char *ptr;
> > > +       size_t size =3D 64;
> > > +
> > > +       pr_info("overflow out-of-bounds in memmove\n");
> > > +       ptr =3D kmalloc(size, GFP_KERNEL);
> > > +       if (!ptr) {
> > > +               pr_err("Allocation failed\n");
> > > +               return;
> > > +       }
> > > +
> > > +       memset((char *)ptr, 0, 64);
> > > +       memmove((char *)ptr + size, (char *)ptr, 2);
> > > +       kfree(ptr);
> > > +}
> > > +
> > >  static noinline void __init kmalloc_uaf(void)
> > >  {
> > >         char *ptr;
> > > @@ -734,6 +768,8 @@ static int __init kmalloc_tests_init(void)
> > >         kmalloc_oob_memset_4();
> > >         kmalloc_oob_memset_8();
> > >         kmalloc_oob_memset_16();
> > > +       kmalloc_oob_in_memmove_underflow();
> > > +       kmalloc_oob_in_memmove_overflow();
> > >         kmalloc_uaf();
> > >         kmalloc_uaf_memset();
> > >         kmalloc_uaf2();
> > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > index 616f9dd82d12..34ca23d59e67 100644
> > > --- a/mm/kasan/generic.c
> > > +++ b/mm/kasan/generic.c
> > > @@ -131,9 +131,13 @@ static __always_inline bool memory_is_poisoned_n=
(unsigned long addr,
> > >                                                 size_t size)
> > >  {
> > >         unsigned long ret;
> > > +       void *shadow_start =3D kasan_mem_to_shadow((void *)addr);
> > > +       void *shadow_end =3D kasan_mem_to_shadow((void *)addr + size =
- 1) + 1;
> > >
> > > -       ret =3D memory_is_nonzero(kasan_mem_to_shadow((void *)addr),
> > > -                       kasan_mem_to_shadow((void *)addr + size - 1) =
+ 1);
> > > +       if ((long)size < 0)
> > > +               shadow_end =3D kasan_mem_to_shadow((void *)addr + siz=
e);
> >
> > Hi Walter,
> >
> > Thanks for working on this.
> >
> > If size<0, does it make sense to continue at all? We will still check
> > 1PB of shadow memory? What happens when we pass such huge range to
> > memory_is_nonzero?
> > Perhaps it's better to produce an error and bail out immediately if siz=
e<0?
>
> I agree with what you said. when size<0, it is indeed an unreasonable
> behavior, it should be blocked from continuing to do.
>
>
> > Also, what's the failure mode of the tests? Didn't they badly corrupt
> > memory? We tried to keep tests such that they produce the KASAN
> > reports, but don't badly corrupt memory b/c/ we need to run all of
> > them.
>
> Maybe we should first produce KASAN reports and then go to execute
> memmove() or do nothing? It looks like it=E2=80=99s doing the following.o=
r?
>
> void *memmove(void *dest, const void *src, size_t len)
>  {
> +       if (long(len) <=3D 0)

/\/\/\/\/\/\

This check needs to be inside of check_memory_region, otherwise we
will have similar problems in all other places that use
check_memory_region.
But check_memory_region already returns a bool, so we could check that
bool and return early.


> +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> +
>         check_memory_region((unsigned long)src, len, false, _RET_IP_);
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>
>
