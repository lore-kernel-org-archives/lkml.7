Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FE22190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCVWJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:09:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfCVWJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBDFF356E8;
        Fri, 22 Mar 2019 22:09:51 +0000 (UTC)
Received: from x1.home (ovpn-116-218.phx2.redhat.com [10.3.116.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 433DD5D9CC;
        Fri, 22 Mar 2019 22:09:47 +0000 (UTC)
Date:   Fri, 22 Mar 2019 16:09:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org, vincent.stehle@arm.com
Subject: Re: [PATCH v6 09/22] vfio: VFIO_IOMMU_BIND/UNBIND_MSI
Message-ID: <20190322160947.3f8dacdb@x1.home>
In-Reply-To: <16931d58-9c88-8cfb-a392-408ea7afdf16@redhat.com>
References: <20190317172232.1068-1-eric.auger@redhat.com>
        <20190317172232.1068-10-eric.auger@redhat.com>
        <20190321170159.38358f38@x1.home>
        <16931d58-9c88-8cfb-a392-408ea7afdf16@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 22 Mar 2019 22:09:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 10:30:02 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> On 3/22/19 12:01 AM, Alex Williamson wrote:
> > On Sun, 17 Mar 2019 18:22:19 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> This patch adds the VFIO_IOMMU_BIND/UNBIND_MSI ioctl which aim
> >> to pass/withdraw the guest MSI binding to/from the host.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >> v3 -> v4:
> >> - add UNBIND
> >> - unwind on BIND error
> >>
> >> v2 -> v3:
> >> - adapt to new proto of bind_guest_msi
> >> - directly use vfio_iommu_for_each_dev
> >>
> >> v1 -> v2:
> >> - s/vfio_iommu_type1_guest_msi_binding/vfio_iommu_type1_bind_guest_msi
> >> ---
> >>  drivers/vfio/vfio_iommu_type1.c | 58 +++++++++++++++++++++++++++++++++
> >>  include/uapi/linux/vfio.h       | 29 +++++++++++++++++
> >>  2 files changed, 87 insertions(+)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 12a40b9db6aa..66513679081b 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -1710,6 +1710,25 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
> >>  	return iommu_cache_invalidate(d, dev, &ustruct->info);
> >>  }
> >>  
> >> +static int vfio_bind_msi_fn(struct device *dev, void *data)
> >> +{
> >> +	struct vfio_iommu_type1_bind_msi *ustruct =
> >> +		(struct vfio_iommu_type1_bind_msi *)data;
> >> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
> >> +
> >> +	return iommu_bind_guest_msi(d, dev, ustruct->iova,
> >> +				    ustruct->gpa, ustruct->size);
> >> +}
> >> +
> >> +static int vfio_unbind_msi_fn(struct device *dev, void *data)
> >> +{
> >> +	dma_addr_t *iova = (dma_addr_t *)data;
> >> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);  
> > 
> > Same as previous, we can encapsulate domain in our own struct to avoid
> > a lookup.
> >   
> >> +
> >> +	iommu_unbind_guest_msi(d, dev, *iova);  
> > 
> > Is it strange that iommu-core is exposing these interfaces at a device
> > level if every one of them requires us to walk all the devices?  Thanks,  
> 
> Hum this per device API was devised in response of Robin's comments on
> 
> [RFC v2 12/20] dma-iommu: Implement NESTED_MSI cookie.
> 
> "
> But that then seems to reveal a somewhat bigger problem - if the callers
> are simply registering IPAs, and relying on the ITS driver to grab an
> entry and fill in a PA later, then how does either one know *which* PA
> is supposed to belong to a given IPA in the case where you have multiple
> devices with different ITS targets assigned to the same guest? (and if
> it's possible to assume a guest will use per-device stage 1 mappings and
> present it with a single vITS backed by multiple pITSes, I think things
> start breaking even harder.)
> "
> 
> However looking back into the problem I wonder if there was an issue
> with the iommu_domain based API.
> 
> If my understanding is correct, when assigned devices are protected by a
> vIOMMU then they necessarily end up in separate host iommu domains even
> if they belong to the same iommu_domain on the guest. And there can only
> be a single device in this iommu_domain.

Don't forget that a container represents the IOMMU context in a vfio
environment, groups are associated with containers and a group may
contain one or more devices.  When a vIOMMU comes into play, we still
only have an IOMMU context per container.  If we have multiple devices
in a group, we run into problems with vIOMMU.  We can resolve this by
requiring that the user ignore all but one device in the group,
or making sure that the devices in the group have the same IOMMU
context.  The latter we could do in QEMU if PCIe-to-PCI bridges there
masked the per-device address space as it does on real hardware (ie.
there is no requester ID on conventional PCI, all transactions appear to
the IOMMU with the bridge requester ID).  So I raise this question
because vfio's minimum domain granularity is a group.

> If this is confirmed, there is a non ambiguous association between 1
> physical iommu_domain, 1 device, 1 S1 mapping and 1 physical MSI
> controller.
> 
> I added the device handle handle to disambiguate those associations. The
> gIOVA ->gDB mapping is associated with a device handle. Then when the
> host needs a stage 1 mapping for this device, to build the nested
> mapping towards the physical DB it can easily grab the gIOVA->gDB stage
> 1 mapping registered for this device.
> 
> The correctness looks more obvious to me, at least.

Except all devices within all groups within the same container
necessarily share the same IOMMU context, so from that perspective, it
appears to impose non-trivial redundancy on the caller.  Thanks,

Alex
