Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B6C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB8206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAHWFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:05:25 -0500
Received: from muru.com ([72.249.23.125]:50508 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHWFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:05:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B46DC80C5;
        Wed,  8 Jan 2020 22:06:04 +0000 (UTC)
Date:   Wed, 8 Jan 2020 14:05:20 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Colin King <colin.king@canonical.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
Message-ID: <20200108220520.GJ5885@atomide.com>
References: <20200106122325.39121-1-colin.king@canonical.com>
 <b7200998-c8e7-0841-ce91-ad3834c63cae@ti.com>
 <f6b24302-a90e-7aa5-b2e8-3c459e6d0598@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b24302-a90e-7aa5-b2e8-3c459e6d0598@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [200108 07:20]:
> Colin, Tony,
> 
> On 07/01/2020 13.59, Peter Ujfalusi wrote:
> > Colin,
> > 
> > On 06/01/2020 14.23, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Currently when the call to dev_get_platdata returns null the driver issues
> >> a warning and then later dereferences the null pointer.  Avoid this issue
> >> by returning -EPROBE_DEFER errror rather when the platform data is null.
> > 
> > Thank you for noticing it!
> > 
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> >> Addresses-Coverity: ("Dereference after null check")
> >> Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/dma/ti/omap-dma.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> >> index fc8f7b2fc7b3..335c3fa7a3b1 100644
> >> --- a/drivers/dma/ti/omap-dma.c
> >> +++ b/drivers/dma/ti/omap-dma.c
> >> @@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
> >>  	if (conf) {
> >>  		od->cfg = conf;
> >>  		od->plat = dev_get_platdata(&pdev->dev);
> >> -		if (!od->plat)
> >> +		if (!od->plat) {
> >>  			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
> >> +			return -EPROBE_DEFER;
> 
> I think we should make the print as dev_err("&pdev->dev,
> "omap_system_dma_plat_info is missing") and return with -ENODEV. The
> omap_system_dma_plat_info is _needed_ and if we have booted with device
> tree it is not going to appear later.
> 
> Tony, what do you think?

Yes makes sense, the auxdata is needed for the quirks for now.
Eventually the quirks can be set directly in the dmaengine driver
based on compatible and soc_device_match().

Regards,

Tony
