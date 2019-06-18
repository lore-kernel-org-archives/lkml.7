Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A63C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2721479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891565;
	bh=OKekjAHMHDSKBX7i8AEyG++qk2Jq9H3Y71jv2y4IdLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=huF2XoepUZ3yRuUu2jkK6IDk8vlVSeM+TrJ43Ycel4bwDARgBMFJYrM3G4QC+6Z32
	 txvKz1MOr5ccNRoPTBszg5MvTJDNPI+oHJXlUIU1bjHgzVTJbgxzdbA/husixsvHRr
	 xCW/EVkKgNEYn3AJ3krA8LvxYQ3w0axe3ZdZFMYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfFRU7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfFRU7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:59:23 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C2C20863;
        Tue, 18 Jun 2019 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560891562;
        bh=OKekjAHMHDSKBX7i8AEyG++qk2Jq9H3Y71jv2y4IdLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRPi+E6V6BOa4jcRdwiJTpkttXzbzF7JzL+etbTckkndfBqAq8OEfjCMcljvaUl5A
         Y0dguz5W/QAQY/rZu34ZBxhJDhgFbNBRj3YPGSV5CsXkQLhMnGgPxgOMaInyd2e2yY
         /VadGoXzYEJuUjtFcTrb9+vrKqIoxTcf+93+SKaU=
Date:   Tue, 18 Jun 2019 13:59:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joelaf@google.com>, Arnd Bergmann <arnd@arndb.de>,
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
Message-Id: <20190618135920.9dd7bdc78fc0ce33ee65d99c@linux-foundation.org>
In-Reply-To: <20190618140622.bbak3is7yv32hfjn@pc636>
References: <20190618092650.2943749-1-arnd@arndb.de>
        <CAJWu+oqzd8MJqusRV0LAK=Xnm7VSRSu3QbNZ-j5h9_MbzcFhhg@mail.gmail.com>
        <20190618140622.bbak3is7yv32hfjn@pc636>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 16:06:22 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> On Tue, Jun 18, 2019 at 09:40:28AM -0400, Joel Fernandes wrote:
> > On Tue, Jun 18, 2019 at 5:27 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > gcc gets confused in pcpu_get_vm_areas() because there are too many
> > > branches that affect whether 'lva' was initialized before it gets
> > > used:
> > >
> > > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> > > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > >     insert_vmap_area_augment(lva, &va->rb_node,
> > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >      &free_vmap_area_root, &free_vmap_area_list);
> > >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > mm/vmalloc.c:916:20: note: 'lva' was declared here
> > >   struct vmap_area *lva;
> > >                     ^~~
> > >
> > > Add an intialization to NULL, and check whether this has changed
> > > before the first use.
> > >
> > > Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  mm/vmalloc.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index a9213fc3802d..42a6f795c3ee 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -913,7 +913,12 @@ adjust_va_to_fit_type(struct vmap_area *va,
> > >         unsigned long nva_start_addr, unsigned long size,
> > >         enum fit_type type)
> > >  {
> > > -       struct vmap_area *lva;
> > > +       /*
> > > +        * GCC cannot always keep track of whether this variable
> > > +        * was initialized across many branches, therefore set
> > > +        * it NULL here to avoid a warning.
> > > +        */
> > > +       struct vmap_area *lva = NULL;
> > 
> > Fair enough, but is this 5-line comment really needed here?
> > 
> How it is rewritten now, probably not. I would just set it NULL and
> leave the comment, but that is IMHO. Anyway
> 

I agree - given that the patch does this:

@@ -972,7 +977,7 @@ adjust_va_to_fit_type(struct vmap_area *
 	if (type != FL_FIT_TYPE) {
 		augment_tree_propagate_from(va);
 
-		if (type == NE_FIT_TYPE)
+		if (lva)
 			insert_vmap_area_augment(lva, &va->rb_node,
 				&free_vmap_area_root, &free_vmap_area_list);
 	}

the comment simply isn't relevant any more.  Although I guess this
might be a bit helpful:

@@ -977,7 +972,7 @@ adjust_va_to_fit_type(struct vmap_area *
 	if (type != FL_FIT_TYPE) {
 		augment_tree_propagate_from(va);
 
-		if (lva)
+		if (lva)	/* type == NE_FIT_TYPE */
 			insert_vmap_area_augment(lva, &va->rb_node,
 				&free_vmap_area_root, &free_vmap_area_list);
 	}

