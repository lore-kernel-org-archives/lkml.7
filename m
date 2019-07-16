Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FDC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35C120880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfGPPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfGPPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4A73C034DF3;
        Tue, 16 Jul 2019 15:33:39 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C221001B00;
        Tue, 16 Jul 2019 15:33:38 +0000 (UTC)
Date:   Tue, 16 Jul 2019 11:33:37 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Message-ID: <20190716153337.GA3490@redhat.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
 <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
 <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
 <20190715150031.49c2846f4617f30bca5f043f@linux-foundation.org>
 <0ee5166a-26cd-a504-b9db-cffd082ecd38@nvidia.com>
 <8dd86951-f8b0-75c2-d738-5080343e5dc5@nvidia.com>
 <6a52c2a0-8d27-2ce4-e797-7cae653df21a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a52c2a0-8d27-2ce4-e797-7cae653df21a@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 16 Jul 2019 15:33:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:14:31PM -0700, John Hubbard wrote:
> On 7/15/19 5:38 PM, Ralph Campbell wrote:
> > On 7/15/19 4:34 PM, John Hubbard wrote:
> > > On 7/15/19 3:00 PM, Andrew Morton wrote:
> > > > On Tue, 9 Jul 2019 18:24:57 -0700 Ralph Campbell <rcampbell@nvidia.com> wrote:
> > > > 
> > > >   mm/rmap.c |    1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > --- a/mm/rmap.c~mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one
> > > > +++ a/mm/rmap.c
> > > > @@ -1476,6 +1476,7 @@ static bool try_to_unmap_one(struct page
> > > >                * No need to invalidate here it will synchronize on
> > > >                * against the special swap migration pte.
> > > >                */
> > > > +            subpage = page;
> > > >               goto discard;
> > > >           }
> > > 
> > > Hi Ralph and everyone,
> > > 
> > > While the above prevents a crash, I'm concerned that it is still not
> > > an accurate fix. This fix leads to repeatedly removing the rmap, against the
> > > same struct page, which is odd, and also doesn't directly address the
> > > root cause, which I understand to be: this routine can't handle migrating
> > > the zero page properly--over and back, anyway. (We should also mention more
> > > about how this is triggered, in the commit description.)
> > > 
> > > I'll take a closer look at possible fixes (I have to step out for a bit) soon,
> > > but any more experienced help is also appreciated here.
> > > 
> > > thanks,
> > 
> > I'm not surprised at the confusion. It took me quite awhile to
> > understand how migrate_vma() works with ZONE_DEVICE private memory.
> > The big point to be aware of is that when migrating a page to
> > device private memory, the source page's page->mapping pointer
> > is copied to the ZONE_DEVICE struct page and the page_mapcount()
> > is increased. So, the kernel sees the page as being "mapped"
> > but the page table entry as being is_swap_pte() so the CPU will fault
> > if it tries to access the mapped address.
> 
> Thanks for humoring me here...
> 
> The part about the source page's page->mapping pointer being *copied*
> to the ZONE_DEVICE struct page is particularly interesting, and belongs
> maybe even in a comment (if not already there). Definitely at least in
> the commit description, for now.
> 
> > So yes, the source anon page is unmapped, DMA'ed to the device,
> > and then mapped again. Then on a CPU fault, the zone device page
> > is unmapped, DMA'ed to system memory, and mapped again.
> > The rmap_walk() is used to clear the temporary migration pte so
> > that is another important detail of how migrate_vma() works.
> > At the moment, only single anon private pages can migrate to
> > device private memory so there are no subpages and setting it to "page"
> > should be correct for now. I'm looking at supporting migration of
> > transparent huge pages but that is a work in progress.
> 
> Well here, I worry, because subpage != tail page, right? subpage is a
> strange variable name, and here it is used to record the page that
> corresponds to *each* mapping that is found during the reverse page
> mapping walk.
> 
> And that makes me suspect that if there were more than one of these
> found (which is unlikely, given the light testing that we have available
> so far, I realize), then there could possibly be a problem with the fix,
> yes?

No THP when migrating to device memory so no tail vs head page here.

Cheers,
Jérôme
