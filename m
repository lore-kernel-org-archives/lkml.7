Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62041C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FEF218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1OIF+/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCPBn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:43:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37946 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCPBnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 21:43:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so7503437pfn.5;
        Fri, 15 Mar 2019 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1k0wj5ScUknjFJiFjOX8hnyLp9DFlmQAwewCKkzltU=;
        b=E1OIF+/KbIv+y7EBrCLAuOwcVU7qvuGdh/FLJag7stZkzEYJKExS1+eyrwP0bNNQ30
         jSR82dJzJG7wkL0d9UN4Yp1NBsygnh9dIqr1y/FuKh49Wkjh2hiGsdscUld7CmJuErZl
         xA6RfcdJJdwukHJmQhjEBaQDZw55VebJc1IXqwCkzhf4HKOHyo4vLbtHeKgOR9LJN+D5
         a35XKg0kR0cFPGek658AM+TjB1ao2wRCDb1F6KjlkyNRoCletch4h/e8YZzJMo0Y7Q/r
         NFLgFOFCiSo2GQe7N3oMeEEI2x8M3RqvCsxQYxMhVTcQv4XWmWvtAsevzOLmVwGmBpl4
         5ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1k0wj5ScUknjFJiFjOX8hnyLp9DFlmQAwewCKkzltU=;
        b=lcRVpZkDMIrGlVfoabURwcWYLBp2U0lWwF1uYm7P60xfeUYnelV1yVn9SyYfrtSod0
         AvK08202t3vHWLg7TAxaDBY+9O6/fL4IEc+sg8BEsjvKOnDxY6s9ifza4Wg+XuH2sz3x
         yH/NhubJT626wT6DOsIWrvk+cE7PFlqIGbrF7YFkcS3PFtyJdYeMTAKBrdgra/BXa+6D
         EcPWOInpofKPkMa8XxO2DUo8JAn0aMoqLDnneH43wfz3EWViasLEKrorg5+l67rUZN/V
         nNI31Y+fldE32tdQdVUICY+nVG+Old/gCEAVdPrHwPrUYrwd3JjFkh3QbRKAECfCDYHA
         iEGg==
X-Gm-Message-State: APjAAAU9RMK0EQFrTvWP7rAZ70krp0RKF4dnZVoTIjhE1L4mhM7tSNIK
        0SsxglLzTHKcnmRUt65ugJk=
X-Google-Smtp-Source: APXvYqw8i78OOi5bfRupeUQ0JmoKbZmifKVG7MtwMAkRxtz8t+ve85e8u5rvTUCpi7cJxvkOzhbD7w==
X-Received: by 2002:a65:410a:: with SMTP id w10mr6244104pgp.206.1552700634661;
        Fri, 15 Mar 2019 18:43:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k29sm4760274pfj.92.2019.03.15.18.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 18:43:53 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:43:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more
 places
Message-ID: <20190316014352.GA6124@roeck-us.net>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
 <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:28:57PM +0100, Thomas Petazzoni wrote:
> As suggested by Linus Walleij, let's use the new gpio_set_config()
> helper in gpiod_set_debounce() and gpiod_set_transitory().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/gpio/gpiolib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cf8a4402fef1..9762a836fec9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2762,7 +2762,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
>  	}
>  
>  	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> -	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> +	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);

Are you sure this is correct ? This patch results in a number of tracebacks
in mainline. Reverting it fixes the problem.

gpio_set_config() seems to pack config, but it is already packed above.
That seems a bit suspicious.

>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
>  
> @@ -2799,7 +2799,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
>  	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
>  					  !transitory);
>  	gpio = gpio_chip_hwgpio(desc);
> -	rc = chip->set_config(chip, gpio, packed);
> +	rc = gpio_set_config(chip, gpio, packed);

Same here.

Guenter

---
Bisect log:

