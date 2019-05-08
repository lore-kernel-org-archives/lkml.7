Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0E121726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfEHQu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:50:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40424 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728647AbfEHQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:50:28 -0400
Received: (qmail 5609 invoked by uid 2102); 8 May 2019 12:50:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2019 12:50:27 -0400
Date:   Wed, 8 May 2019 12:50:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
cc:     Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Suresh Gupta <suresh.gupta@freescale.com>
Subject: Re: [PATCH v5 4/5] usb: host: Stops USB controller init if PLL fails
 to lock
In-Reply-To: <20190508060608.33882-4-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1905081248440.1699-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019, Yinbo Zhu wrote:

> From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> 
> USB erratum-A006918 workaround tries to start internal PHY inside
> uboot (when PLL fails to lock). However, if the workaround also
> fails, then USB initialization is also stopped inside Linux.
> Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
> node in device-tree. Presence of this node in device-tree is
> used to stop USB controller initialization in Linux
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v5:
> 		use dev_warn() instead of pr_warn()
> 
>  drivers/usb/host/ehci-fsl.c      |    5 +++++
>  drivers/usb/host/fsl-mph-dr-of.c |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 1634ac8..90550a6 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -236,6 +236,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  		portsc |= PORT_PTS_PTW;
>  		/* fall through */
>  	case FSL_USB2_PHY_UTMI:
> +		if (pdata->has_fsl_erratum_a006918) {
> +			dev_warn(dev, "USB PHY clock invalid\n");
> +			return -EINVAL;
> +		}
> +

You need to add a "Fall through" comment between these two cases.

>  	case FSL_USB2_PHY_UTMI_DUAL:
>  		/* PHY_CLK_VALID bit is de-featured from all controller
>  		 * versions below 2.4 and is to be checked only for

Alan Stern

