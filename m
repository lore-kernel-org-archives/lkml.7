Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81DC34960
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1C246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269379;
	bh=YPaNCsm+FJvIWej38mWbBoe0T6D28xFUIWW4ft16uNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V4nUu39gIdUXwNThd3/o3UrLGuyLjoi2ojs0rOwwp4KX1nnrUtmhop2zWZ017vdWy
	 OXZfZ4opou5PsdZouvvaWJ69dLWffwattZ9oTpGPRCtN4W01mLqF1C1rz4/TZJTueT
	 v7Of0YyppUL5LHJ6ONXHqDxOXJYshTklTeBczoaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLMLRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:17:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33948 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:17:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so2146203ljc.1;
        Fri, 13 Dec 2019 03:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ec79d6Yr2kvkN4vFRH9LzqVSAfGcyBhOQq0QTx7vgs=;
        b=XZgcVO2YgeES1yrMQvmDWD1XbwatbF7kQY8JwWLifjD5ZWO1eOB8Ny6JMJeAgFv2j3
         2gTcAN4z13IB3xt7QSOVAtLIrfShDLqdumP/WeNW1NxpqTSvQQkkgCGqjkQvCSji7yl/
         19o5NcEKEcEbZi7zwbR9TVlIjOGo2UIR73LBL5QUlyWHBf/V+P/FT5d3lxgDgU63ipNO
         UbS0tECU3VwxHU1sNSWstmNpegJBLcj3b/BWl9roZx/t6iNea9FyIbqxLjJ51ns0npy5
         v5XO46yz2gNkC/bdK63xg75xARvB8FaRUqGzMVTTlB2r+lkfTQOyuJkNThbYGX2LCyfu
         0OSQ==
X-Gm-Message-State: APjAAAUnnFrRH7Zn0HomkpP+v6xoXOPA9a830HjMzzkM9teaYlie/aR6
        FT7so64OhDAgk3l5uAp+Z1ob8+tB
X-Google-Smtp-Source: APXvYqxtxcxwRs2X5RA/iW/6TivZ5ydkApaGeX1uTLayqUxNdjVNn2zi+i3IJuxiJX5rpfAd5+hF4g==
X-Received: by 2002:a05:651c:112d:: with SMTP id e13mr8042598ljo.99.1576235822451;
        Fri, 13 Dec 2019 03:17:02 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id t2sm4552700ljj.11.2019.12.13.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 03:17:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ifiwQ-0004Ws-G0; Fri, 13 Dec 2019 12:17:02 +0100
Date:   Fri, 13 Dec 2019 12:17:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
Message-ID: <20191213111702.GX10631@localhost>
References: <20191213105521.4290-1-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213105521.4290-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:55:21AM +0100, Guillaume La Roque wrote:
> Actually IRQ can be found from GPIO but all platforms don't support
> gpiod_to_irq, it's the case on amlogic chip.
> so to have possibility to use interrupt mode we need to add interrupts
> field in node and support it in driver.

"node" is a bit vague, please refer to devicetree here and in the patch
summary.

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index f8f5c593a05c..aa194f8d703e 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/property.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/platform_device.h>
> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>  #endif
>  	bcmdev->serdev_hu.serdev = serdev;
>  	serdev_device_set_drvdata(serdev, bcmdev);
> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);

And this clearly makes no sense for acpi, so you'd need to add it to
bcm_of_probe().

Shouldn't you be used using of_irq_get_byname()?

And since you're extending the binding, I think you need a preparatory
patch documenting this in:

	Documentation/devicetree/bindings/net/broadcom-bluetooth.txt

>  	/* Initialize routing field to an unused value */
>  	bcmdev->pcm_int_params[0] = 0xff;

Johan
