Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C97C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A50B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHwL4+o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFMWdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:33:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37705 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFMWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:33:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so569583oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skAyl8MJx5v5fwtxkk7putdWLb1p9QjEOVKS34d+a0k=;
        b=QHwL4+o6bnf/48OrfHhAXARH6Df/eLYASxhzONsJOarERl9xPskVexAqzFeHc8qXl8
         R9esfd4nbvJLOGq8i1EjAqVSfW0DvRQrlUj9EKOK7RQPCYASWsYlmWc3tu/kFKbjds91
         i/FKraOGtJ7Sr4cXt2VfhWbTSI7CAjTLdO+HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skAyl8MJx5v5fwtxkk7putdWLb1p9QjEOVKS34d+a0k=;
        b=SAyOffBUglOktfJ2a/K+oQTKb8izdr6fvvmdOTVT/Vlsd3I3qD/f6wxhw7ZEHkBlM8
         kNCLtfF0nfH+uGVGrlnumxkZOcSOoCLOq3vpLJbd8HDK4/1Lhbq2ly3eqisP1x8GkTqd
         BNdxFf3eCELlWb3QHdaNc4kNqriqt/MFimnKHWDsrNdc7E7XCdH270TUQz8oJ2qkn2fI
         snCxKWN5ciHy8l43oAqmGYzkd0gfzRaa2Ovm7Ync5bj5w4diG9EX2AZ8eD/2gBHvqhug
         DsQwNJwQ8cGVN3Aa1UV9zeCXtZHatSKyFUylq+xy9QxBCvgRzv7RdSLKjAhCHHkZ6dXZ
         TAUQ==
X-Gm-Message-State: APjAAAWzsOW5Ylp4Ff8vdFiuQQcPcCgAKgtG1WtKOrxPRuzJ1UCd0HaS
        82WtMDLzo5uY2ykZawPuMTtLFBx2mYQ=
X-Google-Smtp-Source: APXvYqzaKphk1pPanaJEVqNa5j/GtH22nsvjkBc34BqkEGN5Nq2phO9/Fh1Go32TVFs8ssyaxQqOfw==
X-Received: by 2002:aca:aad3:: with SMTP id t202mr4616818oie.158.1560465179905;
        Thu, 13 Jun 2019 15:32:59 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id t6sm497615otk.36.2019.06.13.15.32.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 15:32:58 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s184so542928oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:32:57 -0700 (PDT)
X-Received: by 2002:aca:ef42:: with SMTP id n63mr4575687oih.177.1560465177210;
 Thu, 13 Jun 2019 15:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190612203017.9014-1-enric.balletbo@collabora.com>
In-Reply-To: <20190612203017.9014-1-enric.balletbo@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 13 Jun 2019 16:32:45 -0600
X-Gmail-Original-Message-ID: <CAHX4x850fiK0vbjH_SG6nHjXPi1+-bX+XOFPgNz4bULLVj6TnA@mail.gmail.com>
Message-ID: <CAHX4x850fiK0vbjH_SG6nHjXPi1+-bX+XOFPgNz4bULLVj6TnA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_lpc: Choose Microchip EC at runtime
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the changes Enric! I had just a few more nits.

