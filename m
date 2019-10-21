Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930BB205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtKTocvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfJUM3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:29:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44300 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:29:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so13756767wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2I2I4mzsYfhdqHPLyU8RHWhZq7LnFLBgUtko9EGZhA=;
        b=vtKTocvVbwjA2WgUF5tke/FjPEG9ytdNFFRdjtq7cQ98tEv5Hp5HkixofdPHJe7BFt
         1fjei8Rjqb2LnCrUuAXLskT/zmYHB0bFr6cqUa9L66j/6PS+CLkCcwZmnXgWfrQpTXIj
         YXBRn9ebR1AYTXubk4N1MrGBhSwu3ZNLgxGl6zKnS9Vsm6BNQR1hI/NJ/MYEQofXHk9+
         Ie83J0kaPMYbDpnOT+g5XXq5n41RwzbzHa+KXVt31ByjW4Ugrv2yrpv890sKwQ7SqxD+
         55os6UMGFeQcgqrEfyaYtsnA0AYA4HsiEzBbvBN9JA+cxTeAqknJTUJdb/MHsh9VXuPK
         xy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2I2I4mzsYfhdqHPLyU8RHWhZq7LnFLBgUtko9EGZhA=;
        b=hZlf9UwiluYskL8LPmrgv2UjdEmiP42huKg73UCQk09UwoLCImfj/+6LNuueaprbAD
         ni0U6VKCw85YepXOeAZhRu04Gbyzq5YRF05HbcNG4qUVOz0gniuOh3BVuJ8Wp+t/OQg2
         Vpg/n1bIAOJL32kaByEWnFdK/M9nLX52be3MnSxzl9lSmgU/jE5gY2DwbuiBQjLdlx/s
         7PMmU5RyW/opjHAU0N5PgtpjPwtii4tlPM84RWVQ5pAm81TLBxEmqEDPwmJ8MG0a2BkN
         dX8HSoNrRPrAvEtSzzyLamFSFKnq/cqPgOuizhndP4zo7H7napGaFvhkdLfTG6dAV+7m
         IsBw==
X-Gm-Message-State: APjAAAW+P5bFUjLoKpsb0Yinjm8Zj6oSJ5UTy/TOCz7pAJkwO54a9dqu
        c/m6Q90FYqiq3nvJ/Vn8/JyXGZZGoKIe9Q==
X-Google-Smtp-Source: APXvYqwb1nujp9zdlC01AqAtWYRUY8PVAzUilrBt/2OEunlktk2NxBiPIElwt6MKo6MY/gJIu39hoQ==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr18759829wrs.63.1571660987651;
        Mon, 21 Oct 2019 05:29:47 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n1sm17157278wrg.67.2019.10.21.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:29:47 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:29:45 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 5/9] mfd: mfd-core: Remove mfd_clone_cell()
Message-ID: <20191021122945.ys7zn4igstid7yko@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-6-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:18AM +0100, Lee Jones wrote:
> Providing a subsystem-level API helper seems over-kill just to save a
> few lines of C-code.  Previous commits saw us convert mfd_clone_cell()'s
> only user over to use a more traditional style of MFD child-device
> registration.  Now we can remove the superfluous helper from the MFD API.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/mfd/mfd-core.c   | 33 ---------------------------------
>  include/linux/mfd/core.h | 18 ------------------
>  2 files changed, 51 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 23276a80e3b4..8126665bb2d8 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -382,38 +382,5 @@ int devm_mfd_add_devices(struct device *dev, int id,
>  }
>  EXPORT_SYMBOL(devm_mfd_add_devices);
>  
> -int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
> -{
> -	struct mfd_cell cell_entry;
> -	struct device *dev;
> -	struct platform_device *pdev;
> -	int i;
> -
> -	/* fetch the parent cell's device (should already be registered!) */
> -	dev = bus_find_device_by_name(&platform_bus_type, NULL, cell);
> -	if (!dev) {
> -		printk(KERN_ERR "failed to find device for cell %s\n", cell);
> -		return -ENODEV;
> -	}
> -	pdev = to_platform_device(dev);
> -	memcpy(&cell_entry, mfd_get_cell(pdev), sizeof(cell_entry));
> -
> -	WARN_ON(!cell_entry.enable);
> -
> -	for (i = 0; i < n_clones; i++) {
> -		cell_entry.name = clones[i];
> -		/* don't give up if a single call fails; just report error */
> -		if (mfd_add_device(pdev->dev.parent, -1, &cell_entry,
> -				   cell_entry.usage_count, NULL, 0, NULL))
> -			dev_err(dev, "failed to create platform device '%s'\n",
> -					clones[i]);
> -	}
> -
> -	put_device(dev);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(mfd_clone_cell);
> -
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Ian Molton, Dmitry Baryshkov");
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index b43fc5773ad7..bd8c0e089164 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -86,24 +86,6 @@ struct mfd_cell {
>  extern int mfd_cell_enable(struct platform_device *pdev);
>  extern int mfd_cell_disable(struct platform_device *pdev);
>  
> -/*
> - * "Clone" multiple platform devices for a single cell. This is to be used
> - * for devices that have multiple users of a cell.  For example, if an mfd
> - * driver wants the cell "foo" to be used by a GPIO driver, an MTD driver,
> - * and a platform driver, the following bit of code would be use after first
> - * calling mfd_add_devices():
> - *
> - * const char *fclones[] = { "foo-gpio", "foo-mtd" };
> - * err = mfd_clone_cells("foo", fclones, ARRAY_SIZE(fclones));
> - *
> - * Each driver (MTD, GPIO, and platform driver) would then register
> - * platform_drivers for "foo-mtd", "foo-gpio", and "foo", respectively.
> - * The cell's .enable/.disable hooks should be used to deal with hardware
> - * resource contention.
> - */
> -extern int mfd_clone_cell(const char *cell, const char **clones,
> -		size_t n_clones);
> -
>  /*
>   * Given a platform device that's been created by mfd_add_devices(), fetch
>   * the mfd_cell that created it.
> -- 
> 2.17.1
> 
