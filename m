Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17F72231F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565197010;
	bh=hvVL8ffc/jpc+bF4/4PHu60D06JAOf/K78E9+2Cf9VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qHQop3cFpni1Q5Ar8HYLj33FEy9c6FaXNu94at2e1UBentZf9/O6rKfasoEfw3Tlj
	 t48RzhfWrgxRdJbK2jPTQgZsKJDCp26s6Tg7etjIMs+uSXKUEXVr4lVag+eANfgxAw
	 y5f/9gRzBT2wEsMZsHmyX+R4IGUSabRKCTVc18Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfHGQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbfHGQ4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:56:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128DA222FC;
        Wed,  7 Aug 2019 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565197008;
        bh=hvVL8ffc/jpc+bF4/4PHu60D06JAOf/K78E9+2Cf9VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkB1X1iSl56LQP0CBIj5/L1p7RUnNbaRbYHyuBNqZBjc6i2nazIdJ5qcCCP/LJY0i
         dW9wJ0yKIT6CwqGXaPDJKk/WkPMNzesKuItpcDpzHmSWVFsc4YMpt9MMJf/ZsaFKR5
         N1wzPceAsL2UfeGslE7K62fzZnnAwBV3SH5To17o=
Date:   Wed, 7 Aug 2019 18:56:46 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Message-ID: <20190807165646.GA6584@kroah.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
 <20190806184042.GA26041@kroah.com>
 <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:42:17PM +0000, Stefan-gabriel Mirea wrote:
> On 8/6/2019 9:40 PM, gregkh@linuxfoundation.org wrote:
> > On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:
> >> On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:
> >>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >>>>
> >>>> +/* Freescale Linflex UART */
> >>>> +#define PORT_LINFLEXUART     121
> >>>
> >>> Do you really need this modified?
> >>
> >> Hello Greg,
> >>
> >> This macro is meant to be assigned to port->type in the config_port
> >> method from uart_ops, in order for verify_port to know if the received
> >> serial_struct structure was really targeted for a LINFlex port. It
> >> needs to be defined outside, to avoid "collisions" with other drivers.
> > 
> > Yes, I know what it goes to, but does anyone in userspace actually use
> > it?
> 
> No, we do not use it from userspace, but kept the pattern only for
> conformance.
> 
> >> Other than that, I do not see anything wrong with the addition of a
> >> define in serial_core.h for this purpose (which is also what most of the
> >> serial drivers do, including amba-pl011.c, mentioned in
> >> Documentation/driver-api/serial/driver.rst as providing the reference
> >> implementation), so please be more specific.
> > 
> > I am getting tired of dealing with merge issues with that list, and no
> > one seems to be able to find where they are really needed for userspace,
> > especially for new devices.  What happens if you do not have use it?
> 
> I see. If I drop its usage completely and leave 'type' from the
> uart_port as 0, uart_port_startup() will fail when finding that
> uport->type == PORT_UNKNOWN at [1] (there may be other effects as well,
> e.g. due to the check in uart_configure_port[2]).
> 
> So I suppose that I need to define some nonzero 'PORT_KNOWN' macro in
> the driver and use that one internally for 'type'. Is my understanding
> correct? Will there be any problems if I define it to a positive integer
> which is already assigned to another driver, according to serial_core.h?

Ugh, ok, that's messy, nevermind.  Keep the #define in there, I will try
to figure out how to move all of these at once sometime in the future...

sorry for the noise.

greg k-h