On Wed, Jun 12, 2019 at 2:30 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> On many boards, communication between the kernel and the Embedded
> Controller happens over an LPC bus. In these cases, the kernel config
> CONFIG_CROS_EC_LPC is enabled. Some of these LPC boards contain a
> Microchip Embedded Controller (MEC) that is different from the regular
> EC. On these devices, the same LPC bus is used, but the protocol is
> a little different. In these cases, the CONFIG_CROS_EC_LPC_MEC kernel
> config is enabled. Currently, the kernel decides at compile-time whether
> or not to use the MEC variant, and, when that kernel option is selected
> it breaks the other boards. We would like a kind of runtime detection to
> avoid this.
>
> This patch adds that detection mechanism by probing the protocol at
> runtime, first we assume that a MEC variant is connected, and if the
> protocol fails it fallbacks to the regular EC. This adds a bit of
> overload because we try to read twice on those LPC boards that doesn't
> contain a MEC variant, but is a better solution than having to select the
> EC variant at compile-time.
>
> While here also fix the alignment in Kconfig file for this config option
> replacing the spaces by tabs.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> Tested-by: Nick Crews <ncrews@chromium.org>
> ---
> Hi,
>
> This is another attempt to solve the issue to be able to select at
> runtime the CrOS MEC variant. My first thought was check for a device
> ID,
> the MEC1322 has a register that contains the device ID, however I am not
> sure if we can read that register from the host without modifying the
> firmware. Also, I am not sure if the MEC1322 is the only device used
> that supports that LPC protocol variant, so I ended with a more easy
> solution, check if the protocol fails or not. Some background on this
> issue can be found [1] and [2]
>
> The patch has been tested on:
>  - Acer Chromebook R11 (Cyan - MEC variant)
>  - Pixel Chromebook 2015 (Samus - non-MEC variant)
>  - Dell Chromebook 11 (Wolf - non-MEC variant)
>  - Toshiba Chromebook (Leon - non-MEC variant)
>
> Best regards,
>  Enric
>
> [1] https://bugs.chromium.org/p/chromium/issues/detail?id=932626
> [2] https://chromium-review.googlesource.com/c/chromiumos/overlays/chromiumos-overlay/+/1474254
>
> Changes in v3:
> - Kconfig: Split across multiple lines to keep it under 80 characters.
> - Improve kernel-doc as suggested by Nick Crews.
> - Convert msg in write function to const.
> - Add rb and tb tags.
>
> Changes in v2:
> - Remove global bool to indicate the kind of variant as suggested by Ezequiel.
> - Create an internal operations struct to allow different variants.
>
>  drivers/platform/chrome/Kconfig           | 29 +++------
>  drivers/platform/chrome/Makefile          |  2 +-
>  drivers/platform/chrome/cros_ec_lpc.c     | 77 ++++++++++++++++-------
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 38 +++--------
>  drivers/platform/chrome/cros_ec_lpc_reg.h | 17 ++++-
>  drivers/platform/chrome/wilco_ec/Kconfig  |  2 +-
>  6 files changed, 89 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 2826f7136f65..453e69733842 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -83,28 +83,17 @@ config CROS_EC_SPI
>           'pre-amble' bytes before the response actually starts.
>
>  config CROS_EC_LPC
> -        tristate "ChromeOS Embedded Controller (LPC)"
> -        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> -        help
> -          If you say Y here, you get support for talking to the ChromeOS EC
> -          over an LPC bus. This uses a simple byte-level protocol with a
> -          checksum. This is used for userspace access only. The kernel
> -          typically has its own communication methods.
> -
> -          To compile this driver as a module, choose M here: the
> -          module will be called cros_ec_lpc.
> -
> -config CROS_EC_LPC_MEC
> -       bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> -       depends on CROS_EC_LPC
> -       default n
> +       tristate "ChromeOS Embedded Controller (LPC)"
> +       depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
>         help
> -         If you say Y here, a variant LPC protocol for the Microchip EC
> -         will be used. Note that this variant is not backward compatible
> -         with non-Microchip ECs.
> +         If you say Y here, you get support for talking to the ChromeOS EC
> +         over an LPC bus, including the LPC Microchip EC (MEC) variant.
> +         This uses a simple byte-level protocol with a checksum. This is
> +         used for userspace access only. The kernel typically has its own
> +         communication methods.
>
> -         If you have a ChromeOS Embedded Controller Microchip EC variant
> -         choose Y here.
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_lpcs.
>
>  config CROS_EC_PROTO
>          bool
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 1b2f1dcfcd5c..da9aa08d9fa6 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_CROS_EC_I2C)             += cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_RPMSG)            += cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
> -cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
> +cros_ec_lpcs-objs                      += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            += cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   += cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index c9c240fbe7c6..579eb4b3629a 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -28,6 +28,23 @@
>  #define DRV_NAME "cros_ec_lpcs"
>  #define ACPI_DRV_NAME "GOOG0004"
>
> +/**
> + * struct lpc_driver_ops - LPC driver operations
> + * @read: Copy length bytes from EC address offset into buffer dest. Returns
> + *        the 8-bit checksum of all bytes read.
> + * @write: Copy length bytes from buffer msg into EC address offset. Returns
> + *         the 8-bit checksum of all bytes written.
> + */
> +struct lpc_driver_ops {
> +       u8 (*read)(unsigned int offset, unsigned int length, u8 *dest);
> +       u8 (*write)(unsigned int offset, unsigned int length, const u8 *msg);
> +};
> +
> +static struct lpc_driver_ops cros_ec_lpc_ops = {
> +       .read   = cros_ec_lpc_mec_read_bytes,
> +       .write  = cros_ec_lpc_mec_write_bytes,
> +};
> +
>  /* True if ACPI device is present */
>  static bool cros_ec_lpc_acpi_device_found;
>
> @@ -38,7 +55,7 @@ static int ec_response_timed_out(void)
>
>         usleep_range(200, 300);
>         do {
> -               if (!(cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_CMD, 1, &data) &
> +               if (!(cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_CMD, 1, &data) &
>                     EC_LPC_STATUS_BUSY_MASK))
>                         return 0;
>                 usleep_range(100, 200);
> @@ -58,11 +75,11 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
>         ret = cros_ec_prepare_tx(ec, msg);
>
>         /* Write buffer */
> -       cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
> +       cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
>
>         /* Here we go */
>         sum = EC_COMMAND_PROTOCOL_3;
> -       cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> +       cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
>
>         if (ec_response_timed_out()) {
>                 dev_warn(ec->dev, "EC responsed timed out\n");
> @@ -71,15 +88,15 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
>         }
>
>         /* Check result */
> -       msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +       msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
>         ret = cros_ec_check_result(ec, msg);
>         if (ret)
>                 goto done;
>
>         /* Read back response */
>         dout = (u8 *)&response;
> -       sum = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
> -                                    dout);
> +       sum = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
> +                                  dout);
>
>         msg->result = response.result;
>
> @@ -92,9 +109,9 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
>         }
>
>         /* Read response and process checksum */
> -       sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET +
> -                                     sizeof(response), response.data_len,
> -                                     msg->data);
> +       sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET +
> +                                   sizeof(response), response.data_len,
> +                                   msg->data);
>
>         if (sum) {
>                 dev_err(ec->dev,
> @@ -134,17 +151,17 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
>         sum = msg->command + args.flags + args.command_version + args.data_size;
>
>         /* Copy data and update checksum */
> -       sum += cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
> -                                      msg->data);
> +       sum += cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
> +                                    msg->data);
>
>         /* Finalize checksum and write args */
>         args.checksum = sum;
> -       cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> -                               (u8 *)&args);
> +       cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> +                             (u8 *)&args);
>
>         /* Here we go */
>         sum = msg->command;
> -       cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> +       cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
>
>         if (ec_response_timed_out()) {
>                 dev_warn(ec->dev, "EC responsed timed out\n");
> @@ -153,14 +170,13 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
>         }
>
>         /* Check result */
> -       msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +       msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
>         ret = cros_ec_check_result(ec, msg);
>         if (ret)
>                 goto done;
>
>         /* Read back args */
> -       cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> -                              (u8 *)&args);
> +       cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_ARGS, sizeof(args), (u8 *)&args);
>
>         if (args.data_size > msg->insize) {
>                 dev_err(ec->dev,
> @@ -174,8 +190,8 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
>         sum = msg->command + args.flags + args.command_version + args.data_size;
>
>         /* Read response and update checksum */
> -       sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PARAM, args.data_size,
> -                                     msg->data);
> +       sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
> +                                   msg->data);
>
>         /* Verify checksum */
>         if (args.checksum != sum) {
> @@ -205,13 +221,13 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
>
>         /* fixed length */
>         if (bytes) {
> -               cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
> +               cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
>                 return bytes;
>         }
>
>         /* string */
>         for (; i < EC_MEMMAP_SIZE; i++, s++) {
> -               cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + i, 1, s);
> +               cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + i, 1, s);
>                 cnt++;
>                 if (!*s)
>                         break;
> @@ -248,10 +264,23 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>                 return -EBUSY;
>         }
>
> -       cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> +       /*
> +        * Read the mapped ID twice, the first one is assuming the
> +        * EC is a Microchip Embedded Controller (MEC) variant, if the
> +        * protocol fails, fallback to the non MEC variant and try to
> +        * read again the ID.
> +        */
> +       cros_ec_lpc_mec_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>         if (buf[0] != 'E' || buf[1] != 'C') {
> -               dev_err(dev, "EC ID not detected\n");
> -               return -ENODEV;
> +               cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2,
> +                                      buf);
> +               if (buf[0] != 'E' || buf[1] != 'C') {
> +                       dev_err(dev, "EC ID not detected\n");
> +                       return -ENODEV;
> +               }
> +               /* Re-assign read/write operations for the non MEC variant */
> +               cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
> +               cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;

