Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD332133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfHNHi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:38:59 -0400
Received: from verein.lst.de ([213.95.11.211]:35522 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNHi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:38:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17B9F68B20; Wed, 14 Aug 2019 09:38:55 +0200 (CEST)
Date:   Wed, 14 Aug 2019 09:38:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Message-ID: <20190814073854.GA27249@lst.de>
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de> <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com> <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> Section alignment constraints somewhat save us here. The only example
> I can think of a PMD not containing a uniform pgmap association for
> each pte is the case when the pgmap overlaps normal dram, i.e. shares
> the same 'struct memory_section' for a given span. Otherwise, distinct
> pgmaps arrange to manage their own exclusive sections (and now
> subsections as of v5.3). Otherwise the implementation could not
> guarantee different mapping lifetimes.
> 
> That said, this seems to want a better mechanism to determine "pfn is
> ZONE_DEVICE".

So I guess this patch is fine for now, and once you provide a better
mechanism we can switch over to it?
