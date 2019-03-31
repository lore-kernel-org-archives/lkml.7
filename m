Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B8EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA352086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Ut0kmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfCaPO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:14:57 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36549 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbfCaPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:14:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id n4so4032301vsm.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBsJQsFvMrPo98lUzLMYhevM4wuKttyWGnDZLyEeI5I=;
        b=g8Ut0kmJICKhqDxP9atG/H7Yv4fVseGuy/EJ91DIaFNaNUChAwd8eHHAES77CHLOQw
         FBpBn0MJZN4mET3h8XVOVH9IEyznbDrugOr1ja+ByNxA9weKhZxlju++8WK34SMj28mN
         YGD3QWiDi/VGpavY/U2rSijys5shVfs9SswggySLdG+d/J4K6125qVEiBd598N23NipS
         ngaIdVaO7WQdcXXJWP629G3WBf1zj0bsKBGwOeJeA5Y3Ho3yyhZoJeQ1iL0u469qQUrG
         F2SjoN3wW9nUpYUs35Griy9rZ1XxvFF8DZJk9o7GKebS7K9fdqysYigelvrYMB9gdWsD
         xw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBsJQsFvMrPo98lUzLMYhevM4wuKttyWGnDZLyEeI5I=;
        b=OrU6d2GqP48JOCewYpO6gnLl4yg8YIk0MmVUE2FAuRsY+YwO0dVMAWJsGz9nPLD0DS
         IuGkcfApMjGbBYGTlZ9KfeTP10s2wp77QAl1nbuo/ynGcQRx9A5OfkG9vH6wnHcnyMXn
         HPans76zDjFnQMx+yz24pCykUNNI4R8cadBC6hZLz3J/IPYFRkljIsTKtaHm36EmOaeQ
         4DzlEwV+l6LHbCJYKnP/X0gIrlA7cy65TCmzJ7nDO0Bp+UJQY+WD/3EgAwtFkA1SpYZb
         WUBpaLDsfW1P6xhYBmJ+CT/OYepy/ebYue/blqWRlrsB+xP2BjPI1q0tMwszEnU642PX
         0e4g==
X-Gm-Message-State: APjAAAXE7j9BYyn2bljcyJq+uPo0rek2iGwVdOgWk9XWKZlsA44RAeeB
        SE10RheV40do8AVVBF1QErj0pMo3wEbDWfcncF0=
X-Google-Smtp-Source: APXvYqzK83/i8i+qsrzflAplGdVyteBV7BJTIGue66UCsb4hczK2yA3KU2IVzZJMpVg9VE0gQiZ444gz58oe1gcx8jY=
X-Received: by 2002:a67:f694:: with SMTP id n20mr35245354vso.9.1554045296313;
 Sun, 31 Mar 2019 08:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190314032047.15790-1-vichy.kuo@gmail.com> <20190319153114.GI59586@arrakis.emea.arm.com>
In-Reply-To: <20190319153114.GI59586@arrakis.emea.arm.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Sun, 31 Mar 2019 23:14:44 +0800
Message-ID: <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Catalin:

> On Thu, Mar 14, 2019 at 11:20:47AM +0800, pierre Kuo wrote:
> > in the previous case, initrd_start and initrd_end can be successfully
> > returned either (base < memblock_start_of_DRAM()) or (base + size >
> > memblock_start_of_DRAM() + linear_region_size).
> >
> > That means even linear mapping range check fail for initrd_start and
> > initrd_end, it still can get virtual address. Here we put
> > initrd_start/initrd_end to be calculated only when linear mapping check
> > pass.
> >
> > Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
>
> For future versions, please also cc the author of the original commit
> you are fixing.

Got it and thanks for ur warm reminder ^^

> >
> >  arch/arm64/mm/init.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 7205a9085b4d..1adf418de685 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -425,6 +425,9 @@ void __init arm64_memblock_init(void)
> >                       memblock_remove(base, size); /* clear MEMBLOCK_ flags */
> >                       memblock_add(base, size);
> >                       memblock_reserve(base, size);
> > +                     /* the generic initrd code expects virtual addresses */
> > +                     initrd_start = __phys_to_virt(phys_initrd_start);
> > +                     initrd_end = initrd_start + phys_initrd_size;
> >               }
> >       }
> >
> > @@ -450,11 +453,6 @@ void __init arm64_memblock_init(void)
> >        * pagetables with memblock.
> >        */
> >       memblock_reserve(__pa_symbol(_text), _end - _text);
> > -     if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
> > -             /* the generic initrd code expects virtual addresses */
> > -             initrd_start = __phys_to_virt(phys_initrd_start);
> > -             initrd_end = initrd_start + phys_initrd_size;
> > -     }
>
> With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
> after the place where you moved the initrd_{start,end} setting, which
> would result in a different value for __phys_to_virt(phys_initrd_start).

I found what you mean, since __phys_to_virt will use PHYS_OFFSET
(memstart_addr) for calculating.
How about moving CONFIG_RANDOMIZE_BASE part of code ahead of
CONFIG_BLK_DEV_INITRD checking?

That means below (d) moving ahead of (c)
prvious:
if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)

now:
if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) { ---(a)
if (memory_limit != PHYS_ADDR_MAX) {}              ----------------(b)
if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}  --------------(d)
if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}  ---(c)

Appreciate your kind advice.
