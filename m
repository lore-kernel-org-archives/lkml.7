Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC92C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045EE2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573537208;
	bh=DHULJ5PDA2aurBq/UHbqIfg+vBBq4iEHEwdqVLa0Rak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WremyTj6OhgH6MNAETnVwUGPl1kwKzKmixiHwDMKH6Ixl6SGQXTwajRbKlgAnR1LI
	 q4ARsR7N9E7Ic6l5XW2DrGy9VgEeQVdyJqfobO2qowfsa2L92WsQbp5awYedOPfkSs
	 dGquAzxTjlYr/lJGH47nZUq1SIANhutlzWAQ54zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfKLFkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLFkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:40:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817A02084F;
        Tue, 12 Nov 2019 05:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573537206;
        bh=DHULJ5PDA2aurBq/UHbqIfg+vBBq4iEHEwdqVLa0Rak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIdklnhR1wHAYbf9dcmZZxeSETsXhU1RQofV1TABiA/LMIwkDJkONzhxeGrMd9WEb
         2YK+IKes8uDqeh0oeI+DUgPMeA3THWY3Hv/yBaurld+YtEEiCThT5vKHsWJbjw/kl4
         aEkJL5Ymp45+COr4Cr2hcDGVlVHJoUbuiF33Zil0=
Date:   Tue, 12 Nov 2019 06:40:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] soc: amlogic: socinfo: Avoid soc_device_to_device()
Message-ID: <20191112054003.GD1210104@kroah.com>
References: <20191111221521.1587-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111221521.1587-1-afaerber@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:15:21PM +0100, Andreas Färber wrote:
> The helper soc_device_to_device() is considered deprecated.
> For a driver __init function the predictable prefix text
> "soc soc0:" from dev_info() does not add real value, so use
> pr_info() to emit the info text without such prefix.
> 
> While at it, normalize the casing of "detected" for GX.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 4 +---
>  drivers/soc/amlogic/meson-mx-socinfo.c | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 01fc0d20a70d..105b819bbd5f 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -129,7 +129,6 @@ static int __init meson_gx_socinfo_init(void)
>  	struct device_node *np;
>  	struct regmap *regmap;
>  	unsigned int socinfo;
> -	struct device *dev;
>  	int ret;
>  
>  	/* look up for chipid node */
> @@ -192,9 +191,8 @@ static int __init meson_gx_socinfo_init(void)
>  		kfree(soc_dev_attr);
>  		return PTR_ERR(soc_dev);
>  	}
> -	dev = soc_device_to_device(soc_dev);
>  
> -	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
> +	pr_info("Amlogic Meson %s Revision %x:%x (%x:%x) detected\n",

This should message should just be removed entirely.

>  			soc_dev_attr->soc_id,
>  			socinfo_to_major(socinfo),
>  			socinfo_to_minor(socinfo),
> diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
> index 78f0f1aeca57..7db2c94a7130 100644
> --- a/drivers/soc/amlogic/meson-mx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-mx-socinfo.c
> @@ -167,8 +167,8 @@ static int __init meson_mx_socinfo_init(void)
>  		return PTR_ERR(soc_dev);
>  	}
>  
> -	dev_info(soc_device_to_device(soc_dev), "Amlogic %s %s detected\n",
> -		 soc_dev_attr->soc_id, soc_dev_attr->revision);
> +	pr_info("Amlogic %s %s detected\n",
> +		soc_dev_attr->soc_id, soc_dev_attr->revision);

Same here, no need to polute the kernel log for when all is going just
fine.

That's why we created "common" driver init helpers, to prevent the
ability for this type of noise from even being able to be created at
all.

thanks,

greg k-h
