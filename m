Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91744C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5810D20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g63j6COv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKH5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:57:49 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39380 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:57:49 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so4508005qvq.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7y4zy6OrzaKCbmt5VnQkSfOPrSCD4IzJM4CsQhV4vc=;
        b=g63j6COvu8/gYONRQt9DCMBKG/vdfAoAIq4kFVCoQhW0YwHdPfzPFVjXRltUzcXy2M
         4M19/g5navLrOWvbxmDK/dkpTzke5fDPVwWhmBPpgXLTx40JhXcXvRV6iiqyWyzya82P
         BU8PgrRkZoODSqCPT2homm3jFH4r+tvEgnMem6528jRA3HsYRbAEMVMobBxRwCJnBlO5
         4vKiHw+Y9wHjBbI3BACQ6pwr5HzfcSSTpN/LA6x4Hb3pJFzbHdMx8Otzz6pMqk9NDAhI
         rDzRU5zSfuaBi543fvixREZ3C9D/JjYgJzpgOlHzGoYxwHBzTlm0mtHSt4p0sxQJNRCq
         OKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7y4zy6OrzaKCbmt5VnQkSfOPrSCD4IzJM4CsQhV4vc=;
        b=AdjaGKZdaXjQcyecZJR2ILn0FhyNczVV0ij+sbLxDtcE++mWzjIoc3VzInNwwwrUG8
         K7MOTD8InvfSix2TsMYbm1Mum5vHhdpn0K2qEEtTNpiM24vYgIEebbyjBoEiy5VoUBvn
         n5ePR9gvxPYMijZvZxrmoR61Co4+pbSgEm2o8jimE+QMCVtRN3WzLnRKdn2phhqETSbV
         y6kssB3/iwWgqTf5yfc9fVUit391gK+803WgrZMEMdHGjoIRooWcD4Xv1DSkfIdKPl7I
         7QQgbwfg+UqlUrHi/GEk67erlGiPDepqyXtFN31Nx1HIDkZzD0jNO+SK/fqeowuVMthD
         /sGg==
X-Gm-Message-State: APjAAAVe++qhntMYV/NLyF4dihIeU4QEQA6ZmWqiTV2xCQrTufHydm8+
        F3pjyt13fu8tfuhUV6bAjrRHtcsrMrjm5WcPZYIZ2w==
X-Google-Smtp-Source: APXvYqwfegIIk1e1zoYpAwU83F6r6f1P4e2x+T1xLBRYcBCusyP997BoiwHQt2Bm/a3lw7Hh2aH9A36AFHU/5KoT4bs=
X-Received: by 2002:a05:6214:8ee:: with SMTP id dr14mr22829788qvb.122.1573459067244;
 Sun, 10 Nov 2019 23:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com> <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
In-Reply-To: <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Nov 2019 08:57:35 +0100
Message-ID: <CACT4Y+bfGrJemwyMVqd2Kt19mF2i=3GwXRKHP0qGJaT_5OhSCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation function
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
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

