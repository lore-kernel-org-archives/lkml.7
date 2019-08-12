Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19804C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE32E208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PykGLLrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHLHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:24:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:24:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so103695243wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EzL5oPwPWP+i1Dl8GnEH4sLFKHKvgm53zQpW/LeZKN8=;
        b=PykGLLrMqapgzqImD33lH3WqU8EsjsQyR62y8ey8BqQqsULXtn31CMZxb2FxKrZHJg
         dcHyPbcCZzYG3x9gfly97a73ggE4cg6kNztifzFGzxqUkUfS38N8vZk5/CwYHFJsDv+C
         U82Ncu/sqmGlIOwqTibxSmtR1idwD2AsKAbtsmq493DMw1hNQ/htWBvWQXsnY4bNfjMt
         JBfsedyfZHr5mH9rwmdyKZtG3vQvxF1XqN1ciey/VvSjhlZhOwxl+jjql/Yiaf/7n4mg
         fFhw4TotMfpvFmERsO0coxyjzCLPZVQFwGSSDlsK+q5u400mvGfVqu2qXT0WqOCntvEz
         Iswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EzL5oPwPWP+i1Dl8GnEH4sLFKHKvgm53zQpW/LeZKN8=;
        b=Gn6KL/6fTVBH+VWN7OAcB7rk3qxtWz71ZgUXOgbrcR6SJs+1BhKEok1yQIyNb7hpNR
         A1seB1Fcz1+nHfsrhEMFwO3DVlhZXxCzrW4aa7huolxdj9W/TKdXpvQtff9SIapl+X4T
         N7OBJ6Zrepd5y902wFi/N+INZejcfQH+ngt+aeQ05gqM+eBJdQXlICWzWQIDs8dYzC4Z
         F8dJYPTrgZZFVo9f/R9cGzGmCW3jFt2WONKMyRDgT4m+eHi6p/TaV3yOvfNBhye2mRhq
         /1K5KXbHXx7m4z/nzCcAM2ghdDASuCssDPuOtb3xzgG7fXv0mRyMVxHQleNZjBwQWBVW
         PsnQ==
X-Gm-Message-State: APjAAAUmumAF5MQxIWN8CIIKhPrt0cUdUQbAoeSDXaticfynJ1NC/J3C
        0L5LWqLK/i4+hinIBTHSD8taKg==
X-Google-Smtp-Source: APXvYqxWIEwdrZb54vApYuurr77b3Tu0nBVwUKEN5UJvyW1EJjpr4te7ZaJg0SUfDKIlNxnGcWFnTg==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr28304515wrn.8.1565594696080;
        Mon, 12 Aug 2019 00:24:56 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id l3sm23743226wrb.41.2019.08.12.00.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:24:55 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:24:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 03/11] mfd / platform: cros_ec: Miscellaneous
 character device to talk with the EC
Message-ID: <20190812072453.GG4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> That's a driver to talk with the ChromeOS Embedded Controller via a
> miscellaneous character device, it creates an entry in /dev for every
> instance and implements basic file operations for communicating with the
> Embedded Controller with an userspace application. The API is moved to
> the uapi folder, which is supposed to contain the user space API of the
> kernel.
> 
> Note that this will replace current character device interface
> implemented in the cros-ec-dev driver in the MFD subsystem. The idea is
> to move all the functionality that extends the bounds of what MFD was
> designed to platform/chrome subsystem.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5:
> - Prefix the versions strings with CROS_EC_DEV_VERSION (Gwendal)
> 
> Changes in v4: None
> Changes in v3:
> - Fix 'linux/mfd/cros_ec.h' is not exported (reported by lkp)
> 
> Changes in v2:
> - Remove the list, and the lock, as are not needed (Greg Kroah-Hartman)
> - Remove dev_info in probe, anyway we will see the chardev or not if the
>   probe fails (Greg Kroah-Hartman)
> 
>  drivers/mfd/cros_ec_dev.c                     |   4 +-
>  drivers/platform/chrome/Kconfig               |  11 +
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_chardev.c     | 252 ++++++++++++++++++
>  .../uapi/linux/cros_ec_chardev.h              |   9 +-
>  5 files changed, 271 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
>  rename drivers/mfd/cros_ec_dev.h => include/uapi/linux/cros_ec_chardev.h (80%)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
