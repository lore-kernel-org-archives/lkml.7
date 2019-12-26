Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9AC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8D2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0S+5TOkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLZJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:52:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40241 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:51:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so5694125wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Q6UFSRGR2MJ+IER5gw/YE6x0C6sfmGGwcqhDuK/iGS0=;
        b=0S+5TOkWe5NcUGiQS0Dh4/RBbEY/dhP4T8g5aY6GZ7h+0dkMci5gsHoxQfg2fcfWgG
         vKIQ67UNVaTIlkfs1Sc1lEk56VIoxuTtFNeOTOh92pwGSqyxh6EuTEzWeNpgvJFRFt5A
         yibdRsnhRquESZqxKqnzWP/30FBpH4TLV4ep737a+2hXanQxZUnETlQS7hr67MoVlzGg
         9WBTVuCCFics3kn6GJMeZc1WhBNLXcRd81E4A25QkvFuic+PH7jOoYSJiKces//CNb/C
         MK01d8K+iYRp9JLUrh/b6bJ+aPD6DeB8u+eIJXiEIWpRKpqdZFikBUx82izXS5qso5xx
         Q/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Q6UFSRGR2MJ+IER5gw/YE6x0C6sfmGGwcqhDuK/iGS0=;
        b=lEOfa80N8N05aEVhnrmu9ow7jRwbsgA5BVhf1kbwqAqXWOmR8eU0KsNHH2xR92AWMP
         +IQ7XSM8jPWvjYuujHg//oW1KFLrPfJKkBM2kgn0c8cLJLxM8xYcvilE6K10ftJaNHty
         uLd3YIbafoH4cfFLVgGhfuGwkFNlxM45/ZPli92UnQAKGQ99rMg8MP7+29w/2ElMq8d2
         AeMqSDudPtClqaJHtgdL/chIL4v5sNVupOQbvTqGrGh/HyaSwDtARvvl5opeX7pyUT8b
         0Pi91jBckjhOWqkZkXaG8pzBO03hrTBk3LssucjR9+h+/Nx0D7M8anHr6K6si8R/L21i
         VuDg==
X-Gm-Message-State: APjAAAV0Cldzq3km3YpPShzsvzfmeUKJ0gzG9GRZO87A9jx+I+ich0iC
        oqD0ga0/Yknm2SQNdPAJ6iLgWw==
X-Google-Smtp-Source: APXvYqwfDB/sQDwO6hvyq6nY2GHHxxCB3FcXLHXmTxp7aLc9tXlQWon+pHKOvoNZSbUw1TD1me2h3A==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr13856784wma.78.1577353917551;
        Thu, 26 Dec 2019 01:51:57 -0800 (PST)
Received: from localhost ([2a01:e0a:1a5:7ee0:1e09:f4bb:719a:3028])
        by smtp.gmail.com with ESMTPSA id 5sm32114005wrh.5.2019.12.26.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 01:51:56 -0800 (PST)
References: <20191225163429.29694-1-linux@roeck-us.net>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Don't try to enable critical clocks if prepare failed
In-reply-to: <20191225163429.29694-1-linux@roeck-us.net>
Date:   Thu, 26 Dec 2019 10:51:56 +0100
Message-ID: <1jd0cbpg77.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 25 Dec 2019 at 17:34, Guenter Roeck <linux@roeck-us.net> wrote:

> The following traceback is seen if a critical clock fails to prepare.
>
> bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
> ------------[ cut here ]------------
> Enabling unprepared plld_per
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:1014 clk_core_enable+0xcc/0x2c0
> ...
> Call trace:
>  clk_core_enable+0xcc/0x2c0
>  __clk_register+0x5c4/0x788
>  devm_clk_hw_register+0x4c/0xb0
>  bcm2835_register_pll_divider+0xc0/0x150
>  bcm2835_clk_probe+0x134/0x1e8
>  platform_drv_probe+0x50/0xa0
>  really_probe+0xd4/0x308
>  driver_probe_device+0x54/0xe8
>  device_driver_attach+0x6c/0x78
>  __driver_attach+0x54/0xd8
> ...
>
> Check return values from clk_core_prepare() and clk_core_enable() and
> bail out if any of those functions returns an error.
>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Fixes: 99652a469df1 ("clk: migrate the count of orphaned clocks at init")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/clk/clk.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 6a11239ccde3..772258de2d1f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3426,11 +3426,17 @@ static int __clk_core_init(struct clk_core *core)
>  	if (core->flags & CLK_IS_CRITICAL) {
>  		unsigned long flags;
>  
> -		clk_core_prepare(core);
> +		ret = clk_core_prepare(core);
> +		if (ret)
> +			goto out;
>  
>  		flags = clk_enable_lock();
> -		clk_core_enable(core);
> +		ret = clk_core_enable(core);
>  		clk_enable_unlock(flags);
> +		if (ret) {
> +			clk_core_unprepare(core);
> +			goto out;
> +		}

Hi Guenter,

It looks like it was a mistake to discard the possibility of a failure
here. Thanks for correcting this.

However, we would not want a critical clock to silently fail to
enable. This might lead to unexpected behavior which are generally hard
(and annoying) to debug.

Would you mind adding some kind of warning trace in case this fails ?

Thx

>  	}
>  
>  	clk_core_reparent_orphans_nolock();

