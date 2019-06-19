Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F41C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3662A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfFSKEo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:04:44 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62780 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbfFSKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:04:44 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16950740-1500050 
        for multiple; Wed, 19 Jun 2019 11:04:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <156032532526.2193.13029744217391066047@skylake-alporthouse-com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.cz>, Song Liu <liu.song.a23@gmail.com>
References: <20190307153051.18815-1-willy@infradead.org>
 <155951205528.18214.706102020945306720@skylake-alporthouse-com>
 <20190612014634.f23fjumw666jj52s@box>
 <156032532526.2193.13029744217391066047@skylake-alporthouse-com>
Message-ID: <156093866933.31375.12797765093948100374@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Wed, 19 Jun 2019 11:04:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2019-06-12 08:42:05)
> Quoting Kirill A. Shutemov (2019-06-12 02:46:34)
> > On Sun, Jun 02, 2019 at 10:47:35PM +0100, Chris Wilson wrote:
> > > Quoting Matthew Wilcox (2019-03-07 15:30:51)
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 404acdcd0455..aaf88f85d492 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2456,6 +2456,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > >                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> > > >                                 shmem_uncharge(head->mapping->host, 1);
> > > >                         put_page(head + i);
> > > > +               } else if (!PageAnon(page)) {
> > > > +                       __xa_store(&head->mapping->i_pages, head[i].index,
> > > > +                                       head + i, 0);
> > > 
> > > Forgiving the ignorant copy'n'paste, this is required:
> > > 
> > > +               } else if (PageSwapCache(page)) {
> > > +                       swp_entry_t entry = { .val = page_private(head + i) };
> > > +                       __xa_store(&swap_address_space(entry)->i_pages,
> > > +                                  swp_offset(entry),
> > > +                                  head + i, 0);
> > >                 }
> > >         }
> > >  
> > > The locking is definitely wrong.
> > 
> > Does it help with the problem, or it's just a possible lead?
> 
> It definitely solves the problem we encountered of the bad VM_PAGE
> leading to RCU stalls in khugepaged. The locking is definitely wrong
> though :)

I notice I'm not the only one to have bisected a swap related VM_PAGE_BUG
to this patch. Do we have a real fix I can put through our CI to confirm
the issue is resolved before 5.2?
-Chris
