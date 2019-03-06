Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F52C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E96321019
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C87bB7RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfCFSJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:09:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43897 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfCFSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:09:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so11141807ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=biLQh5l734qE48460EHEU4FVnZpUsBbZHO4mHn49GII=;
        b=C87bB7RU1ozp+GOwCrLwZgbqacXTuK1xpdA9GoITwpZOiVcK65Qg3Tshuzgeku9e7U
         IPTRr7zEvIVKpCFV3Yw4eY7RENCVRhYW83nqEzGvRn/CnEXbGt5/KCDUdyBAMKco/oHn
         M3V/AyKW3+WcuWoAQTjteZIuM24OxRP+hHA57qlykFq/IhMiLzIOOinTXnTsAePeTfKn
         1TZvRTXB8r7FROJAuPTl8QYgPd7vxD7NeUXYiojioGta+U28nrtzW25T1Zn+BXKOV49q
         GiA3DtdH0Mx7GTICj7lk4elNkCYqDvtHdZ+rPHcI32pYFvnA0HRmO1oNBdlMyyNLOfkQ
         BYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=biLQh5l734qE48460EHEU4FVnZpUsBbZHO4mHn49GII=;
        b=EKDS3CEAK/Xa2ToHIRjTOZ7647APt8hAgLq8zxAlmAmpEIuvkfWY8j596vFM1bUCtx
         bKxrCpvhHAJGuuFgPq3BHgKqC+04H5q30WFWZh84z/SB0xKJELkTkwXkrQJpzloEaWWU
         L5oj3x6jksQtTidBYiI/JzobXAbRpNQj7XlYYwiGU/eIMtjObQKi5R0D6rD59RszLPpM
         Rzy0TwmHAWbRa2l902OoJ3QfG6yykajM9pmbZE3KhF1O1t4U3J/N1KjuKgmMFuWuctdw
         aMLV4dHmLGmA4tWxmh7PcAkNR/ab6YeGPRt74HoqcUfiwM4UOctCbhQWkKNJc45+MNdG
         jwfw==
X-Gm-Message-State: APjAAAWuZOmS/WrKDyZR5SXtUSCygRk6dK+RIahbOBRhmXdOzrLICF/L
        4NktqdlnhIAitnLbwzyIXLVqtwo6AMk=
X-Google-Smtp-Source: APXvYqxf9dhLM5y0w/VJrZY1WFe1vnFpw2JRKurgNKqQYv4/scegPQxpusVSYHTzFy6038W+q7e7cw==
X-Received: by 2002:aa7:dc46:: with SMTP id g6mr24907957edu.162.1551895776403;
        Wed, 06 Mar 2019 10:09:36 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y45sm619598edd.33.2019.03.06.10.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:09:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
Date:   Wed, 6 Mar 2019 18:08:34 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

