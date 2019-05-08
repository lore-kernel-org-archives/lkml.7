Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A74C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFEF21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLz8F84h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEHL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:56:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfEHL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:56:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so13377860wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DB52DpeQK0sRWTUTWRJBhP3xrMQSlJ1Wcsb1JqjD2ZM=;
        b=nLz8F84hRlKrfmk6FY5MPonXwDS0G0wYzEc4LN/FLcOueVQj6U25V3KATjup3CLZia
         U9kadZfnDdfeziJF9pQ0hy1Ou6Gz7CcABdhtnoPQajJUr+GnjJY1osd18z7oDMXC0gq+
         nXmZH39Tg0oHR6uvd5bheSMykOI/h1f17UFGBU6e4RM5W8NHj/bMvIHiqtllrqQT2xce
         8jE2gP1ZJ5bzZLtmRGqhXNv8+Ryd2PPp+vK2NUVGYU8p8UkinWhbYCwYE4zfUEIxuiVi
         8VLYcJloowtVuDe9HoAqRAmBTDnFwxMf6RHGBurFMCnVfc4VK+Fqe/ep3P4fX4+Ogpey
         ZYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DB52DpeQK0sRWTUTWRJBhP3xrMQSlJ1Wcsb1JqjD2ZM=;
        b=H3XPpSZuGFz+lmssyjqXJjFuZ4f9Rtl7gBnZ7pUfFB4m0VgGGCfycHhZhvg4XCqhMU
         Zei1CdKgqyktAA5qwP/+v9tK0HvIg+n6krWP769P6BHNQ2L2jM+wWmSEH0162MB8NJiW
         Me+n1ZTskB18thRbR0dbJ/dpeKE1P8NTgTTkzxRQ6DS1ytzEQ7YbC1AiVXqKfbZ/hQGS
         FhISKGvrNVxFko1g/s73Tj+6TRj8rj/fqNyLERY04JGfvEPzn/U9YDSGbRiXBrZMWv1k
         8FMWApYzxyDY61pGzDDN1LlSC4NpOL7mHahEhbPzZuw8f3ZyEkKYW33pvY4vbINCsxNK
         eQ3w==
X-Gm-Message-State: APjAAAUCjyih7dd3V/ivZ4K2cmpVQhfDcy1kSkp8cYh4X9uyb/pLP3oy
        bfms37tmEplYyP/UkhCSmf/rEqgJhqE=
X-Google-Smtp-Source: APXvYqywmIxL5z/SEyv5I1ZAffePSJgW50oKAbBkA959LpKDhEyGcF6l09w3z0DOcADQ0AOYNzlNKQ==
X-Received: by 2002:adf:db4e:: with SMTP id f14mr259381wrj.35.1557316577082;
        Wed, 08 May 2019 04:56:17 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id l16sm6464312wro.15.2019.05.08.04.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:56:16 -0700 (PDT)
Date:   Wed, 8 May 2019 12:56:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v3 1/4] mfd: cros_ec: Update the EC feature codes
Message-ID: <20190508115614.GP31645@dell>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
 <20190408094141.27858-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408094141.27858-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019, Enric Balletbo i Serra wrote:

> Update the feature enum for the Chromebook Embedded Controller to the
> latest version. Some of these enums are still not used in the kernel but
> we might be also interested on have these enums up to date. Userspace
> can use them to query the features to the EC via the cros-ec character
> device.
> 
> While here, also fix a typo in one comment in the enum.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add a patch to introduce the required enums to build.
> 
>  include/linux/mfd/cros_ec_commands.h | 34 +++++++++++++++++++++++++++-

As always, I would like some more Chrome guys to review please.

>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 1cdb07c0ece1..dcec96f01879 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -840,7 +840,7 @@ enum ec_feature_code {
>  	 * (Common Smart Battery System Interface Specification)
>  	 */
>  	EC_FEATURE_SMART_BATTERY = 18,
> -	/* EC can dectect when the host hangs. */
> +	/* EC can detect when the host hangs. */
>  	EC_FEATURE_HANG_DETECT = 19,
>  	/* Report power information, for pit only */
>  	EC_FEATURE_PMU = 20,
> @@ -852,10 +852,42 @@ enum ec_feature_code {
>  	EC_FEATURE_USB_MUX = 23,
>  	/* Motion Sensor code has an internal software FIFO */
>  	EC_FEATURE_MOTION_SENSE_FIFO = 24,
> +	/* Support temporary secure vstore */
> +	EC_FEATURE_VSTORE = 25,
> +	/* EC decides on USB-C SS mux state, muxes configured by host */
> +	EC_FEATURE_USBC_SS_MUX_VIRTUAL = 26,
>  	/* EC has RTC feature that can be controlled by host commands */
>  	EC_FEATURE_RTC = 27,
> +	/* The MCU exposes a Fingerprint sensor */
> +	EC_FEATURE_FINGERPRINT = 28,
> +	/* The MCU exposes a Touchpad */
> +	EC_FEATURE_TOUCHPAD = 29,
> +	/* The MCU has RWSIG task enabled */
> +	EC_FEATURE_RWSIG = 30,
> +	/* EC has device events support */
> +	EC_FEATURE_DEVICE_EVENT = 31,
> +	/* EC supports the unified wake masks for LPC/eSPI systems */
> +	EC_FEATURE_UNIFIED_WAKE_MASKS = 32,
> +	/* EC supports 64-bit host events */
> +	EC_FEATURE_HOST_EVENT64 = 33,
> +	/* EC runs code in RAM (not in place, a.k.a. XIP) */
> +	EC_FEATURE_EXEC_IN_RAM = 34,
>  	/* EC supports CEC commands */
>  	EC_FEATURE_CEC = 35,
> +	/* EC supports tight sensor timestamping. */
> +	EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS = 36,
> +	/*
> +	 * EC supports tablet mode detection aligned to Chrome and allows
> +	 * setting of threshold by host command using
> +	 * MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE.
> +	 */
> +	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
> +	/* EC supports audio codec. */
> +	EC_FEATURE_AUDIO_CODEC = 38,
> +	/* EC Supports SCP. */
> +	EC_FEATURE_SCP = 39,
> +	/* The MCU is an Integrated Sensor Hub */
> +	EC_FEATURE_ISH = 40,
>  };
>  
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
