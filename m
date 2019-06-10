Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6561C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907602082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NP3GXWYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfFJRpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:45:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40518 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFJRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:45:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id x24so9129336otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxDqaOhWM/ors8MbWHT+pw/x85Ok4knvy2L5bYxMdfw=;
        b=NP3GXWYnejnP+Yn0712QNydjPIDa/rQWkC4oJyWNqX/GzvaE00zOYcG6P7ZEk+wDaD
         pPQx7eHs6c7XreUdlaaE9QT/eYZdTH3xB+yN6L0WeRHLd40tpStEt0KaY4UtvuzeMQi9
         W0McdauMHs57UIPfAOe19GV+nMDs5PlkgxD8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxDqaOhWM/ors8MbWHT+pw/x85Ok4knvy2L5bYxMdfw=;
        b=MzjPekMXvPt0AfKQt5HVw7zt1hVszlOeAwgy9h3/bK4R2Yo1WyxksERadzVwFyvNbM
         fc2tWRiomcZFF/9qi+oa5+bPo/EfIp0x5pUCR0NMJhUMkd8KGQ6fYOgT48VOFZFejETD
         2+BF8xiWHN9koQQDCrrG1/IQxdNxBZs8ZYtMc4Z9g6AUk4v9YM7TjwftFoLJcnRSmFdd
         2RXqTv2thYgucrYQrFFpV0LVjuAk6bC5E9PCsrVa9mdihB/eYl/jb9Do4ePhW47RpVCS
         3Arf9ZurcOxGIchR0mGUhSnyhKXY5IOY56B9AG/ICqpChobOB4JXeoalmaLYih+xFHeH
         zrQg==
X-Gm-Message-State: APjAAAXU+Ws4pMq5OGPtwPZxXpPXNaeghqc2Y3vMusMXRwtyB+fayfVs
        c7ejis477kRdsbmk9a3Ke6xWxSMByzA=
X-Google-Smtp-Source: APXvYqzqSfWatEnJbb7bveEmJZ53AM+b00172chRpYHqOa7DS+14k5CK5AizzN0PrgqCF8XYeYlf+A==
X-Received: by 2002:a9d:6499:: with SMTP id g25mr14939714otl.184.1560188722444;
        Mon, 10 Jun 2019 10:45:22 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id s63sm4177778oig.11.2019.06.10.10.45.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:45:20 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id u64so6889760oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:45:19 -0700 (PDT)
X-Received: by 2002:aca:330b:: with SMTP id z11mr12274073oiz.148.1560188718948;
 Mon, 10 Jun 2019 10:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190607102710.23800-1-enric.balletbo@collabora.com>
 <decdbdf5285d76b4dab5b8f337023631a96ffc15.camel@collabora.com>
 <CAHX4x84G-f=HabyWCqAGOEBZdBgobW0BTB0iUbZcXYxBh3XcaQ@mail.gmail.com>
 <CABXOdTdGYmGnrmzRbUPX3cwXg=m=aX3cXXEk=OEphA5_GKKvJQ@mail.gmail.com> <CAFqH_52RMQLr_JW7Txm_WgLcZJkreQozx20j5TmESUMcGTUgtA@mail.gmail.com>
In-Reply-To: <CAFqH_52RMQLr_JW7Txm_WgLcZJkreQozx20j5TmESUMcGTUgtA@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 10 Jun 2019 11:45:07 -0600
X-Gmail-Original-Message-ID: <CAHX4x86czx68HU=J=5L8F1WrGwWxQ+gNo2h3DdFeNJSnGu1fAA@mail.gmail.com>
Message-ID: <CAHX4x86czx68HU=J=5L8F1WrGwWxQ+gNo2h3DdFeNJSnGu1fAA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_lpc: Choose Microchip EC at runtime
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few nits below, and otherwise looks good to me!

