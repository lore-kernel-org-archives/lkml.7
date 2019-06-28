Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA3EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734632064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evisap28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF1Ovo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:51:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37756 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1Ovo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:51:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so797210pgi.4;
        Fri, 28 Jun 2019 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrM3FvmBCbPYQ2NinJ38ellKrJziDThKo2p7l1cubIc=;
        b=Evisap28no3DoZp+1blRLNe/MsMHoJrcwrgHTfdfp8oS5fsRkJ+KCBzFA7qBqE0Vc2
         rVf1InKKJ6mTno89RnaySGqORWzBsExbN9/5+xxNgPnxdchEtV+hmVTHqnbC2H0odcrS
         +8RdOGBo2M99nXQA19y3EbKotHiIm8swiSpulOqAQvUOo62V3qhRBPgydoVsFAOdybJd
         osWRDmY1U65BlvffsjIuQGkWYAaKwenpQv+SMrp/VVseg/aZMBXeT6dji5hgNQzuF4hU
         mxNnPJsiHvs+D3DTs6J8cJrmKQ8GpMOkA2AzaJfDsSRDjYDIL8lAI4PDIa+HplkEqJ2A
         lV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrM3FvmBCbPYQ2NinJ38ellKrJziDThKo2p7l1cubIc=;
        b=uKpV4XLickvpSocqv9YbQBU3xnSn9I4vU5EAGRfoEn0m5zLyIizzlfC6yQcIwcBaSH
         6ygu9nD5mQQg5GnuR56wp6NHLOLkUf+E+supAfLl0G24/i1m4UwwODB5cvQD6fieBpRg
         HkLrfB7hBQZl/ajtWvBCSydZAlARdKM/R4UgBZkGK+VJBG9Hj8YMpbBjyiqhYPa2cMG8
         cAYuJ2CvAU3/90z94WX12Nj4Uk3HpIM68F/xYDsf3uPAC5lIrE47r0cfa/vvax+dSq2M
         CxOf0SnB5totGnLExohmDYjJvHIHnf9eRf7ExlCt+uCfDEGVXZaSb8fKsg7Gw4nmRAs1
         BF2g==
X-Gm-Message-State: APjAAAWPvRNyFFf6ImFLREiTKQVL45Dr6+TPsvtPpzv7XrC9KD9yH7x2
        raUAvsEFDvYz4DMm0lmx844eaKBNHkf4DYlIy/k=
X-Google-Smtp-Source: APXvYqzHLJIE8Yt/TpTlK9owcdKJsXTjlr5IAE1/te81nDAdbtjpqFSCX9d6vfvsxsCEpaRj3456gIxXkyusfGx9XwI=
X-Received: by 2002:a63:f346:: with SMTP id t6mr10077691pgj.203.1561733503232;
 Fri, 28 Jun 2019 07:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561724493.git.mchehab+samsung@kernel.org> <f5c35189e421a5fa02075d611f58506bffe77028.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <f5c35189e421a5fa02075d611f58506bffe77028.1561724493.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jun 2019 17:51:32 +0300
Message-ID: <CAHp75VeJy2qEakb5Eag0MV7zuao0aHQCVu6ZMMZpy1JnZDJjYw@mail.gmail.com>
Subject: Re: [PATCH 17/39] docs: admin-guide: add laptops documentation
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matan Ziv-Av <matan@svgalib.org>,
        Mattia Dongili <malattia@linux.it>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:30 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The docs under Documentation/laptops contain users specific
