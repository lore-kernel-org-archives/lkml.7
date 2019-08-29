Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03CDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C0723403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567073433;
	bh=lxep6NKFXEm61hWlaCADl7aH4C7g4KhxHM4ZioALn2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hhnx/cEcdYp2nbZ4Nz8ve3n6vpP7TxahZWM0GTpTuacJRUH1Rap1p67GhB/8UKEEG
	 CGj9qEIP0/mQZXir2NZ2HzN+gtsHEwP9AXrq0g9nFU81xFSYdRYTlemNm/3AoPLog/
	 IbNTjpMaHftl+UH8Ylt3lavgb2CaKdLx7li7FLWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH2KKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfH2KKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:10:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF252339E;
        Thu, 29 Aug 2019 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567073430;
        bh=lxep6NKFXEm61hWlaCADl7aH4C7g4KhxHM4ZioALn2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHqr8XLjynHZME8z2KfP2D7/bk2oW7pcMr8B8eEMmhbJegLXaifOuxW6j5oMVmNqa
         v/R8GU/EDshcQ3gCMPwVveQKBVihViWq/YIqeuEgtHNOzMq8xVdN8Oa5j7MuusFgwg
         fGkuLu/BrmWxe9Xa/iDQzW/W4niydVo6qd8YIQtI=
Date:   Thu, 29 Aug 2019 12:10:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Introduce
 platform_get_irq_optional()
Message-ID: <20190829101028.GA20197@kroah.com>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
 <20190829074408.GA17754@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829074408.GA17754@ulmo>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:44:08AM +0200, Thierry Reding wrote:
> On Wed, Aug 28, 2019 at 10:34:10AM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > In some cases the interrupt line of a device is optional. Introduce a
> > new platform_get_irq_optional() that works much like platform_get_irq()
> > but does not output an error on failure to find the interrupt.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> >  include/linux/platform_device.h |  1 +
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 8ad701068c11..0dda6ade50fd 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -192,6 +192,28 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> >  
> > +/**
> > + * platform_get_irq_optional - get an optional IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + *
> > + * Gets an IRQ for a platform device. Device drivers should check the return
> > + * value for errors so as to not pass a negative integer value to the
> > + * request_irq() APIs. This is the same as platform_get_irq(), except that it
> > + * does not print an error message if an IRQ can not be obtained.
> > + *
> > + * Example:
> > + *		int irq = platform_get_irq_optional(pdev, 0);
> > + *		if (irq < 0)
> > + *			return irq;
> > + *
> > + * Return: IRQ number on success, negative error number on failure.
> > + */
> > +int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
> > +{
> > +	return __platform_get_irq(dev, num);
> > +}
> 
> Oh my... this is embarrassing, but the kbuild test robot reported that
> the second patch here fails to build because I forgot to export this
> symbol. I've attached a patch that fixes it.
> 
> Thierry
> 
> > +
> >  /**
> >   * platform_irq_count - Count the number of IRQs a platform device uses
> >   * @dev: platform device
> > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > index 37e15a935a42..35bc4355a9df 100644
> > --- a/include/linux/platform_device.h
> > +++ b/include/linux/platform_device.h
> > @@ -58,6 +58,7 @@ extern void __iomem *
> >  devm_platform_ioremap_resource(struct platform_device *pdev,
> >  			       unsigned int index);
> >  extern int platform_get_irq(struct platform_device *, unsigned int);
> > +extern int platform_get_irq_optional(struct platform_device *, unsigned int);
> >  extern int platform_irq_count(struct platform_device *);
> >  extern struct resource *platform_get_resource_byname(struct platform_device *,
> >  						     unsigned int,
> > -- 
> > 2.22.0
> > 

> From 0f7695c4d3f30b2946c97160b717de03c3deb73f Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Thu, 29 Aug 2019 09:29:32 +0200
> Subject: [PATCH] driver core: platform: Export platform_get_irq_optional()
> 
> This function can be used by modules, so it needs to be exported.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/base/platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 014dc07b0056..b6c6c7d97d5b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -194,6 +194,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>  {
>  	return __platform_get_irq(dev, num);
>  }
> +EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>  
>  /**
>   * platform_irq_count - Count the number of IRQs a platform device uses
> -- 
> 2.22.0
> 

Now merged, thanks.

greg k-h


