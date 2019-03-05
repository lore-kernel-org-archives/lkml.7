Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F2420842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="leU1gnFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCELfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:35:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41100 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfCELfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:35:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so6943035eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tV6dXyfAzeVPDaytwddnrjaCtPWmSBXhfZi07V2sghQ=;
        b=leU1gnFVbuJwcNTaOPg5khsyBQIfc1Rx5nJ8iOpa6DxvK2eAJmQWQXSAxx0USGNcec
         unOgApHZRSi2fLJcRFvlo4GwMYKUMCvkh1ul6g20+AEss/s9m2PJCy2v+xnXS0hGdmPp
         oaCi+wvWujjQN81l4wKB2Rl3xSvJtB1tR9eUwP5AgBA4JYBdTpDHUMpk3TT0XPcBocYS
         tbLfB2u+pTTH/lw9sjjv3egTFSEeNT6CT7+Qlb7CA3oSuwcjOs8nFNQDVZk38kx4K8Eg
         4lO3wlBdvqn3CkrOTKzPAqHt8fGkU0FLnm2Ig98bisW+EHynN1fY6jJOO2lLDQ7rctTL
         WcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tV6dXyfAzeVPDaytwddnrjaCtPWmSBXhfZi07V2sghQ=;
        b=sjZLPBrdFalTknCehGZkcgnvyrcw65Gn0BG9hikh6ipYMfRLK/ULk9t07SbbGbEwDd
         3r5gYytCnbn5IVPLVbpIyT6FMUbSSUIzNS8BicdhfJLr6SYKBnAkL8q6tcam9Md8kQD1
         uBSwMjJKusoqV6MLeuOqAbMRbLhpHedi7SbzVGk0K7KUsETRtP+mdTLcFc/9TG9j7vxi
         agN6rmj/bSqezUc65vjZ63C8x+g+gnePIjU5/auIaJvq4qrZ/9T3k1DeH7GlVKmrJ84T
         WiZ4Bi2KU+N7h+SnZcyyUkfvmvOxdeg+jPTUBm8tE39oeVXgUS23B3S/NfPsr5iPLZ6q
         zHkg==
X-Gm-Message-State: APjAAAWdZkcaR/azJnH8kpcOtuSITtenPKZhwPQ1mXn5pYZzK5HfgCS3
        tnpQoI1fPbL+DQdLo9VDm9mJjQ==
X-Google-Smtp-Source: APXvYqyJ+lQatOCbpEjjZtevaGjj4yHho0RGCvG483DHg3X8jl9TEzVHcSK/xh5DNfHCMO21e/2buw==
X-Received: by 2002:a50:a545:: with SMTP id z5mr19444189edb.208.1551785742016;
        Tue, 05 Mar 2019 03:35:42 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x7sm1739584eju.12.2019.03.05.03.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 03:35:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <78df6013-bdcb-abfa-d86a-6460b17dc924@linux.intel.com>
Date:   Tue, 5 Mar 2019 11:34:41 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C9B5243-3DF8-47DB-BA5B-F201E9808874@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <78df6013-bdcb-abfa-d86a-6460b17dc924@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 5 Mar 2019, at 06:46, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi,
>=20
> On 3/4/19 11:46 PM, James Sewart wrote:
>> Allowing IOMMU_DOMAIN_DMA type IOMMU domain to be allocated allows =
the
>> default_domain of an iommu_group to be set. This delegates =
device-domain
>> relationships to the generic IOMMU code.
>> Signed-off-by: James Sewart <jamessewart@arista.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 113 =
+++++++++++++++++++++++++++---------
>>  1 file changed, 84 insertions(+), 29 deletions(-)
>> diff --git a/drivers/iommu/intel-iommu.c =
b/drivers/iommu/intel-iommu.c
>> index 8e0a4e2ff77f..71cd6bbfec05 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -309,6 +309,14 @@ static int hw_pass_through =3D 1;
>>  /* si_domain contains mulitple devices */
>>  #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
>>  +/* Domain managed externally, don't cleanup if it isn't attached
>> + * to any devices. */
>> +#define DOMAIN_FLAG_MANAGED_EXTERNALLY	(1 << 2)
>> +
>> +/* Set after domain initialisation. Used when allocating dma domains =
to
>> + * defer domain initialisation until it is attached to a device */
>> +#define DOMAIN_FLAG_INITIALISED	(1 << 4)
>=20
> Why do you skip bit 3?

