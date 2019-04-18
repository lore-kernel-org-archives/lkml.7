Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE5C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED092183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfDRBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:39:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbfDRBj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:39:59 -0400
X-UUID: ba91d1cd0352424a931e4fd900476379-20190418
X-UUID: ba91d1cd0352424a931e4fd900476379-20190418
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1501483083; Thu, 18 Apr 2019 09:39:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Apr 2019 09:39:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 09:39:44 +0800
Message-ID: <1555551584.2407.10.camel@mtksdaap41>
Subject: Re: [PATCH v2 04/15] [media] mtk-mipicsi: add color format support
 for mt2712
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 18 Apr 2019 09:39:44 +0800
In-Reply-To: <1555407015-18130-5-git-send-email-stu.hsieh@mediatek.com>
References: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
         <1555407015-18130-5-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Tue, 2019-04-16 at 17:30 +0800, Stu Hsieh wrote:
> This patch add color format support for mt2712

Without this patch, I think this driver still support these color
format. In this patch, you just check for the non-supported color
format.

Regards,
CK

> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> index ec4f6b503b32..16f6bc480f4e 100644
> --- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> +++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> @@ -138,6 +138,20 @@ static void mtk_mipicsi_remove_device(struct soc_camera_device *icd)
>  	(void)pm_runtime_put_sync(icd->parent);
>  }
>  
> +static bool is_supported(const u32 pixformat)
> +{
> +	switch (pixformat) {
> +	/* YUV422 */
> +	case V4L2_PIX_FMT_YUYV:
> +	case V4L2_PIX_FMT_UYVY:
> +	case V4L2_PIX_FMT_YVYU:
> +	case V4L2_PIX_FMT_VYUY:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
>  				struct v4l2_format *f)
>  {
> @@ -153,6 +167,12 @@ static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
>  	struct v4l2_mbus_framefmt *mf = &format.format;
>  	int ret = 0;
>  
> +	if (!is_supported(pix->pixelformat)) {
> +		dev_err(dev, "Format %x not support. set V4L2_PIX_FMT_YUYV as default\n",
> +			pix->pixelformat);
> +		pix->pixelformat = V4L2_PIX_FMT_YUYV;
> +	}
> +
>  	xlate = soc_camera_xlate_by_fourcc(icd, pix->pixelformat);
>  	if (xlate == NULL) {
>  		dev_err(dev, "Format 0x%x not found\n", pix->pixelformat);


