Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D66C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85F72070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfE1FgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:36:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2077 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfE1FgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:36:12 -0400
X-UUID: 431b29fe870c431c9b09dc0979a77c29-20190528
X-UUID: 431b29fe870c431c9b09dc0979a77c29-20190528
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1074673266; Tue, 28 May 2019 13:36:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 28 May 2019 13:35:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 13:35:59 +0800
Message-ID: <1559021759.15879.2.camel@mtksdaap41>
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
Date:   Tue, 28 May 2019 13:35:59 +0800
In-Reply-To: <1555403634.11519.11.camel@mtksdaap41>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-25-git-send-email-yongqiang.niu@mediatek.com>
         <1555403634.11519.11.camel@mtksdaap41>
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

On Tue, 2019-04-16 at 16:33 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > Respect page offset for PRIME mmap calls
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>


This patch looks independent, so I've applied it to
mediatek-drm-fixes-5.2 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.2

Regards,
CK

> 
> > 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > index c230237..524e494 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > @@ -144,7 +144,6 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
> >  	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
> >  	 */
> >  	vma->vm_flags &= ~VM_PFNMAP;
> > -	vma->vm_pgoff = 0;
> >  
> >  	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
> >  			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
> > @@ -183,6 +182,12 @@ int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> >  
> >  	obj = vma->vm_private_data;
> >  
> > +	/*
> > +	 * Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
> > +	 * whole buffer from the start.
> > +	 */
> > +	vma->vm_pgoff = 0;
> > +
> >  	return mtk_drm_gem_object_mmap(obj, vma);
> >  }
> >  
> 


