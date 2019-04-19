Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5ACC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A9321736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDSDwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:52:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3374 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727159AbfDSDwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:52:15 -0400
X-UUID: bd26d3df69664dd386ea419e77e24e48-20190419
X-UUID: bd26d3df69664dd386ea419e77e24e48-20190419
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1011604904; Fri, 19 Apr 2019 11:52:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Apr 2019 11:52:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Apr 2019 11:52:07 +0800
Message-ID: <1555645927.24433.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 05/15] [media] mtk-mipicsi: get the w/h/bytepwerline
 for mtk_mipicsi
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
Date:   Fri, 19 Apr 2019 11:52:07 +0800
In-Reply-To: <1555407015-18130-6-git-send-email-stu.hsieh@mediatek.com>
References: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
         <1555407015-18130-6-git-send-email-stu.hsieh@mediatek.com>
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
> This patch get the w/h/bytepwerline to save in mtk_mipicsi.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> index 16f6bc480f4e..10782fccca79 100644
> --- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> +++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> @@ -99,6 +99,9 @@ struct mtk_mipicsi_dev {
>  	u32 id;
>  	int clk_num;
>  	struct clk		*clk[MIPICSI_CLK];
> +	u32 width;
> +	u32 height;
> +	u32 bytesperline;
>  };
>  
>  #define MTK_MIPICSI_BUS_PARAM (V4L2_MBUS_MASTER |	\
> @@ -110,13 +113,36 @@ struct mtk_mipicsi_dev {
>  		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
>  		V4L2_MBUS_DATA_ACTIVE_HIGH)
>  
> +static u32 get_bytesperline(const u32 fmt, const u32 width)
> +{
> +	u32 bytesperline = 0;
> +
> +	switch (fmt) {
> +	case MEDIA_BUS_FMT_UYVY8_2X8:
> +	case MEDIA_BUS_FMT_VYUY8_2X8:
> +	case MEDIA_BUS_FMT_YUYV8_2X8:
> +	case MEDIA_BUS_FMT_YVYU8_2X8:
> +		bytesperline = width * 2U;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return bytesperline;
> +}
> +
>  static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
>  {
> +	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
> +	struct mtk_mipicsi_dev *mipicsi = ici->priv;
>  	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
>  	struct v4l2_subdev_format format = {
>  		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>  	};
>  	int ret;
> +	u32 width;
> +	u32 height;
> +	u32 fmt;
>  
>  	/* Get width/height info from subdev. Then use them to set register */
>  	ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &format);
> @@ -125,6 +151,19 @@ static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
>  		return ret;
>  	}
>  
> +	width = format.format.width;
> +	height = format.format.height;
> +	fmt = format.format.code;
> +	mipicsi->bytesperline = get_bytesperline(fmt, width);
> +	if ((width == 0U) || (height == 0U) || (mipicsi->bytesperline == 0U)) {

You could check more completely, for example, if the valid range of width is 1 ~ 4095, you could check as:

#define WIDTH_MIN 1
#define WIDTH_MAX 4095

if ((width < WIDTH_MIN) || (width > WIDTH_MAX)) {
	/* invalid value */
}

Regards,
CK

> +		dev_err(icd->parent, "invalid sub device width/height/bytesperline %d/%d/%d\n",
> +			width, height, mipicsi->bytesperline);
> +		return -EINVAL;
> +	}
> +
> +	mipicsi->width = width;
> +	mipicsi->height = height;
> +
>  	/*
>  	 * If power domain was closed before, it will be open.
>  	 * Then clock will be open and register will be set



