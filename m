Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5225C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0782084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfDIRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:17:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46604 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726499AbfDIRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:17:45 -0400
Received: (qmail 5532 invoked by uid 2102); 9 Apr 2019 13:17:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Apr 2019 13:17:44 -0400
Date:   Tue, 9 Apr 2019 13:17:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 3/6] usb: ohci-da8xx: disable the regulator if the
 overcurrent irq fired
In-Reply-To: <20190409082855.15373-4-brgl@bgdev.pl>
Message-ID: <Pine.LNX.4.44L0.1904091316550.1599-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Historically the power supply management in this driver has been handled
> in two separate places in parallel. Device-tree users simply defined an
> appropriate regulator, while two boards with no DT support (da830-evm and
> omapl138-hawk) passed functions defined in their respective board files
> over platform data. These functions simply used legacy GPIO calls to
> watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
> fires.
> 
> Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> updated these GPIO calls to the modern API and moved them inside the
> driver.
> 
> This however is not the optimal solution for the vbus GPIO which should
> be modeled as a fixed regulator that can be controlled with a GPIO.
> 
> In order to keep the overcurrent protection available once we move the
> board files to using fixed regulators we need to disable the enable_reg
> regulator when the overcurrent indicator interrupt fires. Since we
> cannot call regulator_disable() from interrupt context, we need to
> switch to using a oneshot threaded interrupt.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/usb/host/ohci-da8xx.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index 9c6d1f03b871..108fe0a1b962 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -202,12 +202,24 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
>  	return 0;
>  }
>  
> -static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
> +static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
>  {
>  	struct da8xx_ohci_hcd *da8xx_ohci = data;
> +	struct device *dev = da8xx_ohci->hcd->self.controller;
> +	int ret;
>  
> -	if (gpiod_get_value(da8xx_ohci->oc_gpio))
> -		gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
> +	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
> +		if (da8xx_ohci->vbus_gpio) {
> +			gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
> +		} else if (da8xx_ohci->vbus_reg) {
> +			ret = regulator_disable(da8xx_ohci->vbus_reg);
> +			if (ret)
> +				dev_err(dev,
> +					"Failed to disable regulator: %d\n",
> +					ret);
> +		}
> +			
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -434,8 +446,9 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
>  		if (oc_irq < 0)
>  			goto err;
>  
> -		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
> -				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +		error = devm_request_threaded_irq(dev, oc_irq, NULL,
> +				ohci_da8xx_oc_thread, IRQF_TRIGGER_RISING |
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  				"OHCI over-current indicator", da8xx_ohci);
>  		if (error)
>  			goto err;
> 

Acked-by: Alan Stern <stern@rowland.harvard.edu>

