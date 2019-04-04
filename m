Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1833DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDDGze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:55:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfDDGze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:55:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39ED030AA7B8;
        Thu,  4 Apr 2019 06:55:33 +0000 (UTC)
Received: from [10.36.117.163] (ovpn-117-163.ams2.redhat.com [10.36.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADFEA1001E6B;
        Thu,  4 Apr 2019 06:55:26 +0000 (UTC)
Subject: Re: [PATCH v6 09/22] vfio: VFIO_IOMMU_BIND/UNBIND_MSI
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org, vincent.stehle@arm.com
References: <20190317172232.1068-1-eric.auger@redhat.com>
 <20190317172232.1068-10-eric.auger@redhat.com>
 <20190321170159.38358f38@x1.home>
 <16931d58-9c88-8cfb-a392-408ea7afdf16@redhat.com>
 <20190322160947.3f8dacdb@x1.home>
 <b47128de-88d0-1971-1fbc-86e43439c7ee@redhat.com>
 <20190403113800.51503693@x1.home>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <4b27b707-4917-2c3e-a13c-3b978e850d09@redhat.com>
Date:   Thu, 4 Apr 2019 08:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190403113800.51503693@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 04 Apr 2019 06:55:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Robin, Alex,

On 4/3/19 7:38 PM, Alex Williamson wrote:
> On Wed, 3 Apr 2019 16:30:15 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Alex,
>>
>> On 3/22/19 11:09 PM, Alex Williamson wrote:
>>> On Fri, 22 Mar 2019 10:30:02 +0100
>>> Auger Eric <eric.auger@redhat.com> wrote:
>>>   
>>>> Hi Alex,
>>>> On 3/22/19 12:01 AM, Alex Williamson wrote:  
>>>>> On Sun, 17 Mar 2019 18:22:19 +0100
>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>     
>>>>>> This patch adds the VFIO_IOMMU_BIND/UNBIND_MSI ioctl which aim
>>>>>> to pass/withdraw the guest MSI binding to/from the host.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>
>>>>>> ---
>>>>>> v3 -> v4:
>>>>>> - add UNBIND
>>>>>> - unwind on BIND error
>>>>>>
>>>>>> v2 -> v3:
>>>>>> - adapt to new proto of bind_guest_msi
>>>>>> - directly use vfio_iommu_for_each_dev
>>>>>>
>>>>>> v1 -> v2:
>>>>>> - s/vfio_iommu_type1_guest_msi_binding/vfio_iommu_type1_bind_guest_msi
>>>>>> ---
>>>>>>  drivers/vfio/vfio_iommu_type1.c | 58 +++++++++++++++++++++++++++++++++
>>>>>>  include/uapi/linux/vfio.h       | 29 +++++++++++++++++
>>>>>>  2 files changed, 87 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>>>> index 12a40b9db6aa..66513679081b 100644
>>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>>> @@ -1710,6 +1710,25 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
>>>>>>  	return iommu_cache_invalidate(d, dev, &ustruct->info);
>>>>>>  }
>>>>>>  
>>>>>> +static int vfio_bind_msi_fn(struct device *dev, void *data)
>>>>>> +{
>>>>>> +	struct vfio_iommu_type1_bind_msi *ustruct =
>>>>>> +		(struct vfio_iommu_type1_bind_msi *)data;
>>>>>> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
>>>>>> +
>>>>>> +	return iommu_bind_guest_msi(d, dev, ustruct->iova,
>>>>>> +				    ustruct->gpa, ustruct->size);
>>>>>> +}
>>>>>> +
>>>>>> +static int vfio_unbind_msi_fn(struct device *dev, void *data)
>>>>>> +{
>>>>>> +	dma_addr_t *iova = (dma_addr_t *)data;
>>>>>> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);    
>>>>>
>>>>> Same as previous, we can encapsulate domain in our own struct to avoid
>>>>> a lookup.
>>>>>     
>>>>>> +
>>>>>> +	iommu_unbind_guest_msi(d, dev, *iova);    
>>>>>
>>>>> Is it strange that iommu-core is exposing these interfaces at a device
>>>>> level if every one of them requires us to walk all the devices?  Thanks,    
>>>>
>>>> Hum this per device API was devised in response of Robin's comments on
>>>>
>>>> [RFC v2 12/20] dma-iommu: Implement NESTED_MSI cookie.
>>>>
>>>> "
>>>> But that then seems to reveal a somewhat bigger problem - if the callers
>>>> are simply registering IPAs, and relying on the ITS driver to grab an
>>>> entry and fill in a PA later, then how does either one know *which* PA
>>>> is supposed to belong to a given IPA in the case where you have multiple
>>>> devices with different ITS targets assigned to the same guest? (and if
>>>> it's possible to assume a guest will use per-device stage 1 mappings and
>>>> present it with a single vITS backed by multiple pITSes, I think things
>>>> start breaking even harder.)
>>>> "
>>>>
>>>> However looking back into the problem I wonder if there was an issue
>>>> with the iommu_domain based API.
>>>>
>>>> If my understanding is correct, when assigned devices are protected by a
>>>> vIOMMU then they necessarily end up in separate host iommu domains even
>>>> if they belong to the same iommu_domain on the guest. And there can only
>>>> be a single device in this iommu_domain.  
>>>
>>> Don't forget that a container represents the IOMMU context in a vfio
>>> environment, groups are associated with containers and a group may
>>> contain one or more devices.  When a vIOMMU comes into play, we still
>>> only have an IOMMU context per container.  If we have multiple devices
>>> in a group, we run into problems with vIOMMU.  We can resolve this by
>>> requiring that the user ignore all but one device in the group,
>>> or making sure that the devices in the group have the same IOMMU
>>> context.  The latter we could do in QEMU if PCIe-to-PCI bridges there
>>> masked the per-device address space as it does on real hardware (ie.
>>> there is no requester ID on conventional PCI, all transactions appear to
>>> the IOMMU with the bridge requester ID).  So I raise this question
>>> because vfio's minimum domain granularity is a group.
>>>   
>>>> If this is confirmed, there is a non ambiguous association between 1
>>>> physical iommu_domain, 1 device, 1 S1 mapping and 1 physical MSI
>>>> controller.
>>>>
>>>> I added the device handle handle to disambiguate those associations. The
>>>> gIOVA ->gDB mapping is associated with a device handle. Then when the
>>>> host needs a stage 1 mapping for this device, to build the nested
>>>> mapping towards the physical DB it can easily grab the gIOVA->gDB stage
>>>> 1 mapping registered for this device.
>>>>
>>>> The correctness looks more obvious to me, at least.  
>>>
>>> Except all devices within all groups within the same container
>>> necessarily share the same IOMMU context, so from that perspective, it
>>> appears to impose non-trivial redundancy on the caller.  Thanks,  
>>
>> Taking into consideration the case where we could have several devices
>> attached to the same host iommu group, each of them possibly using
>> different host MSI doorbells, I think I am in trouble.
>>
>> Let's assume that using the pcie-to-pci bridge trick on guest side they
>> end up in the same container and in the same guest iommu group.
>>
>> At the moment there is a single MSI controller on guest, so the same
>> gIOVA/gDB S1 mapping is going to be created by the guest iommu dommain
>> and both devices are programmed with gIOVA. If dev0 and dev1 are
>> attached to different host MSI controllers, I would need to build the 2
>> nested bindings:
>> dev0: MSI nested binding: gIOVA -> gDB -> hDB0
>> dev1: MSI nested binding: gIOVA -> gDB -> hDB1
>> (on guest there is a single MSI controller at the moment)
>>
>> which is not possible as the devices belong to the same host iommu group
>> and share the same mapping.
>>
>> The solution would be to instantiate 2 MSI controllers on guest side, in
>> which case we would end up with
>> dev0: gIOVA0 -> gDB0 -> hDB0
>> dev1: gIOVA1 -> gDB1 -> hDB1
>>
>> Isn't it somehow what we do with the IOMMU RID topology. We need to take
>> into account the host topology (2 devices belonging to the same group)
>> to force the same on guest by introducing a PCIe-to-PCI bridge. Here we
>> would need to say, those assigned devices are attached to different MSI
>> domains on host, so we need the same on guest.
>>
>> Anyway, the current container based IOCTL would fail to implement that
>> because I would register gIOVA0 -> gDB0 and gIOVA1 -> gDB1 for each
>> device within the container which would definitively fail to build the
>> correct association. So I think I would need anyway a device based IOTCL
>> that would aim to tell: this assigned device uses this S1 MSI binding.
>> All the notification mechanism we have in qemu is based on container, so
>> this would obliged to have device based notification mechanism.
>>
>> So I wonder whether it wouldn't be sensible to restrict this use case
>> and say we support nested mode only if we have a single assigned device
>> within the container?
>>
>> Thoughts?
> 
> We've essentially done that with vIOMMU up to this point already, it's
> not been possible to assign multiple devices from the same group to a
> VM with intel-iommu, amd-iommu, or smmu due to the requirement of
> separate address spaces per device.  It's only when we introduce
> address space aliasing with bridges that we can even consider this
> possibility, and it's a configuration which smmu doesn't properly
> support even on bare metal.  I hope we can consider that to be simply a
> gap in the implementation that will get fixed and not an architectural
> problem.
> 
> As we discussed offline though, I wonder if we're attempting to support
> more than necessary with your scenarios above.  If devices within the
> same group can be verified to share a host MSI controller, do we still
> have an issue mapping them to a single guest MSI controller?  When we
> talked we were headed down a path that if a group is necessarily
> associated to a single IOMMU, perhaps that necessarily means that a
> group is also associated to a single MSI controller.  I've since
> thought of a configuration where a group could span physical IOMMU
> devices, NVLink.  As essentially a secondary bus interface for a
> device, NVLink can cause devices with arbitrary PCI hierarchy
> connections to be non-isolated, and ideally our grouping would
> understand to account for that.  However, if it could be determined
> that a group associates to a single MSI controller, do we still have an
> issue with multiple devices within the group?

Marc, Robin,

Do you think this is a reasonable assumption to consider devices within
the same host iommu group share the same MSI doorbell?
> 
> My issue with the per device interface for what is fundamentally an
> IOVA mapping is that vfio does not support per device mappings.  We
> support mappings at the container level, where the minimum set of
> devices we can attach to a container is a group.  Therefore to create
> an interface that purports to support device level mappings is not
> accurate.  Maybe MSI controllers will restrict our configuration but
> I'd rather not design the interface around the wrong level of mapping
> granularity.  Thanks,

Alex,

In case of nested, the vfio container is used to setup the stage2 only
whereas the stage1 is owned by the guest. Here the mapping we pass to
the host is a stage1 mapping; this information is used to build the
correct S2 mapping. Then the mapping remains the same for the whole
container. If dev1 decides to use gIOVA0 it will reach hDB0. Anyway the
granularity of the mapping cannot change.

So this rather tells this assigned dev uses this given giova for
reaching a guest MSI doorbell.

Thanks

Eric
> 
> Alex
> 
