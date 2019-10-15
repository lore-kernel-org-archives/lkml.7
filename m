Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DFECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DD62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJOHbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:31:09 -0400
Received: from verein.lst.de ([213.95.11.211]:53271 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfJOHbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:31:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7CF568B05; Tue, 15 Oct 2019 09:31:04 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:31:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, aik@linux.ibm.com, paul.burton@mips.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, hch@lst.de,
        jasowang@redhat.com, andmike@us.ibm.com, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Message-ID: <20191015073104.GA32252@lst.de>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com> <1570843519-8696-2-git-send-email-linuxram@us.ibm.com> <20191014045139.GN4080@umbus.fritz.box> <37609731-5539-b906-aa94-2ef0242795ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37609731-5539-b906-aa94-2ef0242795ac@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:29:24AM +0100, Robin Murphy wrote:
>> However, I would like to see the commit message (and maybe the inline
>> comments) expanded a bit on what the distinction here is about.  Some
>> of the text from the next patch would be suitable, about DMA addresses
>> usually being in a different address space but not in the case of
>> bounce buffering.
>
> Right, this needs a much tighter definition. "DMA address happens to be a 
> valid physical address" is true of various IOMMU setups too, but I can't 
> believe it's meaningful in such cases.
>
> If what you actually want is "DMA is direct or SWIOTLB" - i.e. "DMA address 
> is physical address of DMA data (not necessarily the original buffer)" - 
> wouldn't dma_is_direct() suffice?

It would.  But drivers have absolutely no business knowing any of this.
