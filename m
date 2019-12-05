Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909921835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfLEI2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:28:45 -0500
Received: from verein.lst.de ([213.95.11.211]:54012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfLEI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:28:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D04768C4E; Thu,  5 Dec 2019 09:28:38 +0100 (CET)
Date:   Thu, 5 Dec 2019 09:28:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE
 page with the hypervisor.
Message-ID: <20191205082837.GA20298@lst.de>
References: <20191203020850.GA12354@oc0525413822.ibm.com> <0b56ce3e-6c32-5f3b-e7cc-0d419a61d71d@ozlabs.ru> <20191203040509.GB12354@oc0525413822.ibm.com> <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru> <20191203165204.GA5079@oc0525413822.ibm.com> <3a17372a-fcee-efbf-0a05-282ffb1adc90@ozlabs.ru> <20191204004958.GB5063@oc0525413822.ibm.com> <5963ff32-2119-be7c-d1e5-63457888a73b@ozlabs.ru> <20191204033618.GA5031@umbus.fritz.box> <20191204204232.GE5063@oc0525413822.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204204232.GE5063@oc0525413822.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 12:42:32PM -0800, Ram Pai wrote:
> > The other approach we could use for that - which would still allow
> > H_PUT_TCE_INDIRECT, would be to allocate the TCE buffer page from the
> > same pool that we use for the bounce buffers.  I assume there must
> > already be some sort of allocator for that?
> 
> The allocator for swiotlb is buried deep in the swiotlb code. It is 
> not exposed to the outside-swiotlb world. Will have to do major surgery
> to expose it.

I don't think it would require all that much changes, but I'd really
hate the layering of calling into it directly.  Do we have a struct
device associated with the iommu that doesn't get iommu translations
themselves?  If we do a dma_alloc_coherent on that you'll get the
memory pool for free.
