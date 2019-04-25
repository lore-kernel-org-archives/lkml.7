Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F317C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E576206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfDYNdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:33:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:44345 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDYNdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:33:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 068E010308C;
        Thu, 25 Apr 2019 15:33:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id StRKUhF4G9Zo; Thu, 25 Apr 2019 15:33:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7E3FC10308F;
        Thu, 25 Apr 2019 15:33:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CCA7oOs_8rYC; Thu, 25 Apr 2019 15:33:21 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2257A10308C;
        Thu, 25 Apr 2019 15:33:21 +0200 (CEST)
Message-ID: <3b7fb8442a5e0106f11e328f5bb4f0f46483ccf4.camel@v3.sk>
Subject: Re: [PATCH v3 14/14] [media] marvell-ccic: provide a clock for the
 sensor
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Date:   Thu, 25 Apr 2019 15:33:19 +0200
In-Reply-To: <20181122200747.GA6788@w540>
References: <20181120100318.367987-1-lkundrak@v3.sk>
         <20181120100318.367987-15-lkundrak@v3.sk> <20181122200747.GA6788@w540>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 08:44 +0100, jacopo mondi wrote:
> HI Lubomir,
> 
> On Tue, Nov 20, 2018 at 11:03:19AM +0100, Lubomir Rintel wrote:
> > The sensor needs the MCLK clock running when it's being probed. On
> > platforms where the sensor is instantiated from a DT (MMP2) it is going
> > to happen asynchronously.
> > 
> > Therefore, the current modus operandi, where the bridge driver fiddles
> > with the sensor power and clock itself is not going to fly. As the comments
> > wisely note, this doesn't even belong there.
> > 
> > Luckily, the ov7670 driver is already able to control its power and
> > reset lines, we can just drop the MMP platform glue altogether.
> > 
> > It also requests the clock via the standard clock subsystem. Good -- let's
> > set up a clock instance so that the sensor can ask us to enable the clock.
> > Note that this is pretty dumb at the moment: the clock is hardwired to a
> > particular frequency and parent. It was always the case.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v1:
> > - [kbuild/ia64] depend on COMMON_CLK.
> > - [smatch] fix bad return in mcam_v4l_open() leading to lock not getting
> >   released on error.
> > 
> >  drivers/media/platform/marvell-ccic/Kconfig   |   2 +
> >  .../media/platform/marvell-ccic/cafe-driver.c |   9 +-
> >  .../media/platform/marvell-ccic/mcam-core.c   | 156 +++++++++++++++---
> >  .../media/platform/marvell-ccic/mcam-core.h   |   3 +
> >  .../media/platform/marvell-ccic/mmp-driver.c  | 152 ++---------------
> >  .../linux/platform_data/media/mmp-camera.h    |   2 -
> >  6 files changed, 161 insertions(+), 163 deletions(-)
...
> >  int mccic_register(struct mcam_camera *cam)
> >  {
> > +	struct clk_init_data mclk_init = { };
> >  	int ret;
> > 
> >  	/*
> > @@ -1838,7 +1925,10 @@ int mccic_register(struct mcam_camera *cam)
> >  	mcam_set_config_needed(cam, 1);
> >  	cam->pix_format = mcam_def_pix_format;
> >  	cam->mbus_code = mcam_def_mbus_code;
> > -	mcam_ctlr_init(cam);
> > +
> > +	mcam_clk_enable(cam);
> 
> Am I mis-interpreting the clock bindings, or here you expose a clock
> source, and sensors are supposed to reference it if they need to. It
> is then the sensor driver that by calling clk_prepare_enable() on the
> referenced clock triggers the call of the 'enable' function. It seems
> to me that here you have exposed a clock provider, but the provider
> itself enables its clocks...

What mcam_clk_enable() enables is the clocks for the CCIC IP core; so
that we're able to access the registers.

(Note to self: we're enabling all the clocks here, we just need the
"axi" clock, clk_enable(cam->clk[0]), as done elsewhere, should be
sufficient.)

On the other hand, the "mclk" clock provider that is only registered
below provides the clock for the sensor itself that's provided by the
CCIC block.

>  Am I confused?

Chances are that I am. But maybe you're confusing mcam_clk_enable(cam)
(consumer, enables the CCIC's input clocks) with mclk_enable()
(provider, makes CCIC generate the clock for the sensor).

> 
> Thanks
>    j
> 
> > +	mcam_ctlr_init(cam); // XXX?

This looks like something I shouldn't have left in place though...

> > +	mcam_clk_disable(cam);
> > 
> >  	/*
> >  	 * Register sensor notifier.
> > @@ -1857,6 +1947,26 @@ int mccic_register(struct mcam_camera *cam)
> >  		goto out;
> >  	}
> > 
> > +	/*
> > +	 * Register sensor master clock.
> > +	 */
> > +	mclk_init.parent_names = NULL;
> > +	mclk_init.num_parents = 0;
> > +	mclk_init.ops = &mclk_ops;
> > +	mclk_init.name = "mclk";
> > +
> > +	of_property_read_string(cam->dev->of_node, "clock-output-names",
> > +							&mclk_init.name);
> > +
> > +	cam->mclk_hw.init = &mclk_init;
> > +
> > +	cam->mclk = devm_clk_register(cam->dev, &cam->mclk_hw);
> > +	if (IS_ERR(cam->mclk)) {
> > +		ret = PTR_ERR(cam->mclk);
> > +		dev_err(cam->dev, "can't register clock\n");
> > +		goto out;
> > +	}
> > +
> >  	/*
> >  	 * If so requested, try to get our DMA buffers now.
> >  	 */
> > @@ -1884,7 +1994,7 @@ void mccic_shutdown(struct mcam_camera *cam)
> >  	 */
> >  	if (!list_empty(&cam->vdev.fh_list)) {
> >  		cam_warn(cam, "Removing a device with users!\n");
> > -		mcam_ctlr_power_down(cam);
> > +		sensor_call(cam, core, s_power, 0);
> >  	}
> >  	if (cam->buffer_mode == B_vmalloc)
> >  		mcam_free_dma_bufs(cam);
> > @@ -1906,7 +2016,8 @@ void mccic_suspend(struct mcam_camera *cam)
> >  		enum mcam_state cstate = cam->state;
> > 
> >  		mcam_ctlr_stop_dma(cam);
> > -		mcam_ctlr_power_down(cam);
> > +		sensor_call(cam, core, s_power, 0);
> > +		mcam_clk_disable(cam);
> >  		cam->state = cstate;
> >  	}
> >  	mutex_unlock(&cam->s_mutex);
> > 
...

Cheers,
Lubo

