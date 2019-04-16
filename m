Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7CD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfDPFoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:44:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbfDPFoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:44:17 -0400
X-UUID: f43c2010b0de4475a6dcd785ecfc5498-20190416
X-UUID: f43c2010b0de4475a6dcd785ecfc5498-20190416
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 203164711; Tue, 16 Apr 2019 13:44:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 13:44:03 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 13:44:03 +0800
Message-ID: <1555393443.9968.3.camel@mtksdccf07>
Subject: Re: [PATCH 01/14] [media] mtk-mipicsi: add mediatek mipicsi driver
 for mt2712
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Date:   Tue, 16 Apr 2019 13:44:03 +0800
In-Reply-To: <1554790363.10331.1.camel@mtksdaap41>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
         <1554724505-19882-2-git-send-email-stu.hsieh@mediatek.com>
         <1554790363.10331.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Tue, 2019-04-09 at 14:12 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Mon, 2019-04-08 at 19:54 +0800, Stu Hsieh wrote:
> > This patch add mediatek mipicsi driver for mt2712,
> > including probe function to get the value from device tree,
> > and register to v4l2 the host device.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/media/platform/mtk-mipicsi/Makefile   |   4 +
> >  .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 768 ++++++++++++++++++
> >  2 files changed, 772 insertions(+)
> >  create mode 100644 drivers/media/platform/mtk-mipicsi/Makefile
> >  create mode 100644 drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> > 
> 
> [snip]
> 
> > +
> > +static const struct of_device_id mtk_mipicsi_of_match[] = {
> > +	{ .compatible = "mediatek,mt2712-mipicsi", },
> 
> Where is the binding document of "mediatek,mt2712-mipicsi"?
> 
> Regards,
> CK
> 

I would add this bindind document in next version

Regards,
Stu

> > +	{},
> > +};
> > +
> > +static struct platform_driver mtk_mipicsi_driver = {
> > +	.driver		= {
> > +		.name	= MTK_MIPICSI_DRV_NAME,
> > +		.of_match_table = of_match_ptr(mtk_mipicsi_of_match),
> > +	},
> > +	.probe		= mtk_mipicsi_probe,
> > +	.remove		= mtk_mipicsi_remove,
> > +};
> > +
> > +module_platform_driver(mtk_mipicsi_driver);
> > +MODULE_DESCRIPTION("MediaTek SoC Camera Host driver");
> > +MODULE_LICENSE("GPL v2");
> 
> 


