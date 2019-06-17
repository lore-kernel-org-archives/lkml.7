Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5889AC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E00220848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560765342;
	bh=keB/qNTaNxI25yvhvXe+Z5KA0lG2EkqbJoYKrsvLfQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X20POev4go8vxipJ7LAl8fm1YztxJ6OX2eqOUId91wcdbEyPwoys71LXB2D0KDisi
	 d3+gJ8w2e4+nKpPoZFicZKGxm2y3wM2sc6OkTXsTdJMgZImQfi+jNyJeE0TF4HOCv/
	 76nDUs07gc8bc75K28f440bvtQK2aRPPZR3+HMJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfFQJzl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:55:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41074 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFQJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:55:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so8666298otj.8;
        Mon, 17 Jun 2019 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7SuI9vLUAwXvgnaQIuYQGNgcBOBLIEw7OPkq5rLb6s=;
        b=pLJnrx8fXWIt6w654Ry6SXdJUWrdxmaaA5t/T8HlOW0vZOxdcM9IYY71DD0kRpt86+
         ZxcM7055p2F7Wr953yYT1LVMGevexZasDUXXceTXxBD4JD9AXSWdPhvoRH9a6e1/v1/P
         MHdIuaXMO0fIVKToe+muUWJwYKCWQocLEvb6qtpICPngmZYuk8iPguOXipFQHrujTCG3
         sVFOb6Suz7M5aaqmcPqK1mZbSECVJIkcZOU74PDXob50lJwlP+B7KlF3qYDQJqbs4bCa
         bsvD5Dq8xQeId7es/Va09qkgE6IZ+PE//F95M79sjQnxEadb3O9H7dRVQBXG8SOOf9CC
         /rMw==
X-Gm-Message-State: APjAAAWR5gEEWu3/SyWJZThMV2Z1pwtE4E8WRHLsYV6BI6to6gUdODZD
        EtJMjm9lnapCt+C/ueiu474ok3a6pAZj1BHpGR4=
X-Google-Smtp-Source: APXvYqzYcmzAzTrAIa6DT3XwBZdcJvm+cBivzLoRjMlWNgT2YPWkNLDO9ajhN4pNKdGLrNGl5CyR9/haPnJE33JN5ZE=
X-Received: by 2002:a9d:5e99:: with SMTP id f25mr29823354otl.262.1560765339826;
 Mon, 17 Jun 2019 02:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de> <20190614133840.GN9224@smile.fi.intel.com>
 <20190614141004.GC7234@kroah.com>
In-Reply-To: <20190614141004.GC7234@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jun 2019 11:55:28 +0200
Message-ID: <CAJZ5v0iBSq+DHqkevbLS0kYbaKGM0zYjg0KAzNhqYjCXvrQ-RQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: Provide devm_platform_ioremap_resource_byname()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 4:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 14, 2019 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > +Cc: Jack Ping, who did internally the same
> >
> > On Fri, Jun 14, 2019 at 03:26:25PM +0200, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Fri, 14 Jun 2019 15:15:14 +0200
> > >
> > > The functions “platform_get_resource_byname” and “devm_ioremap_resource”
> > > are called together in 181 source files.
> > > This implementation detail can be determined also with the help
> > > of the semantic patch language (Coccinelle software).
> > >
> > > Wrap these two calls into another helper function.
> > > Thus a local variable does not need to be declared for a resource
> > > structure pointer before and a redundant argument can be omitted
> > > for the resource type.
> >
> > This one makes sense.
> > Though I'm not sure Greg will see your message.
>
> Nope, didn't see it, don't want to see it, it will only cause more work
> in the longrun...
>
> > Rafael, maybe you can apply this one?
>
> Um, don't go around maintainers please, that's rude.

Totally agreed.

And there would be no reason for me to even consider applying it, really.

> There is a reason this specific developer is in my blacklist, and perhaps they should be
> in yours as well :)
>
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > >
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  drivers/base/platform.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 4d1729853d1a..c1f19a479dd7 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -97,6 +97,24 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> > >     return devm_ioremap_resource(&pdev->dev, res);
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > > +
> > > +/**
> > > + * devm_platform_ioremap_resource_byname
> > > + * Call devm_ioremap_resource() for a platform device
> > > + *
> > > + * @pdev: platform device to use both for memory resource lookup as well as
> > > + *        resource management
> > > + * @name: resource name
> > > + */
> > > +void __iomem *devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> > > +                                               const char *name)
> > > +{
> > > +   struct resource *res;
> > > +
> > > +   res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > > +   return devm_ioremap_resource(&pdev->dev, res);
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
> > >  #endif /* CONFIG_HAS_IOMEM */
>
> I don't like adding new apis with no user.

I agree with that too.

Cheers!
