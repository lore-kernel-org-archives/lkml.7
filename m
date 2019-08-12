Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E9BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C372206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHLL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:57:32 -0400
Received: from verein.lst.de ([213.95.11.211]:47706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfHLL5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:57:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DBBD227A81; Mon, 12 Aug 2019 13:57:26 +0200 (CEST)
Date:   Mon, 12 Aug 2019 13:57:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>,
        Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Geoff Levand <geoff@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-usb@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
        iommu@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Bin Liu <b-liu@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 3/6] usb: add a HCD_DMA flag instead of guestimating
 DMA capabilities
Message-ID: <20190812115726.GA9180@lst.de>
References: <20190811080520.21712-1-hch@lst.de> <20190811080520.21712-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811080520.21712-4-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
> index 576f7d79ad4e..9d17e0695e35 100644
> --- a/drivers/usb/host/ehci-ppc-of.c
> +++ b/drivers/usb/host/ehci-ppc-of.c
> @@ -31,7 +31,7 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
>  	 * generic hardware linkage
>  	 */
>  	.irq			= ehci_irq,
> -	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
> +	.flags			= HCD_MEMORY | HC_DMA | HCD_USB2 | HCD_BH,

FYI, the kbuild bot found a little typo here, so even for the unlikely
case that the series is otherwise perfect I'll have to resend it at
least once.
