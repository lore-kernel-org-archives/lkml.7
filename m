Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B3EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40B920882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KWOOycTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfL0QB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:01:58 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47524 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0QB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oC1oWMRNSivJvaHH6O8/h96cNGNhL9U+Xzh7qNQOqwE=; b=KWOOycTeiM4eLSlZofOZDcCjb
        ZXnWKSozQ8RV3OcmKTHktUd8FSpUfMbmc+bfk4CCR0W1c1IDfzT/x3JXjikjx/XaKbnJAPSo0Ka0/
        EXG5Pm5AS6CnhCxBFbo1zVve3r6Cq69QUW/YP/NivR4wL+IjEyoazDP72+sKyO0L+KFrS4VAXLPrI
        0irnNFgsslxCSLJheD77hRnFe4svwvyRiQxLM3gEjedlae17f4oLt56uywQHGUu6RYSaT5+Ut8cHz
        9e4VkGSxeD/6Aitv1R+iG7LLyLGM/YF5PGw+/7aPw8vdPJ3uH092lX/FNz/MfLlJ4KkcB2dvR0qxC
        NTjWdsYVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58690)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iks3d-0002RL-Ao; Fri, 27 Dec 2019 16:01:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iks3b-0004sG-0o; Fri, 27 Dec 2019 16:01:43 +0000
Date:   Fri, 27 Dec 2019 16:01:42 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     nsekhar@ti.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] board-dm644x-evm: fix 2 missing-check bugs in
 evm_led_setup()
Message-ID: <20191227160142.GW25745@shell.armlinux.org.uk>
References: <20191227023921.GA21233@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227023921.GA21233@zhanggen-UX430UQ>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 10:39:21AM +0800, Gen Zhang wrote:
> In evm_led_setup(), the allocation result of platform_device_alloc() and 
> platform_device_add_data() should be checked.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 9d87d4e..9cd2785 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -352,15 +352,20 @@ evm_led_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
>  	 * device unregistration ...
>  	 */
>  	evm_led_dev = platform_device_alloc("leds-gpio", 0);
> -	platform_device_add_data(evm_led_dev,
> +	if (!evm_led_dev)
> +		return -ENOMEM;
> +	status = platform_device_add_data(evm_led_dev,
>  			&evm_led_data, sizeof evm_led_data);
> +	if (status)
> +		goto err;
>  
>  	evm_led_dev->dev.parent = &client->dev;
>  	status = platform_device_add(evm_led_dev);
> -	if (status < 0) {
> -		platform_device_put(evm_led_dev);
> -		evm_led_dev = NULL;
> -	}
> +	if (status)
> +		goto err;
> +err:
> +	platform_device_put(evm_led_dev);
> +	evm_led_dev = NULL;

Please look again at the above change very closely. You will want to
send an updated patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
