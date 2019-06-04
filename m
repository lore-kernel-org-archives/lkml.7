Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AECC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D88124B95
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559638006;
	bh=RBjDeI+HAIKFiYmUaL686WOMkliZaN5AtVxGHHyVe34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=frOZ+Iq8ctfbQpbBkXUVoSraG7QxN5X34Zuk2cfkQGJhmsQilcQ/kpaEosRS9+ZGU
	 z7wsdO9Op/tPG2gmTl+nMnSMrlwnuNvj1t0jWAVUdPvx/La6t1Sp5D2xapmEXzLpnE
	 MYbjBORekCzgHxzHrW43s9Gfe7b6V/GWFbft6Fnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFDIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDIqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:46:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13D824B92;
        Tue,  4 Jun 2019 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559638004;
        bh=RBjDeI+HAIKFiYmUaL686WOMkliZaN5AtVxGHHyVe34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0UNWRPrLflKlQm7WyBstudCchwcLcdB7A7Sewe1GLMRJOmKh6TBqQFYTD+4FHUiK
         9vglIuMUOxGv2iThiRMZ+7JS6hIV4H8UKkIM+6JpynCFqTvXmzbzmQlLX7Z/8fdtNe
         jDMVLzLq0yvMJvlQ3uM+rmXaK/z5NarrlYO5Q304=
Date:   Tue, 4 Jun 2019 10:46:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Message-ID: <20190604084642.GB1129@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
 <20190603191133.GE6487@kroah.com>
 <373d3620-fa60-8306-1119-22d197d6ba93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373d3620-fa60-8306-1119-22d197d6ba93@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:36:08AM +0100, Suzuki K Poulose wrote:
> 
> 
> On 03/06/2019 20:11, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> > > Add a wrappers to lookup a device by name for a given driver, by various
> > > generic properties of a device. This can avoid the proliferation of custom
> > > match functions throughout the drivers.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 52d59d5..68d6e04 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -401,6 +401,50 @@ struct device *driver_find_device(struct device_driver *drv,
> > >   				  struct device *start, void *data,
> > >   				  int (*match)(struct device *dev, const void *data));
> > > +/**
> > > + * driver_find_device_by_name - device iterator for locating a particular device
> > > + * of a specific name.
> > > + * @driver: the driver we're iterating
> > > + * @start: Device to begin with
> > > + * @name: name of the device to match
> > > + */
> > > +static inline struct device *driver_find_device_by_name(struct device_driver *drv,
> > > +							struct device *start,
> > > +							const char *name)
> > > +{
> > > +	return driver_find_device(drv, start, (void *)name, device_match_name);
> > 
> > Why is the cast needed?
> > 
> > > +}
> > > +
> > > +/**
> > > + * driver_find_device_by_of_node- device iterator for locating a particular device
> > > + * by of_node pointer.
> > > + * @driver: the driver we're iterating
> > > + * @start: Device to begin with
> > > + * @np: of_node pointer to match.
> > > + */
> > > +static inline struct device *
> > > +driver_find_device_by_of_node(struct device_driver *drv,
> > > +			      struct device *start,
> > > +			      const struct device_node *np)
> > > +{
> > > +	return driver_find_device(drv, start, (void *)np, device_match_of_node);
> > 
> > Same here.
> > 
> > > +}
> > > +
> > > +/**
> > > + * driver_find_device_by_fwnode- device iterator for locating a particular device
> > > + * by fwnode pointer.
> > > + * @driver: the driver we're iterating
> > > + * @start: Device to begin with
> > > + * @fwnode: fwnode pointer to match.
> > > + */
> > > +static inline struct device *
> > > +driver_find_device_by_fwnode(struct device_driver *drv,
> > > +			     struct device *start,
> > > +			     const struct fwnode_handle *fwnode)
> > > +{
> > > +	return driver_find_device(drv, start, (void *)fwnode, device_match_fwnode);
> > 
> > And here
> 
> Because the driver_find_device() expects a "void *" and not a "const void *".

Can we fix that?

> May be we could promote that to "const void *" in the core API too, since we
> have converted the "match" to const void * already. Thoughts ?

Yes, let's fix the core if possible.

thanks,

greg k-h
