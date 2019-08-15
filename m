Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC622083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfHOTkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbfHOTkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:40:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A08F73082E61;
        Thu, 15 Aug 2019 19:40:24 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7862A10016E8;
        Thu, 15 Aug 2019 19:40:23 +0000 (UTC)
Date:   Thu, 15 Aug 2019 15:40:21 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
Message-ID: <20190815194021.GB9253@redhat.com>
References: <20190807052858.GA9749@mypc>
 <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
 <20190815171918.GC30916@redhat.com>
 <d0a8ab6e-1122-a101-6139-9d7dadb9e999@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0a8ab6e-1122-a101-6139-9d7dadb9e999@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 19:40:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:23:44PM -0700, Ralph Campbell wrote:
> 
> On 8/15/19 10:19 AM, Jerome Glisse wrote:
> > On Wed, Aug 07, 2019 at 04:41:12PM +0800, Pingfan Liu wrote:
> > > Clean up useless 'pfn' variable.
> > 
> > NAK there is a bug see below:
> > 
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > To: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >   mm/migrate.c | 9 +++------
> > >   1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 8992741..d483a55 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -2225,17 +2225,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > >   		pte_t pte;
> > >   		pte = *ptep;
> > > -		pfn = pte_pfn(pte);
> > >   		if (pte_none(pte)) {
> > >   			mpfn = MIGRATE_PFN_MIGRATE;
> > >   			migrate->cpages++;
> > > -			pfn = 0;
> > >   			goto next;
> > >   		}
> > >   		if (!pte_present(pte)) {
> > > -			mpfn = pfn = 0;
> > > +			mpfn = 0;
> > >   			/*
> > >   			 * Only care about unaddressable device page special
> > > @@ -2252,10 +2250,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > >   			if (is_write_device_private_entry(entry))
> > >   				mpfn |= MIGRATE_PFN_WRITE;
> > >   		} else {
> > > +			pfn = pte_pfn(pte);
> > >   			if (is_zero_pfn(pfn)) {
> > >   				mpfn = MIGRATE_PFN_MIGRATE;
> > >   				migrate->cpages++;
> > > -				pfn = 0;
> > >   				goto next;
> > >   			}
> > >   			page = vm_normal_page(migrate->vma, addr, pte);
> > > @@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > >   		/* FIXME support THP */
> > >   		if (!page || !page->mapping || PageTransCompound(page)) {
> > > -			mpfn = pfn = 0;
> > > +			mpfn = 0;
> > >   			goto next;
> > >   		}
> > > -		pfn = page_to_pfn(page);
> > 
> > You can not remove that one ! Otherwise it will break the device
> > private case.
> > 
> 
> I don't understand. The only use of "pfn" I see is in the "else"
> clause above where it is set just before using it.

Ok i managed to confuse myself with mpfn and probably with old
version of the code. Sorry for reading too quickly. Can we move
unsigned long pfn; into the else { branch so that there is no
more confusion to its scope.

Cheers,
Jérôme
