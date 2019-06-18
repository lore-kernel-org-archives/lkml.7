Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29208C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254721655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atm7CO5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfFROGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:06:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35005 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFROGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:06:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so3681662ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QTZqy45k7+sDKOksZP/D2s9gAFDBBAHV7AhvC7CBxAQ=;
        b=Atm7CO5Cu6u7ITQBOejBMNudmy6J6C6jPHf8lkqcirJUgLtaP5ac5yQ33LMRr7Dg8P
         9bAspssbkF5m1NiYck3rTXbtN21Z6vGYbWSOEJEl3mIgmUAUxa9dE6609N94K1vQ1y9W
         AYbnm4bbyIb1DOL1GNxgqb8pmFw3YA11xJ28KDcI2k95/DjaplWwuQwWXhW65IQ0uXk9
         yUQ/0Oey7gYcfdoYNSBvzmvgljve31nsG/bS8Ar4UQMh8MQG+YtKdkDG0k3RtYUUi/lz
         9v3/0wjSPGkofCXlPXVcTcJwuzpz+ZfSGivQ4ZWxlaKhhLdbSX8WToxQg0zO2Pj1jOhl
         wN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTZqy45k7+sDKOksZP/D2s9gAFDBBAHV7AhvC7CBxAQ=;
        b=RnpDY3koZbo6U26O+FGn5wWQBF4bO/pMTU//DbNhwzktzFeVTQboexiFZmlIw3sNxR
         2EbAU/mi5v077+ClLKLLeJO8xQuYRSIKoO0/XvcrEZhbzdUEZhegFUSjOnJVnrg9VZHa
         XSTzXI9aZO5rdxi+yNFYbBgkGd7Vn3kJYz7Z3q+M1bkfmGhc1ejhz9ZZjJBBL7G35E3K
         CjuHeG4GTA08Z9P8eooTLaWCEABKKqAV3vq9AD/Dnqef6/5xUaW0C7tBUGDUlUFOv2/N
         75vS+c+Ypo9Gcp77fZdRSEgff8+PvCzERw7jBFrLzeVJRMXrzr/OBJ2n1Xzz/5lRB1GJ
         8BTw==
X-Gm-Message-State: APjAAAUQ3ZQYqKYfmMuZ1CyRhdgBXrjvmu0fTK8mESy8xD9McgTDC16Y
        NQ9S4k/Pd7egQqS9bF69l/c=
X-Google-Smtp-Source: APXvYqwHPxz5wQf2l7vQGoUuWHaLCHNCKVabuKAlqkhXyXtuR15zj4ULZlZKJJ46pS7yfP1c1Jo+wQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr33791259lji.75.1560866789998;
        Tue, 18 Jun 2019 07:06:29 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id a18sm2614271ljf.35.2019.06.18.07.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 07:06:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Jun 2019 16:06:22 +0200
To:     Joel Fernandes <joelaf@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Roman Penyaev <rpenyaev@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190618140622.bbak3is7yv32hfjn@pc636>
References: <20190618092650.2943749-1-arnd@arndb.de>
 <CAJWu+oqzd8MJqusRV0LAK=Xnm7VSRSu3QbNZ-j5h9_MbzcFhhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqzd8MJqusRV0LAK=Xnm7VSRSu3QbNZ-j5h9_MbzcFhhg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:40:28AM -0400, Joel Fernandes wrote:
> On Tue, Jun 18, 2019 at 5:27 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > gcc gets confused in pcpu_get_vm_areas() because there are too many
> > branches that affect whether 'lva' was initialized before it gets
> > used:
> >
> > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >     insert_vmap_area_augment(lva, &va->rb_node,
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      &free_vmap_area_root, &free_vmap_area_list);
> >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > mm/vmalloc.c:916:20: note: 'lva' was declared here
> >   struct vmap_area *lva;
> >                     ^~~
> >
> > Add an intialization to NULL, and check whether this has changed
> > before the first use.
> >
> > Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  mm/vmalloc.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a9213fc3802d..42a6f795c3ee 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -913,7 +913,12 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >         unsigned long nva_start_addr, unsigned long size,
> >         enum fit_type type)
> >  {
> > -       struct vmap_area *lva;
> > +       /*
> > +        * GCC cannot always keep track of whether this variable
> > +        * was initialized across many branches, therefore set
> > +        * it NULL here to avoid a warning.
> > +        */
> > +       struct vmap_area *lva = NULL;
> 
> Fair enough, but is this 5-line comment really needed here?
> 
How it is rewritten now, probably not. I would just set it NULL and
leave the comment, but that is IMHO. Anyway

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Vlad Rezki