On Fri, Jun 7, 2019 at 2:51 PM Enric Balletbo Serra <eballetbo@gmail.com> wrote:
>
> Hi,
>
> Missatge de Guenter Roeck <groeck@google.com> del dia dv., 7 de juny
> 2019 a les 22:11:
> >
> > On Fri, Jun 7, 2019 at 12:27 PM Nick Crews <ncrews@chromium.org> wrote:
> > >
> > > Hi!
> > >
> > > On Fri, Jun 7, 2019 at 12:03 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > >
> > > > On Fri, 2019-06-07 at 12:27 +0200, Enric Balletbo i Serra wrote:
> > > > > On many boards, communication between the kernel and the Embedded
> > > > > Controller happens over an LPC bus. In these cases, the kernel config
> > > > > CONFIG_CROS_EC_LPC is enabled. Some of these LPC boards contain a
> > > > > Microchip Embedded Controller (MEC) that is different from the regular
> > > > > EC. On these devices, the same LPC bus is used, but the protocol is
> > > > > a little different. In these cases, the CONFIG_CROS_EC_LPC_MEC kernel
> > > > > config is enabled. Currently, the kernel decides at compile-time whether
> > > > > or not to use the MEC variant, and, when that kernel option is selected
> > > > > it breaks the other boards. We would like a kind of runtime detection to
> > > > > avoid this.
> > > > >
> > > > > This patch adds that detection mechanism by probing the protocol at
> > > > > runtime, first we assume that a MEC variant is connected, and if the
> > > > > protocol fails it fallbacks to the regular EC. This adds a bit of
> > > > > overload because we try to read twice on those LPC boards that doesn't
> > > > > contain a MEC variant, but is a better solution than having to select the
> > > > > EC variant at compile-time.
> > > > >
> > > > > While here also fix the alignment in Kconfig file for this config option
> > > > > replacing the spaces by tabs.
> > > > >
> > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > ---
> > > > > Hi,
> > > > >
> > > > > This is the second attempt to solve the issue to be able to select at
> > > > > runtime the CrOS MEC variant. My first thought was check for a device
> > > > > ID,
> > > > > the MEC1322 has a register that contains the device ID, however I am not
> > > > > sure if we can read that register from the host without modifying the
> > > > > firmware. Also, I am not sure if the MEC1322 is the only device used
> > > > > that supports that LPC protocol variant, so I ended with a more easy
> > > > > solution, check if the protocol fails or not. Some background on this
> > > > > issue can be found [1] and [2]
> > > > >
> > > > > The patch has been tested on:
> > > > >  - Acer Chromebook R11 (Cyan - MEC variant)
> > > > >  - Pixel Chromebook 2015 (Samus - non-MEC variant)
> > > > >  - Dell Chromebook 11 (Wolf - non-MEC variant)
> > > > >  - Toshiba Chromebook (Leon - non-MEC variant)
> > > > >
> > > > > Nick, could you test the patch for Wilco?

It works, which makes sense, as Wilco hardcodes in using
the MEC variant.

Tested-by: Nick Crews <ncrews@chromium.org>

