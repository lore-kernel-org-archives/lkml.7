Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E1CC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702CE207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578339305;
	bh=ziYm7fxZ41w31GkYaeDw83bE9fkcFAm8gYgzn3tUsFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qtZUv3EvfkywGDcr9+g6voenYQxO14/gNktPd7zPX2fnvbEjz7+5RANrM4uMZr+hm
	 nB5c8LKqJ6DidxWLMzrJ0sgoK6ISDk0sFLFRsyXyEIgQV82hnKkDqoOk8+kDddYouQ
	 qIvfYEz9eV+Hz6SHcSzJYAyCZx215glPvRoPR5GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFTfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFTfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:35:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63346207FD;
        Mon,  6 Jan 2020 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578339302;
        bh=ziYm7fxZ41w31GkYaeDw83bE9fkcFAm8gYgzn3tUsFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/pSPV8wxy72yJsbhhrfzb7RFEW5LKDUBnQXoN2zxUTM4UwZUXNo9bCgrEhOMAiER
         D20PmzuKjHZnlA0w1HjVo2cfk9ZAbKReFX5vqCTArd+IIBrAQ5ccDRFKjqvUKEMcHB
         VjeCNIHpkYPUCgV6R7DBDDuMFmw9aXPWIA8EswFM=
Date:   Mon, 6 Jan 2020 20:35:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver
 emulating serial port
Message-ID: <20200106193500.GC754821@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
 <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:51:54PM +0530, Rishi Gupta wrote:
> This commit adds driver that can create virtual tty devices.
> This is useful in software testing and gps data simulation.
> 
> Devices are created either through DT or by writing to device
> node. Serial port events like frame, parity, overflow errors
> are also emulated by writing to sysfs files.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
>  MAINTAINERS          |    8 +
>  drivers/tty/Kconfig  |   16 +
>  drivers/tty/Makefile |    1 +
>  drivers/tty/ttyvs.c  | 2429 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2454 insertions(+)
>  create mode 100644 drivers/tty/ttyvs.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6b893f..350fb36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16794,6 +16794,14 @@ F:	include/uapi/linux/serial_core.h
>  F:	include/uapi/linux/serial.h
>  F:	include/uapi/linux/tty.h
>  
> +TTYVS VIRTUAL SERIAL DRIVER
> +M:	Rishi Gupta <gupt21@gmail.com>
> +L:	linux-serial@vger.kernel.org
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/ttyvs.yaml
> +F:	drivers/tty/ttyvs.c
> +
>  TUA9001 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index a312cb3..1e843f9 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -477,4 +477,20 @@ config LDISC_AUTOLOAD
>  	  dev.tty.ldisc_autoload sysctl, this configuration option will
>  	  only set the default value of this functionality.
>  
> +config TTY_VS
> +	tristate "Virtual serial null modem emulation"
> +	help
> +	  This driver creates virtual serial port devices (loopback and
> +	  null modem style) that can be used in the same way as real serial
> +	  port devices. Parity, frame, overflow, ring indicator, baudrate
> +	  mismatch, hardware and software flow control can be emulated.
> +
> +	  For information about how to create/delete devices, exchange data
> +	  and emulate events, please read:
> +	  <file:Documentation/devicetree/bindings/serial/ttyvs.yaml>.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ttyvs.ko. If you want to compile this driver
> +	  into the kernel, say Y here.
> +
>  endif # TTY
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 020b1cd..c5f2b4c 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>  obj-$(CONFIG_VCC)		+= vcc.o
> +obj-$(CONFIG_TTY_VS)	+= ttyvs.o
>  
>  obj-y += ipwireless/
> diff --git a/drivers/tty/ttyvs.c b/drivers/tty/ttyvs.c
> new file mode 100644
> index 0000000..894346c
> --- /dev/null
> +++ b/drivers/tty/ttyvs.c
> @@ -0,0 +1,2429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Serial port null modem emulation driver
> + *
> + * Copyright (c) 2020, Rishi Gupta <gupt21@gmail.com>
> + */
> +
> +/*
> + * Virtual multi-port serial card:
> + *
> + * This driver implements a virtual multi-port serial card in such a
> + * way that the virtual card can have 0 to N number of virtual serial
> + * ports (tty devices). The devices created in this card are used in
> + * exactly the same way as the real tty devices using standard termios
> + * and Linux/Posix APIs.
> + *
> + *    /dev/ttyvs_card
> + *  +~~~~~~~~~~~~~~~~~~~~~+
> + *  |   +-------------+   |
> + *  |   | /dev/ttyvs0 |   |
> + *  |   +-------------+   |
> + *  |   .                 |
> + *  |   .                 |
> + *  |   +-------------+   |
> + *  |   | /dev/ttyvsN |   |
> + *  |   +-------------+   |
> + *  +~~~~~~~~~~~~~~~~~~~~~+
> + *
> + * DT bindings: Documentation/devicetree/bindings/serial/ttyvs.yaml
> + *
> + * Example udev rules:
> + * 1. Permissions on card's node to create/destroy and query information:
> + *    ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"
> + *
> + * 2. Permission on tty device nodes and event sysfs files (%S is sysfs
> + *    mount point and %p is DEVPATH /devices/virtual/tty/ttyvsNUM):
> + *    ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*",\
> + *    MODE="0666", RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial.h>
> +#include <linux/sched.h>
> +#include <linux/version.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +/* Pin out configurations definitions */
> +#define VS_CON_CTS    0x0001
> +#define VS_CON_DCD    0x0002
> +#define VS_CON_DSR    0x0004
> +#define VS_CON_RI     0x0008
> +
> +/* Modem control register definitions */
> +#define VS_MCR_DTR    0x0001
> +#define VS_MCR_RTS    0x0002
> +#define VS_MCR_LOOP   0x0004
> +
> +/* Modem status register definitions */
> +#define VS_MSR_CTS    0x0008
> +#define VS_MSR_DCD    0x0010
> +#define VS_MSR_RI     0x0020
> +#define VS_MSR_DSR    0x0040
> +
> +/* UART frame structure definitions */
> +#define VS_CRTSCTS       0x0001
> +#define VS_XON           0x0002
> +#define VS_NONE          0X0004
> +#define VS_DATA_5        0X0008
> +#define VS_DATA_6        0X0010
> +#define VS_DATA_7        0X0020
> +#define VS_DATA_8        0X0040

