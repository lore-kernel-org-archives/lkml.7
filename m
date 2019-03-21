Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96C9218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553162216;
	bh=mZxaMo9WIyT7wiTqSEb+QquejKDgZi3vKpJlfVJbydE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QtOXrWwY4QB6N98CqqnQZcHBE7rAlF1KHWwtnpAjTQ8faDaJZ9efZoZsUiqCGl5Xs
	 atKAyjk17XBy4Vny53JMBfmJ2RwC5oGc6Sm8gFPb9s6Ii+fSnLvD1P8URUD9xbw5wO
	 V2F4yC7iIGDNntyKBQbL7ApHKF7ksCnit9aVQhes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfCUJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbfCUJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:56:54 -0400
Received: from localhost (unknown [95.98.27.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C1A20850;
        Thu, 21 Mar 2019 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553162213;
        bh=mZxaMo9WIyT7wiTqSEb+QquejKDgZi3vKpJlfVJbydE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGa19erK+FB1Cs6qCiQFfqZDKz5vbdEeDEy+FyADmWsmZlCpOJ0nKQ3iEmsRghS/E
         yrxJJ68wvJzcP7Fz/FvE2LUihrYYIh3OOVdmka8tVqa0Y3gbci7gL5rTvLn5dQUrp8
         8mw4abGGlTrZHhqdYS/lT4DQwsC13GetX7743AJE=
Date:   Thu, 21 Mar 2019 10:56:49 +0100
From:   Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5LqO5rOi?= <yuzibode@126.com>
Subject: Re: [PATCH] misc/fastrpc: add checked value for dma_set_mask
Message-ID: <20190321095649.GA2836@kroah.com>
References: <20190319020519.15209-1-tsu.yubo@gmail.com>
 <CAKq8=3K26Vbg4Vk4+C4F6vjB5mv8SiSxe7mBxLrtph3MHGdi+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKq8=3K26Vbg4Vk4+C4F6vjB5mv8SiSxe7mBxLrtph3MHGdi+A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:31:51PM +0800, Bo YU wrote:
> On Tue, Mar 19, 2019 at 10:05 AM Bo YU <tsu.yubo@gmail.com> wrote:
> >
> > There be should check return value from dma_set_mask to throw some infos
> > if fail to set dma mask.
> >
> > Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)
> >
> > Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  drivers/misc/fastrpc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 39f832d27288..36d0d5c9cfba 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1184,6 +1184,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
> >         struct fastrpc_session_ctx *sess;
> >         struct device *dev = &pdev->dev;
> >         int i, sessions = 0;
> > +       int rc;
> >
> >         cctx = dev_get_drvdata(dev->parent);
> >         if (!cctx)
> > @@ -1213,7 +1214,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
> >         }
> >         cctx->sesscount++;
> >         spin_unlock(&cctx->lock);
> > -       dma_set_mask(dev, DMA_BIT_MASK(32));
> > +       rc = dma_set_mask(dev, DMA_BIT_MASK(32));
> > +       if (rc) {
> > +               dev_err(dev, "32-bit DMA enable failed\n");
> > +               return rc;
> > +       }
> >
> Ping?
> Do me need resend it?

2 days?  Please give us time to catch up on patches, right after the
merge window closed.  This isn't a big deal, we have much higher
priority patches to review.  It will be gotten to eventually :)

thanks,

greg k-h
