Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC381C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9561D208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDHLyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:54:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43819 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:54:10 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C88661BF205;
        Mon,  8 Apr 2019 11:54:06 +0000 (UTC)
Date:   Mon, 8 Apr 2019 13:54:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-rtc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: tegra: set range
Message-ID: <20190408115406.GJ7480@piout.net>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
 <20190408102249.GC6644@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408102249.GC6644@ulmo>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 12:22:49+0200, Thierry Reding wrote:
> On Sun, Apr 07, 2019 at 11:16:44PM +0200, Alexandre Belloni wrote:
> > The Tegra 20 RTC is a 32bit seconds counter (with an unused millisecond
> > counter).
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/rtc/rtc-tegra.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
> > index c6b0a99aa3a9..3f93a1f7abb5 100644
> > --- a/drivers/rtc/rtc-tegra.c
> > +++ b/drivers/rtc/rtc-tegra.c
> > @@ -306,6 +306,13 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
> >  
> >  	info->tegra_rtc_irq = ret;
> >  
> > +	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> > +	if (IS_ERR(info->rtc_dev))
> > +		return PTR_ERR(info->rtc_dev);
> > +
> > +	info->rtc_dev->ops = &tegra_rtc_ops;
> > +	info->rtc_dev->range_max = U32_MAX;
> 
> The placement of this new block seems somewhat arbitrary, but either
> way:
> 

Well, I needed it to be before the clk_prepare_enable call so it can
just return and I thought it would be better to leave devm_clk_get close
to that clk_prepare_enable call. I don't mind, I can respin with it
placed somewhere else.

> Acked-by: Thierry Reding <treding@nvidia.com>



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
