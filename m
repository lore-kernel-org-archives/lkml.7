Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B8C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34BF21736
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfDVI7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:59:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52055 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbfDVI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:59:25 -0400
X-UUID: 06297fc90cdb44d286cbac5391cdd8bb-20190422
X-UUID: 06297fc90cdb44d286cbac5391cdd8bb-20190422
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2119209235; Mon, 22 Apr 2019 16:59:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Apr 2019 16:59:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Apr 2019 16:59:19 +0800
Message-ID: <1555923559.2854.14.camel@mtksdaap41>
Subject: Re: [PATCH v1 4/4] drm/mediatek: fix possible_crtcs
From:   YT Shen <yt.shen@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Date:   Mon, 22 Apr 2019 16:59:19 +0800
In-Reply-To: <20190416145848.11932-5-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
         <20190416145848.11932-5-frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,
On Tue, 2019-04-16 at 16:58 +0200, Frank Wunderlich wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> without this patch there is purple stretched font on fbconsole
> 
> source: http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/52
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 5d333138f913..c171b01f77e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -610,7 +610,7 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
> 
>  	/* Currently DPI0 is fixed to be driven by OVL1 */
> -	dpi->encoder.possible_crtcs = BIT(1);
> +	dpi->encoder.possible_crtcs = BIT(0)|BIT(1);
This patch is not a good solution.

The solution should find the components in the arrays to determine the
correct crtcs, not just set all available bits.  You see the problem
because the hardware connections(BIT0) is not the same as driver
reports(BIT1 changed to BIT0|BIT1, but BIT1 is not supported).

Regards,
yt.shen

> 
>  	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
>  	if (ret) {
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


