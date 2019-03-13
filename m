Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C69BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00AA214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqrmoSVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCMNbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:31:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37211 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:31:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so1546248pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03i8igdDOUwDblBb+NsZoUX5zsecbGXo5cXqQmB9gRs=;
        b=tqrmoSVscuAmMqJI79tT5BPDkW9wkYN9/kvxUA7Dt1HvqiPW+0WfcQZIvC8UjgYMdY
         eRTVDW8abwmIbxfNHw+xbgUWE9UpDjQU99X4EkQ9FMh7yOe32sO65pwC9UihdWyIuHuV
         h8J4fCh+RenuAO6e16VfP/6SrSdXpidmk1LN/tlUXHw2q4fWddYhXt4r1E9gUg3Ed2nd
         o3GNi50TrZwV00SN/rljvpS5WopT0fEos6oYAlcMIka2RmywW3zaf6mdatF1y876K7o6
         yePoN4Zdbepfvt1BbR3xgKfLQn2LeyHrZTb211CjxDAbc1sILQrk7Z0n54pv8aLcqn3+
         2tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03i8igdDOUwDblBb+NsZoUX5zsecbGXo5cXqQmB9gRs=;
        b=PQntaacOeCsYta7nKtXgRB42bAo3pJsqHfyH343S+UkAsUQEcRRAm5I9J38hcc/kaK
         bYu9s95vjIbNMYwDe1je1/Swhj6PX+ySIHV/zJNaQZK/T/N4gl6fv411bT9R2UNwX8Be
         aANRqSwR6foJroVFtesdfAT0p8AIbKfaT4THgRMW+7eWQLs5vIbJqFX48H5+VJX2pI3y
         WnhQty6LbtAkHM7ua2uTYkraHq2IvIs5WjFhxpwY9j3CnhpllcKlaIPS7QW5B/liryTF
         NJhHkIlz6ISBG0TJTU+K1uu0vQtSw+7KB+15dot05H4yPW9x6G1Z3WvLPrziP4qF5je9
         yPpQ==
X-Gm-Message-State: APjAAAXLdSFBw2YDYZnS+fjiSvWvhLeUxfy325ewCPakyiuiNLtPOEyv
        uznA9IuHBUrTx3X219Kq2pY=
X-Google-Smtp-Source: APXvYqzcAj8o4w/HkNYsWZZCGONabj6nmcsFPhyw1UjXqZ9PQrE8ik4iECl0HNvgM8/V4L9p2UMCTQ==
X-Received: by 2002:a63:94:: with SMTP id 142mr40179012pga.277.1552483896497;
        Wed, 13 Mar 2019 06:31:36 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-231-127.dynamic-ip.hinet.net. [114.36.231.127])
        by smtp.gmail.com with ESMTPSA id v4sm16437374pff.181.2019.03.13.06.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 06:31:35 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] Respond:Add SUNIX-Multi-I/O card device driver
Date:   Wed, 13 Mar 2019 21:31:18 +0800
Message-Id: <20190313133118.14506-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,
Thanks for review, my replies are inline:

Signed-off-by: Morris Ku <saumah@gmail.com>
---
+On 08.03.19 13:35, Morris Ku wrote:
+> This patch add header file, Kconfig and Makefile. 
+> 
+> Signed-off-by: Morris Ku <saumah@gmail.com>
+> ---
+>  char/snx/Kconfig       |   15 +
+>  char/snx/Makefile      |    9 +
+>  char/snx/driver_extd.h |  170 ++++++
+>  char/snx/snx_common.h  | 1157 ++++++++++++++++++++++++++++++++++++++++
+>  char/snx/snx_lp.h      |  126 +++++
+>  char/snx/snx_ppdev.h   |   43 ++
+
+why isn't that in ./drivers/tty/serial/sunix/ ?
+
driver support SUNIX Character Devices,
serial ports and parallel ports,so we suggest 
that in /drivers/char. 
+
+<snip>
+
+> diff --git a/char/snx/Kconfig b/char/snx/Kconfig
+> new file mode 100644
+> index 00000000..86f38352
+> --- /dev/null
+> +++ b/char/snx/Kconfig
+> @@ -0,0 +1,15 @@
+> +# SPDX-License-Identifier: GPL-2.0
+> +#
+> +# Character device configuration
+> +#
+> +
+> +config SNX
+
+please use full name: SUNIX
+

