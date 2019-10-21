Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kCntxG+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfJUOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:15:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36872 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfJUOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:15:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id g50so7073539qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SR4XTutzmthc5d7HZlzvb9fPYpgDWiu5nZW7fLVerx8=;
        b=kCntxG+F1zGFLNKi29nV21oIr+oWcnNbXh3PUmsWE3G90Dm4KkfQgx0khoIx807KF/
         Fo1lr/49orQnWqqI6pseXkRQc0bPFDWZ4Yn+lX0tanl/fsf2aafO+az+wHWPEGEQcreU
         2jcEJTTZ93QcKji+Li9QyTYXDDmqIaVZJnOo+mss3C7COKX9swvfSC1+h5uEyv+bEs8X
         mzsdRItRKrn4AXS/tfSqpQmM9EA9WwUIVFffPwRHxfv8Ie6G5IWxpCNIQdCoEK0tTg9V
         0CvjLyXqcJIrNKdc3CDyG4fpx7bjYKzknXwgdyjwPaqpQz+K8iJcsEP7e0bNtwRXWPxF
         9PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SR4XTutzmthc5d7HZlzvb9fPYpgDWiu5nZW7fLVerx8=;
        b=KnQmoFO1Y6eF8Yqo2TqdcuHJMnRZGUDhbDS1l8lYCMRZsp6B1tv1/xQzwhQImAd3D2
         0jnQUtffs+M7O3DwqNgbch+j6YpxndOMnogjWyHiEfn2NudD4mt/Z0X7Tt7vNb2ZY670
         Laz0+fsFDtfins7fQOZ1Xn4lVmDSpq4oMTBjebWSembFYBhNIN0kbHxKu8OsoFu8uU1g
         YWk4fsY1Ol0rxp2nLo9MqTt6Inuzn96hDVAGQbl6JnNfbUZ12cYqQYiiCgFPPnoyzvqY
         QPoUcTDKCoXwPY2/x2r9pVp5T/Kl+634uZtPfr4C0bXWZv7E90Aimyft94Qs412LV93D
         7IbA==
X-Gm-Message-State: APjAAAX0hOzzG+XoV48JqEydHmn0OAbnCRXbDtR4CylJBfTOQGqOjpBe
        r5um8xbnzRu7azT0XHDSIE4pqw==
X-Google-Smtp-Source: APXvYqx0A0iC7aDo3GjKGWsrUQLEpvuI2joDEdM2ghjsafGIxZjhcGWwTQP5TnIKoz1WBOGKbTUiiA==
X-Received: by 2002:a0c:c10d:: with SMTP id f13mr23889157qvh.88.1571667357222;
        Mon, 21 Oct 2019 07:15:57 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h184sm8536827qkf.89.2019.10.21.07.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:15:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190911182546.17094-4-nsaenzjulienne@suse.de>
Date:   Mon, 21 Oct 2019 10:15:55 -0400
Cc:     catalin.marinas@arm.com, Christoph Hellwig <hch@lst.de>,
        wahrenst@gmx.net, marc.zyngier@arm.com,
        Rob Herring <robh+dt@kernel.org>, f.fainelli@gmail.com,
        will@kernel.org, linux-mm@kvack.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3956E54B-6C7A-4C47-B9B6-75F556EFD3F5@lca.pw>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2019, at 2:25 PM, Nicolas Saenz Julienne =
