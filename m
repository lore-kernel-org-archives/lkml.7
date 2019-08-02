Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68556C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B542080C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfHBBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbfHBBaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 401D5F5707;
        Fri,  2 Aug 2019 01:30:15 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBBB5D713;
        Fri,  2 Aug 2019 01:30:14 +0000 (UTC)
Date:   Thu, 1 Aug 2019 19:30:13 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
        tmurphy@arista.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
Message-ID: <20190801193013.19444803@x1.home>
In-Reply-To: <20190719092303.751659a0@x1.home>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
        <20190525054136.27810-13-baolu.lu@linux.intel.com>
        <20190717211226.5ffbf524@x1.home>
        <9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
        <20190719092303.751659a0@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 02 Aug 2019 01:30:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 09:23:03 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 19 Jul 2019 17:04:26 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> > Hi Alex,
> > 
> > On 7/18/19 11:12 AM, Alex Williamson wrote:  
> > > On Sat, 25 May 2019 13:41:33 +0800
> > > Lu Baolu <baolu.lu@linux.intel.com> wrote:
> > >     
> > >> Previously, get_valid_domain_for_dev() is used to retrieve the
> > >> DMA domain which has been attached to the device or allocate one
> > >> if no domain has been attached yet. As we have delegated the DMA
> > >> domain management to upper layer, this function is used purely to
> > >> allocate a private DMA domain if the default domain doesn't work
> > >> for ths device. Cleanup the code for readability.
> > >>
> > >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > >> ---
> > >>   drivers/iommu/intel-iommu.c | 18 ++++++++----------
> > >>   include/linux/intel-iommu.h |  1 -
> > >>   2 files changed, 8 insertions(+), 11 deletions(-)    
> > > 
> > > System fails to boot bisected to this commit:    
> > 
> > Is this the same issue as this https://lkml.org/lkml/2019/7/18/840?  
> 
> Yes, the above link is after bisecting with all the bugs and fixes
> squashed together to avoid landing in local bugs.  Thanks,

Well, it turns out this patch is still broken too.  I was excited that
the system booted again with reverting the commit in the link above and
didn't notice that VT-d failed and de-initialized itself:

DMAR: No ATSR found
DMAR: dmar0: Using Queued invalidation
DMAR: dmar1: Using Queued invalidation
pci 0000:00:00.0: DMAR: Software identity mapping
pci 0000:00:01.0: DMAR: Software identity mapping
pci 0000:00:02.0: DMAR: Software identity mapping
pci 0000:00:16.0: DMAR: Software identity mapping
pci 0000:00:1a.0: DMAR: Software identity mapping
pci 0000:00:1b.0: DMAR: Software identity mapping
pci 0000:00:1c.0: DMAR: Software identity mapping
pci 0000:00:1c.5: DMAR: Software identity mapping
pci 0000:00:1c.6: DMAR: Software identity mapping
pci 0000:00:1c.7: DMAR: Software identity mapping
pci 0000:00:1d.0: DMAR: Software identity mapping
pci 0000:00:1f.0: DMAR: Software identity mapping
pci 0000:00:1f.2: DMAR: Software identity mapping
pci 0000:00:1f.3: DMAR: Software identity mapping
pci 0000:01:00.0: DMAR: Software identity mapping
pci 0000:01:00.1: DMAR: Software identity mapping
pci 0000:03:00.0: DMAR: Software identity mapping
pci 0000:04:00.0: DMAR: Software identity mapping
DMAR: Setting RMRR:
pci 0000:00:02.0: DMAR: Setting identity map [0xbf800000 - 0xcf9fffff]
pci 0000:00:1a.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
pci 0000:00:1d.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
DMAR: Prepare 0-16MiB unity mapping for LPC
pci 0000:00:1f.0: DMAR: Setting identity map [0x0 - 0xffffff]
pci 0000:00:00.0: Adding to iommu group 0
pci 0000:00:00.0: Using iommu direct mapping
pci 0000:00:01.0: Adding to iommu group 1
pci 0000:00:01.0: Using iommu direct mapping
pci 0000:00:02.0: Adding to iommu group 2
pci 0000:00:02.0: Using iommu direct mapping
pci 0000:00:16.0: Adding to iommu group 3
pci 0000:00:16.0: Using iommu direct mapping
pci 0000:00:1a.0: Adding to iommu group 4
pci 0000:00:1a.0: Using iommu direct mapping
pci 0000:00:1b.0: Adding to iommu group 5
pci 0000:00:1b.0: Using iommu direct mapping
pci 0000:00:1c.0: Adding to iommu group 6
pci 0000:00:1c.0: Using iommu direct mapping
pci 0000:00:1c.5: Adding to iommu group 7
pci 0000:00:1c.5: Using iommu direct mapping
pci 0000:00:1c.6: Adding to iommu group 8
pci 0000:00:1c.6: Using iommu direct mapping
pci 0000:00:1c.7: Adding to iommu group 9
pci 0000:00:1c.7: Using iommu direct mapping
pci 0000:00:1d.0: Adding to iommu group 10
pci 0000:00:1d.0: Using iommu direct mapping
pci 0000:00:1f.0: Adding to iommu group 11
pci 0000:00:1f.0: Using iommu direct mapping
pci 0000:00:1f.2: Adding to iommu group 11
pci 0000:00:1f.3: Adding to iommu group 11
pci 0000:01:00.0: Adding to iommu group 1
pci 0000:01:00.1: Adding to iommu group 1
pci 0000:03:00.0: Adding to iommu group 12
pci 0000:03:00.0: Using iommu direct mapping
pci 0000:04:00.0: Adding to iommu group 13
pci 0000:04:00.0: Using iommu direct mapping
pci 0000:05:00.0: Adding to iommu group 9
pci 0000:05:00.0: DMAR: Failed to get a private domain.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pci 0000:00:00.0: Removing from iommu group 0
pci 0000:00:01.0: Removing from iommu group 1
pci 0000:00:02.0: Removing from iommu group 2
pci 0000:00:16.0: Removing from iommu group 3
pci 0000:00:1a.0: Removing from iommu group 4
pci 0000:00:1b.0: Removing from iommu group 5
pci 0000:00:1c.0: Removing from iommu group 6
pci 0000:00:1c.5: Removing from iommu group 7
pci 0000:00:1c.6: Removing from iommu group 8
pci 0000:00:1c.7: Removing from iommu group 9
pci 0000:00:1d.0: Removing from iommu group 10
pci 0000:00:1f.0: Removing from iommu group 11
pci 0000:00:1f.2: Removing from iommu group 11
pci 0000:00:1f.3: Removing from iommu group 11
pci 0000:01:00.0: Removing from iommu group 1
pci 0000:01:00.1: Removing from iommu group 1
pci 0000:03:00.0: Removing from iommu group 12
pci 0000:04:00.0: Removing from iommu group 13
pci 0000:05:00.0: Removing from iommu group 9
DMAR: Intel(R) Virtualization Technology for Directed I/O

