Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC05C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4923B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvBq1wvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfFRQLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:11:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37576 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfFRQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:11:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so15612383otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF3W31ELOp04NzzWKuq2jHZ3kNTf0ohMu5kyeaBrDYA=;
        b=gvBq1wvmu91AqWtQD6QwVeM5XaZRJoVlo/mzpjEBl+qZRvLyiS80Iv5tCmMDdS1Obs
         fEbEnvK6UuluSeF3R7I9qTLIp3VHRyAOvbjv4Rl1upOI9HK+lPG/ljno2X1iOEKG5O99
         wv67E1wkNuuetq0Sw7X8P94UGvQjelqOVGDn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF3W31ELOp04NzzWKuq2jHZ3kNTf0ohMu5kyeaBrDYA=;
        b=nbOByXI3To5iTxdaYtSxlCVEttFDk0YqaS0ZPyUOi/OX3kh18zBRrg2aGUulmmwOU9
         QgtoR+E7eJqW3UiYb1zuupjIEuqQVnuzQvnSQQzbmgAAWCxEYdwwOX2ocxPGBJ0sEKGK
         GAX7pp98YgnWvRUIZ54mDWkD/VqE4HJVGqdL6/QtRaTtQE+s9JlQKiVwKZcwrUNwxA8F
         9rBqPrm3Un5fCd3fjQu7P6dFvraFWwa93In7nWI+oM9eIkcW65eYcr8pfLijTM5bgcrn
         D1Zk9+g69uLnG4ghkjx6wMVOw0oTz613VKn47HUSn5485+VcMSy9uKgDxyvVCKKU/L3y
         4U9g==
X-Gm-Message-State: APjAAAWQW2zpHLY13VXTcRq9D1qTgAwoH+Mp5RZlmwOej8utThwUTANS
        bUYJ5QY5svcFI9HUzVf2yznbAXRqnm8=
X-Google-Smtp-Source: APXvYqyzSwOf9ulp+VcRGyQGk75217cYZCY8BQEqTeeL+igNJqqoq+w/GWYsQOC6EJsAay7hz5+gsA==
X-Received: by 2002:a9d:3e87:: with SMTP id b7mr6460658otc.157.1560874290988;
        Tue, 18 Jun 2019 09:11:30 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id j5sm6067846oih.52.2019.06.18.09.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:11:30 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id z23so15569175ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:11:29 -0700 (PDT)
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr3086182oto.196.1560874289249;
 Tue, 18 Jun 2019 09:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190614214302.26043-1-enric.balletbo@collabora.com>
In-Reply-To: <20190614214302.26043-1-enric.balletbo@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 18 Jun 2019 10:11:17 -0600
X-Gmail-Original-Message-ID: <CAHX4x85bTwBhJACA52Er-viOYpS=DT_o1ZFh32XfV1ST+paaLg@mail.gmail.com>
Message-ID: <CAHX4x85bTwBhJACA52Er-viOYpS=DT_o1ZFh32XfV1ST+paaLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] platform/chrome: cros_ec_lpc: Merge cros_ec_lpc
 and cros_ec_lpc_reg
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric, this looks good to me. Thanks for cleaning this up!

