Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB329C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2F21670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chAc1nMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE2JnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:43:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37395 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2JnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:43:16 -0400
Received: by mail-it1-f194.google.com with SMTP id s16so2482759ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1vwG6ed0prywy+z8KiREagdtZuNI9VOig8toshOVg54=;
        b=chAc1nMBM1I/RScOIuvOknRcBCvKLY8OQacCAciGX3D4YaWn/Hh24EppGZcPDR0rDf
         JHQduWJ7lOTPO9GrnA747wXh+eW9eJcInXMAHBfodLWGHDLOBUrUkr7vmIZjD6yOGYuy
         Wq2Xg8f3PCCgKgmrlyIzWc7LQ2QU09gR978fdQ0MnbskpGMWtvMOQuK1G/AFvl9j5su4
         sQcSUZUvFm3Dke07chnv0kr0O5FP+wjvCyp09+/uzd9NrFa0gNeiXqvqfY/XE2h1or1v
         gzc49DcdJPtvkp8DGycOBdeqgyO1/x/0DnBWZDLCiuMgNK5NgsIxxO77m0ZOkBhAm7H/
         MB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1vwG6ed0prywy+z8KiREagdtZuNI9VOig8toshOVg54=;
        b=FCZwI871z5ZbH7/cKT2MBJBsTcPYzEK0AKLjel9eCumc986dEc0cWRcpfuyhd1ZXVP
         hXxnIHKLlDr0wyuJVaA1EV/BrJqdmHYCpAAJyGDVXm+uq0Z6Ywv9UPVEOCZe/nvIhmKq
         SFWSK1Df8Lf933mp6R7icPopPoIDSc0ziquxT/wCbxML7ljx23Pednekgxnq1fy29NkQ
         kaq7iBa9GlkhY8fEoab07/7lSYEAKpEgV3mqG5pyDNUB9yp9rCnB8tG0hf6gLq+7g8mO
         Uh3VXazZSilYn4vakwbSk+gfYJ4w8hqqPLFAsiY8BaH6tqUn9KuKHrJsUrjeLdVALRzI
         ANZQ==
X-Gm-Message-State: APjAAAVc4yWIUBvj49lp5udJz82BbuelUejfZIz1PRrKKUlz8+jm4u7T
        t61VVRkDErqEw4YmBtPxBUXP4x8JuAeZuQEHT75SyA==
X-Google-Smtp-Source: APXvYqzOol0fDJQfwGvb3+ZpLxlDyeBB7gKfR/q2fZYceJu/nmlQBxb+cmhFz/G3/FlwRFiCO6ubKizNA6OPnTs6xPk=
X-Received: by 2002:a02:1384:: with SMTP id 126mr13105640jaz.72.1559122994696;
 Wed, 29 May 2019 02:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <1559027797-30303-1-git-send-email-walter-zh.wu@mediatek.com>
 <CACT4Y+aCnODuffR7PafyYispp_U+ZdY1Dr0XQYvmghkogLJzSw@mail.gmail.com> <1559122529.17186.24.camel@mtksdccf07>
In-Reply-To: <1559122529.17186.24.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 11:43:02 +0200
Message-ID: <CACT4Y+a__7FQxqbzowLq5KOZGyBys90S8=HP_Gqu_KoNm7W39w@mail.gmail.com>
Subject: Re: [PATCH] kasan: add memory corruption identification for software
 tag-based mode
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:35 AM Walter Wu <walter-zh.wu@mediatek.com> wrot=
e:
>
> > Hi Walter,
> >
> > Please describe your use case.
> > For testing context the generic KASAN works better and it does have
> > quarantine already. For prod/canary environment the quarantine may be
> > unacceptable in most cases.
> > I think we also want to use tag-based KASAN as a base for ARM MTE
> > support in near future and quarantine will be most likely unacceptable
> > for main MTE use cases. So at the very least I think this should be
> > configurable. +Catalin for this.
> >
> My patch hope the tag-based KASAN bug report make it easier for
> programmers to see memory corruption problem.
> Because now tag-based KASAN bug report always shows =E2=80=9Cinvalid-acce=
ss=E2=80=9D
> error, my patch can identify it whether it is use-after-free or
> out-of-bound.
>
> We can try to make our patch is feature option. Thanks your suggestion.
> Would you explain why the quarantine is unacceptable for main MTE?
> Thanks.