-[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v2/Ivy Bridge DRAM Controller
           +-01.0-[01]--+-00.0  NVIDIA Corporation GK208 [GeForce GT 635]
           |            \-00.1  NVIDIA Corporation GK208 HDMI/DP Audio Controller
           +-02.0  Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor Graphics Controller
           +-16.0  Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1
           +-1a.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
           +-1b.0  Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller
           +-1c.0-[02]--
           +-1c.5-[03]----00.0  ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller
           +-1c.6-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-1c.7-[05-06]----00.0-[06]--
           +-1d.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
           +-1f.0  Intel Corporation H67 Express Chipset LPC Controller
           +-1f.2  Intel Corporation 6 Series/C200 Series Chipset Family 6 port Desktop SATA AHCI Controller
           \-1f.3  Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller

05:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge (rev 01) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 5
	Bus: primary=05, secondary=06, subordinate=06, sec-latency=64
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [c0] Subsystem: ASUSTeK Computer Inc. Device 8489


With commit 4ec066c7b1476e0ca66a7acdb575627a5d1a1ee6 reverted on
v5.3-rc2:

DMAR: No ATSR found
DMAR: dmar0: Using Queued invalidation
DMAR: dmar1: Using Queued invalidation
pci 0000:00:00.0: Adding to iommu group 0
pci 0000:00:00.0: Using iommu direct mapping
pci 0000:00:01.0: Adding to iommu group 1
pci 0000:00:01.0: Using iommu direct mapping
pci 0000:00:02.0: Adding to iommu group 2
pci 0000:00:02.0: Using iommu direct mapping
pci 0000:00:16.0: Adding to iommu group 3
pci 0000:00:16.0: Using iommu direct mapping
pci 0000:00:1a.0: Adding to iommu group 4
pci 0000:00:1a.0: Using iommu direct mapping
pci 0000:00:1b.0: Adding to iommu group 5
pci 0000:00:1b.0: Using iommu direct mapping
pci 0000:00:1c.0: Adding to iommu group 6
pci 0000:00:1c.0: Using iommu direct mapping
pci 0000:00:1c.5: Adding to iommu group 7
pci 0000:00:1c.5: Using iommu direct mapping
pci 0000:00:1c.6: Adding to iommu group 8
pci 0000:00:1c.6: Using iommu direct mapping
pci 0000:00:1c.7: Adding to iommu group 9
pci 0000:00:1c.7: Using iommu direct mapping
pci 0000:00:1d.0: Adding to iommu group 10
pci 0000:00:1d.0: Using iommu direct mapping
pci 0000:00:1f.0: Adding to iommu group 11
pci 0000:00:1f.0: Using iommu direct mapping
pci 0000:00:1f.2: Adding to iommu group 11
pci 0000:00:1f.3: Adding to iommu group 11
pci 0000:01:00.0: Adding to iommu group 1
pci 0000:01:00.1: Adding to iommu group 1
pci 0000:03:00.0: Adding to iommu group 12
pci 0000:03:00.0: Using iommu direct mapping
pci 0000:04:00.0: Adding to iommu group 13
pci 0000:04:00.0: Using iommu direct mapping
pci 0000:05:00.0: Adding to iommu group 9
pci 0000:05:00.0: DMAR: Device uses a private dma domain.
DMAR: Intel(R) Virtualization Technology for Directed I/O

I'm guessing this series was maybe never tested on and doesn't account
for PCIe-to-PCI bridges.  Please fix.  Thanks,

Alex