> On 6 Mar 2019, at 07:00, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi,
>=20
> On 3/5/19 7:46 PM, James Sewart wrote:
>> Hey Lu,
>>> On 5 Mar 2019, at 06:59, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> It's hard for me to understand why do we remove the rmrr related
>>> code in this patch.
>> The RMRR code removed here requires the lazy allocation of domains to
>> exist, as it is run before iommu.c would assign IOMMU groups and =
attach a
>> domain. Before patch 3, removing this code would mean the RMRR =
regions are
>> never mapped for a domain: iommu.c will allocate a default domain for =
the
>> group that a device is about to be put in, it will attach the domain =
to
>> the device, then for each region returned by get_resv_regions it will
>> create an identity map, this is where the RMRRs are setup for the =
default
>> domain. >
>>>=20
>>> And, now we have two places to hold a domain for a device: group and
>>> dev->info. We can consider to optimize the use of per device iommu
>>> arch data. This should be later work anyway.
>>>=20
>>> More comments inline.
>>>=20
>>> On 3/4/19 11:47 PM, James Sewart wrote:
>>>> The generic IOMMU code will allocate and attach a dma ops domain to =
each
>>>> device that comes online, replacing any lazy allocated domain. =
Removes
>>>> RMRR application at iommu init time as we won't have a domain =
attached
>>>> to any device. iommu.c will do this after attaching a device using
>>>> create_direct_mappings.
>>>> Signed-off-by: James Sewart <jamessewart@arista.com>
>>>> ---
>>>>  drivers/iommu/intel-iommu.c | 202 =
++----------------------------------
>>>>  1 file changed, 8 insertions(+), 194 deletions(-)
>>>> diff --git a/drivers/iommu/intel-iommu.c =
b/drivers/iommu/intel-iommu.c
>>>> index 71cd6bbfec05..282257e2628d 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -2595,118 +2595,6 @@ static struct dmar_domain =
*dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>>>  	return domain;
>>>>  }
>>>>  -static int get_last_alias(struct pci_dev *pdev, u16 alias, void =
*opaque)
>>>> -{
>>>> -	*(u16 *)opaque =3D alias;
>>>> -	return 0;
>>>> -}
>>>> -
>>>> -static struct dmar_domain *find_or_alloc_domain(struct device =
*dev, int gaw)
>>>> -{
>>>> -	struct device_domain_info *info =3D NULL;
>>>> -	struct dmar_domain *domain =3D NULL;
>>>> -	struct intel_iommu *iommu;
>>>> -	u16 dma_alias;
>>>> -	unsigned long flags;
>>>> -	u8 bus, devfn;
>>>> -
>>>> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
>>>> -	if (!iommu)
>>>> -		return NULL;
>>>> -
>>>> -	if (dev_is_pci(dev)) {
>>>> -		struct pci_dev *pdev =3D to_pci_dev(dev);
>>>> -
>>>> -		pci_for_each_dma_alias(pdev, get_last_alias, =
&dma_alias);
>>>> -
>>>> -		spin_lock_irqsave(&device_domain_lock, flags);
>>>> -		info =3D =
dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),
>>>> -						      =
PCI_BUS_NUM(dma_alias),
>>>> -						      dma_alias & 0xff);
>>>> -		if (info) {
>>>> -			iommu =3D info->iommu;
>>>> -			domain =3D info->domain;
>>>> -		}
>>>> -		spin_unlock_irqrestore(&device_domain_lock, flags);
>>>> -
>>>> -		/* DMA alias already has a domain, use it */
>>>> -		if (info)
>>>> -			goto out;
>>>> -	}
>>>> -
>>>> -	/* Allocate and initialize new domain for the device */
>>>> -	domain =3D alloc_domain(0);
>>>> -	if (!domain)
>>>> -		return NULL;
>>>> -	if (domain_init(domain, iommu, gaw)) {
>>>> -		domain_exit(domain);
>>>> -		return NULL;
>>>> -	}
>>>> -
>>>> -out:
>>>> -
>>>> -	return domain;
>>>> -}
>>>> -
>>>> -static struct dmar_domain *set_domain_for_dev(struct device *dev,
>>>> -					      struct dmar_domain =
*domain)
>>>> -{
>>>> -	struct intel_iommu *iommu;
>>>> -	struct dmar_domain *tmp;
>>>> -	u16 req_id, dma_alias;
>>>> -	u8 bus, devfn;
>>>> -
>>>> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
>>>> -	if (!iommu)
>>>> -		return NULL;
>>>> -
>>>> -	req_id =3D ((u16)bus << 8) | devfn;
>>>> -
>>>> -	if (dev_is_pci(dev)) {
>>>> -		struct pci_dev *pdev =3D to_pci_dev(dev);
>>>> -
>>>> -		pci_for_each_dma_alias(pdev, get_last_alias, =
&dma_alias);
>>>> -
>>>> -		/* register PCI DMA alias device */
>>>> -		if (req_id !=3D dma_alias) {
>>>> -			tmp =3D dmar_insert_one_dev_info(iommu, =
PCI_BUS_NUM(dma_alias),
>>>> -					dma_alias & 0xff, NULL, domain);
>>>> -
>>>> -			if (!tmp || tmp !=3D domain)
>>>> -				return tmp;
>>>> -		}
>>>> -	}
>>>> -
>>>> -	tmp =3D dmar_insert_one_dev_info(iommu, bus, devfn, dev, =
domain);
>>>> -	if (!tmp || tmp !=3D domain)
>>>> -		return tmp;
>>>> -
>>>> -	return domain;
>>>> -}
>>>> -
>>>> -static struct dmar_domain *get_domain_for_dev(struct device *dev, =
int gaw)
>>>> -{
>>>> -	struct dmar_domain *domain, *tmp;
>>>> -
>>>> -	domain =3D find_domain(dev);
>>>> -	if (domain)
>>>> -		goto out;
>>>> -
>>>> -	domain =3D find_or_alloc_domain(dev, gaw);
>>>> -	if (!domain)
>>>> -		goto out;
>>>> -
>>>> -	tmp =3D set_domain_for_dev(dev, domain);
>>>> -	if (!tmp || domain !=3D tmp) {
>>>> -		domain_exit(domain);
>>>> -		domain =3D tmp;
>>>> -	}
>>>> -
>>>> -out:
>>>> -
>>>> -	return domain;
>>>> -}
>>>> -
>>>>  static int iommu_domain_identity_map(struct dmar_domain *domain,
>>>>  				     unsigned long long start,
>>>>  				     unsigned long long end)
>>>> @@ -2779,7 +2667,7 @@ static int iommu_prepare_identity_map(struct =
device *dev,
>>>>  	struct dmar_domain *domain;
>>>>  	int ret;
>>>>  -	domain =3D get_domain_for_dev(dev, =
DEFAULT_DOMAIN_ADDRESS_WIDTH);
>>>> +	domain =3D find_domain(dev);
>>>>  	if (!domain)
>>>>  		return -ENOMEM;
>>>>  @@ -3301,11 +3189,9 @@ static int copy_translation_tables(struct =
intel_iommu *iommu)
>>>>  static int __init init_dmars(void)
>>>>  {
>>>>  	struct dmar_drhd_unit *drhd;
>>>> -	struct dmar_rmrr_unit *rmrr;
>>>>  	bool copied_tables =3D false;
>>>> -	struct device *dev;
>>>>  	struct intel_iommu *iommu;
>>>> -	int i, ret;
>>>> +	int ret;
>>>>    	/*
>>>>  	 * for each drhd
>>>> @@ -3466,32 +3352,6 @@ static int __init init_dmars(void)
>>>>  			goto free_iommu;
>>>>  		}
>>>>  	}
>>>> -	/*
>>>> -	 * For each rmrr
>>>> -	 *   for each dev attached to rmrr
>>>> -	 *   do
>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>> -	 *     allocate free domain
>>>> -	 *     allocate page table entries for rmrr
>>>> -	 *     if context not allocated for bus
>>>> -	 *           allocate and init context
>>>> -	 *           set present in root table for this bus
>>>> -	 *     init context with domain, translation etc
>>>> -	 *    endfor
>>>> -	 * endfor
>>>> -	 */
>>>> -	pr_info("Setting RMRR:\n");
>>>> -	for_each_rmrr_units(rmrr) {
>>>> -		/* some BIOS lists non-exist devices in DMAR table. */
>>>> -		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
>>>> -					  i, dev) {
>>>> -			ret =3D iommu_prepare_rmrr_dev(rmrr, dev);
>>>> -			if (ret)
>>>> -				pr_err("Mapping reserved region =
failed\n");
>>>> -		}
>>>> -	}
>>>> -
>>>> -	iommu_prepare_isa();
>>>=20
>>> Why do you want to remove this segment of code?
>> This will only work if the lazy allocation of domains exists, these
>> mappings will disappear once a default domain is attached to a device =
and
>> then remade by iommu_group_create_direct_mappings. This code is =
redundant
>> and removing it allows us to remove all the lazy allocation logic.
>=20
> No exactly.
>=20
> We need to setup the rmrr mapping before enabling dma remapping,
> otherwise, there will be a window after dma remapping enabling and
> rmrr getting mapped, during which people might see dma faults.

Do you think this patch instead should be a refactoring to simplify this =
initial domain setup before the default domain takes over? It seems like =
duplicated effort to have both lazy allocated domains and externally =
managed domains. We could allocate a domain here for any devices with =
RMRR and call get_resv_regions to avoid duplicating RMRR loop.

>=20
>> iommu_prepare_isa does need moving to get_resv_regions for its =
mappings to
>> be applied, this will need some refactoring.
>=20
> Yes, agree.
>=20
>>>=20
>>>>    domains_done:
>>>>  @@ -3580,53 +3440,6 @@ static unsigned long =
intel_alloc_iova(struct device *dev,
>>>>  	return iova_pfn;
>>>>  }
>>>>  -struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
>>>> -{
>>>> -	struct dmar_domain *domain, *tmp;
>>>> -	struct dmar_rmrr_unit *rmrr;
>>>> -	struct device *i_dev;
>>>> -	int i, ret;
>>>> -
>>>> -	domain =3D find_domain(dev);
>>>> -	if (domain)
>>>> -		goto out;
>>>> -
>>>> -	domain =3D find_or_alloc_domain(dev, =
DEFAULT_DOMAIN_ADDRESS_WIDTH);
>>>> -	if (!domain)
>>>> -		goto out;
>>>> -
>>>> -	/* We have a new domain - setup possible RMRRs for the device */
>>>> -	rcu_read_lock();
>>>> -	for_each_rmrr_units(rmrr) {
>>>> -		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
>>>> -					  i, i_dev) {
>>>> -			if (i_dev !=3D dev)
>>>> -				continue;
>>>> -
>>>> -			ret =3D domain_prepare_identity_map(dev, domain,
>>>> -							  =
rmrr->base_address,
>>>> -							  =
rmrr->end_address);
>>>> -			if (ret)
>>>> -				dev_err(dev, "Mapping reserved region =
failed\n");
>>>=20
>>> We can't simply remove this segment of code, right? At least it =
should
>>> be moved to the domain allocation interface.
>> iommu_group_create_direct_mappings will take care of these mappings, =
this
>> code is not used once an externally managed domain(group domain) is
>> attached to the device.
>=20
> Yes, this seems to be duplicated even with lazy domain allocation.
>=20
> Best regards,
> Lu Baolu
>=20
>>>=20
>>>> -		}
>>>> -	}
>>>> -	rcu_read_unlock();
>>>> -
>>>> -	tmp =3D set_domain_for_dev(dev, domain);
>>>> -	if (!tmp || domain !=3D tmp) {
>>>> -		domain_exit(domain);
>>>> -		domain =3D tmp;
>>>> -	}
>>>> -
>>>> -out:
>>>> -
>>>> -	if (!domain)
>>>> -		pr_err("Allocating domain for %s failed\n", =
dev_name(dev));
>>>> -
>>>> -
>>>> -	return domain;
>>>> -}
>>>> -
>>>>  /* Check if the dev needs to go through non-identity map and unmap =
process.*/
>>>>  static int iommu_no_mapping(struct device *dev)
>>>>  {
>>>> @@ -3689,7 +3502,7 @@ static dma_addr_t __intel_map_page(struct =
device *dev, struct page *page,
>>>>  	if (iommu_no_mapping(dev))
>>>>  		return paddr;
>>>>  -	domain =3D get_valid_domain_for_dev(dev);
>>>> +	domain =3D find_domain(dev);
>>>>  	if (!domain)
>>>>  		return DMA_MAPPING_ERROR;
>>>>  @@ -3753,7 +3566,8 @@ static void intel_unmap(struct device *dev, =
dma_addr_t dev_addr, size_t size)
>>>>  		return;
>>>>    	domain =3D find_domain(dev);
>>>> -	BUG_ON(!domain);
>>>> +	if (!domain)
>>>> +		return;
>>>> =20
>>>=20
>>> This is not related to this patch. Let's do it in a separated patch.
>>>=20
>>>>  	iommu =3D domain_get_iommu(domain);
>>>>  @@ -3899,7 +3713,7 @@ static int intel_map_sg(struct device *dev, =
struct scatterlist *sglist, int nele
>>>>  	if (iommu_no_mapping(dev))
>>>>  		return intel_nontranslate_map_sg(dev, sglist, nelems, =
dir);
>>>>  -	domain =3D get_valid_domain_for_dev(dev);
>>>> +	domain =3D find_domain(dev);
>>>>  	if (!domain)
>>>>  		return 0;
>>>>  @@ -5377,9 +5191,9 @@ int intel_iommu_enable_pasid(struct =
intel_iommu *iommu, struct intel_svm_dev *sd
>>>>  	u64 ctx_lo;
>>>>  	int ret;
>>>>  -	domain =3D get_valid_domain_for_dev(sdev->dev);
>>>> +	domain =3D find_domain(sdev->dev);
>>>>  	if (!domain)
>>>> -		return -EINVAL;
>>>> +		return -ENOMEM;
>>>=20
>>> This is not related to this patch. Let's do it in a separated patch.
>>>=20
>>>>    	spin_lock_irqsave(&device_domain_lock, flags);
>>>>  	spin_lock(&iommu->lock);
>>>=20
>>> Best regards,
>>> Lu Baolu

Cheers,
James.

