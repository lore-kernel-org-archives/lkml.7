Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0EC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB021993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfGVJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:37:00 -0400
Received: from verein.lst.de ([213.95.11.211]:58804 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVJhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:37:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1AF268B20; Mon, 22 Jul 2019 11:36:56 +0200 (CEST)
Date:   Mon, 22 Jul 2019 11:36:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20190722093656.GD29538@lst.de>
References: <20190719192955.30462-1-rcampbell@nvidia.com> <20190719192955.30462-2-rcampbell@nvidia.com> <20190721160204.GB363@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721160204.GB363@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 09:02:04AM -0700, Matthew Wilcox wrote:
> On Fri, Jul 19, 2019 at 12:29:53PM -0700, Ralph Campbell wrote:
> > Struct page for ZONE_DEVICE private pages uses the page->mapping and
> > and page->index fields while the source anonymous pages are migrated to
> > device private memory. This is so rmap_walk() can find the page when
> > migrating the ZONE_DEVICE private page back to system memory.
> > ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
> > page->index fields when files are mapped into a process address space.
> > 
> > Restructure struct page and add comments to make this more clear.
> 
> NAK.  I just got rid of this kind of foolishness from struct page,
> and you're making it harder to understand, not easier.  The comments
> could be improved, but don't lay it out like this again.

This comes over pretty agressive.  Please explain how making the
layout match how the code actually is used vs the previous separation
that is actively misleading and confused multiple people is "foolishness".
