Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1972F21900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553321147;
	bh=ois9Ll/iXGB9ZZtF3PYqXWCudQUHzRJ/sHoSH3rgl+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GU2cOfjvNE/3ckKbrpILUtFGo3rqMwj3XGSokx2hbBWx+ZBbHrJqhFon2x3g/MaUU
	 TNWw0sSxYklQv13nF3HTXwXry7nweRxg13kwKkaD7hwJNM0r7TySLsqUBxHjVqLlff
	 2jWn6hSbVlrlozrzABG+Z1lhZYdDzP5G6D4K11dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCWGFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfCWGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:05:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D8D218E2;
        Sat, 23 Mar 2019 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553321144;
        bh=ois9Ll/iXGB9ZZtF3PYqXWCudQUHzRJ/sHoSH3rgl+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPOLMAgkAQAqIYBUNIo7SeLkV9/d+e2mpTk1nyHv+LWHjH8ElTPGoTYcExN6gRbJ7
         iuEYSn5zb6/63zY6+vnoOfpXzTtkTMOWVELtKvXJRFtnVQkb4MwnLx6LiXL8xqjlVh
         1PYGTgX018bA8nv3mWszXkDUo0gvovehdR3wKPuw=
Date:   Sat, 23 Mar 2019 07:05:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jochen Sprickerhof <jochen@sprickerhof.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Softdep for GBit Ethernet on Odroid XU4
Message-ID: <20190323060541.GA28292@kroah.com>
References: <20190321202303.GA1399@vis>
 <20190322053742.GB31708@kroah.com>
 <20190322204157.GB474@vis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322204157.GB474@vis>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:41:57PM +0100, Jochen Sprickerhof wrote:
> Hi Greg,
> 
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [2019-03-22 06:37]:
> > On Thu, Mar 21, 2019 at 09:23:03PM +0100, Jochen Sprickerhof wrote:
> > > This adds a soft dependency to the dwc3 module to load it after
> > > xhci-plat as proposed in:
> > > 
> > > https://marc.info/?l=linux-usb&m=155230272022603&w=2
> > > 
> > > Old behaviour:
> > > 
> > > $ lsusb -t
> > > /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> > > /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> > >   |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
> > > 
> > > New behaviour:
> > > 
> > > $ lsusb -t
> > > /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> > >   |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> > > 
> > > Tested on Debian unstable using Linux 4.19.29.
> > > 
> > > Note, this needs a hard reset when coming from an unpatched kernel.
> > > 
> > > Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
> > > ---
> > > drivers/usb/dwc3/core.c | 1 +
> > > 1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 103807587dc6..9017e4ed9d99 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1746,3 +1746,4 @@ MODULE_ALIAS("platform:dwc3");
> > > MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> > > MODULE_LICENSE("GPL v2");
> > > MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> > > +MODULE_SOFTDEP("pre: xhci_plat_hcd");
> > 
> > 
> > Your patch is corrupted and can not be applied :(
> 
> 
> I'm sorry to hear that. For me this works:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> cd linux
> curl "https://lore.kernel.org/lkml/20190321202303.GA1399@vis/raw" | git am -
> 
> But I found some archives that seems to have fiddled with the Content-Type
> of my signed mail, making it fail. Can you send more information about the
> corruption?

Maybe it works if I look at the raw email, but just from the above text,
your leading ' ' characters are dropped, so that's why I emailed you
this.

Let me go look at the message I received...

Ah, yeah, the raw message is correct, it just has a gpg signature which
messed with my email client's display somehow and dropped those leading
spaces.

Sorry for the noise, all is good.

greg k-h
