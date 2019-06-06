Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CFF20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559832686;
	bh=QTfNWyei/yIC47IByZ5MJw3oLuT00ADUd6RHFQzHIls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o9n9+h5NbMv2EU4WkUdFm36a4Hy4O10nB985nCU3KEyIg7bqJGv6wvNzbTEhJzR9U
	 T6xqXNKV62jduPhiJ0G3EqwXgqpAzv4xt9PLD3qB0NdBii3N/pWtvGB/b2tw869dAG
	 wmR0+8cB5GpXOot2y/Yyo/m8lvh7hHXXaP5o1dqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfFFOvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfFFOvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:51:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C8E20684;
        Thu,  6 Jun 2019 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559832683;
        bh=QTfNWyei/yIC47IByZ5MJw3oLuT00ADUd6RHFQzHIls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYpZf4NqWFpsd6Q4/ET0i9LmZlheHyoLi5ru9RGLAJGGje5OBWpZ5MJMUVwO8051H
         q59pq5PIjWXua0HYYSl0yxq43mZ/iiSjAB75OvboAUHnWeFyDAz/gF6O7EoaiHYUes
         o90ATrq6Ykp19T/e9sqSUcA/ZwT4zQQokwwkMy/4=
Date:   Thu, 6 Jun 2019 16:51:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, Enno Luebbers <enno.luebbers@intel.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Corbet <corbet@lwn.net>, Wu Hao <hao.wu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH 03/10] mfd / platform: cros_ec: Miscellaneous character
 device to talk with the EC
Message-ID: <20190606145121.GA13048@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com>
 <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
 <20190604183527.GA20098@kroah.com>
 <CABXOdTfU9KaBDhQcwvBGWCmVfnd02_ZFmPGtJsCtGQ-iO9A3Qw@mail.gmail.com>
 <20190604185953.GA2061@kroah.com>
 <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda48bf80add26153e531912fbfca25071934c94.camel@collabora.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:01:17AM -0300, Ezequiel Garcia wrote:
> On Tue, 2019-06-04 at 20:59 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 04, 2019 at 11:39:21AM -0700, Guenter Roeck wrote:
> > > On Tue, Jun 4, 2019 at 11:35 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > > > > Hey Greg,
> > > > > 
> > > > > > > + dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > > > > > +          data->misc.name);
> > > > > > 
> > > > > > No need to be noisy, if all goes well, your code should be quiet.
> > > > > > 
> > > > > 
> > > > > I sometimes wonder about this being noise or not, so I will slightly
> > > > > hijack this thread for this discussion.
> > > > > 
> > > > > > From a kernel developer point-of-view, or even from a platform
> > > > > developer or user with a debugging hat point-of-view, having
> > > > > a "device created" or "device registered" message is often very useful.
> > > > 
> > > > For you, yes.  For someone with 30000 devices attached to their system,
> > > > it is not, and causes booting to take longer than it should be.
> > > > 
> > > > > In fact, I wish people would do this more often, so I don't have to
> > > > > deal with dynamic debug, or hack my way:
> > > > > 
> > > > > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > > > > index 4589631798c9..473549b26bb2 100644
> > > > > --- a/drivers/media/i2c/ov5647.c
> > > > > +++ b/drivers/media/i2c/ov5647.c
> > > > > @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
> > > > >         if (ret < 0)
> > > > >                 goto error;
> > > > > 
> > > > > -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
> > > > > +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
> > > > >         return 0;
> > > > >  error:
> > > > >         media_entity_cleanup(&sd->entity);
> > > > > 
> > > > > In some subsystems, it's even a behavior I'm more or less relying on:
> > > > > 
> > > > > $ git grep v4l2_info.*registered drivers/media/ | wc -l
> > > > > 26
> > > > > 
> > > > > And on the downsides, I can't find much. It's just one little line,
> > > > > that is not even noticed unless you have logging turned on.
> > > > 
> > > > Its better to be quiet, which is why the "default driver registration"
> > > > macros do not have any printk messages in them.  When converting drivers
> > > > over to it, we made the boot process much more sane, don't try to go and
> > > > add messages for no good reason back in please.
> > > > 
> > > > dynamic debugging can be enabled on a module and line-by-line basis,
> > > > even from the boot command line.  So if you need debugging, you can
> > > > always ask someone to just reboot or unload/load the module and get the
> > > > message that way.
> > > > 
> > > 
> > > Can we by any chance make this an official policy ? I am kind of tired
> > > having to argue about this over and over again.
> > 
> > Sure, but how does anyone make any "official policy" in the kernel?  :)
> > 
> > I could just go through and delete all "look ma, a new driver/device!"
> > messages, but that might be annoying...
> > 
> 
> Well, I really need to task.

???

> If it's not an official policy (and won't be anytime soon?),

The ":)" there was that we really have very few "official" policies,
only things that we all strongly encourage to happen.  And get grumpy if
we see them in code reviews.  Like I did here.

> then what's preventing Enric from pushing this print on this driver,
> given he is the one maintaining the code?

Given that he wants people to review his code, why would you tell him to
ignore what people are trying to tell him?

Again, don't be noisy, it's not hard, and is how things have been
trending for many years now.

thanks,

greg k-h
