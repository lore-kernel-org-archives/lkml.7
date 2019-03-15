Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F152186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVP4+LOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfCOKL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:11:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfCOKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:11:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so5997298pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rIzisLLE4ZfeDq5xnPM58Dcf6flCGRSLuG8h9ZfPOtM=;
        b=WVP4+LOYxnIPrRo6Z/hj5/p+vkTndecOctYH40iwEoP6txXkU+/vgc0tFd0EjVwT38
         72Iv0rQxDjQaC4hzE9BqY67yrW0qjjmi/DL4MytwGssOhcwX3ymSolIxplkM+mimWRQQ
         382gM2vHfD4j0K0KLp0FpTc+CF1wSgZdUt+xdP0W5dmgnb3flyFpBDaNcCYXa5Hw4H03
         3BO37DaGCNb+w6/S9BLuMWho+OhijsWslNrSj0O03/0LoulanXWL8eQlGGfscnHtv5++
         XZ5deX032VYSrQRe4Pz4hYAve5ft+UqmjGZ3sB2oM9/+NxE6U5uJ7CAgMkCj5TqGtvwa
         85GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rIzisLLE4ZfeDq5xnPM58Dcf6flCGRSLuG8h9ZfPOtM=;
        b=UVLlXb3A7IQe9i5fdFxj8vEDzaxYpJ46s9MRt2jLf8fGX6t6nlfKQKh9p2ktChaI7/
         lPO0lI5m7+pqqXLwnI+2W3+zhL8qO8Qhh4jloS1PTbkKQzZ55b5S72TD+/7OxsXFSA+A
         uxXWk03DgHYgZUeVYDD9MxekeqL0Wd4LP3yP3vDJWaz7Cijn5WdCsP48+TYWF5TAgumh
         qMXdOVlPgVdtbqoIKj93XXgO6OGIGZuRgHyL5MoGl5RDSdGxjLEGMwB6hgQgoJm5QWDm
         nJsbY01o0VQGMB5J5i+uvJugM7UrIUx5RyWlVsMaA7cS3Fee/gfYrkbcIGMi9tO+VSuU
         qlEw==
X-Gm-Message-State: APjAAAUCp/jXwHluKUhGn+xYdB9wHUMlvoxIJvF1VRWydWbj7TKUSaUt
        N1sS+PkXFP4zo/rmn5ABPvtBnunNLv0=
X-Google-Smtp-Source: APXvYqzpVcUUDfH/eQq/vG/PkOEYDY06KFmQ1+vOUz+4Zu+j2Q+yDDETNQLxKCo56pyi0fjzv0/Bvg==
X-Received: by 2002:a65:6483:: with SMTP id e3mr2571907pgv.273.1552644684344;
        Fri, 15 Mar 2019 03:11:24 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-225-238.dynamic-ip.hinet.net. [114.36.225.238])
        by smtp.gmail.com with ESMTPSA id i3sm3724548pfo.149.2019.03.15.03.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 03:11:23 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     lkml@metux.net
Cc:     gregkh@linuxfoundation.org, morris_ku@sunix.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] Respond:add support for SUNIX Multi-I/O board
Date:   Fri, 15 Mar 2019 18:10:59 +0800
Message-Id: <20190315101059.25096-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,
Thanks for review, my replies are inline:

Signed-off-by: Morris Ku <saumah@gmail.com>
---

