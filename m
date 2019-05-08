Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D8C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2531021530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557297703;
	bh=5VfiQakJiPGMt0g71UJ5S0pfbX5f2t20n5P1wQDvFN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h7PS81EVHv5Yw/KTv6fuPAtXRbhWXkP+EjZckPdvByFa+MoZ7okNO8tJO7HiLBJjv
	 BVkGNrV581vkYDwf2l98eXcpS93Y+/sdDbz1Sn9DJraP1cpu6tJAn3waqGWjRTjTv7
	 2YYwUwWwCwm8cwRiGefln49lSmxp2lqhbwwlYmx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEHGlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfEHGll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:41:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD52B20989;
        Wed,  8 May 2019 06:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557297700;
        bh=5VfiQakJiPGMt0g71UJ5S0pfbX5f2t20n5P1wQDvFN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDLkuPR8VSii4fjwWcMr9fg94ONMRB5hpJvnSa87Oa3hccuRy32pBGb4LyAT15yzk
         QV2aHRueURg58IZDAB42Hl2SDF1WgLagWJ/wekP/lgRSUmZLXTObbo1Ukdorou8E2V
         eucffPVgoDqKyyF/aU2biwBn8het3WJLzcHPlAyU=
Date:   Wed, 8 May 2019 08:41:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suresh Gupta <B42813@freescale.com>
Subject: Re: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
Message-ID: <20190508064138.GD14085@kroah.com>
References: <20190125060356.14294-2-yinbo.zhu@nxp.com>
 <Pine.LNX.4.44L0.1901281034080.1450-100000@iolanthe.rowland.org>
 <VI1PR04MB4158EB9135C9536D612F0967E9320@VI1PR04MB4158.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4158EB9135C9536D612F0967E9320@VI1PR04MB4158.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:26:09AM +0000, Yinbo Zhu wrote:
> 
> 
> > -----Original Message-----
> > From: Alan Stern [mailto:stern@rowland.harvard.edu]
> > Sent: 2019年1月28日 23:37
> > To: Yinbo Zhu <yinbo.zhu@nxp.com>
> > Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang <jerry.huang@nxp.com>;
> > Ran Wang <ran.wang_1@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Ramneek Mehresh
> > <ramneek.mehresh@freescale.com>; Nikhil Badola
> > <nikhil.badola@freescale.com>; Suresh Gupta <suresh.gupta@freescale.com>;
> > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Suresh Gupta
> > <B42813@freescale.com>
> > Subject: Re: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
> > 
> > On Fri, 25 Jan 2019, Yinbo Zhu wrote:
> > 
> > > From: Suresh Gupta <B42813@freescale.com>
> > >
> > > PHY_CLK_VALID bit for UTMI PHY in USBDR does not set even if PHY is
> > > providing valid clock. Workaround for this involves resetting of PHY
> > > and check PHY_CLK_VALID bit multiple times. If PHY_CLK_VALID bit is
> > > still not set even after 5 retries, it would be safe to deaclare that
> > > PHY clock is not available.
> > > This erratum is applicable for USBDR less then ver 2.4.
> > >
> > > Signed-off-by: Suresh Gupta <B42813@freescale.com>
> > > Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> > > ---
> > > Change in v4:
> > > 		Incorrect indentation of the continuation line.
> > > 		replace pr_err with dev_err.
> > >
> > >  drivers/usb/host/ehci-fsl.c |   38
> > +++++++++++++++++++++++++++-----------
> > >  drivers/usb/host/ehci-fsl.h |    3 +++
> > >  2 files changed, 30 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> > > index 38674b7..373a816 100644
> > > --- a/drivers/usb/host/ehci-fsl.c
> > > +++ b/drivers/usb/host/ehci-fsl.c
> > > @@ -183,6 +183,17 @@ static int fsl_ehci_drv_probe(struct platform_device
> > *pdev)
> > >  	return retval;
> > >  }
> > >
> > > +static bool usb_phy_clk_valid(struct usb_hcd *hcd) {
> > > +	void __iomem *non_ehci = hcd->regs;
> > > +	bool ret = true;
> > > +
> > > +	if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) & PHY_CLK_VALID))
> > > +		ret = false;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
> > >  			       enum fsl_usb2_phy_modes phy_mode,
> > >  			       unsigned int port_offset)
> > > @@ -226,6 +237,17 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
> > >  		/* fall through */
> > >  	case FSL_USB2_PHY_UTMI:
> > >  	case FSL_USB2_PHY_UTMI_DUAL:
> > > +		/* PHY_CLK_VALID bit is de-featured from all controller
> > > +		 * versions below 2.4 and is to be checked only for
> > > +		 * internal UTMI phy
> > > +		 */
> > > +		if (pdata->controller_ver > FSL_USB_VER_2_4 &&
> > > +		    pdata->have_sysif_regs && !usb_phy_clk_valid(hcd)) {
> > > +			dev_err(dev,
> > > +				"%s: USB PHY clock invalid\n", dev_name(dev));
> > 
> > This looks silly; it prints the device name twice (once because that's what
> > dev_err() does, and then again because you explicitly told it to print the device
> > name).
> > 
> > Look at how dev_err() is used in other parts of the driver and do the same thing.
> > 
> > > +			return -EINVAL;
> > > +		}
> > > +
> > >  		if (pdata->have_sysif_regs && pdata->controller_ver) {
> > >  			/* controller version 1.6 or above */
> > >  			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL); @@ -249,17
> > +271,11
> > > @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
> > >  		break;
> > >  	}
> > >
> > > -	/*
> > > -	 * check PHY_CLK_VALID to determine phy clock presence before writing
> > > -	 * to portsc
> > > -	 */
> > > -	if (pdata->check_phy_clk_valid) {
> > > -		if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) &
> > > -		    PHY_CLK_VALID)) {
> > > -			dev_warn(hcd->self.controller,
> > > -				 "USB PHY clock invalid\n");
> > > -			return -EINVAL;
> > > -		}
> > > +	if (pdata->have_sysif_regs &&
> > > +	    pdata->controller_ver > FSL_USB_VER_1_6 &&
> > > +		!usb_phy_clk_valid(hcd)) {
> > > +		dev_warn(hcd->self.controller, "USB PHY clock invalid\n");
> > 
> > Once again, you have a continuation line that is indented by the same amount as
> > the code in the inner block.  Please fix this properly.
> Hi Alan stern,
> 
> Above code indented is in oder to ensure that every line less than 80 characters,
> Otherwise, check-patch tool to check patch that will has error.

No, that's is not what Alan is asking you to do here.  Please fix this
up to match other multi-line if statements.

greg k-h