Why the "X"?


> +#define VS_PARITY_NONE   0x0080
> +#define VS_PARITY_ODD    0x0100
> +#define VS_PARITY_EVEN   0x0200
> +#define VS_PARITY_MARK   0x0400
> +#define VS_PARITY_SPACE  0x0800
> +#define VS_STOP_1        0x1000
> +#define VS_STOP_2        0x2000
> +
> +/* Constants for the device type (odevtyp) */
> +#define VS_SNM 0x0001
> +#define VS_CNM 0x0002
> +#define VS_SLB 0x0003
> +#define VS_CLB 0x0004
> +
> +/* Represents a virtual tty device in this virtual card */
> +struct vs_dev {
> +	/* index for this device in tty core */
> +	unsigned int own_index;
> +	/* index of the device to which this device is connected */
> +	unsigned int peer_index;
> +	/* shadow modem status register */
> +	int msr_reg;
> +	/* shadow modem control register */
> +	int mcr_reg;
> +	/* rts line connections for this device */
> +	int rts_mappings;
> +	/* dtr line connections for this device */
> +	int dtr_mappings;
> +	int set_odtr_at_open;
> +	int set_pdtr_at_open;
> +	int odevtyp;
> +	/* mutual exclusion at device level */
> +	struct mutex lock;
> +	int is_break_on;
> +	/* currently active baudrate */
> +	int baud;
> +	int uart_frame;
> +	int waiting_msr_chg;
> +	int tx_paused;
> +	int faulty_cable;
> +	struct tty_struct *own_tty;
> +	struct tty_struct *peer_tty;
> +	struct serial_struct serial;
> +	struct async_icount icount;
> +	struct device *device;
> +};
> +
> +/*
> + * Associates index of the device as managed by index manager
> + * to its device specific data.
> + */
> +struct vs_info {
> +	int index;
> +	struct vs_dev *vsdev;
> +};
> +
> +/*
> + * Root of database of all devices managed by this driver. Devices
> + * are referenced using this root. For ex; to retreive struct vs_dev
> + * of 3rd device use db[3].vsdev.
> + */
> +static struct vs_info *db;