MTE is supposed to be used on actual production devices.
Consider that by submitting this patch you are actually reducing
amount of available memory on your next phone ;)


> > You don't change total quarantine size and charge only sizeof(struct
> > qlist_object). If I am reading this correctly, this means that
> > quarantine will have the same large overhead as with generic KASAN. We
> > will just cache much more objects there. The boot benchmarks may be
> > unrepresentative for this. Don't we need to reduce quarantine size or
> > something?
> >
> Yes, we will try to choose 2. My original idea is belong to it. So we
> will reduce quarantine size.
>
> 1). If quarantine size is the same with generic KASAN and tag-based
> KASAN, then the miss rate of use-after-free case in generic KASAN is
> larger than tag-based KASAN.
> 2). If tag-based KASAN quarantine size is smaller generic KASAN, then
> the miss rate of use-after-free case may be the same, but tag-based
> KASAN can save slab memory usage.
>
>
> >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > ---
> > >  include/linux/kasan.h  |  20 +++++---
> > >  mm/kasan/Makefile      |   4 +-
> > >  mm/kasan/common.c      |  15 +++++-
> > >  mm/kasan/generic.c     |  11 -----
> > >  mm/kasan/kasan.h       |  45 ++++++++++++++++-
> > >  mm/kasan/quarantine.c  | 107 ++++++++++++++++++++++++++++++++++++++-=
--
> > >  mm/kasan/report.c      |  36 +++++++++-----
> > >  mm/kasan/tags.c        |  64 ++++++++++++++++++++++++
> > >  mm/kasan/tags_report.c |   5 +-
> > >  mm/slub.c              |   2 -
> > >  10 files changed, 262 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index b40ea104dd36..bbb52a8bf4a9 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -83,6 +83,9 @@ size_t kasan_metadata_size(struct kmem_cache *cache=
);
> > >  bool kasan_save_enable_multi_shot(void);
> > >  void kasan_restore_multi_shot(bool enabled);
> > >
> > > +void kasan_cache_shrink(struct kmem_cache *cache);
> > > +void kasan_cache_shutdown(struct kmem_cache *cache);
> > > +
> > >  #else /* CONFIG_KASAN */
> > >
> > >  static inline void kasan_unpoison_shadow(const void *address, size_t=
 size) {}
> > > @@ -153,20 +156,14 @@ static inline void kasan_remove_zero_shadow(voi=
d *start,
> > >  static inline void kasan_unpoison_slab(const void *ptr) { }
> > >  static inline size_t kasan_metadata_size(struct kmem_cache *cache) {=
 return 0; }
> > >
> > > +static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
> > > +static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
> > >  #endif /* CONFIG_KASAN */
> > >
> > >  #ifdef CONFIG_KASAN_GENERIC
> > >
> > >  #define KASAN_SHADOW_INIT 0
> > >
> > > -void kasan_cache_shrink(struct kmem_cache *cache);
> > > -void kasan_cache_shutdown(struct kmem_cache *cache);
> > > -
> > > -#else /* CONFIG_KASAN_GENERIC */
> > > -
> > > -static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
> > > -static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
> >
> > Why do we need to move these functions?
> > For generic KASAN that's required because we store the objects
> > themselves in the quarantine, but it's not the case for tag-based mode
> > with your patch...
> >
> The quarantine in tag-based KASAN includes new objects which we create.
> Those objects are the freed information. They can be shrunk by calling
> them. So we move these function into CONFIG_KASAN.

Ok, kasan_cache_shrink is to release memory during memory pressure.
But why do we need kasan_cache_shutdown? It seems that we could leave
qobjects in quarantine when the corresponding cache is destroyed. And
in fact it's useful because we still can get use-after-frees on these
objects.