nit: This is really splitting hairs, but I think I would prefer

cros_ec_lpc_ops.read(...)
if (fails) {
   cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
   cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
   cros_ec_lpc_ops.read(...)
  if (fails)
      really_fail();
}

This makes it more explicit that on the first test we are using the default
methods, and it makes it more explicit that after this, things should
continue to work. Feel free to ignore though.

>         }
>
>         if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> index 0f5cd0ac8b49..0876afe79746 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -9,7 +9,7 @@
>
>  #include "cros_ec_lpc_mec.h"

See below, I think you should add
#include "cros_ec_lpc_reg.h"
here so you get compiler errors if your function declarations and
definitions don't match (since they currently don't match and it compiles).

>
> -static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> +u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
>  {
>         int i;
>         int sum = 0;
> @@ -23,7 +23,7 @@ static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
>         return sum;
>  }
>
> -static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> +u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)

msg should be const here to match the declaration.

>  {
>         int i;
>         int sum = 0;
> @@ -37,9 +37,9 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
>         return sum;
>  }
>
> -#ifdef CONFIG_CROS_EC_LPC_MEC
>
> -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> +u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> +                             u8 *dest)
>  {
>         int in_range = cros_ec_lpc_mec_in_range(offset, length);
>
> @@ -50,10 +50,12 @@ u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
>                 cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
>                                          offset - EC_HOST_CMD_REGION0,
>                                          length, dest) :
> -               lpc_read_bytes(offset, length, dest);
> +               cros_ec_lpc_read_bytes(offset, length, dest);
> +
>  }
>
> -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> +u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> +                              u8 *msg)

