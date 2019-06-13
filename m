Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F3CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445119;
	bh=Y7mdi6uFOuBO3QxKWlpKYM6bNyXkY1xifsM4T0q7N8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TI4JVEg0Yl1Ina91ny21BZtCEXedxNTAz/LjcLkVvl+4w5LPQLCzReKRBNBQdeIs3
	 6WxdDMwm4U6XtXBFhn7Efmu02Z7mxWUp4Pn5CS5argUsjeRRId1da6CbFVFdUtDSQr
	 WHseBM5dpXcklnCG7tC7fu54nttQOYKwQFSVVtQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393142AbfFMQ6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729884AbfFMApq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:45:46 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5143215EA;
        Thu, 13 Jun 2019 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560386745;
        bh=Y7mdi6uFOuBO3QxKWlpKYM6bNyXkY1xifsM4T0q7N8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7EpA5OokHKhhjL9gHwCJrcGLGApv/KADm67/XXDDdIrNY684DJbkzkOJPmVOjFQt
         ZLTdOzW6obAQYrYpwF+ZTMLvsVggKTzpNRFkS5JnUyX29Ah+W/ZcuK7JbuUrgVMB7J
         9jDWecsCijkiNcUINgXNm3wZHEfS8ExGt2NMokZo=
Date:   Thu, 13 Jun 2019 08:45:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     madalin.bucur@nxp.com, Rob Herring <robh+dt@kernel.org>,
        aisheng.dong@nxp.com, Vinod Koul <vkoul@kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
Message-ID: <20190613004508.GA20747@dragon>
References: <20190422183056.16375-1-leoyang.li@nxp.com>
 <20190510030525.GC15856@dragon>
 <CADRPPNT2G20j2pvSEyqX=_WNDPrcNR+xCR_XZukbnSW19wFLNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNT2G20j2pvSEyqX=_WNDPrcNR+xCR_XZukbnSW19wFLNA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:01:29PM -0500, Li Yang wrote:
> On Thu, May 9, 2019 at 10:15 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Apr 22, 2019 at 01:30:56PM -0500, Li Yang wrote:
> > > Enables the FSL EDMA driver by default.  This also works around an issue
> > > that imx-i2c driver keeps deferring the probe because of the DMA is not
> > > ready.  And currently the DMA engine framework can not correctly tell
> > > if the DMA channels will truly become available later (it will never be
> > > available if the DMA driver is not enabled).
> > >
> > > This will cause indefinite messages like below:
> > > [    3.335829] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > > [    3.344455] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> > > [    3.350917] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> > > [    3.362089] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > > [    3.370741] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> > > [    3.377205] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> > > [    3.388455] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > > .....
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> >
> > Applied, thanks.
> 
> Hi Shawn,
> 
> Is it possible to move this patch to the -fix series so that it can
> reach the mainline earlier?  It is having a boot failure in mainline
> for platforms using this device without this workaround.

Why would I2C device deferring cause boot failure on a platform?  I'm
just trying to understand severity of the problem.

Shawn
