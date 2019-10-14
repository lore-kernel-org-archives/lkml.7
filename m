Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncAdm5p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfJNKhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:37:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41466 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfJNKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:37:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so15408527qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xb4r1wuhDtOoPbUBnl8EutTh4mh6Tp7aWVqMVQujZhw=;
        b=ncAdm5p62dlyPVnbhlG8Ia8TOY8Bj9kzLoEPG8kBn98/b8IfkhIVulK5Sep05pIK1O
         a8o0B3t0aBxh0xAqIOcEfeSXp13CEtfHNcab6d7/193DUVfmkz6KLTW7BNnGSznYniOC
         OrQZYXwNQfNq6OFKV5BbBiaTmdDdA/KzwRrZQgY2d88OFjuIVU2/uImhKHWnlurIyJTf
         NP0R4emwQfuBb5AFCb0fsCrPv+n4gOBYVydhYj5Mse1CI1LeqzszvjYKB1kegwn/09dD
         ncJyFdOgxfUX5QfpE14HpJht0iIDCoje7GqrMD9p9QhnHQ3UxkeRvYSV9f1KCk9Dy3Wa
         IlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb4r1wuhDtOoPbUBnl8EutTh4mh6Tp7aWVqMVQujZhw=;
        b=Y4Akt1YZhJx5zbXx1Ti9vMsfptidDa0cvcSCx2tozBQi+3fySBGU3bjJw7w7utLQVP
         k6mXlOmwwV2TrWIvnzJihSdK2lJWapd6m50BgGqilG5t3RXs5FL4MYAmOaY+SwVvfjkX
         FNV8SZlfFB0g5xf4ZBR19Xn1JS4fjqCu2tbPcoyaWtMzpKp9bOZGxDtqmnFL6B4LIJDq
         /56RlFI0N2G92JVMbdtcv0oRBKmbc3zJA0XUmd3f2kp0M0WeM/W5ZmILOlF7/tU44B0B
         uAsRX8Q+S1sWzb8Q1PKk47IDAMSD9kivcapOrXaLRy3rVvp3OEtLJy8G2p+nie9VYhQG
         DkNw==
X-Gm-Message-State: APjAAAXXiiOlVOj61Msx3zGkUM/ZzSuPl6vLLQlqLcq5xoDf6wyQKqon
        JLIbtlKT+1EXc1emtzvOm7vgTD9Xjd8H7ITz5fwXbw==
X-Google-Smtp-Source: APXvYqxYd8Es1sxTY+VJ2ATWYdlj9YU4K41B4R2sul1P3y5YoKeVysrLikKwT7pXtYzOTHQ/ki/Sr8bYKKH4sdYYyHs=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr29448433qkm.250.1571049468723;
 Mon, 14 Oct 2019 03:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191014103148.17816-1-walter-zh.wu@mediatek.com> <CACT4Y+aSybD6Z0YHuhbaTKK+fd4c3t4z8WneYdRRqA4N-G0fkA@mail.gmail.com>
In-Reply-To: <CACT4Y+aSybD6Z0YHuhbaTKK+fd4c3t4z8WneYdRRqA4N-G0fkA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 12:37:37 +0200
Message-ID: <CACT4Y+aj20xfJ4nSR1piWcZTmANJ-kS8+ZcBfz6jG4ZTjR51yw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix the missing underflow in memory operation function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:36 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Oct 14, 2019 at 12:32 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > The patchsets help to produce KASAN report when size is negative numbers
> > in memory operation function. It is helpful for programmer to solve the
> > undefined behavior issue. Patch 1 based on Dmitry's review and
> > suggestion, patch 2 is a test in order to verify the patch 1.
>
> Hi Walter,
>
> I only received this cover letter, but not the actual patches. I also
> don't see them in the group:
> https://groups.google.com/forum/#!forum/kasan-dev
> nor on internet. Have you mailed them? Where are they?

OK, received them just now.

> > [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
> >
> > Walter Wu (2):
> > kasan: detect negative size in memory operation function
> > kasan: add test for invalid size in memmove
> >
> > ---
> >  lib/test_kasan.c          | 18 ++++++++++++++++++
> >  mm/kasan/common.c         | 13 ++++++++-----
> >  mm/kasan/generic.c        |  5 +++++
> >  mm/kasan/generic_report.c | 18 ++++++++++++++++++
> >  mm/kasan/tags.c           |  5 +++++
> >  mm/kasan/tags_report.c    | 17 +++++++++++++++++
> >  6 files changed, 71 insertions(+), 5 deletions(-)
> >
> > --
> > 2.18.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191014103148.17816-1-walter-zh.wu%40mediatek.com.
