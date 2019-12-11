Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E52077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfLKSVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:21:01 -0500
Received: from verein.lst.de ([213.95.11.211]:56752 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbfLKSVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:21:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4FD2668AFE; Wed, 11 Dec 2019 19:20:56 +0100 (CET)
Date:   Wed, 11 Dec 2019 19:20:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Roth <mdroth@linux.vnet.ibm.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, paulus@ozlabs.org, hch@lst.de,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        leonardo@linux.ibm.com
Subject: Re: [PATCH v5 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for
 Secure VM.
Message-ID: <20191211182056.GA17052@lst.de>
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com> <1575681159-30356-2-git-send-email-linuxram@us.ibm.com> <1575681159-30356-3-git-send-email-linuxram@us.ibm.com> <157602860458.3810.8599908751067047456@sif> <be36117d-204e-bf59-287a-371103186e16@ozlabs.ru> <157608763756.3810.12346253559039287143@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157608763756.3810.12346253559039287143@sif>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:07:17PM -0600, Michael Roth wrote:
> > io_tlb_start/io_tlb_end are only guaranteed to stay within 4GB and our
> > default DMA window is 1GB (KVM) or 2GB (PowerVM), ok, we can define
> > ARCH_LOW_ADDRESS_LIMIT as 1GB.
> 
> True, and limiting allocations to under 1GB might be brittle (also saw a
> patching floating around that increased IO_TLB_DEFAULT_SIZE size to 1GB,
> which obviously wouldn't work out with this approach, but not sure if
> that's still needed or not: "powerpc/svm: Increase SWIOTLB buffer size")

FYI, there is a patch out there that allocates the powerpc swiotlb
from the boottom of the memblock area instead of the top to fix a 85xx
regression.

Also the AMD folks have been asking about non-GFP_DMA32 swiotlb pools
as they have the same bounce buffer issue with SEV.  I think it is
entirely doable to have multiple swiotlb pool, I just need a volunteer
to implement that.

> 
> However that's only an issue if we insist on using an identity mapping
> in the IOMMU, which would be nice because non-IOMMU virtio would
> magically work, but since that's not a goal of this series I think we do
> have the option of mapping io_tlb_start at DMA address 0 (or
> thereabouts).
> 
> We'd probably need to modify __phys_to_dma to treat archdata.dma_offset
> as a negative offset in this case, but it seems like it would work about
> the same as with DDW offset.

Or switch to the generic version of __phys_to_dma that has a negative
offset.  We'd just need to look into a signed value for dma_pfn_offset
to allow for the existing platforms that need the current positive
offset.