# bad: [f261c4e529dac5608a604d3dd3ae1cd2adf23c89] Merge branch 'akpm' (patches from Andrew)
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect start 'HEAD' 'v5.0'
# good: [45763bf4bc1ebdf8eb95697607e1fd042a3e1221] Merge tag 'char-misc-5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 45763bf4bc1ebdf8eb95697607e1fd042a3e1221
# good: [cf2e8c544cd3b33e9e403b7b72404c221bf888d1] Merge tag 'mfd-next-5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect good cf2e8c544cd3b33e9e403b7b72404c221bf888d1
# bad: [d6075262969321bcb5d795de25595fc2a141ac02] Merge tag 'nios2-v5.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2
git bisect bad d6075262969321bcb5d795de25595fc2a141ac02
# bad: [96a6de1a541c86e9e67b9c310c14db4099bd1cbc] Merge tag 'media/v5.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 96a6de1a541c86e9e67b9c310c14db4099bd1cbc
# bad: [d1cae94871330cb9f5fdcea34529abf7917e682e] Merge tag 'fscrypt-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt
git bisect bad d1cae94871330cb9f5fdcea34529abf7917e682e
# bad: [80201fe175cbf7f3e372f53eba0a881a702ad926] Merge tag 'for-5.1/block-20190302' of git://git.kernel.dk/linux-block
git bisect bad 80201fe175cbf7f3e372f53eba0a881a702ad926
# bad: [4221b807d1f73c03d22543416d303b60a5d1ef31] Merge tag 'for-5.1/libata-20190301' of git://git.kernel.dk/linux-block
git bisect bad 4221b807d1f73c03d22543416d303b60a5d1ef31
# bad: [8fab3d713ca36bf4ad4dadec0bf38f5e70b8999d] Merge tag 'gpio-v5.1-updates-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into devel
git bisect bad 8fab3d713ca36bf4ad4dadec0bf38f5e70b8999d
# good: [b868db94a6a704755a33a362cfcf4625abdda115] gpio: tqmx86: Add GPIO from for this IO controller
git bisect good b868db94a6a704755a33a362cfcf4625abdda115
# good: [5340f23df8fe27a270af3fa1a93cd07293d23dd9] gpio: sprd: Add missing break in switch statement
git bisect good 5340f23df8fe27a270af3fa1a93cd07293d23dd9
# bad: [7f2f787c10596f486644d730a0a23e78abe8cbe0] gpio: pcf857x: Simpify wake-up handling
git bisect bad 7f2f787c10596f486644d730a0a23e78abe8cbe0
# bad: [6581eaf0e890756e093e2f44916edb5e7e6558ca] gpio: use new gpio_set_config() helper in more places
git bisect bad 6581eaf0e890756e093e2f44916edb5e7e6558ca
# good: [71479789851bdd9d56cd9e82892b0a3bee0a4c2a] gpio: rename gpio_set_drive_single_ended() to gpio_set_config()
git bisect good 71479789851bdd9d56cd9e82892b0a3bee0a4c2a
# first bad commit: [6581eaf0e890756e093e2f44916edb5e7e6558ca] gpio: use new gpio_set_config() helper in more places

Sample traceback:

[   15.965307] ------------[ cut here ]------------
[   15.965655] WARNING: CPU: 0 PID: 1 at drivers/gpio/gpio-aspeed.c:834 unregister_allocated_timer+0x60/0x98
[   15.965884] No timer allocated to offset 125
[   15.966177] CPU: 0 PID: 1 Comm: swapper Not tainted 5.0.0-11515-g3b319ee220a8 #1
[   15.966360] Hardware name: Generic DT based system
[   15.966586] Backtrace: 
[   15.966815] [<80106f9c>] (dump_backtrace) from [<80107248>] (show_stack+0x20/0x24)
[   15.967112]  r7:00000009 r6:00000000 r5:80bed4a0 r4:878a1c74
[   15.967704] [<80107228>] (show_stack) from [<8093f830>] (dump_stack+0x20/0x28)
[   15.967925] [<8093f810>] (dump_stack) from [<801147c8>] (__warn+0xf0/0x118)
[   15.968133] [<801146d8>] (__warn) from [<80114844>] (warn_slowpath_fmt+0x54/0x74)
[   15.968370]  r9:00000001 r8:60000113 r7:879f5ed0 r6:879f5e20 r5:80bed4bc r4:80e0b028
[   15.968612] [<801147f4>] (warn_slowpath_fmt) from [<805a83ac>] (unregister_allocated_timer+0x60/0x98)
[   15.968854]  r3:0000007d r2:80bed4bc
[   15.968989]  r5:00000000 r4:0000007d
[   15.969141] [<805a834c>] (unregister_allocated_timer) from [<805a8538>] (aspeed_gpio_set_config+0x154/0x444)
[   15.969419] [<805a83e4>] (aspeed_gpio_set_config) from [<805a0e6c>] (gpiod_set_debounce+0x60/0xcc)
[   15.969696]  r10:8718e8a0 r9:00000001 r8:84346f4c r7:00000000 r6:879bc010 r5:871606a8
[   15.969893]  r4:87a987d0
[   15.970008] [<805a0e0c>] (gpiod_set_debounce) from [<807462c8>] (gpio_keys_probe+0x4d8/0x924)
[   15.970211]  r4:8718e8bc
[   15.970326] [<80745df0>] (gpio_keys_probe) from [<80633fec>] (platform_drv_probe+0x58/0xa8)
