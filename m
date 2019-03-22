Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A66206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nIOMUomv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCVJ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:57:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42122 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfCVJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:57:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so1162506pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oSBrHBUg5LKLpoebVvBw3+vFCP9u+NDOt1GSkMmZpqs=;
        b=nIOMUomvquEP8pdG7m5AilvJ+kOF1M4szk7SlYixWYUmvcaFWBl45GCXU676hKshLz
         evpmNGG6PyhRe6zcVCFIwYAiCHDVOuRfP0iR4ySRX1wIymzYTFFxlWXna7CkQyZquims
         3yb+iSH99PvB3HIwMiMf5K4uW5lzs4kEKfos6mGJGfmvU1qe4MSbmEeI9Ki5FJHcnmeG
         wYLvQUInhvnfrJGNrDkik8Z67e4t9eW798qXr7Uj7HdMpgOC+PlYRBxemUIHXLo7EPgW
         MaPhfzApgUI8Hnxn74he0msMPVKZ16pg4GLnpSD95uWdCaOzvqXHQLJ3l/cPhwKCtfXF
         oHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oSBrHBUg5LKLpoebVvBw3+vFCP9u+NDOt1GSkMmZpqs=;
        b=OVeA3rQY6ORd0lOV+Wcrh4ics1HEBV+SxtsvYGU6dVI70CgJQvbFJBjDkxkg6eOc3n
         n3cmPR7MReEUdrM39IzHiBXckpQFt+SF6Tafc4bKZIPP3rMiiuq6bvBuACWp62R4wVai
         9pdVpfFV77wenwpUgxymBZXpm3+w5gYDihogUmdxQQscZ1AQqIf5+ATGbCQDrMIwa76V
         aZe7GfABlC5f/OJep5vIqmeDHguCX3vlbsJEES69gNCQw68tZY5tNIHNRZqaqsFES9RM
         tTZ6fn4vzC6b/rRt6V1uYIhGznbv6n1APDhU0FmZiijK5cer+llM4JDaq/Oh7UX2/v8V
         Wu0g==
X-Gm-Message-State: APjAAAUnMEABX2CKSws0ZkR9MY/ad0dZogKW4AMLze7UjQqZIInf8+D+
        NodY8TmjDaVVuc1hjixs3LRkv01h1wYRv74S
X-Google-Smtp-Source: APXvYqwUStY8yV9Clby1DcGSENWL3oVet5R1usXMEtcAtT/wuz716AWXFJQtjvdjY0PTaWcwqSdiWg==
X-Received: by 2002:a63:68c9:: with SMTP id d192mr8292122pgc.264.1553248631872;
        Fri, 22 Mar 2019 02:57:11 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c3:bd00:49d7:4bdf:6b78:2db4? ([2a02:8084:20c3:bd00:49d7:4bdf:6b78:2db4])
        by smtp.gmail.com with ESMTPSA id n82sm14296370pfi.63.2019.03.22.02.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:57:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
