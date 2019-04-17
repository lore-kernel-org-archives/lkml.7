Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2FC20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbfDQOZy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:25:54 -0400
Received: from v5prod-smtp4bis.alinto.net ([31.172.161.223]:20031 "EHLO
        smtpoutv5.alinto.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730209AbfDQOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:25:53 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2019 10:25:52 EDT
Received: from smtpoutv5.alinto.net ([127.0.0.1])
        by localhost (v5prod-smtp2.alinto.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aIFL7h-xQSbM; Wed, 17 Apr 2019 16:17:15 +0200 (CEST)
Received: from jona.localnet (unknown [80.254.183.189])
        (Authenticated sender: brunner@stettbacher.ch)
        by smtpoutv5.alinto.net (Postfix) with ESMTPA id 44kkp25mdDz7px;
        Wed, 17 Apr 2019 16:17:14 +0200 (CEST)
From:   Patrick Brunner <brunner@stettbacher.ch>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: IOMMU Page faults when running DMA transfers from PCIe device
Date:   Wed, 17 Apr 2019 16:17:09 +0200
Message-ID: <2260223.u23yjLcID5@jona>
Organization: Stettbacher Signal Processing
In-Reply-To: <20190416153307.GB3254@redhat.com>
References: <2987837.CvKyUSae8N@jona> <20190416153307.GB3254@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. April 2019, 17:33:07 CEST schrieb Jerome Glisse:
> On Mon, Apr 15, 2019 at 06:04:11PM +0200, Patrick Brunner wrote:
> > Dear all,
> > 
> > I'm encountering very nasty problems regarding DMA transfers from an
> > external PCIe device to the main memory while the IOMMU is enabled, and
> > I'm running out of ideas. I'm not even sure, whether it's a kernel issue
> > or not. But I would highly appreciate any hints from experienced
> > developers how to proceed to solve that issue.
> > 
> > The problem: An FPGA (see details below) should write a small amount of
> > data (~128 bytes) over a PCIe 2.0 x1 link to an address in the CPU's
> > memory space. The destination address (64 bits) for the Mem Write TLP is
> > written to a BAR- mapped register before-hand.
> > 
> > On the system side, the driver consists of the usual setup code:
> > - request PCI regions
> > - pci_set_master
> > - I/O remapping of BARs
> > - setting DMA mask (dma_set_mask_and_coherent), tried both 32/64 bits
> > - allocating DMA buffers with dma_alloc_coherent (4096 bytes, but also
> > tried smaller numbers)
> > - allocating IRQ lines (MSI) with pci_alloc_irq_vectors and pci_irq_vector
> > - writing the DMA buffers' logical address (as returned in dma_handle_t
> > from dma_alloc_coherent) to a BAR-mapped register
> > 
> > There is also an IRQ handler dumping the first 2 DWs from the DMA buffer
> > when triggered.
> > 
> > The FPGA part will initiate following transfers at an interval of 2.5ms:
> > - Memory write to DMA address
> > - Send MSI (to signal that transfer is done)
> > - Memory read from DMA address+offset
> > 
> > And now, the clue: everything works fine with the IOMMU disabled
> > (iommu=off), i.e. the 2 DWs dumped in the ISR handler contain valid data.
> > But if the IOMMU is enabled (iommu=soft or force), I receive an IO page
> > fault (sometimes even more, depending on the payload size) on every
> > transfer, and the data is all zeros:
> > 
> > [   49.001605] IO_PAGE_FAULT device=00:00.0 domain=0x0000
> > address=0x00000000ffbf8000 flags=0x0070]
> > 
> > Where the device ID corresponds to the Host bridge, and the address
> > corresponds to the DMA handle I got from dma_alloc_coherent respectively.
> 
> I am now expert but i am guessing your FPGA set the request field in the
> PCIE TLP write packet to 00:00.0 and this might work when IOMMU is off but
> might not work when IOMMU is on ie when IOMMU is on your device should set
> the request field to the FPGA PCIE id so that the IOMMU knows for which
> device the PCIE write or read packet is and thus against which IOMMU page
> table.
> 
> Cheers,
> Jérôme

Hi Jérôme

Thank you very much for your response.

You hit the nail! That was exactly the root cause of the problem. The request 
field was properly filled in for the Memory Read TLP, but not for the Memory 
Write TLP, where it was all-zeroes.

If I may ask another question: Is it possible to remap a buffer for DMA which 
was allocated by other means? For the second phase, we are going to use the 
RTAI extension(*) which provides its own memory allocation routines (e.g. 
rt_shm_alloc()). There, you may pass the flag USE_GFP_DMA to indicate that 
this buffer should be suitable for DMA. I've tried to remap this memory area 
using virt_to_phys() and use the resulting address for the DMA transfer from 
the FPGA, getting other IO page faults. E.g.:

[   70.100140] IO_PAGE_FAULT device=01:00.0 domain=0x0001 
address=0x0000000000080000 flags=0x0020]

It's remarkable that the logical addresses returned from dma_alloc_coherent 
(e.g. ffbd8000) look quite different from those returned by rt_shm_alloc
+virt_to_phys (e.g. 00080000).

Unfortunately, it does not seem possible to do that the other way round, i.e. 
forcing RTAI to use the buffer from dma_alloc_coherent.

(*) I'm aware that questions regarding the RTAI extension do not really belong 
to this mailing list, but I've read similar questions regarding DMA on the 
RTAI ML which never got answered...

Thanks again for your hint. It saved us many more hours of debugging! :-)

Regards,

Patrick



