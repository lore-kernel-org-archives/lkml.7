Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E71C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE1420830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4k7ZEaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfJCLkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:40:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35780 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfJCLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:40:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so2048720wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gjHdxQE7PtU5YVyM+ycu+GpQGZRZGPXn8KLYV2GOEKk=;
        b=M4k7ZEaOrA5MBGW706POYnYF+p7UCzDpRDmB6KUX786TBU7kDYHUX5qgxshhoqyUQ8
         2h+yx+Wrx3YZkGDqFvQM2n76bQMi7hxDFFVRmqdFwDtmKDBHC0C1V4WbKZFFpmSKiNtk
         2dDq1dnYh8JFNYqnHUtvtgqPNTQxV5Pv+CQn+T2oHQ16zT6sk/3UJx4EkxEqfx6KIdLx
         JZwOvG9EH0TosRqhoWm+SWsNlwtJ0dPhJgNY7whXqUyetzZhUJ0nuNyMddCsl/BYp3T0
         IvpjkPZwd5ju/73exB5nEx++DHrubLvNaxZaAJuxkCLT7fv/3wBFAohiAaM+yy6nNT2g
         0oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gjHdxQE7PtU5YVyM+ycu+GpQGZRZGPXn8KLYV2GOEKk=;
        b=QzPDT5IZ//ghXSdtwEKFlcM7+Ewq9ngBxHOWPT6aVzqB98REyTQlTbavM9hHy4wuCU
         1r4rxW0t9KUWp151Kx33ix+L5SOgZrBa7Zlh907XInz8UZXieTvQvPEl5IeY1f0Mzd4p
         epkar2gbNWtvruDRc+Z06eUw6DvmpIi5WtuLh9Sd0wxBl7dVN4kJYW1KakZBgwHhjeLg
         697Xl/oYMKtjAa9Ftb8h8IqnPFJAzMBlqQlMpHnfVspVbsyky0/tAPL4ItrUUvJVj9J5
         CMRyI6fWWQA1OZkvAMHYZ3Ulks6rFm2ayBIB3oYm6GqBalLd9OZgOZoIHsvzqqVOpjQf
         VQRQ==
X-Gm-Message-State: APjAAAVU97mfKMkl0QKMl8A+YCUXLWNcF3lbx55poF15co0f8yK7LVry
        OO1BhA7wj48OXE5lqYyBu2OZuA==
X-Google-Smtp-Source: APXvYqzkSbKbEO08kV+O5J56dhn/FaSKA4qIomPodHv4axxtI0btIULXGYjMIdOtEj1HzR/N8fo89Q==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr6111876wml.86.1570102832057;
        Thu, 03 Oct 2019 04:40:32 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id q10sm5931600wrd.39.2019.10.03.04.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 04:40:31 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:40:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v8 0/5] Add a generic driver for LED-based backlight
Message-ID: <20191003114028.GC21172@dell>
References: <20191003082812.28491-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003082812.28491-1-jjhiblot@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019, Jean-Jacques Hiblot wrote:

> This series aims to add a led-backlight driver, similar to pwm-backlight,
> but using a LED class device underneath.
> 
> A few years ago (2015), Tomi Valkeinen posted a series implementing a
> backlight driver on top of a LED device:
> https://patchwork.kernel.org/patch/7293991/
> https://patchwork.kernel.org/patch/7294001/
> https://patchwork.kernel.org/patch/7293981/
> 
> The discussion stopped because Tomi lacked the time to work on it.

[...]

>  .../bindings/leds/backlight/led-backlight.txt |  28 ++
>  drivers/leds/led-class.c                      |  98 ++++++-
>  drivers/video/backlight/Kconfig               |   7 +
>  drivers/video/backlight/Makefile              |   1 +
>  drivers/video/backlight/led_bl.c              | 260 ++++++++++++++++++
>  include/linux/leds.h                          |   6 +
>  6 files changed, 399 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
>  create mode 100644 drivers/video/backlight/led_bl.c

How should this set be processed?  I'm happy to take it through
Backlight via an immutable branch and PR to be consumed by LED.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
