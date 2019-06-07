Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80775208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfFGXoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:44:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfFGXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:44:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DA1B6283DA3
Message-ID: <9f252e515c488544a4d7d3eee996f51f356c1766.camel@collabora.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_lpc: Choose Microchip EC at
 runtime
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
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
Date:   Fri, 07 Jun 2019 20:43:55 -0300
In-Reply-To: <CAFqH_52RMQLr_JW7Txm_WgLcZJkreQozx20j5TmESUMcGTUgtA@mail.gmail.com>
References: <20190607102710.23800-1-enric.balletbo@collabora.com>
         <decdbdf5285d76b4dab5b8f337023631a96ffc15.camel@collabora.com>
         <CAHX4x84G-f=HabyWCqAGOEBZdBgobW0BTB0iUbZcXYxBh3XcaQ@mail.gmail.com>
         <CABXOdTdGYmGnrmzRbUPX3cwXg=m=aX3cXXEk=OEphA5_GKKvJQ@mail.gmail.com>
         <CAFqH_52RMQLr_JW7Txm_WgLcZJkreQozx20j5TmESUMcGTUgtA@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Fri, 2019-06-07 at 22:51 +0200, Enric Balletbo Serra wrote:
> Hi,
> 
> Missatge de Guenter Roeck <groeck@google.com> del dia dv., 7 de juny
> 2019 a les 22:11:
> > On Fri, Jun 7, 2019 at 12:27 PM Nick Crews <ncrews@chromium.org> wrote:
> > > Hi!
> > > 
> > > On Fri, Jun 7, 2019 at 12:03 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
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
> 

I see.

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

Thanks for the explanations, it's clear now!

The change looks good.

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks,
Eze

