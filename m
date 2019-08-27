Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8984AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580D1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfH0MX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:23:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0MX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8E228;
        Tue, 27 Aug 2019 05:23:26 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4633F718;
        Tue, 27 Aug 2019 05:23:25 -0700 (PDT)
Subject: Re: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
To:     Peng Fan <peng.fan@nxp.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190709083729.11135-1-peng.fan@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d70b3a5c-647c-2147-99be-4572f76e898b@arm.com>
Date:   Tue, 27 Aug 2019 13:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190709083729.11135-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2019 09:22, Peng Fan wrote:
> arm64 shares some code under arch/arm/xen, including mm.c.
> However ZONE_DMA is removed by commit
> ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
> So to ARM64, need use __GFP_DMA32.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm/xen/mm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index e1d44b903dfc..a95e76d18bf9 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -27,7 +27,7 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>   
>   	for_each_memblock(memory, reg) {
>   		if (reg->base < (phys_addr_t)0xffffffff) {
> -			flags |= __GFP_DMA;
> +			flags |= __GFP_DMA | __GFP_DMA32;

Given the definition of GFP_ZONE_BAD, I'm not sure this combination of 
flags is strictly valid, but rather is implicitly reliant on only one of 
those zones ever actually existing. As such, it seems liable to blow up 
if the plans to add ZONE_DMA to arm64[1] go ahead.

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/20190820145821.27214-1-nsaenzjulienne@suse.de/

>   			break;
>   		}
>   	}
> 
