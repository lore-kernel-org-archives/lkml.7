Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917DCC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597E1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfDRGhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:37:05 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18838 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfDRGhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:37:05 -0400
X-UUID: ad0c928957464d4d901387e7b541e7ea-20190418
X-UUID: ad0c928957464d4d901387e7b541e7ea-20190418
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1571008641; Thu, 18 Apr 2019 14:36:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Apr
 2019 14:36:53 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 14:36:53 +0800
Message-ID: <1555569412.18628.27.camel@mhfsdcap03>
Subject: Re: [PATCH 2/5] mmc: mtk-sd: don't hard-code interrupt trigger type
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     NeilBrown <neil@brown.name>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thirtythreeforty@gmail.com>
Date:   Thu, 18 Apr 2019 14:36:52 +0800
In-Reply-To: <878sw97g6r.fsf@notabene.neil.brown.name>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
         <155539004923.25108.12499096383277776864.stgit@noble.brown>
         <1555402302.18628.17.camel@mhfsdcap03>
         <878sw97g6r.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 08:12 +1000, NeilBrown wrote:
> On Tue, Apr 16 2019, Chaotian Jing wrote:
> 
> > On Tue, 2019-04-16 at 14:47 +1000, NeilBrown wrote:
> >> When using devicetree for configuration, interrupt trigger type
> >> should be described in the dts file, not hard-coded in the C code.
> >> 
> >> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
> >> and so cannot be used with the current code.
> >> 
> >> So remove the trigger and leave it to be set from devicetree.
> >> 
> >> Signed-off-by: NeilBrown <neil@brown.name>
> >> ---
> >>  drivers/mmc/host/mtk-sd.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> >> index 4492a4465c0e..14e048239143 100644
> >> --- a/drivers/mmc/host/mtk-sd.c
> >> +++ b/drivers/mmc/host/mtk-sd.c
> >> @@ -2243,7 +2243,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >>  	msdc_init_hw(host);
> >>  
> >>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> >> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> >> +
> > change it to IRQF_TRIGGER_NONE | IRQF_ONESHOT
> 
> Why do we need IRQF_ONESHOT.  That is for threaded interrupted
> handlers...
> msdc_irq() clears the interrupts, so ONESHOT isn't needed.
> 
> ???
> 
> NeilBrown
> 
> 
I just want to change it to IRQF_TRIGGER_NONE, Since IRQF_TRIGGER_NONE
is defined as 0, it's ok to use 0 instead of it.
> >> 			       0, pdev->name, host);
> >>  	if (ret)
> >>  		goto release;
> >>  
> >> 
> >> 


