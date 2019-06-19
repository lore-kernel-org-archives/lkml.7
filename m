Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C11C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B04208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOgBcyWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfFSKgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:36:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41893 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:36:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so2725673lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vEo5ld3iyjHBFwUuEjWL+Gba8QM9jKd32c5zWkOfXU=;
        b=fOgBcyWWXD9P2VTaJp8pVqhCFDQL68ehA5gqT0yPI6bQbj514Ee+DULCsd6Dp3ZbOh
         DGSZXVuG7lYeqbUXZs93eOiIBvJGV33/slmAioY+QScWze4CArTSsWfog5HCd1bAHP+m
         WcHckthzkDjRHUnW8VFUHgqW2PUMrX46gUTcn8tQaddFvyHyWodiAbX5yapFWHi9eaAe
         j4FjHZ8pEns9hMWJQQ4ufug3wGHPTiAHYNiwGWjxAf3BlekJ/hzkgCYmRi5M1kvl9yZm
         NTEgNM0PZAGqI0KG/meyH4d7ejAAlEARet0RWBIMNpvTlBFYCIoAw4kXpFj6O9qUwUJA
         A3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vEo5ld3iyjHBFwUuEjWL+Gba8QM9jKd32c5zWkOfXU=;
        b=GqC/cPFRtU4oOdlqq+V6/DOtiKp+2Kl88knjipNASHyn7BMQp6JbCBV8FZwsyoIT5a
         Ve1sDCGV9CuN6pgRS/uKrCnkBg4RREqOLeYBmP+kEN5nziQIeFRGxQb9K1zg+eEn4Vkv
         Z3KweZzJxeRj/yUrzLKjoGR2qQEdWqGra4J9eW2o184ZPM/7qFEPs41cPhzRVpoqbIM2
         EKzenaHWF3D8PoPnmQKczR4h1I6XcALaNSQjgoNGFQeQwzqYyQ68ATYFoiAfa2z3QWYu
         KWDHKogiAx/LAqWohgLUXdv2t/K8qnx70VCqFfYwC9dZPiP+8Ib7OOtmz998IOqIkA/m
         qXLA==
X-Gm-Message-State: APjAAAW1JuzQNXiqpGr8jGpU+m8/Gb5/CfNF1OP2aTaNLrKYoEwMNHfJ
        oO/NpXNZJe5QNoJ1BU35Us8=
X-Google-Smtp-Source: APXvYqy2z2pzaeKHA9hb6yNgYbbhdvOfcA4iWRJnQjmbNVPRzTzd9ruwFCZMUQXHwqCqKwOAy9ozAQ==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr27228732ljh.175.1560940604841;
        Wed, 19 Jun 2019 03:36:44 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id v14sm2624011lfb.50.2019.06.19.03.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 03:36:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 19 Jun 2019 12:36:36 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: avoid bogus -Wmaybe-uninitialized warning
Message-ID: <20190619103636.rzjca5jxofc5anjw@pc636>
References: <20190618092650.2943749-1-arnd@arndb.de>
 <CAJWu+oqzd8MJqusRV0LAK=Xnm7VSRSu3QbNZ-j5h9_MbzcFhhg@mail.gmail.com>
 <20190618140622.bbak3is7yv32hfjn@pc636>
 <20190618135920.9dd7bdc78fc0ce33ee65d99c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618135920.9dd7bdc78fc0ce33ee65d99c@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:59:20PM -0700, Andrew Morton wrote:
> On Tue, 18 Jun 2019 16:06:22 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > On Tue, Jun 18, 2019 at 09:40:28AM -0400, Joel Fernandes wrote:
> > > On Tue, Jun 18, 2019 at 5:27 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > gcc gets confused in pcpu_get_vm_areas() because there are too many
> > > > branches that affect whether 'lva' was initialized before it gets
> > > > used:
> > > >
> > > > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> > > > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > > >     insert_vmap_area_augment(lva, &va->rb_node,
> > > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >      &free_vmap_area_root, &free_vmap_area_list);
> > > >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > mm/vmalloc.c:916:20: note: 'lva' was declared here
> > > >   struct vmap_area *lva;
> > > >                     ^~~
> > > >
> > > > Add an intialization to NULL, and check whether this has changed
> > > > before the first use.
> > > >
> > > > Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  mm/vmalloc.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index a9213fc3802d..42a6f795c3ee 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -913,7 +913,12 @@ adjust_va_to_fit_type(struct vmap_area *va,
> > > >         unsigned long nva_start_addr, unsigned long size,
> > > >         enum fit_type type)
> > > >  {
> > > > -       struct vmap_area *lva;
> > > > +       /*
> > > > +        * GCC cannot always keep track of whether this variable
> > > > +        * was initialized across many branches, therefore set
> > > > +        * it NULL here to avoid a warning.
> > > > +        */
> > > > +       struct vmap_area *lva = NULL;
> > > 
> > > Fair enough, but is this 5-line comment really needed here?
> > > 
> > How it is rewritten now, probably not. I would just set it NULL and
> > leave the comment, but that is IMHO. Anyway
> > 
> 
> I agree - given that the patch does this:
> 
> @@ -972,7 +977,7 @@ adjust_va_to_fit_type(struct vmap_area *
>  	if (type != FL_FIT_TYPE) {
>  		augment_tree_propagate_from(va);
>  
> -		if (type == NE_FIT_TYPE)
> +		if (lva)
>  			insert_vmap_area_augment(lva, &va->rb_node,
>  				&free_vmap_area_root, &free_vmap_area_list);
>  	}
> 
> the comment simply isn't relevant any more.  Although I guess this
> might be a bit helpful:
> 
> @@ -977,7 +972,7 @@ adjust_va_to_fit_type(struct vmap_area *
>  	if (type != FL_FIT_TYPE) {
>  		augment_tree_propagate_from(va);
>  
> -		if (lva)
> +		if (lva)	/* type == NE_FIT_TYPE */
>  			insert_vmap_area_augment(lva, &va->rb_node,
>  				&free_vmap_area_root, &free_vmap_area_list);
>  	}
> 
That comment makes it much clear, thanks!

--
Vlad Rezki