Date:   Fri, 22 Mar 2019 09:57:01 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 15 Mar 2019, at 02:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/14/19 7:58 PM, James Sewart wrote:
>> To support mapping ISA region via iommu_group_create_direct_mappings,
>> make sure its exposed by iommu_get_resv_regions. This allows
>> deduplication of reserved region mappings
>> Signed-off-by: James Sewart <jamessewart@arista.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 42 =
+++++++++++++++++++++++++++++--------
>>  1 file changed, 33 insertions(+), 9 deletions(-)
>> diff --git a/drivers/iommu/intel-iommu.c =
b/drivers/iommu/intel-iommu.c
>> index 8e0a4e2ff77f..2e00e8708f06 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -337,6 +337,8 @@ static LIST_HEAD(dmar_rmrr_units);
>>  #define for_each_rmrr_units(rmrr) \
>>  	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
>>  +static struct iommu_resv_region *isa_resv_region;
>> +
>>  /* bitmap for indexing intel_iommus */
>>  static int g_num_of_iommus;
>>  @@ -2780,26 +2782,34 @@ static inline int =
iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
>>  					  rmrr->end_address);
>>  }
>>  +static inline struct iommu_resv_region =
*iommu_get_isa_resv_region(void)
>> +{
>> +	if (!isa_resv_region)
>> +		isa_resv_region =3D iommu_alloc_resv_region(0,
>> +				16*1024*1024,
>> +				0, IOMMU_RESV_DIRECT);
>> +
>> +	return isa_resv_region;
>> +}
>> +
>>  #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>> -static inline void iommu_prepare_isa(void)
>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>  {
>> -	struct pci_dev *pdev;
>>  	int ret;
>> +	struct iommu_resv_region *reg =3D iommu_get_isa_resv_region();
>>  -	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>> -	if (!pdev)
>> +	if (!reg)
>>  		return;
>>    	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
>> -	ret =3D iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - =
1);
>> +	ret =3D iommu_prepare_identity_map(&pdev->dev, reg->start,
>> +			reg->start + reg->length - 1);
>>    	if (ret)
>>  		pr_err("Failed to create 0-16MiB identity map - floppy =
might not work\n");
>> -
>> -	pci_dev_put(pdev);
>>  }
>>  #else
>> -static inline void iommu_prepare_isa(void)
>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>  {
>>  	return;
>>  }
>> @@ -3289,6 +3299,7 @@ static int __init init_dmars(void)
>>  	struct dmar_rmrr_unit *rmrr;
>>  	bool copied_tables =3D false;
>>  	struct device *dev;
>> +	struct pci_dev *pdev;
>>  	struct intel_iommu *iommu;
>>  	int i, ret;
>>  @@ -3469,7 +3480,11 @@ static int __init init_dmars(void)
>>  		}
>>  	}
>>  -	iommu_prepare_isa();
>> +	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>> +	if (pdev) {
>> +		iommu_prepare_isa(pdev);
>> +		pci_dev_put(pdev);
>> +	}
>>    domains_done:
>>  @@ -5266,6 +5281,7 @@ static void =
intel_iommu_get_resv_regions(struct device *device,
>>  	struct iommu_resv_region *reg;
>>  	struct dmar_rmrr_unit *rmrr;
>>  	struct device *i_dev;
>> +	struct pci_dev *pdev;
>>  	int i;
>>    	rcu_read_lock();
>> @@ -5280,6 +5296,14 @@ static void =
intel_iommu_get_resv_regions(struct device *device,
>>  	}
>>  	rcu_read_unlock();
>>  +	if (dev_is_pci(device)) {
>> +		pdev =3D to_pci_dev(device);
>> +		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
>> +			reg =3D iommu_get_isa_resv_region();
>> +			list_add_tail(&reg->list, head);
>> +		}
>> +	}
>> +
>=20
> Just wondering why not just
>=20
> +#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> +	if (dev_is_pci(device)) {
> +		pdev =3D to_pci_dev(device);
> +		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
> +			reg =3D iommu_alloc_resv_region(0,
> +				16*1024*1024,
> +				0, IOMMU_RESV_DIRECT);
> +			if (reg)
> +				list_add_tail(&reg->list, head);
> +		}
> +	}
> +#endif
>=20
> and, remove all other related code?

At this point in the patchset if we remove iommu_prepare_isa then the =
ISA=20
region won=E2=80=99t be mapped to the device. Only once the dma domain =
is allocable=20
will the reserved regions be mapped by =
iommu_group_create_direct_mappings.

Theres an issue that if we choose to alloc a new resv_region with type=20=

IOMMU_RESV_DIRECT, we will need to refactor intel_iommu_put_resv_regions=20=

to free this entry type which means refactoring the rmrr regions in=20
get_resv_regions. Should this work be in this patchset?

>=20
> Best regards,
> Lu Baolu

Cheers,
James.

