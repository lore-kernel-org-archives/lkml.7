Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F820883
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCXQ3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:29:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:47990 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfCXQ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:29:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 09:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="155357905"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2019 09:29:04 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h85zc-0003nt-E5; Sun, 24 Mar 2019 18:29:04 +0200
Date:   Sun, 24 Mar 2019 18:29:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: 8250: fix a missing check for pci_ioremap_bar
Message-ID: <20190324162904.GH9224@smile.fi.intel.com>
References: <20190324160901.23001-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324160901.23001-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:09:00AM -0500, Aditya Pakki wrote:
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.

Thanks for an update.
Almost, but one think below.

> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
> v2: Failed to release resource in exit path and incorrect code in non
> DMA case, suggested by Andy Shevchenko
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..7889b2552013 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  	int ret;
>  
>  	chip->dev = &pdev->dev;
> +	chip->pdata = &qrk_serial_dma_pdata;
>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> -	chip->pdata = &qrk_serial_dma_pdata;
> +	if (!chip->regs)
> +		return;
>  
>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);
> @@ -199,6 +201,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  
>  	if (!param->dma_dev)
>  		return;

> +	pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);

This will fail the DMA driver ->remove() badly.
You need to do this after removal of DMA itself.
See the symmetry with setup above?

>  	dw_dma_remove(&lpss->dma_chip);

...put it here.
Don't forget to separate from above with blank line.

-- 
With Best Regards,
Andy Shevchenko


