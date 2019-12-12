Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46357C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1772C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfLLMAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:00:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:00:03 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ifN8R-00078C-2V; Thu, 12 Dec 2019 12:59:59 +0100
Message-ID: <50977f1c8f17cbc1e3ac4f68d6642f1c3bd01b79.camel@pengutronix.de>
Subject: Re: [PATCH] media: imx7-mipi-csis: Add the missed
 v4l2_async_notifier_cleanup in remove
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chuhong Yuan <hslester96@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Date:   Thu, 12 Dec 2019 12:59:55 +0100
In-Reply-To: <20191212115134.GA1895@kadam>
References: <20191209085828.16183-1-hslester96@gmail.com>
         <20191212115134.GA1895@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 14:51 +0300, Dan Carpenter wrote:
> On Mon, Dec 09, 2019 at 04:58:28PM +0800, Chuhong Yuan wrote:
> > All drivers in imx call v4l2_async_notifier_cleanup() after unregistering
> > the notifier except this driver.
> > This should be a miss and we need to add the call to fix it.
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/staging/media/imx/imx7-mipi-csis.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
> > index 99166afca071..2bfa85bb84e7 100644
> > --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> > +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> > @@ -1105,6 +1105,7 @@ static int mipi_csis_remove(struct platform_device *pdev)
> >  	mipi_csis_debugfs_exit(state);
> >  	v4l2_async_unregister_subdev(&state->mipi_sd);
> >  	v4l2_async_notifier_unregister(&state->subdev_notifier);
> > +	v4l2_async_notifier_cleanup(&state->subdev_notifier);
> >  
> 
> In this case the "state->subdev_notifier" was never initialized or used
> so both v4l2_async_notifier_unregister() and v4l2_async_notifier_cleanup()
> are no-ops.
> 
> We should just delete "subdev_notifier".

I agree with Dan and Hans, the subdev_notifier field and the
v4l2_async_notifier_unregister() call should be removed. Since
this issue was there from the start, the patch can be tagged
as fixing commit 7807063b862b.

regards
Philipp

