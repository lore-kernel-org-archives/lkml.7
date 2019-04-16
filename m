Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3A2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfDPILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:11:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53391 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbfDPILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:11:55 -0400
X-UUID: 85fb53ff82c14d0abe05358bcba75402-20190416
X-UUID: 85fb53ff82c14d0abe05358bcba75402-20190416
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1486577775; Tue, 16 Apr 2019 16:11:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 16 Apr
 2019 16:11:43 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:11:42 +0800
Message-ID: <1555402302.18628.17.camel@mhfsdcap03>
Subject: Re: [PATCH 2/5] mmc: mtk-sd: don't hard-code interrupt trigger type
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     NeilBrown <neil@brown.name>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thirtythreeforty@gmail.com>
Date:   Tue, 16 Apr 2019 16:11:42 +0800
In-Reply-To: <155539004923.25108.12499096383277776864.stgit@noble.brown>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
         <155539004923.25108.12499096383277776864.stgit@noble.brown>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 80F027BB97EB7CC69DBCF5923481919832701100AB31F82F878E200E23CCF39A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 14:47 +1000, NeilBrown wrote:
> When using devicetree for configuration, interrupt trigger type
> should be described in the dts file, not hard-coded in the C code.
> 
> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
> and so cannot be used with the current code.
> 
> So remove the trigger and leave it to be set from devicetree.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/mmc/host/mtk-sd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4492a4465c0e..14e048239143 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2243,7 +2243,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	msdc_init_hw(host);
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> +
change it to IRQF_TRIGGER_NONE | IRQF_ONESHOT
> 			       0, pdev->name, host);
>  	if (ret)
>  		goto release;
>  
> 
> 


