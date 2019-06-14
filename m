Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD152C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020421721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560521409;
	bh=X3olSuNcAEC4oKTYoE6rwJUp6F7cA7DAFJwXvntbFZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IUyOHQe8e8/DV2+qdvWrcjByWd3d3V02leyscczA4HDtND52gpAvFqvkO5HB1Ra+N
	 ckpJMY4LngPDXJ81uwu7e5vE0W0SAqHcQI9245YfgQUhL7f5sMkdyYN4ZZo2EEc8EW
	 ATv1mLuoP/GZa4FAYkabyXoMkb5AVlnvsHh3TvpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfFNOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:10:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4826821721;
        Fri, 14 Jun 2019 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560521406;
        bh=X3olSuNcAEC4oKTYoE6rwJUp6F7cA7DAFJwXvntbFZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZCdPdQZfEwHNfS1xlho9YTjV85ahmdys2IFn8rEms4D6V842SVLCqeSXEw3pePhD
         g1GXkXCuZikiXJtCdZnAwpn5tgzRwjVDscNV386/YaPYhWhvFgHU0ZqQV9CAmqaPZL
         pLUQDNGl0AWOgS1B6+W+7D9tWvNw/Fnsodc95VCs=
Date:   Fri, 14 Jun 2019 16:10:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drivers: Provide devm_platform_ioremap_resource_byname()
Message-ID: <20190614141004.GC7234@kroah.com>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614133840.GN9224@smile.fi.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:38:40PM +0300, Andy Shevchenko wrote:
> +Cc: Jack Ping, who did internally the same
> 
> On Fri, Jun 14, 2019 at 03:26:25PM +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 14 Jun 2019 15:15:14 +0200
> > 
> > The functions “platform_get_resource_byname” and “devm_ioremap_resource”
> > are called together in 181 source files.
> > This implementation detail can be determined also with the help
> > of the semantic patch language (Coccinelle software).
> > 
> > Wrap these two calls into another helper function.
> > Thus a local variable does not need to be declared for a resource
> > structure pointer before and a redundant argument can be omitted
> > for the resource type.
> 
> This one makes sense.
> Though I'm not sure Greg will see your message.

Nope, didn't see it, don't want to see it, it will only cause more work
in the longrun...

> Rafael, maybe you can apply this one?

Um, don't go around maintainers please, that's rude.  There is a reason
this specific developer is in my blacklist, and perhaps they should be
in yours as well :)

> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/base/platform.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 4d1729853d1a..c1f19a479dd7 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -97,6 +97,24 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> >  	return devm_ioremap_resource(&pdev->dev, res);
> >  }
> >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > +
> > +/**
> > + * devm_platform_ioremap_resource_byname
> > + * Call devm_ioremap_resource() for a platform device
> > + *
> > + * @pdev: platform device to use both for memory resource lookup as well as
> > + *        resource management
> > + * @name: resource name
> > + */
> > +void __iomem *devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> > +						    const char *name)
> > +{
> > +	struct resource *res;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > +	return devm_ioremap_resource(&pdev->dev, res);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
> >  #endif /* CONFIG_HAS_IOMEM */

I don't like adding new apis with no user.

thanks,

greg k-h
