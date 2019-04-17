Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0478CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCA6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfDQOhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732259AbfDQOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B0D77DCDA;
        Wed, 17 Apr 2019 14:37:33 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B7860474;
        Wed, 17 Apr 2019 14:37:32 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:37:30 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Patrick Brunner <brunner@stettbacher.ch>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: IOMMU Page faults when running DMA transfers from PCIe device
Message-ID: <20190417143730.GC3229@redhat.com>
References: <2987837.CvKyUSae8N@jona>
 <20190416153307.GB3254@redhat.com>
 <2260223.u23yjLcID5@jona>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2260223.u23yjLcID5@jona>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 17 Apr 2019 14:37:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:17:09PM +0200, Patrick Brunner wrote:
> Am Dienstag, 16. April 2019, 17:33:07 CEST schrieb Jerome Glisse:
> > On Mon, Apr 15, 2019 at 06:04:11PM +0200, Patrick Brunner wrote:
> > > Dear all,
> > > 
> > > I'm encountering very nasty problems regarding DMA transfers from an
> > > external PCIe device to the main memory while the IOMMU is enabled, and
> > > I'm running out of ideas. I'm not even sure, whether it's a kernel issue
> > > or not. But I would highly appreciate any hints from experienced
> > > developers how to proceed to solve that issue.
> > > 
> > > The problem: An FPGA (see details below) should write a small amount of
> > > data (~128 bytes) over a PCIe 2.0 x1 link to an address in the CPU's
> > > memory space. The destination address (64 bits) for the Mem Write TLP is
> > > written to a BAR- mapped register before-hand.
> > > 
> > > On the system side, the driver consists of the usual setup code:
> > > - request PCI regions
> > > - pci_set_master
> > > - I/O remapping of BARs
> > > - setting DMA mask (dma_set_mask_and_coherent), tried both 32/64 bits
> > > - allocating DMA buffers with dma_alloc_coherent (4096 bytes, but also
> > > tried smaller numbers)
> > > - allocating IRQ lines (MSI) with pci_alloc_irq_vectors and pci_irq_vector
> > > - writing the DMA buffers' logical address (as returned in dma_handle_t
> > > from dma_alloc_coherent) to a BAR-mapped register
> > > 
> > > There is also an IRQ handler dumping the first 2 DWs from the DMA buffer
> > > when triggered.
> > > 
> > > The FPGA part will initiate following transfers at an interval of 2.5ms:
> > > - Memory write to DMA address
> > > - Send MSI (to signal that transfer is done)
> > > - Memory read from DMA address+offset
> > > 
> > > And now, the clue: everything works fine with the IOMMU disabled
> > > (iommu=off), i.e. the 2 DWs dumped in the ISR handler contain valid data.
> > > But if the IOMMU is enabled (iommu=soft or force), I receive an IO page
> > > fault (sometimes even more, depending on the payload size) on every
> > > transfer, and the data is all zeros:
> > > 
> > > [   49.001605] IO_PAGE_FAULT device=00:00.0 domain=0x0000
> > > address=0x00000000ffbf8000 flags=0x0070]
> > > 
> > > Where the device ID corresponds to the Host bridge, and the address
> > > corresponds to the DMA handle I got from dma_alloc_coherent respectively.
> > 
> > I am now expert but i am guessing your FPGA set the request field in the
> > PCIE TLP write packet to 00:00.0 and this might work when IOMMU is off but
> > might not work when IOMMU is on ie when IOMMU is on your device should set
> > the request field to the FPGA PCIE id so that the IOMMU knows for which
> > device the PCIE write or read packet is and thus against which IOMMU page
> > table.
> > 
> > Cheers,
> > Jérôme
> 
> Hi Jérôme
> 
> Thank you very much for your response.
> 
> You hit the nail! That was exactly the root cause of the problem. The request 
> field was properly filled in for the Memory Read TLP, but not for the Memory 
> Write TLP, where it was all-zeroes.
> 
> If I may ask another question: Is it possible to remap a buffer for DMA which 
> was allocated by other means? For the second phase, we are going to use the 
> RTAI extension(*) which provides its own memory allocation routines (e.g. 
> rt_shm_alloc()). There, you may pass the flag USE_GFP_DMA to indicate that 
> this buffer should be suitable for DMA. I've tried to remap this memory area 
> using virt_to_phys() and use the resulting address for the DMA transfer from 
> the FPGA, getting other IO page faults. E.g.:
> 
> [   70.100140] IO_PAGE_FAULT device=01:00.0 domain=0x0001 
> address=0x0000000000080000 flags=0x0020]
> 
> It's remarkable that the logical addresses returned from dma_alloc_coherent 
> (e.g. ffbd8000) look quite different from those returned by rt_shm_alloc
> +virt_to_phys (e.g. 00080000).
> 
> Unfortunately, it does not seem possible to do that the other way round, i.e. 
> forcing RTAI to use the buffer from dma_alloc_coherent.

You can use pci_map_page() or dma_map_page(). First you must get the page
that correspond to the virtual address (maybe with get_user_pages*() but
i would advice against it as it comes with a long list of gotcha and they
are no other alternative unless your device is advance enough).

Once you have the page for the virtual address then you can call either
dma_map_page() or pci_map_page(). I am sure you can find example within
the kernel for there usage.

It is also documented somewhere in Documentations/

Hopes this helps.

Cheers,
Jérôme
