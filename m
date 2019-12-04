Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0269AC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84D8207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5Am9237"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLDIkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:40:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50523 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfLDIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:40:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so6077753wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CPOGV/8IiCeIDG6XJD4N+CaTFPOjpb+amQn4DTTeuHo=;
        b=X5Am9237hdiu6SnRkdyqee4vsw8T7ZqjCBI3yb7DZtKwSnl6ITPjk7DNLJ78DKGT6q
         UUxb/19tu496J3HIyM0tfQgt3Z7Uo5cmy2ysTjGfxKRRX4jL3qUlikni63lqci0Jq+9H
         VBOWmPyZG1B34OVgWLRULEqTpXB+tkGJsicr/xALm7ryx3FxY8gV4ssHm7T18th8XmOg
         ufGepWN+N3UHP3EBWuGF7eA2QB4loRx439JDOz++RSgj7om7t7JomlM9/ezphgKwAby2
         dhKG5ka9Qdkn8KbkVqKkkl51YJcj5xfwQiNjKb/RYQttkn4xKADSth3/N7/Txzw3jqqa
         lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CPOGV/8IiCeIDG6XJD4N+CaTFPOjpb+amQn4DTTeuHo=;
        b=dQ46jbig7kQ650EE/kVKwnsGiqvNZB8tWPx7GDDy3DcaQJm1A5TDjfejNyZ4Qc9UlD
         N/QvOY+DOJiTDWsRGu6S8mtIIA9D2J/O2HkinL8c3Q8a8NWoU5/xe1Gw7w05GxTtaiZW
         GM8knAqYmtEfHtguvnWCU+pQjw8/3Rh1Cn7S2zryODMMGXqAMXJ52MCAWaSToT+m2Q/q
         ABGogxMxwTlHzbOQexlLGPtbzPWTXjqUEdDUm85DOvOIfWcm9jRL5CqFvxaJ0jddf5vg
         ZBimyYHkb9yX5GK2lGdhlq2c9DZyyHbEktE8uj7Q3WwOrAmJtHO9WdMGqZROGbHb0cgP
         eY4A==
X-Gm-Message-State: APjAAAVNIoPguaxyFmOGyk1cQIMpOKjGiHDhOcws3Eaw7v2KAWO0EXPD
        Z9JQY3/I7SeLEOLvdvzNS9dYaQ==
X-Google-Smtp-Source: APXvYqzLyzOc0jQfYZK9ymAn5u/rHy2qMdZIi3s9mhmJDZdlYmd/2gz8jYS+G+K+0o1B06iSPtvJeQ==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr23525248wmk.119.1575448800004;
        Wed, 04 Dec 2019 00:40:00 -0800 (PST)
Received: from dell ([2.27.167.28])
        by smtp.gmail.com with ESMTPSA id c1sm7152787wrs.24.2019.12.04.00.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:39:59 -0800 (PST)
Date:   Wed, 4 Dec 2019 08:39:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-iio@vger.kernel.org, Nick Vaccaro <nvaccaro@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] cros_ec: treewide: Remove 'include/linux/mfd/cros_ec.h'
Message-ID: <20191204083950.GB3468@dell>
References: <20191203145018.14015-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203145018.14015-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Dec 2019, Enric Balletbo i Serra wrote:

> This header file now only includes the cros_ec_dev struct, however, is the
> 'include/linux/platform_data/cros_ec_proto.h' who contains the definition of
> all the Chrome OS EC related structs. There is no reason to have a
> separate include for this struct so move to the place where other
> structs are defined. That way, we can remove the include itself, but also
> simplify the common pattern
> 
>     #include <linux/mfd/cros_ec.h>
>     #include <linux/platform_data/cros_ec_proto.h>
> 
> for a single include
> 
>     #include <linux/platform_data/cros_ec_proto.h>
> 
> The changes to remove the cros_ec.h include were generated with the
> following shell script:
> 
>     git grep -l "<linux/mfd/cros_ec.h>" | xargs sed -i '/<linux\/mfd\/cros_ec.h>/d'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  1 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  1 -
>  drivers/iio/light/cros_ec_light_prox.c        |  1 -
>  drivers/iio/pressure/cros_ec_baro.c           |  1 -
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |  1 -
>  drivers/mfd/cros_ec_dev.c                     |  1 -

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/chrome/cros_ec_chardev.c     |  1 -
>  drivers/platform/chrome/cros_ec_debugfs.c     |  1 -
>  drivers/platform/chrome/cros_ec_lightbar.c    |  1 -
>  drivers/platform/chrome/cros_ec_sensorhub.c   |  1 -
>  drivers/platform/chrome/cros_ec_sysfs.c       |  1 -
>  drivers/platform/chrome/cros_ec_vbc.c         |  1 -
>  drivers/platform/chrome/cros_usbpd_logger.c   |  1 -
>  drivers/power/supply/cros_usbpd-charger.c     |  1 -
>  drivers/rtc/rtc-cros-ec.c                     |  1 -
>  include/linux/mfd/cros_ec.h                   | 35 -------------------
>  include/linux/platform_data/cros_ec_proto.h   | 23 +++++++++++-
>  18 files changed, 22 insertions(+), 52 deletions(-)
>  delete mode 100644 include/linux/mfd/cros_ec.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