> > > > >
> > > > > Best regards,
> > > > >  Enric
> > > > >
> > > > > [1] https://bugs.chromium.org/p/chromium/issues/detail?id=932626
> > > > > [2] https://chromium-review.googlesource.com/c/chromiumos/overlays/chromiumos-overlay/+/1474254
> > > > >
> > > > > Changes in v2:
> > > > > - Remove global bool to indicate the kind of variant as suggested by Ezequiel.
> > > > > - Create an internal operations struct to allow different variants.
> > > > >
> > > > >  drivers/platform/chrome/Kconfig           | 29 +++------
> > > > >  drivers/platform/chrome/Makefile          |  3 +-
> > > > >  drivers/platform/chrome/cros_ec_lpc.c     | 76 ++++++++++++++++-------
> > > > >  drivers/platform/chrome/cros_ec_lpc_reg.c | 39 +++---------
> > > > >  drivers/platform/chrome/cros_ec_lpc_reg.h | 26 ++++++++
> > > > >  drivers/platform/chrome/wilco_ec/Kconfig  |  2 +-
> > > > >  6 files changed, 98 insertions(+), 77 deletions(-)
> > > > >
> > > > > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> > > > > index 2826f7136f65..453e69733842 100644
> > > > > --- a/drivers/platform/chrome/Kconfig
> > > > > +++ b/drivers/platform/chrome/Kconfig
> > > > > @@ -83,28 +83,17 @@ config CROS_EC_SPI
> > > > >         'pre-amble' bytes before the response actually starts.
> > > > >
> > > > >  config CROS_EC_LPC
> > > > > -        tristate "ChromeOS Embedded Controller (LPC)"
> > > > > -        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> > > > > -        help
> > > > > -          If you say Y here, you get support for talking to the ChromeOS EC
> > > > > -          over an LPC bus. This uses a simple byte-level protocol with a
> > > > > -          checksum. This is used for userspace access only. The kernel
> > > > > -          typically has its own communication methods.
> > > > > -
> > > > > -          To compile this driver as a module, choose M here: the
> > > > > -          module will be called cros_ec_lpc.
> > > > > -
> > > > > -config CROS_EC_LPC_MEC
> > > > > -     bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> > > > > -     depends on CROS_EC_LPC
> > > > > -     default n
> > > > > +     tristate "ChromeOS Embedded Controller (LPC)"
> > > > > +     depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> > > > >       help
> > > > > -       If you say Y here, a variant LPC protocol for the Microchip EC
> > > > > -       will be used. Note that this variant is not backward compatible
> > > > > -       with non-Microchip ECs.
> > > > > +       If you say Y here, you get support for talking to the ChromeOS EC
> > > > > +       over an LPC bus, including the LPC Microchip EC (MEC) variant.
> > > > > +       This uses a simple byte-level protocol with a checksum. This is
> > > > > +       used for userspace access only. The kernel typically has its own
> > > > > +       communication methods.
> > > > >
> > > > > -       If you have a ChromeOS Embedded Controller Microchip EC variant
> > > > > -       choose Y here.
> > > > > +       To compile this driver as a module, choose M here: the
> > > > > +       module will be called cros_ec_lpcs.
> > > > >
> > > > >  config CROS_EC_PROTO
> > > > >          bool
> > > > > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> > > > > index 1b2f1dcfcd5c..d6416411888f 100644
> > > > > --- a/drivers/platform/chrome/Makefile
> > > > > +++ b/drivers/platform/chrome/Makefile
> > > > > @@ -9,8 +9,7 @@ obj-$(CONFIG_CHROMEOS_TBMC)           += chromeos_tbmc.o
> > > > >  obj-$(CONFIG_CROS_EC_I2C)            += cros_ec_i2c.o
> > > > >  obj-$(CONFIG_CROS_EC_RPMSG)          += cros_ec_rpmsg.o
> > > > >  obj-$(CONFIG_CROS_EC_SPI)            += cros_ec_spi.o
> > > > > -cros_ec_lpcs-objs                    := cros_ec_lpc.o cros_ec_lpc_reg.o
> > > > > -cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)       += cros_ec_lpc_mec.o
> > > > > +cros_ec_lpcs-objs                    := cros_ec_lpc.o cros_ec_lpc_reg.o cros_ec_lpc_mec.o

To be consistent with the other parts of this file, this should
be split across multiple lines to keep it under 80 characters.
Also, this hunk did not apply cleanly to the chrome-platform/for-next branch.