msg should be const here to match the declaration.

>  {
>         int in_range = cros_ec_lpc_mec_in_range(offset, length);
>
> @@ -64,7 +66,7 @@ u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
>                 cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
>                                          offset - EC_HOST_CMD_REGION0,
>                                          length, msg) :

You will need to cast msg as (u8 *) to avoid compiler errors here.

> -               lpc_write_bytes(offset, length, msg);
> +               cros_ec_lpc_write_bytes(offset, length, msg);
>  }
>
>  void cros_ec_lpc_reg_init(void)
> @@ -77,25 +79,3 @@ void cros_ec_lpc_reg_destroy(void)
>  {
>         cros_ec_lpc_mec_destroy();
>  }
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
> index 416fd2572182..2ff89baec292 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.h
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
> @@ -26,7 +26,22 @@ u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest);
>   * @length: Number of bytes to write
>   * @msg: Write data buffer
>   */

Change these docstrings to be references, like the ones below?
Maybe merge the two docstrings below into one, as is done above?

> -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg);
> +u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
> +                          const u8 *msg);
> +
> +/*
> + * An instance of the read function of struct lpc_driver_ops, used for the
> + * MEC variant of LPC EC.
> + */
> +u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> +                             u8 *dest);
> +
> +/*
> + * An instance of the write function of struct lpc_driver_ops, used for the
> + * MEC variant of LPC EC.
> + */
> +u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> +                              const u8 *msg);
>
>  /**
>   * cros_ec_lpc_reg_init
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index fd29cbfd3d5d..c63ff2508409 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config WILCO_EC
>         tristate "ChromeOS Wilco Embedded Controller"
> -       depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
> +       depends on ACPI && X86 && CROS_EC_LPC
>         help
>           If you say Y here, you get support for talking to the ChromeOS
>           Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> --
> 2.20.1
>
