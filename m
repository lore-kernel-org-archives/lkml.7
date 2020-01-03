Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F05521835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lyEsEuUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgACLnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:43:42 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:38505 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:43:42 -0500
Received: by mail-io1-f50.google.com with SMTP id v3so41112343ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y0OONBs4gn3TAMG/9zfn43zRfQC5HcMFZ3670SZhyEk=;
        b=lyEsEuUT5YH96fNGG8FKUiZEMSkMnma2gQJHAefDl7slKP/yWBZKpdDhPcu36/P8IP
         4CeXAgEGNwc0KZ5Si8jDjCLfdqarzl2awc4O0cYJNmibCONhC9yC2EXvxSlRx97Fw0K2
         IT+JGLuSUDwjq+z+BEkYbX2ApDxodRHX1LAYkuriIRC4P4gFBUlNEQjsajN8VM/+COOh
         HY93hNXl46ZRUPGTC5lEFBcadUM++An9Jl56gPDehg5RN2eOPqRc8EDwnmZ84gDqLylq
         +0mCbnMn9PiVhcF5kcBZ474KsmsISGb7tEEcWoqB+LJB0LYQouXBsXEPP8aCDSvONL2J
         FygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y0OONBs4gn3TAMG/9zfn43zRfQC5HcMFZ3670SZhyEk=;
        b=e1e9OYDv1RV2xMPrKWv7cTM3/CfZiMqw42+dM2zp0VxUmWA5HIV9cbpSJKOyy/A8nY
         pXws3+ye5+w0dMJdb8Xa+B25dLHg95uaXfqzU4DYzieBVIk4Un0enXuqkVwSHf1Nbr0W
         Sd1DVEJNQ1ymi1jrT9SIMsKJ98NNzT+IyXCYd2trQYuIiMhvofgRlls1BQIxLKcJ3xMh
         pWwNn6sSnzDW1erL9oYj6cKWNXNZNXQeTeO+Im+H8Wkt5Wl0ZcpgD44LQoyHFfPsEOQg
         yNWctIVj8xwyhIp/D56LKxaXltos6xH/9+raRwjpD9Uzox2vzqGjFGqKgnzMra7WrpHS
         44rQ==
X-Gm-Message-State: APjAAAXoMycyC2/itLIrgLo0Ju7RcwIB8vYIuSJnhFw3Cu9loip4jd+Y
        KZF8OGpu2Us4w7LSMMUI5kKGtmCnNWgwUepWkb7YZJ5m
X-Google-Smtp-Source: APXvYqxPm51Zv+ADJF+5SRuCmrI3yjDL3Mui4bBtSoq3U5Ub3vfVdYARcZiqlv22KOutyUcM0BagxlOrDf4/qnpXfeU=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12mr55441931ioh.189.1578051821416;
 Fri, 03 Jan 2020 03:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20200103053642.yr7ynaqmi67z5hmk@dev.opentheblackbox.net>
In-Reply-To: <20200103053642.yr7ynaqmi67z5hmk@dev.opentheblackbox.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Jan 2020 12:43:30 +0100
Message-ID: <CAMRc=MdM+OknEhguq5SxkOqyp0M62TU3T1+iMwvooHsDXU8Fqg@mail.gmail.com>
Subject: Re: Apparent Kconfig bug for Maxim 77650 driver
To:     Paul Gazzillo <paul@pgazz.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 3 sty 2020 o 06:45 Paul Gazzillo <paul@pgazz.com> napisa=C5=82(a):
>
> It seems there is a Kconfig issue that causing a linking error for driver=
s/mfd/max77650.c.  It happens when CONFIG_MFD_MAX77650 is set (which contro=
ls drivers/mfd/max77650.c), but CONFIG_REGMAP_IRQ is not.  CONFIG_REMAP_IRQ=
 controls drivers/base/regmap/regmap-irq.c, which has functions called by m=
ax77650.c.
>
> In drivers/mfd/Kconfig, it looks like CONFIG_MFD_MAX77650 is meant to hav=
e "select CONFIG_REGMAP_IRQ" like several other configuration options from =
the same Kconfig file.
>
> Steps to reproduce the bug for next-20191220 (also happens on other versi=
ons, e.g., v5.4.4):
>
>   1. make allnoconfig  # using x86
>   2. make menuconfig
>     a. Enable device drivers->i2c support
>     b. Enable device drivers->device tree and open firmware support
>     c. Enable device drivers->multifunction devices->maxim MAX77650
>   3. make  # should have a build error when linking vmlinux
>
> This is the build error I get:
>
>     ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
>     max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_=
chip'
>     ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_d=
omain'
>     make: *** [Makefile:1079: vmlinux] Error 1
>
> Is this a real bug or am I doing something wrong?
>
> Best,
> Paul

It's a bug, thanks for reporting. I just sent out a fix.

Best regards,
Bartosz Golaszewski

PS please set your e-mail client to wrap lines around 80 characters
when posting to LKML.
