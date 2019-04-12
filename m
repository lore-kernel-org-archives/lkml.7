Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4472171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DWh4NBZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfDLKj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:39:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49262 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:39:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CAdHvN054033;
        Fri, 12 Apr 2019 05:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555065557;
        bh=pGmkMFZyA1iAhFzWS7v56JDSKk1xDXLjmYUA9FEMtIY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DWh4NBZzybLz0eBiZUpRbcCKYJ7qDjlfrs11slTWouf15EB0eg8qwZILpAQpJhWVn
         W2AVPP07TZU1mY7GbjrkLt9mGGxlrkKOmqaQKNxmVkgCl16wpj/epcSSVL6dR7NyMi
         regCkeHg+7HE8wuJ/foHgv60lRojOW6teRF1+DmI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CAdHoM109692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 05:39:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 05:39:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 05:39:16 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CAdDJu066203;
        Fri, 12 Apr 2019 05:39:14 -0500
Subject: Re: [PATCH v4 3/6] usb: ohci-da8xx: disable the regulator if the
 overcurrent irq fired
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190411093024.23555-1-brgl@bgdev.pl>
 <20190411093024.23555-4-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <4a022050-73ad-cbed-bf30-416abb2196e0@ti.com>
Date:   Fri, 12 Apr 2019 16:09:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411093024.23555-4-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 11/04/19 3:00 PM, Bartosz Golaszewski wrote:
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

I thought a bit on whether it makes sense to merge this patch into 6/6
since that is modifying some code you introduce here. But I think its
probably better to keep it separate like you have it now.

6/6 is about dropping support for vbus gpio, where as here you are
letting regulator be used for handing overcurrent detected using oci gpio.

Having it separate makes it possible to revert dropping support for vbus
gpio while keeping this functionality ;)

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

Unnecessary empty line here, that too one that introduces white space
error. Please drop.

Thanks,
Sekhar
