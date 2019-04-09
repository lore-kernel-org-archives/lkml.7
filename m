Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C493C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C9120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDIFQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:16:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4407 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbfDIFQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:16:41 -0400
X-UUID: aa2acfe69a0041efb731e51f630df759-20190409
X-UUID: aa2acfe69a0041efb731e51f630df759-20190409
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 872247550; Tue, 09 Apr 2019 13:16:07 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Apr 2019 13:15:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Apr 2019 13:15:59 +0800
Message-ID: <1554786959.336.1.camel@mtksdaap41>
Subject: Re: [PATCH 1/7] drm/mediatek: fix possible object reference leak
From:   CK Hu <ck.hu@mediatek.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
CC:     <linux-kernel@vger.kernel.org>, <wang.yi59@zte.com.cn>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 9 Apr 2019 13:15:59 +0800
In-Reply-To: <1554307455-40361-2-git-send-email-wen.yang99@zte.com.cn>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
         <1554307455-40361-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 6C3628861AC26213B58C9F255F10F5CB456356F772F5AF5FB2C22EA78C8C0EF12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wen:

On Thu, 2019-04-04 at 00:04 +0800, Wen Yang wrote:
> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/mediatek/mtk_hdmi.c:1521:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1509, but without a corresponding object release within this function.
> drivers/gpu/drm/mediatek/mtk_hdmi.c:1524:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1509, but without a corresponding object release within this function.

For this patch, applied to mediatek-drm-fixes-5.1 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.1

Regards,
CK

> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 915cc84..ed10f4d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1516,6 +1516,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
>  	of_node_put(remote);
>  
>  	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
> +	of_node_put(i2c_np);
>  	if (!hdmi->ddc_adpt) {
>  		dev_err(dev, "Failed to get ddc i2c adapter by node\n");
>  		return -EINVAL;


