Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44162C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCA420684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfDOQES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:04:18 -0400
Received: from v5prod-smtp1bis.alinto.net ([83.145.109.218]:42510 "EHLO
        smtpoutv5.alinto.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727213AbfDOQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:04:17 -0400
X-Virus-Scanned: amavisd-new at localdomain
Received: from smtpoutv5.alinto.net ([127.0.0.1])
        by localhost (v5prod-smtp1.alinto.net [127.0.0.1]) (amavisd-new, port 10050)
        with LMTP id IrGZ-KNelxOW; Mon, 15 Apr 2019 18:04:12 +0200 (CEST)
Received: from jona.localnet (unknown [80.254.183.189])
        (Authenticated sender: brunner@stettbacher.ch)
        by smtpoutv5.alinto.net (Postfix) with ESMTPA id 44jYGN1Jklz85c;
        Mon, 15 Apr 2019 18:04:12 +0200 (CEST)
From:   Patrick Brunner <brunner@stettbacher.ch>
To:     linux-kernel@vger.kernel.org
Subject: IOMMU Page faults when running DMA transfers from PCIe device
Date:   Mon, 15 Apr 2019 18:04:11 +0200
Message-ID: <2987837.CvKyUSae8N@jona>
Organization: Stettbacher Signal Processing
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm encountering very nasty problems regarding DMA transfers from an external 
PCIe device to the main memory while the IOMMU is enabled, and I'm running out 
of ideas. I'm not even sure, whether it's a kernel issue or not. But I would 
highly appreciate any hints from experienced developers how to proceed to 
solve that issue.

The problem: An FPGA (see details below) should write a small amount of data 
(~128 bytes) over a PCIe 2.0 x1 link to an address in the CPU's memory space. 
The destination address (64 bits) for the Mem Write TLP is written to a BAR-
mapped register before-hand.

On the system side, the driver consists of the usual setup code:
- request PCI regions
- pci_set_master
- I/O remapping of BARs
- setting DMA mask (dma_set_mask_and_coherent), tried both 32/64 bits
- allocating DMA buffers with dma_alloc_coherent (4096 bytes, but also tried 
smaller numbers)
- allocating IRQ lines (MSI) with pci_alloc_irq_vectors and pci_irq_vector
- writing the DMA buffers' logical address (as returned in dma_handle_t from 
dma_alloc_coherent) to a BAR-mapped register

There is also an IRQ handler dumping the first 2 DWs from the DMA buffer when 
triggered.

The FPGA part will initiate following transfers at an interval of 2.5ms:
- Memory write to DMA address
- Send MSI (to signal that transfer is done)
- Memory read from DMA address+offset

And now, the clue: everything works fine with the IOMMU disabled (iommu=off), 
i.e. the 2 DWs dumped in the ISR handler contain valid data. But if the IOMMU 
is enabled (iommu=soft or force), I receive an IO page fault (sometimes even 
more, depending on the payload size) on every transfer, and the data is all 
zeros:

[   49.001605] IO_PAGE_FAULT device=00:00.0 domain=0x0000 
address=0x00000000ffbf8000 flags=0x0070]

Where the device ID corresponds to the Host bridge, and the address 
corresponds to the DMA handle I got from dma_alloc_coherent respectively.

The big question is: what do I need to do to convince the IOMMU that my DMA 
transfer is legal? To my understanding, the IOMMU should be completely 
transparent as regarded from my device driver. What am I missing?

Some notes:
- disabling the IOMMU is not an option, as otherwise only 1 of the 2 MSIs on 
the FPGA is recognised by pci_alloc_irq_vectors. This is another problem I 
don't understand. Well, if I would get both IRQs working, I could disable the 
IOMMU for good...
- The second MSI is used for some UARTs in the FPGA, not related to the DMA-
part.
- The kernel device driver code is based on example code by Lattice for a demo 
based on the ECP3.
- The same system includes a CAN-adapter on a Mini-PCIe-Card where the driver 
code runs basically the same initialisation sequence (see above), including 
setup of the DMA buffer address via BAR-mapped register. This adapter is based 
on an ECP3 FPGA too. I don't see any IO page faults for this adapter though, 
when the IOMMU is enabled.
- When performing a Mem Read from the FPGA, no IO page faults are issued.
- The same approach was used in 3 other designs (various combos of CPUs, RAM 
and x86, some with ECP3, others with ECP5) without any problems, but none so 
far had an IOMMU involved.

System/FPGA details:
- CPU: AMD Embedded R-Series RX-416GD Radeon R6 (family: 0x15, model: 0x60, 
stepping: 0x1)
- FPGA: Lattice ECP5-45 with Lattice PCIe x1 Endpoint IP
- Kernel: 4.9.80 (same results with 4.20.17)

Note: Need to use that older kernel version as the final design must be 
patched with the RTAI extension.

I'm quite desperate at this point, after spending days of trying out various 
stuff, reading driver code for several similar devices, crawling through 
hundreds of google search results. All to no avail... So, sorry for the noise, 
but I'd be much obliged for any help/directions.

I'm happily providing more details such as the full driver code if someone is 
willing to take a deeper look.

Thanks and best regards,

Patrick




