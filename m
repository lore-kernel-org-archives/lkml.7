Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0C120B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfECHbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfECHbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:31:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5BB9AEA1;
        Fri,  3 May 2019 07:31:29 +0000 (UTC)
Date:   Fri, 3 May 2019 09:31:26 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jane Chu <jane.chu@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190503073121.GA15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190502074803.GA3495@linux>
 <CAPcyv4jPG56sf4hHaKEoacQbDEpcMrr4fJVEwkxGjcWcCmieNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jPG56sf4hHaKEoacQbDEpcMrr4fJVEwkxGjcWcCmieNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:03:45AM -0700, Dan Williams wrote:
> > section_active_mask() also converts the value to address/size.
> > Why do we need to convert the values and we cannot work with pfn/pages instead?
> > It should be perfectly possible unless I am missing something.
> >
> > The only thing required would be to export earlier your:
> >
> > +#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
> > +#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))
> >
> > and change section_active_index to:
> >
> > static inline int section_active_index(unsigned long pfn)
> > {
> >         return (pfn & ~(PAGE_SECTION_MASK)) / SUB_SECTION_ACTIVE_PAGES;

Sorry, here I meant:

return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUB_SECTION;

But I think you got the idea :-)

-- 
Oscar Salvador
SUSE L3
