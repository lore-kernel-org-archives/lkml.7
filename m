Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E2C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1202067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBndJnDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgAIJaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:30:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35850 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgAIJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:30:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id i13so498551qtr.3;
        Thu, 09 Jan 2020 01:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0oVp+X6L4o/RiqeObpubUSElARUfM4pJhEjA1HRJT0=;
        b=HBndJnDRcD9V7TyypPPx5mP8DTEZYu7oC7jv4J0IJGHUoIGbaqFpjfcvYJADL1MqWx
         DJXlfgT5Z0K3PG+8SPzKMd9Wsg1JesyUb0cP6ex3Fw7Dt7evp/tSGaxpzLykpwB6idaL
         gNKgJAz/+DGCXbIniwFABfv6WbKlgK5wPqrGE+G8Oq1WKuwpnV/U/wFZA9jZZM7AiyG6
         19utqfnS0pDImHWrxlKa+HzvNEba50rdHS/OgmH4zszhBHBcAXJJ2a5P9Oa0wxO+SE20
         u2qSne/vRiMZYemABMJjIPBn1BYotwl6bB/CJXy47riLp7rmSjuSm54BDVFZjEAtkq2M
         F6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0oVp+X6L4o/RiqeObpubUSElARUfM4pJhEjA1HRJT0=;
        b=m/0jlWqwn14pdkqGE3stcX6V6+aBzD1tR7S9D1n/uKJ7fe1EvSQHMgdH/TcPx3PCCP
         5+owWtHoO7DPP9hHzDWOHSo0rVJgimRgJqSx6Cn6OsbGkvkJh/tk9vzf90z0LAR9cpAZ
         kNyJ9Pgg5Kj4dFsL6ldwNVAzt7h5WUZw726WySEAjG3kddZHlR/4IBFCFlq5GySho1d4
         bakb9FkUJfW4geTWYPrdZifqBeIrPTao8f4I9tB3vlKVqyxzaLMEJjvzxanGDw+AUw46
         ym6TtrTmGcpjJaXpRXXy7K5GDsIEZbzecutrHTXJGj1XoYiZzAAvrypVdaUnhKfWX8Yt
         omFg==
X-Gm-Message-State: APjAAAVEWrZZP3olX2dHscW152j9AD6LPvPnr2+kP01jf1ujy8mEQcAw
        64QDX5psz3gvrqadpBSgf4kafyiB95yJ91FOI4uB4175
X-Google-Smtp-Source: APXvYqw2HbfZJ2MWs8eISqgmhqC/ipxEJVSaHitA2D2xUFZ1LEteeT5iAtE1feoBPkkQUPx10+kJwNpMkOhvG6KZcIU=
X-Received: by 2002:ac8:108:: with SMTP id e8mr7393629qtg.101.1578562210248;
 Thu, 09 Jan 2020 01:30:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578235515.git.gupt21@gmail.com> <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com>
In-Reply-To: <20200106193500.GC754821@kroah.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 9 Jan 2020 14:59:59 +0530
Message-ID: <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver emulating
 serial port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg for the review, please find my replies inline.

