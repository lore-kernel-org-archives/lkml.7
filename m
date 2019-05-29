Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F22C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BA822AED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137473;
	bh=TDyNtlz445V2KfqCvU5AeZnbIE1PFnUssf6X86CEbM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZHlqV5ftiDJh5qlBAI91BgCSQcpPglCDCju1C7W7KWLEe1WmbxbZxZ0yCT7TUPRFe
	 r7hIysBAATEzmgATdesOn/y1Ot3ZZ8h2rLAvIsi/XumT7qDdPw2AVk1G3pfy5Ez9ah
	 Th+imYE4EwqF92tAORqCLl7bar6nuS3zUznYICrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfE2Noc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:44:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42222 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2Noc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:44:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so2103082lfh.9;
        Wed, 29 May 2019 06:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyDp/Sea9Ytj79ykUYdPjN3F1ceX0kmZop3ND/MuQ8k=;
        b=Ezn75/K23ZKYppz1TPsH5dr9ZLefX4v+6+1FttqhEPObxCSFV/F73dB30hx/XJYdTq
         M6E1/yxSQkqfAGnogEbn1cZw/lqkL5RYHWu6qLwr0MKPbISxxS7ezfvI9UFkbGSrbxBM
         qWENxt+ue9YPhi1whEWCR9svk/2pln81brry5p1UAC06E/3txFZKBCuXkKvrKwlFHjYj
         2aUL1G5HwkIlGWx7yIB9DAMUiF7mySNxZ8udH8XPORxLt6ZGR3PFGbeudpbdwCKJkcmU
         k98jtRk1D2YpJf7shdd3rQla0JxnW/jeymkjkPUmZWZ50F5oU3LNubq+azzKikYPIskB
         k5xA==
X-Gm-Message-State: APjAAAUNKPsbygRx5aep6544KDqEvRtdGKjLLFpn5uh8juV4QB7cPC/n
        GZvRi9LOZzubNcbCKNqIhfM=
X-Google-Smtp-Source: APXvYqyRdWhNSYk7M2iTK+aQ8Fl6loE39UE8WgE0C4Ft4MsJbrZrFuqdmPun7lzQzXH0UPfHycNM2A==
X-Received: by 2002:ac2:494f:: with SMTP id o15mr4449106lfi.22.1559137470075;
        Wed, 29 May 2019 06:44:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p5sm3434957lfc.80.2019.05.29.06.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:44:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hVysd-00084k-KS; Wed, 29 May 2019 15:44:35 +0200
Date:   Wed, 29 May 2019 15:44:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2 v3] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190529134435.GR568@localhost>
References: <20190527111805.876-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111805.876-1-sr@denx.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:18:04PM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> v3:
> - No change
> 
> v2:
> - Include the problem description and analysis from Mika into the commit
>   text, as suggested by Greg.
> 
>  drivers/tty/serial/serial_mctrl_gpio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 39ed56214cd3..cac50b20a119 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -116,6 +116,13 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>  
>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);

Where's the corresponding kfree?

> +		if (!device_property_present(dev, gpio_str))
> +			continue;
>  
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags = GPIOD_OUT_LOW;

Johan
