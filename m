Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307AB21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfIBKu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:50:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfIBKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:50:58 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i4jv5-0007oW-At; Mon, 02 Sep 2019 12:50:47 +0200
Message-ID: <76f25b70dd874c49c861a812384391c87240f5e7.camel@pengutronix.de>
Subject: Re: [PATCH -next] drm/etnaviv: fix missing unlock on error in
 etnaviv_iommuv1_context_alloc()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 02 Sep 2019 12:50:44 +0200
In-Reply-To: <20190819061733.50023-1-weiyongjun1@huawei.com>
References: <20190819061733.50023-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-08-19 at 06:17 +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function
> etnaviv_iommuv1_context_alloc()
> in the error handling case.
> 
> Fixes: 27b67278e007 ("drm/etnaviv: rework MMU handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied.

For my education, can you tell me which tool you did use to catch this
issue?

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
> b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
> index aac8dbf3ea56..1a7c89a67bea 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
> @@ -140,8 +140,10 @@ etnaviv_iommuv1_context_alloc(struct
> etnaviv_iommu_global *global)
>  	}
>  
>  	v1_context = kzalloc(sizeof(*v1_context), GFP_KERNEL);
> -	if (!v1_context)
> +	if (!v1_context) {
> +		mutex_unlock(&global->lock);
>  		return NULL;
> +	}
>  
>  	v1_context->pgtable_cpu = dma_alloc_wc(global->dev, PT_SIZE,
>  					       &v1_context-
> >pgtable_dma,
> 
> 
> 

