Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29637C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfDPIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:34:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11319 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727828AbfDPIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:34:13 -0400
X-UUID: 55b67e42df5e4227af8934dba0cfd7ff-20190416
X-UUID: 55b67e42df5e4227af8934dba0cfd7ff-20190416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 943493924; Tue, 16 Apr 2019 16:33:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:33:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:33:54 +0800
Message-ID: <1555403634.11519.11.camel@mtksdaap41>
Subject: Re: [PATCH v2 24/25] drm/mediatek: respect page offset for PRIME
 mmap calls
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Tue, 16 Apr 2019 16:33:54 +0800
In-Reply-To: <1553667561-25447-25-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-25-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 63D5F2FFE5D5D105423AA4BF92CA0A03CB4FA5473FC075292571F951F3F39EF82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Respect page offset for PRIME mmap calls

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index c230237..524e494 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -144,7 +144,6 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
>  	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
>  	 */
>  	vma->vm_flags &= ~VM_PFNMAP;
> -	vma->vm_pgoff = 0;
>  
>  	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
>  			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
> @@ -183,6 +182,12 @@ int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	obj = vma->vm_private_data;
>  
> +	/*
> +	 * Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
> +	 * whole buffer from the start.
> +	 */
> +	vma->vm_pgoff = 0;
> +
>  	return mtk_drm_gem_object_mmap(obj, vma);
>  }
>  


