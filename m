Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 04:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BA520865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MzM8LadG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKID7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:59:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34839 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfKID7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:59:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so6943266qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 19:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aROgLuqmyQMn6bQ3dkRZULLKhNypYtMoFctyPNExrr8=;
        b=MzM8LadGws9kVWYfucgsQOARwUxQ0v14BoSsETtO0VfLCIibmC6dR1dP87tTDPKUlk
         eFNhdrVFtqdad+YCvvDGiAsYzWVzJJMTyxPB0AKHXvN9sOY31st+DBlz8wjty9Xlp2jH
         wOPof/LWVH3M5TRHLjS+87Dj7v/tEvyjOcTesEAWFG/UKvVCZ1/WcHgPO8LHBTv1D78c
         Sr+8omFbTtQ6peGcGzTjT8JTlgBT/X6PtdNUC9uJw9QGuAU22ygXn2BQ8peVT1OWcOP0
         r419pcS9pTK7zB9DkuWTSQ9I+6gpnGesLFFEWKxTg7jekKuxHy/ca1BNweLNWjPBNXN2
         fXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aROgLuqmyQMn6bQ3dkRZULLKhNypYtMoFctyPNExrr8=;
        b=JPEL4wuWDW87YyL2KOuKJBu2i37QgLwlt44tGN8XoahTEMT3exSoghunfFk2vv19EO
         cbl6vBtca7jvDc6bINDiSXnR0MSAfCFFOM9RvfJmQdM6h5wkgwnZ5aV0y+nfBL8yErSt
         sWaui9dPU+7EhsUADUFv0RW9fps5Bahyeu3eM6w0kT1XycDrtgZ199X0+xgSKG90bjFh
         Dua/4OLJZAeR+asVDOiy2N/GGKh+GKpW0Ktjo2CXDQB3gTSSBxzhObKPQNGEFYlU9ddN
         wJrc1MV/w3ZiyZbyL6wVLMB5T7PIRK3wmKvFsH96yyY7S+wGdn/lDqfvpmecwQSoE5Jn
         p2GA==
X-Gm-Message-State: APjAAAU5YHynhnjlbOu9ZQYn5hzDb4/+64io9MpJT3dKgfNqgo661Fi7
        u3csRxmV2mz8olmihek1s4gyVw==
X-Google-Smtp-Source: APXvYqyJm/ueJQ86ESZKiEi2O0iWVfky5nDFQUUmL2RhwXagjqCuRNkA+VM2ExLU3ZBV76dbCqvABg==
X-Received: by 2002:a05:620a:a0e:: with SMTP id i14mr355330qka.3.1573271943010;
        Fri, 08 Nov 2019 19:59:03 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x65sm4183104qkd.15.2019.11.08.19.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 19:59:02 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191109034039.27964-1-baolu.lu@linux.intel.com>
Date:   Fri, 8 Nov 2019 22:59:01 -0500
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 8, 2019, at 10:40 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> This adds Kconfig option INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> to make it easier for distributions to enable or disable the
> Intel IOMMU scalable mode by default during kernel build.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
> drivers/iommu/Kconfig       | 9 +++++++++
> drivers/iommu/intel-iommu.c | 7 ++++++-
> 2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..fbdf3fd291d9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -242,6 +242,15 @@ config INTEL_IOMMU_FLOPPY_WA
> 	  workaround will setup a 1:1 mapping for the first
> 	  16MiB to make floppy (an ISA device) work.
>=20
> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +	prompt "Enable Intel IOMMU scalable mode by default"
> +	depends on INTEL_IOMMU
> +	help
> +	  Selecting this option will enable the scalable mode if
> +	  hardware presents the capability. If this option is not
> +	  selected, scalable mode support could also be enabled
> +	  by passing intel_iommu=3Dsm_on to the kernel.


Maybe a sentence or two to describe what the scalable mode is in =
layman's
terms could be useful, so developers don=E2=80=99t need to search around =
for the
Kconfig selection?

> +
> config IRQ_REMAP
> 	bool "Support for Interrupt Remapping"
> 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6db6d969e31c..6051fe790c61 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -355,9 +355,14 @@ static phys_addr_t =
intel_iommu_iova_to_phys(struct iommu_domain *domain,
> int dmar_disabled =3D 0;
> #else
> int dmar_disabled =3D 1;
> -#endif /*CONFIG_INTEL_IOMMU_DEFAULT_ON*/
> +#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
>=20
> +#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +int intel_iommu_sm =3D 1;
> +#else
> int intel_iommu_sm;
> +#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
> +
> int intel_iommu_enabled =3D 0;
> EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>=20
> --=20
> 2.17.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

