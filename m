Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AECC072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C720848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rabKNPw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfERHLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:11:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34552 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:11:12 -0400
Received: by mail-it1-f195.google.com with SMTP id g23so403142iti.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiOVb0r2XtDlST73GK6EKcP9xzfFFxYpIe1ze82bR2Q=;
        b=rabKNPw+eYC9kmx+8CDGM7I/PCMu8buwuC3OVQ22mOV/QwgFrLf1MgLbENPaK9Se90
         a7fmyYILc74wzHEGZz9aGU0ZNQ08T8Gt/NNztt+jsaSnETR6dan690a5cQhg6xpHBavG
         gaic3JMrP51pMKiDkt0yA+Wi8eWInyDrMXMk9uZo0b4WwDG3mfZpNOMsy5Twog2sWXrf
         bNpVK6qheOHkwXR7u+wLf6Q5UnrML5rAqsK5ywzb3R3Y8/62rCQracLGlKyDGXsqfWWK
         jGgnDEaCmw3u7OpyUUOTn+03g7GpgERf90DXAA9s88EhcU2dEqt5XuwtxQ5ZpnjIzjV8
         NxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiOVb0r2XtDlST73GK6EKcP9xzfFFxYpIe1ze82bR2Q=;
        b=hqlGuU0I3rXANb0OLY/9hWfoGCbJr0tQy+cbtVL4SLdL2nWs+nBS01SrgDG6c44IYO
         95wUd9d7aQl+IQ4ybA30cddPd2Maq9Nu3mUIgY7TdXIDGzkLTdacdojRsNzf7FmwiRcv
         H9ZLwLJ/j15W33NeDib2CNL2BDtIpxeOGauLFka4ZHOGwQZeA/Ij2+6BbFI3M9zFYOtm
         Gbud1Kaiv0WxTtiZ7XsrTIyaKfXudHBl3V3mJRQQtrvmwALVGTeBRw6e5x6wwtOSyThb
         XqtUjEOAP89O8mMp9BjzjIToguyjOnYywvKz5UxVBbhkVTKhxjqs08YMILeby5mBGEmf
         18Mw==
X-Gm-Message-State: APjAAAWQ5iotDNVfPQrJTR3guSGAxM/UPQMVVk38yO1+7dUK0AwIFgnE
        4cBYK7xJBHx0bIola46KtnSj7GGHKcimuWyLxr4M0w==
X-Google-Smtp-Source: APXvYqzQ5tmIhQCBoyFPy/MoyrkRC8/116cN+KJoXVBjPead1xsLW52BD5mkme39a12aeV4+k6Q9m4IDEKJWxCmNQrM=
X-Received: by 2002:a24:4c08:: with SMTP id a8mr5931148itb.76.1558163470937;
 Sat, 18 May 2019 00:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190517171507.96046-1-dvyukov@gmail.com> <20190517143746.2157a759f65b4cbc73321124@linux-foundation.org>
