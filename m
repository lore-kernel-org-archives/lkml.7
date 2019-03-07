Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71C620652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCGJRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:17:18 -0500
Received: from foss.arm.com ([217.140.101.70]:42720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGJRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:17:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86038EBD;
        Thu,  7 Mar 2019 01:17:17 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2683F706;
        Thu,  7 Mar 2019 01:17:15 -0800 (PST)
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190307085246.1477426-1-arnd@arndb.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
Date:   Thu, 7 Mar 2019 09:17:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190307085246.1477426-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2019-03-07 8:52 am, Arnd Bergmann wrote:
> Clang has a rather annoying behavior of checking for integer
> arithmetic problems in code paths that are discarded by gcc
> before that perfoms the same checks.
> 
> For DMA_BIT_MASK(64), this leads to a warning despite the
> result of the macro being completely sensible:
> 
> arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>                  .coherent_dma_mask = DMA_BIT_MASK(64),
> 
> The best workaround I could come up with is to shift the
> value twice, which makes the macro way less readable but
> always has the same result.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix off-by-one error
> ---
>   include/linux/dma-mapping.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 75e60be91e5f..9e438fe6b130 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -138,7 +138,8 @@ struct dma_map_ops {
>   extern const struct dma_map_ops dma_virt_ops;
>   extern const struct dma_map_ops dma_dummy_ops;
>   
> -#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> +#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)

I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter 
in most cases, but it could potentially happen at runtime where callers 
use a non-constant argument. However, it also means we don't need to 
special-case 64 any more (since that's there to avoid the same thing 
anyway), so we could simply flip that to handle 0 instead.

FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)", 
but that may not be to everyone's taste.

Robin.

>   
>   #define DMA_MASK_NONE	0x0ULL
>   
> 
