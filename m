Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D87C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E53214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFKM24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:28:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfFKM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:28:55 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C1223285914;
        Tue, 11 Jun 2019 13:28:52 +0100 (BST)
Date:   Tue, 11 Jun 2019 14:28:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     <bbrezillon@kernel.org>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <gregkh@linuxfoundation.org>, <xinping.qian@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <liguo.zhang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <linux-i3c@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] i3c: master: Add driver for MediaTek IP
Message-ID: <20190611142849.43f6d1e4@collabora.com>
In-Reply-To: <1560255922.12217.3.camel@mhfsdcap03>
References: <1559533863-10292-1-git-send-email-qii.wang@mediatek.com>
        <1559533863-10292-3-git-send-email-qii.wang@mediatek.com>
        <20190604095858.38ed9a28@collabora.com>
        <1559651200.5871.2.camel@mhfsdcap03>
        <1560255922.12217.3.camel@mhfsdcap03>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 20:25:22 +0800
Qii Wang <qii.wang@mediatek.com> wrote:

> On Tue, 2019-06-04 at 20:26 +0800, Qii Wang wrote:
> > On Tue, 2019-06-04 at 09:58 +0200, Boris Brezillon wrote:  
> > > On Mon, 3 Jun 2019 11:51:03 +0800
> > > Qii Wang <qii.wang@mediatek.com> wrote:
> > > 
> > >   
> > > > +static int mtk_i3c_master_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct mtk_i3c_master *master;
> > > > +	struct resource *res;
> > > > +	int ret, irqnr;
> > > > +
> > > > +	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> > > > +	if (!master)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "main");
> > > > +	master->regs = devm_ioremap_resource(dev, res);
> > > > +	if (IS_ERR(master->regs))
> > > > +		return PTR_ERR(master->regs);
> > > > +
> > > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
> > > > +	master->dma_regs = devm_ioremap_resource(dev, res);
> > > > +	if (IS_ERR(master->dma_regs))
> > > > +		return PTR_ERR(master->dma_regs);
> > > > +
> > > > +	irqnr = platform_get_irq(pdev, 0);
> > > > +	if (irqnr < 0)
> > > > +		return irqnr;
> > > > +
> > > > +	ret = devm_request_irq(dev, irqnr, mtk_i3c_master_irq,
> > > > +			       IRQF_TRIGGER_NONE, DRV_NAME, master);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "Request I3C IRQ %d fail\n", irqnr);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = of_property_read_u32(pdev->dev.of_node, "clock-div",
> > > > +				   &master->clk_src_div);  
> > > 
> > > You say in one comment that this clock divider is fixed in HW but might
> > > change on a per-SoC basis. If that's the case, you should get rid of
> > > this clock-div prop and attach the divider to the compatible (using an
> > > mtk_i3c_master_variant struct that contains a divider field).
> > >   
> > 
> > ok, I will attach the divider to the compatible.
> >   
> I have rechecked your comment, maybe I have misunderstood what you mean.
> "clock-div" changes according to i2c source clock, different project may
> change i2c source clock, The previous dt-binding may be misleading, I
> will modify it.

Is it fixed or configurable? Maybe it should be modeled as a clk
driver. What's for sure is that we shouldn't have this divider defined
in the DT.
