Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF83C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521B1218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562236997;
	bh=GO5rZwACuqGJZLDo2ucr74UTZmdv8Bqm4fA6Yt770mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqShvhYqXxd5BvSSS7Lncc7vI2xatjlkygjwoW0UfyqRJ+y2myrFJtoFzfi4/4abD
	 0Sqx6/zQnHgpIIekiFVqR6oxnaEFl61Ih5BySnqzqbYyqRFqhI0hjkjCMANdv6HqqW
	 SXx/Oi5+VTvg7Z5F8qTO/uOPnKGO3idMR7QVF2Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGDKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:43:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA4F218A3;
        Thu,  4 Jul 2019 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562236995;
        bh=GO5rZwACuqGJZLDo2ucr74UTZmdv8Bqm4fA6Yt770mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nvDXObCXpiy0YByYsTXgPkhBa2nJpAojxuoTqc8YKs7Tdb/KfqWxTSN9JWEPZkC2
         JGSqqe7Tv+BGBQZVVpCgXVzG9SOu6HVSNR7qFDFNMuaNRlOJKN9SurghIVPofkSuu0
         lfx6V1CG0YWaOybnG88fHy3OqtKCti8nWzOKX5rM=
Date:   Thu, 4 Jul 2019 12:43:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/11] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190704104311.GA16681@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org>
 <20190704093200.GM13424@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704093200.GM13424@localhost>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:32:00AM +0200, Johan Hovold wrote:
> On Thu, Jul 04, 2019 at 10:46:07AM +0200, Greg Kroah-Hartman wrote:
> > Platform drivers like to add sysfs groups to their device, but right now
> > they have to do it "by hand".  The driver core should handle this for
> > them, but there is no way to get to the bus-default attribute groups as
> > all platform devices are "special and unique" one-off drivers/devices.
> > 
> > To combat this, add a dev_groups pointer to platform_driver which allows
> > a platform driver to set up a list of default attributes that will be
> > properly created and removed by the platform driver core when a probe()
> > function is successful and removed right before the device is unbound.
> > 
> > Cc: Richard Gong <richard.gong@linux.intel.com>
> > Cc: Romain Izard <romain.izard.pro@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mans Rullgard <mans@mansr.com>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/platform.c         | 40 +++++++++++++++++++++------------
> >  include/linux/platform_device.h |  1 +
> >  2 files changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 713903290385..d81fcd435b52 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -598,6 +598,21 @@ struct platform_device *platform_device_register_full(
> >  }
> >  EXPORT_SYMBOL_GPL(platform_device_register_full);
> >  
> > +static int platform_drv_remove(struct device *_dev)
> > +{
> > +	struct platform_driver *drv = to_platform_driver(_dev->driver);
> > +	struct platform_device *dev = to_platform_device(_dev);
> > +	int ret = 0;
> > +
> > +	if (drv->remove)
> > +		ret = drv->remove(dev);
> > +	if (drv->dev_groups)
> > +		device_remove_groups(_dev, drv->dev_groups);
> 
> Shouldn't you remove the groups before calling driver remove(), which
> could be releasing resources used by the attribute implementations?
> 
> This would also be the reverse of how what you do at probe.

Good point, probably doesn't really matter, but I'll reverse it.

> > +	dev_pm_domain_detach(_dev, true);
> > +
> > +	return ret;
> > +}
> > +
> >  static int platform_drv_probe(struct device *_dev)
> >  {
> >  	struct platform_driver *drv = to_platform_driver(_dev->driver);
> > @@ -614,8 +629,18 @@ static int platform_drv_probe(struct device *_dev)
> >  
> >  	if (drv->probe) {
> >  		ret = drv->probe(dev);
> > -		if (ret)
> > +		if (ret) {
> >  			dev_pm_domain_detach(_dev, true);
> > +			goto out;
> > +		}
> > +	}
> > +	if (drv->dev_groups) {
> > +		ret = device_add_groups(_dev, drv->dev_groups);
> > +		if (ret) {
> > +			platform_drv_remove(_dev);
> 
> This would lead to device_remove_groups() being called for the never
> added attribute groups. Looks like that may trigger a warning in the
> sysfs code judging from a quick look.

Hm, let me look at this some more...