No, please create these dynamically, no need to have this, right?

> +
> +/*
> + * This is used to create and destroy devices atomically.
> + */
> +static DEFINE_MUTEX(card_lock);
> +
> +/* Describes this driver */
> +static struct tty_driver *ttyvs_driver;
> +
> +/* Module params / device-tree properties */
> +#define VS_DEFAULT_MAX_DEV 64
> +static ushort max_num_vs_devs = VS_DEFAULT_MAX_DEV;
> +static ushort init_num_nm_pairs;
> +static ushort init_num_lb_devs;
> +
> +/* Gives how many null modem pairs exist at present */
> +static ushort total_nm_pair;
> +
> +/* Gives how many loop back devices exist at present */
> +static ushort total_lb_devs;

u16 for all of these?


> +static struct attribute *vs_info_attrs[] = {
> +	&dev_attr_event.attr,
> +	&dev_attr_faultycable.attr,
> +	&dev_attr_ownidx.attr,
> +	&dev_attr_peeridx.attr,
> +	&dev_attr_ortsmap.attr,
> +	&dev_attr_odtrmap.attr,
> +	&dev_attr_prtsmap.attr,
> +	&dev_attr_pdtrmap.attr,
> +	&dev_attr_odevtyp.attr,
> +	&dev_attr_odtropn.attr,
> +	&dev_attr_pdtropn.attr,
> +	&dev_attr_ostats.attr,
> +	NULL,
> +};

There are a _LOT_ of sysfs files here that are not documented anywhere
in your Documentation/ABI/ entry.  Why are these all needed?

> +
> +static const struct attribute_group vs_info_attr_grp = {
> +	.attrs = vs_info_attrs,
> +};

ATTRIBUTE_GROUPS()?

> +/*
> + * Returns next minor number (index) free to be used for
> + * next tty device otherwise -ENOMEM. If a particular index
> + * is to be excluded it is provided by the caller in 'exclude'.
> + */
> +static int vs_get_free_idx(unsigned int *idx, int exclude)
> +{
> +	int x;
> +
> +	for (x = 0; x < max_num_vs_devs; x++) {
> +		if (db[x].index == -1) {
> +			if (x == exclude) {
> +				continue;
> +			} else {
> +				*idx = x;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -ENOMEM;
> +}

Use an idr please.  Or is it an 'ida'?  Either way, NEVER open-code this
type of logic anymore, you will get it wrong :(

> +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> +			int dtrmap, int dtropn)
> +{
> +	int ret;
> +	struct vs_dev *vsdev;
> +	struct device *dev;
> +
> +	/* Allocate and init virtual tty device private data */
> +	vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
> +	if (!vsdev)
> +		return -ENOMEM;
> +
> +	vsdev->own_tty = NULL;
> +	vsdev->peer_tty = NULL;
> +	vsdev->own_index = oidx;
> +	vsdev->peer_index =  pidx;
> +	vsdev->rts_mappings = rtsmap;
> +	vsdev->dtr_mappings = dtrmap;
> +	vsdev->set_odtr_at_open = dtropn;
> +	vsdev->msr_reg = 0;
> +	vsdev->mcr_reg = 0;
> +	vsdev->waiting_msr_chg = 0;
> +	vsdev->tx_paused = 0;
> +	vsdev->faulty_cable = 0;
> +	mutex_init(&vsdev->lock);
> +
> +	/* Register with tty core with specific minor number */
> +	dev = tty_register_device(ttyvs_driver, oidx, NULL);
> +	if (!dev) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	vsdev->device = dev;
> +	dev_set_drvdata(dev, vsdev);
> +
> +	/* Create custom sysfs files for this device for events */
> +	ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);

Please no.  You just raced with userspace and lost (i.e. userspace has
no idea these files are present.)

Please use the correct apis for this, if you _REALLY_ want special sysfs
files for a tty device.

greg k-h
