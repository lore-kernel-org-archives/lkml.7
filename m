Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B7C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58561217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfGQEi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 00:38:27 -0400
Received: from verein.lst.de ([213.95.11.211]:47036 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQEi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:38:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 416C168B05; Wed, 17 Jul 2019 06:38:24 +0200 (CEST)
Date:   Wed, 17 Jul 2019 06:38:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] mm: document zone device struct page reserved
 fields
Message-ID: <20190717043824.GA4755@lst.de>
References: <20190717001446.12351-1-rcampbell@nvidia.com> <20190717001446.12351-2-rcampbell@nvidia.com> <26a47482-c736-22c4-c21b-eb5f82186363@nvidia.com> <20190717042233.GA4529@lst.de> <ae3936eb-2c08-c4a4-f670-10f25c7e0ed8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3936eb-2c08-c4a4-f670-10f25c7e0ed8@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 09:31:33PM -0700, John Hubbard wrote:
> OK, so just delete all the _zd_pad_* fields? Works for me. It's misleading to
> calling something padding, if it's actually unavailable because it's used
> in the other union, so deleting would be even better than commenting.
> 
> In that case, it would still be nice to have this new snippet, right?:

I hope willy can chime in a bit on his thoughts about how the union in
struct page should look like.  The padding at the end of the sub-structs
certainly looks pointless, and other places don't use it either.  But if
we are using the other fields it almost seems to me like we only want to
union the lru field in the first sub-struct instead of overlaying most
of it.
