Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A512073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575391979;
	bh=9lhZiHfm0cFNL65g+4OVMkdlfm0IqJwsTBHm9mt3QQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sv2Hx9OdoWbyvi1+4ZEzUlbe+WgpEnGw0vmhesSoFSmsjGRz55R0AGrdhwZXuDt2R
	 7T6iHgJ+v57tHJsq9Y0I+gudQ2fds/h1Y7GY/fhONj2NaI/g69xf5F37XiWuMk6lsu
	 T0FOs6frhDlUANwcZObT7Y98S2lLLZHZqXkblq44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLCQw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:52:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40664 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLCQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:52:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so3569173lfy.7;
        Tue, 03 Dec 2019 08:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CINu8kwJ3/pozCYLOw1eHYh+k5bZA/5ppRAlDtMjvfg=;
        b=d4yeZutzdxhWfKAG1Q6/BMv2Skmai4ykwX8zAN58WR0pZoT3lvvrGGMZxMRJnbXZPP
         zooBLs5bIOvccAb4cNzpCnnkEGmJEf+qq0QEpyfqxHxTP7RlNrN8BuKzzakB/lJPQgAU
         yaUODYNJ6FgVkNGnjLScXoSadRx+VKdyWo+mvgS0qZeNBB/9SMJQeEnhmz3MIPVGA2kd
         W+beDR06MAExXRL9wmfGHHuB6EdcwzlSByoty/fnO5FaNmSy8tJeFMgQ7VBWNPcLAVKQ
         YGGjoLHThj3vzpSGPlAYtMGP1Q/QrlQB+JS9kozZVdJkL/vKoXMHCFClO9fMYhaM1bcL
         kjwQ==
X-Gm-Message-State: APjAAAW+rdWzM0lVoDCWlXAGFUvX8qZ3v/v9lmUCWE1L7qgdAI7M48a9
        x319OPhUJcTEUa6A2xMs4Ys=
X-Google-Smtp-Source: APXvYqx41aguGS+jp/QeI9IlKVT+iM1RPBrdRSa2hyDW+XXcFW87LhZHMu5KFyPepTNf1XrQRA5UFg==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr3322208lfi.141.1575391974516;
        Tue, 03 Dec 2019 08:52:54 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id g14sm1659970ljj.37.2019.12.03.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:52:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1icBQ5-000409-47; Tue, 03 Dec 2019 17:53:01 +0100
Date:   Tue, 3 Dec 2019 17:53:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        JohanHovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
Message-ID: <20191203165301.GH10631@localhost>
References: <20191203101552.199339-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203101552.199339-1-ikjn@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:15:52PM +0800, Ikjoon Jang wrote:
> This patch enables hub device to override its own endpoint descriptor's
> bInterval when the hub has a device node with "hub,interval" property.
> 
> When we know reducing autosuspend delay for built-in HIDs is better for
> power saving, we can reduce it to the optimal value. But if a parent hub
> has a long bInterval, mouse lags a lot from more frequent autosuspend.
> So this enables overriding bInterval for a hard wired hub device only
> when we know that reduces the power consumption.

I think I saw you argue about why this shouldn't simply be configured at
runtime. Please include that here too, I can't seem to remember why...

> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  drivers/usb/core/config.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 5f40117e68e7..95ec5af42a1c 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -6,6 +6,7 @@
>  #include <linux/usb.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/of.h>
>  #include <linux/usb/quirks.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -257,6 +258,14 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
>  	memcpy(&endpoint->desc, d, n);
>  	INIT_LIST_HEAD(&endpoint->urb_list);
>  
> +	/* device node property overrides bInterval */
> +	if (usb_of_has_combined_node(to_usb_device(ddev))) {

Not only hubs have combined nodes so you probably need to check
bDeviceClass here instead.

> +		u32 interval = 0;
> +		if (!of_property_read_u32(ddev->of_node, "hub,interval",
> +				    &interval))
> +			d->bInterval = min_t(u8, interval, 255);

You want min_t(u32, ...) here to avoid surprises when someone specifies
a value > 255.

> +	}
> +
>  	/*
>  	 * Fix up bInterval values outside the legal range.
>  	 * Use 10 or 8 ms if no proper value can be guessed.

Johan
