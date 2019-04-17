Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC13C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9920872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+URAciQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfDQLue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:50:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:50:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so31572954wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXkceclKYogbXCLoeXJVlPi06thLC4AnNmyU4U76yv0=;
        b=Y+URAciQ+M8cmBS5dBKlsu+WhtMaPf7js4UjsiWn1RNagP6DfNTkIXBZB65yVLFgx1
         dfs8AA+IZNEDxXIoinkKYo6Wi9cQOGMHfjmmmkEJrhY7KKaVPNZDH+80n5ihOJWzFr2o
         TaUwx+enLeKiPx35cCrIV84XH4UDS45GpApGV0pQQAHQR3MOYxdKQzdQoUFZyfz1qTH4
         Csd0SmPg4Qd5K9YNCql477FVYlcBWULpCJit8zGrX7sf9MfdU1TRCScRsGZiM8H6chuV
         F+hen7472dLNuWdAumgrbuynaBeC14h3zR2N0qCysuU2dnzse3z4VnbaYD2WSnmXKgY9
         tDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXkceclKYogbXCLoeXJVlPi06thLC4AnNmyU4U76yv0=;
        b=mt64P9w3ZPZH6VK2TKFf1cd24Fa820Hz6ZnKe2VZITQ2x1MuT5y7P8N7fGJ/oPGhQv
         NVUU8IG9I4JiXLwKUXwa7jwDwtGaIxZQhCMXHVHzpuDXBrif0nV3BYH/yA56vya4EjQb
         HiZY2boA8IzVzL66tX4pBp23bQi9imrG/RJ3F77rgD5OnwtPGzjt/xg3MFgyV1W57lAq
         gsLIOXoN6xJYx6yhAZQLA17/90Xa8xYs1nR0SEs/aE9ile45WatR2cjdhDmO4VuQkDAK
         gShxbBb4S06tzivOEykLG7nsYQMDLrYB2mhaM+i6LmmwzSfMrc5jEbTL177a1cdCXRMz
         Fseg==
X-Gm-Message-State: APjAAAVmoB5zVEuObSDnyf9R4/eH4qXJbK/YrafrQ/j2e7ODDNVe2cju
        zhvAIKGmi6/iOmXEHZxcRfI=
X-Google-Smtp-Source: APXvYqwuGyhQU4JfmZ+mKtKc73dPprmppDk33S0gj+yhJiGjOazmrIIy6v2Mvk131dsFzqqeYpUhcw==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr2266249wrv.142.1555501832488;
        Wed, 17 Apr 2019 04:50:32 -0700 (PDT)
Received: from 5WDYG62 (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id f128sm3778167wme.28.2019.04.17.04.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 04:50:31 -0700 (PDT)
Date:   Wed, 17 Apr 2019 13:50:25 +0200
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 9/9] misc: atmel_tclib: do not probe already used TCBs
Message-ID: <20190417114934.GA28520@5WDYG62>
References: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
 <20190415150856.9384-10-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415150856.9384-10-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:08:56PM +0200, Alexandre Belloni wrote:
> The TCBs that have children are using the proper DT bindings and don't need
> to be handled by tclib.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/misc/atmel_tclib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index 194f774ab3a1..c1f5aba1c6f2 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -111,6 +111,9 @@ static int __init tc_probe(struct platform_device *pdev)
>  	struct resource	*r;
>  	unsigned int	i;
>  
> +	if (of_get_child_count(pdev->dev.of_node))
> +		return 0;
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return -EINVAL;

This lead to a panic during shutdown, as tc_shutdown is called on the
device that has not been initialized and it has not been designed for
this.

-- 
Romain Izard
