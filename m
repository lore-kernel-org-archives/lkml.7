Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F89C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E4720818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565116882;
	bh=u1x4R5iUanTwInCID5PwGTrmyW23jOXOmyoOOvc4ERA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aC39N2gVCiIgaz+I17oNEGBzaCpmYvxg6ZzCE7N3es3v9/5uJIwfID7PeZWJacipS
	 ndOLMuwdN3h2QPJEwCTdNdik3adnoK+3VZt70yZf+YgVl576qbPMr8STLAclnljFdi
	 iR8ojWVBUE6ylMx/fyDJO4NFYYVfrKvS76ZNtWbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfHFSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfHFSkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C1120818;
        Tue,  6 Aug 2019 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565116844;
        bh=u1x4R5iUanTwInCID5PwGTrmyW23jOXOmyoOOvc4ERA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3bxmHgVSZOVnoqiuGhDKNBmuYYh0uuCp6Y1rh99th1Z9FIUYrg5RIIvgqAUNT2KI
         ZS2B2vSpvb845Qx10KpHQAtMMTHeYD1Mp/YQ1cIff7Gn79tPvtnPj/Yb7hQVHCMtVD
         K0NCzYURphpm5+cWg0U71eUEriCKwUDCdL6mBrcY=
Date:   Tue, 6 Aug 2019 20:40:42 +0200
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
Message-ID: <20190806184042.GA26041@kroah.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:
> On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:
> > On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >>
> >> +/* Freescale Linflex UART */
> >> +#define PORT_LINFLEXUART     121
> > 
> > Do you really need this modified?
> 
> Hello Greg,
> 
> This macro is meant to be assigned to port->type in the config_port
> method from uart_ops, in order for verify_port to know if the received
> serial_struct structure was really targeted for a LINFlex port. It
> needs to be defined outside, to avoid "collisions" with other drivers.

Yes, I know what it goes to, but does anyone in userspace actually use
it?

> As far as I see, uart_set_info() will actually fail at the
> "baud_base < 9600" check[1], right after calling verify_port(), when
> performing an ioctl() on "/dev/console" with TIOCSSERIAL using a
> serial_struct obtained with TIOCGSERIAL. This happens because this
> reduced version of the LINFlex UART driver will not touch the uartclk
> field of the uart_port (as there is currently no clock support).
> Therefore, the linflex_config/verify_port() functions, along with the
> PORT_LINFLEXUART macro, may be indeed unnecessary at this point (and
> should be added later). Is this what you mean?

No, see below.

> Other than that, I do not see anything wrong with the addition of a
> define in serial_core.h for this purpose (which is also what most of the
> serial drivers do, including amba-pl011.c, mentioned in
> Documentation/driver-api/serial/driver.rst as providing the reference
> implementation), so please be more specific.

I am getting tired of dealing with merge issues with that list, and no
one seems to be able to find where they are really needed for userspace,
especially for new devices.  What happens if you do not have use it?

thanks,

greg k-h
