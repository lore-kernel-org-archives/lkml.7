Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E75AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9DC2182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0B7/O1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfHEJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:53:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32944 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:53:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so57534371lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhFhmYD1XCmoTjeTnvzGsODetc1XqqaQE8oBpm4W4vQ=;
        b=K0B7/O1SMz4RHGXSXodAVa9L8sFoa6UoXKns2dJR1JyKOU2c6furolEA7Q5allCkl0
         hz3utRt5xZzsleYc5j96GSG5SHJEN9qRmcnlBwZ5Hbwn+fft/iuWyPYdhkJXD/m3jjk7
         jrqz4dcI6wnABAMB/2cejuK/mx5zUZuzGuS867Iji3hw8OpOMM0EX1haB0kh4NotBmOv
         TnrXt+nPzDsghutAkYvsNt/760Kmcu8ed+WXy1lumUgqOtf+HKx+P7IjgQ1X5X3F7qkT
         B41DImoEkIRtZUYYGgcCoKd1jS/rYluUTw2JPsGDWnr8wMsUgYyBHWgFNW3+ViFzuyiM
         iwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhFhmYD1XCmoTjeTnvzGsODetc1XqqaQE8oBpm4W4vQ=;
        b=PV+URA4C7kHJ0+cwsHVXCrvzF7Pz62Scurb7BzxnHuHgKipRfSBaFap76DNFcpa5GE
         Z9XBcxX7PT9T35Mc6hnsj7gdtbjd3wATC/6dKAdQq2+FOct9Ti7CnhYljuhrytdeTe1k
         eOPmY+iTVMzaTnoGD2hLXsHypliA7/S0ub45XjHoApzciA8zBPLVzIhkZaxyEIZxv1C0
         3Vb8pB71wB4jj8aLewSHE7TKi8Z4Y/raJwDUSxeKQY7tkgn/LlTkcAlHZW0xOvO28aez
         zlMNC73kox4yYmXZMDksw89A+gDOawgkRXYp9eKRKXcsvS0iLaMAgUPpP1fYi6m9LGL9
         DPrg==
X-Gm-Message-State: APjAAAXwdocyw0jb0hRl3sf1aZW9AOPyCmDSyHEEO+1Kpjpddk2D0+OJ
        EMBnl8AfaQs+x8zRj0NNBYwz6szNAgr5qgbzeRplyw==
X-Google-Smtp-Source: APXvYqznj+OyBQxOK0qX1ZGixNtwr50nmLElXsC7qnFS3oH2+cAja/iMhd5ozIzmb9vouUkDfKjemRMc1Gv/14GZ9L0=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr1288145lfq.152.1564998796491;
 Mon, 05 Aug 2019 02:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190722150302.29526-1-brgl@bgdev.pl> <20190722150302.29526-2-brgl@bgdev.pl>
In-Reply-To: <20190722150302.29526-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:53:04 +0200
Message-ID: <CACRpkdYexsXR=n+t1iVb1QMZc9U1FeKdyHy3w4VnfPy4B=xeiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] sh: ecovec24: add additional properties to the
 backlight device
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-sh@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a GPIO lookup entry and a device property for GPIO backlight to the
> board file. Tie them to the platform device which is now registered using
> platform_device_register_full() because of the properties. These changes
> are inactive now but will be used once the gpio backlight driver is
> modified.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Clever! I must also use these dynamic properties now.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
