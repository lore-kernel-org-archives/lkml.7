Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19704C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7D72252B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4kojKEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfKTNpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:45:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45614 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbfKTNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:45:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so21224304qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UyxuxmxImlUdV6zHQGJ06NC25bjtzoqkkhU8rYqgdo=;
        b=u4kojKEMNq+NIJgjFysH9QOnDjFv8cvxJtkDBxPmoX9dPtPTtMh450iGqlNrRcYVwf
         S5msvMuOI7czflrDvqAbguWXiRU2qLrWjzlb6PNtUSNd2kjiz6VxzSW5j429u7EA3H3a
         zNfc4l8ZWMPLgrBsN0F/rcbOoeYhi9zQiKbfgs3e6YAwuIhe9WPVnj6sk7/UlG2a0qHB
         z16rIAQjLGIdfCiIk0dHibTuoHVxeMK87XnguLt4TRNd6Pa6J5cSFFm/vGCtKJ7OVXE3
         upkB+KBUDBZNRugYpIg2meqx1Uz2e+jgHcrgiD/AnEiLZ8w4mxWYillfHZUXye+Ggr+F
         5OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UyxuxmxImlUdV6zHQGJ06NC25bjtzoqkkhU8rYqgdo=;
        b=TP/aZ6RjVRRdL6Gg3k+INymxWXnzBgrv4AVg/pjaZaTy7egXAclbRMZOcapM+osZ5r
         ysWK7ERE9UH2H9SLxGpPikDMNWakm+9RzfG/Sb74M/E/1M9v5y2nZmTeawLKzsMRidfC
         cE2Vk4WHeOfeAnyzpiZUAz4hsAwEfsjlUN+18ZrhS9iUi0eks8EdliPqBrA2W+Ds93Wu
         0lNMwc6kEHazW6VRFY59yftNfPq9Ue8cnVyuwUe8rmTuZfIAzOGKKy7wXv7vIZ9Ibrm9
         UuTZPUWPEwg9nHBxPyTGYifONfztPbX7uzVRYRiVA3YEugnRpxRgLvUKICsf2t3Ww413
         /Bwg==
X-Gm-Message-State: APjAAAWqH8JqkidYSdVTPV3evkdS5HXCl3SHp/SplZnmRtNRrfCQTl9L
        AgOCLILzpqKQEWpOs4/ndSrmDQ==
X-Google-Smtp-Source: APXvYqyhLkOpqX04Zv3575puz7F0gB0sdprqkx8HCY/U/VcEvqlM3VT8sHJzs5dMTVaYr/YF2CMZkA==
X-Received: by 2002:ae9:e501:: with SMTP id w1mr2334470qkf.271.1574257549958;
        Wed, 20 Nov 2019 05:45:49 -0800 (PST)
Received: from pine ([2603:3005:3403:7100::715b])
        by smtp.gmail.com with ESMTPSA id k26sm13483064qtm.10.2019.11.20.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:45:49 -0800 (PST)
Date:   Wed, 20 Nov 2019 08:45:46 -0500
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video: Fix Kconfig indentation
Message-ID: <20191120134546.GA2654@pine>
References: <20191120133838.13132-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133838.13132-1-krzk@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:38:38PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

No particular objections but I wonder if this would be better sent to
trivial@kernel.org .


Daniel.

