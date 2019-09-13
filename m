Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A8C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1F2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ISpQbyr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfIMRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:37:34 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60969 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfIMRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568396251; x=1599932251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=hEtTLt7shZYpCeRJtmzBpo9y9jmoUnjb7OmJVTZFaqU=;
  b=ISpQbyr0LSXRGdQwjEh1NFNrEj4ev/LZBQfJnkzjzEoOpFGJriyEpTzw
   BwZZGAFqktbn3ePgP3h8dyEaHckKUJNToKjqUdKUzwznL2oH7NflxTejH
   HignL+sBLzqt769czuD+CBJ2aR1SiS6RgAw5NuHaqqx7hvpiLSCp7Cm9+
   I=;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="831708404"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 13 Sep 2019 17:37:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 8C43CA1E64;
        Fri, 13 Sep 2019 17:37:08 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 17:37:07 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Sep 2019 17:37:07 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Fri, 13 Sep 2019 17:37:06 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iommu/amd: Flushing and locking fixes
Thread-Topic: iommu/amd: Flushing and locking fixes
Thread-Index: AQHVaAAdZLIw6zsBR0+UAi/oDn4TsqcmWa8AgAOKCQA=
Date:   Fri, 13 Sep 2019 17:37:06 +0000
Message-ID: <8A1D9B62-F046-4723-9178-011254D36A85@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
 <20190911113415.GA25943@8bytes.org>
In-Reply-To: <20190911113415.GA25943@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.68]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B54ACD9D0304D842955FBAA93C1C48BB@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 11. Sep 2019, at 13:34, Joerg Roedel <joro@8bytes.org> wrote:
> =

> Hi Filippo,
> =

> On Tue, Sep 10, 2019 at 07:49:20PM +0200, Filippo Sironi wrote:
>> This patch series introduce patches to take the domain lock whenever we =
call
>> functions that end up calling __domain_flush_pages.  Holding the domain =
lock is
>> necessary since __domain_flush_pages traverses the device list, which is
>> protected by the domain lock.
>> =

>> The first patch in the series adds a completion right after an IOTLB flu=
sh in
>> attach_device.
> =

> Thanks for pointing out these locking issues and your fixes. I have been
> looking into it a bit and it seems there is more problems to take care
> of.
> =

> The first problem is the racy access to domain->updated, which is best
> fixed by moving that info onto the stack don't keep it in the domain
> structure.
> =

> Other than that, I think your patches are kind of the big hammer
> approach to fix it. As they are, they destroy the scalability of the
> dma-api path. So we need something more fine-grained, also if we keep in
> mind that the actual cases where we need to flush something in the
> dma-api path are very rare. The default should be to not take any lock
> in that path.
> =

> How does the attached patch look to you? It is completly untested but
> should give an idea of a better way to fix these locking issues.
> =

> Regards,
> =

> 	Joerg
> =

> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 61de81965c44..bb93a2bbb73d 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1435,9 +1435,10 @@ static void free_pagetable(struct protection_domai=
n *domain)
>  * another level increases the size of the address space by 9 bits to a s=
ize up
>  * to 64 bits.
>  */
> -static void increase_address_space(struct protection_domain *domain,
> +static bool increase_address_space(struct protection_domain *domain,
> 				   gfp_t gfp)
> {
> +	bool updated =3D false;
> 	unsigned long flags;
> 	u64 *pte;
> =

> @@ -1455,27 +1456,30 @@ static void increase_address_space(struct protect=
ion_domain *domain,
> 					iommu_virt_to_phys(domain->pt_root));
> 	domain->pt_root  =3D pte;
> 	domain->mode    +=3D 1;
> -	domain->updated  =3D true;
> +	updated		 =3D true;
> =

> out:
> 	spin_unlock_irqrestore(&domain->lock, flags);
> =

> -	return;
> +	return updated;
> }
> =

> static u64 *alloc_pte(struct protection_domain *domain,
> 		      unsigned long address,
> 		      unsigned long page_size,
> 		      u64 **pte_page,
> -		      gfp_t gfp)
> +		      gfp_t gfp,
> +		      bool *updated)
> {
> 	int level, end_lvl;
> 	u64 *pte, *page;
> =

> 	BUG_ON(!is_power_of_2(page_size));
> =

> +	*updated =3D false;
> +
> 	while (address > PM_LEVEL_SIZE(domain->mode))
> -		increase_address_space(domain, gfp);
> +		*updated =3D increase_address_space(domain, gfp) || *updated;
> =

> 	level   =3D domain->mode - 1;
> 	pte     =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> @@ -1501,7 +1505,7 @@ static u64 *alloc_pte(struct protection_domain *dom=
ain,
> 			if (cmpxchg64(pte, __pte, __npte) !=3D __pte)
> 				free_page((unsigned long)page);
> 			else if (pte_level =3D=3D PAGE_MODE_7_LEVEL)
> -				domain->updated =3D true;
> +				*updated =3D true;
> =

> 			continue;
> 		}
> @@ -1617,6 +1621,7 @@ static int iommu_map_page(struct protection_domain =
*dom,
> 	struct page *freelist =3D NULL;
> 	u64 __pte, *pte;
> 	int i, count;
> +	bool updated;
> =

> 	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
> 	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
> @@ -1625,7 +1630,7 @@ static int iommu_map_page(struct protection_domain =
*dom,
> 		return -EINVAL;
> =

> 	count =3D PAGE_SIZE_PTE_COUNT(page_size);
> -	pte   =3D alloc_pte(dom, bus_addr, page_size, NULL, gfp);
> +	pte   =3D alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
> =

> 	if (!pte)
> 		return -ENOMEM;
> @@ -1634,7 +1639,7 @@ static int iommu_map_page(struct protection_domain =
*dom,
> 		freelist =3D free_clear_pte(&pte[i], pte[i], freelist);
> =

> 	if (freelist !=3D NULL)
> -		dom->updated =3D true;
> +		updated =3D true;
> =

> 	if (count > 1) {
> 		__pte =3D PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
> @@ -1650,7 +1655,8 @@ static int iommu_map_page(struct protection_domain =
*dom,
> 	for (i =3D 0; i < count; ++i)
> 		pte[i] =3D __pte;
> =

> -	update_domain(dom);
> +	if (updated)
> +		update_domain(dom);
> =

> 	/* Everything flushed out, free pages now */
> 	free_page_list(freelist);
> @@ -2041,6 +2047,13 @@ static int __attach_device(struct iommu_dev_data *=
dev_data,
> 	/* Attach alias group root */
> 	do_attach(dev_data, domain);
> =

> +	/*
> +	 * We might boot into a crash-kernel here. The crashed kernel
> +	 * left the caches in the IOMMU dirty. So we have to flush
> +	 * here to evict all dirty stuff.
> +	 */
> +	domain_flush_tlb_pde(domain);
> +
> 	ret =3D 0;
> =

> out_unlock:
> @@ -2162,13 +2175,6 @@ static int attach_device(struct device *dev,
> 	ret =3D __attach_device(dev_data, domain);
> 	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
> =

> -	/*
> -	 * We might boot into a crash-kernel here. The crashed kernel
> -	 * left the caches in the IOMMU dirty. So we have to flush
> -	 * here to evict all dirty stuff.
> -	 */
> -	domain_flush_tlb_pde(domain);
> -
> 	return ret;
> }
> =

> @@ -2352,17 +2358,21 @@ static void update_device_table(struct protection=
_domain *domain)
> 	}
> }
> =

> -static void update_domain(struct protection_domain *domain)
> +static void __update_domain(struct protection_domain *domain)
> {
> -	if (!domain->updated)
> -		return;
> -
> 	update_device_table(domain);
> =

> 	domain_flush_devices(domain);
> 	domain_flush_tlb_pde(domain);
> +}
> =

> -	domain->updated =3D false;
> +static void update_domain(struct protection_domain *domain)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	__update_domain(domain);
> +	spin_unlock_irqrestore(&domain->lock, flags);
> }
> =

> static int dir2prot(enum dma_data_direction direction)
> @@ -3221,9 +3231,12 @@ static bool amd_iommu_is_attach_deferred(struct io=
mmu_domain *domain,
> static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> {
> 	struct protection_domain *dom =3D to_pdomain(domain);
> +	unsigned long flags;
> =

> +	spin_lock_irqsave(&dom->lock, flags);
> 	domain_flush_tlb_pde(dom);
> 	domain_flush_complete(dom);
> +	spin_unlock_irqrestore(&dom->lock, flags);
> }
> =

> static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> @@ -3285,10 +3298,9 @@ void amd_iommu_domain_direct_map(struct iommu_doma=
in *dom)
> =

> 	/* Update data structure */
> 	domain->mode    =3D PAGE_MODE_NONE;
> -	domain->updated =3D true;
> =

> 	/* Make changes visible to IOMMUs */
> -	update_domain(domain);
> +	__update_domain(domain);
> =

> 	/* Page-table is not visible to IOMMU anymore, so free it */
> 	free_pagetable(domain);
> @@ -3331,9 +3343,8 @@ int amd_iommu_domain_enable_v2(struct iommu_domain =
*dom, int pasids)
> =

> 	domain->glx      =3D levels;
> 	domain->flags   |=3D PD_IOMMUV2_MASK;
> -	domain->updated  =3D true;
> =

> -	update_domain(domain);
> +	__update_domain(domain);
> =

> 	ret =3D 0;
> =

> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_ty=
pes.h
> index 64edd5a9694c..143e1bf70c40 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -475,7 +475,6 @@ struct protection_domain {
> 	int glx;		/* Number of levels for GCR3 table */
> 	u64 *gcr3_tbl;		/* Guest CR3 table */
> 	unsigned long flags;	/* flags to find out type of domain */
> -	bool updated;		/* complete domain flush required */
> 	unsigned dev_cnt;	/* devices assigned to this domain */
> 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> };

Hi Joerg,

I agree with the assessment, taking the domain lock everywhere is definitely
a big hammer.

I didn't test your patch but it looks sane.

Filippo





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



