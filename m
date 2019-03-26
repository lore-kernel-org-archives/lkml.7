Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfCZKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:18:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:27400 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfCZKSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:18:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="143906223"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2019 03:17:59 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8j9a-0001DU-8i; Tue, 26 Mar 2019 12:17:58 +0200
Date:   Tue, 26 Mar 2019 12:17:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tty: 8250: fix a missing check for pci_ioremap_bar
Message-ID: <20190326101758.GV9224@smile.fi.intel.com>
References: <20190325222147.13342-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325222147.13342-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:21:46PM -0500, Aditya Pakki wrote:
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.

Thanks for an update.
One comment below.

After addressing it, take mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
> v5: change pci_iounmap to iounmap to pass kbuild errors in other arch
> v4: Missed resource release in dma_probe failure.
> v3: Change the order of pci_iounmap and dw_dma_remove
> v2: Failed to release resource in exit path and incorrect code in non
> DMA case, suggested by Andy Shevchenko
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..c7c7bf5d7e5e 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,14 +170,18 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
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
> -	if (ret)
> +	if (ret) {
> +		iounmap(chip->regs);
>  		return;
> +	}
>  
>  	pci_try_set_mwi(pdev);
>  
> @@ -199,7 +203,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  
>  	if (!param->dma_dev)
>  		return;
> +
>  	dw_dma_remove(&lpss->dma_chip);
> +
> +	iounmap(&lpss->dma_chip->regs);

This is a bit fragile form of writing. Perhaps

        struct dw_dma_chip *chip = &lpss->dma_chip;

	...
	dw_dma_remove(chip);

	iounmap(chip->regs);

>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


