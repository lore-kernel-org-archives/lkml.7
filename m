Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB7C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858B208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559673333;
	bh=tyW09f1dV8kNzahIVCY6RGw/i1iM0mFvYnLCIjZANTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZpfNjAtCFHTCQ/yzV+2uoe9os1tKKNk+dsZCyF3Nn5U+vHr0FJawFzN5k62SMLZA
	 68tVWYlC2+KNeeSVwL8Xy53cNc/+ublws3GTgLhbWkg+AvDHIk6MehxqC4t8Xvechl
	 57eazOqVjocHvvGRBmZpsdCnJnciu8I17mpMK3sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFDSfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfFDSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:35:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7246D2070B;
        Tue,  4 Jun 2019 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559673330;
        bh=tyW09f1dV8kNzahIVCY6RGw/i1iM0mFvYnLCIjZANTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3ATu6bdulf9AAzDZrCr1bqyZSAOVqrr9z4KTBzMuzWKAr3OrL4fblKNcp554WGLs
         cldHemm/6ZpLI0uLyYh867Z184dGxudv8UP+gwn85iaT59qI+QxyQJw0apgCLMoy9j
         8iLI7hbtrTu/Atj+yudw9SwmZ6to+BtaWlDYEszs=
Date:   Tue, 4 Jun 2019 20:35:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org,
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
Message-ID: <20190604183527.GA20098@kroah.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-4-enric.balletbo@collabora.com>
 <20190604155228.GB9981@kroah.com>
 <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beaf3554bb85974eb118d7722ca55f1823b1850c.camel@collabora.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> Hey Greg,
> 
> > > +	dev_info(&pdev->dev, "Created misc device /dev/%s\n",
> > > +		 data->misc.name);
> > 
> > No need to be noisy, if all goes well, your code should be quiet.
> > 
> 
> I sometimes wonder about this being noise or not, so I will slightly
> hijack this thread for this discussion.
> 
> >From a kernel developer point-of-view, or even from a platform
> developer or user with a debugging hat point-of-view, having
> a "device created" or "device registered" message is often very useful.

For you, yes.  For someone with 30000 devices attached to their system,
it is not, and causes booting to take longer than it should be.

> In fact, I wish people would do this more often, so I don't have to
> deal with dynamic debug, or hack my way:
> 
> diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> index 4589631798c9..473549b26bb2 100644
> --- a/drivers/media/i2c/ov5647.c
> +++ b/drivers/media/i2c/ov5647.c
> @@ -603,7 +603,7 @@ static int ov5647_probe(struct i2c_client *client,
>         if (ret < 0)
>                 goto error;
>  
> -       dev_dbg(dev, "OmniVision OV5647 camera driver probed\n");
> +       dev_info(dev, "OmniVision OV5647 camera driver probed\n");
>         return 0;
>  error:
>         media_entity_cleanup(&sd->entity);
> 
> In some subsystems, it's even a behavior I'm more or less relying on:
> 
> $ git grep v4l2_info.*registered drivers/media/ | wc -l
> 26
> 
> And on the downsides, I can't find much. It's just one little line,
> that is not even noticed unless you have logging turned on.

Its better to be quiet, which is why the "default driver registration"
macros do not have any printk messages in them.  When converting drivers
over to it, we made the boot process much more sane, don't try to go and
add messages for no good reason back in please.

dynamic debugging can be enabled on a module and line-by-line basis,
even from the boot command line.  So if you need debugging, you can
always ask someone to just reboot or unload/load the module and get the
message that way.

thanks,

greg k-h
