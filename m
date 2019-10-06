Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF9C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403120867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EGpBGCDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfJFFkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:40:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34337 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfJFFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:40:49 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so22031937ion.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xI2Qocms6qNiV2iMXZu4/cQtgB5QztaNG2lDp34DqfU=;
        b=EGpBGCDteikNjZQNE/D2fgB2B2Z5RVlThy/2WcnO0jF5pxMgwOTL2EmK/44wDn/XKQ
         INJot3NMPr54eKTg8amLWAU7zXHfrmeYxNigDsUmjrL0tKiOmSGN88YzxwJmgR3UIzdC
         FYkyR0ZYMkV4sutJ5t+tdb3EXpXFHVFCxvKntSpCk9797I37anqXrhOO8jY37WHQrDvP
         Zp3VjJ+4eabYt8YBlCLsO/IQ6gcDHyjy9tlr43yic8FfZ4lsp4yczel6Gyfaji4RgkUV
         gkhqxxfgEsl49vFVcvYxJt3qZNGCfhWFVK0wBDpAdqtzC0HmSMaRTx1fz+E9bkgFxz/P
         cakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xI2Qocms6qNiV2iMXZu4/cQtgB5QztaNG2lDp34DqfU=;
        b=hpxy6tAfJdv8jABmmZlv3M5qHQbrxIkipxaQt7vr3AYFLzjSpJ6eHpmQVlaDKSu1mF
         cpaPq8NH/2t54MB2+kNRGzKX1S278tHHx8tZ3V4XjgBVgJGD+EymEVRpzkd45AsoWX/L
         eTqkmgTpANg8YwDx/nbotbvgicRG0GaNDklakrCWNkX37A3k2RwUZhpRnWw8XlyOPmPo
         7cnFexMe2RjQYaFZdIcY2fnapCL/a6TZXt+F0WPdriLs11iFbyTIdeL9IJCVtxsilQ11
         wlMiyIWQoV44dLFFINqg2vE4sfK5EKWpQOFKIQONCY2JNtic5l+TMXxttnYmk5drYsqu
         +gGg==
X-Gm-Message-State: APjAAAVAbIJut1UfHiGOow0kncMR5/EwD6Jtczf9FPxwIyso8WEI/DRG
        FmtkWCEzXF/NcqVmlpxB9T5mZc/VsH3gBPy/HtpRw80tOF4=
X-Google-Smtp-Source: APXvYqz4088A6dPyccPjCU4wsr/q3N0DxLDhD1/3tMWhqtSwIStW2H9CSh33Kegu/W7Io815JqtEfVP7uE2c1XIYQIY=
X-Received: by 2002:a6b:fc04:: with SMTP id r4mr8557796ioh.189.1570340447106;
 Sat, 05 Oct 2019 22:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191002162534.3967-1-brgl@bgdev.pl>
In-Reply-To: <20191002162534.3967-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 6 Oct 2019 07:40:36 +0200
Message-ID: <CAMRc=Mdk+9KTHAp_kuF4uy5uSACO6Qkdnn_=bqkYwqbrsUXbxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drivers: add a new variant of devm_platform_ioremap_resource()
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 2 pa=C5=BA 2019 o 18:25 Bartosz Golaszewski <brgl@bgdev.pl> napis=
a=C5=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The new devm_platform_ioremap_resource() helper has now been widely
> adopted and used in many drivers. Users of the write-combined ioremap()
> variants could benefit from the same code shrinkage. This series provides
> a write-combined version of devm_platform_ioremap_resource() and uses it =
in a
> relevant driver with the assumption that - just like was the case
> previously - a coccinelle script will be developed to ease the transition
> for others.
>
> v1 -> v2:
> - dropped everything related to nocache ioremap as this is going away
>
> Bartosz Golaszewski (5):
>   Documentation: devres: add missing entry for
>     devm_platform_ioremap_resource()
>   lib: devres: prepare devm_ioremap_resource() for more variants
>   lib: devres: provide devm_ioremap_resource_wc()
>   drivers: platform: provide devm_platform_ioremap_resource_wc()
>   misc: sram: use devm_platform_ioremap_resource_wc()
>
>  .../driver-api/driver-model/devres.rst        |  3 +
>  drivers/base/platform.c                       | 27 ++++++--
>  drivers/misc/sram.c                           | 28 +++------
>  include/linux/device.h                        |  2 +
>  include/linux/platform_device.h               |  3 +
>  lib/devres.c                                  | 62 +++++++++++++------
>  6 files changed, 80 insertions(+), 45 deletions(-)
>
> --
> 2.23.0
>

Superseded by v3 which adds another variant that might be useful.

Bart
