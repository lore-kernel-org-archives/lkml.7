Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7642C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F9A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDCENd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:13:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDCENc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:13:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [10.3.19.207])
        by Forcepoint Email with ESMTP id 747E04DAD2D1D8C0BC33;
        Wed,  3 Apr 2019 12:13:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 12:13:28 +0800
Subject: Re: [PATCH] ASoC: Mediatek: MT8183: Fix build error in
 mt8183_da7219_max98357_dev_probe
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <shunli.wang@mediatek.com>
References: <20190403041128.1900-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <alsa-devel@alsa-project.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5a3cde15-1d33-a67e-2a82-72b0edb099e6@huawei.com>
Date:   Wed, 3 Apr 2019 12:13:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190403041128.1900-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this.

On 2019/4/3 12:11, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
> gcc warn this:
> 
> sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c: In function mt8183_mt6358_ts3a227_max98357_dev_probe:
> sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:325:13: error: struct snd_soc_dai_link has no member named platform; did you mean platforms?
>    dai_link->platform = NULL;
>              ^~~~~~~~
>              platforms
> 
> use 'dai_link->platforms' instead of 'dai_link->platform'.
> 
> Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> index 9353665..1e7e8ae 100644
> --- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> +++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> @@ -410,7 +410,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
>  		 * the "platform" will not null when probe is trying
>  		 * again. It's not expected normally.
>  		 */
> -		dai_link->platform = NULL;
> +		dai_link->platforms = NULL;
>  
>  		if (dai_link->platform_name)
>  			continue;
> 

