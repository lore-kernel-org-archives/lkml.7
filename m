Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBC8213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259595;
	bh=hYtwuCFhnuQj0X2x7mwLXKB81zPD2nZFA25itFEFtKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y2nnJMu9LyckkL7lmSNz8xDVRB9emMTxqjuru8umbhHhTZG3DMSrYW072mXXrHpDE
	 38ijF2zAwGxc5Z0BH8VtpfmjRK4DaDOvkWKH6hdOfHlOtjYufjzmSJqcIpB3I3X8yw
	 PhPLL5pVluTlXOXrJgI2B9TroY0kWDPkkG4nap5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfCVM7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731794AbfCVM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:59:46 -0400
Received: from localhost (unknown [106.201.33.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECD4213F2;
        Fri, 22 Mar 2019 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553259585;
        bh=hYtwuCFhnuQj0X2x7mwLXKB81zPD2nZFA25itFEFtKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJjyY4wfOD1YdkihjMq2OGa5KRvI5z6frn6qcUOWDEc8WJqr1oeucQxRxBuzGpGXV
         P3vsl8D7SVh6gOEOhbXMur33oOCZrglmKo6NoAPLa0q0MQY2dtRQ+JsgYJAeElMo0a
         EHIRBX8vHq+bnHIGsTyTASR9D48MFdstOvvS1M7M=
Date:   Fri, 22 Mar 2019 18:29:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus
 clock
Message-ID: <20190322125940.GE5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-3-jernej.skrabec@siol.net>
 <20190316110753.GH5348@vkoul-mobl>
 <2451376.qVWA8nfu3q@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2451376.qVWA8nfu3q@jernej-laptop>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-19, 12:23, Jernej Škrabec wrote:
> Hi!
> 
> Dne sobota, 16. marec 2019 ob 12:07:53 CET je Vinod Koul napisal(a):
> > On 07-03-19, 17:58, Jernej Skrabec wrote:
> > > H6 DMA controller needs additional mbus clock to be enabled.
> > > 
> > > Add a quirk for it and handle it accordingly.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > > index 0cd13f17fc11..761555080325 100644
> > > --- a/drivers/dma/sun6i-dma.c
> > > +++ b/drivers/dma/sun6i-dma.c
> > > @@ -129,6 +129,7 @@ struct sun6i_dma_config {
> > > 
> > >  	u32 dst_burst_lengths;
> > >  	u32 src_addr_widths;
> > >  	u32 dst_addr_widths;
> > > 
> > > +	bool mbus_clk;
> > > 
> > >  };
> > >  
> > >  /*
> > > 
> > > @@ -182,6 +183,7 @@ struct sun6i_dma_dev {
> > > 
> > >  	struct dma_device	slave;
> > >  	void __iomem		*base;
> > >  	struct clk		*clk;
> > > 
> > > +	struct clk		*clk_mbus;
> > 
> > So rather than have mbus_clk and then a ptr, why not use the ptr and use
> > NULL value to check for..?
> > 
> 
> I'm not sure what you mean here. clk_mbus will hold a reference to a clock 
> retrieved by devm_clk_get() so it has to be "struct clk *".
> 
> What I'm missing here?

IIRC there were two variable one clk ptr and one an integer to mark
presence, you may be able to skip variable and use ptr..
-- 
~Vinod
