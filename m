Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D558C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16BF20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6dSQpzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfF1KPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:15:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33497 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF1KPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:15:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so5445505ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kuj/HA5ST1YfjCjqjIBhZNTXDUSb6xW7P1aCaiPqrgA=;
        b=r6dSQpzyJ15l8/BZOerGnIC0wmlXFFxfmCNPswk98awd0aKKD/xz4DYIkFnrcpARwc
         9sdvqCgd+viVCqOoqV5DsJAzOBUhUf/9nizOab/W05hGnZ+aRPgxYSIvNp/etvsf0Bd5
         7F4BrgRgXu1c9aYrUgEPX1eF/7LB/YoDreIZpGZnd2Ti3SaiRfgp05yGFCfRpyUWgepa
         oLODrZ7ssyKN4rbX8g59LuC3JvntLy+gjzULgxNHEHNn3QTm6v/wkO5hDsKGyWISADOz
         7bVhqeEKt5MJ2n98pVYGCrxjEj6/99R06YIrx9A8E2D83Zm2PoCJRlDWEY6NInkGexOX
         pB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kuj/HA5ST1YfjCjqjIBhZNTXDUSb6xW7P1aCaiPqrgA=;
        b=DMhOrekWFDhxkxzSgh55cwCuAfEJqU7ksETc8laCD1kqIWJWw+OibGzzOH/WdZ8WkB
         rZnoJH29AMUG+CITaHJhg0mY77p8a8irgaYYBxkvSvllis+lm+3A1C+7oNsMcG8bC7lN
         pH9Ymu7pheGPTStbpW3bX6T5J7oY9hFTCUU5DV2cSlEYyb6HKSOcGRq7xWEUSwcEj2Kk
         0ojrqUEPIpIP+BJvNzlVnW4+XxydxWJwC+P9AB2HiKpUOLLo+gFpNnxdO4uavQBT06kr
         at6aVEJ/OD6mQhOZpqdEHxucOLUCkOzQPlThcuT67xOlnBCwDnMxCY0EbUDGtE0z1El6
         bMFA==
X-Gm-Message-State: APjAAAVMciqNTPb5Qw6SYxJ3fCunPFSa6hqZqDyRddLGJUIfmnjji2Hy
        34iScqn4LN4vOk9rWcBJd/62WRgm/tLgj99C89N2Pg==
X-Google-Smtp-Source: APXvYqwYZ2VwFJZSHzxzSaLF/aTvHeHNBwJGW3yg8YND+7cFBk+h9mUEiXw+n8bOv+ARb6mtvZlpXB0Ri+mSjhURIAs=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr5837692ljj.108.1561716922174;
 Fri, 28 Jun 2019 03:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190628100253.8385-1-brgl@bgdev.pl>
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jun 2019 11:15:10 +0100
Message-ID: <CACRpkdZqsgXoZcHv9z+7oVrf=i9WPSHG=93qhfA=0SkR0Mdfxg@mail.gmail.com>
Subject: Re: [PATCH RFT 0/4] backlight: gpio: simplify the driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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

On Fri, Jun 28, 2019 at 11:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
>
> The first patch sets up all the required structures in the board file,
> the second modifies the backlight driver, the third and fourth remove
> the leftovers.
>
> This series depends on the three first patches from [1].
>
> I don't have access to this HW but hopefully this works. Only compile
> tested.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Excellent work!

Yours,
Linus Walleij
