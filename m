Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29048C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6325206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFDOhEqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKKRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:17:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39550 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:17:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id 15so10665311qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DS5VW8HLST3ocKeDeJ9QZgQRHqn3pgbndgTPCNayrE=;
        b=lFDOhEqVjOSXfNJBmRBz0twb2+nSO8ILygUTgNCKcexs7dLnkD4sI/nkATPjC74Wxi
         UDAL3kRkslYDnoZa+Czz7oq/sYtZqK4oM68t25IP89Tapvl3kjI2BI+Andtou/ufhXWh
         hqvN5aD7TA7I3LgLC0MP7mZmdL27Gtjq6Gz2fJXOY7oOdPpIrOS7vFCdKekB0ZM9Sbhp
         Mot7fZmRkLvbhFjFKdn5uzCL6uId6VsLXbRHZ7sp+NYsdavvhNFkmfwMc/7Dfw5CsOg+
         ymc4HArERq2B/0Uz/QLaBK56LAk28svJawPdlYJzeIFp5MtlW+vKYXTZhh2k+1XkKPea
         lWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DS5VW8HLST3ocKeDeJ9QZgQRHqn3pgbndgTPCNayrE=;
        b=ZT6WaobqQ+5CA6tDpi1oDmFQN9PSluZQtnbXvaLKjiKedxF3QTVK0Ck8QbnAysR2ut
         SfQMU8QveQzWhMfOj/dr9RIpc6+Ys3US03JvSx+Mjv+C7Qgl7wzLEmBVJL2tMNUuHf3j
         xCPTpMyJ5DdFw0iTDseaSGpoc/qlB1gl+YxDXOK+8R/O1/Qh00jGFOZLmf7RuRI112Oy
         o9TsToMgocmMUiIjBjE1yQGwXE2BegWmW1OdVz/vv6mF5zhe5vnWv6/dgYckXNYb4Akm
         iMp9Ynvp0MVBWeSJs7IpqDmhJFQB0/Ds5qH0Cef4Jlql7Z/Ogjxym6swxka3EgcogwSN
         Wyew==
X-Gm-Message-State: APjAAAWhME/RULhgTXHs329l19RSLWNUTX8p+ImHtxe6vXoIVjbNOOfZ
        Rf1gPC8hBpXah+uQPS5kg0O0uOOQyySfcWe8+d44Ow==
X-Google-Smtp-Source: APXvYqzngyp3gzCT7vLNBQdqFfCduZnei2+2jqfx418+UCn/40IJzE6IHh4VhuB/6RGs/fBSwvjY12hbIRv9V9b1U7s=
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr5628740qkk.250.1573467467767;
 Mon, 11 Nov 2019 02:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
 <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com> <1573456464.20611.45.camel@mtksdccf07>
 <757f0296-7fa0-0e5e-8490-3eca52da41ad@virtuozzo.com> <1573467150.20611.57.camel@mtksdccf07>