> > > > >  obj-$(CONFIG_CROS_EC_LPC)            += cros_ec_lpcs.o
> > > > >  obj-$(CONFIG_CROS_EC_PROTO)          += cros_ec_proto.o cros_ec_trace.o
> > > > >  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT) += cros_kbd_led_backlight.o
> > > > > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > > > > index c9c240fbe7c6..91cb4dd34764 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > > > > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > > > > @@ -28,6 +28,22 @@
> > > > >  #define DRV_NAME "cros_ec_lpcs"
> > > > >  #define ACPI_DRV_NAME "GOOG0004"
> > > > >
> > > > > +/**
> > > > > + * struct lpc_ops - LPC driver methods
> > > > > + *
> > > > > + * @read: Read bytes from a given LPC-mapped address.
> > > > > + * @write: Write bytes to a given LPC-mapped address.

It would be great if you documented the API of these two functions better,
so someone doesn't have to chase down the API of the instances. Then
I would remove (or better, simplify and make them point here) the docstrings
of the instance functions so we don't have duplicates of docstrings.

> > > > > + */
> > > > > +struct lpc_ops {
> > > > > +     u8      (*read)(unsigned int offset, unsigned int length, u8 *dest);
> > > > > +     u8      (*write)(unsigned int offset, unsigned int length, u8 *msg);
> > > > > +};
> > > > > +
> > > > > +static struct lpc_ops cros_ec_lpc_ops = {
> > > > > +     .read   = cros_ec_lpc_mec_read_bytes,
> > > > > +     .write  = cros_ec_lpc_mec_write_bytes,
> > > > > +};
> > > > > +
> > > >
> > > > While this is better than a global boolean, it's still not
> > > > per-device.
> > > >
>
> Indeed
>
> > > > I guess it's not an issue given you typically (always?)
> > > > have one cros-ec device per platform.
> > > >
>
> I don't think is expected, at least now, we don't have a real use case with it.
>
> > > > However, I'm still wondering if it's not better to make it
> > > > per-device (as the bus is per-device?).
> > >
> > > Enric and I were discussing this. Up to this point, there has only been
> > > one EC device per platform, and I think this is a reasonable
> > > expectation to maintain. I'm adding Stefan Reinauer, the Chrome OS
> > > EC lead, for their thoughts. Stefan, we are discussing whether or not we
> > > need to support multiple communication protocols at the same time,
> > > for instance if a device had multiple ECs, each with a different protocol.
> > >
>
> My two cents to the discussion and the reason why I did not implement
> the per-device functionality:
> - Before this patch, we didn't have support per-device.
> - Make it per-device is not the purpose of this patch, the purpose is
> detect at run-time the protocol used.
> - Add support per-device needs more changes than the expected, which
> IMO are out of the scope of this patch.
> - We don't have a real use case and unlikely we will have in the
> future, so why worry now.

Ack.

>
> > > If we really wanted to support multiple ECs, there would be some other
> > > work to do besides this one fix, since the memory addresses that
> > > we write to are hardcoded into the drivers. In order to support
> > > multiple devices,
> > > not only would we need to make the xfer algorithms per-device, but would
> > > also need to make the memory addresses per-device. I would love
> > > some feedback on this, but my initial thought would be to add a
> > > "void *xfer_protocol_data" field to struct cros_ec_device, alongside
> > > the two existing
> > > int (*cmd_xfer)(struct cros_ec_device *ec, struct cros_ec_command *msg);
> > > int (*pkt_xfer)(struct cros_ec_device *ec, struct cros_ec_command *msg);
> > > fields. Then, each different protocol (lpc, i2c, spi, rpmsg, ishtp;
> > > some of these
> > > are only in the Chromium tree as of now) would be able to use this
> > > field as needed,
> > > for example to store the I2C address or the is_MEC flag for each device.
> > >
> >
> > I understand that the current implementation may be insufficient if
> > there is ever more than one EC in a given system. Maybe I am missing
> > something, but why even consider it right now, with no such system in
> > existence ? We would not even know if a more flexible implementation
> > actually works, since there would be no means to test it.
>
> Agree.
>
> Thanks,
>  Enric

Ack.