> information.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-block-device                  | 2 +-
>  Documentation/ABI/testing/sysfs-platform-asus-laptop          | 2 +-
>  Documentation/admin-guide/index.rst                           | 1 +
>  Documentation/admin-guide/kernel-parameters.txt               | 2 +-
>  Documentation/{ => admin-guide}/laptops/asus-laptop.rst       | 0
>  .../{ => admin-guide}/laptops/disk-shock-protection.rst       | 0
>  Documentation/{ => admin-guide}/laptops/index.rst             | 1 -
>  Documentation/{ => admin-guide}/laptops/laptop-mode.rst       | 0
>  Documentation/{ => admin-guide}/laptops/lg-laptop.rst         | 1 -
>  Documentation/{ => admin-guide}/laptops/sony-laptop.rst       | 0
>  Documentation/{ => admin-guide}/laptops/sonypi.rst            | 0
>  Documentation/{ => admin-guide}/laptops/thinkpad-acpi.rst     | 0
>  Documentation/{ => admin-guide}/laptops/toshiba_haps.rst      | 0
>  Documentation/admin-guide/sysctl/vm.rst                       | 4 ++--
>  MAINTAINERS                                                   | 4 ++--
>  drivers/char/Kconfig                                          | 2 +-
>  drivers/platform/x86/Kconfig                                  | 4 ++--
>  17 files changed, 11 insertions(+), 12 deletions(-)
>  rename Documentation/{ => admin-guide}/laptops/asus-laptop.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/disk-shock-protection.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/index.rst (95%)
>  rename Documentation/{ => admin-guide}/laptops/laptop-mode.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/lg-laptop.rst (99%)
>  rename Documentation/{ => admin-guide}/laptops/sony-laptop.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/sonypi.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/thinkpad-acpi.rst (100%)
>  rename Documentation/{ => admin-guide}/laptops/toshiba_haps.rst (100%)
>
> diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
> index 0d57bbb4fddc..17f2bc7dd261 100644
> --- a/Documentation/ABI/testing/sysfs-block-device
> +++ b/Documentation/ABI/testing/sysfs-block-device
> @@ -45,7 +45,7 @@ Description:
>                 - Values below -2 are rejected with -EINVAL
>
>                 For more information, see
> -               Documentation/laptops/disk-shock-protection.rst
> +               Documentation/admin-guide/laptops/disk-shock-protection.rst
>
>
>  What:          /sys/block/*/device/ncq_prio_enable
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-laptop b/Documentation/ABI/testing/sysfs-platform-asus-laptop
> index d67fa4bafa70..8b0e8205a6a2 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-laptop
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-laptop
> @@ -31,7 +31,7 @@ Description:
>                 To control the LED display, use the following :
>                     echo 0x0T000DDD > /sys/devices/platform/asus_laptop/
>                 where T control the 3 letters display, and DDD the 3 digits display.
> -               The DDD table can be found in Documentation/laptops/asus-laptop.rst
> +               The DDD table can be found in Documentation/admin-guide/laptops/asus-laptop.rst
>
>  What:          /sys/devices/platform/asus_laptop/bluetooth
>  Date:          January 2007
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index acd0efa46e9d..9899b78dbe50 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -81,6 +81,7 @@ configure specific aspects of kernel behavior to your liking.
>     perf-security
>     acpi/index
>     device-mapper/index
> +   laptops/index
>
>  .. only::  subproject and html
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a3d3da5baacb..e38b96d061f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4373,7 +4373,7 @@
>                         Format: <integer>
>
>         sonypi.*=       [HW] Sony Programmable I/O Control Device driver
> -                       See Documentation/laptops/sonypi.rst
> +                       See Documentation/admin-guide/laptops/sonypi.rst
>
>         spectre_v2=     [X86] Control mitigation of Spectre variant 2
>                         (indirect branch speculation) vulnerability.
> diff --git a/Documentation/laptops/asus-laptop.rst b/Documentation/admin-guide/laptops/asus-laptop.rst
> similarity index 100%
> rename from Documentation/laptops/asus-laptop.rst
> rename to Documentation/admin-guide/laptops/asus-laptop.rst
> diff --git a/Documentation/laptops/disk-shock-protection.rst b/Documentation/admin-guide/laptops/disk-shock-protection.rst
> similarity index 100%
> rename from Documentation/laptops/disk-shock-protection.rst
> rename to Documentation/admin-guide/laptops/disk-shock-protection.rst
> diff --git a/Documentation/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
> similarity index 95%
> rename from Documentation/laptops/index.rst
> rename to Documentation/admin-guide/laptops/index.rst
> index 001a30910d09..6b554e39863b 100644
> --- a/Documentation/laptops/index.rst
> +++ b/Documentation/admin-guide/laptops/index.rst
> @@ -1,4 +1,3 @@
> -:orphan:
>
>  ==============
>  Laptop Drivers
> diff --git a/Documentation/laptops/laptop-mode.rst b/Documentation/admin-guide/laptops/laptop-mode.rst
> similarity index 100%
> rename from Documentation/laptops/laptop-mode.rst
> rename to Documentation/admin-guide/laptops/laptop-mode.rst
> diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
> similarity index 99%
> rename from Documentation/laptops/lg-laptop.rst
> rename to Documentation/admin-guide/laptops/lg-laptop.rst
> index f2c2ffe31101..ce9b14671cb9 100644
> --- a/Documentation/laptops/lg-laptop.rst
> +++ b/Documentation/admin-guide/laptops/lg-laptop.rst
> @@ -1,6 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>
> -:orphan:
>
>  LG Gram laptop extra features
>  =============================
> diff --git a/Documentation/laptops/sony-laptop.rst b/Documentation/admin-guide/laptops/sony-laptop.rst
> similarity index 100%
> rename from Documentation/laptops/sony-laptop.rst
> rename to Documentation/admin-guide/laptops/sony-laptop.rst
> diff --git a/Documentation/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
> similarity index 100%
> rename from Documentation/laptops/sonypi.rst
> rename to Documentation/admin-guide/laptops/sonypi.rst
> diff --git a/Documentation/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> similarity index 100%
> rename from Documentation/laptops/thinkpad-acpi.rst
> rename to Documentation/admin-guide/laptops/thinkpad-acpi.rst
> diff --git a/Documentation/laptops/toshiba_haps.rst b/Documentation/admin-guide/laptops/toshiba_haps.rst
> similarity index 100%
> rename from Documentation/laptops/toshiba_haps.rst
> rename to Documentation/admin-guide/laptops/toshiba_haps.rst
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 5aceb5cd5ce7..64aeee1009ca 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -108,7 +108,7 @@ block_dump
>  ==========
>
>  block_dump enables block I/O debugging when set to a nonzero value. More
> -information on block I/O debugging is in Documentation/laptops/laptop-mode.rst.
> +information on block I/O debugging is in Documentation/admin-guide/laptops/laptop-mode.rst.
>
>
>  compact_memory
> @@ -298,7 +298,7 @@ laptop_mode
>  ===========
>
>  laptop_mode is a knob that controls "laptop mode". All the things that are
> -controlled by this knob are discussed in Documentation/laptops/laptop-mode.rst.
> +controlled by this knob are discussed in Documentation/admin-guide/laptops/laptop-mode.rst.
>
>
>  legacy_va_layout
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40d057631004..d35ff73f718a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8978,7 +8978,7 @@ M:        Matan Ziv-Av <matan@svgalib.org>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-platform-lg-laptop
> -F:     Documentation/laptops/lg-laptop.rst
> +F:     Documentation/admin-guide/laptops/lg-laptop.rst
>  F:     drivers/platform/x86/lg-laptop.c
>
>  LG2160 MEDIA DRIVER
> @@ -14830,7 +14830,7 @@ M:      Mattia Dongili <malattia@linux.it>
>  L:     platform-driver-x86@vger.kernel.org
>  W:     http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
>  S:     Maintained
> -F:     Documentation/laptops/sony-laptop.rst
> +F:     Documentation/admin-guide/laptops/sony-laptop.rst
>  F:     drivers/char/sonypi.c
>  F:     drivers/platform/x86/sony-laptop.c
>  F:     include/linux/sony-laptop.h
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index bb734066075f..442403abd73a 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -382,7 +382,7 @@ config SONYPI
>           Device which can be found in many (all ?) Sony Vaio laptops.
>
>           If you have one of those laptops, read
> -         <file:Documentation/laptops/sonypi.rst>, and say Y or M here.
> +         <file:Documentation/admin-guide/laptops/sonypi.rst>, and say Y or M here.
>
>           To compile this driver as a module, choose M here: the
>           module will be called sonypi.
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 1f616844fb87..85101c678693 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -448,7 +448,7 @@ config SONY_LAPTOP
>           screen brightness control, Fn keys and allows powering on/off some
>           devices.
>
> -         Read <file:Documentation/laptops/sony-laptop.rst> for more information.
> +         Read <file:Documentation/admin-guide/laptops/sony-laptop.rst> for more information.
>
>  config SONYPI_COMPAT
>         bool "Sonypi compatibility"
> @@ -500,7 +500,7 @@ config THINKPAD_ACPI
>           support for Fn-Fx key combinations, Bluetooth control, video
>           output switching, ThinkLight control, UltraBay eject and more.
>           For more information about this driver see
> -         <file:Documentation/laptops/thinkpad-acpi.rst> and
> +         <file:Documentation/admin-guide/laptops/thinkpad-acpi.rst> and
>           <http://ibm-acpi.sf.net/> .
>
>           This driver was formerly known as ibm-acpi.
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
