Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AB52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfDPFm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:42:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15005 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726214AbfDPFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:42:53 -0400
X-UUID: 6a5de33b1324443387f32beb53f9b6db-20190416
X-UUID: 6a5de33b1324443387f32beb53f9b6db-20190416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1690920456; Tue, 16 Apr 2019 13:42:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 13:42:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 13:42:44 +0800
Message-ID: <1555393364.9968.2.camel@mtksdccf07>
Subject: Re: [PATCH 03/14] [media] mtk-mipicsi: add color format support for
 mt2712
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Date:   Tue, 16 Apr 2019 13:42:44 +0800
In-Reply-To: <1554790709.10331.6.camel@mtksdaap41>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
         <1554724505-19882-4-git-send-email-stu.hsieh@mediatek.com>
         <1554790709.10331.6.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Tue, 2019-04-09 at 14:18 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Mon, 2019-04-08 at 19:54 +0800, Stu Hsieh wrote:
> > This patch add color format support for mt2712
> 
> Without this patch, I think this driver still support these color
> format. In this patch, you just check for the non-supported color
> format.
> 
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> > index a5ed720df900..ccf2d18a3e74 100644
> > --- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> > +++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> > @@ -139,6 +139,25 @@ static void mtk_mipicsi_remove_device(struct soc_camera_device *icd)
> >  	(void)pm_runtime_put_sync(icd->parent);
> >  }
> >  
> > +static bool is_supported(struct soc_camera_device *icd, const u32 pixformat)
> 
> icd is useless, so remove it.
> 
> > +{
> > +	bool ret = false;
> > +
> > +	switch (pixformat) {
> > +	/* YUV422 */
> > +	case V4L2_PIX_FMT_YUYV:
> > +	case V4L2_PIX_FMT_UYVY:
> > +	case V4L2_PIX_FMT_YVYU:
> > +	case V4L2_PIX_FMT_VYUY:
> > +		ret = true;
> 
> You could just return true.
> 
> > +		break;
> > +	default:
> > +		break;
> 
> You don't need the 'default' part.
> 
> > +	}
> > +
> > +	return ret;
> 
> You could just return false.
> 
> Regards,
> CK
> 

Ok, I would modify it in next version.

> > +}
> > +
> >  static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
> >  				struct v4l2_format *f)
> >  {
> > @@ -154,6 +173,12 @@ static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
> >  	struct v4l2_mbus_framefmt *mf = &format.format;
> >  	int ret = 0;
> >  
> > +	if (!is_supported(icd, pix->pixelformat)) {
> > +		dev_err(dev, "Format %x not support. set V4L2_PIX_FMT_YUYV as default\n",
> > +			pix->pixelformat);
> > +		pix->pixelformat = V4L2_PIX_FMT_YUYV;
> > +	}
> > +
> >  	xlate = soc_camera_xlate_by_fourcc(icd, pix->pixelformat);
> >  	if (xlate == NULL) {
> >  		dev_err(dev, "Format 0x%x not found\n", pix->pixelformat);
> 
> 