> ---
>  drivers/video/backlight/Kconfig |  8 ++--
>  drivers/video/console/Kconfig   | 76 ++++++++++++++++-----------------
>  2 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 403707a3e503..95e2000c1491 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -9,7 +9,7 @@ menu "Backlight & LCD device support"
>  # LCD
>  #
>  config LCD_CLASS_DEVICE
> -        tristate "Lowlevel LCD controls"
> +	tristate "Lowlevel LCD controls"
>  	help
>  	  This framework adds support for low-level control of LCD.
>  	  Some framebuffer devices connect to platform-specific LCD modules
> @@ -141,10 +141,10 @@ endif # LCD_CLASS_DEVICE
>  # Backlight
>  #
>  config BACKLIGHT_CLASS_DEVICE
> -        tristate "Lowlevel Backlight controls"
> +	tristate "Lowlevel Backlight controls"
>  	help
>  	  This framework adds support for low-level control of the LCD
> -          backlight. This includes support for brightness and power.
> +	  backlight. This includes support for brightness and power.
>  
>  	  To have support for your specific LCD panel you will have to
>  	  select the proper drivers which depend on this option.
> @@ -272,7 +272,7 @@ config BACKLIGHT_APPLE
>         tristate "Apple Backlight Driver"
>         depends on X86 && ACPI
>         help
> -         If you have an Intel-based Apple say Y to enable a driver for its
> +	 If you have an Intel-based Apple say Y to enable a driver for its
>  	 backlight.
>  
>  config BACKLIGHT_TOSA
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index c10e17fb9a9a..ac3a28c08f78 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -27,7 +27,7 @@ config VGACON_SOFT_SCROLLBACK
>         depends on VGA_CONSOLE
>         default n
>         help
> -         The scrollback buffer of the standard VGA console is located in
> +	 The scrollback buffer of the standard VGA console is located in
>  	 the VGA RAM.  The size of this RAM is fixed and is quite small.
>  	 If you require a larger scrollback buffer, this can be placed in
>  	 System RAM which is dynamically allocated during initialization.
> @@ -84,12 +84,12 @@ config MDA_CONSOLE
>  	  If unsure, say N.
>  
>  config SGI_NEWPORT_CONSOLE
> -        tristate "SGI Newport Console support"
> +	tristate "SGI Newport Console support"
>  	depends on SGI_IP22 && HAS_IOMEM
> -        select FONT_SUPPORT
> -        help
> -          Say Y here if you want the console on the Newport aka XL graphics
> -          card of your Indy.  Most people say Y here.
> +	select FONT_SUPPORT
> +	help
> +	  Say Y here if you want the console on the Newport aka XL graphics
> +	  card of your Indy.  Most people say Y here.
>  
>  config DUMMY_CONSOLE
>  	bool
> @@ -97,24 +97,24 @@ config DUMMY_CONSOLE
>  	default y
>  
>  config DUMMY_CONSOLE_COLUMNS
> -        int "Initial number of console screen columns"
> -        depends on DUMMY_CONSOLE && !ARM
> -        default 160 if PARISC
> -        default 80
> -        help
> -          On PA-RISC, the default value is 160, which should fit a 1280x1024
> -          monitor.
> -          Select 80 if you use a 640x480 resolution by default.
> +	int "Initial number of console screen columns"
> +	depends on DUMMY_CONSOLE && !ARM
> +	default 160 if PARISC
> +	default 80
> +	help
> +	  On PA-RISC, the default value is 160, which should fit a 1280x1024
> +	  monitor.
> +	  Select 80 if you use a 640x480 resolution by default.
>  
>  config DUMMY_CONSOLE_ROWS
> -        int "Initial number of console screen rows"
> -        depends on DUMMY_CONSOLE && !ARM
> -        default 64 if PARISC
> -        default 25
> -        help
> -          On PA-RISC, the default value is 64, which should fit a 1280x1024
> -          monitor.
> -          Select 25 if you use a 640x480 resolution by default.
> +	int "Initial number of console screen rows"
> +	depends on DUMMY_CONSOLE && !ARM
> +	default 64 if PARISC
> +	default 25
> +	help
> +	  On PA-RISC, the default value is 64, which should fit a 1280x1024
> +	  monitor.
> +	  Select 25 if you use a 640x480 resolution by default.
>  
>  config FRAMEBUFFER_CONSOLE
>  	bool "Framebuffer Console support"
> @@ -130,11 +130,11 @@ config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
>         depends on FRAMEBUFFER_CONSOLE
>         default n
>         ---help---
> -         If this option is selected, the framebuffer console will
> -         automatically select the primary display device (if the architecture
> +	 If this option is selected, the framebuffer console will
> +	 automatically select the primary display device (if the architecture
>  	 supports this feature).  Otherwise, the framebuffer console will
> -         always select the first framebuffer driver that is loaded. The latter
> -         is the default behavior.
> +	 always select the first framebuffer driver that is loaded. The latter
> +	 is the default behavior.
>  
>  	 You can always override the automatic selection of the primary device
>  	 by using the fbcon=map: boot option.
> @@ -145,11 +145,11 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>         bool "Framebuffer Console Rotation"
>         depends on FRAMEBUFFER_CONSOLE
>         help
> -         Enable display rotation for the framebuffer console.  This is done
> -         in software and may be significantly slower than a normally oriented
> -         display.  Note that the rotation is done at the console level only
> -         such that other users of the framebuffer will remain normally
> -         oriented.
> +	 Enable display rotation for the framebuffer console.  This is done
> +	 in software and may be significantly slower than a normally oriented
> +	 display.  Note that the rotation is done at the console level only
> +	 such that other users of the framebuffer will remain normally
> +	 oriented.
>  
>  config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	bool "Framebuffer Console Deferred Takeover"
> @@ -163,14 +163,14 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	  black screen as soon as fbcon loads.
>  
>  config STI_CONSOLE
> -        bool "STI text console"
> +	bool "STI text console"
>  	depends on PARISC && HAS_IOMEM
> -        select FONT_SUPPORT
> -        default y
> -        help
> -          The STI console is the builtin display/keyboard on HP-PARISC
> -          machines.  Say Y here to build support for it into your kernel.
> -          The alternative is to use your primary serial port as a console.
> +	select FONT_SUPPORT
> +	default y
> +	help
> +	  The STI console is the builtin display/keyboard on HP-PARISC
> +	  machines.  Say Y here to build support for it into your kernel.
> +	  The alternative is to use your primary serial port as a console.
>  
>  endmenu
>  
> -- 
> 2.17.1
> 
