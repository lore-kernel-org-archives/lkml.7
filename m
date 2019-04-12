Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1516EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADB92171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mkrryVkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDLKcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:32:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48596 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:32:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CAWEAX051748;
        Fri, 12 Apr 2019 05:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555065134;
        bh=/xfSaZ1QRl+hHQhdhFBw9Ok1kkvfuJN2/FbjpR69m2w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mkrryVkZpE4l27xD5xBLVtI2xG3WQ9SYfDcGP/DCB/QkWsFlZpf7oCaONDNJl88tn
         wmkJwP61gbNw89UAbcHJKBsnYOEXWBpha0hXentMb9hQ66Kx3RCuKKCHz6bYEULaiQ
         2h2rb8zkId/J/Ystb8pcOeL1xmdk3fu3HygemauM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CAWECt070241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 05:32:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 05:32:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 05:32:14 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CAWBFZ056757;
        Fri, 12 Apr 2019 05:32:12 -0500
Subject: Re: [PATCH v4 6/6] usb: ohci-da8xx: drop the vbus GPIO
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190411093024.23555-1-brgl@bgdev.pl>
 <20190411093024.23555-7-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5bd92c5a-86e4-6779-6035-f9a0b33917e9@ti.com>
Date:   Fri, 12 Apr 2019 16:02:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411093024.23555-7-brgl@bgdev.pl>
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
> @@ -209,9 +197,7 @@ static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
>  	int ret;
>  
>  	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
> -		if (da8xx_ohci->vbus_gpio) {
> -			gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
> -		} else if (da8xx_ohci->vbus_reg) {
> +		if (da8xx_ohci->vbus_reg) {
>  			ret = regulator_disable(da8xx_ohci->vbus_reg);
>  			if (ret)
>  				dev_err(dev,

You can now reduce a level of indentation here by doing

	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio) &&
	    da8xx_ohci->vbus_reg) {
		ret = regulator_disable(da8xx_ohci->vbus_reg);
		if (ret)
			dev_err(dev, "Failed to disable regulator: %d\n",
				ret);
	}

Thanks
Sekhar
