Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B69AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD6218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C++bXdVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfC2TXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:23:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfC2TXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:23:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so3643444wmf.1;
        Fri, 29 Mar 2019 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mE+quAYUTiBPxPD4hMDVHlGR0840XRh3EfzVkflT7e8=;
        b=C++bXdVVDbYcDTB5XHgf9IO7rATmVn863NlR34EciYggfX71xk1F8wzrJHSeWxSIKP
         KYE+FJfxe8hII5ZUThLsXII8RuwcOsGSnZSh6yWdm6x8qHuz5yWnTOeAF6t1fR/NvGGh
         z95PH4RG1wzfySyUTbBWqZWgPfsryvkJ41foJEe8Q45oXguhqDmm8hmbX4zPRb5snlPW
         i5RFDB2NZJNSsdRimAy2D6KPy8UaC0tyr8BBWIjuvTzIoyPYs3CKZQqy3a1QC0W+ESAw
         MuQi83gKsV60zsSvWTiHnX+CE537ztUpHHo+1p05nBnofOLYhxIfQlDW4rC4Cr73/Bl8
         lp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mE+quAYUTiBPxPD4hMDVHlGR0840XRh3EfzVkflT7e8=;
        b=fgDob4WDL/Nnznx8r88eaAnEQgyCpModz8YAAwG6tLhBlYtvccLxu3iI3NDamYTalB
         QvIijG4BZs4n1j3v/C4s/2wjn17veltgSUJFuOGVM5ycNgHGzEsfIt1VwbqAm6u5sBzg
         cBEVRW5hu3vc78/nqtWkfIIoR9I7aTxB5lOw8C0nvSj4gft4KeklvHWmZXsflEV7wkyC
         8xXSYpjkKUByDmBkppjuoO7LbtsIv+Cx2XvcXnqIJ5JVhoI8/1Oqr1hxfNfVN48w5wVk
         CCRXPCZSGHVphoH4muENQiNPajEwskR4VxZbIvewWKMMwnMU9nEaLYkKjkpDMR18yx6N
         mOsg==
X-Gm-Message-State: APjAAAW1MCb60WTjOUcDQcz0rizjPDZ9JwP+OQSdokUO7nEw0ynQ5zik
        qTVjn4tBgT0bZA3lLpm242vNy5ms
X-Google-Smtp-Source: APXvYqxEMY7NJai9SGMRR0vSHvw9m1wzPYypu73nYVNGaWryR1PG/2y1bY/FUR46j6z2A1d55dVujQ==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr4837410wme.26.1553887384327;
        Fri, 29 Mar 2019 12:23:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:a991:cc44:5157:9e5? (p200300EA8BE1DD00A991CC44515709E5.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:a991:cc44:5157:9e5])
        by smtp.googlemail.com with ESMTPSA id e16sm3985597wrs.0.2019.03.29.12.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 12:23:03 -0700 (PDT)
Subject: Re: [PATCH net-next v2 3/3] net: phy: meson-gxl: add g12a support
To:     Jerome Brunet <jbrunet@baylibre.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20190329141512.29867-1-jbrunet@baylibre.com>
 <20190329141512.29867-4-jbrunet@baylibre.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0b7df4e8-8db2-a028-bd1d-6d77cac67110@gmail.com>
Date:   Fri, 29 Mar 2019 20:22:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329141512.29867-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.2019 15:15, Jerome Brunet wrote:
> The g12a SoC family uses the type of internal PHY that was used on the
> gxl family. The quirks of gxl family, like the LPA register corruption,
> appear to have been resolved on this new SoC generation.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/net/phy/meson-gxl.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index 0eec2913c289..49cad0f4c79b 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -237,11 +237,25 @@ static struct phy_driver meson_gxl_phy[] = {
>  		.config_intr	= meson_gxl_config_intr,
>  		.suspend        = genphy_suspend,
>  		.resume         = genphy_resume,
> +	}, {
> +		.phy_id		= 0x01803301,
> +		.phy_id_mask	= 0xffffffff,

Here you could use the PHY_ID_MATCH_EXACT() macro, see realtek PHY
driver for an example.

> +		.name		= "Meson G12A Internal PHY",
> +		.features	= PHY_BASIC_FEATURES,
> +		.flags		= PHY_IS_INTERNAL,
> +		.soft_reset     = genphy_soft_reset,
> +		.aneg_done      = genphy_aneg_done,
> +		.read_status	= genphy_read_status,

genphy_aneg_done() and genphy_read_status() are used automatically
as fallback if no callback is defined. You can omit these two lines.

> +		.ack_interrupt	= meson_gxl_ack_interrupt,
> +		.config_intr	= meson_gxl_config_intr,
> +		.suspend        = genphy_suspend,
> +		.resume         = genphy_resume,
>  	},
>  };
>  
>  static struct mdio_device_id __maybe_unused meson_gxl_tbl[] = {
>  	{ 0x01814400, 0xfffffff0 },
> +	{ 0x01803301, 0xffffffff },

Also a candidate for PHY_ID_MATCH_EXACT. In the line before
PHY_ID_MATCH_MODEL could be used.

>  	{ }
>  };
>  
> 