In-Reply-To: <20190517143746.2157a759f65b4cbc73321124@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 May 2019 09:10:59 +0200
Message-ID: <CACT4Y+aee_Kvezo8zeD77RwBi2-Csd9cE8vtGCmaTGYxr=iK5A@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: fix check for softirq context
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:37 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 17 May 2019 19:15:07 +0200 Dmitry Vyukov <dvyukov@gmail.com> wrote:
>
> > From: Dmitry Vyukov <dvyukov@google.com>
> >
> > in_softirq() is a wrong predicate to check if we are in a softirq context.
> > It also returns true if we have BH disabled, so objects are falsely
> > stamped with "softirq" comm. The correct predicate is in_serving_softirq().
> >
> > ...
> >
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -588,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> >       if (in_irq()) {
> >               object->pid = 0;
> >               strncpy(object->comm, "hardirq", sizeof(object->comm));
> > -     } else if (in_softirq()) {
> > +     } else if (in_serving_softirq()) {
> >               object->pid = 0;
> >               strncpy(object->comm, "softirq", sizeof(object->comm));
> >       } else {
>
> What are the user-visible runtime effects of this change?


If user does cat from /sys/kernel/debug/kmemleak previously they would
see this, which is clearly wrong, this is system call context (see the
comm):

unreferenced object 0xffff88805bd661c0 (size 64):
  comm "softirq", pid 0, jiffies 4294942959 (age 12.400s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
    00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000007dcb30c>] kmemleak_alloc_recursive
include/linux/kmemleak.h:55 [inline]
    [<0000000007dcb30c>] slab_post_alloc_hook mm/slab.h:439 [inline]
    [<0000000007dcb30c>] slab_alloc mm/slab.c:3326 [inline]
    [<0000000007dcb30c>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
    [<00000000969722b7>] kmalloc include/linux/slab.h:547 [inline]
    [<00000000969722b7>] kzalloc include/linux/slab.h:742 [inline]
    [<00000000969722b7>] ip_mc_add1_src net/ipv4/igmp.c:1961 [inline]
    [<00000000969722b7>] ip_mc_add_src+0x36b/0x400 net/ipv4/igmp.c:2085
    [<00000000a4134b5f>] ip_mc_msfilter+0x22d/0x310 net/ipv4/igmp.c:2475
    [<00000000d20248ad>] do_ip_setsockopt.isra.0+0x19fe/0x1c00
net/ipv4/ip_sockglue.c:957
    [<000000003d367be7>] ip_setsockopt+0x3b/0xb0 net/ipv4/ip_sockglue.c:1246
    [<000000003c7c76af>] udp_setsockopt+0x4e/0x90 net/ipv4/udp.c:2616
    [<000000000c1aeb23>] sock_common_setsockopt+0x3e/0x50 net/core/sock.c:3130
    [<000000000157b92b>] __sys_setsockopt+0x9e/0x120 net/socket.c:2078
    [<00000000a9f3d058>] __do_sys_setsockopt net/socket.c:2089 [inline]
    [<00000000a9f3d058>] __se_sys_setsockopt net/socket.c:2086 [inline]
    [<00000000a9f3d058>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
    [<000000001b8da885>] do_syscall_64+0x7c/0x1a0 arch/x86/entry/common.c:301
    [<00000000ba770c62>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

now they will see this:

unreferenced object 0xffff88805413c800 (size 64):
  comm "syz-executor.4", pid 8960, jiffies 4294994003 (age 14.350s)
  hex dump (first 32 bytes):
    00 7a 8a 57 80 88 ff ff e0 00 00 01 00 00 00 00  .z.W............
    00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000c5d3be64>] kmemleak_alloc_recursive
include/linux/kmemleak.h:55 [inline]
    [<00000000c5d3be64>] slab_post_alloc_hook mm/slab.h:439 [inline]
    [<00000000c5d3be64>] slab_alloc mm/slab.c:3326 [inline]
    [<00000000c5d3be64>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
    [<0000000023865be2>] kmalloc include/linux/slab.h:547 [inline]
    [<0000000023865be2>] kzalloc include/linux/slab.h:742 [inline]
    [<0000000023865be2>] ip_mc_add1_src net/ipv4/igmp.c:1961 [inline]
    [<0000000023865be2>] ip_mc_add_src+0x36b/0x400 net/ipv4/igmp.c:2085
    [<000000003029a9d4>] ip_mc_msfilter+0x22d/0x310 net/ipv4/igmp.c:2475
    [<00000000ccd0a87c>] do_ip_setsockopt.isra.0+0x19fe/0x1c00
net/ipv4/ip_sockglue.c:957
    [<00000000a85a3785>] ip_setsockopt+0x3b/0xb0 net/ipv4/ip_sockglue.c:1246
    [<00000000ec13c18d>] udp_setsockopt+0x4e/0x90 net/ipv4/udp.c:2616
    [<0000000052d748e3>] sock_common_setsockopt+0x3e/0x50 net/core/sock.c:3130
    [<00000000512f1014>] __sys_setsockopt+0x9e/0x120 net/socket.c:2078
    [<00000000181758bc>] __do_sys_setsockopt net/socket.c:2089 [inline]
    [<00000000181758bc>] __se_sys_setsockopt net/socket.c:2086 [inline]
    [<00000000181758bc>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
    [<00000000d4b73623>] do_syscall_64+0x7c/0x1a0 arch/x86/entry/common.c:301
    [<00000000c1098bec>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
