Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CC72168B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rethQCw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfL1Nsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:48:40 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33210 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1Nsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RCJmzul6XUbomXCbjxTYwriW9jA1/+w+3KTp2D3QCyw=; b=rethQCw+VAf1V48foed947eZr
        PlhqMB2wsoYmmGRB1tR2rLPNm+c8A+yp8OD3Iw0FTZam8Uwpc2N4eblDPNYxqQU2C/+OFSv8TcKsK
        JerjC3ctp4j/JibUeCBVYdSwBIXrDHW6Ildjm+hpc2dDLnFiw5ihiMjMEzUN0sDWr6am0k8C+7Hjn
        aLN+vTK0S6MASwbFGY/mg5gwGPAKOgODs6MYT7UD4S87ngS+hGC3Qd3BdKNZZSrI2kYYay3NId7iX
        8ESyKEqxBgaIMMCC20WThsuq/z8booLcmJyN1ihT0Tatd5ithZzY42NslIGRLd6yglwzHA7C3XSxO
        C+P+/EQoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59090)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ilCSD-000868-MD; Sat, 28 Dec 2019 13:48:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ilCS8-0005mL-6m; Sat, 28 Dec 2019 13:48:24 +0000
Date:   Sat, 28 Dec 2019 13:48:24 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     bgolaszewski@baylibre.com, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] board-dm644x-evm: fix 2 missing-check bugs in
 evm_led_setup()
Message-ID: <20191228134824.GX25745@shell.armlinux.org.uk>
References: <20191227023921.GA21233@zhanggen-UX430UQ>
 <20191227160142.GW25745@shell.armlinux.org.uk>
 <20191228131930.GA7214@zhanggen-UX430UQ.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228131930.GA7214@zhanggen-UX430UQ.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 09:19:30PM +0800, Gen Zhang wrote:
> On Fri, Dec 27, 2019 at 04:01:42PM +0000, Russell King - ARM Linux admin wrote:
> > On Fri, Dec 27, 2019 at 10:39:21AM +0800, Gen Zhang wrote:
> > > In evm_led_setup(), the allocation result of platform_device_alloc() and 
> > > platform_device_add_data() should be checked.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > ---
> > > diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > index 9d87d4e..9cd2785 100644
> > > --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > > +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > @@ -352,15 +352,20 @@ evm_led_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
> > >  	 * device unregistration ...
> > >  	 */
> > >  	evm_led_dev = platform_device_alloc("leds-gpio", 0);
> > > -	platform_device_add_data(evm_led_dev,
> > > +	if (!evm_led_dev)
> > > +		return -ENOMEM;
> > > +	status = platform_device_add_data(evm_led_dev,
> > >  			&evm_led_data, sizeof evm_led_data);
> > > +	if (status)
> > > +		goto err;
> > >  
> > >  	evm_led_dev->dev.parent = &client->dev;
> > >  	status = platform_device_add(evm_led_dev);
> > > -	if (status < 0) {
> > > -		platform_device_put(evm_led_dev);
> > > -		evm_led_dev = NULL;
> > > -	}
> > > +	if (status)
> > > +		goto err;
> > > +err:
> > > +	platform_device_put(evm_led_dev);
> > > +	evm_led_dev = NULL;
> > 
> > Please look again at the above change very closely. You will want to
> > send an updated patch.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
> 
> Thanks for your reply. You mean the if (state < 0 ) to if (state) or
> anything else? Please point out directly.

This is the old everything-successful path through the code:

	platform_device_alloc()
	platform_device_add_data()
	platform_device_add()
	evm_led_dev is set to the device

This is the new everything-successful path through the code:

	platform_device_alloc()
	platform_device_add_data()
	platform_device_add()
	platform_device_put()
	evm_led_dev = NULL

And, specifically, the code sequence (I quote from your patch):

	if (status)
		goto err;
err:

is very stupid; it might as well not exist at all.

Since other code references evm_led_dev, one can assume that we do
not want it to be NULL for the success path. So, taking all this
together, your patch is very very wrong, and I also find it very
worrying too.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