This was an oversight, I will update to use bit 3.

>=20
>> +
>>  #define for_each_domain_iommu(idx, domain)			\
>>  	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
>>  		if (domain->iommu_refcnt[idx])
>> @@ -558,6 +566,16 @@ static inline int domain_type_is_vm_or_si(struct =
dmar_domain *domain)
>>  				DOMAIN_FLAG_STATIC_IDENTITY);
>>  }
>>  +static inline int domain_managed_externally(struct dmar_domain =
*domain)
>> +{
>> +	return domain->flags & DOMAIN_FLAG_MANAGED_EXTERNALLY;
>> +}
>> +
>> +static inline int domain_is_initialised(struct dmar_domain *domain)
>> +{
>> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
>> +}
>> +
>>  static inline int domain_pfn_supported(struct dmar_domain *domain,
>>  				       unsigned long pfn)
>>  {
>> @@ -1662,7 +1680,7 @@ static void disable_dmar_iommu(struct =
intel_iommu *iommu)
>>    		__dmar_remove_one_dev_info(info);
>>  -		if (!domain_type_is_vm_or_si(domain)) {
>> +		if (!domain_managed_externally(domain)) {
>>  			/*
>>  			 * The domain_exit() function  can't be called =
under
>>  			 * device_domain_lock, as it takes this lock =
itself.
>> @@ -1895,6 +1913,7 @@ static int domain_init(struct dmar_domain =
*domain, struct intel_iommu *iommu,
>>  	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
>>  	if (!domain->pgd)
>>  		return -ENOMEM;
>> +	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
>>  	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
>>  	return 0;
>>  }
>> @@ -2807,14 +2826,10 @@ static inline void iommu_prepare_isa(void)
>>    static int md_domain_init(struct dmar_domain *domain, int =
guest_width);
>>  -static int __init si_domain_init(int hw)
>> +static int __init si_domain_init(struct dmar_domain *si_domain, int =
hw)
>>  {
>>  	int nid, ret =3D 0;
>>  -	si_domain =3D alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
>> -	if (!si_domain)
>> -		return -EFAULT;
>> -
>>  	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>>  		domain_exit(si_domain);
>>  		return -EFAULT;
>> @@ -3417,9 +3432,16 @@ static int __init init_dmars(void)
>>  	check_tylersburg_isoch();
>>    	if (iommu_identity_mapping) {
>> -		ret =3D si_domain_init(hw_pass_through);
>> -		if (ret)
>> +		si_domain =3D alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
>=20
> Where will this si_domain be used? We still need to keep the global
> si_domain?

I am unsure of the best thing to do here. The si_domain can be =
initialised=20
as a hardware passthrough which means it doesn=E2=80=99t have any =
mappings applied.=20
I think any user allocating a domain here will always want a software=20
passthrough domain. I=E2=80=99m not sure if/how to consolidate these =
two.

>=20
>> +		if (!si_domain) {
>> +			ret =3D -EFAULT;
>>  			goto free_iommu;
>> +		}
>> +		ret =3D si_domain_init(si_domain, hw_pass_through);
>> +		if (ret) {
>> +			domain_exit(si_domain);
>> +			goto free_iommu;
>> +		}
>>  	}
>>    @@ -4575,7 +4597,7 @@ static int device_notifier(struct =
notifier_block *nb,
>>  		return 0;
>>    	dmar_remove_one_dev_info(domain, dev);
>> -	if (!domain_type_is_vm_or_si(domain) && =
list_empty(&domain->devices))
>> +	if (!domain_managed_externally(domain) && =
list_empty(&domain->devices))
>>  		domain_exit(domain);
>>    	return 0;
>> @@ -5020,6 +5042,7 @@ static int md_domain_init(struct dmar_domain =
*domain, int guest_width)
>>  	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
>>  	if (!domain->pgd)
>>  		return -ENOMEM;
>> +	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
>>  	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
>>  	return 0;
>>  }
>> @@ -5028,28 +5051,54 @@ static struct iommu_domain =
*intel_iommu_domain_alloc(unsigned type)
>>  {
>>  	struct dmar_domain *dmar_domain;
>>  	struct iommu_domain *domain;
>> +	int flags =3D DOMAIN_FLAG_MANAGED_EXTERNALLY;
>>  -	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
>> -		return NULL;
>> -
>> -	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
>> -	if (!dmar_domain) {
>> -		pr_err("Can't allocate dmar_domain\n");
>> -		return NULL;
>> -	}
>> -	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>> -		pr_err("Domain initialization failed\n");
>> -		domain_exit(dmar_domain);
>> +	switch (type) {
>> +	case IOMMU_DOMAIN_UNMANAGED:
>> +		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE | =
DOMAIN_FLAG_INITIALISED;
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>> +			return NULL;
>> +		}
>> +		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>> +			pr_err("Domain initialization failed\n");
>> +			domain_exit(dmar_domain);
>> +			return NULL;
>> +		}
>> +		domain_update_iommu_cap(dmar_domain);
>> +		domain =3D &dmar_domain->domain;
>> +		domain->geometry.aperture_start =3D 0;
>> +		domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
>> +		domain->geometry.force_aperture =3D true;
>> +		break;
>> +	case IOMMU_DOMAIN_DMA:
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>=20
> Not necessary for memory allocation failure.

I=E2=80=99ll update in the next revision

>=20
>> +			return NULL;
>> +		}
>> +		// init domain in device attach when we know IOMMU =
capabilities
>=20
> Use /* */ for comments, please.

I=E2=80=99ll update in the next revision

>=20
>> +		break;
>> +	case IOMMU_DOMAIN_IDENTITY:
>> +		flags |=3D DOMAIN_FLAG_STATIC_IDENTITY | =
DOMAIN_FLAG_INITIALISED;
>> +		dmar_domain =3D alloc_domain(flags);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate dmar_domain\n");
>> +			return NULL;
>> +		}
>> +		if (si_domain_init(dmar_domain, 0)) {
>> +			pr_err("Domain initialization failed\n");
>> +			domain_exit(dmar_domain);
>> +			return NULL;
>> +		}
>> +		break;
>=20
> How about moving si domain allocation into a separated patch? There =
are
> two significant changes here, so it worth a new patch for discussion.
>=20
> 1) a shared single si domain vs. per group si domain;
> 2) previously vt-d drivers determines what kind of devices should use
>   identity domain; Now, it turns to iommu generic layer, behavior will
>   be changed.

