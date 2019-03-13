Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D152171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcmTjTnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfCMTSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:18:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33467 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfCMTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id h11so2229296pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWhPJ3WNEGAzoi65eJxiwmXgvhDwWzZG2Rd8Px4UT/M=;
        b=NcmTjTnP669KpQSaJDsEVbwa7ZSzy7RTfIIe13UmBh3jYlwMYcna5tYe4UPD7K0QWp
         FIrtHvkbkTM8ZBWJ3XThzGI16NdwnR8y7gi2UQUoklv18NqvNlv4dUVkMLbgqH27ruof
         dMtQcwagO8GS1fAZKEB8X4sTCzzPxWzs+1gOQVLVU38G4SmKQ1h6nrViaEOFgwalljeG
         55Bjh7XKlWG2CJ+yxYisD8n8CKG6RRXlonBc96iYd7oScLW/Vq1waoOB7NOdC6jSE6/W
         zzdnOCFfi4SnFgQd4EK3xcv0kGMPk3W5KRAEg09Ml/WZwYTy1iA0HnD/paLeGOZvXgsF
         GzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWhPJ3WNEGAzoi65eJxiwmXgvhDwWzZG2Rd8Px4UT/M=;
        b=erQ6qLpGMS+f5sfjDpGz5JfGl2JKQ0u8U3DaW2BOuFKlyPcvzHKhawg3mboVY1DLU8
         /UvFOnK/MVd74vZGms5drNEF854kg2uWieTEAFeAyHrzcPg00couOHjLHUuiHnh8/yRe
         7Ft6aLNzvifmufAMX8nZTTWuuXDExau+5kSvunYRD4zMtZW+skp5S4SNWuHtieb7fzBy
         mmYr+RYX6/iHRwtUl+C6kGQdirylZfzbq5WdJ/bR0LC6t8tXThKZypvHYUttsfI+KZud
         QZHdxnMnC/+oWBBy+27XyEM11CAdbghV7XjRxhYzmRrTzeeofLPLO3ebHsYFkSbuseJX
         IJ1Q==
X-Gm-Message-State: APjAAAUtJphkuXmtVfT5Bb6qMnKrqxdudrvxy/PlfYJG6lrLYFxbD7/k
        ao4UbKq6jOR6z83A/siVio96+qoQYQBcrFHl0Vm/eXbx
X-Google-Smtp-Source: APXvYqyhqJNYym2YNvO7ZRCVAOdtXq1+cu5eY/wmttmIdLIRskcfobIWUY0/oQcJh6Qub3CfDQ7R1ZoFLvgFmhtTDG0=
X-Received: by 2002:a65:6651:: with SMTP id z17mr39579463pgv.95.1552504715765;
 Wed, 13 Mar 2019 12:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190313191506.159677-1-sashal@kernel.org> <20190313191506.159677-22-sashal@kernel.org>
In-Reply-To: <20190313191506.159677-22-sashal@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 13 Mar 2019 20:18:24 +0100
Message-ID: <CAAeHK+xMxX3Baou=W914tbbPhuPGCBd4wJdgS3O459JEwxw5OQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 22/33] kasan, slab: make freelist stored
 without tags
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 8:16 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> [ Upstream commit 51dedad06b5f6c3eea7ec1069631b1ef7796912a ]

Hi Sasha,

None of the 4.9, 4.14, 4.19 or 4.20 have tag-based KASAN, so
backporting these 3 KASAN related patches doesn't make much sense.

Thanks!


>
> Similarly to "kasan, slub: move kasan_poison_slab hook before
> page_address", move kasan_poison_slab() before alloc_slabmgmt(), which
> calls page_address(), to make page_address() return value to be
> non-tagged.  This, combined with calling kasan_reset_tag() for off-slab
> slab management object, leads to freelist being stored non-tagged.
>
> Link: http://lkml.kernel.org/r/dfb53b44a4d00de3879a05a9f04c1f55e584f7a1.1550602886.git.andreyknvl@google.com
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Qian Cai <cai@lca.pw>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Evgeniy Stepanov <eugenis@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/slab.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 409631e49295..766043dd3f8e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2378,6 +2378,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
>                 /* Slab management obj is off-slab. */
>                 freelist = kmem_cache_alloc_node(cachep->freelist_cache,
>                                               local_flags, nodeid);
> +               freelist = kasan_reset_tag(freelist);
>                 if (!freelist)
>                         return NULL;
>         } else {
> @@ -2690,6 +2691,13 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
>
>         offset *= cachep->colour_off;
>
> +       /*
> +        * Call kasan_poison_slab() before calling alloc_slabmgmt(), so
> +        * page_address() in the latter returns a non-tagged pointer,
> +        * as it should be for slab pages.
> +        */
> +       kasan_poison_slab(page);
> +
>         /* Get slab management. */
>         freelist = alloc_slabmgmt(cachep, page, offset,
>                         local_flags & ~GFP_CONSTRAINT_MASK, page_node);
> @@ -2698,7 +2706,6 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
>
>         slab_map_pages(cachep, page, freelist);
>
> -       kasan_poison_slab(page);
>         cache_init_objs(cachep, page);
>
>         if (gfpflags_allow_blocking(local_flags))
> --
> 2.19.1
>
