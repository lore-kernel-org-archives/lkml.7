Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED5C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0EC206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEDJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:47:31 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:38129 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfEDJra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:47:30 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id AF5A55C0B0A; Sat,  4 May 2019 11:46:35 +0200 (CEST)
Date:   Sat, 4 May 2019 11:46:35 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Nicholas Mc Guire <hofrat@opentech.at>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: smiapp: core: add range to usleep_range
Message-ID: <20190504094635.GA27029@osadl.at>
References: <1554603364-10500-1-git-send-email-hofrat@opentech.at>
 <20190430134944.6sutxdztj6crgo6w@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430134944.6sutxdztj6crgo6w@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:49:44PM +0300, Sakari Ailus wrote:
> Hi Nicholas,
> 
> On Sun, Apr 07, 2019 at 04:16:02AM +0200, Nicholas Mc Guire wrote:
> > Allow the hrtimer subsystem to coalesce delay timers of lower accuracy
> > by providing a suitable range
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
> > ---
> > 
> > Problem located by an experimental coccinelle script
> > 
> > hrtimers in atomic context have limited accuracy due to possible
> > context-switching and interruption so the accuracy is limited 
> > anyway. Giving the hrtimer subsystem a reasonable range for merging
> > hrtimers helps to reduce the load on the hrtimer subsystem. As this
> > delays do not seem to mandate high accuracy the range of a factor
> > two seems acceptable.
> > 
> > Patch was compile tested with: x86_64_defconfig + MEDIA_SUPPORT=m,
> > MEDIA_CAMERA_SUPPORT=y, MEDIA_CONTROLLER=y, VIDEO_V4L2_SUBDEV_API=y,
> > VIDEO_SMIAPP=m                                                                                               
> > (with a number of sparse warnings on sizeof() usage)
> > 
> > Patch is against 5.1-rc3 (localversion-next is next-20190405)
> 
> The delays are exact for the reason that they are user-visible delays in
> image capturing related use cases. Sometimes milliseconds matter, or at
> least adding more does not help.
>

Actually it can be better iwith respect to jitter to let the hrtimer 
subsystem use an existing timer event than to have a close by second event 
and the accuracy is determined by the non-atomic context anyway - 
so while the proposed delay extension might be excessive in your case
I would still suggest to try to get away from a range of 0 - even if
you only end up with (1000,1050) that would be an advantage for the
timer subsystem.

thx!
hofrat
 
> > 
> >  drivers/media/i2c/smiapp/smiapp-core.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
> > index 58a45c3..c0c29ec 100644
> > --- a/drivers/media/i2c/smiapp/smiapp-core.c
> > +++ b/drivers/media/i2c/smiapp/smiapp-core.c
> > @@ -1222,19 +1222,19 @@ static int smiapp_power_on(struct device *dev)
> >  		dev_err(&client->dev, "failed to enable vana regulator\n");
> >  		return rval;
> >  	}
> > -	usleep_range(1000, 1000);
> > +	usleep_range(1000, 2000);
> >  
> >  	rval = clk_prepare_enable(sensor->ext_clk);
> >  	if (rval < 0) {
> >  		dev_dbg(&client->dev, "failed to enable xclk\n");
> >  		goto out_xclk_fail;
> >  	}
> > -	usleep_range(1000, 1000);
> > +	usleep_range(1000, 2000);
> >  
> >  	gpiod_set_value(sensor->xshutdown, 1);
> >  
> >  	sleep = SMIAPP_RESET_DELAY(sensor->hwcfg->ext_clk);
> > -	usleep_range(sleep, sleep);
> > +	usleep_range(sleep, sleep*2);
> >  
> >  	mutex_lock(&sensor->mutex);
> >  
> > @@ -1381,7 +1381,7 @@ static int smiapp_power_off(struct device *dev)
> >  
> >  	gpiod_set_value(sensor->xshutdown, 0);
> >  	clk_disable_unprepare(sensor->ext_clk);
> > -	usleep_range(5000, 5000);
> > +	usleep_range(5000, 10000);
> >  	regulator_disable(sensor->vana);
> >  	sensor->streaming = false;
> >  
> 
> -- 
> Sakari Ailus
