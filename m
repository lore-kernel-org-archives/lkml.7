Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C91C17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573536988;
	bh=YDjjnafho2uCvMpxMXlnLJhhfTeoSuyoFzfDVXn7/m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LX/FzFFb6Z/mFIQFwEgTC01y0URS0lleI1lx7mfZ7jDr2hvHwTzAINJnYnDXaOIg5
	 VlnEa8wSXpv2UotT6cb1a4TxF9yfTZZNF0tQZqWIKTEcgbCiobpUKrK4asdrS2LI0S
	 jKRqarCkSfecRiSzJoHwa/x8Rvgpe1g2B9OH0HDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKLFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLFg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:36:26 -0500
Received: from localhost (unknown [122.167.70.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6960321783;
        Tue, 12 Nov 2019 05:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573536986;
        bh=YDjjnafho2uCvMpxMXlnLJhhfTeoSuyoFzfDVXn7/m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP/sZWa6JWAiI7hq87AEWqr9AfSulRdI9YTrCKxSrQ9hoL4y7OXcCBvFDo6lhJO0f
         FeJ/Vqsm9SzcuKMOUI1LrLDl4Fp3KOIMDqB1bOIZf5z1Xn5+3hQ0ld7AfxnpvhMfIT
         NS+jfbiH+eK3W0HryxKa7RJk06UWxK51nrET6tF0=
Date:   Tue, 12 Nov 2019 11:06:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 12/15] dmaengine: ti: New driver for K3 UDMA -
 split#4: dma_device callbacks 1
Message-ID: <20191112053621.GW952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-13-peter.ujfalusi@ti.com>
 <20191111060943.GQ952516@vkoul-mobl>
 <6d73f6e1-6d85-d468-2e69-47d36ed75807@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d73f6e1-6d85-d468-2e69-47d36ed75807@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-19, 12:29, Peter Ujfalusi wrote:
> On 11/11/2019 8.09, Vinod Koul wrote:
> > On 01-11-19, 10:41, Peter Ujfalusi wrote:

> >> +static enum dma_status udma_tx_status(struct dma_chan *chan,
> >> +				      dma_cookie_t cookie,
> >> +				      struct dma_tx_state *txstate)
> >> +{
> >> +	struct udma_chan *uc = to_udma_chan(chan);
> >> +	enum dma_status ret;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&uc->vc.lock, flags);
> >> +
> >> +	ret = dma_cookie_status(chan, cookie, txstate);
> >> +
> >> +	if (!udma_is_chan_running(uc))
> >> +		ret = DMA_COMPLETE;
> > 
> > so a paused channel will result in dma complete status?
> 
> The channel is still enabled (running), the pause only sets a bit in the
> channel's real time control register.

Okay and which cases will channel not be running i.e., you return
DMA_COMPLETE above?

-- 
~Vinod
