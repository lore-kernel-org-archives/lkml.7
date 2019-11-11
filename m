Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57F2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmKD+5OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKLnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:43:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKLnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:43:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so14235387wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=btwpyE4DKhSXy4FwJ2ZD9A7dltuQxSGv5JHsll8DI20=;
        b=lmKD+5OS0vjqFt56pnvwLZFFro7OfkevToyeur/XuWHxeJ0Vk+XDK5YjVCvmrD615p
         gWflCdfIAN2jW4H6Y1kMf1wEiOQjzReY1Bd1YX8tUr+Lq8c0vMiDgavy+vGKdet/qXBn
         rZe0PDn9ELo3/RXuNhxhBpR+Q5TgjV8TLFpWQX/a/6xueaBHXGj0fVM2ujqg8m02PwB2
         b+/vWx+ilnjUisD0BXGtA++yPVLfSDAv07zuEn4ZCS6k0R5a3+33/iH0OoUmWgPozECI
         czwHujbbNUYtlVbolr32G/KAIWgUf3gnkZoREabNFo6xsQq/hhjpFNTHa5Sh5Zdma/W5
         z2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=btwpyE4DKhSXy4FwJ2ZD9A7dltuQxSGv5JHsll8DI20=;
        b=arIBYuMK6MlBKK4rDvM5cu2gKvhUWI/Cm+IB0AOHno+TIeHa4zSnngWUgqN+MjFCnN
         dDNoALvftA9WwqqTFmycdAtw2JaW89RMY0tEe0Mu1HC/en6hEH8w3cO5UMcl71n/iW+E
         tGlIG6P7wXk9ZD16ok5opQQwr7DAIHwchHNWagSt8/Vo6pBQlfg7BqQ5QZZLYOWdTlJy
         AOiE08xNiStk0Wj0QIb6F8lktgfANZ2NMbCS2DYxi0PwVjbfshXKJTtWVNAU97LZj3z6
         lIipQpNVdYQHJ0okhRqOeLUIm++HcZI5h4IJcG64nJHjknC6IRLxm93VS5/7L7zPqi6A
         ITvQ==
X-Gm-Message-State: APjAAAWsO+4XFoJIwc80aV27hjFXsdt2ZbV6cqZvKcGSKHcFQ1k3cyoe
        dd+OCtfjkrWGSRj2nHsWzrRcAQ==
X-Google-Smtp-Source: APXvYqxe0V7wxbe9LxXQ7Boi59XGm4VrGwzmHV65LvzGKaVJcLUW13/9tnDcvZeFl8ZE8L2l2442Yg==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr8778108wru.116.1573472617414;
        Mon, 11 Nov 2019 03:43:37 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id 4sm17320362wmd.33.2019.11.11.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:43:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:43:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 03/17] platform/mfd:iio: cros_ec: Register sensor
 through sensorhub
Message-ID: <20191111114329.GM3218@dell>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105222652.70226-4-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2019, Gwendal Grignou wrote:

> - Remove duplicate code in mfd, since mfd just register
>   cros_ec_sensorhub if at least one sensor is present
> - Change iio cros_ec driver to get the pointer to the cros_ec_dev
>   through cros_ec_sensorhub.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> No changes in v4, v3.
> Changes in v2:
> - Remove unerelated changes.
> - Remove ec presence test in iio driver, done in cros_ec_sensorhub.
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   6 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   6 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   6 -
>  drivers/mfd/cros_ec_dev.c                     | 203 ++----------------

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