I=E2=80=99ll move it into another patch. Do you think the global =
si_domain should=20
be returned here?

>> +	default:
>>  		return NULL;
>>  	}
>> -	domain_update_iommu_cap(dmar_domain);
>> -
>> -	domain =3D &dmar_domain->domain;
>> -	domain->geometry.aperture_start =3D 0;
>> -	domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
>> -	domain->geometry.force_aperture =3D true;
>>  -	return domain;
>> +	dmar_domain->domain.type =3D type;
>=20
> Is it necessary to set this?

It isn=E2=80=99t I=E2=80=99ll remove this for the next revision.

>=20
>> +	return &dmar_domain->domain;
>>  }
>>    static void intel_iommu_domain_free(struct iommu_domain *domain)
>> @@ -5080,8 +5129,8 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
>>  			dmar_remove_one_dev_info(old_domain, dev);
>>  			rcu_read_unlock();
>>  -			if (!domain_type_is_vm_or_si(old_domain) &&
>> -			     list_empty(&old_domain->devices))
>> +			if (list_empty(&old_domain->devices) &&
>> +			     !domain_managed_externally(old_domain))
>>  				domain_exit(old_domain);
>>  		}
>>  	}
>> @@ -5090,6 +5139,12 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
>>  	if (!iommu)
>>  		return -ENODEV;
>>  +	// Initialise domain with IOMMU capabilities if it isn't already =
initialised
>=20
> Ditto.
>=20
>> +	if (!domain_is_initialised(dmar_domain)) {
>> +		if (domain_init(dmar_domain, iommu, =
DEFAULT_DOMAIN_ADDRESS_WIDTH))
>> +			return -ENOMEM;
>> +	}
>=20
> Each domain, not matter the DMA domain or UNMANAGED domain, is =
allocated
> first and then gets initialized during device attaching, right? If so,
> why do we need to have a special DOMAIN_FLAG_INITIALISED flag for DMA
> domains?

Only the DMA domain is initialised on attach, UNMANAGED and IDENTITY=20
initialises with the lowest common denominator of the parameters of all=20=

attached IOMMUs using domain_update_iommu_cap.

>=20
>> +
>>  	/* check if this iommu agaw is sufficient for max mapped address =
*/
>>  	addr_width =3D agaw_to_width(iommu->agaw);
>>  	if (addr_width > cap_mgaw(iommu->cap))
>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
