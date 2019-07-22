Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A18C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526E620821
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E54nSq8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfGVLI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:08:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfGVLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yI6oJAOD8RitgYpGXV7mavr3OofMjIjiw6wkaelvwj4=; b=E54nSq8QjpaTk0rNt3VrHCO3G
        6kAbY17R0sFpqIBTjoU+pieKC/cHS4iMnbKh8gX3+6PGXNEtD32bKcxKbDVjDeGtIRJLxUcsyn1NN
        3GyiIL+bgEf3zPDOl5k5dcOBYibUyF1CspeuBVydmylD8cU8ReuFqydxCS9WcVgKrGAONFHqfRk3P
        3xKD3XQpielWtJY3iWAQHp8SPP086TCjGdfvdG64iqF/3g5gTd2JtJEO4Xq1DIXdHMHv9HoFO1LyB
        u/WSNkyznbiMOroeS+PsuvJ/+iYGhHxXZC4RdMUKrwj6QdG4S8hrisMyAv6rOmyJ2kVjY7TQY+G1M
        MkPPuOq3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpWB7-0002Eh-PH; Mon, 22 Jul 2019 11:08:25 +0000
Date:   Mon, 22 Jul 2019 04:08:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: document zone device struct page field usage
Message-ID: <20190722110825.GD363@bombadil.infradead.org>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
 <20190719192955.30462-2-rcampbell@nvidia.com>
 <20190721160204.GB363@bombadil.infradead.org>
 <20190722051345.GB6157@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722051345.GB6157@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 10:13:45PM -0700, Ira Weiny wrote:
> On Sun, Jul 21, 2019 at 09:02:04AM -0700, Matthew Wilcox wrote:
> > On Fri, Jul 19, 2019 at 12:29:53PM -0700, Ralph Campbell wrote:
> > > Struct page for ZONE_DEVICE private pages uses the page->mapping and
> > > and page->index fields while the source anonymous pages are migrated to
> > > device private memory. This is so rmap_walk() can find the page when
> > > migrating the ZONE_DEVICE private page back to system memory.
> > > ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
> > > page->index fields when files are mapped into a process address space.
> > > 
> > > Restructure struct page and add comments to make this more clear.
> > 
> > NAK.  I just got rid of this kind of foolishness from struct page,
> > and you're making it harder to understand, not easier.  The comments
> > could be improved, but don't lay it out like this again.
> 
> Was V1 of Ralphs patch ok?  It seemed ok to me.

Yes, v1 was fine.  This seems like a regression.
