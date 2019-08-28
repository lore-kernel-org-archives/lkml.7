Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D530F20828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567008507;
	bh=eLovFhfmXzqDIk/TDKv2aE9tBBV+t8nqpUbBWhhHJ0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=omdeQNmfM5Ku7I7/L9e/Ppos1BqpeehxORuLoCCY+RcAkUXkr987kJPndILTJ0imx
	 4xWoAIWu6QlJwOS3HBQAWyMirACe7OQLkBrXnP9y9qsLmUdDtoy2JM0xU7moDuEAAV
	 yUxSbEDZz+iDj2IlMVgUAQoE8+UHbxrB9DyXOtnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1QI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1QI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:08:26 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7425D20828;
        Wed, 28 Aug 2019 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567008505;
        bh=eLovFhfmXzqDIk/TDKv2aE9tBBV+t8nqpUbBWhhHJ0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w4ONHUiRrU0nxEr70fyR2MWO9PAeQgmAcFJMR0HtkOwvztAppvkFT+c4qGWAXfjik
         IbTkIGIuAN6WMd9S3dwNnQjOw93S0vGbUHHQ1Dzxt2ow9A61SFXMvj41uC70lnHUiG
         f5N883US8Ejxz2WG/HUDRRftZQlxF6flsarbt0ck=
Received: by mail-wr1-f42.google.com with SMTP id t16so373465wra.6;
        Wed, 28 Aug 2019 09:08:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUa9/nhab1UJpJmZLU1MNaEOE6Tl/5jq5BZQdSW8WaQAIwUW3kR
        5pahH7EwzrcYwZQUKQr2z3o19wef3SU02M4Ef2Q=
X-Google-Smtp-Source: APXvYqy2MdNrtC6cq/V0NhMLDf5lyTJAjLNy45uH8vKk7uRjJ0ygP5+oz3XINQQBpLNvZCOwwgVgmUlH8ULL13TEFrc=
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr5650476wrp.38.1567008503934;
 Wed, 28 Aug 2019 09:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1566999319-8151-1-git-send-email-rppt@linux.ibm.com>
 <CAJF2gTTF0W18kPzXP8hOA64FuOx=atxFnCk0syEhP7s7LOm0Kw@mail.gmail.com> <20190828143946.GA21342@rapoport-lnx>
In-Reply-To: <20190828143946.GA21342@rapoport-lnx>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 29 Aug 2019 00:08:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXf23s-7urhRLX3-bc+6atiO5WewN+PYr3T1-C-rLKig@mail.gmail.com>
Message-ID: <CAJF2gTQXf23s-7urhRLX3-bc+6atiO5WewN+PYr3T1-C-rLKig@mail.gmail.com>
Subject: Re: [PATCH] csky: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, no problem.

On Wed, Aug 28, 2019 at 10:39 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi,
>
> On Wed, Aug 28, 2019 at 10:12:52PM +0800, Guo Ren wrote:
> > Acked-by: Guo Ren <guoren@kernel.org>
>
> Do you mind taking it via csky tree?
>
> > On Wed, Aug 28, 2019 at 9:35 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > The csky implementation of free_initrd_mem() is an open-coded version of
> > > free_reserved_area() without poisoning.
> > >
> > > Remove it and make csky use the generic version of free_initrd_mem().
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/csky/mm/init.c | 16 ----------------
> > >  1 file changed, 16 deletions(-)
> > >
> > > diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> > > index eb0dc9e..d4c2292 100644
> > > --- a/arch/csky/mm/init.c
> > > +++ b/arch/csky/mm/init.c
> > > @@ -60,22 +60,6 @@ void __init mem_init(void)
> > >         mem_init_print_info(NULL);
> > >  }
> > >
> > > -#ifdef CONFIG_BLK_DEV_INITRD
> > > -void free_initrd_mem(unsigned long start, unsigned long end)
> > > -{
> > > -       if (start < end)
> > > -               pr_info("Freeing initrd memory: %ldk freed\n",
> > > -                       (end - start) >> 10);
> > > -
> > > -       for (; start < end; start += PAGE_SIZE) {
> > > -               ClearPageReserved(virt_to_page(start));
> > > -               init_page_count(virt_to_page(start));
> > > -               free_page(start);
> > > -               totalram_pages_inc();
> > > -       }
> > > -}
> > > -#endif
> > > -
> > >  extern char __init_begin[], __init_end[];
> > >
> > >  void free_initmem(void)
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> >
>
> --
> Sincerely yours,
> Mike.
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
