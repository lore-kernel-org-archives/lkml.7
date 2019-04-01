Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37848C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD622070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2gb9iNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDAVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:10:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oV5murX2kiYm9mlhk9u52OViT+gEGIpRtBmJCwVzzFg=; b=E2gb9iNIeXJ2833rMTXW3OuFV
        uR6bJeKsaNJZB5NhjC83GhNbx7dhQmxTyRUyECpVb01AP3wKRhgLV3B9DnAO63LrlVFAVfq9sgl4o
        pKwcC68MXmPpP8163ItAIDp/1avH/FgIoTQCqN/B0qN/c9ZmPuVI7s4MU29xlD13plX2OFwbUcVkh
        sIrgrcYlBi6yL4+hqrMCbZvzA3wT/BIdlsbokt/vzOSIEUF11TBGWAV7M+VZL4l9JOERWEOV8tsmI
        3FOMOgeF4Dszl2mPHXxrjD2Nnspr06Bsj4/po/VaHx/UolVBoARosk0tk74WKqY/Pp0ScNKCxom6W
        4XhpfGxAw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hB4CT-0001cZ-TK; Mon, 01 Apr 2019 21:10:37 +0000
Subject: Re: [RFC PATCH 5/5] leds: multicolor: Introduce a multicolor class
 definition
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     marek.behun@nic.cz, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-6-dmurphy@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5f75eeed-41d5-e0d9-38f8-bf00c5045ba1@infradead.org>
Date:   Mon, 1 Apr 2019 14:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401173400.14238-6-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/19 10:34 AM, Dan Murphy wrote:
> Introduce a multicolor class that groups colored LEDs
> within a LED node.
> 
> The framework allows for dynamically setting individual LEDs
> or setting brightness levels of LEDs and updating them virtually
> simultaneously.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/Kconfig                 |  10 +
>  drivers/leds/Makefile                |   1 +
>  drivers/leds/led-class-multicolor.c  | 411 +++++++++++++++++++++++++++
>  include/linux/led-class-multicolor.h |  69 +++++
>  4 files changed, 491 insertions(+)
>  create mode 100644 drivers/leds/led-class-multicolor.c
>  create mode 100644 include/linux/led-class-multicolor.h
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..477e108fd2a7 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -29,6 +29,16 @@ config LEDS_CLASS_FLASH
>  	  for the flash related features of a LED device. It can be built
>  	  as a module.
>  
> +config LEDS_CLASS_MULTI_COLOR
> +	tristate "LED Mulit Color LED Class Support"

	              Multi

> +	depends on LEDS_CLASS
> +	help
> +	  This option enables the flash led sysfs class in /sys/class/leds.

	                                LED (?)

> +	  It wrapps LED Class and adds flash LEDs specific sysfs attributes

	     wraps

> +	  and kernel internal API to it. You'll need this to provide support
> +	  for the flash related features of a LED device. It can be built

	                                 of an LED device.

> +	  as a module.
> +
>  config LEDS_BRIGHTNESS_HW_CHANGED
>  	bool "LED Class brightness_hw_changed attribute support"
>  	depends on LEDS_CLASS


ciao.
-- 
~Randy