In-Reply-To: <1573467150.20611.57.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Nov 2019 11:17:35 +0100
Message-ID: <CACT4Y+bxWCF0WCkVxi+Qq3pztAXf2g-eBG5oexmQsQ65xrmiRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:12 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > On 11/11/19 10:14 AM, Walter Wu wrote:
> > > On Sat, 2019-11-09 at 01:31 +0300, Andrey Ryabinin wrote:
> > >>
> > >> On 11/4/19 5:05 AM, Walter Wu wrote:
> > >>
> > >>>
> > >>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > >>> index 6814d6d6a023..4ff67e2fd2db 100644
> > >>> --- a/mm/kasan/common.c
> > >>> +++ b/mm/kasan/common.c
> > >>> @@ -99,10 +99,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
> > >>>  }
> > >>>  EXPORT_SYMBOL(__kasan_check_write);
> > >>>
> > >>> +extern bool report_enabled(void);
> > >>> +
> > >>>  #undef memset
> > >>>  void *memset(void *addr, int c, size_t len)
> > >>>  {
> > >>> - check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > >>> + if (report_enabled() &&
> > >>> +     !check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > >>> +         return NULL;
> > >>>
> > >>>   return __memset(addr, c, len);
> > >>>  }
> > >>> @@ -110,8 +114,10 @@ void *memset(void *addr, int c, size_t len)
> > >>>  #undef memmove
> > >>>  void *memmove(void *dest, const void *src, size_t len)
> > >>>  {
> > >>> - check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > >>> - check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > >>> + if (report_enabled() &&
> > >>> +    (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > >>> +     !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
> > >>> +         return NULL;
> > >>>
> > >>>   return __memmove(dest, src, len);
> > >>>  }
> > >>> @@ -119,8 +125,10 @@ void *memmove(void *dest, const void *src, size_t len)
> > >>>  #undef memcpy
> > >>>  void *memcpy(void *dest, const void *src, size_t len)
> > >>>  {
> > >>> - check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > >>> - check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > >>> + if (report_enabled() &&
> > >>
> > >>             report_enabled() checks seems to be useless.
> > >>
> > >
> > > Hi Andrey,
> > >
> > > If it doesn't have report_enable(), then it will have below the error.
> > > We think it should be x86 shadow memory is invalid value before KASAN
> > > initialized, it will have some misjudgments to do directly return when
> > > it detects invalid shadow value in memset()/memcpy()/memmove(). So we
> > > add report_enable() to avoid this happening. but we should only use the
> > > condition "current->kasan_depth == 0" to determine if KASAN is
> > > initialized. And we try it is pass at x86.
> > >
> >
> > Ok, I see. It just means that check_memory_region() return incorrect result in early stages of boot.
> > So, the right way to deal with this would be making kasan_report() to return bool ("false" if no report and "true" if reported)
> > and propagate this return value up to check_memory_region().
> >
> This changes in v4.
>
> >
> > >>> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > >>> index 36c645939bc9..52a92c7db697 100644
> > >>> --- a/mm/kasan/generic_report.c
> > >>> +++ b/mm/kasan/generic_report.c
> > >>> @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
> > >>>
> > >>>  const char *get_bug_type(struct kasan_access_info *info)
> > >>>  {
> > >>> + /*
> > >>> +  * If access_size is negative numbers, then it has three reasons
> > >>> +  * to be defined as heap-out-of-bounds bug type.
> > >>> +  * 1) Casting negative numbers to size_t would indeed turn up as
> > >>> +  *    a large size_t and its value will be larger than ULONG_MAX/2,
> > >>> +  *    so that this can qualify as out-of-bounds.
> > >>> +  * 2) If KASAN has new bug type and user-space passes negative size,
> > >>> +  *    then there are duplicate reports. So don't produce new bug type
> > >>> +  *    in order to prevent duplicate reports by some systems
> > >>> +  *    (e.g. syzbot) to report the same bug twice.
> > >>> +  * 3) When size is negative numbers, it may be passed from user-space.
> > >>> +  *    So we always print heap-out-of-bounds in order to prevent that
> > >>> +  *    kernel-space and user-space have the same bug but have duplicate
> > >>> +  *    reports.
> > >>> +  */
> > >>
> > >> Completely fail to understand 2) and 3). 2) talks something about *NOT* producing new bug
> > >> type, but at the same time you code actually does that.
> > >> 3) says something about user-space which have nothing to do with kasan.
> > >>
> > > about 2)
> > > We originally think the heap-out-of-bounds is similar to
> > > heap-buffer-overflow, maybe we should change the bug type to
> > > heap-buffer-overflow.
> >
> > There is no "heap-buffer-overflow".
> >
> If I remember correctly, "heap-buffer-overflow" is one of existing bug
> type in user-space? Or you want to expect to see an existing bug type in
> kernel space?

Existing bug in KASAN.
KASAN and ASAN bugs will never match regardless of what we do. They
are simply in completely different code. So aligning titles between
kernel and userspace will not lead to any better deduplication.
