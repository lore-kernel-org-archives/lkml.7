Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088CEC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A1F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlTFwFIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbfFKLca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:32:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40460 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389464AbfFKLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:32:29 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so9555664ioc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJ5KMjkPulVIlquMhDg/I0WD4XAnjse8O6WtWcGUz4E=;
        b=TlTFwFIxz9etSjSBZdcP2L6srMJb56KWUjVFS4qyFG2NEzpl/ugkDxZGDtevEXvCsu
         d+W4D0EjwpeQWLu6YTAqLlOWtV9+PYCjJ+BGYrb4gKrfG/NPB6ccs074WqJLtEQjGVso
         mSFb2VwUteI3d6rFAZ6+Iy65mgseV0VV/vvswhzRN77Hg3pqpHJnF2CXpEwVpu2pyAM1
         TYGTSH57wWYQoNtEH1TJ7m8hjnzm2XA+44SW/ctJefLRikEX++cKcPTNJGOnwBnKd99X
         sSqqMt8kFPa6rel1VGvJojdPG8wvyJ6Eb5oWIyyaz2xdhEyEUuLc4Detd3tySV6jR7EK
         bwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ5KMjkPulVIlquMhDg/I0WD4XAnjse8O6WtWcGUz4E=;
        b=OHeKV1Hmis89rSGrl1JC37WHOD0XOehTqV1P0n7kAnAjz9GjtPriUclVC+sJdam/zD
         BCCcWAJXfrV669YMy0kbTfA3nQH15BTh+S0tAOyozyOkJyP4WdLtyUanvoTV2j7yD8Zt
         gQtx5WjY6YyFvIPIXr/ZG0sInqpLqK6dfv+8fRUnBRXLYom+5NZt2l7bCh0oFv4sFHxw
         vh4qme/ncHyEvnhJif7Yi6ELLx2ZYBZSxONniOYDT0Pit93ORhvM1YrCWDpQhi82U4bj
         CU+iJB4/jpWcwebhOzwyN0NgTrnMjcnnrzC4gvMuJe5PnzF+/qcy/DMwYo/3XrdcOKGj
         MnWQ==
X-Gm-Message-State: APjAAAUlJ044b3se1p07daS53AXGZ9SRex9LDmTdyDzChsTHOqdEiuFU
        aO8gfSXUMj7eirhtGPP0YVWGju1SzXV6kqPpJsXyVA==
X-Google-Smtp-Source: APXvYqw9dSSfEyizP9qkfJ/fTJ+bPVpxmMW//LjyNaWWY5U1Qi8nthjbX348yzFM8aZPZ+LmzKj04oxrxcPDI3N9JoU=
X-Received: by 2002:a6b:641a:: with SMTP id t26mr3295112iog.3.1560252747608;
 Tue, 11 Jun 2019 04:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <1559651172-28989-1-git-send-email-walter-zh.wu@mediatek.com>
 <CACT4Y+Y9_85YB8CCwmKerDWc45Z00hMd6Pc-STEbr0cmYSqnoA@mail.gmail.com>
 <1560151690.20384.3.camel@mtksdccf07> <CACT4Y+aetKEM9UkfSoVf8EaDNTD40mEF0xyaRiuw=DPEaGpTkQ@mail.gmail.com>
 <1560236742.4832.34.camel@mtksdccf07> <CACT4Y+YNG0OGT+mCEms+=SYWA=9R3MmBzr8e3QsNNdQvHNt9Fg@mail.gmail.com>
 <1560249891.29153.4.camel@mtksdccf07>
