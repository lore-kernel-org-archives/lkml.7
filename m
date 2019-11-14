Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36FCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56D420409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfKNJt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:49:28 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:46838 "EHLO
        15.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:49:27 -0500
X-Greylist: delayed 2191 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 04:49:26 EST
Received: from player773.ha.ovh.net (unknown [10.109.146.5])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 37B2F1EC35B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:12:54 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id 9889BC17ABBB;
        Thu, 14 Nov 2019 09:12:31 +0000 (UTC)
Date:   Thu, 14 Nov 2019 11:12:30 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andi Shyti <andi@etezian.org>, linus.walleij@linaro.org,
        kgene@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-msm@vger.kernel.org, radu_nicolae.pirea@upb.ro,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        agross@kernel.org, ldewangan@nvidia.com, broonie@kernel.org,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Message-ID: <20191114091230.GB1249@jack.zhora.eu>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
 <20191113234049.GA1249@jack.zhora.eu>
 <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Ovh-Tracer-Id: 1915718693274174139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucfkpheptddrtddrtddrtddpkedurddujeehrddvvdefrdduudeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> >>  	if (!is_polling(sdd)) {
> >>  		/* Acquire DMA channels */
> >> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
> >> -								  "rx");
> >> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
> > 
> > I have a little concern here. We have two funcions
> > 'dma_request_chan' and  'dma_request_channel' don't we end up
> > making some confusion here?
> > 
> > Wouldn't it make more sense renaming 'dma_request_chan' to
> > 'dma_request_slave_channel_reason'?
> 
> The dma_request_channel() should go away. It was the old API before we
> got the dma_slave_map for non DT (and non ACPI) platforms so we can get
> rid of the filter function exports from DMA drivers to clients all over
> the place.

Yes, I agree... thanks!

Acked-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
