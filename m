Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79C218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfGZL5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:57:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:18066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfGZL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:57:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 04:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="181843620"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2019 04:57:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hqyr4-0001Sf-QX; Fri, 26 Jul 2019 14:57:46 +0300
Date:   Fri, 26 Jul 2019 14:57:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>, emamd001@umn.edu,
        kjlu@umn.edu, smccaman@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 8250_lpss: check null return when calling
 pci_ioremap_bar
Message-ID: <20190726115746.GT9224@smile.fi.intel.com>
References: <20190719151519.GO9224@smile.fi.intel.com>
 <20190719174848.24216-1-navid.emamdoost@gmail.com>
 <CGME20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6@eucas1p2.samsung.com>
 <afc360b9-6d05-72a6-4933-2fc0b84a7cf7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc360b9-6d05-72a6-4933-2fc0b84a7cf7@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:32:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On 7/19/19 7:48 PM, Navid Emamdoost wrote:
> > pci_ioremap_bar may return null. This is eventually de-referenced at 
> > drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check 
> > is needed to prevent null de-reference. I am adding the check and in case
> >  of failure. Thanks to Andy Shevchenko for the hint on the necessity of 
> > pci_iounmap when exiting.

> > @@ -169,10 +169,12 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> >  	struct pci_dev *pdev = to_pci_dev(port->dev);
> >  	int ret;
> >  
> > +	chip->pdata = &qrk_serial_dma_pdata;
> >  	chip->dev = &pdev->dev;
> >  	chip->irq = pci_irq_vector(pdev, 0);
> >  	chip->regs = pci_ioremap_bar(pdev, 1);
> > -	chip->pdata = &qrk_serial_dma_pdata;
> > +	if (!chip->regs)
> > +		return;
> >  
> >  	/* Falling back to PIO mode if DMA probing fails */
> >  	ret = dw_dma_probe(chip);
> 
> pci_iounmap() should also be called on dw_dma_probe() failure (in such
> case param->dma_dev is NULL so pci_iounmap() in qrk_serial_exit_dma()
> won't be called during exit).

Oh, yes, good catch!
Navid, can you send a follow up fix?

> > @@ -195,11 +197,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> >  pci_iounmap
> >  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
> >  {
> > +	struct dw_dma_chip *chip = &lpss->dma_chip;
> >  	struct dw_dma_slave *param = &lpss->dma_param;
> >  
> >  	if (!param->dma_dev)
> >  		return;
> > -	dw_dma_remove(&lpss->dma_chip);
> > +
> > +	dw_dma_remove(chip);
> > +
> > +	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
> >  }

-- 
With Best Regards,
Andy Shevchenko


