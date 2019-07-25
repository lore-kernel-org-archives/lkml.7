Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51012C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6A22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbfGYPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:37:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37795 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389301AbfGYPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:36:59 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hqfnQ-0001bw-8U; Thu, 25 Jul 2019 17:36:44 +0200
Message-ID: <1564069001.3006.1.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/7] media: hantro: Set DMA max segment size
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 25 Jul 2019 17:36:41 +0200
In-Reply-To: <20190725141756.2518-2-ezequiel@collabora.com>
References: <20190725141756.2518-1-ezequiel@collabora.com>
         <20190725141756.2518-2-ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 11:17 -0300, Ezequiel Garcia wrote:
> From: Francois Buergisser <fbuergisser@chromium.org>
> 
> The Hantro codec is typically used in platforms with an IOMMU,
> so we need to set a proper DMA segment size.

... to make sure the DMA-mapping subsystem produces contiguous mappings?

> Devices without an
> IOMMU will still fallback to default 64KiB segments.

I don't understand this comment. The default max_seg_size may be 64 KiB,
but if we are always setting it to DMA_BUT_MASK(32), there is no falling
back.

> Cc: stable@vger.kernel.org
> Fixes: 775fec69008d3 ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Francois Buergisser <fbuergisser@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index b71a06e9159e..4eae1dbb1ac8 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -731,6 +731,7 @@ static int hantro_probe(struct platform_device *pdev)
>  		dev_err(vpu->dev, "Could not set DMA coherent mask.\n");
>  		return ret;
>  	}
> +	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));

This should be complemented by a call to
vb2_dma_contig_clear_max_seg_size() in _remove,
to avoid leaking dev->dma_parms.

>  
>  	for (i = 0; i < vpu->variant->num_irqs; i++) {
>  		const char *irq_name = vpu->variant->irqs[i].name;

regards
Philipp
