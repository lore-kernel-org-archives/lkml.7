Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA9BC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CFA2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFNHYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:24:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42002 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfFNHY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so1713625otn.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uCR24TBOk3OIH8vvM2+dQIPnKS4Tb63WZTvRttfMKk=;
        b=S4silnyzcvKLBiyu0lRCyTMQHeBSOHFIxvGFxpdqr4ESQEMn2LVL4EBWZGHwfvPg42
         lUrSxu7w7uygnK8+3CNyUs7gsv9ILpKC6WAkSL3mSbtKuW86R9VtOA2tUxQ0fFHonQ0O
         0YppPbCJ/swPQpHMwZfljbOMJMjalqTiSCmrROTrR7Y11zPdgPr1hy7tDoeuUH1NTd//
         mUxXauwBEdRDB9a9SCJRsi4Aw5OVA3VZfa8JrzMCayLuXelqZZBRGtePlXXAce0Bnxyx
         s+At8i54mnCVI7b1n6LJBZyvW6g2fAMkFGHSj/Ten4iZJ9ck6ht3nZ5S59t/76otIvRc
         F2Pg==
X-Gm-Message-State: APjAAAVJcD7P2FwuCa+5RSNlFsKZvdEZUEIpNL/kYP2qjAw82BovCQyz
        iEnr3F65EM+B4Fe0AsnyI5PWSovru3EBy+I1Yb4=
X-Google-Smtp-Source: APXvYqwGu1JHa1iz1amVUHNyIUTMhsCShMGjlKbwTjhPIIIdXS77eBjkBE8e5hTiKBm2eFNCEg8mXQSDdNhqnvlUZ8c=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr44758163otb.335.1560497067686;
 Fri, 14 Jun 2019 00:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190613082446.18685-1-hch@lst.de>
In-Reply-To: <20190613082446.18685-1-hch@lst.de>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 14 Jun 2019 09:24:16 +0200
Message-ID: <CA+7wUswMtpVCoX0H5eF=GUY8jWDAEWa9Z223tKiKHiL69hhHtQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, aaro.koskinen@iki.fi
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> With the strict dma mask checking introduced with the switch to
> the generic DMA direct code common wifi chips on 32-bit powerbooks
> stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> to allow them to reliably allocate dma coherent memory.
>
> Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/page.h         | 7 +++++++
>  arch/powerpc/mm/mem.c                   | 3 ++-
>  arch/powerpc/platforms/powermac/Kconfig | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index b8286a2013b4..0d52f57fca04 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -319,6 +319,13 @@ struct vm_area_struct;
>  #endif /* __ASSEMBLY__ */
>  #include <asm/slice.h>
>
> +/*
> + * Allow 30-bit DMA for very limited Broadcom wifi chips on many powerbooks.

nit: would it be possible to mention explicit reference to b43-legacy.
Using b43 on my macmini g4 never showed those symptoms (using
5.2.0-rc2+)

$ dmesg | grep b43
[   14.327189] bus: 'pci': add driver b43-pci-bridge
[   14.345354] bus: 'pci': driver_probe_device: matched device
0001:10:12.0 with driver b43-pci-bridge
[   14.380110] bus: 'pci': really_probe: probing driver b43-pci-bridge
with device 0001:10:12.0
[   14.440295] b43-pci-bridge 0001:10:12.0: enabling device (0004 -> 0006)
[   14.637223] b43-pci-bridge 0001:10:12.0: Sonics Silicon Backplane
found on PCI device 0001:10:12.0
[   14.644858] driver: 'b43-pci-bridge': driver_bound: bound to device
'0001:10:12.0'
[   14.743341] bus: 'pci': really_probe: bound device 0001:10:12.0 to
driver b43-pci-bridge
[   18.724343] bus: 'bcma': add driver b43
[   18.728635] bus: 'ssb': add driver b43
[   18.734305] bus: 'ssb': driver_probe_device: matched device ssb0:0
with driver b43
[   18.743155] bus: 'ssb': really_probe: probing driver b43 with device ssb0:0
[   18.747782] b43-phy0: Broadcom 4306 WLAN found (core revision 5)
[   18.767439] b43-phy0: Found PHY: Analog 2, Type 2 (G), Revision 2
[   18.771759] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision
2, Version 0
[   18.795467] driver: 'b43': driver_bound: bound to device 'ssb0:0'
[   18.801533] bus: 'ssb': really_probe: bound device ssb0:0 to driver b43
[   22.143084] b43-phy0: Loading firmware version 666.2 (2011-02-23 01:15:07)
[   25.133011] b43 ssb0:0 wlan0: disabling HT as WMM/QoS is not
supported by the AP
[   25.140221] b43 ssb0:0 wlan0: disabling VHT as WMM/QoS is not
supported by the AP


> + */
> +#ifdef CONFIG_PPC32
> +#define ARCH_ZONE_DMA_BITS 30
> +#else
>  #define ARCH_ZONE_DMA_BITS 31
> +#endif
>
>  #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index cba29131bccc..2540d3b2588c 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -248,7 +248,8 @@ void __init paging_init(void)
>                (long int)((top_of_ram - total_ram) >> 20));
>
>  #ifdef CONFIG_ZONE_DMA
> -       max_zone_pfns[ZONE_DMA] = min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +       max_zone_pfns[ZONE_DMA] = min(max_low_pfn,
> +                       ((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
>  #endif
>         max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
> index f834a19ed772..c02d8c503b29 100644
> --- a/arch/powerpc/platforms/powermac/Kconfig
> +++ b/arch/powerpc/platforms/powermac/Kconfig
> @@ -7,6 +7,7 @@ config PPC_PMAC
>         select PPC_INDIRECT_PCI if PPC32
>         select PPC_MPC106 if PPC32
>         select PPC_NATIVE
> +       select ZONE_DMA if PPC32
>         default y
>
>  config PPC_PMAC64
> --
> 2.20.1
>