<nsaenzjulienne@suse.de> wrote:
>=20
> So far all arm64 devices have supported 32 bit DMA masks for their
> peripherals. This is not true anymore for the Raspberry Pi 4 as most =
of
> it's peripherals can only address the first GB of memory on a total of
> up to 4 GB.
>=20
> This goes against ZONE_DMA32's intent, as it's expected for ZONE_DMA32
> to be addressable with a 32 bit mask. So it was decided to =
re-introduce
> ZONE_DMA in arm64.
>=20
> ZONE_DMA will contain the lower 1G of memory, which is currently the
> memory area addressable by any peripheral on an arm64 device.
> ZONE_DMA32 will contain the rest of the 32 bit addressable memory.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>=20
> ---
>=20
> I kept the Reviewed-by as the last bug solution was proposed by =
Catalin
>=20
> Changes in v6:
> - Fixed bug in max_zone_phys
>=20
> Changes in v5:
> - Fixed swiotlb initialization
>=20
> Changes in v4:
> - Fixed issue when NUMA=3Dn and ZONE_DMA=3Dn
> - Merged two max_zone_dma*_phys() functions
>=20
> Changes in v3:
> - Used fixed size ZONE_DMA
> - Fix check befor swiotlb_init()
>=20
> Changes in v2:
> - Update comment to reflect new zones split
> - ZONE_DMA will never be left empty
>=20
> arch/arm64/Kconfig            |  4 +++
> arch/arm64/include/asm/page.h |  2 ++
> arch/arm64/mm/init.c          | 54 +++++++++++++++++++++++++----------
> 3 files changed, 45 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6b6362b83004..2dbe0165bd15 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -267,6 +267,10 @@ config GENERIC_CSUM
> config GENERIC_CALIBRATE_DELAY
> 	def_bool y
>=20
> +config ZONE_DMA
> +	bool "Support DMA zone" if EXPERT
> +	default y
> +
> config ZONE_DMA32
> 	bool "Support DMA32 zone" if EXPERT
> 	default y
> diff --git a/arch/arm64/include/asm/page.h =
b/arch/arm64/include/asm/page.h
> index d39ddb258a04..7b8c98830101 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -38,4 +38,6 @@ extern int pfn_valid(unsigned long);
>=20
> #include <asm-generic/getorder.h>
>=20
> +#define ARCH_ZONE_DMA_BITS 30
> +
> #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8e9bc64c5878..44f07fdf7a59 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -56,6 +56,13 @@ EXPORT_SYMBOL(physvirt_offset);
> struct page *vmemmap __ro_after_init;
> EXPORT_SYMBOL(vmemmap);
>=20
> +/*
> + * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first =
1G of
> + * memory as some devices, namely the Raspberry Pi 4, have =
peripherals with
> + * this limited view of the memory. ZONE_DMA32 will cover the rest of =
the 32
> + * bit addressable memory area.
> + */
> +phys_addr_t arm64_dma_phys_limit __ro_after_init;
> phys_addr_t arm64_dma32_phys_limit __ro_after_init;
>=20
> #ifdef CONFIG_KEXEC_CORE
> @@ -169,15 +176,16 @@ static void __init reserve_elfcorehdr(void)
> {
> }
> #endif /* CONFIG_CRASH_DUMP */
> +
> /*
> - * Return the maximum physical address for ZONE_DMA32 =
(DMA_BIT_MASK(32)). It
> - * currently assumes that for memory starting above 4G, 32-bit =
devices will
> - * use a DMA offset.
> + * Return the maximum physical address for a zone with a given =
address size
> + * limit. It currently assumes that for memory starting above 4G, =
32-bit
> + * devices will use a DMA offset.
>  */
> -static phys_addr_t __init max_zone_dma32_phys(void)
> +static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> {
> -	phys_addr_t offset =3D memblock_start_of_DRAM() & =
GENMASK_ULL(63, 32);
> -	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
> +	phys_addr_t offset =3D memblock_start_of_DRAM() & =
GENMASK_ULL(63, zone_bits);
> +	return min(offset + (1ULL << zone_bits), =
memblock_end_of_DRAM());
> }
>=20
> #ifdef CONFIG_NUMA
> @@ -186,6 +194,9 @@ static void __init zone_sizes_init(unsigned long =
min, unsigned long max)
> {
> 	unsigned long max_zone_pfns[MAX_NR_ZONES]  =3D {0};
>=20
> +#ifdef CONFIG_ZONE_DMA
> +	max_zone_pfns[ZONE_DMA] =3D PFN_DOWN(arm64_dma_phys_limit);
> +#endif
> #ifdef CONFIG_ZONE_DMA32
> 	max_zone_pfns[ZONE_DMA32] =3D PFN_DOWN(arm64_dma32_phys_limit);
> #endif
> @@ -201,13 +212,18 @@ static void __init zone_sizes_init(unsigned long =
min, unsigned long max)
> 	struct memblock_region *reg;
> 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
> 	unsigned long max_dma32 =3D min;
> +	unsigned long max_dma =3D min;
>=20
> 	memset(zone_size, 0, sizeof(zone_size));
>=20
> -	/* 4GB maximum for 32-bit only capable devices */
> +#ifdef CONFIG_ZONE_DMA
> +	max_dma =3D PFN_DOWN(arm64_dma_phys_limit);
> +	zone_size[ZONE_DMA] =3D max_dma - min;
> +	max_dma32 =3D max_dma;
> +#endif
> #ifdef CONFIG_ZONE_DMA32
> 	max_dma32 =3D PFN_DOWN(arm64_dma32_phys_limit);
> -	zone_size[ZONE_DMA32] =3D max_dma32 - min;
> +	zone_size[ZONE_DMA32] =3D max_dma32 - max_dma;
> #endif
> 	zone_size[ZONE_NORMAL] =3D max - max_dma32;
>=20
> @@ -219,11 +235,17 @@ static void __init zone_sizes_init(unsigned long =
min, unsigned long max)
>=20
> 		if (start >=3D max)
> 			continue;
> -
> +#ifdef CONFIG_ZONE_DMA
> +		if (start < max_dma) {
> +			unsigned long dma_end =3D min_not_zero(end, =
max_dma);
> +			zhole_size[ZONE_DMA] -=3D dma_end - start;
> +		}
> +#endif
> #ifdef CONFIG_ZONE_DMA32
> 		if (start < max_dma32) {
> -			unsigned long dma_end =3D min(end, max_dma32);
> -			zhole_size[ZONE_DMA32] -=3D dma_end - start;
> +			unsigned long dma32_end =3D min(end, max_dma32);
> +			unsigned long dma32_start =3D max(start, =
max_dma);
> +			zhole_size[ZONE_DMA32] -=3D dma32_end - =
dma32_start;
> 		}
> #endif
> 		if (end > max_dma32) {
> @@ -418,9 +440,11 @@ void __init arm64_memblock_init(void)
>=20
> 	early_init_fdt_scan_reserved_mem();
>=20
> -	/* 4GB maximum for 32-bit only capable devices */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		arm64_dma_phys_limit =3D =
max_zone_phys(ARCH_ZONE_DMA_BITS);
> +
> 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		arm64_dma32_phys_limit =3D max_zone_dma32_phys();
> +		arm64_dma32_phys_limit =3D max_zone_phys(32);
> 	else
> 		arm64_dma32_phys_limit =3D PHYS_MASK + 1;
>=20
> @@ -430,7 +454,7 @@ void __init arm64_memblock_init(void)
>=20
> 	high_memory =3D __va(memblock_end_of_DRAM() - 1) + 1;
>=20
> -	dma_contiguous_reserve(arm64_dma32_phys_limit);
> +	dma_contiguous_reserve(arm64_dma_phys_limit ? : =
arm64_dma32_phys_limit);
> }
>=20
> void __init bootmem_init(void)
> @@ -534,7 +558,7 @@ static void __init free_unused_memmap(void)
> void __init mem_init(void)
> {
> 	if (swiotlb_force =3D=3D SWIOTLB_FORCE ||
> -	    max_pfn > (arm64_dma32_phys_limit >> PAGE_SHIFT))
> +	    max_pfn > PFN_DOWN(arm64_dma_phys_limit ? : =
arm64_dma32_phys_limit))
> 		swiotlb_init(1);
> 	else
> 		swiotlb_force =3D SWIOTLB_NO_FORCE;
> --=20
> 2.23.0
>=20
>=20

With ZONE_DMA=3Dy, this config will fail to reserve 512M CMA on a =
server,

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

CONFIG_DMA_CMA=3Dy
CONFIG_CMA_SIZE_MBYTES=3D64
CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
CONFIG_CMA_ALIGNMENT=3D8
CONFIG_CMA=3Dy
CONFIG_CMA_DEBUGFS=3Dy
CONFIG_CMA_AREAS=3D7

Is this expected?=
