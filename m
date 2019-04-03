Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B9FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D522082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2XKLx6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDCQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:39:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35945 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCQjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:39:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8604168pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IQMSP6P4b510J55TjeGkbsT5/Y/3zEz6PB9bSwT+7E=;
        b=N2XKLx6CwqbNgMJ1R23HY44NJ8E5jLkGzjmH3vzavEGsnUhSx5spwjOvDihNdKeHLD
         hiucnujUTZFNi9BJbS5ZZcViGdNdedLO1DTkY0HgdHNPjnDEjOlIghEiUQ3KEtWoEJvb
         hlYn3zfi2x7zS5JY2oyWATaMaUY6BtlFZ3OrTgtB0msmsdiDNfD9pMJ7Ltk5nAXP3yDj
         5W8KOeZ4AhHDF2akw58m3cZJBibsfONnnOUvFKsXUkLzMzlp383ccKE62xg+6tVpOPv5
         QsRci9bzTdkqTq8TAeE+o/0gbVgTOwhzbEc/vxi80Xdn9WHWnkXq8Jj+N3YW288e5CzO
         pzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IQMSP6P4b510J55TjeGkbsT5/Y/3zEz6PB9bSwT+7E=;
        b=qqikV+NWCpSup5+Ery6F0JI7X0hj/QXnDbjnfrBUSEvAPSv/WdNWF8A5WJeh3x5a7h
         sSG6KrHH5ADWaTF56iNUd20g22t6ECDrox+m5eafL2/NQ/Egk30Luk3raENCdTxuhisb
         s1tr13JKS/Qw45w1SWunqkpRJJtMDCK5SJzEc72fjbU1pyW3u1cuvbletsxR6ZgUDZtq
         AfRY8gcXvRM7xiuhjkNDUWIXVq/4hrKZdIcmlwDX6a6EguViFbEc/J/cbaYBJu3rKbQz
         9Y5vaBcJIsWUjYyHk+1vhFotZUZfEuRfZoZO/K/hnPn36dZ2t3oN9+kjSZVT/OGh46q5
         GGfw==
X-Gm-Message-State: APjAAAXOKXfrbe+jqAzwWBDXWhsrusm2yrSX8Gvj/EkrLQcpjsnk0GI8
        o2iuvpNrRgOTNe/CjAJRZw17H/nXJmBiWF3FX+Bqnw==
X-Google-Smtp-Source: APXvYqzYXS80SV0hZJplY4wbQNIVdXhJJqlu6SJclWXyq0z/0V+GPeAi6agt59VEmqpex5O4cxAu8xmIrxGQvFLtTC8=
X-Received: by 2002:a62:a513:: with SMTP id v19mr398736pfm.212.1554309581669;
 Wed, 03 Apr 2019 09:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190403022858.97584-1-cai@lca.pw> <CAAeHK+y25S6GYMrGUEQJJ5AU1LZ7T-jWrwoDsLXdxuk_E+q5BQ@mail.gmail.com>
 <1554296870.26196.32.camel@lca.pw>
In-Reply-To: <1554296870.26196.32.camel@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 3 Apr 2019 18:39:30 +0200
Message-ID: <CAAeHK+wB4L9nj+iPf8iHUbuWBCE_FQN4aea4zswEd4bbr49FPQ@mail.gmail.com>
Subject: Re: [PATCH] slab: store tagged freelist for off-slab slabmgmt
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:07 PM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-04-03 at 13:23 +0200, Andrey Konovalov wrote:
> > On Wed, Apr 3, 2019 at 4:29 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > The commit 51dedad06b5f ("kasan, slab: make freelist stored without
> > > tags") calls kasan_reset_tag() for off-slab slab management object
> > > leading to freelist being stored non-tagged. However, cache_grow_begin()
> > > -> alloc_slabmgmt() -> kmem_cache_alloc_node() which assigns a tag for
> > > the address and stores in the shadow address. As the result, it causes
> > > endless errors below during boot due to drain_freelist() ->
> > > slab_destroy() -> kasan_slab_free() which compares already untagged
> > > freelist against the stored tag in the shadow address. Since off-slab
> > > slab management object freelist is such a special case, so just store it
> > > tagged. Non-off-slab management object freelist is still stored untagged
> > > which has not been assigned a tag and should not cause any other
> > > troubles with this inconsistency.
> >
> > Hi Qian,
> >
> > Could you share the config (or other steps) you used to reproduce this?
>
> https://git.sr.ht/~cai/linux-debug/blob/master/config
>
> Additional command-line option to boot:
>
> page_poison=on crashkernel=768M earlycon page_owner=on numa_balancing=enable
> systemd.unified_cgroup_hierarchy=1 debug_guardpage_minorder=1

Reproduced, thanks!

As far as my understanding of how SLAB works goes, this change looks good to me.

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks, Qian!

>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1554296870.26196.32.camel%40lca.pw.
> For more options, visit https://groups.google.com/d/optout.