Ok, i'll fix in next verion.

+
+<snip>
+
+> diff --git a/char/snx/driver_extd.h b/char/snx/driver_extd.h
+> new file mode 100644
+> index 00000000..27f69570
+> --- /dev/null
+> +++ b/char/snx/driver_extd.h
+> @@ -0,0 +1,170 @@
+> +/* SPDX-License-Identifier: GPL-2.0 */
+> +
+> +#ifndef _SNXHW_DRVR_EXTR_H_
+> +#define _SNXHW_DRVR_EXTR_H_
+> +
+> +#ifndef SNX_IOCTL
+> +#define SNX_IOCTL 0x900
+> +#endif
+> +
+> +#define SNX_COMM_GET_BOARD_CNT          (SNX_IOCTL + 100)
+> +#define SNX_COMM_GET_BOARD_INFO         (SNX_IOCTL + 101)
+> +
+> +#define SNX_GPIO_GET                    (SNX_IOCTL + 200)
+> +#define SNX_GPIO_SET                    (SNX_IOCTL + 201)
+> +#define SNX_GPIO_READ                   (SNX_IOCTL + 202)
+> +#define SNX_GPIO_WRITE                  (SNX_IOCTL + 203)
+> +#define SNX_GPIO_SET_DEFAULT            (SNX_IOCTL + 204)
+> +#define SNX_GPIO_WRITE_DEFAULT          (SNX_IOCTL + 205)
+> +#define SNX_GPIO_GET_INPUT_INVERT       (SNX_IOCTL + 206)
+> +#define SNX_GPIO_SET_INPUT_INVERT       (SNX_IOCTL + 207)
+> +
+> +#define SNX_UART_GET_TYPE               (SNX_IOCTL + 300)
+> +#define SNX_UART_SET_TYPE               (SNX_IOCTL + 301)
+> +#define SNX_UART_GET_ACS                (SNX_IOCTL + 302)
+> +#define SNX_UART_SET_ACS                (SNX_IOCTL + 303)
+
+why exactly do you introduce driver-specific ioctls ?
+
ioctl functions support SUNIX specific serial,parellel and GPIO 
,need to use specific ioctol function to get related inforomation.
+
+what is "ACS"
+
RS485 ACS Enable,Enable SUNIX UART Controller waiting transmit 
data when receive data is going.
+
+> +#define SNX_GPIO_IN               0
+> +#define SNX_GPIO_OUT              1
+> +#define SNX_GPIO_LOW              0
+> +#define SNX_GPIO_HI               1
+> +#define SNX_GPIO_INPUT_INVERT_D   0
+> +#define SNX_GPIO_INPUT_INVERT_E   1
+
+GPIO stuff belongs into the gpio subsystem. see drivers/gpio/
+
SUNIX Multi-I/O card combaine serial ports,parallel ports and GPIO,
therefore, the define support SUNIX specific gpio interface. 
+
+<snip>
+
+> diff --git a/char/snx/snx_common.h b/char/snx/snx_common.h
+> new file mode 100644
+> index 00000000..16dd8f02
+> --- /dev/null
+> +++ b/char/snx/snx_common.h
+> @@ -0,0 +1,1157 @@
+> +﻿// SPDX-License-Identifier: GPL-2.0
+> +
+> +#ifdef       MODVERSIONS
+> +#ifndef MODULE
+> +#define      MODULE
+> +#endif
+> +#endif
+
+dont need that. please drop it.
+
Ok, i will drop it.
+
+<snip>
+
+> +#ifndef KERNEL_VERSION
+> +#define KERNEL_VERSION(ver, rel, seq)        ((ver << 16) | (rel << 8) | seq)
+> +#endif
+
+same here.
+
Ok, i will drop it.
+
+> +#include <linux/errno.h>
+> +#include <linux/signal.h>
+> +#include <linux/tty.h>
+> +#include <linux/tty_flip.h>
+> +#include <linux/serial.h>
+> +#include <linux/serial_reg.h>
+> +#include <linux/ioport.h>
+> +#include <linux/mm.h>
+> +#include <linux/kernel.h>
+> +#include <linux/init.h>
+> +#include <linux/slab.h>
+> +#include <linux/wait.h>
+> +#include <linux/tty_driver.h>
+> +#include <linux/pci.h>
+> +#include <linux/circ_buf.h>
+> +#include <asm/uaccess.h>
+> +#include <asm/io.h>
+> +#include <asm/irq.h>
+> +#include <asm/segment.h>
+> +#include <asm/serial.h>
+> +#include <linux/interrupt.h>
+> +#include <linux/module.h>
+> +#include <linux/workqueue.h>
+> +#include <linux/moduleparam.h>
+> +#include <linux/console.h>
+> +#include <linux/sysrq.h>
+> +#include <linux/delay.h>
+> +#include <linux/device.h>
+> +#include <linux/kref.h>
+> +#include <linux/parport.h>
+> +#include <linux/ctype.h>
+> +#include <linux/poll.h>
+> +#include <linux/sched.h>
+> +#include <linux/serial_8250.h>
+> +#include <linux/cdev.h>
+> +#include <linux/sched/signal.h>
+
+are these really all needed within the header ?
+
i will fix it.
+
+> +extern int snx_board_count;
+
+Why that extern field ?
+
i will fix it.
+
+> +#define SNX_DRIVER_VERSION   "V2.0.4.5"
+> +#define SNX_DRIVER_AUTHOR    "SUNIX Co., Ltd.<info@sunix.com.tw>"
+> +#define SNX_DRIVER_DESC      "SUNIX Multi-I/O Board Driver Module"
+
+Does it need to be in here ? (see MODULE_*() macros)
+
Ok, i will moved to appropriate file.
+
+<snip>
+
+> +typedef struct _PORT {
+> +     char            type;
+> +
+> +     int             bar1;
+> +     unsigned char   offset1;
+> +     unsigned char   length1;
+> +
+> +     int             bar2;
+> +     unsigned char   offset2;
+> +     unsigned char   length2;
+> +
+> +     unsigned int    intmask;
+> +     unsigned int    chip_flag;
+> +
+> +} PORT;
+
+please no uppercase type names, and use proper prefix.
+
ok , i will fix it 
+
+> +#if defined(__i386__) && (defined(CONFIG_M386) ||    \
+> +defined(CONFIG_M486))
+> +#define SNX_SERIAL_INLINE
+> +#endif
+> +
+> +#ifdef SNX_SERIAL_INLINE
+> +#define _INLINE_ inline
+> +#else
+> +#define _INLINE_
+> +#endif
+
+what is that for ?!
+
i will drop it.
+
+> +struct snx_ser_driver {
+> +     struct module   *owner;
+> +     const char      *driver_name;
+> +     const char      *dev_name;
+> +     int             major;
+> +     int             minor;
+> +     int             nr;
+> +     struct snx_ser_state    *state;
+> +     struct tty_driver       *tty_driver;
+> +};
+
+oh, not good. the struct tty_driver should be contained in
+snx_ser_driver (not a pointer to it). or the other way round:
+give the tty driver a pointer to a driver-private struct.
+
+and this data looks as it should be assigned to individual
+devices, not to driver globally.
+
ok , i will fix it 
+
+> +#include <linux/tty_flip.h>
+
+put all includes together at the top
+
ok , i will fix it 
+
+
+> +static inline void snx_ser_insert_char
+> +(
+> +             struct snx_ser_port *port,
+> +             unsigned int status,
+> +             unsigned int overrun,
+> +             unsigned int ch,
+> +             unsigned int flag
+> +)
+> +{
+> +     struct snx_ser_info *info = port->info;
+> +     struct tty_struct *tty = info->tty;
+> +     struct snx_ser_state *state = NULL;
+> +     struct tty_port *tport = NULL;
+> +
+> +     state = tty->driver_data;
+> +
+> +     tport = &state->tport;
+> +
+> +     if ((status & port->ignore_status_mask & ~overrun) == 0) {
+> +
+> +             if (tty_insert_flip_char(tport, ch, flag) == 0)
+> +                     ++port->icount.buf_overrun;
+> +     }
+> +
+> +     if (status & ~port->ignore_status_mask & overrun) {
+> +
+> +             if (tty_insert_flip_char(tport, 0, TTY_OVERRUN) == 0)
+> +                     ++port->icount.buf_overrun;
+> +     }
+> +}
+
+too big for an inline function.
+
ok , i will fix it 
+
+> +#define SNX_CONFIG_PARPORT_1284
+> +#define SNX_CONFIG_PARPORT_PC_FIFO
+> +
+> +#ifdef SNX_CONFIG_PARPORT_1284
+> +#undef SNX_CONFIG_PARPORT_1284
+> +#endif
+> +
+> +#ifdef SNX_CONFIG_PARPORT_PC_FIFO
+> +#undef SNX_CONFIG_PARPORT_PC_FIFO
+> +#endif
+
+parport, serial port, gpio should be separate drivers.
+
driver support SUNIX Multi-I/O card(ex: 1-port serial + 1-port Parallel),
therefore, i prefer to keep it in one driver.
+
+> +struct snx_parport_ops {
+
+Why does the driver introduce its own callback vectors ?
+
function definition in multiple .c files.
+
+> +
+> +struct sunix_par_port {
+> +     struct snx_parport      *port;
+> +
+> +     unsigned char           ctr;
+> +     unsigned char           ctr_writable;
+> +     int                     ecr;
+> +     int                     fifo_depth;
+> +     int                     pword;
+> +     int                     read_intr_threshold;
+> +     int                     write_intr_threshold;
+> +
+> +     char                    *dma_buf;
+
+why not void * ?
+
i am not sure what you mean ?
+
+> +     dma_addr_t              dma_handle;
+> +     struct list_head        list;
+> +
+> +     unsigned long           base;
+> +     unsigned long           base_hi;
+> +     int                     irq;
+> +     int                     portnum;
+> +     unsigned int            snx_type;
+> +
+> +     int                     board_enum;
+> +     unsign
+ed int            bus_number;
+> +     unsigned int            dev_number;
+> +
+> +     PCI_BOARD               pb_info;
+> +
+> +     unsigned char           chip_flag;
+> +     unsigned int            port_flag;
+> +};
+> +
+> +// snx_devtable.c
+> +extern PCI_BOARD snx_pci_board_conf[];
+<snip>
+
+why all these extern functions ?
+
function definition in multiple .c files.
+
+<snip>
+
+> +extern char snx_ser_ic_table[SNX_SER_PORT_MAX_UART][10];
+> +extern char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10];
+> +extern char snx_port_remap[2][10];
+
+please try not to use global fields. these things look they belong into
+the corresponding device private data structs.
+
ok , i will fix it 
+
+> +#define sunix_parport_write_data(p, x)       sunix_parport_pc_write_data(p, x)
+> +#define sunix_parport_read_data(p)   sunix_parport_pc_read_data(p)
+> +#define sunix_parport_write_control(p, x)    \
+> +sunix_parport_pc_write_control(p, x)
+> +#define sunix_parport_read_control(p)        sunix_parport_pc_read_control(p)
+> +#define sunix_parport_frob_control(p, m, v)  \
+> +sunix_parport_pc_frob_control(p, m, v)
+> +#define sunix_parport_read_status(p) \
+> +sunix_parport_pc_read_status(p)
+> +#define sunix_parport_enable_irq(p)  sunix_parport_pc_enable_irq(p)
+> +#define sunix_parport_disable_irq(p) sunix_parport_pc_disable_irq(p)
+> +#define sunix_parport_data_forward(p)        sunix_parport_pc_data_forward(p)
+> +#define sunix_parport_data_reverse(p)        sunix_parport_pc_data_reverse(p)
+
+does that really need to be in a header file ?
+
I suggest that keep it in a header file.
+
+<snip>
+
+> +static inline unsigned char sunix_parport_pc_frob_control(
+> +struct snx_parport *p, unsigned char mask, unsigned char val)
+> +{
+> +     const unsigned char wm = (PARPORT_CONTROL_STROBE |
+> +                                                     PARPORT_CONTROL_AUTOFD |
+> +                                                     PARPORT_CONTROL_INIT |
+> +                                                     PARPORT_CONTROL_SELECT);
+> +
+> +     if (mask & 0x20) {
+> +             if (val & 0x20)
+> +                     sunix_parport_pc_data_reverse(p);
+> +             else
+> +                     sunix_parport_pc_data_forward(p);
+> +
+> +     }
+> +
+> +     mask &= wm;
+> +     val &= wm;
+> +
+> +     return __sunix_parport_pc_frob_control(p, mask, val);
+> +}
+
+do these functions really *need* to be in the header and static inline ?
+(IOW: are they really needed from multiple .c files ?)
+
I suggest that keep it in a header file.
+
+> diff --git a/char/snx/snx_lp.h b/char/snx/snx_lp.h
+> new file mode 100644
+> index 00000000..8c48deea
+> --- /dev/null
+> +++ b/char/snx/snx_lp.h
+
+<snip>
+
+> +#define __KERNEL__   1
+> +
+> +#ifdef __KERNEL__
+
+doesn't belong here. drop that.
+
ok , i will fix it 
+
+> +
+> +#include <linux/mutex.h>
+
+put this at the top. if it's really needed here.
+
ok , i will fix it 
+
+> diff --git a/char/snx/snx_ppdev.h b/char/snx/snx_ppdev.h
+> new file mode 100644
+> index 00000000..635f99e1
+> --- /dev/null
+> +++ b/char/snx/snx_ppdev.h
+> @@ -0,0 +1,43 @@
+> +/* SPDX-License-Identifier: GPL-2.0 */
+> +#include "snx_common.h"
+> +
+> +#define SNX_PP_IOCTL 'p'
+> +
+> +struct snx_ppdev_frob_struct {
+> +     unsigned char mask;
+> +     unsigned char val;
+> +};
+> +
+> +
+> +#define SNX_PPSETMODE                _IOW(SNX_PP_IOCTL, 0x80, int)
+> +#define SNX_PPRSTATUS                _IOR(SNX_PP_IOCTL, 0x81, unsigned char)
+> +#define SNX_PPRCONTROL               _IOR(SNX_PP_IOCTL, 0x83, unsigned char)
+> +#define SNX_PPWCONTROL               _IOW(SNX_PP_IOCTL, 0x84, unsigned char)
+> +#define SNX_PPFCONTROL               _IOW(SNX_PP_IOCTL, 0x8e,\
+> +struct snx_ppdev_frob_struct)
+> +#define SNX_PPRDATA          _IOR(SNX_PP_IOCTL, 0x85, unsigned char)
+> +#define SNX_PPWDATA          _IOW(SNX_PP_IOCTL, 0x86, unsigned char)
+> +#define SNX_PPCLAIM          _IO(SNX_PP_IOCTL, 0x8b)
+> +#define SNX_PPRELEASE                _IO(SNX_PP_IOCTL, 0x8c)
+> +#define SNX_PPYIELD          _IO(SNX_PP_IOCTL, 0x8d)
+> +#define SNX_PPEXCL           _IO(SNX_PP_IOCTL, 0x8f)
+> +#define SNX_PPDATADIR                _IOW(SNX_PP_IOCTL, 0x90, int)
+> +#define SNX_PPNEGOT          _IOW(SNX_PP_IOCTL, 0x91, int)
+> +#define SNX_PPWCTLONIRQ              _IOW(SNX_PP_IOCTL, 0x92, unsigned char)
+> +#define SNX_PPCLRIRQ         _IOR(SNX_PP_IOCTL, 0x93, int)
+> +#define SNX_PPSETPHASE               _IOW(SNX_PP_IOCTL, 0x94, int)
+> +#define SNX_PPGETTIME                _IOR(SNX_PP_IOCTL, 0x95, struct timeval)
+> +#define SNX_PPSETTIME                _IOW(SNX_PP_IOCTL, 0x96, struct timeval)
+> +#define SNX_PPGETMODES               _IOR(SNX_PP_IOCTL, 0x97, unsigned int)
+> +#define SNX_PPGETMODE                _IOR(SNX_PP_IOCTL, 0x98, int)
+> +#define SNX_PPGETPHASE               _IOR(SNX_PP_IOCTL, 0x99, int)
+> +#define SNX_PPGETFLAGS               _IOR(SNX_PP_IOCTL, 0x9a, int)
+> +#define SNX_PPSETFLAGS               _IOW(SNX_PP_IOCTL, 0x9b, int)
+> +
+> +#define SNX_PP_FASTWRITE     (1<<2)
+> +#define SNX_PP_FASTREAD              (1<<3)
+> +#define SNX_PP_W91284PIC     (1<<4)
+> +
+> +#define SNX_PP_FLAGMASK              (SNX_PP_FASTWRITE | SNX_PP_FASTREAD \
+
+what exactly are these needed for ?
+
ok , i will fix it 
-- 
2.17.1

