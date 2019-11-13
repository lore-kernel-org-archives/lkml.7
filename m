Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF7C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C62206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMXlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:41:16 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:56702 "EHLO
        7.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMXlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:41:15 -0500
Received: from player758.ha.ovh.net (unknown [10.109.160.244])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id A627A1B028A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:41:13 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 17468C1C43CF;
        Wed, 13 Nov 2019 23:40:50 +0000 (UTC)
Date:   Thu, 14 Nov 2019 01:40:49 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, radu_nicolae.pirea@upb.ro, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linus.walleij@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, andi@etezian.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vkoul@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Message-ID: <20191113234049.GA1249@jack.zhora.eu>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Ovh-Tracer-Id: 10707589591967711931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefvddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucfkpheptddrtddrtddrtddpkedurddujeehrddvvdefrdduudeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>  	if (!is_polling(sdd)) {
>  		/* Acquire DMA channels */
> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
> -								  "rx");
> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");

I have a little concern here. We have two funcions
'dma_request_chan' and  'dma_request_channel' don't we end up
making some confusion here?

Wouldn't it make more sense renaming 'dma_request_chan' to
'dma_request_slave_channel_reason'?

Thanks,
Andi