On Fri, Jun 14, 2019 at 3:43 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros_ec_lpc_reg files are only used by the cros_ec_lpc core and
> there isn't logical separation between them. So, merge those files into
> the cros_ec_lpc also allowing us to drop the header file used for the
> interface between the two.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v5:
> - Introduced this patch to fix the include mess.
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/platform/chrome/Makefile          |   2 +-
>  drivers/platform/chrome/cros_ec_lpc.c     |  97 ++++++++++++++++++++-
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 101 ----------------------
>  drivers/platform/chrome/cros_ec_lpc_reg.h |  45 ----------
>  4 files changed, 97 insertions(+), 148 deletions(-)
>  delete mode 100644 drivers/platform/chrome/cros_ec_lpc_reg.c
>  delete mode 100644 drivers/platform/chrome/cros_ec_lpc_reg.h
>
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 1b2f1dcfcd5c..e2a250892404 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_CHROMEOS_TBMC)             += chromeos_tbmc.o
>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_RPMSG)            += cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
> -cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
> +cros_ec_lpcs-objs                      := cros_ec_lpc.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            += cros_ec_proto.o cros_ec_trace.o
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index c9c240fbe7c6..00a07c9337b7 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -23,7 +23,7 @@
>  #include <linux/printk.h>
>  #include <linux/suspend.h>
>
> -#include "cros_ec_lpc_reg.h"
> +#include "cros_ec_lpc_mec.h"
>
>  #define DRV_NAME "cros_ec_lpcs"
>  #define ACPI_DRV_NAME "GOOG0004"
> @@ -31,6 +31,101 @@
>  /* True if ACPI device is present */
>  static bool cros_ec_lpc_acpi_device_found;
>
> +static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> +{
> +       int sum = 0;
> +       int i;
> +
> +       for (i = 0; i < length; ++i) {
> +               dest[i] = inb(offset + i);
> +               sum += dest[i];
> +       }
> +
> +       /* Return checksum of all bytes read */
> +       return sum;
> +}
> +
> +static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> +{
> +       int sum = 0;
> +       int i;
> +
> +       for (i = 0; i < length; ++i) {
> +               outb(msg[i], offset + i);
> +               sum += msg[i];
> +       }
> +
> +       /* Return checksum of all bytes written */
> +       return sum;
> +}
> +
> +#ifdef CONFIG_CROS_EC_LPC_MEC
> +
> +static u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length,
> +                                u8 *dest)
> +{
> +       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> +
> +       if (in_range < 0)
> +               return 0;
> +
> +       return in_range ?
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> +                                        offset - EC_HOST_CMD_REGION0,
> +                                        length, dest) :
> +               lpc_read_bytes(offset, length, dest);
> +}
> +
> +static u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
> +                                 u8 *msg)
> +{
> +       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> +
> +       if (in_range < 0)
> +               return 0;
> +
> +       return in_range ?
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> +                                        offset - EC_HOST_CMD_REGION0,
> +                                        length, msg) :
> +               lpc_write_bytes(offset, length, msg);
> +}
> +
> +static void cros_ec_lpc_reg_init(void)
> +{
> +       cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
> +                            EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
> +}
> +
> +static void cros_ec_lpc_reg_destroy(void)
> +{
> +       cros_ec_lpc_mec_destroy();
> +}
> +
> +#else /* CONFIG_CROS_EC_LPC_MEC */
> +
> +static u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length,
> +                                u8 *dest)
> +{
> +       return lpc_read_bytes(offset, length, dest);
> +}
> +
> +static u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
> +                                 u8 *msg)
> +{
> +       return lpc_write_bytes(offset, length, msg);
> +}
> +
> +static void cros_ec_lpc_reg_init(void)
> +{
> +}
> +
> +static void cros_ec_lpc_reg_destroy(void)
> +{
> +}
> +
> +#endif /* CONFIG_CROS_EC_LPC_MEC */
> +
>  static int ec_response_timed_out(void)
>  {
>         unsigned long one_second = jiffies + HZ;
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> deleted file mode 100644
> index 0f5cd0ac8b49..000000000000
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// LPC interface for ChromeOS Embedded Controller
> -//
> -// Copyright (C) 2016 Google, Inc
> -
> -#include <linux/io.h>
> -#include <linux/mfd/cros_ec.h>
> -#include <linux/mfd/cros_ec_commands.h>
> -
> -#include "cros_ec_lpc_mec.h"
> -
> -static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> -{
> -       int i;
> -       int sum = 0;
> -
> -       for (i = 0; i < length; ++i) {
> -               dest[i] = inb(offset + i);
> -               sum += dest[i];
> -       }
> -
> -       /* Return checksum of all bytes read */
> -       return sum;
> -}
> -
> -static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> -{
> -       int i;
> -       int sum = 0;
> -
> -       for (i = 0; i < length; ++i) {
> -               outb(msg[i], offset + i);
> -               sum += msg[i];
> -       }
> -
> -       /* Return checksum of all bytes written */
> -       return sum;
> -}
> -
> -#ifdef CONFIG_CROS_EC_LPC_MEC
> -
> -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> -{
> -       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> -
> -       if (in_range < 0)
> -               return 0;
> -
> -       return in_range ?
> -               cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> -                                        offset - EC_HOST_CMD_REGION0,
> -                                        length, dest) :
> -               lpc_read_bytes(offset, length, dest);
> -}
> -
> -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> -{
> -       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> -
> -       if (in_range < 0)
> -               return 0;
> -
> -       return in_range ?
> -               cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> -                                        offset - EC_HOST_CMD_REGION0,
> -                                        length, msg) :
> -               lpc_write_bytes(offset, length, msg);
> -}
> -
> -void cros_ec_lpc_reg_init(void)
> -{
> -       cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
> -                            EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
> -}
> -
> -void cros_ec_lpc_reg_destroy(void)
> -{
> -       cros_ec_lpc_mec_destroy();
> -}
> -
> -#else /* CONFIG_CROS_EC_LPC_MEC */
> -
> -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> -{
> -       return lpc_read_bytes(offset, length, dest);
> -}
> -
> -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> -{
> -       return lpc_write_bytes(offset, length, msg);
> -}
> -
> -void cros_ec_lpc_reg_init(void)
> -{
> -}
> -
> -void cros_ec_lpc_reg_destroy(void)
> -{
> -}
> -
> -#endif /* CONFIG_CROS_EC_LPC_MEC */
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
> deleted file mode 100644
> index 416fd2572182..000000000000
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.h
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * LPC interface for ChromeOS Embedded Controller
> - *
> - * Copyright (C) 2016 Google, Inc
> - */
> -
> -#ifndef __CROS_EC_LPC_REG_H
> -#define __CROS_EC_LPC_REG_H
> -
> -/**
> - * cros_ec_lpc_read_bytes - Read bytes from a given LPC-mapped address.
> - * Returns 8-bit checksum of all bytes read.
> - *
> - * @offset: Base read address
> - * @length: Number of bytes to read
> - * @dest: Destination buffer
> - */
> -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest);
> -
> -/**
> - * cros_ec_lpc_write_bytes - Write bytes to a given LPC-mapped address.
> - * Returns 8-bit checksum of all bytes written.
> - *
> - * @offset: Base write address
> - * @length: Number of bytes to write
> - * @msg: Write data buffer
> - */
> -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg);
> -
> -/**
> - * cros_ec_lpc_reg_init
> - *
> - * Initialize register I/O.
> - */
> -void cros_ec_lpc_reg_init(void);
> -
> -/**
> - * cros_ec_lpc_reg_destroy
> - *
> - * Cleanup reg I/O.
> - */
> -void cros_ec_lpc_reg_destroy(void);
> -
> -#endif /* __CROS_EC_LPC_REG_H */

Reviewed-by: Nick Crews <ncrews@chromium.org>

> --
> 2.20.1
>
