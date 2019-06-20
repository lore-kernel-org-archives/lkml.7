Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126372147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6FqUsmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFTGOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:14:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43633 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTGOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:14:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so990160pgv.10;
        Wed, 19 Jun 2019 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4cIeTi4GQNLRlznEj81pK4DefY3R9Wq48lqryAGlQM=;
        b=s6FqUsmtVE/aRyBb1l0nowEvvjpeAbwuVV8WnlOIAGWNnbRZXkotXsfrDXdIf05HWH
         UmNu3nRFl78pVjYK7Gv5a1a5P2841nLoYV3utETFRRbI8eNzfgbIey69YAI9bow34eRc
         5941jzNbcojTM8j5J7hqwg62HBUhHBb62HTUBt8jsVX06WDyzgWfJPvtB0R83/sxqyPw
         FARQhXwYUonhV3a7DuZAckp+m4d37bxthPY3bF3iSzErHMO+QCqBLX/C+YDkwR8lGHDS
         Ke7QZoRjQ/GEkRGsi9tuyIK2yqvBK1mhcgEQhvqAEMt/Dqn+xbafSijow9JhFo8iz8zJ
         5rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4cIeTi4GQNLRlznEj81pK4DefY3R9Wq48lqryAGlQM=;
        b=UXzu+yplNr1y/b4oen8/sMx/Zk619NVwrxM/mQTakHbFjgxbFt7urCj5FFaOGDPH63
         /qhDJYM8YalIwBsgjMNKzenOePyL9l8xZemmvXzKtTRsoXIl5VYEL16DnnDmEHSKQM/8
         0TmuVoj7zLcYD+jUz9WGyfe32yhnhbVgKDY0JIzbczRjSlQM3ngrICobg6TPuHQiTrwt
         1HUjx//kBC1gi8fVeFGYFEkc9duDaUC6Hod96+UG5fyfEXXlxVQt9yOSGIgKaPjgtSrn
         ozYfMkKiuz3MZgW4rqIi4wurgD9EGif+oN4DL6O0YZ+qAxKsmOpEmxV85Q6Xd6M+gSsQ
         z6OA==
X-Gm-Message-State: APjAAAV/01AT1yN9Ad89sEwKnu1M8imJtRl3n8CUqp8WasNl7v1yFWM4
        0iV2J2eJyaCWJCfeNhGQ2u3sjSDkRHeS0rx1XEsONslQ2Hvjbg==
X-Google-Smtp-Source: APXvYqxpNxYmoR30y+1MSB2QCWiblWr586ldBb+RZPqhWlLIMknG1+b78xG0Yl6g/Dm4gW32hvXoiMZVM7AHyDpAziU=
X-Received: by 2002:a65:448b:: with SMTP id l11mr11172601pgq.74.1561011276684;
 Wed, 19 Jun 2019 23:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560891322.git.mchehab+samsung@kernel.org> <48cf367612aeec99f9eef54bb57685eb3b6c4ebf.1560891322.git.mchehab+samsung@kernel.org>
In-Reply-To: <48cf367612aeec99f9eef54bb57685eb3b6c4ebf.1560891322.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jun 2019 09:14:25 +0300
Message-ID: <CAHp75VfqvJvTszpfhFD9Q-Ab+AGkytvLwMh3rngscre7AUefEg@mail.gmail.com>
Subject: Re: [PATCH v1 21/22] docs: admin-guide: add laptops documentation
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

On Wed, Jun 19, 2019 at 12:05 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The docs under Documentation/laptops contain users specific
> information.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

with a caveat about Documentation/admin-guide/sysctl/vm.rst.
How block bump is related to laptops? It sounds rather common
debugging feature, no?

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
> index 5940ce8d16af..e4f0cb2a02bd 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -79,6 +79,7 @@ configure specific aspects of kernel behavior to your liking.
>     aoe/index
>     perf-security
>     acpi/index
> +   laptops/index
>
>     btmrvl
>     clearing-warn-once
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b17312b9198..69a9e2e66dfb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4356,7 +4356,7 @@
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
> index 4940ab610eb7..d918b11326f3 100644
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
> index b7c81bd0f8e8..ab170522ec55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8927,7 +8927,7 @@ M:        Matan Ziv-Av <matan@svgalib.org>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-platform-lg-laptop
> -F:     Documentation/laptops/lg-laptop.rst
> +F:     Documentation/admin-guide/laptops/lg-laptop.rst
>  F:     drivers/platform/x86/lg-laptop.c
>
>  LG2160 MEDIA DRIVER
> @@ -14756,7 +14756,7 @@ M:      Mattia Dongili <malattia@linux.it>
>  L:     platform-driver-x86@vger.kernel.org
>  W:     http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
>  S:     Maintained
> -F:     Documentation/laptops/sony-laptop.rst
> +F:     Documentation/admin-guide/laptops/sony-laptop.rst
>  F:     drivers/char/sonypi.c
>  F:     drivers/platform/x86/sony-laptop.c
>  F:     include/linux/sony-laptop.h
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 3a0f94929814..3e866885a405 100644
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
> index 9d866b6753fe..430f7f619553 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -451,7 +451,7 @@ config SONY_LAPTOP
>           screen brightness control, Fn keys and allows powering on/off some
>           devices.
>
> -         Read <file:Documentation/laptops/sony-laptop.rst> for more information.
> +         Read <file:Documentation/admin-guide/laptops/sony-laptop.rst> for more information.
>
>  config SONYPI_COMPAT
>         bool "Sonypi compatibility"
> @@ -503,7 +503,7 @@ config THINKPAD_ACPI
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