I was basing this "allow for multiple devices" paradigm from a past
suggestion from Dmitry. I applied this for the Wilco EC Event [1] and
Wilco EC Telemetry [2] drivers per Dmitry's suggestion, so in the future
we could use multiple EC devices. I agree that at this point it seems
a bit silly to plan that far ahead, but I was just trying to be consistent.
In future work that I do, I will now default to accommodating only one EC.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-next&id=f7b0bc5eafa44941ddf92df6f46dd82cbfacec3e
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-next&id=1210d1e6bad1e7ccccb19627b880a50d7c15dd51

>
> >
> > Thanks,
> > Guenter
> >
> > > Thanks,
> > > Nick
> > >
> > > >
> > > > >  /* True if ACPI device is present */
> > > > >  static bool cros_ec_lpc_acpi_device_found;
> > > > >
> > > > > @@ -38,7 +54,7 @@ static int ec_response_timed_out(void)
> > > > >
> > > > >       usleep_range(200, 300);
> > > > >       do {
> > > > > -             if (!(cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_CMD, 1, &data) &
> > > > > +             if (!(cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_CMD, 1, &data) &
> > > > >                   EC_LPC_STATUS_BUSY_MASK))
> > > > >                       return 0;
> > > > >               usleep_range(100, 200);
> > > > > @@ -58,11 +74,11 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
> > > > >       ret = cros_ec_prepare_tx(ec, msg);
> > > > >
> > > > >       /* Write buffer */
> > > > > -     cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
> > > > > +     cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
> > > > >
> > > > >       /* Here we go */
> > > > >       sum = EC_COMMAND_PROTOCOL_3;
> > > > > -     cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> > > > > +     cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> > > > >
> > > > >       if (ec_response_timed_out()) {
> > > > >               dev_warn(ec->dev, "EC responsed timed out\n");
> > > > > @@ -71,15 +87,15 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
> > > > >       }
> > > > >
> > > > >       /* Check result */
> > > > > -     msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> > > > > +     msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> > > > >       ret = cros_ec_check_result(ec, msg);
> > > > >       if (ret)
> > > > >               goto done;
> > > > >
> > > > >       /* Read back response */
> > > > >       dout = (u8 *)&response;
> > > > > -     sum = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
> > > > > -                                  dout);
> > > > > +     sum = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
> > > > > +                                dout);
> > > > >
> > > > >       msg->result = response.result;
> > > > >
> > > > > @@ -92,9 +108,9 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
> > > > >       }
> > > > >
> > > > >       /* Read response and process checksum */
> > > > > -     sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PACKET +
> > > > > -                                   sizeof(response), response.data_len,
> > > > > -                                   msg->data);
> > > > > +     sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET +
> > > > > +                                 sizeof(response), response.data_len,
> > > > > +                                 msg->data);
> > > > >
> > > > >       if (sum) {
> > > > >               dev_err(ec->dev,
> > > > > @@ -134,17 +150,17 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
> > > > >       sum = msg->command + args.flags + args.command_version + args.data_size;
> > > > >
> > > > >       /* Copy data and update checksum */
> > > > > -     sum += cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
> > > > > -                                    msg->data);
> > > > > +     sum += cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
> > > > > +                                  msg->data);
> > > > >
> > > > >       /* Finalize checksum and write args */
> > > > >       args.checksum = sum;
> > > > > -     cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> > > > > -                             (u8 *)&args);
> > > > > +     cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> > > > > +                           (u8 *)&args);
> > > > >
> > > > >       /* Here we go */
> > > > >       sum = msg->command;
> > > > > -     cros_ec_lpc_write_bytes(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> > > > > +     cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
> > > > >
> > > > >       if (ec_response_timed_out()) {
> > > > >               dev_warn(ec->dev, "EC responsed timed out\n");
> > > > > @@ -153,14 +169,13 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
> > > > >       }
> > > > >
> > > > >       /* Check result */
> > > > > -     msg->result = cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> > > > > +     msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> > > > >       ret = cros_ec_check_result(ec, msg);
> > > > >       if (ret)
> > > > >               goto done;
> > > > >
> > > > >       /* Read back args */
> > > > > -     cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
> > > > > -                            (u8 *)&args);
> > > > > +     cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_ARGS, sizeof(args), (u8 *)&args);
> > > > >
> > > > >       if (args.data_size > msg->insize) {
> > > > >               dev_err(ec->dev,
> > > > > @@ -174,8 +189,8 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
> > > > >       sum = msg->command + args.flags + args.command_version + args.data_size;
> > > > >
> > > > >       /* Read response and update checksum */
> > > > > -     sum += cros_ec_lpc_read_bytes(EC_LPC_ADDR_HOST_PARAM, args.data_size,
> > > > > -                                   msg->data);
> > > > > +     sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
> > > > > +                                 msg->data);
> > > > >
> > > > >       /* Verify checksum */
> > > > >       if (args.checksum != sum) {
> > > > > @@ -205,13 +220,13 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
> > > > >
> > > > >       /* fixed length */
> > > > >       if (bytes) {
> > > > > -             cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
> > > > > +             cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + offset, bytes, s);
> > > > >               return bytes;
> > > > >       }
> > > > >
> > > > >       /* string */
> > > > >       for (; i < EC_MEMMAP_SIZE; i++, s++) {
> > > > > -             cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + i, 1, s);
> > > > > +             cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + i, 1, s);
> > > > >               cnt++;
> > > > >               if (!*s)
> > > > >                       break;
> > > > > @@ -248,10 +263,23 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> > > > >               return -EBUSY;
> > > > >       }
> > > > >
> > > > > -     cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> > > > > +     /*
> > > > > +      * Read the mapped ID twice, the first one is assuming the
> > > > > +      * EC is a Microchip Embedded Controller (MEC) variant, if the
> > > > > +      * protocol fails, fallback to the non MEC variant and try to
> > > > > +      * read again the ID.
> > > > > +      */
> > > > > +     cros_ec_lpc_mec_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> > > > >       if (buf[0] != 'E' || buf[1] != 'C') {
> > > > > -             dev_err(dev, "EC ID not detected\n");
> > > > > -             return -ENODEV;
> > > > > +             cros_ec_lpc_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2,
> > > > > +                                    buf);
> > > > > +             if (buf[0] != 'E' || buf[1] != 'C') {
> > > > > +                     dev_err(dev, "EC ID not detected\n");
> > > > > +                     return -ENODEV;
> > > > > +             }
> > > > > +             /* Re-assign read/write operations for the non MEC variant */
> > > > > +             cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
> > > > > +             cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
> > > > >       }
> > > > >
> > > > >       if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> > > > > diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> > > > > index 0f5cd0ac8b49..389d3329616f 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> > > > > +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> > > > > @@ -9,7 +9,7 @@
> > > > >
> > > > >  #include "cros_ec_lpc_mec.h"
> > > > >
> > > > > -static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > > +u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > >  {
> > > > >       int i;
> > > > >       int sum = 0;
> > > > > @@ -23,7 +23,7 @@ static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > >       return sum;
> > > > >  }
> > > > >
> > > > > -static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > > +u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > >  {
> > > > >       int i;
> > > > >       int sum = 0;
> > > > > @@ -37,9 +37,8 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > >       return sum;
> > > > >  }
> > > > >
> > > > > -#ifdef CONFIG_CROS_EC_LPC_MEC
> > > > > -
> > > > > -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > > +u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> > > > > +                           u8 *dest)
> > > > >  {
> > > > >       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> > > > >
> > > > > @@ -50,10 +49,12 @@ u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > >               cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> > > > >                                        offset - EC_HOST_CMD_REGION0,
> > > > >                                        length, dest) :
> > > > > -             lpc_read_bytes(offset, length, dest);
> > > > > +             cros_ec_lpc_read_bytes(offset, length, dest);
> > > > > +
> > > > >  }
> > > > >
> > > > > -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > > +u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> > > > > +                            u8 *msg)
> > > > >  {
> > > > >       int in_range = cros_ec_lpc_mec_in_range(offset, length);
> > > > >
> > > > > @@ -64,7 +65,7 @@ u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > >               cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> > > > >                                        offset - EC_HOST_CMD_REGION0,
> > > > >                                        length, msg) :
> > > > > -             lpc_write_bytes(offset, length, msg);
> > > > > +             cros_ec_lpc_write_bytes(offset, length, msg);
> > > > >  }
> > > > >
> > > > >  void cros_ec_lpc_reg_init(void)
> > > > > @@ -77,25 +78,3 @@ void cros_ec_lpc_reg_destroy(void)
> > > > >  {
> > > > >       cros_ec_lpc_mec_destroy();
> > > > >  }
> > > > > -
> > > > > -#else /* CONFIG_CROS_EC_LPC_MEC */
> > > > > -
> > > > > -u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
> > > > > -{
> > > > > -     return lpc_read_bytes(offset, length, dest);
> > > > > -}
> > > > > -
> > > > > -u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
> > > > > -{
> > > > > -     return lpc_write_bytes(offset, length, msg);
> > > > > -}
> > > > > -
> > > > > -void cros_ec_lpc_reg_init(void)
> > > > > -{
> > > > > -}
> > > > > -
> > > > > -void cros_ec_lpc_reg_destroy(void)
> > > > > -{
> > > > > -}
> > > > > -
> > > > > -#endif /* CONFIG_CROS_EC_LPC_MEC */
> > > > > diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
> > > > > index 416fd2572182..e8d53fb8a2bc 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_lpc_reg.h
> > > > > +++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
> > > > > @@ -28,6 +28,32 @@ u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest);
> > > > >   */
> > > > >  u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg);

