Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2115B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErLvOg6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGBQ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:57:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39983 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:57:11 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so38621713ioc.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3ruOHdYru6Rpy+BKpMXi/6c+V83W2zZQqeLjuI07mA=;
        b=ErLvOg6Ev6zdphtHAlsPI/i4E1PAFFXuaLmpX6JcmhUUgS/xmdRuySXKCpIRtG+kX1
         FsBNUdt7zVXIciKH78drKjYo4PYJhD0tQnv5rYwR3/PbGcFitIGiyFOgRNQv0cqHlGeu
         9y928edF1AI0QN3d9ySA6ju08SKBpvuUyqAVUUTBKxMF/hoGVeig2TwgtMcmDhk5bwON
         ytRV6TMwbAXFECT+G69te6UyI4Y/HZtbTAL2PPKYiox8zBVdb6HWzEWgwyGh9YaT0+o5
         RvasPdi/clcVZRh3FzLopILMMo7MJkLlQhmUJLYkDyArxNRZCsan6cYz+PMwXxGZXyRc
         2XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3ruOHdYru6Rpy+BKpMXi/6c+V83W2zZQqeLjuI07mA=;
        b=dfESU2jNGoMqFVRlIXDb+955pCOiQhAUjamaIRAazGKEDlyUNoyjxA2lKU5UVHB/yk
         IxWFjMY/i1unDTAJYOWlA5Ur+F/DOz3fwUXqg6PCzX/Av5fmpmwJc39rey+yf6mPDCVU
         RHFw060sFn/YywnU7mGYqCeakkyVJRH5ejRBlSrIgzCrn/Kfljr1srxFxjWSCbmtnPY8
         lHlu8APy3dX5MGe5UxBVr3/te5OfuocFUaj0td2oepRtIgv55xN9jnRwopN1htuVyvI/
         qBfZtnsYugpOAzj/VOrb2+F+4X8rZ3EHxMHuDrhVeGB/5OtP/2qQhVSXdsE2EuZ+pdcy
         d+qQ==
X-Gm-Message-State: APjAAAUurb68heGTDCLdVSVpmlrxA0kSG89XdGPBGfAfJWpk5afvWmja
        sB0Shl9W1Q/b7qL05I/whaW6XO3bnaqS76QjqdnyRA==
X-Google-Smtp-Source: APXvYqy+XdTH/NEg0tFMMzUuM/+XmEQEFt0V0klg3HtEJYTy61ahf+1pdl0T/rIL9bJh57cA1/DbyP6ClHqPxMl8h3w=
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr22818920ioi.51.1562086630549;
 Tue, 02 Jul 2019 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190701173042.221453-1-henryburns@google.com> <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com>
In-Reply-To: <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Tue, 2 Jul 2019 09:56:34 -0700
Message-ID: <CAGQXPTjX=7aD9MQAs2kJthFvPdd3x8Nh53oc=wZCXH_dvDJ=Vg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 12:45 AM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> Hi Henry,
>
> On Mon, Jul 1, 2019 at 8:31 PM Henry Burns <henryburns@google.com> wrote:
> >
> > Running z3fold stress testing with address sanitization
> > showed zhdr->slots was being used after it was freed.
> >
> > z3fold_free(z3fold_pool, handle)
> >   free_handle(handle)
> >     kmem_cache_free(pool->c_handle, zhdr->slots)
> >   release_z3fold_page_locked_list(kref)
> >     __release_z3fold_page(zhdr, true)
> >       zhdr_to_pool(zhdr)
> >         slots_to_pool(zhdr->slots)  *BOOM*
>
> Thanks for looking into this. I'm not entirely sure I'm all for
> splitting free_handle() but let me think about it.
>
> > Instead we split free_handle into two functions, release_handle()
> > and free_slots(). We use release_handle() in place of free_handle(),
> > and use free_slots() to call kmem_cache_free() after
> > __release_z3fold_page() is done.
>
> A little less intrusive solution would be to move backlink to pool
> from slots back to z3fold_header. Looks like it was a bad idea from
> the start.
>
> Best regards,
>    Vitaly

We still want z3fold pages to be movable though. Wouldn't moving
the backink to the pool from slots to z3fold_header prevent us from
enabling migration?