+From 5b1c4c8f7d91661a27c88b980c42b768e4cb7606 Mon Sep 17 00:00:00 2001
+From: Morris Ku <saumah@gmail.com>
+Date: Tue, 26 Feb 2019 17:11:48 +0800
+Subject: [PATCH 6/6] add support for SUNIX Multi-I/O board
+
+
+<snip>
+
+> diff --git a/char/snx/snx_main.c b/char/snx/snx_main.c
+
+if it's a serial card, shouldn't it go to drivers/tty/serial/snx/ ?
+
i will move to drivers/mfd (multi function devices)
+
+
+<snip>
+
+> +char
+[SNX_SER_PORT_MAX_UART][10] = {
+> +     {"UNKNOWN"},
+> +     {"SUN1889"},
+> +     {"SUN1699"},
+> +     {"SUNMATX"},
+> +     {"SUN1999"}
+> +};
+> +
+> +char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10] = {
+> +     {"UNKNOWN"},
+> +     {"SUN1888"},
+> +     {"SUN1689"},
+> +     {"SUNMATX"},
+> +     {"SUN1999"}
+> +};
+> +
+> +char snx_port_remap[2][10] = {
+> +     {"NON-REMAP"},
+> +     {"REMAP"}
+> +};
+
+can't these be const static ?
+
i will fix it.
+
+can we have a bit more consistent formatting (eg. all those comments
+w/ same indention) ?
+
i prefer to keep it in current format.
+
+> +     SUN1999_BOARD_5008A,
+> +
+
+<snip>
+
+> +static  struct pci_device_id sunix_pci_board_id[] = {
+> +// golden-serial
+
+can't this be const ?
+
i will fix it.
+
+(maybe even __initconst)
+I'd really prefer separate port types - that go into separate
+subsystems, in separate modules (those can share code in a common
+module, if desired)
+
+Oh, is there really a hard restriction on the max number of boards ?
+
+driver support maximum 4 boards can be installed incombination
+(up to 32 serial port and 2 parallel port)
+
+And do we really need a global list of them ? (instead of just having
+all per-board / per-port data in a per-board / per-port driver instance)
+
+
i prefer to keep current format.
+
+
+> +static int snx_ser_port_total_cnt;
+> +static int snx_par_port_total_cnt;
+> +
+> +int snx_board_count;
+> +
+> +static struct snx_ser_driver sunix_ser_reg = {
+> +     .dev_name = "ttySNX",
+> +     .major = 0,
+> +     .minor = 0,
+> +     .nr = (SNX_SER_TOTAL_MAX + 1),
+> +};
+
+can't this be const ?
+
i prefer keep it in current format.
+
+> +static irqreturn_t sunix_interrupt(int irq, void *dev_id)
+> +{
+> +     struct sunix_ser_port *sp = NULL;
+> +     struct sunix_par_port *pp = NULL;
+> +     struct sunix_board *sb = NULL;
+> +     int i;
+
+> +     int status = 0;
+> +
+> +     int handled = IRQ_NONE;
+> +
+> +     for (i = 0; i < SNX_BOARDS_MAX; i++) {
+> +
+> +             if (dev_id == &(sunix_board_table[i])) {
+> +                     sb = dev_id;
+> +                     break;
+> +             }
+> +     }
+
+maybe put this index into the board data, so the loop on the global
+array isn't needed ?
+
i prefer keep it in current format.
+
+<snip>
+
+> +     if ((sb->ser_port > 0) && (sb->ser_isr != NULL)) {
+> +             sp = &sunix_ser_table[sb->ser_port_index];
+
+maybe put this pointer struct sunix_board so the lookup in the
+global array isn't necessary ?
+
i prefer keep it in current format.
+
+<snip>
+
+> +     if ((sb->par_port > 0) && (sb->par_isr != NULL)) {
+> +             pp = &sunix_par_table[sb->par_port_index];
+> +
+> +             if (!pp)
+> +                     status = 1;
+> +
+> +             status = sb->par_isr(sb, pp);
+> +     }
+> +
+> +     if (status != 0)
+> +             return handled;
+> +
+> +     handled = IRQ_HANDLED;
+> +     return handled;
+> +}
+
+btw: is there only one irq per board or one per port ?
+
only one irq per board.
+
+> +static int snx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+> +{
+> +     return 0;
+
+shouldn't probe check whether the device is actually there and then do
+the initialization ?
+
i will fix it.
+
+<snip>
+
+> +static int snx_resume_port_termios(struct snx_ser_info *info)
+> +{
+> +     struct snx_ser_state *state = NULL;
+> +     struct tty_struct *tty = info->tty;
+> +
+> +     state = tty->driver_data;
+> +     snx_set_port_termios(state);
+> +
+> +     return 0;
+> +}
+> +
+> +
+
+do we need multiple newlines here ?
+
i will fix it.
+
+<snip>
+
+> +static int snx_resume_one(struct pci_dev *pdev)
+> +{
+> +     struct sunix_board *sb = pci_get_drvdata(pdev);
+> +     struct sunix_ser_port *sp = NULL;
+> +     int j;
+> +
+> +     if (sb == NULL)
+> +             return 0;
+> +
+> +     for (j = 0; j < sb->ser_port; j++) {
+> +             sp = &sunix_ser_table[j];
+
+can't the pointers to the serial ports be in struct sunix_board instead
+of an global array ?
+
+if it already is a global, why not statically initialized ?
+Why not doing this in snx_pci_probe() on per-board basis, and let device
+registration be done by pci subsystem ?
+
i prefer keep it in current format.
+
+> +     // search sun1999 muti I/O board
+> +     pdev = NULL;
+> +     tablecnt = 0;
+> +     sub_device_id = 0;
+> +     status = 0;
+> +     device_part_number = 0;
+> +     bar3_base_add = 0;
+> +     bar3_Byte5 = 0;
+> +     bar3_Byte6 = 0;
+> +     bar3_Byte7 = 0;
+> +     oem_id = 0;
+> +     uart_type = 0;
+> +     gpio_type = 0;
+> +     gpio_card_type = 0;
+> +     gpio_ch_cnt = 0;
+
+completely different boards handled by one big driver ?
+why not splitting it up into multiple drivers ?
+
SUNIX has many differing cards,serail,parallel and
multi-i/o(serial + parellel), therefore, we combaine to one driver.
+
+<snip>
+
+> +             if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x01))
+> +                     gpio_ch_cnt = 6;
+> +             else if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x02))
+> +                     gpio_ch_cnt = 8;
+> +             else if (gpio_ch_cnt == 0x01)
+> +                     gpio_ch_cnt = 16;
+> +             else if (gpio_ch_cnt == 0x02)
+> +                     gpio_ch_cnt = 32;
+> +
+
+gpio devices have their own subsystem -> therefore: write a separate
+gpio driver for that.
+
ioctl functions support for SUNIX specific serial,parellel and cash drawer
interface.
+
+<snip>
+why that limitation ? why does this have to be a global array at all ?
+
driver support maximum 4 boards can be installed incombination
(up to 32 serial port and 2 parallel port)
+
+> +static int sunix_assign_resource(void)
+> +{
+> +     struct sunix_board *sb = NULL;
+> +     struct sunix_ser_port *sp = NULL;
+> +     struct sunix_par_port *pp = NULL;
+> +
+> +     int status = 0;
+> +     int i;
+> +     int j;
+> +     int k;
+> +     int ser_n;
+> +     int ser_port_index = 0;
+> +
+> +     memset(sunix_ser_table, 0, (SNX_SER_TOTAL_MAX + 1) *
+> +     sizeof(struct sunix_ser_port));
+> +
+> +     memset(sunix_par_table, 0, (SNX_PAR_TOTAL_MAX) *
+> +     sizeof(struct sunix_par_port));
+
+why this w/ global variables, instead of on per-device basis on device-
+private data ?
+
i prefer keep it in current format.
+
+<snip>
+
+> +static int sunix_ser_port_table_init(void)
+> +{
+
+same here.
+
+<snip>
+
+> +static int sunix_par_port_table_init(void)
+> +{
+
+same here
+
+> +int sunix_register_irq(void)
+> +{
+
+same here.
+
+<snip>
+why not doing those initializations on per-device basis, in the
+corresponding probe() function ?
+use devm_*() functions, which automatically releases resource when a
+device is deleted, so explicit release isn't needed anymore.
+
i will fix it.
+
+> +static void __exit snx_exit(void)
+> +{
+> +     if (snx_par_port_total_cnt > 0) {
+> +             sunix_par_lp_exit();
+> +             sunix_par_ppdev_exit();
+> +             sunix_par_parport_exit();
+> +     }
+
+Let the cleanup be done by the individual driver's release functions,
+and down forget to set .owner correctly - that way, the kernel won't
+even allow unloading the module, as long as it's in use. then, you'd
+probably don't need much more than just removing unregistering the
+drivers here.
+
i prefer keep it in current format.
+
+> diff --git a/char/snx/snx_serial.c b/char/snx/snx_serial.c
+> new file mode 100644
+> index 00000000..fdac4c90
+> --- /dev/null
+> +++ b/char/snx/snx_serial.c
+> @@ -0,0 +1,4263 @@
+> +// SPDX-License-Identifier: GPL-2.0
+> +#include "snx_common.h"
+> +#include "driver_extd.h"
+> +
+> +#define SNX_ioctl_DBG        0
+
+what exactly is that ioctl for ?
+or more to the point: why are you introducing a driver specific iotctl ?
+
i will drop it.
+
+> +#define      EEPROM_ACCESS_DELAY_COUNT                       100000
+> +
+> +static DEFINE_SEMAPHORE(ser_port_sem);
+> +
+> +#define SNX_HIGH_BITS_OFFSET ((sizeof(long)-sizeof(int))*8)
+> +#define sunix_ser_users(state) \
+> +((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
+> +
+> +static struct tty_port snx_service_port;
+
+why has this to be global, instead of in per-device private data ?
+
I am not sure what you mean ?
+
+<snip>
+
+> +static _INLINE_ void snx_ser_handle_cts_change(
+> +     struct snx_ser_port *, unsigned int);
+
+Where's this strange "_INLINE_" coming from ?
+
i will fix it.
+
+<snip>
+
+> +//extern void                snx_ser_change_speed(
+> +     //struct snx_ser_state *state, struct SNXTERMIOS *old_termios);
+
+please no dead/commented-out code.
+
i will drop it.
+
+> +//extern int sunix_ser_interrupt(
+> +     //struct sunix_board *, struct sunix_ser_port *first_sp);
+
+same here
+
i will drop it.
+
+> +//extern int      sunix_ser_register_ports(struct snx_ser_driver *drv);
+> +//extern void     sunix_ser_unregister_ports(struct snx_ser_driver *drv);
+> +//extern int      sunix_ser_register_driver(struct snx_ser_driver *drv);
+> +//extern void     sunix_ser_unregister_driver(struct snx_ser_driver *drv);
+
+same here
+
i will drop it.
+
+> +static unsigned char READ_INTERRUPT_VECTOR_BYTE(struct sunix_ser_port *sp)
+
+i'd recommend no caps in function names.
+
i will fix it.
+
+> +             if (var == 0x04) {
+> +                     vet4 = inb(local_vector + 0xb0);
+> +                     vet4 <<= 12;
+> +             }
+> +
+> +             data = (vet1 | vet2 | vet3 | vet4);
+> +
+> +             return data;
+> +     }
+> +     return 0;
+> +}
+> +
+> +
+> +
+
+remove excess newlines
+
i will fix it.
+
+<snip>
+
+> +static int EEPROMWriteData(int targetConfigAddress, int address, int data)
+
+why do you use int instead of void* for addresses ?
+oh, and shouldn't it be __iomem ?
+
+targetConfigAddress for PCI (bar)base address register.
+
+<snip>
+
+> +             Error = inb(targetConfigAddress + 0x08) & 0x04;
+
+<snip>
+
+> +static void snx_ser_start(struct tty_struct *tty)
+> +{
+> +     int line = SNX_SER_DEVNUM(tty);
+> +
+> +     if (line >= SNX_SER_TOTAL_MAX)
+> +             return;
+> +
+> +     //spin_lock_irqsave(&port->lock, flags);
+> +     __snx_ser_start(tty);
+> +     //spin_unlock_irqrestore(&port->lock, flags);
+
+why are the spinlock calls commented out ?
+
i wiil fix it.
+
+<nsip>
+
+> +     tasklet_kill(&info->tlet);
+
+what exactly is the tasklet needed for ?
+
i will fix it.
+
+> +     if (!capable(CAP_SYS_ADMIN)) {
+> +             retval = -EPERM;
+
+why this explicit check for CAP_SYS_ADMIN ?
+
check users with admin rights
+
+> +             if (change_irq ||
+
+indention mismatch.
+
i will fix it.
+
+> +                     change_port ||
+
+why is userland allowed to change irq, port, etc, if that's probed
+from pci anyways ?
+
+
Since changing the 'type' of the port changes its resource
allocations, we should treat type changes the same as
IO port changes.
+
+>
+
+                    (new_serial.baud_base != port->uartclk / 16) ||
+> +                     (close_delay != state->close_delay) ||
+> +                     (closing_wait != state->closing_wait) ||
+> +                     (new_serial.xmit_fifo_size != port->fifosize) ||
+> +                     (((new_flags ^ old_flags) & ~SNX_UPF_USR_MASK) != 0)) {
+> +                     goto exit;
+> +             }
+> +
+> +             port->flags = ((port->flags & ~SNX_UPF_USR_MASK) |
+> +                     (new_flags & SNX_UPF_USR_MASK));
+> +             port->custom_divisor = new_serial.custom_divisor;
+> +             goto check_and_exit;
+> +     }
+
+<snip>
+
+> +static int snx_ser_ioctl(struct tty_struct *tty,
+> +unsigned int cmd, unsigned long arg)
+> +{
+<snip>
+> +     case TIOCSSERIAL:
+> +     {
+> +             if (line < SNX_SER_TOTAL_MAX) {
+> +                     state->port->setserial_flag = SNX_SER_BAUD_SETSERIAL;
+> +                     ret = snx_ser_set_info(state,
+> +                             (struct serial_struct *)arg);
+> +             }
+> +             break;
+> +     }
+> +
+> +
+> +     case TCSETS:
+> +     {
+> +             if (line < SNX_SER_TOTAL_MAX) {
+> +                     state->port->flags &= ~(SNX_UPF_SPD_HI |
+> +                             SNX_UPF_SPD_VHI |
+> +                             SNX_UPF_SPD_SHI |
+> +                             SNX_UPF_SPD_WARP);
+> +                     state->port->setserial_flag = SNX_SER_BAUD_NOTSETSER;
+> +                     snx_ser_update_termios(state);
+> +             }
+> +             break;
+> +     }
+> +
+
+Why do you need your own implementation of these tty ioctl()'s ?
+The tty subsystem handles them on its own (using the callbacks for hw-
+specific operations)
+
ioctl functions support for SUNIX specific serial,parellel and cash drawer interface.
+
+> +     case SNX_SER_DUMP_PORT_INFO:
+<snip>
+> +     case SNX_SER_DUMP_DRIVER_VER:
+<snip>
+> +     case SNX_COMM_GET_BOARD_CNT:
+<snip>
+> +     case SNX_COMM_GET_BOARD_INFO:
+
+is it really necessary to introduce your own driver-specific ioctl() ?
+why not putting these things into debugfs or sysfs ?
+
ioctl functions support for SUNIX specific serial,
parellel and cash drawer interface.
+
+> +     case SNX_GPIO_GET:
+<snip>
+> +     case SNX_GPIO_SET:
+<snip>
+> +     case SNX_GPIO_READ:
+<snip>
+> +     case SNX_GPIO_WRITE:
+<snip>
+> +     case SNX_GPIO_SET_DEFAULT:
+<snip>
+> +     case SNX_GPIO_WRITE_DEFAULT:
+<snip>
+> +     case SNX_GPIO_GET_INPUT_INVERT:
+<snip>
+> +     case SNX_GPIO_SET_INPUT_INVERT:
+
+
+gpio stuff clearly doesn't belong into tty ioctl()s.
+
+that's what the gpio subsystem is there for - this provides the linux
+standard api for gpio access.
+
+> +     case SNX_UART_GET_TYPE:
+
+what exactly is this for ?
+
+<snip>
+> +             } else {
+> +                     //pr_err(CE_NOTE, "WARNING : incorrect port
+> +                     //number (port = %d)!",gb.uart_num);
+> +                     break;
+> +             }
+> +
+> +                     switch (uart_type) {
+> +                     case 0: // RS-232
+
+yet another indention mismatch.
+and please remove dead code.
+
i will fix it.
+
+<snip>
+
+> +     case SNX_UART_SET_TYPE: {
+
+what is this for ?
+
+<snip>
+
+> +     case SNX_UART_SET_ACS:
+
+what is "ACS" ?
+
RS485 ACS Enable,Enable SUNIX UART Controller waiting transmit
data when receive data is going.
+
+> +     {
+> +             SNX_DRVR_UART_SET_ACS gb;
+> +             struct sunix_board      *sb = NULL;
+> +             int ACSstate = 0;
+> +             int targetConfigAddress = 0;
+> +
+> +             memset(&gb, 0, sizeof(SNX_DRVR_UART_SET_ACS));
+> +
+> +             if (copy_from_user(&gb, (void *)arg,
+> +                     (sizeof(SNX_DRVR_UART_SET_ACS))))
+> +                     ret = -EFAULT;
+> +             else
+> +                     ret = 0;
+> +
+> +             sb = &sunix_board_table[gb.board_id - 1];
+
+do we really need to access global variables here ?
+
i prefer to keep current format.
+
+<snip>
+
+> +     if (tty->flags & (1 << TTY_IO_ERROR)) {
+> +             ret = -EIO;
+> +             goto out;
+> +     }
+> +
+> +             switch (cmd) {
+> +             case TIOCMIWAIT:
+
+yet another idention mismatch.
+
i will fix it.
+
+<snip>
+
+> +     if (line < SNX_SER_TOTAL_MAX) {
+> +             down(&state->sem);
+> +
+> +                     switch (cmd) {
+> +                     case TIOCSERGETLSR:
+> +                     ret = snx_ser_get_lsr_info(state, (unsigned int *)arg);
+> +                     break;
+> +
+> +                     default:
+> +                     {
+> +                             break;
+> +                     }
+> +                     }
+> +
+> +             up(&state->sem);
+> +     }
+
+even more indention mismatches.
+
i will fix it.
+
+<snip>
+
+> +static void snx_ser_set_termios(struct tty_struct *tty,
+> +struct SNXTERMIOS *old_termios)
+> +{
+> +     struct snx_ser_state *state = NULL;
+> +     unsigned long flags;
+> +     unsigned int cflag = tty->termios.c_cflag;
+> +     int line = SNX_SER_DEVNUM(tty);
+> +
+> +     if (line >= SNX_SER_TOTAL_MAX)
+> +             return;
+> +
+> +     state = tty->driver_data;
+> +
+> +#define RELEVANT_IFLAG(iflag)        ((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
+
+please no #define's in the middle of a function.
+
i will fix it.
+
+<snip>
+
+> +static void snx_ser_update_timeout(struct snx_ser_port *port,
+> +unsigned int cflag, unsigned int baud)
+> +{
+> +     unsigned int bits;
+> +
+> +     switch (cflag & CSIZE) {
+> +     case CS5:
+> +     bits = 7;
+> +     break;
+> +
+
+more indention mismatches.
+
i will fix it.
+
+<snip>
+
+> +static int snx_ser_open(struct tty_struct *tty, struct file *filp)
+> +{
+> +     struct snx_ser_driver *drv =
+> +     (struct snx_ser_driver *)tty->driver->driver_state;
+> +
+> +     struct snx_ser_state *state = NULL;
+> +     struct tty_port *tport = NULL;
+> +
+> +     int retval = 0;
+> +     int line = SNX_SER_DEVNUM(tty);
+> +
+> +     if (line < SNX_SER_TOTAL_MAX) {
+> +             retval = -ENODEV;
+> +
+> +             if (line >= SNX_SER_TOTAL_MAX)
+> +                     goto fail;
+> +
+> +             state = snx_ser_get(drv, line);
+> +
+> +             tport = &state->tport;
+> +
+> +             if (IS_ERR(state)) {
+> +                     retval = PTR_ERR(state);
+> +                     goto fail;
+> +             }
+> +
+> +             if (!state)
+> +                     goto fail;
+> +
+> +
+> +             state->port->suspended = 1;
+> +             tty->driver_data = state;
+> +
+> +             tport->low_latency = (state->port->flags &
+> +             SNX_UPF_LOW_LATENCY) ? 1 : 0;
+> +
+> +             state->info->tty = tty;
+> +
+> +             tty_port_tty_set(tport, tty);
+> +
+> +             if (tty_hung_up_p(filp)) {
+> +                     retval = -EAGAIN;
+> +                     state->count--;
+> +                     up(&state->sem);
+> +                     goto fail;
+> +             }
+> +
+> +             retval = snx_ser_startup(state, 0);
+> +
+> +             if (retval == 0)
+> +                     retval = snx_ser_block_til_ready(filp, state);
+> +
+> +             up(&state->sem);
+> +
+> +             if (retval == 0 && !(state->info->flags &
+> +                     SNX_UIF_NORMAL_ACTIVE)) {
+> +                     state->info->flags |= SNX_UIF_NORMAL_ACTIVE;
+> +
+> +                     snx_ser_update_termios(state);
+> +             }
+> +
+> +             try_module_get(THIS_MODULE);
+
+why this ?
+
i will fix it.
+
+<snip>
+
+> +extern int sunix_ser_register_driver(struct snx_ser_driver *drv)
+> +{
+> +     struct tty_driver *normal = NULL;
+> +     int i;
+> +     int ret = 0;
+> +
+> +     drv->state = kmalloc(sizeof(struct snx_ser_state) * drv->nr,
+> +             GFP_KERNEL);
+> +
+> +     ret = -ENOMEM;
+> +
+> +     if (!drv->state) {
+> +             pr_err("SNX Error: Allocate memory fail !\n\n");
+> +             goto out;
+> +     }
+> +
+> +     memset(drv->state, 0, sizeof(struct snx_ser_state) * drv->nr);
+> +
+> +     for (i = 0; i < drv->nr; i++) {
+> +             struct snx_ser_state *state = drv->state + i;
+> +             struct tty_port *tport = &state->tport;
+> +
+> +             tty_port_init(tport);
+
+does that really need to be globally in driver init, instead of in per
+port device->open (and use device's private data) ?
+
i prefer to keep current format.
+
+<snip>
+
+> +extern void sunix_ser_unregister_ports(struct snx_ser_driver *drv)
+
+why are these 'extern' ?!
+
functions definition in multiple .c files.

\ No newline at end of file
--
2.17.1

