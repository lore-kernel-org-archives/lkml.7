Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F1C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732220838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LljBa/7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL1NTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:19:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1NTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:19:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so28552863wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mROGrVXLEQzNF7njXXU2HOGRKW7Iu6ci6QJQxa/5Pug=;
        b=LljBa/7Vc+Pv+w8r0wajVxDjHPY9o1ACGA5bUuCUTKnVPF9MFXlFz7rQCXWQ9Zw2Md
         DVBJPvdjgL9fnpycXMsu6+6FOit0rpWwV3e8RBteLCmvavOmr4DI6bhs6O2Qpmlxqops
         yvu3Vbm2VxRrYmzeDsDRwqRq19f161xRoBC7QMUKUdjInj/cKgkuylPkOngboekCkcD3
         rlbxI/0un3M9QwN1xkX0HyZb1Tm7Dp2WAzJ7cad8KGd0IO4AehX9OUx52k0gHD3IijdL
         wSLcbi4jddnbmW1jg9fmcxLXo3ogZNMBlvMJagJCyexbCcBA7CjW0/aTjHgg9xBEyCj5
         UvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mROGrVXLEQzNF7njXXU2HOGRKW7Iu6ci6QJQxa/5Pug=;
        b=enbvdC3L99nVAiV4Gs8CPXQ7ueEogzTunv0WQPuFWqXyiubKObdlA/K+bN11VG4U8Z
         Dk3F/E3+BiajXC3glqjdqTx7Vx+zMs2TbpQkiHtfPLRVJ7S+VIRPTWITbsUSUHgQlZeg
         US9TwsQcn/+QrrFIBZYR/bFVu27r4lgSbJmHg4rg9xPZUoCd/eQl/m0IXylXSEzZ6DuS
         yhJDfpqXE5OJyvOT90nyfNkTQ6V4773KtOOJGZKvvKsQcFWbmyy3XpMV6583brdl4JVh
         /kQviS7RW/RbGCjRUx5zRg+/Hn6N02GTnqZ4YkU97u/9GLJlwOtzz4ivWJAGjhTZLQcF
         /nyg==
X-Gm-Message-State: APjAAAUVOnl5fRSubuR8D9K0u/i4WkHI+mGgaoB2qW0u2ln+xR+R2tIg
        f6Ox1OXlnANvmr56/VVzIn8=
X-Google-Smtp-Source: APXvYqyeZtp0u4nqd2az6FFSTsGN6tOBc76dqmqvtmVQhd7ZRlATk1x+LzDOLY39GnKg6d0zp+W0IA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr54659377wrm.210.1577539168956;
        Sat, 28 Dec 2019 05:19:28 -0800 (PST)
Received: from zhanggen-UX430UQ.lan ([95.179.219.143])
        by smtp.gmail.com with ESMTPSA id o16sm15264205wmc.18.2019.12.28.05.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Dec 2019 05:19:28 -0800 (PST)
Date:   Sat, 28 Dec 2019 21:19:30 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     nsekhar@ti.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] board-dm644x-evm: fix 2 missing-check bugs in
 evm_led_setup()
Message-ID: <20191228131930.GA7214@zhanggen-UX430UQ.lan>
References: <20191227023921.GA21233@zhanggen-UX430UQ>
 <20191227160142.GW25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227160142.GW25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 04:01:42PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Dec 27, 2019 at 10:39:21AM +0800, Gen Zhang wrote:
> > In evm_led_setup(), the allocation result of platform_device_alloc() and 
> > platform_device_add_data() should be checked.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> > index 9d87d4e..9cd2785 100644
> > --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > @@ -352,15 +352,20 @@ evm_led_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
> >  	 * device unregistration ...
> >  	 */
> >  	evm_led_dev = platform_device_alloc("leds-gpio", 0);
> > -	platform_device_add_data(evm_led_dev,
> > +	if (!evm_led_dev)
> > +		return -ENOMEM;
> > +	status = platform_device_add_data(evm_led_dev,
> >  			&evm_led_data, sizeof evm_led_data);
> > +	if (status)
> > +		goto err;
> >  
> >  	evm_led_dev->dev.parent = &client->dev;
> >  	status = platform_device_add(evm_led_dev);
> > -	if (status < 0) {
> > -		platform_device_put(evm_led_dev);
> > -		evm_led_dev = NULL;
> > -	}
> > +	if (status)
> > +		goto err;
> > +err:
> > +	platform_device_put(evm_led_dev);
> > +	evm_led_dev = NULL;
> 
> Please look again at the above change very closely. You will want to
> send an updated patch.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

Thanks for your reply. You mean the if (state < 0 ) to if (state) or
anything else? Please point out directly.

Best,
Gen