On Tue, Jan 7, 2020 at 1:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 06, 2020 at 12:51:54PM +0530, Rishi Gupta wrote:
> > This commit adds driver that can create virtual tty devices.
> > This is useful in software testing and gps data simulation.
> >
> > Devices are created either through DT or by writing to device
> > node. Serial port events like frame, parity, overflow errors
> > are also emulated by writing to sysfs files.
> >
> > Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> > ---
> >  MAINTAINERS          |    8 +
> >  drivers/tty/Kconfig  |   16 +
> >  drivers/tty/Makefile |    1 +
> >  drivers/tty/ttyvs.c  | 2429 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 2454 insertions(+)
> >  create mode 100644 drivers/tty/ttyvs.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c6b893f..350fb36 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16794,6 +16794,14 @@ F:   include/uapi/linux/serial_core.h
> >  F:   include/uapi/linux/serial.h
> >  F:   include/uapi/linux/tty.h
> >
> > +TTYVS VIRTUAL SERIAL DRIVER
> > +M:   Rishi Gupta <gupt21@gmail.com>
> > +L:   linux-serial@vger.kernel.org
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/serial/ttyvs.yaml
> > +F:   drivers/tty/ttyvs.c
> > +
> >  TUA9001 MEDIA DRIVER
> >  M:   Antti Palosaari <crope@iki.fi>
> >  L:   linux-media@vger.kernel.org
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index a312cb3..1e843f9 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -477,4 +477,20 @@ config LDISC_AUTOLOAD
> >         dev.tty.ldisc_autoload sysctl, this configuration option will
> >         only set the default value of this functionality.
> >
> > +config TTY_VS
> > +     tristate "Virtual serial null modem emulation"
> > +     help
> > +       This driver creates virtual serial port devices (loopback and
> > +       null modem style) that can be used in the same way as real serial
> > +       port devices. Parity, frame, overflow, ring indicator, baudrate
> > +       mismatch, hardware and software flow control can be emulated.
> > +
> > +       For information about how to create/delete devices, exchange data
> > +       and emulate events, please read:
> > +       <file:Documentation/devicetree/bindings/serial/ttyvs.yaml>.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called ttyvs.ko. If you want to compile this driver
> > +       into the kernel, say Y here.
> > +
> >  endif # TTY
> > diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> > index 020b1cd..c5f2b4c 100644
> > --- a/drivers/tty/Makefile
> > +++ b/drivers/tty/Makefile
> > @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
> >  obj-$(CONFIG_GOLDFISH_TTY)   += goldfish.o
> >  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
> >  obj-$(CONFIG_VCC)            += vcc.o
> > +obj-$(CONFIG_TTY_VS) += ttyvs.o
> >
> >  obj-y += ipwireless/
> > diff --git a/drivers/tty/ttyvs.c b/drivers/tty/ttyvs.c
> > new file mode 100644
> > index 0000000..894346c
> > --- /dev/null
> > +++ b/drivers/tty/ttyvs.c
> > @@ -0,0 +1,2429 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Serial port null modem emulation driver
> > + *
> > + * Copyright (c) 2020, Rishi Gupta <gupt21@gmail.com>
> > + */
> > +
> > +/*
> > + * Virtual multi-port serial card:
> > + *
> > + * This driver implements a virtual multi-port serial card in such a
> > + * way that the virtual card can have 0 to N number of virtual serial
> > + * ports (tty devices). The devices created in this card are used in
> > + * exactly the same way as the real tty devices using standard termios
> > + * and Linux/Posix APIs.
> > + *
> > + *    /dev/ttyvs_card
> > + *  +~~~~~~~~~~~~~~~~~~~~~+
> > + *  |   +-------------+   |
> > + *  |   | /dev/ttyvs0 |   |
> > + *  |   +-------------+   |
> > + *  |   .                 |
> > + *  |   .                 |
> > + *  |   +-------------+   |
> > + *  |   | /dev/ttyvsN |   |
> > + *  |   +-------------+   |
> > + *  +~~~~~~~~~~~~~~~~~~~~~+
> > + *
> > + * DT bindings: Documentation/devicetree/bindings/serial/ttyvs.yaml
> > + *
> > + * Example udev rules:
> > + * 1. Permissions on card's node to create/destroy and query information:
> > + *    ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"
> > + *
> > + * 2. Permission on tty device nodes and event sysfs files (%S is sysfs
> > + *    mount point and %p is DEVPATH /devices/virtual/tty/ttyvsNUM):
> > + *    ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*",\
> > + *    MODE="0666", RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/slab.h>
> > +#include <linux/wait.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_driver.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/serial.h>
> > +#include <linux/sched.h>
> > +#include <linux/version.h>
> > +#include <linux/mutex.h>
> > +#include <linux/device.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +
> > +/* Pin out configurations definitions */
> > +#define VS_CON_CTS    0x0001
> > +#define VS_CON_DCD    0x0002
> > +#define VS_CON_DSR    0x0004
> > +#define VS_CON_RI     0x0008
> > +
> > +/* Modem control register definitions */
> > +#define VS_MCR_DTR    0x0001
> > +#define VS_MCR_RTS    0x0002
> > +#define VS_MCR_LOOP   0x0004
> > +
> > +/* Modem status register definitions */
> > +#define VS_MSR_CTS    0x0008
> > +#define VS_MSR_DCD    0x0010
> > +#define VS_MSR_RI     0x0020
> > +#define VS_MSR_DSR    0x0040
> > +
> > +/* UART frame structure definitions */
> > +#define VS_CRTSCTS       0x0001
> > +#define VS_XON           0x0002
> > +#define VS_NONE          0X0004
> > +#define VS_DATA_5        0X0008
> > +#define VS_DATA_6        0X0010
> > +#define VS_DATA_7        0X0020
> > +#define VS_DATA_8        0X0040
>
> Why the "X"?
Sorry I did not understand, do you mean why VS_XON.
>
>
> > +#define VS_PARITY_NONE   0x0080
> > +#define VS_PARITY_ODD    0x0100
> > +#define VS_PARITY_EVEN   0x0200
> > +#define VS_PARITY_MARK   0x0400
> > +#define VS_PARITY_SPACE  0x0800
> > +#define VS_STOP_1        0x1000
> > +#define VS_STOP_2        0x2000
> > +
> > +/* Constants for the device type (odevtyp) */
> > +#define VS_SNM 0x0001
> > +#define VS_CNM 0x0002
> > +#define VS_SLB 0x0003
> > +#define VS_CLB 0x0004
> > +
> > +/* Represents a virtual tty device in this virtual card */
> > +struct vs_dev {
> > +     /* index for this device in tty core */
> > +     unsigned int own_index;
> > +     /* index of the device to which this device is connected */
> > +     unsigned int peer_index;
> > +     /* shadow modem status register */
> > +     int msr_reg;
> > +     /* shadow modem control register */
> > +     int mcr_reg;
> > +     /* rts line connections for this device */
> > +     int rts_mappings;
> > +     /* dtr line connections for this device */
> > +     int dtr_mappings;
> > +     int set_odtr_at_open;
> > +     int set_pdtr_at_open;
> > +     int odevtyp;
> > +     /* mutual exclusion at device level */
> > +     struct mutex lock;
> > +     int is_break_on;
> > +     /* currently active baudrate */
> > +     int baud;
> > +     int uart_frame;
> > +     int waiting_msr_chg;
> > +     int tx_paused;
> > +     int faulty_cable;
> > +     struct tty_struct *own_tty;
> > +     struct tty_struct *peer_tty;
> > +     struct serial_struct serial;
> > +     struct async_icount icount;
> > +     struct device *device;
> > +};
> > +
> > +/*
> > + * Associates index of the device as managed by index manager
> > + * to its device specific data.
> > + */
> > +struct vs_info {
> > +     int index;
> > +     struct vs_dev *vsdev;
> > +};
> > +
> > +/*
> > + * Root of database of all devices managed by this driver. Devices
> > + * are referenced using this root. For ex; to retreive struct vs_dev
> > + * of 3rd device use db[3].vsdev.
> > + */
> > +static struct vs_info *db;
>
> No, please create these dynamically, no need to have this, right?
Okay, I have replaced this with index radix tree. I will send v2 soon.
>
> > +
> > +/*
> > + * This is used to create and destroy devices atomically.
> > + */
> > +static DEFINE_MUTEX(card_lock);
> > +
> > +/* Describes this driver */
> > +static struct tty_driver *ttyvs_driver;
> > +
> > +/* Module params / device-tree properties */
> > +#define VS_DEFAULT_MAX_DEV 64
> > +static ushort max_num_vs_devs = VS_DEFAULT_MAX_DEV;
> > +static ushort init_num_nm_pairs;
> > +static ushort init_num_lb_devs;
> > +
> > +/* Gives how many null modem pairs exist at present */
> > +static ushort total_nm_pair;
> > +
> > +/* Gives how many loop back devices exist at present */
> > +static ushort total_lb_devs;
>
> u16 for all of these?
Okay, I will update in v2.
>
>
> > +static struct attribute *vs_info_attrs[] = {
> > +     &dev_attr_event.attr,
> > +     &dev_attr_faultycable.attr,
> > +     &dev_attr_ownidx.attr,
> > +     &dev_attr_peeridx.attr,
> > +     &dev_attr_ortsmap.attr,
> > +     &dev_attr_odtrmap.attr,
> > +     &dev_attr_prtsmap.attr,
> > +     &dev_attr_pdtrmap.attr,
> > +     &dev_attr_odevtyp.attr,
> > +     &dev_attr_odtropn.attr,
> > +     &dev_attr_pdtropn.attr,
> > +     &dev_attr_ostats.attr,
> > +     NULL,
> > +};
>
> There are a _LOT_ of sysfs files here that are not documented anywhere
> in your Documentation/ABI/ entry.  Why are these all needed?
I will double check this with my team or document why they are needed in v2.
>
> > +
> > +static const struct attribute_group vs_info_attr_grp = {
> > +     .attrs = vs_info_attrs,
> > +};
>
> ATTRIBUTE_GROUPS()?
Okay, I will update in v2.
>
> > +/*
> > + * Returns next minor number (index) free to be used for
> > + * next tty device otherwise -ENOMEM. If a particular index
> > + * is to be excluded it is provided by the caller in 'exclude'.
> > + */
> > +static int vs_get_free_idx(unsigned int *idx, int exclude)
> > +{
> > +     int x;
> > +
> > +     for (x = 0; x < max_num_vs_devs; x++) {
> > +             if (db[x].index == -1) {
> > +                     if (x == exclude) {
> > +                             continue;
> > +                     } else {
> > +                             *idx = x;
> > +                             return 0;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return -ENOMEM;
> > +}
>
> Use an idr please.  Or is it an 'ida'?  Either way, NEVER open-code this
> type of logic anymore, you will get it wrong :(
Okay, I will update in v2.
>
> > +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> > +                     int dtrmap, int dtropn)
> > +{
> > +     int ret;
> > +     struct vs_dev *vsdev;
> > +     struct device *dev;
> > +
> > +     /* Allocate and init virtual tty device private data */
> > +     vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
> > +     if (!vsdev)
> > +             return -ENOMEM;
> > +
> > +     vsdev->own_tty = NULL;
> > +     vsdev->peer_tty = NULL;
> > +     vsdev->own_index = oidx;
> > +     vsdev->peer_index =  pidx;
> > +     vsdev->rts_mappings = rtsmap;
> > +     vsdev->dtr_mappings = dtrmap;
> > +     vsdev->set_odtr_at_open = dtropn;
> > +     vsdev->msr_reg = 0;
> > +     vsdev->mcr_reg = 0;
> > +     vsdev->waiting_msr_chg = 0;
> > +     vsdev->tx_paused = 0;
> > +     vsdev->faulty_cable = 0;
> > +     mutex_init(&vsdev->lock);
> > +
> > +     /* Register with tty core with specific minor number */
> > +     dev = tty_register_device(ttyvs_driver, oidx, NULL);
> > +     if (!dev) {
> > +             ret = -ENOMEM;
> > +             goto fail;
> > +     }
> > +
> > +     vsdev->device = dev;
> > +     dev_set_drvdata(dev, vsdev);
> > +
> > +     /* Create custom sysfs files for this device for events */
> > +     ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);
>
> Please no.  You just raced with userspace and lost (i.e. userspace has
> no idea these files are present.)
>
> Please use the correct apis for this, if you _REALLY_ want special sysfs
> files for a tty device.
Any specific API would you like to suggest. I am unable to progress on
how to address this one.
>
> greg k-h
