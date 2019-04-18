Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC2DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB555208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbfDRPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:36:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:36:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFD015AB;
        Thu, 18 Apr 2019 08:36:06 -0700 (PDT)
Received: from [10.1.32.54] (unknown [10.1.32.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09D3E3F5AF;
        Thu, 18 Apr 2019 08:36:03 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190415143711.13c29308@x1.home> <20190415161015.564cb071@jacob-builder>
Message-ID: <70c6b197-029e-94cd-2745-d4a193cbbcd0@arm.com>
Date:   Thu, 18 Apr 2019 16:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415161015.564cb071@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 00:10, Jacob Pan wrote:[...]
>> > +                   /*
>> > +                    * Register a custom ASID allocator if we
>> > are running
>> > +                    * in a guest, the purpose is to have a
>> > system wide PASID
>> > +                    * namespace among all PASID users.
>> > +                    * Note that only one vIOMMU in each guest
>> > is supported.  
>> 
>> Why one vIOMMU per guest?  This would prevent guests with multiple PCI
>> domains aiui.
>> 
> This is mainly for simplicity reasons. These are all virtual BDFs
> anyway. As long as guest BDF can be mapped to a host BDF, it should be
> sufficient, am I missing anything?
> 
> From PASID allocation perspective, it is not tied to any PCI device
> until bind call. We only need to track PASID ownership per guest.
> 
> virtio-IOMMU spec does support multiple PCI domains but I am not sure
> if that applies to all assigned devices, whether all assigned devices
> are under the same domain. Perhaps Jean can help to clarify how PASID
> allocation API looks like on virtio IOMMU.

[Ugh, this is much longer than I hoped. In short I don't think multiple
vIOMMUs is a problem, because the host uses the same allocator for all of
them.]

Yes there can be a single virtio-iommu instance for multiple PCI
domains, or multiple instances each managing assigned devices. It's up to
the hypervisor to decide on the topology.

For Linux and QEMU I was assuming that choosing the vIOMMU used for PASID
allocation isn't a big deal, since in the end they all use the same
allocator in the host. It gets complicated when some vIOMMUs can be
removed at runtime (unload the virtio-iommu module that was providing the
PASID allocator, and then you can't allocate PASIDs for the VT-d instance
anymore), so maybe limiting to one type of vIOMMU (don't mix VT-d and
virtio-iommu in the same VM) is more reasonable.

It's a bit more delicate from the virtio-iommu perspective. The
interface is portable and I can't tie it down to the choices we're making
for Linux and KVM. Having a system-wide PASID space is what we picked for
Linux but the PCIe architecture allows for each device to have
their own PASID space, and I suppose some hypervisors and guests might
prefer implementing it that way.

My plan for the moment is to implement global PASID allocation using one
feature bit and two new requests, but leave space for a per-device PASID
allocation, introduced with another feature bit if necessary. If it ever
gets added, I expect the per-device allocation to be done during the bind
request rather than with a separate PASID_ALLOC request.

So currently I have a new feature bit and two commands:

#define VIRTIO_IOMMU_F_PASID_ALLOC
#define VIRTIO_IOMMU_T_ALLOC_PASID
#define VIRTIO_IOMMU_T_FREE_PASID

struct virtio_iommu_req_alloc_pasid {
        struct virtio_iommu_req_head head;
        u32 reserved;

        /* Device-writeable */
        le32 pasid;
        struct virtio_iommu_req_tail tail;
};

struct virtio_iommu_req_free_pasid {
        struct virtio_iommu_req_head head;
        u32 reserved;
        le32 pasid;

        /* Device-writeable */
        struct virtio_iommu_req_tail tail;
};

If the feature bit is offered it must be used, and the guest can only use
PASIDs allocated via VIRTIO_IOMMU_T_ALLOC_PASID in its bind requests.

The PASID space is global at the host scope. If multiple virtio-iommu
devices in the VM offer the feature bit, then using either of their
command queue to issue a VIRTIO_IOMMU_F_ALLOC_PASID and
VIRTIO_IOMMU_F_FREE_PASID is equivalent. Another possibility is to require
that only one of the virtio-iommu instances per VM offers the feature bit.
I do prefer this option, but there is the vIOMMU removal problem mentioned
above - which, with the first option, could be solved by keeping a list of
PASID allocator functions rather than a single one.

I'm considering adding max_pasid field to virtio_iommu_req_alloc_pasid. If
VIRTIO_IOMMU_T_ALLOC_PASID returns a random 20-bit value then a lot of
space might be needed for storing PASID contexts (is that a real concern
though? For internal data it can use a binary tree, and the guest is not
in charge of hardware PASID tables here). If the guest is short on memory
then it could benefit from a smaller number of PASID bits. That could
either be globally configurable in the virtio-iommu config space, or using
a max_pasid field in the VIRTIO_IOMMU_T_ALLOC_PASID request. The latter
allows to support devices with less than 20 PASID bits, though we're
hoping that no one will implement that.

Thanks,
Jean