On Fri, Nov 8, 2019 at 11:32 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 6814d6d6a023..4ff67e2fd2db 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -99,10 +99,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
> >  }
> >  EXPORT_SYMBOL(__kasan_check_write);
> >
> > +extern bool report_enabled(void);
> > +
> >  #undef memset
> >  void *memset(void *addr, int c, size_t len)
> >  {
> > -     check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > +     if (report_enabled() &&
> > +         !check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > +             return NULL;
> >
> >       return __memset(addr, c, len);
> >  }
> > @@ -110,8 +114,10 @@ void *memset(void *addr, int c, size_t len)
> >  #undef memmove
> >  void *memmove(void *dest, const void *src, size_t len)
> >  {
> > -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > +     if (report_enabled() &&
> > +        (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
> > +             return NULL;
> >
> >       return __memmove(dest, src, len);
> >  }
> > @@ -119,8 +125,10 @@ void *memmove(void *dest, const void *src, size_t len)
> >  #undef memcpy
> >  void *memcpy(void *dest, const void *src, size_t len)
> >  {
> > -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > +     if (report_enabled() &&
>
>             report_enabled() checks seems to be useless.
>
> > +        (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
> > +             return NULL;
> >
> >       return __memcpy(dest, src, len);
> >  }
> > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > index 616f9dd82d12..02148a317d27 100644
> > --- a/mm/kasan/generic.c
> > +++ b/mm/kasan/generic.c
> > @@ -173,6 +173,11 @@ static __always_inline bool check_memory_region_inline(unsigned long addr,
> >       if (unlikely(size == 0))
> >               return true;
> >
> > +     if (unlikely((long)size < 0)) {
>
>         if (unlikely(addr + size < addr)) {
>
> > +             kasan_report(addr, size, write, ret_ip);
> > +             return false;
> > +     }
> > +
> >       if (unlikely((void *)addr <
> >               kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> >               kasan_report(addr, size, write, ret_ip);
> > diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > index 36c645939bc9..52a92c7db697 100644
> > --- a/mm/kasan/generic_report.c
> > +++ b/mm/kasan/generic_report.c
> > @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
> >
> >  const char *get_bug_type(struct kasan_access_info *info)
> >  {
> > +     /*
> > +      * If access_size is negative numbers, then it has three reasons
> > +      * to be defined as heap-out-of-bounds bug type.
> > +      * 1) Casting negative numbers to size_t would indeed turn up as
> > +      *    a large size_t and its value will be larger than ULONG_MAX/2,
> > +      *    so that this can qualify as out-of-bounds.
> > +      * 2) If KASAN has new bug type and user-space passes negative size,
> > +      *    then there are duplicate reports. So don't produce new bug type
> > +      *    in order to prevent duplicate reports by some systems
> > +      *    (e.g. syzbot) to report the same bug twice.
> > +      * 3) When size is negative numbers, it may be passed from user-space.
> > +      *    So we always print heap-out-of-bounds in order to prevent that
> > +      *    kernel-space and user-space have the same bug but have duplicate
> > +      *    reports.
> > +      */
>
> Completely fail to understand 2) and 3). 2) talks something about *NOT* producing new bug
> type, but at the same time you code actually does that.
> 3) says something about user-space which have nothing to do with kasan.

The idea was to use one of the existing bug titles so that syzbot does
not produce 2 versions for OOBs where size is user-controlled. We
don't know if it's overflow from heap, global or stack, but heap is
the most common bug, so saying heap overflow will reduce chances of
producing duplicates the most.
But for all of this to work we do need to use one of the existing bug titles.

> > +     if ((long)info->access_size < 0)
>
>         if (info->access_addr + info->access_size < info->access_addr)
>
> > +             return "heap-out-of-bounds";
> > +
> >       if (addr_has_shadow(info->access_addr))
> >               return get_shadow_bug_type(info);
> >       return get_wild_bug_type(info);
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 621782100eaa..c79e28814e8f 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -446,7 +446,7 @@ static void print_shadow_for_address(const void *addr)
> >       }
> >  }
> >
> > -static bool report_enabled(void)
> > +bool report_enabled(void)
> >  {
> >       if (current->kasan_depth)
> >               return false;
> > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > index 0e987c9ca052..b829535a3ad7 100644
> > --- a/mm/kasan/tags.c
> > +++ b/mm/kasan/tags.c
> > @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
> >       if (unlikely(size == 0))
> >               return true;
> >
> > +     if (unlikely((long)size < 0)) {
>
>         if (unlikely(addr + size < addr)) {
>
> > +             kasan_report(addr, size, write, ret_ip);
> > +             return false;
> > +     }
> > +
> >       tag = get_tag((const void *)addr);
> >
> >       /*
> > diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> > index 969ae08f59d7..f7ae474aef3a 100644
> > --- a/mm/kasan/tags_report.c
> > +++ b/mm/kasan/tags_report.c
> > @@ -36,6 +36,24 @@
> >
> >  const char *get_bug_type(struct kasan_access_info *info)
> >  {
> > +     /*
> > +      * If access_size is negative numbers, then it has three reasons
> > +      * to be defined as heap-out-of-bounds bug type.
> > +      * 1) Casting negative numbers to size_t would indeed turn up as
> > +      *    a large size_t and its value will be larger than ULONG_MAX/2,
> > +      *    so that this can qualify as out-of-bounds.
> > +      * 2) If KASAN has new bug type and user-space passes negative size,
> > +      *    then there are duplicate reports. So don't produce new bug type
> > +      *    in order to prevent duplicate reports by some systems
> > +      *    (e.g. syzbot) to report the same bug twice.
> > +      * 3) When size is negative numbers, it may be passed from user-space.
> > +      *    So we always print heap-out-of-bounds in order to prevent that
> > +      *    kernel-space and user-space have the same bug but have duplicate
> > +      *    reports.
> > +      */
> > +     if ((long)info->access_size < 0)
>
>         if (info->access_addr + info->access_size < info->access_addr)
>
> > +             return "heap-out-of-bounds";
> > +
> >  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> >       struct kasan_alloc_meta *alloc_meta;
> >       struct kmem_cache *cache;
> >