optional nit: msg could be const

> > > > >
> > > > > +/**
> > > > > + * cros_ec_lpc_mec_read_bytes() - Read bytes from a given LPC-mapped address.
> > > > > + * @offset: Base read address
> > > > > + * @length: Number of bytes to read
> > > > > + * @dest: Destination buffer
> > > > > + *
> > > > > + * This function is for the MEC (Microchip Embedded Controller) variant.
> > > > > + *
> > > > > + * Return: 8-bit checksum of all bytes read.
> > > > > + */
> > > > > +u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> > > > > +                           u8 *dest);
> > > > > +
> > > > > +/**
> > > > > + * cros_ec_lpc_mec_write_bytes - Write bytes to a given LPC-mapped address.
> > > > > + * @offset: Base write address
> > > > > + * @length: Number of bytes to write
> > > > > + * @msg: Write data buffer
> > > > > + *
> > > > > + * This function is for the MEC (Microchip Embedded Controller) variant.
> > > > > + *
> > > > > + * Return: 8-bit checksum of all bytes written.
> > > > > + */
> > > > > +u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> > > > > +                            u8 *msg);

optional nit: msg could be const

> > > > > +
> > > > >  /**
> > > > >   * cros_ec_lpc_reg_init
> > > > >   *
> > > > > diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> > > > > index fd29cbfd3d5d..c63ff2508409 100644
> > > > > --- a/drivers/platform/chrome/wilco_ec/Kconfig
> > > > > +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> > > > > @@ -1,7 +1,7 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only

This SPDX line isn't in the chrome-platform/for-next branch so this
doesn't apply cleanly. I think adding the SPDX would be good though,
just make that part of this patch?

> > > > >  config WILCO_EC
> > > > >       tristate "ChromeOS Wilco Embedded Controller"
> > > > > -     depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
> > > > > +     depends on ACPI && X86 && CROS_EC_LPC
> > > > >       help
> > > > >         If you say Y here, you get support for talking to the ChromeOS
> > > > >         Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > >
> > > >
> > > >

After these tweaks, looks good!

Reviewed-by: Nick Crews <ncrews@chomium.org>
