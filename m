Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F864C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A43206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eqjn3GCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408819AbfFLJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:32:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40229 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408577AbfFLJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:32:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so5754589wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kXYExoZX2VN/fgLgrapoW1snuGSCqJ2qiGI/4xjK+ag=;
        b=Eqjn3GCsj1mrcd5rVk1m/XSs+HLCYEkexe4aGNYetJUosCBGH6AzHRX04/kA8onWbE
         EWNJSYpYAQkFuNWI9iBvB2tCPnXDdxVJF04Dq0nLZheJbyXIjLekStOY9jG7eM9LRz8m
         Ja1IojJnx0ry5fSmPYCxnqCz+dd1C7KDsrVHN55jXGQOgVjd3BHx1g2DjNGgA+JqHmjo
         h5x6XMl2ybE1Wq4e2dDfoBftF0ICSiLQdqxP0vs+F9mgEg9pp9y5L0NQgRR2Y3t41WRQ
         6hBDRxZVfGrZX4ylKA2UK1Kj/weiRolOAhlIcprRFLwibqsgw2l89GkCJw65FD7c55u/
         Gm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kXYExoZX2VN/fgLgrapoW1snuGSCqJ2qiGI/4xjK+ag=;
        b=Ahl/ZJr77u3B4jjYaHLqjo8UYVrIyQQdzYnUZV/GT3qeS3rpfP59pFuAuYH1BhPFKC
         OHDg4JwjZn4Wnbjb289mJfZI7UgSy3IdoERgEUhFJrn28UJOE6rXfQZ3G0+1v9m6Grk8
         P6k5TSKx0OwCZRTyvrkjLETdVUS182pbtcuQvVY0+ogyqYow//wreomViEM7RMPL6DV0
         b/CcIF724n1d59vgmJSK5OpYMXz2KBIH7YLsyGvasXBXetukgIzWfD3RivsDVZsD2n4z
         Y+XgEWklbcktO86MxuhH9LqxLT5/sd/pvYDwj0gUqR3Ff4S5WwNUHjJyV7Yy5hGtEoTg
         vRlw==
X-Gm-Message-State: APjAAAUjon4kjo02qblkBtbz1fOLZJwCZ94G9tZiEZbLa9VcQHqsdnLP
        JtgjvK9Ufgg+a5e/j7dD34NupNG+D9Y=
X-Google-Smtp-Source: APXvYqyMX/rsv3GfmZJV7FrVdRMM92c+d4Y0yfrxvoGmQGmPzO4fnd8/xVHk65bqa0yENTRtbZIUQQ==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr20509639wmm.83.1560331968928;
        Wed, 12 Jun 2019 02:32:48 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id b14sm13346979wro.5.2019.06.12.02.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 02:32:48 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:32:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Corey Minyard <minyard@acm.org>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 03/13] driver_find_device: Unify the match function with
 class_find_device()
Message-ID: <20190612093246.GE4797@dell>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559747630-28065-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Suzuki K Poulose wrote:

> The driver_find_device() accepts a match function pointer to
> filter the devices for lookup, similar to bus/class_find_device().
> However, there is a minor difference in the prototype for the
> match parameter for driver_find_device() with the now unified
> version accepted by {bus/class}_find_device(), where it doesn't
> accept a "const" qualifier for the data argument. This prevents
> us from reusing the generic match functions for driver_find_device().
> 
> For this reason, change the prototype of the driver_find_device() to
> make the "match" parameter in line with {bus/class}_find_device()
> and adjust its callers to use the const qualifier. Also, we could
> now promote the "data" parameter to const as we pass it down
> as a const parameter to the match functions.
> 
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Sebastian Ott <sebott@linux.ibm.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/amba/tegra-ahb.c             | 4 ++--
>  drivers/base/driver.c                | 4 ++--
>  drivers/char/ipmi/ipmi_msghandler.c  | 8 ++++----
>  drivers/gpu/drm/tegra/dc.c           | 4 ++--
>  drivers/i2c/busses/i2c-amd-mp2-pci.c | 2 +-
>  drivers/iommu/arm-smmu-v3.c          | 2 +-
>  drivers/iommu/arm-smmu.c             | 2 +-

>  drivers/mfd/altera-sysmgr.c          | 4 ++--
>  drivers/mfd/syscon.c                 | 2 +-

I'm okay with the changes.  How do you plan on managing the merge?

>  drivers/s390/cio/ccwgroup.c          | 2 +-
>  drivers/s390/cio/chsc_sch.c          | 2 +-
>  drivers/s390/cio/device.c            | 2 +-
>  include/linux/device.h               | 4 ++--
>  13 files changed, 21 insertions(+), 21 deletions(-)

[...]

> diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
> index 8976f82..2ee14d8 100644
> --- a/drivers/mfd/altera-sysmgr.c
> +++ b/drivers/mfd/altera-sysmgr.c
> @@ -92,9 +92,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
>   * Matching function used by driver_find_device().
>   * Return: True if match is found, otherwise false.
>   */
> -static int sysmgr_match_phandle(struct device *dev, void *data)
> +static int sysmgr_match_phandle(struct device *dev, const void *data)
>  {
> -	return dev->of_node == (struct device_node *)data;
> +	return dev->of_node == (const struct device_node *)data;
>  }
>  
>  /**
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 8ce1e41..4f39ba5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -190,7 +190,7 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
>  }
>  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
>  
> -static int syscon_match_pdevname(struct device *dev, void *data)
> +static int syscon_match_pdevname(struct device *dev, const void *data)
>  {
>  	return !strcmp(dev_name(dev), (const char *)data);
>  }

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
