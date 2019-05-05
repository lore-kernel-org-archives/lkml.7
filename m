Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED5C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92C42082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEEHth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:49:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31256 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbfEEHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:49:36 -0400
X-UUID: 2cdd444e8eb048f2881cab579ad6db28-20190505
X-UUID: 2cdd444e8eb048f2881cab579ad6db28-20190505
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1544155296; Sun, 05 May 2019 15:49:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 5 May
 2019 15:49:19 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 May 2019 15:49:19 +0800
Message-ID: <1557042559.18628.34.camel@mhfsdcap03>
Subject: Re: [PATCH 2/4] mmc: mtk-sd: add support for config found in mt7620
 family SOCs.
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     NeilBrown <neil@brown.name>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thirtythreeforty@gmail.com>
Date:   Sun, 5 May 2019 15:49:19 +0800
In-Reply-To: <155696549676.8632.14384982012480111613.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549676.8632.14384982012480111613.stgit@noble.brown>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> mt7620 family MIPS SOCs contain the mtk-sd silicon.
> Add support for this.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 +
>  drivers/mmc/host/mtk-sd.c                        |   12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 91a2ec59e497..8a532f4453f2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -16,6 +16,7 @@ Required properties:
>  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>  	"mediatek,mt7622-mmc": for MT7622 SoC
>  	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
> +	"mediatek,mt7620-mmc", for MT7621 SoC (and others)
>  
>  - reg: physical base address of the controller and length
>  - interrupts: Should contain MSDC interrupt number
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 469d4a717175..0c2be4f54b1f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -517,6 +517,17 @@ static const struct mtk_mmc_compatible mt8516_compat = {
>  	.stop_clk_fix = true,
>  };
>  
> +static const struct mtk_mmc_compatible mt7620_compat = {
> +	.clk_div_bits = 8,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE,
> +	.async_fifo = false,
> +	.data_tune = false,
> +	.busy_check = false,
> +	.stop_clk_fix = false,
> +	.enhance_rx = false,
> +};
> +
>  static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>  	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> @@ -525,6 +536,7 @@ static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>  	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
>  	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
> +	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, msdc_of_ids);
> 
> 


