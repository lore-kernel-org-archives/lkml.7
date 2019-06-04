Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F5CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C497420665
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFDM0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:26:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:15625 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbfFDM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:26:51 -0400
X-UUID: e64f5e4932bb49efa567b16a9c3a2533-20190604
X-UUID: e64f5e4932bb49efa567b16a9c3a2533-20190604
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 404720184; Tue, 04 Jun 2019 20:26:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Jun
 2019 20:26:41 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 20:26:40 +0800
Message-ID: <1559651200.5871.2.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] i3c: master: Add driver for MediaTek IP
From:   Qii Wang <qii.wang@mediatek.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     <bbrezillon@kernel.org>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <gregkh@linuxfoundation.org>, <xinping.qian@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <liguo.zhang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <linux-i3c@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 4 Jun 2019 20:26:40 +0800
In-Reply-To: <20190604095858.38ed9a28@collabora.com>
References: <1559533863-10292-1-git-send-email-qii.wang@mediatek.com>
         <1559533863-10292-3-git-send-email-qii.wang@mediatek.com>
         <20190604095858.38ed9a28@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 09:58 +0200, Boris Brezillon wrote:
> On Mon, 3 Jun 2019 11:51:03 +0800
> Qii Wang <qii.wang@mediatek.com> wrote:
> 
> 
> > +static int mtk_i3c_master_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mtk_i3c_master *master;
> > +	struct resource *res;
> > +	int ret, irqnr;
> > +
> > +	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> > +	if (!master)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "main");
> > +	master->regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(master->regs))
> > +		return PTR_ERR(master->regs);
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
> > +	master->dma_regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(master->dma_regs))
> > +		return PTR_ERR(master->dma_regs);
> > +
> > +	irqnr = platform_get_irq(pdev, 0);
> > +	if (irqnr < 0)
> > +		return irqnr;
> > +
> > +	ret = devm_request_irq(dev, irqnr, mtk_i3c_master_irq,
> > +			       IRQF_TRIGGER_NONE, DRV_NAME, master);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Request I3C IRQ %d fail\n", irqnr);
> > +		return ret;
> > +	}
> > +
> > +	ret = of_property_read_u32(pdev->dev.of_node, "clock-div",
> > +				   &master->clk_src_div);
> 
> You say in one comment that this clock divider is fixed in HW but might
> change on a per-SoC basis. If that's the case, you should get rid of
> this clock-div prop and attach the divider to the compatible (using an
> mtk_i3c_master_variant struct that contains a divider field).
> 

ok, I will attach the divider to the compatible.

> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	spin_lock_init(&master->xferqueue.lock);
> > +	INIT_LIST_HEAD(&master->xferqueue.list);
> > +
> > +	if (dma_set_mask(dev, DMA_BIT_MASK(33))) {
> > +		dev_err(dev, "dma_set_mask return error.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	master->clk_main = devm_clk_get(dev, "main");
> > +	if (IS_ERR(master->clk_main)) {
> > +		dev_err(dev, "cannot get main clock\n");
> > +		return PTR_ERR(master->clk_main);
> > +	}
> > +	master->clk_dma = devm_clk_get(dev, "dma");
> > +	if (IS_ERR(master->clk_dma)) {
> > +		dev_err(dev, "cannot get dma clock\n");
> > +		return PTR_ERR(master->clk_dma);
> > +	}
> > +
> > +	master->clk_arb = devm_clk_get_optional(dev, "arb");
> > +	if (IS_ERR(master->clk_arb))
> > +		return PTR_ERR(master->clk_arb);
> > +
> > +	ret = mtk_i3c_master_clock_enable(master);
> > +	if (ret) {
> > +		dev_err(dev, "clock enable failed!\n");
> > +		return ret;
> > +	}
> > +
> > +	master->dev = dev;
> > +	platform_set_drvdata(pdev, master);
> > +
> > +	ret = i3c_master_register(&master->mas_ctrler, dev,
> > +				  &mtk_i3c_master_ops, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add i3c bus to i3c core\n");
> > +		mtk_i3c_master_clock_disable(master);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}


