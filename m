Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C6C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E9720663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfFXXBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:01:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:40541 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFXXBY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:01:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 16:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="163454969"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2019 16:01:24 -0700
Date:   Mon, 24 Jun 2019 16:01:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <Linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] mm/gup: speed up check_and_migrate_cma_pages() on huge
 page
Message-ID: <20190624230123.GA24567@iweiny-DESK2.sc.intel.com>
References: <1561349561-8302-1-git-send-email-kernelfans@gmail.com>
 <20190624044305.GA30102@iweiny-DESK2.sc.intel.com>
 <CAFgQCTuMVdrjkiQ5H3xUuME16g-xNUFXtvU1p+=P4-pujXcSAA@mail.gmail.com>
 <CAFgQCTshH=FsJbdf49wD=fgJzvbEqzEW--F3oon1aLc64r=u7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTshH=FsJbdf49wD=fgJzvbEqzEW--F3oon1aLc64r=u7w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:34:01PM +0800, Pingfan Liu wrote:
> On Mon, Jun 24, 2019 at 1:32 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Mon, Jun 24, 2019 at 12:43 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Mon, Jun 24, 2019 at 12:12:41PM +0800, Pingfan Liu wrote:
> > > > Both hugetlb and thp locate on the same migration type of pageblock, since
> > > > they are allocated from a free_list[]. Based on this fact, it is enough to
> > > > check on a single subpage to decide the migration type of the whole huge
> > > > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > > > similar on other archs.
> > > >
> > > > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > > > hugetlb_lock many times, and meanless remove/add to the local link list
> > > > cma_page_list.
> > > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > > Cc: Linux-kernel@vger.kernel.org
> > > > ---
> > > >  mm/gup.c | 19 ++++++++++++-------
> > > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index ddde097..544f5de 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> > > >       LIST_HEAD(cma_page_list);
> > > >
> > > >  check_again:
> > > > -     for (i = 0; i < nr_pages; i++) {
> > > > +     for (i = 0; i < nr_pages;) {
> > > > +
> > > > +             struct page *head = compound_head(pages[i]);
> > > > +             long step = 1;
> > > > +
> > > > +             if (PageCompound(head))
> > > > +                     step = compound_order(head) - (pages[i] - head);
> > >
> > > Sorry if I missed this last time.  compound_order() is not correct here.
> > For thp, prep_transhuge_page()->prep_compound_page()->set_compound_order().
> > For smaller hugetlb,
> > prep_new_huge_page()->prep_compound_page()->set_compound_order().
> > For gigantic page, prep_compound_gigantic_page()->set_compound_order().
> >
> > Do I miss anything?
> >
> Oh, got it. It should be 1<<compound_order(head)

Yea.

Ira

> > Thanks,
> >   Pingfan
> > [...]
