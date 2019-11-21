Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419C0206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kd3uHXA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKUT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:58:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38250 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:58:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id 14so5096597qtf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrzxHrY8HSPigVP1ddvjUfQFh9GexeJHE6yrEfyJGn8=;
        b=Kd3uHXA1P6DuCOhB2GxNrroyfRPcjST5rj7knlJlrVz7Lrr4YsfVvSNtbCJMOzDkm9
         v/Y0j8z3u2abnQEXY0H/eS8gg8o59m/He8HAtGj9aKsogiT9HudHc7VPDU2uoLVegRab
         sua5+XIGxHCZJbnaUyGj+m0xq4sdO/dgPH5ql42Q3eTE9zhaycI8jmcThgYH39KDXrzD
         1s8L4VxDYCCJ8XxaPf86AG60AUSWCfVYt225dJygovcnw48m1vkJtxVDMaj17SMkzVOU
         6motdGawpCw2ZkIZ70iqZsTbQBr8FOa9spMlRL+BJl5lsiRXNBDSQxevq5bBE2xPOBET
         0W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrzxHrY8HSPigVP1ddvjUfQFh9GexeJHE6yrEfyJGn8=;
        b=BNbkkZDopC9zWCwtf5hFCxA76tZjH2wBHCxksR/mNDWzZh0boq8G1/1YVS4dGDvl5A
         cYRpY1N3p/jVWM+SVJy2gF73gAZazGUyOiFia+WEPB/Dvmj9McNtT2nJDFg7gYDcH/Lp
         pNZ7KCuQxrYy9T9UmI+xKP2/EoCcevK0AwEPyFVg6uonCEGT2Nn9b1MqlTcKGzjZflgh
         gSWjLHSZDdUiNXbQBJiFu4xFTSbDI35bTVnOWNq2he43/hChiumtAdPcQdmfQoIZx392
         NO2y14VfG0I6cNvdWMQXGAxEN+akNf5UlF4qGK7YpQGCsTj8oIrnTbdzliSGJQc9cmSy
         u4SQ==
X-Gm-Message-State: APjAAAXXkHq1fwq13L+jFHSQpd9g9wyVIIQngv2h++EbeUxDOJTVSmXA
        F7IpFRdExFJ95z8kamZ9ThNqQ8EcpB6OkSHYmsVvTA==
X-Google-Smtp-Source: APXvYqzPK/X2AE0eWdYsKj49rv1x+g3AQZDvujO3L268Ze2mJnamWmtGWcsUjKvRNU7iWCoHqffcHfRnbEOs1IRx7Os=
X-Received: by 2002:aed:24af:: with SMTP id t44mr10377791qtc.57.1574366311591;
 Thu, 21 Nov 2019 11:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com> <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
In-Reply-To: <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Nov 2019 20:58:19 +0100
Message-ID: <CACT4Y+botuVF6KanfRrudDguw7HGkJ1mrwvxYZQQF0eWoo-Lxw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation function
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 1:27 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 6814d6d6a023..4bfce0af881f 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> >  #undef memset
> >  void *memset(void *addr, int c, size_t len)
> >  {
> > -     check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > +     if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > +             return NULL;
> >
> >       return __memset(addr, c, len);
> >  }
> > @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
> >  #undef memmove
> >  void *memmove(void *dest, const void *src, size_t len)
> >  {
> > -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > +     if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > +             return NULL;
> >
> >       return __memmove(dest, src, len);
> >  }
> > @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t len)
> >  #undef memcpy
> >  void *memcpy(void *dest, const void *src, size_t len)
> >  {
> > -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > +     if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > +             return NULL;
> >
>
> I realized that we are going a wrong direction here. Entirely skipping mem*() operation on any
> poisoned shadow value might only make things worse. Some bugs just don't have any serious consequences,
> but skipping the mem*() ops entirely might introduce such consequences, which wouldn't happen otherwise.
>
> So let's keep this code as this, no need to check the result of check_memory_region().

I suggested it.

For our production runs it won't matter, we always panic on first report.
If one does not panic, there is no right answer. You say: _some_ bugs
don't have any serious consequences, but skipping the mem*() ops
entirely might introduce such consequences. The opposite is true as
well, right? :) And it's not hard to come up with a scenario where
overwriting memory after free or out of bounds badly corrupts memory.
I don't think we can somehow magically avoid bad consequences in all
cases.

What I was thinking about is tests. We need tests for this. And we
tried to construct tests specifically so that they don't badly corrupt
memory (e.g. OOB/UAF reads, or writes to unused redzones, etc), so
that it's possible to run all of them to completion reliably. Skipping
the actual memory options allows to write such tests for all possible
scenarios. That's was my motivation.
