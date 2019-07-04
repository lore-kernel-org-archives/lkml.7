Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B08CC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701C8218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562232729;
	bh=QubOvX+MT3C5c7Jj4WfeXmvN8AiFrueiPsOR//C5Clw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvduRyeYyHjCdgJ0s18lgJau6ltJkYO69YtXnFAIa3zzKtmT0yvAcC1mz7n1HyyvY
	 0HMO4WN+fYHJIlFyVW/C2O9WJvmyZp+G7SaNqRloDkQ5q/rokjnSsPLQ7D1izS5vn2
	 Ckhl+WpsSoxrMBNTNmj+EWJe8Og4X22BUVPSVYb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGDJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:32:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37544 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfGDJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:32:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so2028599lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6XWgf4aZOiZ9nBImvtuRI/cSLt8i5bschesBs6VcKI=;
        b=tcrQ0AuB+flmyrISxJTDmemDr35ZE6wJfrq6afGOphARkd55Hh9+Ilc2ZZl9TTsF6A
         WuxIX9/f9I13/LiDLVR01Uz9W075jTvugbUylUABOAHGlrlIa5SkWQJ4ScoAODRgeCdF
         nY+0YvFvQZGGKf35P33FzjvlTB3lVtdX1R+VjEtdask2ucUXN9X8p1/ohzFSafPvL0ic
         p4WLvnBjzZT1yoHHjSVLCWBAWrVfGn6pE3W3Ghm6LB4iFsQEB06e2WvfvP/U8KtL8Hvd
         BVx7PVxBGAuIerx5Iam3uNB5mHnWbgn+AOKvvaOkQx2iZxWhivjZsrbuvhdO8cZelB6L
         k9pA==
X-Gm-Message-State: APjAAAXapZoaELaHm8dH4suLgvV2H+++dOSp1+3bCIgEkOjkd2wdKEAW
        EkbYUf6utdS+ZU5hI9CaxEEjbOZNyyA=
X-Google-Smtp-Source: APXvYqwFC2qe6eiEuVsl3gTWis45xSshT//m46XuppF8twyI6eOfwFg2ta0S6Cr6ZA/Sf5Npc8434Q==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr8312091lfl.121.1562232725886;
        Thu, 04 Jul 2019 02:32:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h11sm800946lfm.14.2019.07.04.02.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:32:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hiy5w-0006vk-Fs; Thu, 04 Jul 2019 11:32:00 +0200
Date:   Thu, 4 Jul 2019 11:32:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/11] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190704093200.GM13424@localhost>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704084617.3602-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:46:07AM +0200, Greg Kroah-Hartman wrote:
> Platform drivers like to add sysfs groups to their device, but right now
> they have to do it "by hand".  The driver core should handle this for
> them, but there is no way to get to the bus-default attribute groups as
> all platform devices are "special and unique" one-off drivers/devices.
> 
> To combat this, add a dev_groups pointer to platform_driver which allows
> a platform driver to set up a list of default attributes that will be
> properly created and removed by the platform driver core when a probe()
> function is successful and removed right before the device is unbound.
> 
> Cc: Richard Gong <richard.gong@linux.intel.com>
> Cc: Romain Izard <romain.izard.pro@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mans Rullgard <mans@mansr.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/platform.c         | 40 +++++++++++++++++++++------------
>  include/linux/platform_device.h |  1 +
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 713903290385..d81fcd435b52 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -598,6 +598,21 @@ struct platform_device *platform_device_register_full(
>  }
>  EXPORT_SYMBOL_GPL(platform_device_register_full);
>  
> +static int platform_drv_remove(struct device *_dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(_dev->driver);
> +	struct platform_device *dev = to_platform_device(_dev);
> +	int ret = 0;
> +
> +	if (drv->remove)
> +		ret = drv->remove(dev);
> +	if (drv->dev_groups)
> +		device_remove_groups(_dev, drv->dev_groups);

Shouldn't you remove the groups before calling driver remove(), which
could be releasing resources used by the attribute implementations?

This would also be the reverse of how what you do at probe.

> +	dev_pm_domain_detach(_dev, true);
> +
> +	return ret;
> +}
> +
>  static int platform_drv_probe(struct device *_dev)
>  {
>  	struct platform_driver *drv = to_platform_driver(_dev->driver);
> @@ -614,8 +629,18 @@ static int platform_drv_probe(struct device *_dev)
>  
>  	if (drv->probe) {
>  		ret = drv->probe(dev);
> -		if (ret)
> +		if (ret) {
>  			dev_pm_domain_detach(_dev, true);
> +			goto out;
> +		}
> +	}
> +	if (drv->dev_groups) {
> +		ret = device_add_groups(_dev, drv->dev_groups);
> +		if (ret) {
> +			platform_drv_remove(_dev);

This would lead to device_remove_groups() being called for the never
added attribute groups. Looks like that may trigger a warning in the
sysfs code judging from a quick look.

> +			return ret;
> +		}
> +		kobject_uevent(&_dev->kobj, KOBJ_CHANGE);
>  	}

Johan
