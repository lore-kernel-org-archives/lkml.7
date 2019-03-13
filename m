Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90075C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8812183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCMJZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:25:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60860 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbfCMJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:25:18 -0400
X-UUID: a573d73afd474bb6b340500aec94ce18-20190313
X-UUID: a573d73afd474bb6b340500aec94ce18-20190313
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1622792869; Wed, 13 Mar 2019 17:25:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Mar
 2019 17:25:07 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Mar 2019 17:25:06 +0800
Message-ID: <1552469107.7433.21.camel@mhfsdcap03>
Subject: Re: [PATCH v6 12/22] memory: mtk-smi: Add gals support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Date:   Wed, 13 Mar 2019 17:25:07 +0800
In-Reply-To: <1550394300-17420-13-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
         <1550394300-17420-13-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

A gentle ping for all the smi part here.
From Joerg, your review is expected before he apply.

Thanks in advance.

On Sun, 2019-02-17 at 17:04 +0800, Yong Wu wrote:
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
> 
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
> 
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
> 
> This is also a preparing patch for mt8183 which has GALS.
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 8a2f968..91634d7 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -56,6 +56,7 @@ enum mtk_smi_gen {
>  
>  struct mtk_smi_common_plat {
>  	enum mtk_smi_gen gen;
> +	bool             has_gals;
>  };
>  
>  struct mtk_smi_larb_gen {
> @@ -63,11 +64,13 @@ struct mtk_smi_larb_gen {
>  	int port_in_larb[MTK_LARB_NR_MAX + 1];
>  	void (*config_port)(struct device *);
>  	unsigned int larb_direct_to_common_mask;
> +	bool             has_gals;
>  };
>  
>  struct mtk_smi {
>  	struct device			*dev;
>  	struct clk			*clk_apb, *clk_smi;
> +	struct clk			*clk_gals0, *clk_gals1;
>  	struct clk			*clk_async; /*only needed by mt2701*/
>  	void __iomem			*smi_ao_base;
>  
> @@ -99,8 +102,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  	if (ret)
>  		goto err_disable_apb;
>  
> +	ret = clk_prepare_enable(smi->clk_gals0);
> +	if (ret)
> +		goto err_disable_smi;
> +
> +	ret = clk_prepare_enable(smi->clk_gals1);
> +	if (ret)
> +		goto err_disable_gals0;
> +
>  	return 0;
>  
> +err_disable_gals0:
> +	clk_disable_unprepare(smi->clk_gals0);
> +err_disable_smi:
> +	clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>  	clk_disable_unprepare(smi->clk_apb);
>  err_put_pm:
> @@ -110,6 +125,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  
>  static void mtk_smi_disable(const struct mtk_smi *smi)
>  {
> +	clk_disable_unprepare(smi->clk_gals1);
> +	clk_disable_unprepare(smi->clk_gals0);
>  	clk_disable_unprepare(smi->clk_smi);
>  	clk_disable_unprepare(smi->clk_apb);
>  	pm_runtime_put_sync(smi->dev);
> @@ -310,6 +327,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	larb->smi.clk_smi = devm_clk_get(dev, "smi");
>  	if (IS_ERR(larb->smi.clk_smi))
>  		return PTR_ERR(larb->smi.clk_smi);
> +
> +	if (larb->larb_gen->has_gals) {
> +		/* The larbs may still haven't gals even if the SoC support.*/
> +		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
> +		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> +			larb->smi.clk_gals0 = NULL;
> +		else if (IS_ERR(larb->smi.clk_gals0))
> +			return PTR_ERR(larb->smi.clk_gals0);
> +	}
>  	larb->smi.dev = dev;
>  
>  	if (larb->larb_gen->need_larbid) {
> @@ -402,6 +428,16 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> +	if (common->plat->has_gals) {
> +		common->clk_gals0 = devm_clk_get(dev, "gals0");
> +		if (IS_ERR(common->clk_gals0))
> +			return PTR_ERR(common->clk_gals0);
> +
> +		common->clk_gals1 = devm_clk_get(dev, "gals1");
> +		if (IS_ERR(common->clk_gals1))
> +			return PTR_ERR(common->clk_gals1);
> +	}
> +
>  	/*
>  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
>  	 * m4u port, and we need to enable the aync clock for transform the smi


