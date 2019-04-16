Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D3EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E6820870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfDPIbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:31:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57456 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728813AbfDPIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:31:12 -0400
X-UUID: 5df338e4de03445c83484615e20fe0b2-20190416
X-UUID: 5df338e4de03445c83484615e20fe0b2-20190416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 881612881; Tue, 16 Apr 2019 16:30:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:30:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:30:56 +0800
Message-ID: <1555403456.11519.10.camel@mtksdaap41>
Subject: Re: [PATCH v2 23/25] drm/mediatek: add vmap support for mediatek drm
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Tue, 16 Apr 2019 16:30:56 +0800
In-Reply-To: <1553667561-25447-24-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-24-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add add vmap support for mediatek drm

I think the upstreamed patch 'drm/mediatek: Implement gem prime
vmap/vunmap function' [1] has the same function of this patch. You could
cherry-pick that patch to your local and need not to upstream this
patch.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?h=v5.1-rc5&id=3df64d7b0a4f70f1797f23cfd4cca5c4d48131fe

Regards,
CK

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 7 +++++++
>  drivers/gpu/drm/mediatek/mtk_drm_gem.h | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 84c6626..942789d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -370,6 +370,7 @@ static void mtk_drm_kms_deinit(struct drm_device *drm)
>  	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
>  	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
>  	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
> +	.gem_prime_vmap = mtk_drm_gem_vmap_buf,
>  	.fops = &mtk_drm_fops,
>  
>  	.name = DRIVER_NAME,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index 259b7b0..c230237 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -165,6 +165,13 @@ int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  	return mtk_drm_gem_object_mmap(obj, vma);
>  }
>  
> +void *mtk_drm_gem_vmap_buf(struct drm_gem_object *obj)
> +{
> +	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
> +
> +	return mtk_gem->cookie;
> +}
> +
>  int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct drm_gem_object *obj;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
> index 534639b..3c48af9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
> @@ -49,6 +49,7 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
>  int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>  int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj,
>  			 struct vm_area_struct *vma);
> +void *mtk_drm_gem_vmap_buf(struct drm_gem_object *obj);
>  struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj);
>  struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
>  			struct dma_buf_attachment *attach, struct sg_table *sg);