In-Reply-To: <1560249891.29153.4.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jun 2019 13:32:16 +0200
Message-ID: <CACT4Y+aXqjCMaJego3yeSG1eR1+vkJkx5GB+xsy5cpGvAtTnDA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add memory corruption identification for
 software tag-based mode
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>, kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:44 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Tue, 2019-06-11 at 10:47 +0200, Dmitry Vyukov wrote:
> > On Tue, Jun 11, 2019 at 9:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
> > > On Mon, 2019-06-10 at 13:46 +0200, Dmitry Vyukov wrote:
> > > > On Mon, Jun 10, 2019 at 9:28 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > >
> > > > > On Fri, 2019-06-07 at 21:18 +0800, Dmitry Vyukov wrote:
> > > > > > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > > > > > index b40ea104dd36..be0667225b58 100644
> > > > > > > --- a/include/linux/kasan.h
> > > > > > > +++ b/include/linux/kasan.h
> > > > > > > @@ -164,7 +164,11 @@ void kasan_cache_shutdown(struct kmem_cache *cache);
> > > > > > >
> > > > > > >  #else /* CONFIG_KASAN_GENERIC */
> > > > > > >
> > > > > > > +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > > > > > > +void kasan_cache_shrink(struct kmem_cache *cache);
> > > > > > > +#else
> > > > > >
> > > > > > Please restructure the code so that we don't duplicate this function
> > > > > > name 3 times in this header.
> > > > > >
> > > > > We have fixed it, Thank you for your reminder.
> > > > >
> > > > >
> > > > > > >  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
> > > > > > > +#endif
> > > > > > >  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
> > > > > > >
> > > > > > >  #endif /* CONFIG_KASAN_GENERIC */
> > > > > > > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > > > > > > index 9950b660e62d..17a4952c5eee 100644
> > > > > > > --- a/lib/Kconfig.kasan
> > > > > > > +++ b/lib/Kconfig.kasan
> > > > > > > @@ -134,6 +134,15 @@ config KASAN_S390_4_LEVEL_PAGING
> > > > > > >           to 3TB of RAM with KASan enabled). This options allows to force
> > > > > > >           4-level paging instead.
> > > > > > >
> > > > > > > +config KASAN_SW_TAGS_IDENTIFY
> > > > > > > +       bool "Enable memory corruption idenitfication"
> > > > > >
> > > > > > s/idenitfication/identification/
> > > > > >
> > > > > I should replace my glasses.
> > > > >
> > > > >
> > > > > > > +       depends on KASAN_SW_TAGS
> > > > > > > +       help
> > > > > > > +         Now tag-based KASAN bug report always shows invalid-access error, This
> > > > > > > +         options can identify it whether it is use-after-free or out-of-bound.
> > > > > > > +         This will make it easier for programmers to see the memory corruption
> > > > > > > +         problem.
> > > > > >
> > > > > > This description looks like a change description, i.e. it describes
> > > > > > the current behavior and how it changes. I think code comments should
> > > > > > not have such, they should describe the current state of the things.
> > > > > > It should also mention the trade-off, otherwise it raises reasonable
> > > > > > questions like "why it's not enabled by default?" and "why do I ever
> > > > > > want to not enable it?".
> > > > > > I would do something like:
> > > > > >
> > > > > > This option enables best-effort identification of bug type
> > > > > > (use-after-free or out-of-bounds)
> > > > > > at the cost of increased memory consumption for object quarantine.
> > > > > >
> > > > > I totally agree with your comments. Would you think we should try to add the cost?
> > > > > It may be that it consumes about 1/128th of available memory at full quarantine usage rate.
> > > >
> > > > Hi,
> > > >
> > > > I don't understand the question. We should not add costs if not
> > > > necessary. Or you mean why we should add _docs_ regarding the cost? Or
> > > > what?
> > > >
> > > I mean the description of option. Should it add the description for
> > > memory costs. I see KASAN_SW_TAGS and KASAN_GENERIC options to show the
> > > memory costs. So We originally think it is possible to add the
> > > description, if users want to enable it, maybe they want to know its
> > > memory costs.
> > >
> > > If you think it is not necessary, we will not add it.
> >
> > Full description of memory costs for normal KASAN mode and
> > KASAN_SW_TAGS should probably go into
> > Documentation/dev-tools/kasan.rst rather then into config description
> > because it may be too lengthy.
> >
> Thanks your reminder.
>
> > I mentioned memory costs for this config because otherwise it's
> > unclear why would one ever want to _not_ enable this option. If it
> > would only have positive effects, then it should be enabled all the
> > time and should not be a config option at all.
>
> Sorry, I don't get your full meaning.
> You think not to add the memory costs into the description of config ?
> or need to add it? or make it not be a config option(default enabled)?

Yes, I think we need to include mention of additional cost into _this_
new config.
