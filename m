Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ECC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCMSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:33:01 -0400
Received: from verein.lst.de ([213.95.11.211]:53262 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfCMSdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:33:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7D86368B05; Wed, 13 Mar 2019 19:32:54 +0100 (CET)
Date:   Wed, 13 Mar 2019 19:32:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Message-ID: <20190313183254.GC4926@lst.de>
References: <20190304195951.1118807-1-arnd@arndb.de> <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com> <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com> <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com> <20190308152355.GA20230@lst.de> <124f4e49-9eb1-99d9-35f4-c2ef3dff8415@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124f4e49-9eb1-99d9-35f4-c2ef3dff8415@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 05:25:57PM +0000, Julien Grall wrote:
> In the common case, Dom0 also contains the PV backend drivers. Those 
> drivers may directly use the guest buffer in the DMA request (so a copy is 
> avoided). To avoid using a bounce buffer too much, xen-swiotlb will find 
> the host physical address associated to the guest buffer and will use it to 
> compute the DMA address.
>
> While Dom0 kernel may only deal with 32-bit physical address, the 
> hypervisor can still deal with up to 40-bit physical address. This means 
> the guest memory can be allocated above the 4GB threshold. Hence why the 
> dma_addr_t is always 64-bit with CONFIG_XEN=y.

This at least makes some sense.  But is it really so much better to
avoid having a 64-bit phys_addr_t?
