Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571DC282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDHDy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:54:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20569 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbfDHDy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:54:58 -0400
X-UUID: a8c593d377d1474b952a3f3ff46f9f96-20190408
X-UUID: a8c593d377d1474b952a3f3ff46f9f96-20190408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1040451129; Mon, 08 Apr 2019 11:54:49 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 11:54:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 11:54:42 +0800
Message-ID: <1554695682.25248.2.camel@mtksdaap41>
Subject: Re: [PATCH V8 3/5] drm/mediatek: using new factor for tvdpll in
 MT2701
From:   CK Hu <ck.hu@mediatek.com>
To:     wangyan wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Date:   Mon, 8 Apr 2019 11:54:42 +0800
In-Reply-To: <20190402093605.82004-4-wangyan.wang@mediatek.com>
References: <20190402093605.82004-1-wangyan.wang@mediatek.com>
         <20190402093605.82004-4-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wangyan:

On Tue, 2019-04-02 at 17:36 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> This is the second step to make MT2701 HDMI stable.
> The factor depends on the divider of DPI in MT2701, therefore,
> we should fix this factor to the right and new one.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 69c6e42dad6b..4a2f4a650494 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -662,13 +662,11 @@ static unsigned int mt8173_calculate_factor(int clock)
>  static unsigned int mt2701_calculate_factor(int clock)
>  {
>  	if (clock <= 64000)
> -		return 16;
> -	else if (clock <= 128000)
> -		return 8;
> -	else if (clock <= 256000)
>  		return 4;
> -	else
> +	else if (clock <= 128000)
>  		return 2;
> +	else
> +		return 1;
>  }
>  
>  static const struct mtk_dpi_conf mt8173_conf = {


