Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E361C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206420840
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SnfReXqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCBAs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:48:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727736AbfCBAs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:48:59 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x220meJg029313
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 16:48:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=kNQrT+a4BHP9LL7Q4ItVB/bcojDcXzmMndmn653nxMA=;
 b=SnfReXqvLMQs5eWJq4XLN2ZQXKYmlaNRCGRq6F8Ah7e9tPL/AXCL2lelzyjbe6CvlIQq
 WhgMfJEPd84+WTaLdODKW2xF2tJ9o6qMflGPrMJdm0Dd0CQhU8+9usLyHh3g9AYVawk3
 KxNZqsmI75Na6r15XqsBMxmC6RJyzU8HWfE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qye6v07sk-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:48:41 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 16:48:34 -0800
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id 0621023A5AB3; Fri,  1 Mar 2019 16:48:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Date:   Fri, 1 Mar 2019 16:48:19 -0800
Message-ID: <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch embeds a device struct in the console struct, and registers
them on a "console" bus so we can expose attributes in sysfs.

Currently, most drivers declare static console structs, and that is
incompatible with the dev refcount model. So we end up needing to patch
all of the console drivers to:

	1. Dynamically allocate the console struct using a new helper
	2. Handle the allocation in (1) possibly failing
	3. Dispose of (1) with put_device()

Early console structures must still be static, since they're required
before we're able to allocate memory. The least ugly way I can come up
with to handle this is an "is_static" flag in the structure which makes
the gets and puts NOPs, and is checked in ->release() to catch mistakes.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 arch/alpha/kernel/srmcons.c                   |  10 +-
 arch/arm/kernel/early_printk.c                |   7 +-
 arch/ia64/hp/sim/hpsim_console.c              |   9 +-
 arch/m68k/amiga/config.c                      |  17 ++-
 arch/m68k/atari/debug.c                       |  29 ++++-
 arch/m68k/emu/nfcon.c                         |  60 ++++++---
 arch/m68k/kernel/early_printk.c               |   9 +-
 arch/m68k/q40/config.c                        |   7 +-
 arch/m68k/sun3x/prom.c                        |   7 +-
 arch/mips/dec/prom/console.c                  |   7 +-
 arch/mips/fw/arc/arc_con.c                    |  12 +-
 arch/mips/kernel/early_printk.c               |   9 +-
 arch/mips/sibyte/common/cfe_console.c         |  12 +-
 arch/parisc/kernel/pdc_cons.c                 |   9 +-
 arch/powerpc/kernel/udbg.c                    |   7 +-
 arch/s390/kernel/early_printk.c               |   7 +-
 arch/sh/kernel/sh_bios.c                      |   9 +-
 arch/sparc/kernel/btext.c                     |   7 +-
 arch/sparc/kernel/setup_32.c                  |   7 +-
 arch/sparc/kernel/setup_64.c                  |   7 +-
 arch/um/drivers/mconsole_kern.c               |  15 ++-
 arch/um/drivers/ssl.c                         |  22 +++-
 arch/um/drivers/stderr_console.c              |   7 +-
 arch/um/drivers/stdio_console.c               |  22 +++-
 arch/um/kernel/early_printk.c                 |   7 +-
 arch/unicore32/kernel/early_printk.c          |   7 +-
 arch/x86/include/asm/efi.h                    |   1 +
 arch/x86/kernel/early_printk.c                |  14 ++-
 arch/x86/platform/efi/early_printk.c          |   9 +-
 arch/xtensa/platforms/iss/console.c           |  10 +-
 .../accessibility/braille/braille_console.c   |   6 +-
 drivers/char/lp.c                             |  19 ++-
 drivers/hwtracing/stm/console.c               |  19 +--
 drivers/misc/pti.c                            |  26 ++--
 drivers/net/netconsole.c                      |  99 +++++++--------
 drivers/s390/char/con3215.c                   |  11 +-
 drivers/s390/char/con3270.c                   |  12 +-
 drivers/s390/char/sclp_con.c                  |  17 ++-
 drivers/s390/char/sclp_vt220.c                |  18 ++-
 drivers/tty/amiserial.c                       |  13 +-
 drivers/tty/ehv_bytechan.c                    |  19 ++-
 drivers/tty/goldfish.c                        |  34 ++++--
 drivers/tty/hvc/hvc_console.c                 |   8 +-
 drivers/tty/hvc/hvc_xen.c                     |  15 ++-
 drivers/tty/hvc/hvsi.c                        |  14 ++-
 drivers/tty/mips_ejtag_fdc.c                  |  44 ++++---
 drivers/tty/serial/21285.c                    |  25 ++--
 drivers/tty/serial/8250/8250_core.c           |  22 ++--
 drivers/tty/serial/8250/8250_early.c          |  18 ++-
 drivers/tty/serial/8250/8250_ingenic.c        |   6 +-
 drivers/tty/serial/altera_jtaguart.c          |  33 +++--
 drivers/tty/serial/altera_uart.c              |  25 ++--
 drivers/tty/serial/amba-pl010.c               |  35 ++++--
 drivers/tty/serial/amba-pl011.c               |  47 +++++---
 drivers/tty/serial/apbuart.c                  |  24 ++--
 drivers/tty/serial/ar933x_uart.c              |  13 +-
 drivers/tty/serial/arc_uart.c                 |  27 +++--
 drivers/tty/serial/atmel_serial.c             |  31 +++--
 drivers/tty/serial/bcm63xx_uart.c             |  25 ++--
 drivers/tty/serial/clps711x.c                 |  17 +--
 drivers/tty/serial/cpm_uart/cpm_uart_core.c   |  21 ++--
 drivers/tty/serial/digicolor-usart.c          |  24 ++--
 drivers/tty/serial/dz.c                       |  18 +--
 drivers/tty/serial/earlycon-arm-semihost.c    |   6 +-
 drivers/tty/serial/earlycon.c                 |   5 +-
 drivers/tty/serial/efm32-uart.c               |  22 ++--
 drivers/tty/serial/fsl_lpuart.c               |  57 ++++-----
 drivers/tty/serial/imx.c                      |  35 ++++--
 drivers/tty/serial/ip22zilog.c                |  18 +--
 drivers/tty/serial/kgdb_nmi.c                 |  21 +++-
 drivers/tty/serial/kgdboc.c                   |   2 +-
 drivers/tty/serial/lantiq.c                   |  23 ++--
 drivers/tty/serial/lpc32xx_hs.c               |  21 ++--
 drivers/tty/serial/mcf.c                      |  18 +--
 drivers/tty/serial/meson_uart.c               |  26 ++--
 drivers/tty/serial/mpc52xx_uart.c             |  18 +--
 drivers/tty/serial/mps2-uart.c                |  34 ++++--
 drivers/tty/serial/mpsc.c                     |  23 ++--
 drivers/tty/serial/msm_serial.c               |  36 ++++--
 drivers/tty/serial/mux.c                      |  44 ++++---
 drivers/tty/serial/mvebu-uart.c               |  30 +++--
 drivers/tty/serial/mxs-auart.c                |  18 +--
 drivers/tty/serial/netx-serial.c              |  20 +--
 drivers/tty/serial/omap-serial.c              |  40 +++---
 drivers/tty/serial/owl-uart.c                 |  29 +++--
 drivers/tty/serial/pch_uart.c                 |  26 ++--
 drivers/tty/serial/pic32_uart.c               |  30 +++--
 drivers/tty/serial/pmac_zilog.c               |  19 +--
 drivers/tty/serial/pnx8xxx_uart.c             |  20 +--
 drivers/tty/serial/pxa.c                      |  25 ++--
 drivers/tty/serial/qcom_geni_serial.c         |  57 ++++-----
 drivers/tty/serial/rda-uart.c                 |  26 ++--
 drivers/tty/serial/sa1100.c                   |  20 +--
 drivers/tty/serial/samsung.c                  |  41 +++++--
 drivers/tty/serial/sb1250-duart.c             |  20 +--
 drivers/tty/serial/sccnxp.c                   |  26 ++--
 drivers/tty/serial/serial_core.c              |  16 ++-
 drivers/tty/serial/serial_ks8695.c            |  25 ++--
 drivers/tty/serial/serial_txx9.c              |  21 ++--
 drivers/tty/serial/sh-sci.c                   |  55 ++++++---
 drivers/tty/serial/sirfsoc_uart.c             |  26 ++--
 drivers/tty/serial/sn_console.c               |  25 ++--
 drivers/tty/serial/sprd_serial.c              |  25 ++--
 drivers/tty/serial/st-asc.c                   |  27 +++--
 drivers/tty/serial/stm32-usart.c              |  17 ++-
 drivers/tty/serial/sunhv.c                    |  29 +++--
 drivers/tty/serial/sunsab.c                   |  29 ++---
 drivers/tty/serial/sunsu.c                    |  26 ++--
 drivers/tty/serial/sunzilog.c                 |  26 ++--
 drivers/tty/serial/uartlite.c                 |  23 ++--
 drivers/tty/serial/vr41xx_siu.c               |  31 +++--
 drivers/tty/serial/vt8500_serial.c            |  25 ++--
 drivers/tty/serial/xilinx_uartps.c            |  42 +++----
 drivers/tty/serial/zs.c                       |  25 ++--
 drivers/tty/tty_io.c                          |   6 +-
 drivers/tty/vt/vt.c                           |  14 ++-
 drivers/usb/early/ehci-dbgp.c                 |   7 +-
 drivers/usb/early/xhci-dbc.c                  |   7 +-
 drivers/usb/gadget/function/u_serial.c        |  22 ++--
 drivers/usb/serial/console.c                  |  24 ++--
 drivers/usb/serial/usb-serial.c               |  13 +-
 fs/proc/consoles.c                            |  10 +-
 fs/pstore/platform.c                          |  25 ++--
 include/linux/console.h                       |  36 +++++-
 include/linux/serial_core.h                   |  19 +++
 include/linux/usb/serial.h                    |   4 +-
 kernel/debug/debug_core.c                     |   7 +-
 kernel/debug/kdb/kdb_io.c                     |   4 +-
 kernel/printk/printk.c                        | 114 +++++++++++++++---
 129 files changed, 1772 insertions(+), 1036 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 438b10c44d73..f4de0ba8240b 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -266,15 +266,21 @@ srm_console_setup(struct console *co, char *options)
 	return 0;
 }
 
-static struct console srmcons = {
-	.name		= "srm",
+static const struct console_operations srmcons_cons_ops = {
 	.write		= srm_console_write,
 	.device		= srm_console_device,
 	.setup		= srm_console_setup,
+};
+
+static struct console srmcons = {
+	.name		= "srm",
+	.ops		= &srmcons_cons_ops,
 	.flags		= CON_PRINTBUFFER | CON_BOOT,
 	.index		= -1,
+	.is_static	= 1,
 };
 
+
 void __init
 register_srm_console(void)
 {
diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 9257736ec9fa..3af38403468e 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -33,11 +33,16 @@ static void early_console_write(struct console *con, const char *s, unsigned n)
 	early_write(s, n);
 }
 
+static const struct console_operations early_console_ops = {
+	.write =	early_console_write,
+};
+
 static struct console early_console_dev = {
 	.name =		"earlycon",
-	.write =	early_console_write,
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	-1,
+	.ops =		&early_console_ops,
+	.is_static =	1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/ia64/hp/sim/hpsim_console.c b/arch/ia64/hp/sim/hpsim_console.c
index bffd9f67a8a1..68be4eb8c5c8 100644
--- a/arch/ia64/hp/sim/hpsim_console.c
+++ b/arch/ia64/hp/sim/hpsim_console.c
@@ -30,13 +30,18 @@ static int simcons_init (struct console *, char *);
 static void simcons_write (struct console *, const char *, unsigned);
 static struct tty_driver *simcons_console_device (struct console *, int *);
 
-static struct console hpsim_cons = {
-	.name =		"simcons",
+static const struct console_operations hpsim_cons_ops = {
 	.write =	simcons_write,
 	.device =	simcons_console_device,
 	.setup =	simcons_init,
+};
+
+static struct console hpsim_cons = {
+	.name =		"simcons",
 	.flags =	CON_PRINTBUFFER,
+	.ops =		&hpsim_cons_ops,
 	.index =	-1,
+	.is_static =	1,
 };
 
 static int
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 65f63a457130..184520b4461f 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -110,6 +110,7 @@ static struct console amiga_console_driver = {
 	.name	= "debug",
 	.flags	= CON_PRINTBUFFER,
 	.index	= -1,
+	.is_static = 1,
 };
 
 
@@ -617,6 +618,10 @@ static void amiga_mem_console_write(struct console *co, const char *s,
 	}
 }
 
+static const struct console_operations amiga_mem_ops = {
+	.write = amiga_mem_console_write,
+};
+
 static int __init amiga_savekmsg_setup(char *arg)
 {
 	bool registered;
@@ -637,8 +642,8 @@ static int __init amiga_savekmsg_setup(char *arg)
 	savekmsg->magicptr = ZTWO_PADDR(savekmsg);
 	savekmsg->size = 0;
 
-	registered = !!amiga_console_driver.write;
-	amiga_console_driver.write = amiga_mem_console_write;
+	registered = !!amiga_console_driver.ops;
+	amiga_console_driver.ops = &amiga_mem_ops;
 	if (!registered)
 		register_console(&amiga_console_driver);
 	return 0;
@@ -663,6 +668,10 @@ static void amiga_serial_console_write(struct console *co, const char *s,
 	}
 }
 
+static const struct console_operations amiga_serial_ops = {
+	.write = amiga_serial_console_write,
+};
+
 #if 0
 void amiga_serial_puts(const char *s)
 {
@@ -728,8 +737,8 @@ static int __init amiga_debug_setup(char *arg)
 		return 0;
 
 	/* no initialization required (?) */
-	registered = !!amiga_console_driver.write;
-	amiga_console_driver.write = amiga_serial_console_write;
+	registered = !!amiga_console_driver.ops;
+	amiga_console_driver.ops = &amiga_serial_ops;
 	if (!registered)
 		register_console(&amiga_console_driver);
 	return 0;
diff --git a/arch/m68k/atari/debug.c b/arch/m68k/atari/debug.c
index 03cb5e08d7cf..3edb58b52b8c 100644
--- a/arch/m68k/atari/debug.c
+++ b/arch/m68k/atari/debug.c
@@ -29,6 +29,7 @@ static struct console atari_console_driver = {
 	.name	= "debug",
 	.flags	= CON_PRINTBUFFER,
 	.index	= -1,
+	.is_static = 1,
 };
 
 
@@ -49,6 +50,10 @@ static void atari_mfp_console_write(struct console *co, const char *str,
 	}
 }
 
+static const struct console_operations mfp_ops = {
+	.write = atari_mfp_console_write,
+};
+
 static inline void ata_scc_out(char c)
 {
 	do {
@@ -68,6 +73,10 @@ static void atari_scc_console_write(struct console *co, const char *str,
 	}
 }
 
+static const struct console_operations scc_ops = {
+	.write = atari_scc_console_write,
+};
+
 static inline void ata_midi_out(char c)
 {
 	while (!(acia.mid_ctrl & ACIA_TDRE))	/* wait for tx buf empty */
@@ -85,6 +94,10 @@ static void atari_midi_console_write(struct console *co, const char *str,
 	}
 }
 
+static const struct console_operations midi_ops = {
+	.write = atari_midi_console_write,
+};
+
 static int ata_par_out(char c)
 {
 	unsigned char tmp;
@@ -128,6 +141,10 @@ static void atari_par_console_write(struct console *co, const char *str,
 	}
 }
 
+static const struct console_operations par_ops = {
+	.write = atari_par_console_write,
+};
+
 #if 0
 int atari_mfp_console_wait_key(struct console *co)
 {
@@ -296,19 +313,19 @@ static int __init atari_debug_setup(char *arg)
 		/* defaults to ser2 for a Falcon and ser1 otherwise */
 		arg = MACH_IS_FALCON ? "ser2" : "ser1";
 
-	registered = !!atari_console_driver.write;
+	registered = !!atari_console_driver.ops;
 	if (!strcmp(arg, "ser1")) {
 		/* ST-MFP Modem1 serial port */
 		atari_init_mfp_port(B9600|CS8);
-		atari_console_driver.write = atari_mfp_console_write;
+		atari_console_driver.ops = &mfp_ops;
 	} else if (!strcmp(arg, "ser2")) {
 		/* SCC Modem2 serial port */
 		atari_init_scc_port(B9600|CS8);
-		atari_console_driver.write = atari_scc_console_write;
+		atari_console_driver.ops = &scc_ops;
 	} else if (!strcmp(arg, "midi")) {
 		/* MIDI port */
 		atari_init_midi_port(B9600|CS8);
-		atari_console_driver.write = atari_midi_console_write;
+		atari_console_driver.ops = &midi_ops;
 	} else if (!strcmp(arg, "par")) {
 		/* parallel printer */
 		atari_turnoff_irq(IRQ_MFP_BUSY); /* avoid ints */
@@ -318,9 +335,9 @@ static int __init atari_debug_setup(char *arg)
 		sound_ym.wd_data = 0;		/* no char */
 		sound_ym.rd_data_reg_sel = 14;	/* select port A */
 		sound_ym.wd_data = sound_ym.rd_data_reg_sel | 0x20; /* strobe H */
-		atari_console_driver.write = atari_par_console_write;
+		atari_console_driver.ops = &par_ops;
 	}
-	if (atari_console_driver.write && !registered)
+	if (atari_console_driver.ops && !registered)
 		register_console(&atari_console_driver);
 
 	return 0;
diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 57e8c8fb5eba..4a1a3c2f4c18 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -52,15 +52,6 @@ static struct tty_driver *nfcon_device(struct console *con, int *index)
 	return (con->flags & CON_ENABLED) ? nfcon_tty_driver : NULL;
 }
 
-static struct console nf_console = {
-	.name	= "nfcon",
-	.write	= nfcon_write,
-	.device	= nfcon_device,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-};
-
-
 static int nfcon_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	return 0;
@@ -98,8 +89,23 @@ static const struct tty_operations nfcon_tty_ops = {
 	.write_room	= nfcon_tty_write_room,
 };
 
+static const struct console_operations nfcon_cons_ops = {
+	.write	= nfcon_write,
+	.device	= nfcon_device,
+};
+
+static struct console *nf_console;
+
 #ifndef MODULE
 
+static struct console nf_console_static = {
+	.name	= "nfcon",
+	.flags	= CON_PRINTBUFFER,
+	.ops = &nfcon_cons_ops,
+	.index	= -1,
+	.is_static = 1,
+};
+
 static int __init nf_debug_setup(char *arg)
 {
 	if (strcmp(arg, "nfcon"))
@@ -107,8 +113,9 @@ static int __init nf_debug_setup(char *arg)
 
 	stderr_id = nf_get_id("NF_STDERR");
 	if (stderr_id) {
-		nf_console.flags |= CON_ENABLED;
-		register_console(&nf_console);
+		nf_console = &nf_console_static;
+		nf_console->flags |= CON_ENABLED;
+		register_console(nf_console);
 	}
 
 	return 0;
@@ -142,22 +149,37 @@ static int __init nfcon_init(void)
 	tty_set_operations(nfcon_tty_driver, &nfcon_tty_ops);
 	tty_port_link_device(&nfcon_tty_port, nfcon_tty_driver, 0);
 	res = tty_register_driver(nfcon_tty_driver);
-	if (res) {
-		pr_err("failed to register nfcon tty driver\n");
-		put_tty_driver(nfcon_tty_driver);
-		tty_port_destroy(&nfcon_tty_port);
-		return res;
+	if (res)
+		goto err;
+
+	res = -ENOMEM;
+	if (!nf_console) {
+		nf_console = allocate_console_dfl(&nfcon_cons_ops, "nfcon",
+						  NULL);
+		if (!nf_console)
+			goto err_unregister;
 	}
 
-	if (!(nf_console.flags & CON_ENABLED))
-		register_console(&nf_console);
+	if (!(nf_console->flags & CON_ENABLED))
+		register_console(nf_console);
 
 	return 0;
+
+err_unregister:
+	tty_unregister_driver(nfcon_tty_driver);
+err:
+	put_tty_driver(nfcon_tty_driver);
+	tty_port_destroy(&nfcon_tty_port);
+
+	pr_err("failed to register nfcon tty driver\n");
+	return res;
 }
 
 static void __exit nfcon_exit(void)
 {
-	unregister_console(&nf_console);
+	unregister_console(nf_console);
+	put_device(&nf_console->dev);
+
 	tty_unregister_driver(nfcon_tty_driver);
 	put_tty_driver(nfcon_tty_driver);
 	tty_port_destroy(&nfcon_tty_port);
diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 7d3fe08a48eb..e8f8efb42044 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -29,11 +29,16 @@ static void __ref debug_cons_write(struct console *c,
 #endif
 }
 
+static const struct console_operations early_ops = {
+	.write = debug_cons_write,
+};
+
 static struct console early_console_instance = {
 	.name  = "debug",
-	.write = debug_cons_write,
 	.flags = CON_PRINTBUFFER | CON_BOOT,
-	.index = -1
+	.ops = &early_ops,
+	.index = -1,
+	.is_static = 1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 96810d91da2b..6a919a61a5d4 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -53,11 +53,16 @@ static void q40_mem_console_write(struct console *co, const char *b,
 
 extern int ql_ticks;
 
+static const struct console_operations q40_mem_ops = {
+	.write	= q40_mem_console_write,
+};
+
 static struct console q40_console_driver = {
 	.name	= "debug",
-	.write	= q40_mem_console_write,
 	.flags	= CON_PRINTBUFFER,
+	.ops = &q40_mem_ops,
 	.index	= -1,
+	.is_static = 1,
 };
 
 
diff --git a/arch/m68k/sun3x/prom.c b/arch/m68k/sun3x/prom.c
index be14c899ab7d..661ef959a451 100644
--- a/arch/m68k/sun3x/prom.c
+++ b/arch/m68k/sun3x/prom.c
@@ -85,11 +85,16 @@ static void sun3x_prom_write(struct console *co, const char *s,
 
 /* debug console - write-only */
 
+static const struct console_operations sun3x_prom = {
+	.write	= sun3x_prom_write,
+};
+
 static struct console sun3x_debug = {
 	.name	= "debug",
-	.write	= sun3x_prom_write,
 	.flags	= CON_PRINTBUFFER,
+	.ops = &sun3x_prom,
 	.index	= -1,
+	.is_static = 1,
 };
 
 void __init sun3x_prom_init(void)
diff --git a/arch/mips/dec/prom/console.c b/arch/mips/dec/prom/console.c
index caa6e047caf1..707237815e2b 100644
--- a/arch/mips/dec/prom/console.c
+++ b/arch/mips/dec/prom/console.c
@@ -32,11 +32,16 @@ static void __init prom_console_write(struct console *con, const char *s,
 	}
 }
 
+static struct console_operations early_ops __initdata = {
+	.write	= prom_console_write,
+};
+
 static struct console promcons __initdata = {
 	.name	= "prom",
-	.write	= prom_console_write,
 	.flags	= CON_BOOT | CON_PRINTBUFFER,
+	.ops = &early_ops,
 	.index	= -1,
+	.is_static = 1,
 };
 
 void __init register_prom_console(void)
diff --git a/arch/mips/fw/arc/arc_con.c b/arch/mips/fw/arc/arc_con.c
index 365e3913231e..2cd246958e1f 100644
--- a/arch/mips/fw/arc/arc_con.c
+++ b/arch/mips/fw/arc/arc_con.c
@@ -31,12 +31,9 @@ static int prom_console_setup(struct console *co, char *options)
 	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
 }
 
-static struct console arc_cons = {
-	.name		= "arc",
+static const struct console_operations arc_ops = {
 	.write		= prom_console_write,
 	.setup		= prom_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 };
 
 /*
@@ -45,8 +42,13 @@ static struct console arc_cons = {
 
 static int __init arc_console_init(void)
 {
-	register_console(&arc_cons);
+	struct console *arc_cons;
 
+	arc_cons = allocate_console_dfl(&arc_ops, "arc", NULL);
+	if (!arc_cons)
+		return -ENOMEM;
+
+	register_console(arc_cons);
 	return 0;
 }
 console_initcall(arc_console_init);
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 4a1647ddfbd9..1b7b8994dd76 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -24,11 +24,16 @@ static void early_console_write(struct console *con, const char *s, unsigned n)
 	}
 }
 
+static const struct console_operations early_ops = {
+	.write	= early_console_write,
+};
+
 static struct console early_console_prom = {
 	.name	= "early",
-	.write	= early_console_write,
 	.flags	= CON_PRINTBUFFER | CON_BOOT,
-	.index	= -1
+	.ops = &early_ops,
+	.index	= -1,
+	.is_static = 1,
 };
 
 void __init setup_early_printk(void)
diff --git a/arch/mips/sibyte/common/cfe_console.c b/arch/mips/sibyte/common/cfe_console.c
index 8af7b41f7c19..51e81c0d3923 100644
--- a/arch/mips/sibyte/common/cfe_console.c
+++ b/arch/mips/sibyte/common/cfe_console.c
@@ -64,17 +64,19 @@ static int cfe_console_setup(struct console *cons, char *str)
 	return 0;
 }
 
-static struct console sb1250_cfe_cons = {
-	.name		= "cfe",
+static const struct console_operations cfe_ops = {
 	.write		= cfe_console_write,
 	.setup		= cfe_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 };
 
 static int __init sb1250_cfe_console_init(void)
 {
-	register_console(&sb1250_cfe_cons);
+	struct console *sb1250_cfe = allocate_console_dfl(&cfe_ops, "cfe",
+							  NULL);
+	if (!sb1250_cfe)
+		return -ENOMEM;
+
+	register_console(sb1250_cfe);
 	return 0;
 }
 
diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index c46bf29ae412..9c7f157aa133 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -218,13 +218,18 @@ static struct tty_driver * pdc_console_device (struct console *c, int *index)
 #define pdc_console_device NULL
 #endif
 
-static struct console pdc_cons = {
-	.name =		"ttyB",
+static const struct console_operations pdc_ops = {
 	.write =	pdc_console_write,
 	.device =	pdc_console_device,
 	.setup =	pdc_console_setup,
+};
+
+static struct console pdc_cons = {
+	.name =		"ttyB",
 	.flags =	CON_BOOT | CON_PRINTBUFFER,
+	.ops =		&pdc_ops,
 	.index =	-1,
+	.is_static =	1,
 };
 
 static int pdc_console_initialized;
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7cc38b5b58bc..91a369c9691e 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -148,11 +148,16 @@ static void udbg_console_write(struct console *con, const char *s,
 	udbg_write(s, n);
 }
 
+static const struct console_operations udbg_ops = {
+	.write	= udbg_console_write,
+};
+
 static struct console udbg_console = {
 	.name	= "udbg",
-	.write	= udbg_console_write,
 	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.ops	= &udbg_ops,
 	.index	= 0,
+	.is_static = 1,
 };
 
 /*
diff --git a/arch/s390/kernel/early_printk.c b/arch/s390/kernel/early_printk.c
index 40c1dfec944e..f3aaf7748027 100644
--- a/arch/s390/kernel/early_printk.c
+++ b/arch/s390/kernel/early_printk.c
@@ -13,11 +13,16 @@ static void sclp_early_write(struct console *con, const char *s, unsigned int le
 	__sclp_early_printk(s, len, 0);
 }
 
+static const struct console_operations sclp_ops = {
+	.write = sclp_early_write,
+};
+
 static struct console sclp_early_console = {
 	.name  = "earlysclp",
-	.write = sclp_early_write,
 	.flags = CON_PRINTBUFFER | CON_BOOT,
+	.ops = &sclp_ops,
 	.index = -1,
+	.is_static = 1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/sh/kernel/sh_bios.c b/arch/sh/kernel/sh_bios.c
index 250dbdf3fa74..2cbd042d452f 100644
--- a/arch/sh/kernel/sh_bios.c
+++ b/arch/sh/kernel/sh_bios.c
@@ -134,12 +134,17 @@ static int __init sh_console_setup(struct console *co, char *options)
 	return 0;
 }
 
-static struct console bios_console = {
-	.name		= "bios",
+static const struct console_operations bios_ops = {
 	.write		= sh_console_write,
 	.setup		= sh_console_setup,
+};
+
+static struct console bios_console = {
+	.name		= "bios",
 	.flags		= CON_PRINTBUFFER,
+	.ops		= &bios_ops,
 	.index		= -1,
+	.is_static	= 1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 5869773f3dc4..d5a165eaa161 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -300,11 +300,16 @@ static void btext_console_write(struct console *con, const char *s,
 	btext_drawtext(s, n);
 }
 
+static const struct console_operations btext_ops = {
+	.write	= btext_console_write,
+};
+
 static struct console btext_console = {
 	.name	= "btext",
-	.write	= btext_console_write,
 	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.ops = &btext_ops,
 	.index	= 0,
+	.is_static = 1,
 };
 
 int __init btext_find_display(void)
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index afe1592a6d08..e36dbc2cb8da 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -114,11 +114,16 @@ prom_console_write(struct console *con, const char *s, unsigned int n)
 	prom_write(s, n);
 }
 
+static const struct console_operations prom_ops = {
+	.write =	prom_console_write,
+};
+
 static struct console prom_early_console = {
 	.name =		"earlyprom",
-	.write =	prom_console_write,
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
+	.ops =		&prom_ops,
 	.index =	-1,
+	.is_static =	1,
 };
 
 /* 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 51c4d12c0853..0cc1dfcd8d5b 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -90,11 +90,16 @@ prom_console_write(struct console *con, const char *s, unsigned int n)
 /* Exported for mm/init.c:paging_init. */
 unsigned long cmdline_memory_size = 0;
 
+static const struct console_operations prom_ops = {
+	.write =	prom_console_write,
+};
+
 static struct console prom_early_console = {
 	.name =		"earlyprom",
-	.write =	prom_console_write,
 	.flags =	CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
+	.ops =		&prom_ops,
 	.index =	-1,
+	.is_static =	1,
 };
 
 /*
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff3ab72fd90f..5a6e5acec5d0 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -572,14 +572,19 @@ static void console_write(struct console *console, const char *string,
 	}
 }
 
-static struct console mc_console = { .name	= "mc",
-				     .write	= console_write,
-				     .flags	= CON_ENABLED,
-				     .index	= -1 };
+static const struct console_operations mc_cons_ops = {
+	.write = console_write,
+};
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	struct console *mc_console = allocate_console_dfl(&mc_cons_ops, "mc",
+							  NULL);
+	if (!mc_console)
+		return -ENOMEM;
+
+	mc_console->flags = CON_ENABLED;
+	register_console(mc_console);
 	return 0;
 }
 
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index b8d14fa52059..2f44fea2c455 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -138,15 +138,15 @@ static int ssl_console_setup(struct console *co, char *options)
 }
 
 /* No locking for register_console call - relies on single-threaded initcalls */
-static struct console ssl_cons = {
-	.name		= "ttyS",
+
+static const struct console_operations ssl_cons_ops = {
 	.write		= ssl_console_write,
 	.device		= ssl_console_device,
 	.setup		= ssl_console_setup,
-	.flags		= CON_PRINTBUFFER|CON_ANYTIME,
-	.index		= -1,
 };
 
+static struct console *ssl_cons;
+
 static int ssl_init(void)
 {
 	char *new_title;
@@ -156,10 +156,16 @@ static int ssl_init(void)
 	printk(KERN_INFO "Initializing software serial port version %d\n",
 	       ssl_version);
 
+	ssl_cons = allocate_console_dfl(&ssl_cons_ops, "ttyS", NULL);
+	if (!ssl_cons)
+		return -ENOMEM;
+
+	ssl_cons->flags |= CON_ANYTIME;
+
 	err = register_lines(&driver, &ssl_ops, serial_lines,
 				    ARRAY_SIZE(serial_lines));
 	if (err)
-		return err;
+		goto out;
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if (new_title != NULL)
@@ -178,6 +184,9 @@ static int ssl_init(void)
 	ssl_init_done = 1;
 	register_console(&ssl_cons);
 	return 0;
+out:
+	kfree(ssl_cons);
+	return err;
 }
 late_initcall(ssl_init);
 
@@ -185,7 +194,10 @@ static void ssl_exit(void)
 {
 	if (!ssl_init_done)
 		return;
+
+	unregister_console(&ssl_cons);
 	close_lines(serial_lines, ARRAY_SIZE(serial_lines));
+	put_device(&ssl_cons->dev);
 }
 __uml_exitcall(ssl_exit);
 
diff --git a/arch/um/drivers/stderr_console.c b/arch/um/drivers/stderr_console.c
index ecc3a5814932..8c4c6f8e1a32 100644
--- a/arch/um/drivers/stderr_console.c
+++ b/arch/um/drivers/stderr_console.c
@@ -22,10 +22,15 @@ static void stderr_console_write(struct console *console, const char *string,
 	generic_write(2 /* stderr */, string, len, NULL);
 }
 
+static const struct console_operations stderr_ops = {
+	.write		= stderr_console_write,
+};
+
 static struct console stderr_console = {
 	.name		= "stderr",
-	.write		= stderr_console_write,
 	.flags		= CON_PRINTBUFFER,
+	.ops		= &stderr_ops,
+	.is_static	= 1,
 };
 
 static int __init stderr_console_init(void)
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index c90817b04da9..7cd000b3b095 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -138,25 +138,31 @@ static int uml_console_setup(struct console *co, char *options)
 }
 
 /* No locking for register_console call - relies on single-threaded initcalls */
-static struct console stdiocons = {
-	.name		= "tty",
+
+static const struct console_operations uml_cons_ops = {
 	.write		= uml_console_write,
 	.device		= uml_console_device,
 	.setup		= uml_console_setup,
-	.flags		= CON_PRINTBUFFER|CON_ANYTIME,
-	.index		= -1,
 };
 
+static struct console *stdiocons;
+
 static int stdio_init(void)
 {
 	char *new_title;
 	int err;
 	int i;
 
+	stdiocons = allocate_console_dfl(&uml_cons_ops, "tty", NULL);
+	if (!stdiocons)
+		return -ENOMEM;
+
+	stdiocons->flags |= CON_ANYTIME;
+
 	err = register_lines(&driver, &console_ops, vts,
 					ARRAY_SIZE(vts));
 	if (err)
-		return err;
+		goto out;
 
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
@@ -177,8 +183,11 @@ static int stdio_init(void)
 	}
 
 	con_init_done = 1;
-	register_console(&stdiocons);
+	register_console(stdiocons);
 	return 0;
+out:
+	put_console(stdiocons);
+	return err;
 }
 late_initcall(stdio_init);
 
@@ -187,6 +196,7 @@ static void console_exit(void)
 	if (!con_init_done)
 		return;
 	close_lines(vts, ARRAY_SIZE(vts));
+	put_console(stdiocons);
 }
 __uml_exitcall(console_exit);
 
diff --git a/arch/um/kernel/early_printk.c b/arch/um/kernel/early_printk.c
index 4a0800bc37b2..96b20439d6f3 100644
--- a/arch/um/kernel/early_printk.c
+++ b/arch/um/kernel/early_printk.c
@@ -16,11 +16,16 @@ static void early_console_write(struct console *con, const char *s, unsigned int
 	um_early_printk(s, n);
 }
 
+static const struct console_operations early_ops = {
+	.write = early_console_write,
+};
+
 static struct console early_console_dev = {
 	.name = "earlycon",
-	.write = early_console_write,
 	.flags = CON_BOOT,
+	.ops = &early_ops,
 	.index = -1,
+	.is_static = 1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/unicore32/kernel/early_printk.c b/arch/unicore32/kernel/early_printk.c
index f2f6323c8d64..31d66e9e3d0d 100644
--- a/arch/unicore32/kernel/early_printk.c
+++ b/arch/unicore32/kernel/early_printk.c
@@ -26,11 +26,16 @@ static void early_ocd_write(struct console *con, const char *s, unsigned n)
 	}
 }
 
+static const struct console_operations ocd_ops = {
+	.write =	early_ocd_write,
+};
+
 static struct console early_ocd_console = {
 	.name =		"earlyocd",
-	.write =	early_ocd_write,
 	.flags =	CON_PRINTBUFFER,
+	.ops =		&ocd_ops,
 	.index =	-1,
+	.is_static =	1,
 };
 
 static int __init setup_early_printk(char *buf)
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 107283b1eb1e..790d0f4bcbb2 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -171,6 +171,7 @@ static inline bool efi_runtime_supported(void)
 }
 
 extern struct console early_efi_console;
+extern const struct console_operations early_efi_ops;
 extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 374a52fa5296..56034af5bc6c 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -70,11 +70,16 @@ static void early_vga_write(struct console *con, const char *str, unsigned n)
 	}
 }
 
+static const struct console_operations early_vga_ops = {
+	.write =	early_vga_write,
+};
+
 static struct console early_vga_console = {
 	.name =		"earlyvga",
-	.write =	early_vga_write,
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
+	.ops =		&early_vga_ops,
+	.is_static =	1,
 };
 
 /* Serial functions loosely based on a similar package from Klaus P. Gerlicher */
@@ -320,11 +325,16 @@ static __init void early_pci_serial_init(char *s)
 }
 #endif
 
+static const struct console_operations early_serial_ops = {
+	.write =	early_serial_write,
+};
+
 static struct console early_serial_console = {
 	.name =		"earlyser",
-	.write =	early_serial_write,
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
+	.ops =		&early_serial_ops,
+	.is_static =	1,
 };
 
 static void early_console_register(struct console *con, int keep_early)
diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 7138bc7a265c..d1d706ac026e 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -231,10 +231,15 @@ static __init int early_efi_setup(struct console *con, char *options)
 	return 0;
 }
 
-struct console early_efi_console = {
-	.name =		"earlyefi",
+static const struct console_operations early_efi_ops = {
 	.write =	early_efi_write,
 	.setup =	early_efi_setup,
+};
+
+struct console early_efi_console = {
+	.name =		"earlyefi",
 	.flags =	CON_PRINTBUFFER,
+	.ops =		&early_efi_ops,
 	.index =	-1,
+	.is_static =	1,
 };
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index af81a62faba6..cd2189f7aa35 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -236,13 +236,17 @@ static struct tty_driver* iss_console_device(struct console *c, int *index)
 	return serial_driver;
 }
 
+static const struct console_operations iss_ops = {
+	.write = iss_console_write,
+	.device = iss_console_device,
+};
 
 static struct console sercons = {
 	.name = "ttyS",
-	.write = iss_console_write,
-	.device = iss_console_device,
 	.flags = CON_PRINTBUFFER,
-	.index = -1
+	.ops = &iss_ops,
+	.index = -1,
+	.is_static = 1,
 };
 
 static int __init iss_console_init(void)
diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index dc34a5b8bcee..7fcc5c8a8c24 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -116,7 +116,7 @@ static void braille_write(u16 *buf)
 	*c++ = csum;
 	*c++ = ETX;
 
-	braille_co->write(braille_co, data, c - data);
+	braille_co->ops->write(braille_co, data, c - data);
 }
 
 /* Follow the VC cursor*/
@@ -367,8 +367,8 @@ int braille_register_console(struct console *console, int index,
 		console_options = "57600o8";
 	if (braille_co)
 		return -ENODEV;
-	if (console->setup) {
-		ret = console->setup(console, console_options);
+	if (console->ops->setup) {
+		ret = console->ops->setup(console, console_options);
 		if (ret != 0)
 			return ret;
 	}
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 5c8d780637bd..e09cb192a469 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -857,12 +857,12 @@ static void lp_console_write(struct console *co, const char *s,
 	parport_release(dev);
 }
 
-static struct console lpcons = {
-	.name		= "lp",
+static const struct console_operations lp_cons_ops = {
 	.write		= lp_console_write,
-	.flags		= CON_PRINTBUFFER,
 };
 
+static struct console *lpcons;
+
 #endif /* console on line printer */
 
 /* --- initialisation code ------------------------------------- */
@@ -921,6 +921,11 @@ static int lp_register(int nr, struct parport *port)
 						      &ppdev_cb, nr);
 	if (lp_table[nr].dev == NULL)
 		return 1;
+
+	lpcons = allocate_console_dfl(&lp_cons_ops, "lp", NULL);
+	if (!lpcons)
+		return -ENOMEM;
+
 	lp_table[nr].flags |= LP_EXIST;
 
 	if (reset)
@@ -935,7 +940,7 @@ static int lp_register(int nr, struct parport *port)
 #ifdef CONFIG_LP_CONSOLE
 	if (!nr) {
 		if (port->modes & PARPORT_MODE_SAFEININT) {
-			register_console(&lpcons);
+			register_console(lpcons);
 			console_registered = port;
 			printk(KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
 		} else
@@ -989,8 +994,9 @@ static void lp_detach(struct parport *port)
 	/* Write this some day. */
 #ifdef CONFIG_LP_CONSOLE
 	if (console_registered == port) {
-		unregister_console(&lpcons);
+		unregister_console(lpcons);
 		console_registered = NULL;
+		put_device(&lpcons->dev);
 	}
 #endif /* CONFIG_LP_CONSOLE */
 
@@ -1105,7 +1111,8 @@ static void lp_cleanup_module(void)
 	parport_unregister_driver(&lp_driver);
 
 #ifdef CONFIG_LP_CONSOLE
-	unregister_console(&lpcons);
+	unregister_console(lpcons);
+	put_device(&lpcons->dev);
 #endif
 
 	unregister_chrdev(LP_MAJOR, "lp");
diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index a00f65e21747..8271b1772f58 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -17,7 +17,7 @@ static void stm_console_unlink(struct stm_source_data *data);
 
 static struct stm_console {
 	struct stm_source_data	data;
-	struct console		console;
+	struct console		*console;
 } stm_console = {
 	.data	= {
 		.name		= "console",
@@ -30,20 +30,25 @@ static struct stm_console {
 static void
 stm_console_write(struct console *con, const char *buf, unsigned len)
 {
-	struct stm_console *sc = container_of(con, struct stm_console, console);
+	struct stm_console *sc = con->data;
 
 	stm_source_write(&sc->data, 0, buf, len);
 }
 
+static const struct console_operations stm_cons_ops = {
+	.write = stm_console_write,
+};
+
 static int stm_console_link(struct stm_source_data *data)
 {
 	struct stm_console *sc = container_of(data, struct stm_console, data);
 
-	strcpy(sc->console.name, "stm_console");
-	sc->console.write = stm_console_write;
-	sc->console.flags = CON_ENABLED | CON_PRINTBUFFER;
-	register_console(&sc->console);
+	sc->console = allocate_console_dfl(&stm_cons_ops, "stm_console", data);
+	if (!sc->console)
+		return -ENOMEM;
 
+	sc->console->flags |= CON_ENABLED;
+	register_console(sc->console);
 	return 0;
 }
 
@@ -51,7 +56,7 @@ static void stm_console_unlink(struct stm_source_data *data)
 {
 	struct stm_console *sc = container_of(data, struct stm_console, data);
 
-	unregister_console(&sc->console);
+	unregister_console(sc->console);
 }
 
 static int stm_console_init(void)
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f6851d..89219d09291b 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -729,15 +729,14 @@ static int pti_console_setup(struct console *c, char *opts)
  * the tty port is to hook up syslog to it, the tty port
  * will be open for a really long time.
  */
-static struct console pti_console = {
-	.name		= TTYNAME,
+static const struct console_operations pti_cons_ops = {
 	.write		= pti_console_write,
 	.device		= pti_console_device,
 	.setup		= pti_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= 0,
 };
 
+static struct console *pti_console;
+
 /**
  * pti_port_activate()- Used to start/initialize any items upon
  * first opening of tty_port().
@@ -755,7 +754,7 @@ static struct console pti_console = {
 static int pti_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	if (port->tty->index == PTITTY_MINOR_START)
-		console_start(&pti_console);
+		console_start(pti_console);
 	return 0;
 }
 
@@ -772,7 +771,7 @@ static int pti_port_activate(struct tty_port *port, struct tty_struct *tty)
 static void pti_port_shutdown(struct tty_port *port)
 {
 	if (port->tty->index == PTITTY_MINOR_START)
-		console_stop(&pti_console);
+		console_stop(pti_console);
 }
 
 static const struct tty_port_operations tty_port_ops = {
@@ -800,19 +799,23 @@ static int pti_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	unsigned int a;
-	int retval = -EINVAL;
+	int retval = -ENOMEM;
 	int pci_bar = 1;
 
 	dev_dbg(&pdev->dev, "%s %s(%d): PTI PCI ID %04x:%04x\n", __FILE__,
 			__func__, __LINE__, pdev->vendor, pdev->device);
 
+	pti_console = allocate_console_dfl(&pti_cons_ops, TTYNAME, NULL);
+	if (!pti_console)
+		goto err;
+
 	retval = misc_register(&pti_char_driver);
 	if (retval) {
 		pr_err("%s(%d): CHAR registration failed of pti driver\n",
 			__func__, __LINE__);
 		pr_err("%s(%d): Error value returned: %d\n",
 			__func__, __LINE__, retval);
-		goto err;
+		goto err_put_con;
 	}
 
 	retval = pci_enable_device(pdev);
@@ -859,7 +862,7 @@ static int pti_pci_probe(struct pci_dev *pdev,
 		tty_port_register_device(port, pti_tty_driver, a, &pdev->dev);
 	}
 
-	register_console(&pti_console);
+	register_console(pti_console);
 
 	return 0;
 err_rel_reg:
@@ -870,6 +873,8 @@ static int pti_pci_probe(struct pci_dev *pdev,
 	pci_disable_device(pdev);
 err_unreg_misc:
 	misc_deregister(&pti_char_driver);
+err_put_con:
+	put_device(&pti_console->dev);
 err:
 	return retval;
 }
@@ -884,7 +889,8 @@ static void pti_pci_remove(struct pci_dev *pdev)
 	struct pti_dev *drv_data = pci_get_drvdata(pdev);
 	unsigned int a;
 
-	unregister_console(&pti_console);
+	unregister_console(pti_console);
+	put_device(&pti_console->dev);
 
 	for (a = 0; a < PTITTY_MINOR_NUM; a++) {
 		tty_unregister_device(pti_tty_driver, a);
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index be9aa368639f..80e06ab6e5d2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -79,11 +79,7 @@ static LIST_HEAD(target_list);
 /* This needs to be a spinlock because write_msg() cannot sleep */
 static DEFINE_SPINLOCK(target_list_lock);
 
-/*
- * Console driver for extended netconsoles.  Registered on the first use to
- * avoid unnecessarily enabling ext message formatting.
- */
-static struct console netconsole_ext;
+static struct console *netconsole;
 
 /**
  * struct netconsole_target - Represents a configured netconsole target.
@@ -343,10 +339,8 @@ static ssize_t enabled_store(struct config_item *item,
 	}
 
 	if (enabled) {	/* true */
-		if (nt->extended && !(netconsole_ext.flags & CON_ENABLED)) {
-			netconsole_ext.flags |= CON_ENABLED;
-			register_console(&netconsole_ext);
-		}
+		if (nt->extended)
+			netconsole->flags |= CON_EXTENDED;
 
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
@@ -828,65 +822,51 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
-static void write_ext_msg(struct console *con, const char *msg,
-			  unsigned int len)
+static void send_msg_udp(struct netconsole_target *nt, const char *msg, int len)
 {
-	struct netconsole_target *nt;
-	unsigned long flags;
-
-	if ((oops_only && !oops_in_progress) || list_empty(&target_list))
-		return;
+	int frag, left;
+	const char *tmp;
 
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
-			send_ext_msg_udp(nt, msg, len);
-	spin_unlock_irqrestore(&target_list_lock, flags);
+	/* We nest this inside the caller's for-each loop
+	 * so that we're able to get as much logging out to
+	 * at least one target if we die inside here, instead
+	 * of unnecessarily keeping all targets in lock-step.
+	 */
+	tmp = msg;
+	for (left = len; left;) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		netpoll_send_udp(&nt->np, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
 }
 
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
+
 	/* Avoid taking lock and disabling interrupts unnecessarily */
 	if (list_empty(&target_list))
 		return;
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				netpoll_send_udp(&nt->np, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
-		}
+		if (!nt->enabled || !netif_running(nt->np.dev))
+			continue;
+
+		if (nt->extended)
+			send_ext_msg_udp(nt, msg, len);
+		else
+			send_msg_udp(nt, msg, len);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static struct console netconsole_ext = {
-	.name	= "netcon_ext",
-	.flags	= CON_EXTENDED,	/* starts disabled, registered on first use */
-	.write	= write_ext_msg,
-};
-
-static struct console netconsole = {
-	.name	= "netcon",
-	.flags	= CON_ENABLED,
+static const struct console_operations netconsole_ops = {
 	.write	= write_msg,
 };
 
@@ -897,6 +877,7 @@ static int __init init_netconsole(void)
 	unsigned long flags;
 	char *target_config;
 	char *input = config;
+	short con_flags = CON_ENABLED | CON_PRINTBUFFER;
 
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
@@ -905,12 +886,8 @@ static int __init init_netconsole(void)
 				err = PTR_ERR(nt);
 				goto fail;
 			}
-			/* Dump existing printks when we register */
 			if (nt->extended)
-				netconsole_ext.flags |= CON_PRINTBUFFER |
-							CON_ENABLED;
-			else
-				netconsole.flags |= CON_PRINTBUFFER;
+				con_flags |= CON_EXTENDED;
 
 			spin_lock_irqsave(&target_list_lock, flags);
 			list_add(&nt->list, &target_list);
@@ -918,6 +895,14 @@ static int __init init_netconsole(void)
 		}
 	}
 
+	netconsole = allocate_console_dfl(&netconsole_ops, "netcon", NULL);
+	if (!netconsole) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	netconsole->flags = con_flags;
+
 	err = register_netdevice_notifier(&netconsole_netdev_notifier);
 	if (err)
 		goto fail;
@@ -926,11 +911,8 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (netconsole_ext.flags & CON_ENABLED)
-		register_console(&netconsole_ext);
-	register_console(&netconsole);
+	register_console(netconsole);
 	pr_info("network logging started\n");
-
 	return err;
 
 undonotifier:
@@ -956,8 +938,7 @@ static void __exit cleanup_netconsole(void)
 {
 	struct netconsole_target *nt, *tmp;
 
-	unregister_console(&netconsole_ext);
-	unregister_console(&netconsole);
+	unregister_console(netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 
@@ -973,6 +954,8 @@ static void __exit cleanup_netconsole(void)
 		list_del(&nt->list);
 		free_param_target(nt);
 	}
+
+	put_console(netconsole);
 }
 
 /*
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 8c9d412b6d33..1d04fef525f7 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -887,11 +887,9 @@ static struct notifier_block on_reboot_nb = {
 /*
  *  The console structure for the 3215 console
  */
-static struct console con3215 = {
-	.name	 = "ttyS",
+static const struct console_operations con3215_cons_ops = {
 	.write	 = con3215_write,
 	.device	 = con3215_device,
-	.flags	 = CON_PRINTBUFFER,
 };
 
 /*
@@ -902,6 +900,7 @@ static int __init con3215_init(void)
 	struct ccw_device *cdev;
 	struct raw3215_info *raw;
 	struct raw3215_req *req;
+	struct console *con3215;
 	int i;
 
 	/* Check if 3215 is to be the console */
@@ -925,6 +924,10 @@ static int __init con3215_init(void)
 		raw3215_freelist = req;
 	}
 
+	con3215 = allocate_console_dfl(&con3215_cons_ops, "ttyS", NULL);
+	if (!con3215)
+		return -ENOMEM;
+
 	cdev = ccw_device_create_console(&raw3215_ccw_driver);
 	if (IS_ERR(cdev))
 		return -ENODEV;
@@ -950,7 +953,7 @@ static int __init con3215_init(void)
 	}
 	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 	register_reboot_notifier(&on_reboot_nb);
-	register_console(&con3215);
+	register_console(con3215);
 	return 0;
 }
 console_initcall(con3215_init);
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index fd2146bcc0ad..4871be8568f1 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -580,11 +580,10 @@ static struct notifier_block on_reboot_nb = {
 /*
  *  The console structure for the 3270 console
  */
-static struct console con3270 = {
-	.name	 = "tty3270",
+
+static const struct console_operations con3270_cons_ops = {
 	.write	 = con3270_write,
 	.device	 = con3270_device,
-	.flags	 = CON_PRINTBUFFER,
 };
 
 /*
@@ -593,6 +592,7 @@ static struct console con3270 = {
 static int __init
 con3270_init(void)
 {
+	struct console *con3270;
 	struct raw3270 *rp;
 	void *cbuf;
 	int i;
@@ -607,6 +607,10 @@ con3270_init(void)
 		cpcmd("TERM AUTOCR OFF", NULL, 0, NULL);
 	}
 
+	con3270 = allocate_console_dfl(&con3270_cons_ops, "tty3270", NULL);
+	if (!con3270)
+		return -ENOMEM;
+
 	rp = raw3270_setup_console();
 	if (IS_ERR(rp))
 		return PTR_ERR(rp);
@@ -642,7 +646,7 @@ con3270_init(void)
 	condev->input = alloc_string(&condev->freemem, 80);
 	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 	register_reboot_notifier(&on_reboot_nb);
-	register_console(&con3270);
+	register_console(con3270);
 	return 0;
 }
 
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index 8966a1c1b548..b837089f52c5 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -281,15 +281,12 @@ static struct notifier_block on_reboot_nb = {
  * used to register the SCLP console to the kernel and to
  * give printk necessary information
  */
-static struct console sclp_console =
-{
-	.name = sclp_console_name,
+static const struct console_operations sclp_cons_ops = {
 	.write = sclp_console_write,
 	.device = sclp_console_device,
-	.flags = CON_PRINTBUFFER,
-	.index = 0 /* ttyS0 */
 };
 
+
 /*
  * This function is called for SCLP suspend and resume events.
  */
@@ -312,6 +309,7 @@ void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event)
 static int __init
 sclp_console_init(void)
 {
+	struct console *sclp_console;
 	void *page;
 	int i;
 	int rc;
@@ -319,9 +317,16 @@ sclp_console_init(void)
 	/* SCLP consoles are handled together */
 	if (!(CONSOLE_IS_SCLP || CONSOLE_IS_VT220))
 		return 0;
+
 	rc = sclp_rw_init();
 	if (rc)
 		return rc;
+
+	sclp_console = allocate_console_dfl(&sclp_cons_ops, sclp_console_name,
+					    NULL);
+	if (!sclp_console)
+		return -ENOMEM;
+
 	/* Allocate pages for output buffering */
 	INIT_LIST_HEAD(&sclp_con_pages);
 	for (i = 0; i < sclp_console_pages; i++) {
@@ -347,7 +352,7 @@ sclp_console_init(void)
 	/* enable printk-access to this driver */
 	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 	register_reboot_notifier(&on_reboot_nb);
-	register_console(&sclp_console);
+	register_console(sclp_console);
 	return 0;
 }
 
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 3f9a6ef650fa..adbaeefbd05f 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -869,27 +869,33 @@ static struct notifier_block on_reboot_nb = {
 };
 
 /* Structure needed to register with printk */
-static struct console sclp_vt220_console =
-{
-	.name = SCLP_VT220_CONSOLE_NAME,
+static const struct console_operations sclp_vt220_cons_ops = {
 	.write = sclp_vt220_con_write,
 	.device = sclp_vt220_con_device,
-	.flags = CON_PRINTBUFFER,
-	.index = SCLP_VT220_CONSOLE_INDEX
 };
 
 static int __init
 sclp_vt220_con_init(void)
 {
+	struct console *sclp_vt220_console;
 	int rc;
 
+	sclp_vt220_console = allocate_console_dfl(&sclp_vt220_cons_ops,
+						  SCLP_VT220_CONSOLE_NAME,
+						  NULL);
+	if (!sclp_vt220_console)
+		return -ENOMEM;
+
+	sclp_vt220_console->index = SCLP_VT220_CONSOLE_INDEX;
+
 	rc = __sclp_vt220_init(sclp_console_pages);
 	if (rc)
 		return rc;
+
 	/* Attach linux console */
 	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 	register_reboot_notifier(&on_reboot_nb);
-	register_console(&sclp_vt220_console);
+	register_console(sclp_vt220_console);
 	return 0;
 }
 
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 8330fd809a05..3c7f29da0163 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1779,12 +1779,9 @@ static struct tty_driver *serial_console_device(struct console *c, int *index)
 	return serial_driver;
 }
 
-static struct console sercons = {
-	.name =		"ttyS",
+static const struct console_operations ami_cons_ops = {
 	.write =	serial_console_write,
 	.device =	serial_console_device,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
 };
 
 /*
@@ -1792,10 +1789,16 @@ static struct console sercons = {
  */
 static int __init amiserial_console_init(void)
 {
+	struct console *sercons;
+
 	if (!MACH_IS_AMIGA)
 		return -ENODEV;
 
-	register_console(&sercons);
+	sercons = allocate_console_dfl(&ami_cons_ops, "ttyS", NULL);
+	if (!sercons)
+		return -ENOMEM;
+
+	register_console(sercons);
 	return 0;
 }
 console_initcall(amiserial_console_init);
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 769e0a5d1dfc..4d45dac7f6c5 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -277,13 +277,13 @@ static struct tty_driver *ehv_bc_console_device(struct console *co, int *index)
 	return ehv_bc_driver;
 }
 
-static struct console ehv_bc_console = {
-	.name		= "ttyEHV",
+static const struct console_operations ehv_bc_cons_ops = {
 	.write		= ehv_bc_console_write,
 	.device		= ehv_bc_console_device,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
 };
 
+static struct console *ehv_bc_console;
+
 /*
  * Console initialization
  *
@@ -308,12 +308,19 @@ static int __init ehv_bc_console_init(void)
 			CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE);
 #endif
 
+	ehv_bc_console = allocate_console_dfl(&ehv_bc_cons_ops, "ttyEHV", NULL);
+	if (!ehv_bc_console)
+		return -ENOMEM;
+
+	ehv_bc_console->flags |= CON_ENABLED;
+
 	/* add_preferred_console() must be called before register_console(),
 	   otherwise it won't work.  However, we don't want to enumerate all the
 	   byte channels here, either, since we only care about one. */
 
-	add_preferred_console(ehv_bc_console.name, ehv_bc_console.index, NULL);
-	register_console(&ehv_bc_console);
+	add_preferred_console(ehv_bc_console->name, ehv_bc_console->index,
+			      NULL);
+	register_console(ehv_bc_console);
 
 	pr_info("ehv-bc: registered console driver for byte channel %u\n",
 		stdout_bc);
@@ -765,7 +772,7 @@ static int __init ehv_bc_init(void)
 	}
 
 	ehv_bc_driver->driver_name = "ehv-bc";
-	ehv_bc_driver->name = ehv_bc_console.name;
+	ehv_bc_driver->name = ehv_bc_console->name;
 	ehv_bc_driver->type = TTY_DRIVER_TYPE_CONSOLE;
 	ehv_bc_driver->subtype = SYSTEM_TYPE_CONSOLE;
 	ehv_bc_driver->init_termios = tty_std_termios;
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c8c5cdfc5e19..49ce7f5a8542 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -39,7 +39,7 @@ struct goldfish_tty {
 	void __iomem *base;
 	u32 irq;
 	int opencount;
-	struct console console;
+	struct console *console;
 	u32 version;
 	struct device *dev;
 };
@@ -241,6 +241,12 @@ static const struct tty_operations goldfish_tty_ops = {
 	.chars_in_buffer = goldfish_tty_chars_in_buffer,
 };
 
+static const struct console_operations goldfish_cons_ops = {
+	.write = goldfish_tty_console_write,
+	.device = goldfish_tty_console_device,
+	.setup = goldfish_tty_console_setup,
+};
+
 static int goldfish_tty_create_driver(void)
 {
 	int ret;
@@ -392,18 +398,19 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 		goto err_tty_register_device_failed;
 	}
 
-	strcpy(qtty->console.name, "ttyGF");
-	qtty->console.write = goldfish_tty_console_write;
-	qtty->console.device = goldfish_tty_console_device;
-	qtty->console.setup = goldfish_tty_console_setup;
-	qtty->console.flags = CON_PRINTBUFFER;
-	qtty->console.index = line;
-	register_console(&qtty->console);
+	qtty->console = allocate_console_dfl(&goldfish_cons_ops, "ttyGF", NULL);
+	if (!qtty->console)
+		goto err_alloc_console_failed;
+
+	qtty->console->index = line;
+	register_console(qtty->console);
 	platform_set_drvdata(pdev, qtty);
 
 	mutex_unlock(&goldfish_tty_lock);
 	return 0;
 
+err_alloc_console_failed:
+	tty_unregister_device(goldfish_tty_driver, line);
 err_tty_register_device_failed:
 	free_irq(irq, qtty);
 err_dec_line_count:
@@ -423,8 +430,9 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 
 	mutex_lock(&goldfish_tty_lock);
 
-	unregister_console(&qtty->console);
-	tty_unregister_device(goldfish_tty_driver, qtty->console.index);
+	unregister_console(qtty->console);
+	put_device(&qtty->console->dev);
+	tty_unregister_device(goldfish_tty_driver, qtty->console->index);
 	iounmap(qtty->base);
 	qtty->base = NULL;
 	free_irq(qtty->irq, pdev);
@@ -448,13 +456,17 @@ static void gf_early_write(struct console *con, const char *s, unsigned int n)
 	uart_console_write(&dev->port, s, n, gf_early_console_putchar);
 }
 
+static const struct console_operations goldfish_early_cons_ops = {
+	.write = gf_early_write,
+};
+
 static int __init gf_earlycon_setup(struct earlycon_device *device,
 				    const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = gf_early_write;
+	device->con->ops = &goldfish_early_cons_ops;
 	return 0;
 }
 
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 27284a2dcd2b..a9efffc461eb 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -214,13 +214,17 @@ static int hvc_console_setup(struct console *co, char *options)
 	return 0;
 }
 
-static struct console hvc_console = {
-	.name		= "hvc",
+static const struct console_operations hvc_console_ops = {
 	.write		= hvc_console_print,
 	.device		= hvc_console_device,
 	.setup		= hvc_console_setup,
+};
+
+static struct console hvc_console = {
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
+	.ops		= &hvc_console_ops,
+	.is_static	= 1,
 };
 
 /*
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index dc43fa96c3de..ce14942b340d 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -644,12 +644,17 @@ static void xenboot_write_console(struct console *console, const char *string,
 		domU_write_console(0, string+off, len-off);
 }
 
-struct console xenboot_console = {
-	.name		= "xenboot",
+static const struct console_operations xenboot_cons_ops = {
 	.write		= xenboot_write_console,
 	.setup		= xenboot_setup_console,
+};
+
+struct console xenboot_console = {
+	.name		= "xenboot",
+	.ops		= &xenboot_cons_ops,
 	.flags		= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index		= -1,
+	.is_static	= 1,
 };
 #endif	/* CONFIG_EARLY_PRINTK */
 
@@ -685,10 +690,14 @@ static void xenboot_earlycon_write(struct console *console,
 	dom0_write_console(0, string, len);
 }
 
+static const struct console_operations xenboot_early_cons_ops = {
+	.write = xenboot_earlycon_write,
+};
+
 static int __init xenboot_earlycon_setup(struct earlycon_device *device,
 					    const char *opt)
 {
-	device->con->write = xenboot_earlycon_write;
+	device->con->ops = &xenboot_early_cons_ops;
 	return 0;
 }
 EARLYCON_DECLARE(xenboot, xenboot_earlycon_setup);
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 66f95f758be0..f6bba2d97490 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1151,21 +1151,23 @@ static int __init hvsi_console_setup(struct console *console, char *options)
 	return 0;
 }
 
-static struct console hvsi_console = {
-	.name		= "hvsi",
+static const struct console_operations hvsi_cons_ops = {
 	.write		= hvsi_console_print,
 	.device		= hvsi_console_device,
 	.setup		= hvsi_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 };
 
 static int __init hvsi_console_init(void)
 {
+	struct console *hvsi_console;
 	struct device_node *vty;
 
 	hvsi_wait = poll_for_state; /* no irqs yet; must poll */
 
+	hvsi_console = allocate_console_dfl(&hvsi_cons_ops, "hvsi", NULL);
+	if (!hvsi_console)
+		return -ENOMEM;
+
 	/* search device tree for vty nodes */
 	for_each_compatible_node(vty, "serial", "hvterm-protocol") {
 		struct hvsi_struct *hp;
@@ -1204,7 +1206,9 @@ static int __init hvsi_console_init(void)
 	}
 
 	if (hvsi_count)
-		register_console(&hvsi_console);
+		register_console(hvsi_console);
+
+	put_console(hvsi_console);
 	return 0;
 }
 console_initcall(hvsi_console_init);
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 4c1cd49ae95b..283686d53d4c 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -289,7 +289,7 @@ static unsigned int mips_ejtag_fdc_decode(u32 word, char *buf)
  * @regs:		Registers base address for each CPU.
  */
 struct mips_ejtag_fdc_console {
-	struct console		 cons;
+	struct console		*cons;
 	struct tty_driver	*tty_drv;
 	raw_spinlock_t		 lock;
 	bool			 initialised;
@@ -300,8 +300,7 @@ struct mips_ejtag_fdc_console {
 static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
 					 unsigned int count)
 {
-	struct mips_ejtag_fdc_console *cons =
-		container_of(c, struct mips_ejtag_fdc_console, cons);
+	struct mips_ejtag_fdc_console *cons = c->data;
 	void __iomem *regs;
 	struct fdc_word word;
 	unsigned long flags;
@@ -355,13 +354,17 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
 static struct tty_driver *mips_ejtag_fdc_console_device(struct console *c,
 							int *index)
 {
-	struct mips_ejtag_fdc_console *cons =
-		container_of(c, struct mips_ejtag_fdc_console, cons);
+	struct mips_ejtag_fdc_console *cons = c->data;
 
 	*index = c->index;
 	return cons->tty_drv;
 }
 
+static const struct console_operations fdc_cons_ops = {
+	.write	= mips_ejtag_fdc_console_write,
+	.device	= mips_ejtag_fdc_console_device,
+};
+
 /* Initialise an FDC console (early or normal */
 static int __init mips_ejtag_fdc_console_init(struct mips_ejtag_fdc_console *c)
 {
@@ -382,20 +385,13 @@ static int __init mips_ejtag_fdc_console_init(struct mips_ejtag_fdc_console *c)
 
 	c->initialised = true;
 	c->regs[smp_processor_id()] = regs;
-	register_console(&c->cons);
+	register_console(c->cons);
 out:
 	raw_spin_unlock_irqrestore(&c->lock, flags);
 	return ret;
 }
 
 static struct mips_ejtag_fdc_console mips_ejtag_fdc_con = {
-	.cons	= {
-		.name	= "fdc",
-		.write	= mips_ejtag_fdc_console_write,
-		.device	= mips_ejtag_fdc_console_device,
-		.flags	= CON_PRINTBUFFER,
-		.index	= -1,
-	},
 	.lock	= __RAW_SPIN_LOCK_UNLOCKED(mips_ejtag_fdc_con.lock),
 };
 
@@ -590,7 +586,7 @@ static void mips_ejtag_fdc_handle(struct mips_ejtag_fdc_tty *priv)
 			}
 #endif
 			/* Support Ctrl+O for console channel */
-			if (channel == mips_ejtag_fdc_con.cons.index) {
+			if (channel == mips_ejtag_fdc_con.cons->index) {
 				if (buf[i] == '\x0f') {	/* ^O */
 					priv->sysrq_pressed =
 						!priv->sysrq_pressed;
@@ -1125,18 +1121,26 @@ builtin_mips_cdmm_driver(mips_ejtag_fdc_tty_driver);
 
 static int __init mips_ejtag_fdc_init_console(void)
 {
+	mips_ejtag_fdc_con.cons = allocate_console_dfl(&fdc_cons_ops, "fdc", c);
 	return mips_ejtag_fdc_console_init(&mips_ejtag_fdc_con);
 }
 console_initcall(mips_ejtag_fdc_init_console);
 
 #ifdef CONFIG_MIPS_EJTAG_FDC_EARLYCON
+static const struct console_operations early_fdc_cons_ops = {
+	.write  = mips_ejtag_fdc_console_write,
+};
+
+static struct console early_fdc_console = {
+	.name	= "early_fdc",
+	.ops	= &early_fdc_cons_ops,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= CONSOLE_CHANNEL,
+	.is_static = 1,
+};
+
 static struct mips_ejtag_fdc_console mips_ejtag_fdc_earlycon = {
-	.cons	= {
-		.name	= "early_fdc",
-		.write	= mips_ejtag_fdc_console_write,
-		.flags	= CON_PRINTBUFFER | CON_BOOT,
-		.index	= CONSOLE_CHANNEL,
-	},
+	.cons	= &early_fdc_console,
 	.lock	= __RAW_SPIN_LOCK_UNLOCKED(mips_ejtag_fdc_earlycon.lock),
 };
 
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf8150a..6e3fbc8cd562 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -444,28 +444,28 @@ static int __init serial21285_console_setup(struct console *co, char *options)
 
 static struct uart_driver serial21285_reg;
 
-static struct console serial21285_console =
-{
-	.name		= SERIAL_21285_NAME,
+static const struct console_operations serial2125_cons_ops = {
 	.write		= serial21285_console_write,
 	.device		= uart_console_device,
 	.setup		= serial21285_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial21285_reg,
 };
 
+static struct console __initdata *serial21285_console;
+
 static int __init rs285_console_init(void)
 {
+	serial21285_console = allocate_console_dfl(&serial2125_cons_ops,
+						   SERIAL_21285_NAME,
+						   &serial21285_reg);
+	if (!serial21285_console)
+		return -ENOMEM;
+
 	serial21285_setup_ports();
-	register_console(&serial21285_console);
+	register_console(serial21285_console);
 	return 0;
 }
 console_initcall(rs285_console_init);
 
-#define SERIAL_21285_CONSOLE	&serial21285_console
-#else
-#define SERIAL_21285_CONSOLE	NULL
 #endif
 
 static struct uart_driver serial21285_reg = {
@@ -475,7 +475,6 @@ static struct uart_driver serial21285_reg = {
 	.major			= SERIAL_21285_MAJOR,
 	.minor			= SERIAL_21285_MINOR,
 	.nr			= 1,
-	.cons			= SERIAL_21285_CONSOLE,
 };
 
 static int __init serial21285_init(void)
@@ -487,8 +486,10 @@ static int __init serial21285_init(void)
 	serial21285_setup_ports();
 
 	ret = uart_register_driver(&serial21285_reg);
-	if (ret == 0)
+	if (ret == 0) {
 		uart_add_one_port(&serial21285_reg, &serial21285_port);
+		serial21285_reg.cons = serial21285_console;
+	}
 
 	return ret;
 }
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221e04b9..696c80f49878 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -661,29 +661,33 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 	return -ENODEV;
 }
 
-static struct console univ8250_console = {
-	.name		= "ttyS",
+static const struct console_operations univ8250_console_ops = {
 	.write		= univ8250_console_write,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
-	.index		= -1,
-	.data		= &serial8250_reg,
 };
 
+static struct console __initdata *univ8250_console;
+
 static int __init univ8250_console_init(void)
 {
 	if (nr_uarts == 0)
 		return -ENODEV;
 
+	univ8250_console = allocate_console_dfl(&univ8250_console_ops, "ttyS",
+						&serial8250_reg);
+	if (!univ8250_console)
+		return -ENOMEM;
+
+	univ8250_console->flags |= CON_ANYTIME;
 	serial8250_isa_init_ports();
-	register_console(&univ8250_console);
+	register_console(univ8250_console);
 	return 0;
 }
 console_initcall(univ8250_console_init);
 
-#define SERIAL8250_CONSOLE	(&univ8250_console)
+#define SERIAL8250_CONSOLE	(univ8250_console)
 #else
 #define SERIAL8250_CONSOLE	NULL
 #endif
@@ -694,7 +698,6 @@ static struct uart_driver serial8250_reg = {
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
-	.cons			= SERIAL8250_CONSOLE,
 };
 
 /*
@@ -1136,6 +1139,8 @@ static int __init serial8250_init(void)
 	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
 		nr_uarts, share_irqs ? "en" : "dis");
 
+	serial8250_reg.cons = SERIAL8250_CONSOLE;
+
 #ifdef CONFIG_SPARC
 	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
 #else
@@ -1178,6 +1183,7 @@ static int __init serial8250_init(void)
 	uart_unregister_driver(&serial8250_reg);
 #endif
 out:
+	put_console(SERIAL8250_CONSOLE);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..cffffca9c49e 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -132,6 +132,10 @@ static void __init init_port(struct earlycon_device *device)
 	}
 }
 
+static struct console_operations early_serial8250_ops = {
+	.write = early_serial8250_write,
+};
+
 int __init early_serial8250_setup(struct earlycon_device *device,
 					 const char *options)
 {
@@ -148,7 +152,7 @@ int __init early_serial8250_setup(struct earlycon_device *device,
 	} else
 		init_port(device);
 
-	device->con->write = early_serial8250_write;
+	device->con->ops = &early_serial8250_ops;
 	return 0;
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
@@ -160,6 +164,10 @@ OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
 
 #ifdef CONFIG_SERIAL_8250_OMAP
 
+static const struct console_operations early_omap8250_cons_ops = {
+	.write = early_serial8250_write,
+};
+
 static int __init early_omap8250_setup(struct earlycon_device *device,
 				       const char *options)
 {
@@ -169,7 +177,7 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	port->regshift = 2;
-	device->con->write = early_serial8250_write;
+	device->con->ops = &early_omap8250_cons_ops;
 	return 0;
 }
 
@@ -184,12 +192,16 @@ OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
 unsigned int au_serial_in(struct uart_port *p, int offset);
 void au_serial_out(struct uart_port *p, int offset, int value);
 
+static const struct console_operations early_serial8250_cons_ops = {
+	.write = early_serial8250_write,
+};
+
 static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
 {
 	dev->port.serial_in = au_serial_in;
 	dev->port.serial_out = au_serial_out;
 	dev->port.iotype = UPIO_AU;
-	dev->con->write = early_serial8250_write;
+	dev->con->ops = &early_serial8250_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8dfa92b..9795ae0da711 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -87,6 +87,10 @@ static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev
 	dev->port.uartclk = be32_to_cpup(prop);
 }
 
+static struct console_operations ingenic_early_cons_ops = {
+	.write = ingenic_early_console_write,
+};
+
 static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 					      const char *opt)
 {
@@ -124,7 +128,7 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 	early_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	early_device = dev;
-	dev->con->write = ingenic_early_console_write;
+	dev->con->ops = &ingenic_early_cons_ops;
 
 	return 0;
 }
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c90e503d6b57..9222427cd761 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -359,26 +359,28 @@ static int __init altera_jtaguart_console_setup(struct console *co,
 
 static struct uart_driver altera_jtaguart_driver;
 
-static struct console altera_jtaguart_console = {
-	.name	= "ttyJ",
+static const struct console_operations jtaguart_cons_ops = {
 	.write	= altera_jtaguart_console_write,
 	.device	= uart_console_device,
 	.setup	= altera_jtaguart_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &altera_jtaguart_driver,
 };
 
+static struct console __initdata *altera_jtaguart_console;
+
 static int __init altera_jtaguart_console_init(void)
 {
-	register_console(&altera_jtaguart_console);
+	altera_jtaguart_console = allocate_console_dfl(&jtaguart_cons_ops,
+						       "ttyJ",
+						       &altera_jtaguart_driver);
+	if (!altera_jtaguart_console)
+		return -ENOMEM;
+
+	register_console(altera_jtaguart_console);
 	return 0;
 }
 
 console_initcall(altera_jtaguart_console_init);
 
-#define	ALTERA_JTAGUART_CONSOLE	(&altera_jtaguart_console)
-
 static void altera_jtaguart_earlycon_write(struct console *co, const char *s,
 					   unsigned int count)
 {
@@ -387,22 +389,25 @@ static void altera_jtaguart_earlycon_write(struct console *co, const char *s,
 	uart_console_write(&dev->port, s, count, altera_jtaguart_console_putc);
 }
 
+static const struct console_operations jtaguart_earlycon_con_ops = {
+	.write = altera_jtaguart_earlycon_write,
+};
+
 static int __init altera_jtaguart_earlycon_setup(struct earlycon_device *dev,
 						 const char *options)
 {
 	if (!dev->port.membase)
 		return -ENODEV;
 
-	dev->con->write = altera_jtaguart_earlycon_write;
+	dev->con->ops = &jtaguart_earlycon_con_ops;
 	return 0;
 }
 
 OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
 
+#define ALTERA_JTAGUART_CONSOLE (altera_jtaguart_console)
 #else
-
-#define	ALTERA_JTAGUART_CONSOLE	NULL
-
+#define ALTERA_JTAGUART_CONSOLE NULL
 #endif /* CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE */
 
 static struct uart_driver altera_jtaguart_driver = {
@@ -412,7 +417,6 @@ static struct uart_driver altera_jtaguart_driver = {
 	.major		= ALTERA_JTAGUART_MAJOR,
 	.minor		= ALTERA_JTAGUART_MINOR,
 	.nr		= ALTERA_JTAGUART_MAXPORTS,
-	.cons		= ALTERA_JTAGUART_CONSOLE,
 };
 
 static int altera_jtaguart_probe(struct platform_device *pdev)
@@ -501,12 +505,15 @@ static int __init altera_jtaguart_init(void)
 {
 	int rc;
 
+	altera_jtaguart_driver.cons = ALTERA_JTAGUART_CONSOLE;
 	rc = uart_register_driver(&altera_jtaguart_driver);
 	if (rc)
 		return rc;
+
 	rc = platform_driver_register(&altera_jtaguart_platform_driver);
 	if (rc)
 		uart_unregister_driver(&altera_jtaguart_driver);
+
 	return rc;
 }
 
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 0e487ce091ac..6e0a7b6af214 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -479,25 +479,28 @@ static int __init altera_uart_console_setup(struct console *co, char *options)
 
 static struct uart_driver altera_uart_driver;
 
-static struct console altera_uart_console = {
-	.name	= "ttyAL",
+static const struct console_operations altera_cons_ops = {
 	.write	= altera_uart_console_write,
 	.device	= uart_console_device,
 	.setup	= altera_uart_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &altera_uart_driver,
 };
 
+static struct console __initdata *altera_uart_console;
+
 static int __init altera_uart_console_init(void)
 {
-	register_console(&altera_uart_console);
+	altera_uart_console = allocate_console_dfl(&altera_cons_ops, "ttyAL",
+						   &altera_uart_driver);
+	if (!altera_uart_console)
+		return -ENOMEM;
+
+	register_console(altera_uart_console);
 	return 0;
 }
 
 console_initcall(altera_uart_console_init);
 
-#define	ALTERA_UART_CONSOLE	(&altera_uart_console)
+#define	ALTERA_UART_CONSOLE	(altera_uart_console)
 
 static void altera_uart_earlycon_write(struct console *co, const char *s,
 				       unsigned int count)
@@ -507,6 +510,10 @@ static void altera_uart_earlycon_write(struct console *co, const char *s,
 	uart_console_write(&dev->port, s, count, altera_uart_console_putc);
 }
 
+static const struct console_operations altera_early_cons_ops = {
+	.write = altera_uart_earlycon_write,
+};
+
 static int __init altera_uart_earlycon_setup(struct earlycon_device *dev,
 					     const char *options)
 {
@@ -525,7 +532,7 @@ static int __init altera_uart_earlycon_setup(struct earlycon_device *dev,
 		altera_uart_writel(port, baudclk, ALTERA_UART_DIVISOR_REG);
 	}
 
-	dev->con->write = altera_uart_earlycon_write;
+	dev->con->ops = &altera_early_cons_ops;
 	return 0;
 }
 
@@ -547,7 +554,6 @@ static struct uart_driver altera_uart_driver = {
 	.major		= SERIAL_ALTERA_MAJOR,
 	.minor		= SERIAL_ALTERA_MINOR,
 	.nr		= CONFIG_SERIAL_ALTERA_UART_MAXPORTS,
-	.cons		= ALTERA_UART_CONSOLE,
 };
 
 static int altera_uart_probe(struct platform_device *pdev)
@@ -653,6 +659,7 @@ static int __init altera_uart_init(void)
 {
 	int rc;
 
+	altera_uart_driver.cons	= ALTERA_UART_CONSOLE;
 	rc = uart_register_driver(&altera_uart_driver);
 	if (rc)
 		return rc;
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11726ab..22283935dee9 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -668,20 +668,14 @@ static int __init pl010_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver amba_reg;
-static struct console amba_console = {
-	.name		= "ttyAM",
+static const struct console_operations amba_cons_ops = {
 	.write		= pl010_console_write,
 	.device		= uart_console_device,
 	.setup		= pl010_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &amba_reg,
 };
 
-#define AMBA_CONSOLE	&amba_console
 #else
-#define AMBA_CONSOLE	NULL
+static const struct console_operations amba_cons_ops;
 #endif
 
 static DEFINE_MUTEX(amba_reg_lock);
@@ -692,7 +686,6 @@ static struct uart_driver amba_reg = {
 	.major			= SERIAL_AMBA_MAJOR,
 	.minor			= SERIAL_AMBA_MINOR,
 	.nr			= UART_NR,
-	.cons			= AMBA_CONSOLE,
 };
 
 static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
@@ -740,20 +733,36 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 
 	mutex_lock(&amba_reg_lock);
 	if (!amba_reg.state) {
+		ret = uart_allocate_console_dfl(&amba_reg, &amba_cons_ops,
+						"ttyAM",
+						SERIAL_AMBA_PL010_CONSOLE);
+		if (ret < 0) {
+			mutex_unlock(&amba_reg_lock);
+			goto out;
+		}
+
 		ret = uart_register_driver(&amba_reg);
 		if (ret < 0) {
 			mutex_unlock(&amba_reg_lock);
-			dev_err(uap->port.dev,
-				"Failed to register AMBA-PL010 driver\n");
-			return ret;
+			goto out;
 		}
 	}
 	mutex_unlock(&amba_reg_lock);
 
 	ret = uart_add_one_port(&amba_reg, &uap->port);
 	if (ret)
-		amba_ports[i] = NULL;
+		goto out_unregister;
+
+	return 0;
+
+out_unregister:
+	uart_unregister_driver(&amba_reg);
+out:
+	amba_ports[i] = NULL;
+	uart_put_console(&amba_reg);
+	kfree(uap);
 
+	pr_err("Failed to register AMBA-PL010 driver\n");
 	return ret;
 }
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade213a1a9..859dde8ba1de 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2400,19 +2400,14 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 }
 
 static struct uart_driver amba_reg;
-static struct console amba_console = {
-	.name		= "ttyAMA",
+
+static const struct console_operations amba_cons_ops = {
 	.write		= pl011_console_write,
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
 	.match		= pl011_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
-	.index		= -1,
-	.data		= &amba_reg,
 };
 
-#define AMBA_CONSOLE	(&amba_console)
-
 static void qdf2400_e44_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2429,6 +2424,10 @@ static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned
 	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
 }
 
+static const struct console_operations qdf2400_early_cons_ops = {
+	.write = qdf2400_e44_early_write,
+};
+
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2448,6 +2447,10 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+static const struct console_operations pl011_early_cons_ops = {
+	.write = pl011_early_write,
+};
+
 /*
  * On non-ACPI systems, earlycon is enabled by specifying
  * "earlycon=pl011,<address>" on the kernel command line.
@@ -2466,8 +2469,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = pl011_early_write;
-
+	device->con->ops = &pl011_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
@@ -2490,13 +2492,13 @@ qdf2400_e44_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = qdf2400_e44_early_write;
+	device->con->ops = &qdf2400_early_cons_ops;
 	return 0;
 }
 EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
 
 #else
-#define AMBA_CONSOLE	NULL
+static const struct console_operations amba_cons_ops;
 #endif
 
 static struct uart_driver amba_reg = {
@@ -2506,7 +2508,6 @@ static struct uart_driver amba_reg = {
 	.major			= SERIAL_AMBA_MAJOR,
 	.minor			= SERIAL_AMBA_MINOR,
 	.nr			= UART_NR,
-	.cons			= AMBA_CONSOLE,
 };
 
 static int pl011_probe_dt_alias(int index, struct device *dev)
@@ -2602,18 +2603,28 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	pl011_write(0xffff, uap, REG_ICR);
 
 	if (!amba_reg.state) {
+		ret = uart_allocate_console(&amba_reg, &amba_cons_ops, "ttyAMA",
+					    CON_PRINTBUFFER | CON_ANYTIME, -1,
+					    SERIAL_AMBA_PL011_CONSOLE);
+		if (ret < 0)
+			goto out;
+
 		ret = uart_register_driver(&amba_reg);
-		if (ret < 0) {
-			dev_err(uap->port.dev,
-				"Failed to register AMBA-PL011 driver\n");
-			return ret;
-		}
+		if (ret < 0)
+			goto out;
 	}
 
 	ret = uart_add_one_port(&amba_reg, &uap->port);
 	if (ret)
-		pl011_unregister_port(uap);
+		goto out_unregister;
 
+	return 0;
+
+out_unregister:
+	pl011_unregister_port(uap);
+out:
+	uart_put_console(&amba_reg);
+	dev_err(uap->port.dev, "Failed to register AMBA-PL011 driver\n");
 	return ret;
 }
 
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133ffbbc..0257fe1dbf00 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -507,30 +507,36 @@ static int __init apbuart_console_setup(struct console *co, char *options)
 
 static struct uart_driver grlib_apbuart_driver;
 
-static struct console grlib_apbuart_console = {
-	.name = "ttyS",
+static const struct console_operations grlib_cons_ops = {
 	.write = apbuart_console_write,
 	.device = uart_console_device,
 	.setup = apbuart_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &grlib_apbuart_driver,
 };
 
+static struct console __initdata *grlib_apbuart_console;
 
 static int grlib_apbuart_configure(void);
 
 static int __init apbuart_console_init(void)
 {
+	grlib_apbuart_console = allocate_console_dfl(&grlib_cons_ops, "ttyS",
+						     &grlib_apbuart_driver);
+	if (!grlib_apbuart_console)
+		return -ENOMEM;
+
 	if (grlib_apbuart_configure())
-		return -ENODEV;
-	register_console(&grlib_apbuart_console);
+		goto err;
+
+	register_console(grlib_apbuart_console);
 	return 0;
+err:
+	put_console(grlib_apbuart_console);
+	return -ENODEV;
 }
 
 console_initcall(apbuart_console_init);
 
-#define APBUART_CONSOLE	(&grlib_apbuart_console)
+#define APBUART_CONSOLE	(grlib_apbuart_console)
 #else
 #define APBUART_CONSOLE	NULL
 #endif
@@ -542,7 +548,6 @@ static struct uart_driver grlib_apbuart_driver = {
 	.major = SERIAL_APBUART_MAJOR,
 	.minor = SERIAL_APBUART_MINOR,
 	.nr = UART_NR,
-	.cons = APBUART_CONSOLE,
 };
 
 
@@ -652,6 +657,7 @@ static int __init grlib_apbuart_init(void)
 
 	printk(KERN_INFO "Serial: GRLIB APBUART driver\n");
 
+	grlib_apbuart_driver.cons = APBUART_CONSOLE;
 	ret = uart_register_driver(&grlib_apbuart_driver);
 
 	if (ret) {
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index db5df3d54818..3bce82a216d7 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -595,14 +595,10 @@ static int ar933x_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(&up->port, co, baud, parity, bits, flow);
 }
 
-static struct console ar933x_uart_console = {
-	.name		= "ttyATH",
+static const struct console_operations ar933x_cons_ops = {
 	.write		= ar933x_uart_console_write,
 	.device		= uart_console_device,
 	.setup		= ar933x_uart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &ar933x_uart_driver,
 };
 
 static void ar933x_uart_add_console_port(struct ar933x_uart_port *up)
@@ -749,8 +745,10 @@ static int __init ar933x_uart_init(void)
 {
 	int ret;
 
-	if (ar933x_uart_console_enabled())
-		ar933x_uart_driver.cons = &ar933x_uart_console;
+	ret = uart_allocate_console_dfl(&ar933x_uart_driver, &ar933x_cons_ops,
+					"ttyATH", SERIAL_AR933X_CONSOLE);
+	if (ret)
+		return ret;
 
 	ret = uart_register_driver(&ar933x_uart_driver);
 	if (ret)
@@ -765,6 +763,7 @@ static int __init ar933x_uart_init(void)
 err_unregister_uart_driver:
 	uart_unregister_driver(&ar933x_uart_driver);
 err_out:
+	uart_put_console(&ar933x_uart_driver);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index d904a3a345e7..8637e95b0d7f 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -105,10 +105,6 @@ struct arc_uart_port {
 
 static struct arc_uart_port arc_uart_ports[CONFIG_SERIAL_ARC_NR_PORTS];
 
-#ifdef CONFIG_SERIAL_ARC_CONSOLE
-static struct console arc_console;
-#endif
-
 #define DRIVER_NAME	"arc-uart"
 
 static struct uart_driver arc_uart_driver = {
@@ -118,9 +114,6 @@ static struct uart_driver arc_uart_driver = {
 	.major		= 0,
 	.minor		= 0,
 	.nr		= CONFIG_SERIAL_ARC_NR_PORTS,
-#ifdef CONFIG_SERIAL_ARC_CONSOLE
-	.cons		= &arc_console,
-#endif
 };
 
 static void arc_serial_stop_rx(struct uart_port *port)
@@ -536,14 +529,10 @@ static void arc_serial_console_write(struct console *co, const char *s,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static struct console arc_console = {
-	.name	= ARC_SERIAL_DEV_NAME,
+static const struct console_operations arc_cons_ops = {
 	.write	= arc_serial_console_write,
 	.device	= uart_console_device,
 	.setup	= arc_serial_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &arc_uart_driver
 };
 
 static void arc_early_serial_write(struct console *con, const char *s,
@@ -554,6 +543,10 @@ static void arc_early_serial_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, arc_serial_console_putchar);
 }
 
+static const struct console_operations arc_early_cons_ops = {
+	.write = arc_early_serial_write,
+};
+
 static int __init arc_early_console_setup(struct earlycon_device *dev,
 					  const char *opt)
 {
@@ -570,11 +563,13 @@ static int __init arc_early_console_setup(struct earlycon_device *dev,
 	UART_SET_BAUDL(port, l);
 	UART_SET_BAUDH(port, h);
 
-	dev->con->write = arc_early_serial_write;
+	dev->con->ops = &arc_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(arc_uart, "snps,arc-uart", arc_early_console_setup);
 
+#else
+static const struct console_operations arc_cons_ops;
 #endif	/* CONFIG_SERIAL_ARC_CONSOLE */
 
 static int arc_serial_probe(struct platform_device *pdev)
@@ -662,6 +657,12 @@ static int __init arc_serial_init(void)
 {
 	int ret;
 
+	ret = uart_allocate_console_dfl(&arc_uart_driver, &arc_cons_ops,
+					ARC_SERIAL_DEV_NAME,
+					SERIAL_ARC_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&arc_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..b37f2f640005 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -194,10 +194,6 @@ struct atmel_uart_port {
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
 static DECLARE_BITMAP(atmel_ports_in_use, ATMEL_MAX_UART);
 
-#ifdef SUPPORT_SYSRQ
-static struct console atmel_console;
-#endif
-
 #if defined(CONFIG_OF)
 static const struct of_device_id atmel_serial_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-usart-serial" },
@@ -2684,25 +2680,19 @@ static int __init atmel_console_setup(struct console *co, char *options)
 
 static struct uart_driver atmel_uart;
 
-static struct console atmel_console = {
-	.name		= ATMEL_DEVICENAME,
+static const struct console_operations atmel_cons_ops = {
 	.write		= atmel_console_write,
 	.device		= uart_console_device,
 	.setup		= atmel_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &atmel_uart,
 };
 
-#define ATMEL_CONSOLE_DEVICE	(&atmel_console)
-
 static inline bool atmel_is_console_port(struct uart_port *port)
 {
 	return port->cons && port->cons->index == port->line;
 }
 
 #else
-#define ATMEL_CONSOLE_DEVICE	NULL
+static const struct console_operations atmel_cons_ops;
 
 static inline bool atmel_is_console_port(struct uart_port *port)
 {
@@ -2717,7 +2707,6 @@ static struct uart_driver atmel_uart = {
 	.major		= SERIAL_ATMEL_MAJOR,
 	.minor		= MINOR_START,
 	.nr		= ATMEL_MAX_UART,
-	.cons		= ATMEL_CONSOLE_DEVICE,
 };
 
 #ifdef CONFIG_PM
@@ -2933,7 +2922,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
 	if (atmel_is_console_port(&atmel_port->uart)
-			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
+			&& atmel_uart.cons->flags & CON_ENABLED) {
 		/*
 		 * The serial core enabled the clock for us, so undo
 		 * the clk_prepare_enable() in atmel_console_setup()
@@ -3035,14 +3024,24 @@ static int __init atmel_serial_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&atmel_uart);
+	ret = uart_allocate_console_dfl(&atmel_uart, &atmel_cons_ops,
+					ATMEL_DEVICENAME,
+					SERIAL_ATMEL_CONSOLE);
 	if (ret)
 		return ret;
 
+	ret = uart_register_driver(&atmel_uart);
+	if (ret)
+		goto out;
+
 	ret = platform_driver_register(&atmel_serial_driver);
 	if (ret)
-		uart_unregister_driver(&atmel_uart);
+		goto out_unregister;
 
+out_unregister:
+	uart_unregister_driver(&atmel_uart);
+out:
+	uart_put_console(&atmel_uart);
 	return ret;
 }
 device_initcall(atmel_serial_init);
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index b7adc6127b3d..706a0c7e572b 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -752,19 +752,22 @@ static int bcm_console_setup(struct console *co, char *options)
 
 static struct uart_driver bcm_uart_driver;
 
-static struct console bcm63xx_console = {
-	.name		= "ttyS",
+static const struct console_operations bcm63xx_cons_ops = {
 	.write		= bcm_console_write,
 	.device		= uart_console_device,
 	.setup		= bcm_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &bcm_uart_driver,
 };
 
+static struct console __initdata *bcm63xx_console;
+
 static int __init bcm63xx_console_init(void)
 {
-	register_console(&bcm63xx_console);
+	bcm63xx_console = allocate_console_dfl(&bcm63xx_cons_ops, "ttyS",
+					       &bcm_uart_driver);
+	if (!bcm63xx_console)
+		return -ENOMEM;
+
+	register_console(bcm63xx_console);
 	return 0;
 }
 
@@ -778,19 +781,23 @@ static void bcm_early_write(struct console *con, const char *s, unsigned n)
 	wait_for_xmitr(&dev->port);
 }
 
+static const struct console_operations bcm63xx_early_ops = {
+	.write = bcm_early_write,
+};
+
 static int __init bcm_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = bcm_early_write;
+	device->con->ops = &bcm63xx_early_ops;
 	return 0;
 }
 
 OF_EARLYCON_DECLARE(bcm63xx_uart, "brcm,bcm6345-uart", bcm_early_console_setup);
 
-#define BCM63XX_CONSOLE	(&bcm63xx_console)
+#define BCM63XX_CONSOLE	(bcm63xx_console)
 #else
 #define BCM63XX_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_BCM63XX_CONSOLE */
@@ -802,7 +809,6 @@ static struct uart_driver bcm_uart_driver = {
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= BCM63XX_NR_UARTS,
-	.cons		= BCM63XX_CONSOLE,
 };
 
 /*
@@ -902,6 +908,7 @@ static int __init bcm_uart_init(void)
 {
 	int ret;
 
+	bcm_uart_driver.cons = BCM63XX_CONSOLE;
 	ret = uart_register_driver(&bcm_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 98f193a83392..d37a538768f5 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -429,14 +429,14 @@ static int uart_clps711x_console_setup(struct console *co, char *options)
 				  SYSCON_UARTEN, SYSCON_UARTEN);
 }
 
-static struct console clps711x_console = {
-	.name	= UART_CLPS711X_DEVNAME,
+static const struct console_operations clps711x_cons_ops = {
 	.device	= uart_console_device,
 	.write	= uart_clps711x_console_write,
 	.setup	= uart_clps711x_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
 };
+
+#else
+static const struct console_operations clps711x_cons_ops;
 #endif
 
 static int uart_clps711x_probe(struct platform_device *pdev)
@@ -553,10 +553,11 @@ static int __init uart_clps711x_init(void)
 {
 	int ret;
 
-#ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-	clps711x_uart.cons = &clps711x_console;
-	clps711x_console.data = &clps711x_uart;
-#endif
+	ret = uart_allocate_console_dfl(&clps711x_uart, &clps711x_cons_ops,
+					UART_CLPS711X_DEVNAME,
+					SERIAL_CLPS711X_CONSOLE);
+	if (ret)
+		return ret;
 
 	ret = uart_register_driver(&clps711x_uart);
 	if (ret)
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index b929c7ae3a27..8e2685f1ecc0 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1363,27 +1363,29 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver cpm_reg;
-static struct console cpm_scc_uart_console = {
-	.name		= "ttyCPM",
+
+static const struct console_operations cpm_scc_cons_ops = {
 	.write		= cpm_uart_console_write,
 	.device		= uart_console_device,
 	.setup		= cpm_uart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &cpm_reg,
 };
 
 static int __init cpm_uart_console_init(void)
 {
-	register_console(&cpm_scc_uart_console);
+	struct console *cpm_scc_uart_console;
+
+	cpm_scc_uart_console = allocate_console_dfl(&cpm_scc_cons_ops, "ttyCPM",
+						    &cpm_reg);
+	if (!cpm_scc_uart_console)
+		return -ENOMEM;
+
+	cpm_reg->cons = cpm_scc_uart_console;
+	register_console(cpm_scc_uart_console);
 	return 0;
 }
 
 console_initcall(cpm_uart_console_init);
 
-#define CPM_UART_CONSOLE	&cpm_scc_uart_console
-#else
-#define CPM_UART_CONSOLE	NULL
 #endif
 
 static struct uart_driver cpm_reg = {
@@ -1392,7 +1394,6 @@ static struct uart_driver cpm_reg = {
 	.dev_name	= "ttyCPM",
 	.major		= SERIAL_CPM_MAJOR,
 	.minor		= SERIAL_CPM_MINOR,
-	.cons		= CPM_UART_CONSOLE,
 	.nr		= UART_NR,
 };
 
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index f460cca139e2..2f95a469b814 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -431,21 +431,18 @@ static int digicolor_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct console digicolor_console = {
-	.name	= "ttyS",
-	.device	= uart_console_device,
-	.write	= digicolor_uart_console_write,
-	.setup	= digicolor_uart_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-};
-
 static struct uart_driver digicolor_uart = {
 	.driver_name	= "digicolor-usart",
 	.dev_name	= "ttyS",
 	.nr		= DIGICOLOR_USART_NR,
 };
 
+static const struct console_operations digicolor_cons_ops = {
+	.device	= uart_console_device,
+	.write	= digicolor_uart_console_write,
+	.setup	= digicolor_uart_console_setup,
+};
+
 static int digicolor_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -532,10 +529,11 @@ static int __init digicolor_uart_init(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE)) {
-		digicolor_uart.cons = &digicolor_console;
-		digicolor_console.data = &digicolor_uart;
-	}
+	ret = uart_allocate_console_dfl(&digicolor_uart, &digicolor_cons_ops,
+					"ttyS",
+					SERIAL_CONEXANT_DIGICOLOR_CONSOLE);
+	if (ret)
+		return ret;
 
 	ret = uart_register_driver(&digicolor_uart);
 	if (ret)
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e840e255..68972dc25497 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -887,19 +887,23 @@ static int __init dz_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver dz_reg;
-static struct console dz_console = {
-	.name	= "ttyS",
+
+static const struct console_operations dz_cons_ops = {
 	.write	= dz_console_print,
 	.device	= uart_console_device,
 	.setup	= dz_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &dz_reg,
 };
 
+static struct console __initdata *dz_console;
+
 static int __init dz_serial_console_init(void)
 {
 	if (!IOASIC) {
+		dz_console = allocate_console_dfl(&dz_cons_ops, "ttyS",
+						  &dz_reg);
+		if (!dz_console)
+			return -ENOMEM;
+
 		dz_init_ports();
 		register_console(&dz_console);
 		return 0;
@@ -909,7 +913,7 @@ static int __init dz_serial_console_init(void)
 
 console_initcall(dz_serial_console_init);
 
-#define SERIAL_DZ_CONSOLE	&dz_console
+#define SERIAL_DZ_CONSOLE	(dz_console)
 #else
 #define SERIAL_DZ_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_DZ_CONSOLE */
@@ -921,7 +925,6 @@ static struct uart_driver dz_reg = {
 	.major			= TTY_MAJOR,
 	.minor			= 64,
 	.nr			= DZ_NB_PORT,
-	.cons			= SERIAL_DZ_CONSOLE,
 };
 
 static int __init dz_init(void)
@@ -935,6 +938,7 @@ static int __init dz_init(void)
 
 	dz_init_ports();
 
+	dz_reg.cons = SERIAL_DZ_CONSOLE;
 	ret = uart_register_driver(&dz_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-arm-semihost.c
index fa096c10b591..f4c73327cd18 100644
--- a/drivers/tty/serial/earlycon-arm-semihost.c
+++ b/drivers/tty/serial/earlycon-arm-semihost.c
@@ -42,10 +42,14 @@ static void smh_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, smh_putc);
 }
 
+static const struct console_operations smh_early_cons_ops = {
+	.write = smh_write,
+};
+
 static int
 __init early_smh_setup(struct earlycon_device *device, const char *opt)
 {
-	device->con->write = smh_write;
+	device->con->ops = &smh_early_cons_ops;
 	return 0;
 }
 EARLYCON_DECLARE(smh, early_smh_setup);
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c14873b67803..b32281ce86dc 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -30,6 +30,7 @@ static struct console early_con = {
 	.name =		"uart",		/* fixed up at earlycon registration */
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	0,
+	.is_static =	1,
 };
 
 static struct earlycon_device early_console_dev = {
@@ -142,7 +143,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 	err = match->setup(&early_console_dev, buf);
 	if (err < 0)
 		return err;
-	if (!early_console_dev.con->write)
+	if (!early_console_dev.con->ops || !early_console_dev.con->ops->write)
 		return -ENODEV;
 
 	register_console(early_console_dev.con);
@@ -293,7 +294,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	err = match->setup(&early_console_dev, options);
 	if (err < 0)
 		return err;
-	if (!early_console_dev.con->write)
+	if (!early_console_dev.con->ops || !early_console_dev.con->ops->write)
 		return -ENODEV;
 
 
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index d6b5e5463746..ad07349f7f2e 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -639,18 +639,14 @@ static int efm32_uart_console_setup(struct console *co, char *options)
 
 static struct uart_driver efm32_uart_reg;
 
-static struct console efm32_uart_console = {
-	.name = DEV_NAME,
+static const struct console_operations efm32_cons_ops = {
 	.write = efm32_uart_console_write,
 	.device = uart_console_device,
 	.setup = efm32_uart_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &efm32_uart_reg,
 };
 
 #else
-#define efm32_uart_console (*(struct console *)NULL)
+static const struct console_operations efm32_cons_ops;
 #endif /* ifdef CONFIG_SERIAL_EFM32_UART_CONSOLE / else */
 
 static struct uart_driver efm32_uart_reg = {
@@ -828,16 +824,26 @@ static int __init efm32_uart_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&efm32_uart_reg);
+	ret = uart_allocate_console_dfl(&efm32_uart_reg, &efm32_cons_ops,
+					DEV_NAME, SERIAL_EFM32_UART_CONSOLE);
 	if (ret)
 		return ret;
 
+	ret = uart_register_driver(&efm32_uart_reg);
+	if (ret)
+		goto out;
+
 	ret = platform_driver_register(&efm32_uart_driver);
 	if (ret)
-		uart_unregister_driver(&efm32_uart_reg);
+		goto out_unregister;
 
 	pr_info("EFM32 UART/USART driver\n");
+	return 0;
 
+out_unregister:
+	uart_unregister_driver(&efm32_uart_reg);
+out:
+	uart_put_console(&efm32_uart_reg);
 	return ret;
 }
 module_init(efm32_uart_init);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index debdd1b9e01a..614ac78933a2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2043,24 +2043,17 @@ static int __init lpuart_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver lpuart_reg;
-static struct console lpuart_console = {
-	.name		= DEV_NAME,
+
+static const struct console_operations lpuart_cons_ops = {
 	.write		= lpuart_console_write,
 	.device		= uart_console_device,
 	.setup		= lpuart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &lpuart_reg,
 };
 
-static struct console lpuart32_console = {
-	.name		= DEV_NAME,
+static const struct console_operations lpuart32_cons_ops = {
 	.write		= lpuart32_console_write,
 	.device		= uart_console_device,
 	.setup		= lpuart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &lpuart_reg,
 };
 
 static void lpuart_early_write(struct console *con, const char *s, unsigned n)
@@ -2070,6 +2063,10 @@ static void lpuart_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, lpuart_console_putchar);
 }
 
+static struct console_operations lpuart_early_cons_ops = {
+	.write = lpuart_early_write,
+};
+
 static void lpuart32_early_write(struct console *con, const char *s, unsigned n)
 {
 	struct earlycon_device *dev = con->data;
@@ -2077,13 +2074,17 @@ static void lpuart32_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, lpuart32_console_putchar);
 }
 
+static struct console_operations lpuart32_early_cons_ops = {
+	.write = lpuart32_early_write,
+};
+
 static int __init lpuart_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = lpuart_early_write;
+	device->con->ops = &lpuart_early_cons_ops;
 	return 0;
 }
 
@@ -2094,7 +2095,7 @@ static int __init lpuart32_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.iotype = UPIO_MEM32BE;
-	device->con->write = lpuart32_early_write;
+	device->con->ops = &lpuart32_early_cons_ops;
 	return 0;
 }
 
@@ -2106,8 +2107,7 @@ static int __init lpuart32_imx_early_console_setup(struct earlycon_device *devic
 
 	device->port.iotype = UPIO_MEM32;
 	device->port.membase += IMX_REG_OFF;
-	device->con->write = lpuart32_early_write;
-
+	device->con->ops = &lpuart32_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
@@ -2116,11 +2116,9 @@ OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_s
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
-#define LPUART_CONSOLE	(&lpuart_console)
-#define LPUART32_CONSOLE	(&lpuart32_console)
 #else
-#define LPUART_CONSOLE	NULL
-#define LPUART32_CONSOLE	NULL
+static const struct console_operations lpuart_cons_ops;
+static const struct console_operations lpuart32_cons_ops;
 #endif
 
 static struct uart_driver lpuart_reg = {
@@ -2128,7 +2126,6 @@ static struct uart_driver lpuart_reg = {
 	.driver_name	= DRIVER_NAME,
 	.dev_name	= DEV_NAME,
 	.nr		= ARRAY_SIZE(lpuart_ports),
-	.cons		= LPUART_CONSOLE,
 };
 
 static int lpuart_probe(struct platform_device *pdev)
@@ -2137,6 +2134,7 @@ static int lpuart_probe(struct platform_device *pdev)
 							   &pdev->dev);
 	const struct lpuart_soc_data *sdata = of_id->data;
 	struct device_node *np = pdev->dev.of_node;
+	const struct console_operations *ops;
 	struct lpuart_port *sport;
 	struct resource *res;
 	int ret;
@@ -2203,22 +2201,25 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &sport->port);
 
-	if (lpuart_is_32(sport)) {
-		lpuart_reg.cons = LPUART32_CONSOLE;
+	ops = lpuart_is_32(sport) ? &lpuart32_cons_ops : &lpuart_cons_ops;
+	ret = uart_allocate_console_dfl(&lpuart_reg, ops, DEV_NAME,
+					SERIAL_FSL_LPUART_CONSOLE);
+	if (ret)
+		return ret;
+
+	if (lpuart_is_32(sport))
 		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart32_int, 0,
 					DRIVER_NAME, sport);
-	} else {
-		lpuart_reg.cons = LPUART_CONSOLE;
+	else
 		ret = devm_request_irq(&pdev->dev, sport->port.irq, lpuart_int, 0,
 					DRIVER_NAME, sport);
-	}
 
 	if (ret)
-		goto failed_irq_request;
+		goto out;
 
 	ret = uart_add_one_port(&lpuart_reg, &sport->port);
 	if (ret)
-		goto failed_attach_port;
+		goto out;
 
 	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
 
@@ -2243,8 +2244,8 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	return 0;
 
-failed_attach_port:
-failed_irq_request:
+out:
+	uart_put_console(&lpuart_reg);
 	clk_disable_unprepare(sport->clk);
 	return ret;
 }
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc94731..741a382b7c9b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2071,18 +2071,13 @@ imx_uart_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver imx_uart_uart_driver;
-static struct console imx_uart_console = {
-	.name		= DEV_NAME,
+
+static const struct console_operations imx_cons_ops = {
 	.write		= imx_uart_console_write,
 	.device		= uart_console_device,
 	.setup		= imx_uart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &imx_uart_uart_driver,
 };
 
-#define IMX_CONSOLE	&imx_uart_console
-
 #ifdef CONFIG_OF
 static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
 {
@@ -2102,14 +2097,17 @@ static void imx_uart_console_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, count, imx_uart_console_early_putchar);
 }
 
+static const struct console_operations imx_early_cons_ops = {
+	.write = imx_uart_console_early_write,
+};
+
 static int __init
 imx_console_early_setup(struct earlycon_device *dev, const char *opt)
 {
 	if (!dev->port.membase)
 		return -ENODEV;
 
-	dev->con->write = imx_uart_console_early_write;
-
+	dev->con->ops = &imx_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(ec_imx6q, "fsl,imx6q-uart", imx_console_early_setup);
@@ -2117,7 +2115,7 @@ OF_EARLYCON_DECLARE(ec_imx21, "fsl,imx21-uart", imx_console_early_setup);
 #endif
 
 #else
-#define IMX_CONSOLE	NULL
+static const struct console_operations imx_cons_ops;
 #endif
 
 static struct uart_driver imx_uart_uart_driver = {
@@ -2127,7 +2125,6 @@ static struct uart_driver imx_uart_uart_driver = {
 	.major          = SERIAL_IMX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(imx_uart_ports),
-	.cons           = IMX_CONSOLE,
 };
 
 #ifdef CONFIG_OF
@@ -2553,15 +2550,27 @@ static struct platform_driver imx_uart_platform_driver = {
 
 static int __init imx_uart_init(void)
 {
-	int ret = uart_register_driver(&imx_uart_uart_driver);
+	int ret;
 
+	ret = uart_allocate_console_dfl(&imx_uart_uart_driver, &imx_cons_ops,
+					DEV_NAME, SERIAL_IMX_CONSOLE);
 	if (ret)
 		return ret;
 
+	ret = uart_register_driver(&imx_uart_uart_driver);
+	if (ret)
+		goto out;
+
 	ret = platform_driver_register(&imx_uart_platform_driver);
 	if (ret != 0)
-		uart_unregister_driver(&imx_uart_uart_driver);
+		goto out_unregister;
+
+	return 0;
 
+out_unregister:
+	uart_unregister_driver(&imx_uart_uart_driver);
+out:
+	uart_put_console(&imx_uart_uart_driver);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 8c810733df3d..ab90fc59a488 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1055,15 +1055,14 @@ static int __init ip22zilog_console_setup(struct console *con, char *options)
 
 static struct uart_driver ip22zilog_reg;
 
-static struct console ip22zilog_console = {
-	.name	=	"ttyS",
+static const struct console_operations ip22zilog_cons_ops = {
 	.write	=	ip22zilog_console_write,
 	.device	=	uart_console_device,
 	.setup	=	ip22zilog_console_setup,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data	=	&ip22zilog_reg,
 };
+
+#else
+static const struct console_operations ip22zilog_cons_ops;
 #endif /* CONFIG_SERIAL_IP22_ZILOG_CONSOLE */
 
 static struct uart_driver ip22zilog_reg = {
@@ -1165,6 +1164,11 @@ static int __init ip22zilog_ports_init(void)
 		panic("IP22-Zilog: Unable to register zs interrupt handler.\n");
 	}
 
+	ret = uart_allocate_console_dfl(&ip22zilog_reg, &ip22zilog_cons_ops,
+					"ttyS", SERIAL_IP22_ZILOG_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&ip22zilog_reg);
 	if (ret == 0) {
 		int i;
@@ -1183,9 +1187,7 @@ static int __init ip22zilog_init(void)
 {
 	/* IP22 Zilog setup is hard coded, no probing to do.  */
 	ip22zilog_alloc_tables();
-	ip22zilog_ports_init();
-
-	return 0;
+	return ip22zilog_ports_init()
 }
 
 static void __exit ip22zilog_exit(void)
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272891f9..00cc3a50f601 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -71,15 +71,14 @@ static struct tty_driver *kgdb_nmi_console_device(struct console *co, int *idx)
 	return kgdb_nmi_tty_driver;
 }
 
-static struct console kgdb_nmi_console = {
-	.name	= "ttyNMI",
+static const struct console_operations kgdb_nmi_cons_ops = {
 	.setup  = kgdb_nmi_console_setup,
 	.write	= kgdb_nmi_console_write,
 	.device	= kgdb_nmi_console_device,
-	.flags	= CON_PRINTBUFFER | CON_ANYTIME,
-	.index	= -1,
 };
 
+static struct console *kgdb_nmi_console;
+
 /*
  * This is usually the maximum rate on debug ports. We make fifo large enough
  * to make copy-pasting to the terminal usable.
@@ -335,6 +334,15 @@ int kgdb_register_nmi_console(void)
 		pr_err("%s: cannot allocate tty\n", __func__);
 		return -ENOMEM;
 	}
+
+	ret = -ENOMEM;
+	kgdb_nmi_console = allocate_console_dfl(&kgdb_nmi_cons_ops, "ttyNMI",
+						NULL);
+	if (!kgdb_nmi_console)
+		goto err_drv_reg;
+
+	kgdb_nmi_console->flags |= CON_ANYTIME;
+
 	kgdb_nmi_tty_driver->driver_name	= "ttyNMI";
 	kgdb_nmi_tty_driver->name		= "ttyNMI";
 	kgdb_nmi_tty_driver->num		= 1;
@@ -352,7 +360,7 @@ int kgdb_register_nmi_console(void)
 		goto err_drv_reg;
 	}
 
-	register_console(&kgdb_nmi_console);
+	register_console(kgdb_nmi_console);
 
 	return 0;
 err_drv_reg:
@@ -369,7 +377,7 @@ int kgdb_unregister_nmi_console(void)
 		return 0;
 	arch_kgdb_ops.enable_nmi(0);
 
-	ret = unregister_console(&kgdb_nmi_console);
+	ret = unregister_console(kgdb_nmi_console);
 	if (ret)
 		return ret;
 
@@ -377,6 +385,7 @@ int kgdb_unregister_nmi_console(void)
 	if (ret)
 		return ret;
 	put_tty_driver(kgdb_nmi_tty_driver);
+	put_device(&kgdb_nmi_console->dev);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 6fb312e7af71..d0f1b306cf9f 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -170,7 +170,7 @@ static int configure_kgdboc(void)
 	cons = console_drivers;
 	while (cons) {
 		int idx;
-		if (cons->device && cons->device(cons, &idx) == p &&
+		if (cons->ops->device && cons->ops->device(cons, &idx) == p &&
 		    idx == tty_line) {
 			kgdboc_io_ops.is_console = 1;
 			break;
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 9de9f0f239a1..ae54f5c04a64 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -640,20 +640,23 @@ lqasc_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct console lqasc_console = {
-	.name =		"ttyLTQ",
+static const struct console_operations lqasc_cons_ops = {
 	.write =	lqasc_console_write,
 	.device =	uart_console_device,
 	.setup =	lqasc_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-	.data =		&lqasc_reg,
 };
 
+static struct console __initdata *lqasc_console;
+
 static int __init
 lqasc_console_init(void)
 {
-	register_console(&lqasc_console);
+	lqasc_console = allocate_console_dfl(&lqasc_cons_ops, "ttyLTQ",
+					     &lqasc_reg);
+	if (!lqasc_console)
+		return -ENOMEM;
+
+	register_console(lqasc_console);
 	return 0;
 }
 console_initcall(lqasc_console_init);
@@ -667,6 +670,10 @@ static void lqasc_serial_early_console_write(struct console *co,
 	lqasc_serial_port_write(&dev->port, s, count);
 }
 
+static const struct console_operations lqasc_early_cons_ops = {
+	.write = lqasc_serial_early_console_write,
+};
+
 static int __init
 lqasc_serial_early_console_setup(struct earlycon_device *device,
 				 const char *opt)
@@ -674,7 +681,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = lqasc_serial_early_console_write;
+	device->con->ops = &lqasc_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
@@ -686,7 +693,6 @@ static struct uart_driver lqasc_reg = {
 	.major =	0,
 	.minor =	0,
 	.nr =		MAXPORTS,
-	.cons =		&lqasc_console,
 };
 
 static int __init
@@ -791,6 +797,7 @@ init_lqasc(void)
 {
 	int ret;
 
+	lqasc_reg.cons = lqasc_console;
 	ret = uart_register_driver(&lqasc_reg);
 	if (ret != 0)
 		return ret;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index d1d73261575b..6f3104187aeb 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -174,24 +174,29 @@ static int __init lpc32xx_hsuart_console_setup(struct console *co,
 }
 
 static struct uart_driver lpc32xx_hsuart_reg;
-static struct console lpc32xx_hsuart_console = {
-	.name		= LPC32XX_TTY_NAME,
+
+static const struct console_operations lpc32xx_cons_ops = {
 	.write		= lpc32xx_hsuart_console_write,
 	.device		= uart_console_device,
 	.setup		= lpc32xx_hsuart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &lpc32xx_hsuart_reg,
 };
 
+static struct console __initdata *lpc32xx_hsuart_console;
+
 static int __init lpc32xx_hsuart_console_init(void)
 {
-	register_console(&lpc32xx_hsuart_console);
+	lpc32xx_hsuart_console = allocate_console(&lpc32xx_cons_ops,
+						  LPC32XX_TTY_NAME,
+						  &lpc32xx_hsuart_reg);
+	if (!lpc32xx_hsuart_console)
+		return -ENOMEM;
+
+	register_console(lpc32xx_hsuart_console);
 	return 0;
 }
 console_initcall(lpc32xx_hsuart_console_init);
 
-#define LPC32XX_HSUART_CONSOLE (&lpc32xx_hsuart_console)
+#define LPC32XX_HSUART_CONSOLE (lpc32xx_hsuart_console)
 #else
 #define LPC32XX_HSUART_CONSOLE NULL
 #endif
@@ -201,7 +206,6 @@ static struct uart_driver lpc32xx_hs_reg = {
 	.driver_name	= MODNAME,
 	.dev_name	= LPC32XX_TTY_NAME,
 	.nr		= MAX_PORTS,
-	.cons		= LPC32XX_HSUART_CONSOLE,
 };
 static int uarts_registered;
 
@@ -768,6 +772,7 @@ static int __init lpc32xx_hsuart_init(void)
 {
 	int ret;
 
+	lpc32xx_hs_reg.cons = LPC32XX_HSUART_CONSOLE;
 	ret = uart_register_driver(&lpc32xx_hs_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 7dbfb4cde124..0490c17c5e68 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -566,25 +566,27 @@ static int __init mcf_console_setup(struct console *co, char *options)
 
 static struct uart_driver mcf_driver;
 
-static struct console mcf_console = {
-	.name		= "ttyS",
+static const struct console_operations mcf_cons_ops = {
 	.write		= mcf_console_write,
 	.device		= uart_console_device,
 	.setup		= mcf_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &mcf_driver,
 };
 
+static struct console __initdata *mcf_console;
+
 static int __init mcf_console_init(void)
 {
-	register_console(&mcf_console);
+	mcf_console = allocate_console_dfl(&mcf_cons_ops, "ttyS", &mcf_driver);
+	if (!mcf_console)
+		return -ENOMEM;
+
+	register_console(mcf_console);
 	return 0;
 }
 
 console_initcall(mcf_console_init);
 
-#define	MCF_CONSOLE	&mcf_console
+#define	MCF_CONSOLE	(mcf_console)
 
 /****************************************************************************/
 #else
@@ -606,7 +608,6 @@ static struct uart_driver mcf_driver = {
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= MCF_MAXPORTS,
-	.cons		= MCF_CONSOLE,
 };
 
 /****************************************************************************/
@@ -673,6 +674,7 @@ static int __init mcf_init(void)
 
 	printk("ColdFire internal UART serial driver\n");
 
+	mcf_driver.cons = MCF_CONSOLE;
 	rc = uart_register_driver(&mcf_driver);
 	if (rc)
 		return rc;
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a842591b37c..09d1a5c60053 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -527,19 +527,23 @@ static int meson_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct console meson_serial_console = {
-	.name		= AML_UART_DEV_NAME,
+static const struct console_operations meson_cons_ops = {
 	.write		= meson_serial_console_write,
 	.device		= uart_console_device,
 	.setup		= meson_serial_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &meson_uart_driver,
 };
 
+static struct console __initdata *meson_serial_console;
+
 static int __init meson_serial_console_init(void)
 {
-	register_console(&meson_serial_console);
+	meson_serial_console = allocate_console_dfl(&meson_cons_ops,
+						    AML_UART_DEV_NAME,
+						    &meson_uart_driver);
+	if (!meson_serial_console)
+		return -ENOMEM;
+
+	register_console(meson_serial_console);
 	return 0;
 }
 console_initcall(meson_serial_console_init);
@@ -553,6 +557,10 @@ static void meson_serial_early_console_write(struct console *co,
 	meson_serial_port_write(&dev->port, s, count);
 }
 
+static const struct console_operations meson_early_cons_ops = {
+	.write = meson_serial_early_console_write,
+};
+
 static int __init
 meson_serial_early_console_setup(struct earlycon_device *device, const char *opt)
 {
@@ -560,7 +568,7 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 		return -ENODEV;
 
 	meson_uart_enable_tx_engine(&device->port);
-	device->con->write = meson_serial_early_console_write;
+	device->con->ops = &meson_early_cons_ops;
 	return 0;
 }
 /* Legacy bindings, should be removed when no more used */
@@ -570,7 +578,7 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
 
-#define MESON_SERIAL_CONSOLE	(&meson_serial_console)
+#define MESON_SERIAL_CONSOLE	(meson_serial_console)
 #else
 #define MESON_SERIAL_CONSOLE	NULL
 #endif
@@ -580,7 +588,6 @@ static struct uart_driver meson_uart_driver = {
 	.driver_name	= "meson_uart",
 	.dev_name	= AML_UART_DEV_NAME,
 	.nr		= AML_UART_PORT_NUM,
-	.cons		= MESON_SERIAL_CONSOLE,
 };
 
 static inline struct clk *meson_uart_probe_clock(struct device *dev,
@@ -751,6 +758,7 @@ static int __init meson_uart_init(void)
 {
 	int ret;
 
+	meson_uart_driver.cons = MESON_SERIAL_CONSOLE;
 	ret = uart_register_driver(&meson_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3a75ee08d619..91f0d6b90e50 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1678,28 +1678,30 @@ mpc52xx_console_setup(struct console *co, char *options)
 
 static struct uart_driver mpc52xx_uart_driver;
 
-static struct console mpc52xx_console = {
-	.name	= "ttyPSC",
+static const struct console_operations mpc52xx_cons_ops = {
 	.write	= mpc52xx_console_write,
 	.device	= uart_console_device,
 	.setup	= mpc52xx_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyPSC0) */
-	.data	= &mpc52xx_uart_driver,
 };
 
+static struct console __initdata *mpc52xx_console;
 
 static int __init
 mpc52xx_console_init(void)
 {
+	mpc52xx_console = allocate_console_dfl(&mpc52xx_cons_ops, "ttyPSC",
+					       &mpc52xx_uart_driver);
+	if (!mpc52xx_console)
+		return -ENOMEM;
+
 	mpc52xx_uart_of_enumerate();
-	register_console(&mpc52xx_console);
+	register_console(mpc52xx_console);
 	return 0;
 }
 
 console_initcall(mpc52xx_console_init);
 
-#define MPC52xx_PSC_CONSOLE &mpc52xx_console
+#define MPC52xx_PSC_CONSOLE (mpc52xx_console)
 #else
 #define MPC52xx_PSC_CONSOLE NULL
 #endif
@@ -1715,7 +1717,6 @@ static struct uart_driver mpc52xx_uart_driver = {
 	.major		= SERIAL_PSC_MAJOR,
 	.minor		= SERIAL_PSC_MINOR,
 	.nr		= MPC52xx_PSC_MAXNUM,
-	.cons		= MPC52xx_PSC_CONSOLE,
 };
 
 /* ======================================================================== */
@@ -1910,6 +1911,7 @@ mpc52xx_uart_init(void)
 
 	printk(KERN_INFO "Serial: MPC52xx PSC UART driver\n");
 
+	mpc52xx_uart_driver.cons = MPC52xx_PSC_CONSOLE;
 	ret = uart_register_driver(&mpc52xx_uart_driver);
 	if (ret) {
 		printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 9f8f63719126..a9a9b216e651 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -436,18 +436,12 @@ static int mps2_uart_console_setup(struct console *co, char *options)
 
 static struct uart_driver mps2_uart_driver;
 
-static struct console mps2_uart_console = {
-	.name = SERIAL_NAME,
+static const struct console_operations mps2_cons_ops = {
 	.device = uart_console_device,
 	.write = mps2_uart_console_write,
 	.setup = mps2_uart_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &mps2_uart_driver,
 };
 
-#define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
-
 static void mps2_early_putchar(struct uart_port *port, int ch)
 {
 	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
@@ -463,28 +457,30 @@ static void mps2_early_write(struct console *con, const char *s, unsigned int n)
 	uart_console_write(&dev->port, s, n, mps2_early_putchar);
 }
 
+static const struct console_operations mps2_early_cons_ops = {
+	.write = mps2_early_write,
+};
+
 static int __init mps2_early_console_setup(struct earlycon_device *device,
 					   const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = mps2_early_write;
-
+	device->con->ops = &mps2_early_cons_ops;
 	return 0;
 }
 
 OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
 
 #else
-#define MPS2_SERIAL_CONSOLE NULL
+static const struct console_operations mps2_cons_ops;
 #endif
 
 static struct uart_driver mps2_uart_driver = {
 	.driver_name = DRIVER_NAME,
 	.dev_name = SERIAL_NAME,
 	.nr = MPS2_MAX_PORTS,
-	.cons = MPS2_SERIAL_CONSOLE,
 };
 
 static struct mps2_uart_port *mps2_of_get_port(struct platform_device *pdev)
@@ -588,14 +584,26 @@ static int __init mps2_uart_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&mps2_uart_driver);
+	ret = uart_allocate_console_dfl(&mps2_uart_driver, &mps2_cons_ops,
+					SERIAL_NAME,
+					SERIAL_MPS2_UART_CONSOLE);
 	if (ret)
 		return ret;
 
+	ret = uart_register_driver(&mps2_uart_driver);
+	if (ret)
+		goto out;
+
 	ret = platform_driver_register(&mps2_serial_driver);
 	if (ret)
-		uart_unregister_driver(&mps2_uart_driver);
+		goto out_unregister;
+
+	return 0;
 
+out_unregister:
+	uart_unregister_driver(&mps2_uart_driver);
+out:
+	uart_put_console(&mps2_uart_driver);
 	return ret;
 }
 arch_initcall(mps2_uart_init);
diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 1f60d6fe4ff2..6bbbd55ab7d5 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -1790,28 +1790,33 @@ static int __init mpsc_console_setup(struct console *co, char *options)
 	return uart_set_options(&pi->port, co, baud, parity, bits, flow);
 }
 
-static struct console mpsc_console = {
-	.name	= MPSC_DEV_NAME,
+static const struct console_operations mpsc_cons_ops = {
 	.write	= mpsc_console_write,
 	.device	= uart_console_device,
 	.setup	= mpsc_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &mpsc_reg,
 };
 
+static struct console __initdata *mpsc_console;
+
 static int __init mpsc_late_console_init(void)
 {
 	pr_debug("mpsc_late_console_init: Enter\n");
 
-	if (!(mpsc_console.flags & CON_ENABLED))
-		register_console(&mpsc_console);
+	if (mpsc_console)
+		return 0;
+
+	mpsc_console = allocate_console_dfl(&mpsc_cons_ops, MPSC_DEV_NAME,
+					    &mpsc_reg);
+	if (!mpsc_console)
+		return -ENOMEM;
+
+	register_console(mpsc_console);
 	return 0;
 }
 
 late_initcall(mpsc_late_console_init);
 
-#define MPSC_CONSOLE	&mpsc_console
+#define MPSC_CONSOLE	(mpsc_console)
 #else
 #define MPSC_CONSOLE	NULL
 #endif
@@ -1943,7 +1948,6 @@ static struct uart_driver mpsc_reg = {
 	.major		= MPSC_MAJOR,
 	.minor		= MPSC_MINOR_START,
 	.nr		= MPSC_NUM_CTLRS,
-	.cons		= MPSC_CONSOLE,
 };
 
 static int mpsc_drv_map_regs(struct mpsc_port_info *pi,
@@ -2110,6 +2114,7 @@ static int __init mpsc_drv_init(void)
 	memset(mpsc_ports, 0, sizeof(mpsc_ports));
 	memset(&mpsc_shared_regs, 0, sizeof(mpsc_shared_regs));
 
+	mpsc_reg.cons = MPSC_CONSOLE;
 	rc = uart_register_driver(&mpsc_reg);
 	if (rc)
 		return rc;
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 736b74fd6623..43e326d0e6ff 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1668,13 +1668,17 @@ msm_serial_early_write(struct console *con, const char *s, unsigned n)
 	__msm_console_write(&dev->port, s, n, false);
 }
 
+static const struct console_operations msm_early_cons_ops = {
+	.write = msm_serial_early_write,
+};
+
 static int __init
 msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = msm_serial_early_write;
+	device->con->ops = &msm_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
@@ -1688,6 +1692,10 @@ msm_serial_early_write_dm(struct console *con, const char *s, unsigned n)
 	__msm_console_write(&dev->port, s, n, true);
 }
 
+static const struct console_operations msm_dm_early_cons_ops = {
+	.write = msm_serial_early_write_dm,
+};
+
 static int __init
 msm_serial_early_console_setup_dm(struct earlycon_device *device,
 				  const char *opt)
@@ -1695,7 +1703,7 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = msm_serial_early_write_dm;
+	device->con->ops = &msm_dm_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(msm_serial_dm, "qcom,msm-uartdm",
@@ -1703,20 +1711,14 @@ OF_EARLYCON_DECLARE(msm_serial_dm, "qcom,msm-uartdm",
 
 static struct uart_driver msm_uart_driver;
 
-static struct console msm_console = {
-	.name = "ttyMSM",
+static const struct console_operations msm_cons_ops = {
 	.write = msm_console_write,
 	.device = uart_console_device,
 	.setup = msm_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &msm_uart_driver,
 };
 
-#define MSM_CONSOLE	(&msm_console)
-
 #else
-#define MSM_CONSOLE	NULL
+static const struct console_operations msm_cons_ops;
 #endif
 
 static struct uart_driver msm_uart_driver = {
@@ -1724,7 +1726,6 @@ static struct uart_driver msm_uart_driver = {
 	.driver_name = "msm_serial",
 	.dev_name = "ttyMSM",
 	.nr = UART_NR,
-	.cons = MSM_CONSOLE,
 };
 
 static atomic_t msm_uart_next_id = ATOMIC_INIT(0);
@@ -1848,16 +1849,25 @@ static int __init msm_serial_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&msm_uart_driver);
+	ret = uart_allocate_console_dfl(&msm_uart_driver, &msm_cons_ops,
+					"ttyMSM", SERIAL_MSM_CONSOLE);
 	if (unlikely(ret))
 		return ret;
 
+	ret = uart_register_driver(&msm_uart_driver);
+	if (unlikely(ret))
+		goto err_put;
+
 	ret = platform_driver_register(&msm_platform_driver);
 	if (unlikely(ret))
-		uart_unregister_driver(&msm_uart_driver);
+		goto err_unregister;
 
 	pr_info("msm_serial: driver initialized\n");
 
+err_unregister:
+	uart_unregister_driver(&msm_uart_driver);
+err_put:
+	uart_put_console(&msm_uart_driver);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e8d19a..694fd2711bb7 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -408,19 +408,35 @@ static int mux_console_setup(struct console *co, char *options)
         return 0;
 }
 
-static struct console mux_console = {
-	.name =		"ttyB",
+static const struct console_operations mux_cons_ops = {
 	.write =	mux_console_write,
 	.device =	uart_console_device,
 	.setup =	mux_console_setup,
-	.flags =	CON_ENABLED | CON_PRINTBUFFER,
-	.index =	0,
-	.data =		&mux_driver,
 };
 
-#define MUX_CONSOLE	&mux_console
+static struct console __initdata *mux_console;
+
+static int register_mux_console(void)
+{
+	mux_console = allocate_console_dfl(&mux_cons_ops, "ttyB", &mux_driver);
+	if (!mux_console)
+		return -ENOMEM;
+
+	register_console(mux_console);
+	return 0;
+}
+
+static void unregister_mux_console(void)
+{
+	unregister_console(mux_console);
+	put_console(mux_console);
+}
+
+#define MUX_CONSOLE	(mux_console)
 #else
 #define MUX_CONSOLE	NULL
+static int register_mux_console(void) { return 0; }
+static void ungerister_mux_console(void) {}
 #endif
 
 static const struct uart_ops mux_pops = {
@@ -567,17 +583,19 @@ static struct parisc_driver serial_mux_driver __refdata = {
  */
 static int __init mux_init(void)
 {
+	int ret;
+
 	register_parisc_driver(&builtin_serial_mux_driver);
 	register_parisc_driver(&serial_mux_driver);
 
-	if(port_cnt > 0) {
+	if (port_cnt > 0) {
+		ret = register_mux_console();
+		if (ret)
+			return ret;
+
 		/* Start the Mux timer */
 		timer_setup(&mux_timer, mux_poll, 0);
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
-
-#ifdef CONFIG_SERIAL_MUX_CONSOLE
-	        register_console(&mux_console);
-#endif
 	}
 
 	return 0;
@@ -593,9 +611,7 @@ static void __exit mux_exit(void)
 	/* Delete the Mux timer. */
 	if(port_cnt > 0) {
 		del_timer_sync(&mux_timer);
-#ifdef CONFIG_SERIAL_MUX_CONSOLE
-		unregister_console(&mux_console);
-#endif
+		unregister_mux_console();
 	}
 
 	unregister_parisc_driver(&builtin_serial_mux_driver);
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 231f751d1ef4..9b001eeea9f7 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -624,6 +624,10 @@ static void mvebu_uart_putc_early_write(struct console *con,
 	uart_console_write(&dev->port, s, n, mvebu_uart_putc);
 }
 
+static const struct console_operations mvebu_early_cons_ops = {
+	.write = mvebu_uart_putc_early_write,
+};
+
 static int __init
 mvebu_uart_early_console_setup(struct earlycon_device *device,
 			       const char *opt)
@@ -631,8 +635,7 @@ mvebu_uart_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = mvebu_uart_putc_early_write;
-
+	device->con->ops = &mvebu_early_cons_ops;
 	return 0;
 }
 
@@ -715,25 +718,30 @@ static int mvebu_uart_console_setup(struct console *co, char *options)
 
 static struct uart_driver mvebu_uart_driver;
 
-static struct console mvebu_uart_console = {
-	.name	= "ttyMV",
+static const struct console_operations mvebu_cons_ops = {
 	.write	= mvebu_uart_console_write,
 	.device	= uart_console_device,
 	.setup	= mvebu_uart_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &mvebu_uart_driver,
 };
 
+static struct console __initdata *mvebu_uart_console;
+
 static int __init mvebu_uart_console_init(void)
 {
-	register_console(&mvebu_uart_console);
+	mvebu_uart_console = allocate_console_dfl(&mvebu_cons_ops, "ttyMV",
+						  &mvebu_uart_driver);
+	if (!mvebu_uart_console)
+		return -ENOMEM;
+
+	register_console(mvebu_uart_console);
 	return 0;
 }
 
 console_initcall(mvebu_uart_console_init);
 
-
+#define MVEBU_CONSOLE (mvebu_uart_console)
+#else
+#define MVEBU_CONSOLE NULL
 #endif /* CONFIG_SERIAL_MVEBU_CONSOLE */
 
 static struct uart_driver mvebu_uart_driver = {
@@ -741,9 +749,6 @@ static struct uart_driver mvebu_uart_driver = {
 	.driver_name		= DRIVER_NAME,
 	.dev_name		= "ttyMV",
 	.nr			= MVEBU_NR_UARTS,
-#ifdef CONFIG_SERIAL_MVEBU_CONSOLE
-	.cons			= &mvebu_uart_console,
-#endif
 };
 
 #if defined(CONFIG_PM)
@@ -974,6 +979,7 @@ static int __init mvebu_uart_init(void)
 {
 	int ret;
 
+	mvebu_uart_driver.cons = MVEBU_CONSOLE;
 	ret = uart_register_driver(&mvebu_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 27235a526cce..5d532627d8d4 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1471,15 +1471,14 @@ auart_console_setup(struct console *co, char *options)
 	return ret;
 }
 
-static struct console auart_console = {
-	.name		= "ttyAPP",
+static const struct console_operations auart_cons_ops = {
 	.write		= auart_console_write,
 	.device		= uart_console_device,
 	.setup		= auart_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &auart_driver,
 };
+
+#else
+static const struct console_operations auart_cons_ops;
 #endif
 
 static struct uart_driver auart_driver = {
@@ -1489,9 +1488,6 @@ static struct uart_driver auart_driver = {
 	.major		= 0,
 	.minor		= 0,
 	.nr		= MXS_AUART_PORTS,
-#ifdef CONFIG_SERIAL_MXS_AUART_CONSOLE
-	.cons =		&auart_console,
-#endif
 };
 
 static void mxs_init_regs(struct mxs_auart_port *s)
@@ -1783,6 +1779,11 @@ static int __init mxs_auart_init(void)
 {
 	int r;
 
+	r = uart_allocate_console_dfl(&auart_driver, &auart_cons_ops, "ttyAPP",
+				      SERIAL_MXS_AUART_CONSOLE);
+	if (r)
+		return r;
+
 	r = uart_register_driver(&auart_driver);
 	if (r)
 		goto out;
@@ -1795,6 +1796,7 @@ static int __init mxs_auart_init(void)
 out_err:
 	uart_unregister_driver(&auart_driver);
 out:
+	uart_put_console(&auart_driver);
 	return r;
 }
 
diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index b3556863491f..6533c1881902 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -612,24 +612,28 @@ netx_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver netx_reg;
-static struct console netx_console = {
-	.name		= "ttyNX",
+
+static const struct console_operations netx_cons_ops = {
 	.write		= netx_console_write,
 	.device		= uart_console_device,
 	.setup		= netx_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &netx_reg,
 };
 
+
+static struct console __initdata *netx_console;
+
 static int __init netx_console_init(void)
 {
-	register_console(&netx_console);
+	netx_console = allocate_console_dfl(&netx_cons_ops, "ttyNX", &netx_reg);
+	if (!netx_console)
+		return -ENOMEM;
+
+	register_console(netx_console);
 	return 0;
 }
 console_initcall(netx_console_init);
 
-#define NETX_CONSOLE	&netx_console
+#define NETX_CONSOLE	(netx_console)
 #else
 #define NETX_CONSOLE	NULL
 #endif
@@ -641,7 +645,6 @@ static struct uart_driver netx_reg = {
 	.major          = SERIAL_NX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(netx_ports),
-	.cons           = NETX_CONSOLE,
 };
 
 static int serial_netx_suspend(struct platform_device *pdev, pm_message_t state)
@@ -707,6 +710,7 @@ static int __init netx_serial_init(void)
 
 	printk(KERN_INFO "Serial: NetX driver\n");
 
+	netx_reg.cons = NETX_CONSOLE;
 	ret = uart_register_driver(&netx_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae581a80..090fa8a46e4a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1266,6 +1266,10 @@ static void early_omap_serial_write(struct console *console, const char *s,
 	uart_console_write(port, s, count, omap_serial_early_putc);
 }
 
+static const struct console_operations omap_early_cons_ops = {
+	.write = early_omap_serial_write,
+};
+
 static int __init early_omap_serial_setup(struct earlycon_device *device,
 					  const char *options)
 {
@@ -1275,7 +1279,7 @@ static int __init early_omap_serial_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	port->regshift = 2;
-	device->con->write = early_omap_serial_write;
+	device->con->ops = &omap_early_cons_ops;
 	return 0;
 }
 
@@ -1365,14 +1369,10 @@ serial_omap_console_setup(struct console *co, char *options)
 	return uart_set_options(&up->port, co, baud, parity, bits, flow);
 }
 
-static struct console serial_omap_console = {
-	.name		= OMAP_SERIAL_NAME,
+static const struct console_operations omap_cons_ops = {
 	.write		= serial_omap_console_write,
 	.device		= uart_console_device,
 	.setup		= serial_omap_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial_omap_reg,
 };
 
 static void serial_omap_add_console_port(struct uart_omap_port *up)
@@ -1380,15 +1380,9 @@ static void serial_omap_add_console_port(struct uart_omap_port *up)
 	serial_omap_console_ports[up->port.line] = up;
 }
 
-#define OMAP_CONSOLE	(&serial_omap_console)
-
 #else
-
-#define OMAP_CONSOLE	NULL
-
-static inline void serial_omap_add_console_port(struct uart_omap_port *up)
-{}
-
+static const struct console_operations omap_cons_ops;
+static inline void serial_omap_add_console_port(struct uart_omap_port *up) {}
 #endif
 
 /* Enable or disable the rs485 support */
@@ -1476,7 +1470,6 @@ static struct uart_driver serial_omap_reg = {
 	.driver_name	= "OMAP-SERIAL",
 	.dev_name	= OMAP_SERIAL_NAME,
 	.nr		= OMAP_MAX_HSUART_PORTS,
-	.cons		= OMAP_CONSOLE,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -1929,12 +1922,25 @@ static int __init serial_omap_init(void)
 {
 	int ret;
 
+	ret = uart_allocate_console_dfl(&serial_omap_reg, &omap_cons_ops,
+					OMAP_SERIAL_NAME, SERIAL_OMAP_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&serial_omap_reg);
 	if (ret != 0)
-		return ret;
+		goto out;
+
 	ret = platform_driver_register(&serial_omap_driver);
 	if (ret != 0)
-		uart_unregister_driver(&serial_omap_reg);
+		goto out_unregister;
+
+	return 0;
+
+out_unregister:
+	uart_unregister_driver(&serial_omap_reg);
+out:
+	uart_put_console(&serial_omap_reg);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..7dc2b50eee6a 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -567,20 +567,23 @@ static int owl_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(&owl_port->port, co, baud, parity, bits, flow);
 }
 
-static struct console owl_uart_console = {
-	.name = OWL_UART_DEV_NAME,
+static const struct console_operations owl_uart_cons_ops = {
 	.write = owl_uart_console_write,
 	.device = uart_console_device,
 	.setup = owl_uart_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &owl_uart_driver,
 };
 
+static struct console __initdata *owl_uart_console;
+
 static int __init owl_uart_console_init(void)
 {
-	register_console(&owl_uart_console);
+	owl_uart_console = allocate_console_dfl(&owl_uart_cons_ops,
+						OWL_UART_DEV_NAME,
+						&owl_uart_driver);
+	if (!owl_uart_console)
+		return -ENOMEM;
 
+	register_console(owl_uart_console);
 	return 0;
 }
 console_initcall(owl_uart_console_init);
@@ -594,20 +597,26 @@ static void owl_uart_early_console_write(struct console *co,
 	owl_uart_port_write(&dev->port, s, count);
 }
 
+static const struct console_operations owl_uart_early_cons_ops = {
+	.write = owl_uart_early_console_write,
+};
+
 static int __init
 owl_uart_early_console_setup(struct earlycon_device *device, const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = owl_uart_early_console_write;
-
+	/*
+	 * FIXME: Where does this console struct come from?
+	 */
+	device->con->ops = &owl_uart_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(owl, "actions,owl-uart",
 		    owl_uart_early_console_setup);
 
-#define OWL_UART_CONSOLE (&owl_uart_console)
+#define OWL_UART_CONSOLE (owl_uart_console)
 #else
 #define OWL_UART_CONSOLE NULL
 #endif
@@ -617,7 +626,6 @@ static struct uart_driver owl_uart_driver = {
 	.driver_name = "owl-uart",
 	.dev_name = OWL_UART_DEV_NAME,
 	.nr = OWL_UART_PORT_NUM,
-	.cons = OWL_UART_CONSOLE,
 };
 
 static const struct owl_uart_info owl_s500_info = {
@@ -731,6 +739,7 @@ static int __init owl_uart_init(void)
 {
 	int ret;
 
+	owl_uart_driver.cons = OWL_UART_CONSOLE;
 	ret = uart_register_driver(&owl_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9ed121f08a54..aa70a0cf206f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1705,19 +1705,14 @@ static int __init pch_console_setup(struct console *co, char *options)
 
 static struct uart_driver pch_uart_driver;
 
-static struct console pch_console = {
-	.name		= PCH_UART_DRIVER_DEVICE,
+static const struct console_operations pch_cons_ops = {
 	.write		= pch_console_write,
 	.device		= uart_console_device,
 	.setup		= pch_console_setup,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
-	.index		= -1,
-	.data		= &pch_uart_driver,
 };
 
-#define PCH_CONSOLE	(&pch_console)
 #else
-#define PCH_CONSOLE	NULL
+static const struct console_operations pch_cons_ops;
 #endif	/* CONFIG_SERIAL_PCH_UART_CONSOLE */
 
 static struct uart_driver pch_uart_driver = {
@@ -1727,7 +1722,6 @@ static struct uart_driver pch_uart_driver = {
 	.major = 0,
 	.minor = 0,
 	.nr = PCH_UART_NR,
-	.cons = PCH_CONSOLE,
 };
 
 static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
@@ -1963,16 +1957,28 @@ static int __init pch_uart_module_init(void)
 {
 	int ret;
 
+	ret = uart_allocate_console_dfl(&pch_uart_driver, &pch_cons_ops,
+					PCH_UART_DRIVER_DEVICE,
+					SERIAL_PCH_UART_CONSOLE);
+	if (ret)
+		return ret;
+
 	/* register as UART driver */
 	ret = uart_register_driver(&pch_uart_driver);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* register as PCI driver */
 	ret = pci_register_driver(&pch_uart_pci_driver);
 	if (ret < 0)
-		uart_unregister_driver(&pch_uart_driver);
+		goto out_unregister;
 
+	return 0;
+
+out_unregister:
+	uart_unregister_driver(&pch_uart_driver);
+out:
+	uart_put_console(&pch_uart_driver);
 	return ret;
 }
 module_init(pch_uart_module_init);
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0bdf1687983f..ddba3ccfdec8 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -750,20 +750,24 @@ static int pic32_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver pic32_uart_driver;
-static struct console pic32_console = {
-	.name		= PIC32_SDEV_NAME,
+
+static const struct console_operations pic32_cons_ops = {
 	.write		= pic32_console_write,
 	.device		= uart_console_device,
 	.setup		= pic32_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &pic32_uart_driver,
 };
-#define PIC32_SCONSOLE (&pic32_console)
+
+static struct console *pic32_console;
+#define PIC32_SCONSOLE (pic32_console)
 
 static int __init pic32_console_init(void)
 {
-	register_console(&pic32_console);
+	pic32_console = allocate_console_dfl(&pic32_cons_ops, PIC32_SDEV_NAME,
+					     &pic32_uart_driver);
+	if (!pic32_console)
+		return -ENOMEM;
+
+	register_console(pic32_console);
 	return 0;
 }
 console_initcall(pic32_console_init);
@@ -778,8 +782,8 @@ static inline bool is_pic32_console_port(struct uart_port *port)
  */
 static int __init pic32_late_console_init(void)
 {
-	if (!(pic32_console.flags & CON_ENABLED))
-		register_console(&pic32_console);
+	if (!pic32_console)
+		return pic32_console_init();
 
 	return 0;
 }
@@ -795,7 +799,6 @@ static struct uart_driver pic32_uart_driver = {
 	.driver_name		= PIC32_DEV_NAME,
 	.dev_name		= PIC32_SDEV_NAME,
 	.nr			= PIC32_MAX_UARTS,
-	.cons			= PIC32_SCONSOLE,
 };
 
 static int pic32_uart_probe(struct platform_device *pdev)
@@ -873,8 +876,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
-	if (is_pic32_console_port(port) &&
-	    (pic32_console.flags & CON_ENABLED)) {
+	if (is_pic32_console_port(port) && pic32_console) {
 		/* The peripheral clock has been enabled by console_setup,
 		 * so disable it till the port is used.
 		 */
@@ -927,6 +929,7 @@ static int __init pic32_uart_init(void)
 {
 	int ret;
 
+	pic32_uart_driver.cons = PIC32_SCONSOLE;
 	ret = uart_register_driver(&pic32_uart_driver);
 	if (ret) {
 		pr_err("failed to register %s:%d\n",
@@ -947,7 +950,8 @@ arch_initcall(pic32_uart_init);
 static void __exit pic32_uart_exit(void)
 {
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
-	unregister_console(&pic32_console);
+	unregister_console(pic32_console);
+	put_console(pic32_console);
 #endif
 	platform_driver_unregister(&pic32_uart_platform_driver);
 	uart_unregister_driver(&pic32_uart_driver);
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index bcb5bf70534e..de67ee47e1fc 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1799,17 +1799,15 @@ static int __exit pmz_detach(struct platform_device *pdev)
 static void pmz_console_write(struct console *con, const char *s, unsigned int count);
 static int __init pmz_console_setup(struct console *co, char *options);
 
-static struct console pmz_console = {
-	.name	=	PMACZILOG_NAME,
+static const struct console_operations pmz_cons_ops = {
 	.write	=	pmz_console_write,
 	.device	=	uart_console_device,
 	.setup	=	pmz_console_setup,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data   =	&pmz_uart_reg,
 };
 
-#define PMACZILOG_CONSOLE	&pmz_console
+static struct console __initdata *pmz_console;
+
+#define PMACZILOG_CONSOLE	(pmz_console)
 #else /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
 #define PMACZILOG_CONSOLE	(NULL)
 #endif /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
@@ -2042,12 +2040,15 @@ static int __init pmz_console_init(void)
 	if (pmz_ports_count == 0)
 		return -ENODEV;
 
+	pmz_console = allocate_console_dfl(&pmz_cons_ops, PMACZILOG_NAME,
+					   &pmz_uart_reg);
+	if (!pmz_console)
+		return -ENOMEM;
+
 	/* TODO: Autoprobe console based on OF */
 	/* pmz_console.index = i; */
-	register_console(&pmz_console);
-
+	register_console(pmz_console);
 	return 0;
-
 }
 console_initcall(pmz_console_init);
 #endif /* CONFIG_SERIAL_PMACZILOG_CONSOLE */
diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a9499104e..f01c27d30015 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -740,25 +740,29 @@ pnx8xxx_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver pnx8xxx_reg;
-static struct console pnx8xxx_console = {
-	.name		= "ttyS",
+
+static const struct console_operations pnx8xxx_cons_ops = {
 	.write		= pnx8xxx_console_write,
 	.device		= uart_console_device,
 	.setup		= pnx8xxx_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &pnx8xxx_reg,
 };
 
+static struct console __initdata *pnx8xxx_console;
+
 static int __init pnx8xxx_rs_console_init(void)
 {
+	pnx8xxx_console = allocate_console_dfl(&pnx8xxx_cons_ops, "ttyS",
+					       &pnx8xxx_reg);
+	if (!pnx8xxx_console)
+		return -ENOMEM;
+
 	pnx8xxx_init_ports();
-	register_console(&pnx8xxx_console);
+	register_console(pnx8xxx_console);
 	return 0;
 }
 console_initcall(pnx8xxx_rs_console_init);
 
-#define PNX8XXX_CONSOLE	&pnx8xxx_console
+#define PNX8XXX_CONSOLE	(pnx8xxx_console)
 #else
 #define PNX8XXX_CONSOLE	NULL
 #endif
@@ -770,7 +774,6 @@ static struct uart_driver pnx8xxx_reg = {
 	.major			= SERIAL_PNX8XXX_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
-	.cons			= PNX8XXX_CONSOLE,
 };
 
 static int pnx8xxx_serial_suspend(struct platform_device *pdev, pm_message_t state)
@@ -838,6 +841,7 @@ static int __init pnx8xxx_serial_init(void)
 
 	pnx8xxx_init_ports();
 
+	pnx8xxx_reg.cons = PNX8XXX_CONSOLE;
 	ret = uart_register_driver(&pnx8xxx_reg);
 	if (ret == 0) {
 		ret = platform_driver_register(&pnx8xxx_serial_driver);
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b674f7ef..47b35ff9a48f 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -743,19 +743,14 @@ serial_pxa_console_setup(struct console *co, char *options)
 	return uart_set_options(&up->port, co, baud, parity, bits, flow);
 }
 
-static struct console serial_pxa_console = {
-	.name		= "ttyS",
+static const struct console_operations pxa_cons_ops = {
 	.write		= serial_pxa_console_write,
 	.device		= uart_console_device,
 	.setup		= serial_pxa_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial_pxa_reg,
 };
 
-#define PXA_CONSOLE	&serial_pxa_console
 #else
-#define PXA_CONSOLE	NULL
+static const struct console_operations pxa_cons_ops;
 #endif
 
 static const struct uart_ops serial_pxa_pops = {
@@ -789,7 +784,6 @@ static struct uart_driver serial_pxa_reg = {
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= 4,
-	.cons		= PXA_CONSOLE,
 };
 
 #ifdef CONFIG_PM
@@ -932,14 +926,25 @@ static int __init serial_pxa_init(void)
 {
 	int ret;
 
+	ret = uart_allocate_console_dfl(&serial_pxa_reg, &pxa_cons_ops, "ttyS",
+					SERIAL_PXA_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&serial_pxa_reg);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	ret = platform_driver_register(&serial_pxa_driver);
 	if (ret != 0)
-		uart_unregister_driver(&serial_pxa_reg);
+		goto out_unregister;
+
+	return 0;
 
+out_unregister:
+	uart_unregister_driver(&serial_pxa_reg);
+out:
+	uart_put_console(&serial_pxa_reg);
 	return ret;
 }
 device_initcall(serial_pxa_init);
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 38016609c7fa..0d50607687c3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1157,6 +1157,10 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
 	__qcom_geni_serial_console_write(&dev->port, s, n);
 }
 
+static const struct console_operations qcom_geni_early_ops = {
+	.write = qcom_geni_serial_earlycon_write,
+};
+
 static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 								const char *opt)
 {
@@ -1201,31 +1205,16 @@ static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 	writel_relaxed(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel_relaxed(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
 
-	dev->con->write = qcom_geni_serial_earlycon_write;
-	dev->con->setup = NULL;
+	dev->con->ops = &qcom_geni_early_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(qcom_geni, "qcom,geni-debug-uart",
 				qcom_geni_serial_earlycon_setup);
 
-static int __init console_register(struct uart_driver *drv)
-{
-	return uart_register_driver(drv);
-}
-
-static void console_unregister(struct uart_driver *drv)
-{
-	uart_unregister_driver(drv);
-}
-
-static struct console cons_ops = {
-	.name = "ttyMSM",
+static const struct console_operations qcom_geni_cons_ops = {
 	.write = qcom_geni_serial_console_write,
 	.device = uart_console_device,
 	.setup = qcom_geni_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &qcom_geni_console_driver,
 };
 
 static struct uart_driver qcom_geni_console_driver = {
@@ -1233,17 +1222,9 @@ static struct uart_driver qcom_geni_console_driver = {
 	.driver_name = "qcom_geni_console",
 	.dev_name = "ttyMSM",
 	.nr =  GENI_UART_CONS_PORTS,
-	.cons = &cons_ops,
 };
 #else
-static int console_register(struct uart_driver *drv)
-{
-	return 0;
-}
-
-static void console_unregister(struct uart_driver *drv)
-{
-}
+static const struct console_operations qcom_geni_cons_ops;
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static struct uart_driver qcom_geni_uart_driver = {
@@ -1423,21 +1404,26 @@ static int __init qcom_geni_serial_init(void)
 {
 	int ret;
 
-	ret = console_register(&qcom_geni_console_driver);
+	ret = uart_allocate_console_dfl(&qcom_geni_console_driver,
+					&qcom_geni_cons_ops, "ttyMSM",
+					SERIAL_QCOM_GENI_CONSOLE);
 	if (ret)
 		return ret;
 
 	ret = uart_register_driver(&qcom_geni_uart_driver);
-	if (ret) {
-		console_unregister(&qcom_geni_console_driver);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
 	ret = platform_driver_register(&qcom_geni_serial_platform_driver);
-	if (ret) {
-		console_unregister(&qcom_geni_console_driver);
-		uart_unregister_driver(&qcom_geni_uart_driver);
-	}
+	if (ret)
+		goto out_unregister;
+
+	return 0;
+
+out_unregister:
+	uart_unregister_driver(&qcom_geni_uart_driver);
+out:
+	uart_put_console(&qcom_geni_uart_driver);
 	return ret;
 }
 module_init(qcom_geni_serial_init);
@@ -1445,7 +1431,6 @@ module_init(qcom_geni_serial_init);
 static void __exit qcom_geni_serial_exit(void)
 {
 	platform_driver_unregister(&qcom_geni_serial_platform_driver);
-	console_unregister(&qcom_geni_console_driver);
 	uart_unregister_driver(&qcom_geni_uart_driver);
 }
 module_exit(qcom_geni_serial_exit);
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 284623eefaeb..8dc1429c27a0 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -654,20 +654,23 @@ static int rda_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(&rda_port->port, co, baud, parity, bits, flow);
 }
 
-static struct console rda_uart_console = {
-	.name = RDA_UART_DEV_NAME,
+static const struct console_operations rda_cons_ops = {
 	.write = rda_uart_console_write,
 	.device = uart_console_device,
 	.setup = rda_uart_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &rda_uart_driver,
 };
 
+static struct console __initdata *rda_uart_console;
+
 static int __init rda_uart_console_init(void)
 {
-	register_console(&rda_uart_console);
+	rda_uart_console = allocate_console_dfl(&rda_cons_ops,
+						RDA_UART_DEV_NAME,
+						&rda_uart_driver);
+	if (!rda_uart_console)
+		return -ENOMEM;
 
+	register_console(rda_uart_console);
 	return 0;
 }
 console_initcall(rda_uart_console_init);
@@ -681,21 +684,24 @@ static void rda_uart_early_console_write(struct console *co,
 	rda_uart_port_write(&dev->port, s, count);
 }
 
+static const struct console_operations rda_early_cons_ops = {
+	.write = rda_uart_early_console_write,
+};
+
 static int __init
 rda_uart_early_console_setup(struct earlycon_device *device, const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = rda_uart_early_console_write;
-
+	device->con->ops = &rda_early_cons_ops;
 	return 0;
 }
 
 OF_EARLYCON_DECLARE(rda, "rda,8810pl-uart",
 		    rda_uart_early_console_setup);
 
-#define RDA_UART_CONSOLE (&rda_uart_console)
+#define RDA_UART_CONSOLE (rda_uart_console)
 #else
 #define RDA_UART_CONSOLE NULL
 #endif /* CONFIG_SERIAL_RDA_CONSOLE */
@@ -705,7 +711,6 @@ static struct uart_driver rda_uart_driver = {
 	.driver_name = "rda-uart",
 	.dev_name = RDA_UART_DEV_NAME,
 	.nr = RDA_UART_PORT_NUM,
-	.cons = RDA_UART_CONSOLE,
 };
 
 static const struct of_device_id rda_uart_dt_matches[] = {
@@ -806,6 +811,7 @@ static int __init rda_uart_init(void)
 {
 	int ret;
 
+	rda_uart_driver.cons = RDA_UART_CONSOLE;
 	ret = uart_register_driver(&rda_uart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index a399772be3fc..2eb016e547ae 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -789,25 +789,29 @@ sa1100_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver sa1100_reg;
-static struct console sa1100_console = {
-	.name		= "ttySA",
+
+static const struct console_operations sa1100_cons_ops = {
 	.write		= sa1100_console_write,
 	.device		= uart_console_device,
 	.setup		= sa1100_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &sa1100_reg,
 };
 
+static struct console __initdata *sa1100_console;
+
 static int __init sa1100_rs_console_init(void)
 {
+	sa1100_console = allocate_console_dfl(&sa1100_cons_ops, "ttySA",
+					      &sa1100_reg);
+	if (!sa1100_console)
+		return -ENOMEM;
+
 	sa1100_init_ports();
-	register_console(&sa1100_console);
+	register_console(sa1100_console);
 	return 0;
 }
 console_initcall(sa1100_rs_console_init);
 
-#define SA1100_CONSOLE	&sa1100_console
+#define SA1100_CONSOLE	(sa1100_console)
 #else
 #define SA1100_CONSOLE	NULL
 #endif
@@ -819,7 +823,6 @@ static struct uart_driver sa1100_reg = {
 	.major			= SERIAL_SA1100_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
-	.cons			= SA1100_CONSOLE,
 };
 
 static int sa1100_serial_suspend(struct platform_device *dev, pm_message_t state)
@@ -894,6 +897,7 @@ static int __init sa1100_serial_init(void)
 
 	sa1100_init_ports();
 
+	sd1100_reg.cons	= SA1100_CONSOLE;
 	ret = uart_register_driver(&sa1100_reg);
 	if (ret == 0) {
 		ret = platform_driver_register(&sa11x0_serial_driver);
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 9fc3559f80d9..990093d992e5 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1471,18 +1471,37 @@ s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
 
-static struct console s3c24xx_serial_console;
+static const struct console_operations s3c24xx_cons_ops;
+static struct uart_driver s3c24xx_uart_drv;
+
+static struct console *s3c24xx_serial_console;
 
 static int __init s3c24xx_serial_console_init(void)
 {
-	register_console(&s3c24xx_serial_console);
+	s3c24xx_serial_console = allocate_console_dfl(&s3c24xx_cons_ops,
+						      S3C24XX_SERIAL_NAME,
+						      &s3c24xx_uart_drv);
+	if (!s3c24xx_serial_console)
+		return -ENOMEM;
+
+	register_console(s3c24xx_serial_console);
 	return 0;
 }
 console_initcall(s3c24xx_serial_console_init);
 
-#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
+/*
+ * Since we need this in ->probe(), the static pointer can't be __init, so the
+ * following ugliness cleans up the "dangling reference" in the built-in case.
+ */
+#define S3C24XX_SERIAL_CONSOLE()			\
+({							\
+	struct console *__con = s3c24xx_serial_console; \
+	s3c24xx_serial_console = NULL;			\
+	__con;						\
+})
+
 #else
-#define S3C24XX_SERIAL_CONSOLE NULL
+#define S3C24XX_SERIAL_CONSOLE() (NULL)
 #endif
 
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
@@ -1518,7 +1537,6 @@ static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
-	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
@@ -1884,6 +1902,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		return ret;
 
 	if (!s3c24xx_uart_drv.state) {
+		s3c24xx_uart_drv.cons = S3C24XX_SERIAL_CONSOLE();
 		ret = uart_register_driver(&s3c24xx_uart_drv);
 		if (ret < 0) {
 			pr_err("Failed to register Samsung UART driver\n");
@@ -2196,14 +2215,10 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct console s3c24xx_serial_console = {
-	.name		= S3C24XX_SERIAL_NAME,
+static const struct console_operations s3c24xx_cons_ops = {
 	.device		= uart_console_device,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 	.write		= s3c24xx_serial_console_write,
 	.setup		= s3c24xx_serial_console_setup,
-	.data		= &s3c24xx_uart_drv,
 };
 #endif /* CONFIG_SERIAL_SAMSUNG_CONSOLE */
 
@@ -2488,13 +2503,17 @@ static void samsung_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, samsung_early_putc);
 }
 
+static const struct console_operations samsung_early_cons_ops = {
+	.write = samsung_early_write,
+};
+
 static int __init samsung_early_console_setup(struct earlycon_device *device,
 					      const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = samsung_early_write;
+	device->con->ops = &samsung_early_cons_ops;
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced26bd8..c5ab9b590303 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -888,27 +888,29 @@ static int __init sbd_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver sbd_reg;
-static struct console sbd_console = {
-	.name	= "duart",
+
+static const struct console_operations sdb_cons_ops = {
 	.write	= sbd_console_write,
 	.device	= uart_console_device,
 	.setup	= sbd_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &sbd_reg
 };
 
+static struct console __initdata *sbd_console;
+
 static int __init sbd_serial_console_init(void)
 {
-	sbd_probe_duarts();
-	register_console(&sbd_console);
+	sbd_console = allocate_console_dfl(&sdb_cons_ops, "duart", &sbd_reg);
+	if (!sbd_console)
+		return -ENOMEM;
 
+	sbd_probe_duarts();
+	register_console(sbd_console);
 	return 0;
 }
 
 console_initcall(sbd_serial_console_init);
 
-#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
+#define SERIAL_SB1250_DUART_CONSOLE	(sbd_console)
 #else
 #define SERIAL_SB1250_DUART_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_SB1250_DUART_CONSOLE */
@@ -921,7 +923,6 @@ static struct uart_driver sbd_reg = {
 	.major		= TTY_MAJOR,
 	.minor		= SB1250_DUART_MINOR_BASE,
 	.nr		= DUART_MAX_CHIP * DUART_MAX_SIDE,
-	.cons		= SERIAL_SB1250_DUART_CONSOLE,
 };
 
 /* Set up the driver and register it.  */
@@ -931,6 +932,7 @@ static int __init sbd_init(void)
 
 	sbd_probe_duarts();
 
+	sbd_reg.cons = SERIAL_SB1250_DUART_CONSOLE;
 	ret = uart_register_driver(&sbd_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 68a24a14f6b7..46d0f0e9fd92 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -867,6 +867,15 @@ static int sccnxp_console_setup(struct console *co, char *options)
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
+
+static const struct console_operations sccnxp_cons_ops = {
+	.device	= uart_console_device,
+	.write	= sccnxp_console_write,
+	.setup	= sccnxp_console_setup,
+};
+
+#else
+static const struct console_operations sccnxp_cons_ops;
 #endif
 
 static const struct platform_device_id sccnxp_id_table[] = {
@@ -972,16 +981,12 @@ static int sccnxp_probe(struct platform_device *pdev)
 	s->uart.major		= SCCNXP_MAJOR;
 	s->uart.minor		= SCCNXP_MINOR;
 	s->uart.nr		= s->chip->nr;
-#ifdef CONFIG_SERIAL_SCCNXP_CONSOLE
-	s->uart.cons		= &s->console;
-	s->uart.cons->device	= uart_console_device;
-	s->uart.cons->write	= sccnxp_console_write;
-	s->uart.cons->setup	= sccnxp_console_setup;
-	s->uart.cons->flags	= CON_PRINTBUFFER;
-	s->uart.cons->index	= -1;
-	s->uart.cons->data	= s;
-	strcpy(s->uart.cons->name, "ttySC");
-#endif
+
+	ret = uart_allocate_console_dfl(&s->uart, &sccnxp_cons_ops, "ttySC",
+					SERIAL_SCCNXP_CONSOLE);
+	if (ret)
+		goto err_out;
+
 	ret = uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
@@ -1033,6 +1038,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	if (!IS_ERR(s->regulator))
 		regulator_disable(s->regulator);
 
+	uart_put_console(&s->uart);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 556f50aa1b58..208eb735f086 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2581,6 +2581,14 @@ void uart_unregister_driver(struct uart_driver *drv)
 	kfree(drv->state);
 	drv->state = NULL;
 	drv->tty_driver = NULL;
+
+	if (drv->cons) {
+		/*
+		 * This is the base reference from uart_allocate_console()
+		 */
+		put_device(&drv->cons->dev);
+		drv->cons = NULL;
+	}
 }
 
 struct tty_driver *uart_console_device(struct console *co, int *index)
@@ -2914,10 +2922,14 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 
 	/*
-	 * If the port is used as a console, unregister it
+	 * If the port is used as a console, unregister it. This put() pairs
+	 * with the base reference obtained by drivers via allocate_console().
 	 */
-	if (uart_console(uport))
+	if (uart_console(uport)) {
 		unregister_console(uport->cons);
+		put_console(uport->cons);
+		uport->cons = NULL;
+	}
 
 	/*
 	 * Free the port IO and memory resources, if any.
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d791188c..f89889c33372 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -96,11 +96,6 @@ static inline void tx_enable(struct uart_port *port, int enabled)
 		port->unused[0] &= ~1;
 }
 
-
-#ifdef SUPPORT_SYSRQ
-static struct console ks8695_console;
-#endif
-
 static void ks8695uart_stop_tx(struct uart_port *port)
 {
 	if (tx_enabled(port)) {
@@ -631,26 +626,30 @@ static int __init ks8695_console_setup(struct console *co, char *options)
 
 static struct uart_driver ks8695_reg;
 
-static struct console ks8695_console = {
-	.name		= SERIAL_KS8695_DEVNAME,
+static const struct console_operations ks8695_cons_ops = {
 	.write		= ks8695_console_write,
 	.device		= uart_console_device,
 	.setup		= ks8695_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &ks8695_reg,
 };
 
+static struct console __initdata *ks8695_console;
+
 static int __init ks8695_console_init(void)
 {
+	ks8695_console = allocate_console_dfl(&ks8695_cons_ops,
+					      SERIAL_KS8695_DEVNAME,
+					      &ks8695_reg);
+	if (!ks8695_console)
+		return -ENOMEM;
+
 	add_preferred_console(SERIAL_KS8695_DEVNAME, 0, NULL);
-	register_console(&ks8695_console);
+	register_console(ks8695_console);
 	return 0;
 }
 
 console_initcall(ks8695_console_init);
 
-#define KS8695_CONSOLE	&ks8695_console
+#define KS8695_CONSOLE	(ks8695_console)
 #else
 #define KS8695_CONSOLE	NULL
 #endif
@@ -662,7 +661,6 @@ static struct uart_driver ks8695_reg = {
 	.major			= SERIAL_KS8695_MAJOR,
 	.minor			= SERIAL_KS8695_MINOR,
 	.nr			= SERIAL_KS8695_NR,
-	.cons			= KS8695_CONSOLE,
 };
 
 static int __init ks8695uart_init(void)
@@ -671,6 +669,7 @@ static int __init ks8695uart_init(void)
 
 	printk(KERN_INFO "Serial: Micrel KS8695 UART driver\n");
 
+	ks8695_reg.cons	= KS8695_CONSOLE;
 	ret = uart_register_driver(&ks8695_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 1b4008d022bf..6e0c11625e6d 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -957,24 +957,29 @@ static int __init serial_txx9_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver serial_txx9_reg;
-static struct console serial_txx9_console = {
-	.name		= TXX9_TTY_NAME,
+
+static const struct console_operations txx9_cons_ops = {
 	.write		= serial_txx9_console_write,
 	.device		= uart_console_device,
 	.setup		= serial_txx9_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial_txx9_reg,
 };
 
+static struct console __initdata *serial_txx9_console;
+
 static int __init serial_txx9_console_init(void)
 {
-	register_console(&serial_txx9_console);
+	serial_txx9_console = allocate_console_dfl(&txx9_cons_ops,
+						   TXX9_TTY_NAME,
+						   &serial_txx9_reg);
+	if (!serial_txx9_console)
+		return -ENOMEM;
+
+	register_console(serial_txx9_console);
 	return 0;
 }
 console_initcall(serial_txx9_console_init);
 
-#define SERIAL_TXX9_CONSOLE	&serial_txx9_console
+#define SERIAL_TXX9_CONSOLE	(serial_txx9_console)
 #else
 #define SERIAL_TXX9_CONSOLE	NULL
 #endif
@@ -986,7 +991,6 @@ static struct uart_driver serial_txx9_reg = {
 	.major			= TXX9_TTY_MAJOR,
 	.minor			= TXX9_TTY_MINOR_START,
 	.nr			= UART_NR,
-	.cons			= SERIAL_TXX9_CONSOLE,
 };
 
 int __init early_serial_txx9_setup(struct uart_port *port)
@@ -1261,6 +1265,7 @@ static int __init serial_txx9_init(void)
 
  	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
 
+	serial_txx9_reg.cons = SERIAL_TXX9_CONSOLE;
 	ret = uart_register_driver(&serial_txx9_reg);
 	if (ret)
 		goto out;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 64bbeb7d7e0c..de3ac3c07cb9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3049,21 +3049,22 @@ static int serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct console serial_console = {
-	.name		= "ttySC",
+static const struct console_operations sci_cons_ops = {
 	.device		= uart_console_device,
 	.write		= serial_console_write,
 	.setup		= serial_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &sci_uart_driver,
+};
+
+static const struct console_operations early_sci_cons_ops = {
+	.write          = serial_console_write,
 };
 
 static struct console early_serial_console = {
 	.name           = "early_ttySC",
-	.write          = serial_console_write,
+	.ops		= &early_sci_cons_ops,
 	.flags          = CON_PRINTBUFFER,
 	.index		= -1,
+	.is_static	= 1,
 };
 
 static char early_serial_buf[32];
@@ -3088,15 +3089,14 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 	return 0;
 }
 
-#define SCI_CONSOLE	(&serial_console)
-
 #else
+
 static inline int sci_probe_earlyprintk(struct platform_device *pdev)
 {
 	return -EINVAL;
 }
 
-#define SCI_CONSOLE	NULL
+static const struct console_operations sci_cons_ops;
 
 #endif /* CONFIG_SERIAL_SH_SCI_CONSOLE || CONFIG_SERIAL_SH_SCI_EARLYCON */
 
@@ -3110,7 +3110,6 @@ static struct uart_driver sci_uart_driver = {
 	.major		= SCI_MAJOR,
 	.minor		= SCI_MINOR_START,
 	.nr		= SCI_NPORTS,
-	.cons		= SCI_CONSOLE,
 };
 
 static int sci_remove(struct platform_device *dev)
@@ -3245,21 +3244,30 @@ static int sci_probe_single(struct platform_device *dev,
 
 	mutex_lock(&sci_uart_registration_lock);
 	if (!sci_uart_driver.state) {
-		ret = uart_register_driver(&sci_uart_driver);
+		ret = uart_allocate_console_dfl(&sci_uart_driver, &sci_cons_ops,
+						"ttySC", SERIAL_SH_SCI_CONSOLE);
 		if (ret) {
 			mutex_unlock(&sci_uart_registration_lock);
 			return ret;
 		}
+
+		ret = uart_register_driver(&sci_uart_driver);
+		if (ret) {
+			mutex_unlock(&sci_uart_registration_lock);
+			goto out;
+		}
 	}
 	mutex_unlock(&sci_uart_registration_lock);
 
 	ret = sci_init_single(dev, sciport, index, p, false);
 	if (ret)
-		return ret;
+		goto out_unregister;
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
-		return PTR_ERR(sciport->gpios);
+	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS) {
+		ret = PTR_ERR(sciport->gpios);
+		goto out_unregister;
+	};
 
 	if (sciport->has_rtscts) {
 		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
@@ -3267,18 +3275,25 @@ static int sci_probe_single(struct platform_device *dev,
 		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
 							UART_GPIO_RTS))) {
 			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_unregister;
 		}
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
+	if (ret)
+		goto out_cleanup;
 
 	return 0;
+
+out_cleanup:
+	sci_cleanup_single(sciport);
+out_unregister:
+	uart_unregister_driver(&sci_uart_driver);
+out:
+	uart_put_console(&sci_uart_driver);
+	return ret;
 }
 
 static int sci_probe(struct platform_device *dev)
@@ -3415,7 +3430,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
-	device->con->write = serial_console_write;
+	device->con->ops = &early_sci_cons_ops;
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 38622f2a30a9..fe0a26e06b65 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1132,22 +1132,30 @@ static void sirfsoc_uart_console_write(struct console *co, const char *s,
 			sirfsoc_uart_console_putchar);
 }
 
-static struct console sirfsoc_uart_console = {
-	.name		= SIRFSOC_UART_NAME,
+static const struct console_operations sirfsoc_cons_ops = {
 	.device		= uart_console_device,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 	.write		= sirfsoc_uart_console_write,
 	.setup		= sirfsoc_uart_console_setup,
-	.data           = &sirfsoc_uart_drv,
 };
 
+static struct console __initdata *sirfsoc_uart_console;
+
 static int __init sirfsoc_uart_console_init(void)
 {
-	register_console(&sirfsoc_uart_console);
+	sirfsoc_uart_console = allocate_console_dfl(&sirfsoc_cons_ops,
+						    SIRFSOC_UART_NAME,
+						    &sirfsoc_uart_drv);
+	if (!sirfsoc_uart_console)
+		return -ENOMEM;
+
+	register_console(sirfsoc_uart_console);
 	return 0;
 }
 console_initcall(sirfsoc_uart_console_init);
+
+#define SERIAL_SIRFSOC_CONSOLE (sirfsoc_uart_console)
+#else
+#define SERIAL_SIRFSOC_CONSOLE NULL
 #endif
 
 static struct uart_driver sirfsoc_uart_drv = {
@@ -1157,11 +1165,6 @@ static struct uart_driver sirfsoc_uart_drv = {
 	.dev_name	= SIRFSOC_UART_NAME,
 	.major		= SIRFSOC_UART_MAJOR,
 	.minor		= SIRFSOC_UART_MINOR,
-#ifdef CONFIG_SERIAL_SIRFSOC_CONSOLE
-	.cons			= &sirfsoc_uart_console,
-#else
-	.cons			= NULL,
-#endif
 };
 
 static enum hrtimer_restart
@@ -1479,6 +1482,7 @@ static int __init sirfsoc_uart_init(void)
 {
 	int ret = 0;
 
+	sirfsoc_uart_drv.cons = SERIAL_SIRFSOC_CONSOLE;
 	ret = uart_register_driver(&sirfsoc_uart_drv);
 	if (ret)
 		goto out;
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index fe9170731c16..404efc8c4e3a 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -730,16 +730,13 @@ static int sn_sal_console_setup(struct console *, char *);
 static struct uart_driver sal_console_uart;
 extern struct tty_driver *uart_console_device(struct console *, int *);
 
-static struct console sal_console = {
-	.name = DEVICE_NAME,
+static const struct console_operations sal_cons_ops = {
 	.write = sn_sal_console_write,
 	.device = uart_console_device,
 	.setup = sn_sal_console_setup,
-	.index = -1,		/* unspecified */
-	.data = &sal_console_uart,
 };
 
-#define SAL_CONSOLE	&sal_console
+static struct console __initdata *sal_console;
 
 static struct uart_driver sal_console_uart = {
 	.owner = THIS_MODULE,
@@ -748,7 +745,6 @@ static struct uart_driver sal_console_uart = {
 	.major = 0,		/* major/minor set at registration time per USE_DYNAMIC_MINOR */
 	.minor = 0,
 	.nr = 1,		/* one port */
-	.cons = SAL_CONSOLE,
 };
 
 /**
@@ -768,6 +764,7 @@ static int __init sn_sal_init(void)
 		return 0;
 
 	printk(KERN_INFO "sn_console: Console driver init\n");
+	sal_console_uart.cons = sal_console;
 
 	if (USE_DYNAMIC_MINOR == 1) {
 		misc.minor = MISC_DYNAMIC_MINOR;
@@ -980,11 +977,17 @@ sn_sal_console_write_early(struct console *co, const char *s, unsigned count)
 
 /* Used for very early console printing - again, before
  * sn_sal_serial_console_init is run */
+
+static const struct console_operations sal_early_cons_ops = {
+	.write = sn_sal_console_write_early,
+};
+
 static struct console sal_console_early __initdata = {
 	.name = "sn_sal",
-	.write = sn_sal_console_write_early,
+	.ops = &sal_early_cons_ops,
 	.flags = CON_PRINTBUFFER,
 	.index = -1,
+	.is_static = 1,
 };
 
 /**
@@ -1024,9 +1027,15 @@ int __init sn_serial_console_early_setup(void)
 static int __init sn_sal_serial_console_init(void)
 {
 	if (ia64_platform_is("sn2")) {
+		sal_console = allocate_console_dfl(&sal_cons_ops, DEVICE_NAME,
+						   &sal_console_uart);
+		if (!sal_console)
+			return -ENOMEM;
+
 		sn_sal_switch_to_asynch(&sal_console_port);
 		DPRINTF("sn_sal_serial_console_init : register console\n");
-		register_console(&sal_console);
+
+		register_console(sal_console);
 		unregister_console(&sal_console_early);
 	}
 	return 0;
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 4287ca305b6b..511d3563a6ac 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -575,18 +575,13 @@ static int __init sprd_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver sprd_uart_driver;
-static struct console sprd_console = {
-	.name = SPRD_TTY_NAME,
+
+static const struct console_operations sprd_cons_ops = {
 	.write = sprd_console_write,
 	.device = uart_console_device,
 	.setup = sprd_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &sprd_uart_driver,
 };
 
-#define SPRD_CONSOLE	(&sprd_console)
-
 /* Support for earlycon */
 static void sprd_putc(struct uart_port *port, int c)
 {
@@ -606,20 +601,24 @@ static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 	uart_console_write(&dev->port, s, n, sprd_putc);
 }
 
+static const struct console_operations sprd_early_cons_ops = {
+	.write = sprd_early_write,
+};
+
 static int __init sprd_early_console_setup(struct earlycon_device *device,
 					   const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = sprd_early_write;
+	device->con->ops = &sprd_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(sprd_serial, "sprd,sc9836-uart",
 		    sprd_early_console_setup);
 
 #else /* !CONFIG_SERIAL_SPRD_CONSOLE */
-#define SPRD_CONSOLE		NULL
+static const struct console_operations sprd_cons_ops;
 #endif
 
 static struct uart_driver sprd_uart_driver = {
@@ -629,7 +628,6 @@ static struct uart_driver sprd_uart_driver = {
 	.major = 0,
 	.minor = 0,
 	.nr = UART_NR_MAX,
-	.cons = SPRD_CONSOLE,
 };
 
 static int sprd_probe_dt_alias(int index, struct device *dev)
@@ -723,6 +721,13 @@ static int sprd_probe(struct platform_device *pdev)
 	up->irq = irq;
 
 	if (!sprd_ports_num) {
+		ret = uart_allocate_console_dfl(&sprd_uart_driver,
+						&sprd_cons_ops,
+						SPRD_TTY_NAME,
+						SERIAL_SPRD_CONSOLE);
+		if (ret)
+			return ret;
+
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
 			pr_err("Failed to register SPRD-UART driver\n");
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 7971997cdead..663695e91a8c 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -937,20 +937,14 @@ static int asc_console_setup(struct console *co, char *options)
 	return uart_set_options(&ascport->port, co, baud, parity, bits, flow);
 }
 
-static struct console asc_console = {
-	.name		= ASC_SERIAL_NAME,
+static const struct console_operations asc_cons_ops = {
 	.device		= uart_console_device,
 	.write		= asc_console_write,
 	.setup		= asc_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &asc_uart_driver,
 };
 
-#define ASC_SERIAL_CONSOLE (&asc_console)
-
 #else
-#define ASC_SERIAL_CONSOLE NULL
+static const struct console_operations asc_cons_ops;
 #endif /* CONFIG_SERIAL_ST_ASC_CONSOLE */
 
 static struct uart_driver asc_uart_driver = {
@@ -960,7 +954,6 @@ static struct uart_driver asc_uart_driver = {
 	.major		= 0,
 	.minor		= 0,
 	.nr		= ASC_MAX_PORTS,
-	.cons		= ASC_SERIAL_CONSOLE,
 };
 
 static const struct dev_pm_ops asc_serial_pm_ops = {
@@ -985,14 +978,26 @@ static int __init asc_init(void)
 
 	printk(banner);
 
-	ret = uart_register_driver(&asc_uart_driver);
+	ret = uart_allocate_console_dfl(&asc_uart_driver, &asc_cons_ops,
+					ASC_SERIAL_NAME,
+					CONFIG_SERIAL_ST_ASC_CONSOLE);
 	if (ret)
 		return ret;
 
+	ret = uart_register_driver(&asc_uart_driver);
+	if (ret)
+		goto out;
+
 	ret = platform_driver_register(&asc_serial_driver);
 	if (ret)
-		uart_unregister_driver(&asc_uart_driver);
+		goto out_unregister;
+
+	return 0;
 
+out_unregister:
+	uart_unregister_driver(&asc_uart_driver);
+out:
+	uart_put_console(&asc_uart_driver);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7bb4339..733020efc0be 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1162,20 +1162,14 @@ static int stm32_console_setup(struct console *co, char *options)
 	return uart_set_options(&stm32port->port, co, baud, parity, bits, flow);
 }
 
-static struct console stm32_console = {
-	.name		= STM32_SERIAL_NAME,
+static const struct console_operations stm32_cons_ops = {
 	.device		= uart_console_device,
 	.write		= stm32_console_write,
 	.setup		= stm32_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &stm32_usart_driver,
 };
 
-#define STM32_SERIAL_CONSOLE (&stm32_console)
-
 #else
-#define STM32_SERIAL_CONSOLE NULL
+static const struct console_operations stm32_cons_ops;
 #endif /* CONFIG_SERIAL_STM32_CONSOLE */
 
 static struct uart_driver stm32_usart_driver = {
@@ -1184,7 +1178,6 @@ static struct uart_driver stm32_usart_driver = {
 	.major		= 0,
 	.minor		= 0,
 	.nr		= STM32_MAX_PORTS,
-	.cons		= STM32_SERIAL_CONSOLE,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -1258,6 +1251,12 @@ static int __init usart_init(void)
 
 	pr_info("%s\n", banner);
 
+	ret = uart_allocate_console_dfl(&stm32_usart_driver, &stm32_cons_ops,
+					STM32_SERIAL_NAME,
+					SERIAL_STM32_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&stm32_usart_driver);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 63e34d868de8..52ad551cba9c 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -512,17 +512,20 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 		spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static struct console sunhv_console = {
-	.name	=	"ttyHV",
+static const struct console_operations sunhv_cons_bychar_ops = {
 	.write	=	sunhv_console_write_bychar,
 	.device	=	uart_console_device,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data	=	&sunhv_reg,
+};
+
+static const struct console_operations sunhv_cons_paged_ops = {
+	.write	=	sunhv_console_write_paged,
+	.device	=	uart_console_device,
 };
 
 static int hv_probe(struct platform_device *op)
 {
+	const struct console_operations *cons_ops = &sunhv_cons_bychar_ops;
+	struct console *sunhv_console;
 	struct uart_port *port;
 	unsigned long minor;
 	int err;
@@ -546,7 +549,7 @@ static int hv_probe(struct platform_device *op)
 		if (!con_read_page)
 			goto out_free_con_write_page;
 
-		sunhv_console.write = sunhv_console_write_paged;
+		cons_ops = &sunhv_cons_paged_ops;
 		sunhv_ops = &bywrite_ops;
 	}
 
@@ -567,24 +570,32 @@ static int hv_probe(struct platform_device *op)
 	if (err)
 		goto out_free_con_read_page;
 
-	sunserial_console_match(&sunhv_console, op->dev.of_node,
+	err = -ENOMEM;
+	sunhv_console = allocate_console_dfl(cons_ops, "ttyHV", &sunhv_reg);
+	if (!sunhv_console)
+		goto out_unregister_driver;
+
+	sunserial_console_match(sunhv_console, op->dev.of_node,
 				&sunhv_reg, port->line, false);
 
 	err = uart_add_one_port(&sunhv_reg, port);
 	if (err)
-		goto out_unregister_driver;
+		goto out_put_console;
 
 	err = request_irq(port->irq, sunhv_interrupt, 0, "hvcons", port);
 	if (err)
 		goto out_remove_port;
 
 	platform_set_drvdata(op, port);
-
+	put_console(sunhv_console);
 	return 0;
 
 out_remove_port:
 	uart_remove_one_port(&sunhv_reg, port);
 
+out_put_console:
+	put_console(sunhv_console);
+
 out_unregister_driver:
 	sunserial_unregister_minors(&sunhv_reg, 1);
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..254ce117e02a 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -946,23 +946,14 @@ static int sunsab_console_setup(struct console *con, char *options)
 	return 0;
 }
 
-static struct console sunsab_console = {
-	.name	=	"ttyS",
+static const struct console_operations sunsab_cons_ops = {
 	.write	=	sunsab_console_write,
 	.device	=	uart_console_device,
 	.setup	=	sunsab_console_setup,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data	=	&sunsab_reg,
 };
 
-static inline struct console *SUNSAB_CONSOLE(void)
-{
-	return &sunsab_console;
-}
 #else
-#define SUNSAB_CONSOLE()	(NULL)
-#define sunsab_console_init()	do { } while (0)
+static const struct console_operations sunsab_cons_ops;
 #endif
 
 static int sunsab_init_one(struct uart_sunsab_port *up,
@@ -1024,6 +1015,11 @@ static int sab_probe(struct platform_device *op)
 	struct uart_sunsab_port *up;
 	int err;
 
+	err = uart_allocate_console_dfl(&sunsab_reg, &sunsab_cons_ops, "ttyS",
+					SERIAL_SUNSAB_CONSOLE);
+	if (err)
+		return err;
+
 	up = &sunsab_ports[inst * 2];
 
 	err = sunsab_init_one(&up[0], op,
@@ -1038,13 +1034,11 @@ static int sab_probe(struct platform_device *op)
 	if (err)
 		goto out1;
 
-	sunserial_console_match(SUNSAB_CONSOLE(), op->dev.of_node,
-				&sunsab_reg, up[0].port.line,
-				false);
+	sunserial_console_match(sunsab_reg.cons, op->dev.of_node, &sunsab_reg,
+				up[0].port.line, false);
 
-	sunserial_console_match(SUNSAB_CONSOLE(), op->dev.of_node,
-				&sunsab_reg, up[1].port.line,
-				false);
+	sunserial_console_match(sunsab_reg.cons, op->dev.of_node, &sunsab_reg,
+				up[1].port.line, false);
 
 	err = uart_add_one_port(&sunsab_reg, &up[0].port);
 	if (err)
@@ -1071,6 +1065,7 @@ static int sab_probe(struct platform_device *op)
 		   up[0].port.membase,
 		   sizeof(union sab82532_async_regs));
 out:
+	uart_put_console(&sunsab_reg);
 	return err;
 }
 
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 4db6aaa330b2..229afa1d9c75 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1368,27 +1368,14 @@ static int __init sunsu_console_setup(struct console *co, char *options)
 	return 0;
 }
 
-static struct console sunsu_console = {
-	.name	=	"ttyS",
+static const struct console_operations sunsu_cons_ops = {
 	.write	=	sunsu_console_write,
 	.device	=	uart_console_device,
 	.setup	=	sunsu_console_setup,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data	=	&sunsu_reg,
 };
 
-/*
- *	Register console.
- */
-
-static inline struct console *SUNSU_CONSOLE(void)
-{
-	return &sunsu_console;
-}
 #else
-#define SUNSU_CONSOLE()			(NULL)
-#define sunsu_serial_console_init()	do { } while (0)
+static const struct console_operations sunsu_cons_ops;
 #endif
 
 static enum su_type su_get_type(struct device_node *dp)
@@ -1507,9 +1494,14 @@ static int su_probe(struct platform_device *op)
 	    of_node_name_eq(dp, "lom-console"))
 		ignore_line = true;
 
-	sunserial_console_match(SUNSU_CONSOLE(), dp,
-				&sunsu_reg, up->port.line,
+	err = uart_allocate_console_dfl(&sunsu_reg, &sunsu_cons_ops, "ttyS",
+					SERIAL_SUNSU_CONSOLE);
+	if (err)
+		goto out_unmap;
+
+	sunserial_console_match(sunsu_reg.cons, dp, &sunsu_reg, up->port.line,
 				ignore_line);
+
 	err = uart_add_one_port(&sunsu_reg, &up->port);
 	if (err)
 		goto out_unmap;
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b08a72..f82397a679ea 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1263,23 +1263,14 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 	return 0;
 }
 
-static struct console sunzilog_console_ops = {
-	.name	=	"ttyS",
+static const struct console_operations sunzilog_cons_ops = {
 	.write	=	sunzilog_console_write,
 	.device	=	uart_console_device,
 	.setup	=	sunzilog_console_setup,
-	.flags	=	CON_PRINTBUFFER,
-	.index	=	-1,
-	.data   =	&sunzilog_reg,
 };
 
-static inline struct console *SUNZILOG_CONSOLE(void)
-{
-	return &sunzilog_console_ops;
-}
-
 #else
-#define SUNZILOG_CONSOLE()	(NULL)
+static const struct console_operations sunzilog_cons_ops;
 #endif
 
 static void sunzilog_init_kbdms(struct uart_sunzilog_port *up)
@@ -1466,20 +1457,29 @@ static int zs_probe(struct platform_device *op)
 	sunzilog_init_hw(&up[1]);
 
 	if (!keyboard_mouse) {
-		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->dev.of_node,
+		err = uart_allocate_console_dfl(&sunzilog_reg,
+						&sunzilog_cons_ops, "ttyS",
+						SERIAL_SUNZILOG_CONSOLE);
+		if (err)
+			return err;
+
+		if (sunserial_console_match(sunzilog_reg.cons, op->dev.of_node,
 					    &sunzilog_reg, up[0].port.line,
 					    false))
 			up->flags |= SUNZILOG_FLAG_IS_CONS;
+
 		err = uart_add_one_port(&sunzilog_reg, &up[0].port);
 		if (err) {
 			of_iounmap(&op->resource[0],
 				   rp, sizeof(struct zilog_layout));
 			return err;
 		}
-		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->dev.of_node,
+
+		if (sunserial_console_match(sunzilog_reg.cons, op->dev.of_node,
 					    &sunzilog_reg, up[1].port.line,
 					    false))
 			up->flags |= SUNZILOG_FLAG_IS_CONS;
+
 		err = uart_add_one_port(&sunzilog_reg, &up[1].port);
 		if (err) {
 			uart_remove_one_port(&sunzilog_reg, &up[0].port);
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b5a8b9..c88681617c08 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -537,14 +537,10 @@ static int ulite_console_setup(struct console *co, char *options)
 
 static struct uart_driver ulite_uart_driver;
 
-static struct console ulite_console = {
-	.name	= ULITE_NAME,
+static const struct console_operations ulite_cons_ops = {
 	.write	= ulite_console_write,
 	.device	= uart_console_device,
 	.setup	= ulite_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
-	.data	= &ulite_uart_driver,
 };
 
 static void early_uartlite_putc(struct uart_port *port, int c)
@@ -575,19 +571,25 @@ static void early_uartlite_write(struct console *console,
 	uart_console_write(&device->port, s, n, early_uartlite_putc);
 }
 
+static const struct console_operations early_uartlite_cons_ops = {
+	.write = early_uartlite_write,
+};
+
 static int __init early_uartlite_setup(struct earlycon_device *device,
 				       const char *options)
 {
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = early_uartlite_write;
+	device->con->ops = &early_uartlite_cons_ops;
 	return 0;
 }
 EARLYCON_DECLARE(uartlite, early_uartlite_setup);
 OF_EARLYCON_DECLARE(uartlite_b, "xlnx,opb-uartlite-1.00.b", early_uartlite_setup);
 OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup);
 
+#else
+static const struct console_operations ulite_cons_ops;
 #endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
 
 static struct uart_driver ulite_uart_driver = {
@@ -597,9 +599,6 @@ static struct uart_driver ulite_uart_driver = {
 	.major		= ULITE_MAJOR,
 	.minor		= ULITE_MINOR,
 	.nr		= ULITE_NR_UARTS,
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-	.cons		= &ulite_console,
-#endif
 };
 
 /* ---------------------------------------------------------------------
@@ -803,6 +802,12 @@ static int ulite_probe(struct platform_device *pdev)
 	}
 
 	if (!ulite_uart_driver.state) {
+		ret = uart_allocate_console_dfl(&ulite_uart_driver,
+						&ulite_cons_ops, ULITE_NAME,
+						SERIAL_UARTLITE_CONSOLE);
+		if (ret)
+			return ret;
+
 		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
 		ret = uart_register_driver(&ulite_uart_driver);
 		if (ret < 0) {
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e33f842..8eaaf62db1c7 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -798,28 +798,30 @@ static int __init siu_console_setup(struct console *con, char *options)
 
 static struct uart_driver siu_uart_driver;
 
-static struct console siu_console = {
-	.name	= "ttyVR",
+static const struct console_operations sui_cons_ops = {
 	.write	= siu_console_write,
 	.device	= uart_console_device,
 	.setup	= siu_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &siu_uart_driver,
 };
 
+static struct console *siu_console;
+
 static int siu_console_init(void)
 {
 	struct uart_port *port;
 	int i;
 
+	siu_console = allocate_console_dfl(&sui_cons_ops, "ttyVR",
+					   &siu_uart_driver);
+	if (!siu_console)
+		return -ENOMEM;
+
 	for (i = 0; i < SIU_PORTS_MAX; i++) {
 		port = &siu_uart_ports[i];
 		port->ops = &siu_uart_ops;
 	}
 
-	register_console(&siu_console);
-
+	register_console(siu_console);
 	return 0;
 }
 
@@ -837,9 +839,18 @@ void __init vr41xx_siu_early_setup(struct uart_port *port)
 	siu_uart_ports[port->line].ops = &siu_uart_ops;
 }
 
-#define SERIAL_VR41XX_CONSOLE	&siu_console
+/*
+ * Since we need this in ->probe(), the static pointer can't be __init, so the
+ * following ugliness cleans up the "dangling reference" in the built-in case.
+ */
+#define SERIAL_VR41XX_CONSOLE()				\
+({							\
+	struct console *__con = siu_console;		\
+	s3c24xx_serial_console = NULL;			\
+	__con;						\
+})
 #else
-#define SERIAL_VR41XX_CONSOLE	NULL
+#define SERIAL_VR41XX_CONSOLE() (NULL)
 #endif
 
 static struct uart_driver siu_uart_driver = {
@@ -848,7 +859,6 @@ static struct uart_driver siu_uart_driver = {
 	.dev_name	= "ttyVR",
 	.major		= SIU_MAJOR,
 	.minor		= SIU_MINOR_BASE,
-	.cons		= SERIAL_VR41XX_CONSOLE,
 };
 
 static int siu_probe(struct platform_device *dev)
@@ -861,6 +871,7 @@ static int siu_probe(struct platform_device *dev)
 		return -ENODEV;
 
 	siu_uart_driver.nr = num;
+	siu_uart_driver.cons = SERIAL_VR41XX_CONSOLE();
 	retval = uart_register_driver(&siu_uart_driver);
 	if (retval)
 		return retval;
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 3d58e9b34553..caf0f789fee9 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -541,20 +541,14 @@ static int __init vt8500_console_setup(struct console *co, char *options)
 				 co, baud, parity, bits, flow);
 }
 
-static struct console vt8500_console = {
-	.name = "ttyWMT",
+static const struct console_operations vt8500_cons_ops = {
 	.write = vt8500_console_write,
 	.device = uart_console_device,
 	.setup = vt8500_console_setup,
-	.flags = CON_PRINTBUFFER,
-	.index = -1,
-	.data = &vt8500_uart_driver,
 };
 
-#define VT8500_CONSOLE	(&vt8500_console)
-
 #else
-#define VT8500_CONSOLE	NULL
+static const struct console_operations vt8500_cons_ops;
 #endif
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -612,7 +606,6 @@ static struct uart_driver vt8500_uart_driver = {
 	.driver_name	= "vt8500_serial",
 	.dev_name	= "ttyWMT",
 	.nr		= 6,
-	.cons		= VT8500_CONSOLE,
 };
 
 static unsigned int vt8500_flags; /* none required so far */
@@ -734,15 +727,23 @@ static int __init vt8500_serial_init(void)
 {
 	int ret;
 
+	ret = uart_allocate_console_dfl(&vt8500_uart_driver, &vt8500_cons_ops,
+					"ttyWMT", SERIAL_VT8500_CONSOLE);
+	if (ret)
+		return ret;
+
 	ret = uart_register_driver(&vt8500_uart_driver);
 	if (unlikely(ret))
-		return ret;
+		goto out;
 
 	ret = platform_driver_register(&vt8500_platform_driver);
-
 	if (unlikely(ret))
-		uart_unregister_driver(&vt8500_uart_driver);
+		goto out_unregister;
 
+out_unregister:
+	uart_unregister_driver(&vt8500_uart_driver);
+out:
+	uart_put_console(&vt8500_uart_driver);
 	return ret;
 }
 device_initcall(vt8500_serial_init);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 094f2958cb2b..813053da4ed0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1120,6 +1120,10 @@ static void cdns_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, cdns_uart_console_putchar);
 }
 
+static const struct console_operations cdns_early_cons_ops = {
+	.write = cdns_early_write,
+};
+
 static int __init cdns_early_console_setup(struct earlycon_device *device,
 					   const char *opt)
 {
@@ -1151,8 +1155,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 		writel(bdiv, port->membase + CDNS_UART_BAUDDIV);
 	}
 
-	device->con->write = cdns_early_write;
-
+	device->con->ops = &cdns_early_cons_ops;
 	return 0;
 }
 OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
@@ -1238,6 +1241,15 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
+
+static const struct console_operations cdns_cons_ops = {
+	.write = cdns_uart_console_write,
+	.device = uart_console_device,
+	.setup = cdns_uart_console_setup,
+};
+
+#else
+static const struct console_operations cdns_cons_ops;
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
 #ifdef CONFIG_PM_SLEEP
@@ -1468,9 +1480,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct uart_driver *cdns_uart_uart_driver;
 	char *driver_name;
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	struct console *cdns_uart_console;
-#endif
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
@@ -1505,24 +1514,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
-					 GFP_KERNEL);
-	if (!cdns_uart_console) {
-		rc = -ENOMEM;
+	rc = uart_allocate_console(cdns_uart_uart_driver, &cdns_cons_ops,
+				   driver_name, CON_PRINTBUFFER,
+				   cdns_uart_data->id,
+				   SERIAL_XILINX_PS_UART_CONSOLE);
+	if (rc)
 		goto err_out_id;
-	}
-
-	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
-		sizeof(cdns_uart_console->name));
-	cdns_uart_console->index = cdns_uart_data->id;
-	cdns_uart_console->write = cdns_uart_console_write;
-	cdns_uart_console->device = uart_console_device;
-	cdns_uart_console->setup = cdns_uart_console_setup;
-	cdns_uart_console->flags = CON_PRINTBUFFER;
-	cdns_uart_console->data = cdns_uart_uart_driver;
-	cdns_uart_uart_driver->cons = cdns_uart_console;
-#endif
 
 	rc = uart_register_driver(cdns_uart_uart_driver);
 	if (rc < 0) {
@@ -1669,6 +1666,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+	uart_put_console(cdns_uart_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
 	if (cdns_uart_data->id < MAX_UART_INSTANCES)
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e458ea2..e3e6c09b7f64 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -1220,16 +1220,15 @@ static int __init zs_console_setup(struct console *co, char *options)
 }
 
 static struct uart_driver zs_reg;
-static struct console zs_console = {
-	.name	= "ttyS",
+
+static const struct console_operations zs_cons_ops = {
 	.write	= zs_console_write,
 	.device	= uart_console_device,
 	.setup	= zs_console_setup,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-	.data	= &zs_reg,
 };
 
+static struct console __initdata *zs_console;
+
 /*
  *	Register console.
  */
@@ -1237,17 +1236,25 @@ static int __init zs_serial_console_init(void)
 {
 	int ret;
 
+	zs_console = allocate_console_dfl(&zs_cons_ops, "ttyS", &zs_reg);
+	if (!zs_console)
+		return -ENOMEM;
+
 	ret = zs_probe_sccs();
 	if (ret)
-		return ret;
-	register_console(&zs_console);
+		goto err;
 
+	register_console(zs_console);
 	return 0;
+
+err:
+	put_console(zs_console);
+	return ret;
 }
 
 console_initcall(zs_serial_console_init);
 
-#define SERIAL_ZS_CONSOLE	&zs_console
+#define SERIAL_ZS_CONSOLE	(zs_console)
 #else
 #define SERIAL_ZS_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_ZS_CONSOLE */
@@ -1259,7 +1266,6 @@ static struct uart_driver zs_reg = {
 	.major			= TTY_MAJOR,
 	.minor			= 64,
 	.nr			= ZS_NUM_SCCS * ZS_NUM_CHAN,
-	.cons			= SERIAL_ZS_CONSOLE,
 };
 
 /* zs_init inits the driver. */
@@ -1274,6 +1280,7 @@ static int __init zs_init(void)
 	if (ret)
 		return ret;
 
+	zs_reg.cons = SERIAL_ZS_CONSOLE;
 	ret = uart_register_driver(&zs_reg);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 21ffcce16927..e06c9a1d4e89 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3433,9 +3433,9 @@ static ssize_t show_cons_active(struct device *dev,
 
 	console_lock();
 	for_each_console(c) {
-		if (!c->device)
+		if (!c->ops->device)
 			continue;
-		if (!c->write)
+		if (!c->ops->write)
 			continue;
 		if ((c->flags & CON_ENABLED) == 0)
 			continue;
@@ -3445,7 +3445,7 @@ static ssize_t show_cons_active(struct device *dev,
 	}
 	while (i--) {
 		int index = cs[i]->index;
-		struct tty_driver *drv = cs[i]->device(cs[i], &index);
+		struct tty_driver *drv = cs[i]->ops->device(cs[i], &index);
 
 		/* don't resolve tty0 as some programs depend on it */
 		if (drv && (cs[i]->index > 0 || drv->major != TTY_MAJOR))
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bba75560d11e..ca66365c3cd6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2960,14 +2960,12 @@ static struct tty_driver *vt_console_device(struct console *c, int *index)
 	return console_driver;
 }
 
-static struct console vt_console_driver = {
-	.name		= "tty",
+static const struct console_operations vt_console_ops = {
 	.write		= vt_console_print,
 	.device		= vt_console_device,
 	.unblank	= unblank_screen,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
 };
+
 #endif
 
 /*
@@ -3285,10 +3283,15 @@ static void vc_init(struct vc_data *vc, unsigned int rows,
 
 static int __init con_init(void)
 {
+	struct console *vt_console_driver;
 	const char *display_desc = NULL;
 	struct vc_data *vc;
 	unsigned int currcons = 0, i;
 
+	vt_console_driver = allocate_console_dfl(&vt_console_ops, "tty", NULL);
+	if (!vt_console_driver)
+		return -ENOMEM;
+
 	console_lock();
 
 	if (conswitchp)
@@ -3344,7 +3347,8 @@ static int __init con_init(void)
 	console_unlock();
 
 #ifdef CONFIG_VT_CONSOLE
-	register_console(&vt_console_driver);
+	register_console(vt_console_driver);
+	put_console(vt_console_driver);
 #endif
 	return 0;
 }
diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index ea0d531c63e2..83d97f55ec6a 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -962,11 +962,16 @@ static void early_dbgp_write(struct console *con, const char *str, u32 n)
 	}
 }
 
+static const struct console_operations early_dbgp_cons_ops = {
+	.write =	early_dbgp_write,
+};
+
 struct console early_dbgp_console = {
 	.name =		"earlydbg",
-	.write =	early_dbgp_write,
+	.ops =		&early_dbgp_cons_ops,
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
+	.is_static =	1,
 };
 
 #if IS_ENABLED(CONFIG_USB)
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index d2652dccc699..80a5f6d28be8 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -905,11 +905,16 @@ static void early_xdbc_write(struct console *con, const char *str, u32 n)
 	}
 }
 
+static const struct console_operations early_xdbc_ops = {
+	.write		= early_xdbc_write,
+};
+
 static struct console early_xdbc_console = {
 	.name		= "earlyxdbc",
-	.write		= early_xdbc_write,
 	.flags		= CON_PRINTBUFFER,
+	.ops		= &early_xdbc_ops,
 	.index		= -1,
+	.is_static	= 1,
 };
 
 void __init early_xdbc_register_console(void)
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 29436f75bbe0..6728ec61f9f4 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -897,7 +897,7 @@ static struct tty_driver *gs_tty_driver;
 #ifdef CONFIG_U_SERIAL_CONSOLE
 
 static struct gscons_info gscons_info;
-static struct console gserial_cons;
+static struct console *gserial_cons;
 
 static struct usb_request *gs_request_new(struct usb_ep *ep)
 {
@@ -953,7 +953,7 @@ static int gs_console_connect(int port_num)
 	struct gs_port *port;
 	struct usb_ep *ep;
 
-	if (port_num != gserial_cons.index) {
+	if (port_num != gserial_cons->index) {
 		pr_err("%s: port num [%d] is not support console\n",
 		       __func__, port_num);
 		return -ENXIO;
@@ -1090,26 +1090,22 @@ static struct tty_driver *gs_console_device(struct console *co, int *index)
 	return *p;
 }
 
-static struct console gserial_cons = {
-	.name =		"ttyGS",
+static const struct console_operations gserial_cons_ops = {
 	.write =	gs_console_write,
 	.device =	gs_console_device,
 	.setup =	gs_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-	.data =		&gs_tty_driver,
 };
 
 static void gserial_console_init(void)
 {
-	register_console(&gserial_cons);
+	register_console(gserial_cons);
 }
 
 static void gserial_console_exit(void)
 {
 	struct gscons_info *info = &gscons_info;
 
-	unregister_console(&gserial_cons);
+	unregister_console(gserial_cons);
 	if (!IS_ERR_OR_NULL(info->console_thread))
 		kthread_stop(info->console_thread);
 	kfifo_free(&info->con_buf);
@@ -1437,6 +1433,12 @@ static int userial_init(void)
 		goto fail;
 	}
 
+	status = -ENOMEM;
+	gserial_cons = allocate_console_dfl(&gserial_cons_ops, "ttyGS",
+					    &gs_tty_driver);
+	if (!gserial_cons)
+		goto fail;
+
 	pr_debug("%s: registered %d ttyGS* device%s\n", __func__,
 			MAX_U_SERIAL_PORTS,
 			(MAX_U_SERIAL_PORTS == 1) ? "" : "s");
@@ -1454,6 +1456,8 @@ static void userial_cleanup(void)
 	tty_unregister_driver(gs_tty_driver);
 	put_tty_driver(gs_tty_driver);
 	gs_tty_driver = NULL;
+
+	put_console(gserial_cons);
 }
 module_exit(userial_cleanup);
 
diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index 7d289302ff6c..0983c574133b 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -26,7 +26,7 @@ struct usbcons_info {
 };
 
 static struct usbcons_info usbcons_info;
-static struct console usbcons;
+static struct console *usbcons;
 
 /*
  * ------------------------------------------------------------
@@ -251,14 +251,10 @@ static struct tty_driver *usb_console_device(struct console *co, int *index)
 	return *p;
 }
 
-static struct console usbcons = {
-	.name =		"ttyUSB",
+static const struct console_operations usb_console_ops = {
 	.write =	usb_console_write,
 	.device =	usb_console_device,
 	.setup =	usb_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-	.data = 	&usb_serial_tty_driver,
 };
 
 void usb_serial_console_disconnect(struct usb_serial *serial)
@@ -269,7 +265,7 @@ void usb_serial_console_disconnect(struct usb_serial *serial)
 	}
 }
 
-void usb_serial_console_init(int minor)
+int usb_serial_console_init(int minor)
 {
 	if (minor == 0) {
 		/*
@@ -286,16 +282,26 @@ void usb_serial_console_init(int minor)
 		 * from register_console iff CON_PRINTBUFFER is set in flags.
 		 */
 		pr_debug("registering the USB serial console.\n");
-		register_console(&usbcons);
+
+		usbcons = allocate_console_dfl(&usb_console_ops, "ttyUSB",
+					       &usb_serial_tty_driver);
+		if (!usbcons)
+			return -ENOMEM;
+
+		register_console(usbcons);
 	}
+
+	return 0;
 }
 
 void usb_serial_console_exit(void)
 {
 	if (usbcons_info.port) {
-		unregister_console(&usbcons);
+		unregister_console(usbcons);
 		usbcons_info.port->port.console = 0;
 		usbcons_info.port = NULL;
 	}
+
+	put_console(usbcons);
 }
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 7e89efbf2c28..b3c4ea62a0f0 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -868,7 +868,7 @@ static int usb_serial_probe(struct usb_interface *interface,
 	struct device *ddev = &interface->dev;
 	struct usb_device *dev = interface_to_usbdev(interface);
 	struct usb_serial *serial = NULL;
-	struct usb_serial_port *port;
+	struct usb_serial_port *port = NULL;
 	struct usb_serial_endpoints *epds;
 	struct usb_serial_driver *type = NULL;
 	int retval;
@@ -1056,13 +1056,20 @@ static int usb_serial_probe(struct usb_interface *interface,
 			dev_err(ddev, "Error registering port device, continuing\n");
 	}
 
-	if (num_ports > 0)
-		usb_serial_console_init(serial->port[0]->minor);
+	if (num_ports > 0) {
+		retval = usb_serial_console_init(serial->port[0]->minor);
+		if (retval < 0)
+			goto err_free_dev;
+	}
 exit:
 	kfree(epds);
 	module_put(type->driver.owner);
 	return 0;
 
+err_free_dev:
+	if (port)
+		put_device(&port->dev);
+	release_minors(serial);
 err_free_epds:
 	kfree(epds);
 err_put_serial:
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 954caf0b7fee..8c71658707b8 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -31,10 +31,10 @@ static int show_console_dev(struct seq_file *m, void *v)
 	unsigned int a;
 	dev_t dev = 0;
 
-	if (con->device) {
+	if (con->ops->device) {
 		const struct tty_driver *driver;
 		int index;
-		driver = con->device(con, &index);
+		driver = con->ops->device(con, &index);
 		if (driver) {
 			dev = MKDEV(driver->major, driver->minor_start);
 			dev += index;
@@ -49,9 +49,9 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_setwidth(m, 21 - 1);
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
-	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
-			con->write ? 'W' : '-', con->unblank ? 'U' : '-',
-			flags);
+	seq_printf(m, "%c%c%c (%s)", con->ops->read ? 'R' : '-',
+			con->ops->write ? 'W' : '-',
+			con->ops->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 2d1066ed3c28..2cc38460b70c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -509,23 +509,31 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 	psinfo->write(&record);
 }
 
-static struct console pstore_console = {
-	.name	= "pstore",
-	.write	= pstore_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME,
-	.index	= -1,
+static const struct console_operations pstore_cons_ops = {
+	.write = pstore_console_write,
 };
 
+static struct console *pstore_console;
+
+static int pstore_allocate_console(void)
+{
+	pstore_console = allocate_console_dfl(&pstore_cons_ops, "pstore", NULL);
+	return pstore_console ? 0 : -ENOMEM;
+}
+
 static void pstore_register_console(void)
 {
-	register_console(&pstore_console);
+	pstore_console->flags |= CON_ENABLED | CON_ANYTIME;
+	register_console(pstore_console);
 }
 
 static void pstore_unregister_console(void)
 {
-	unregister_console(&pstore_console);
+	unregister_console(pstore_console);
+	put_console(pstore_console);
 }
 #else
+static int pstore_allocate_console(void) { return 0; }
 static void pstore_register_console(void) {}
 static void pstore_unregister_console(void) {}
 #endif
@@ -603,6 +611,9 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
+	if (pstore_allocate_console())
+		return -ENOMEM;
+
 	allocate_buf_for_compression();
 
 	if (pstore_is_mounted())
diff --git a/include/linux/console.h b/include/linux/console.h
index 3c27a4a29b8c..382591683033 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/device.h>
 
 struct vc_data;
 struct console_font_op;
@@ -142,20 +143,28 @@ static inline int con_debug_leave(void)
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 
-struct console {
-	char	name[16];
+struct console;
+
+struct console_operations {
 	void	(*write)(struct console *, const char *, unsigned);
 	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
+};
+
+struct console {
+	char	name[16];
 	short	flags;
 	short	index;
 	int	cflag;
 	void	*data;
 	struct	 console *next;
 	int	level;
+	const struct console_operations *ops;
+	struct device dev;
+	int is_static;
 };
 
 /*
@@ -167,6 +176,29 @@ struct console {
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
+extern struct console *allocate_console(const struct console_operations *ops,
+					const char *name, short flags,
+					short index, void *data);
+
+#define allocate_console_dfl(ops, name, data) \
+	allocate_console(ops, name, CON_PRINTBUFFER, -1, data)
+
+/*
+ * Helpers for get/put that do the right thing for static early consoles.
+ */
+
+#define get_console(con) \
+do { \
+	if (!con->is_static) \
+		get_device(&(con)->dev); \
+} while (0)
+
+#define put_console(con) \
+do { \
+	if (con && !con->is_static) \
+		put_device(&((struct console *)con)->dev); \
+} while (0)
+
 extern int add_preferred_console(char *name, int idx, char *options);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5fe2b037e833..29b43c4df3d6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -426,6 +426,25 @@ int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_match_port(struct uart_port *port1, struct uart_port *port2);
 
+/*
+ * This ugliness removes the need for #ifdef boilerplate in UART drivers which
+ * allow their console functionality to be disabled via Kconfig.
+ */
+#define uart_allocate_console(drv, ops, name, flags, idx, kcfg)		    \
+({									    \
+	int __retval = 0;						    \
+	if (IS_ENABLED(CONFIG_##kcfg)) {				    \
+		(drv)->cons = allocate_console(ops, name, flags, idx, drv); \
+		__retval = (drv)->cons ? 0 : -ENOMEM;			    \
+	}								    \
+	__retval;							    \
+})
+
+#define uart_allocate_console_dfl(drv, ops, name, kcfg) \
+	uart_allocate_console(drv, ops, name, CON_PRINTBUFFER, -1, kcfg)
+
+#define uart_put_console(drv) put_console((drv)->cons)
+
 /*
  * Power Management
  */
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1c19f77ed541..48841e441e2e 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -332,11 +332,11 @@ extern int usb_serial_resume(struct usb_interface *intf);
 
 /* USB Serial console functions */
 #ifdef CONFIG_USB_SERIAL_CONSOLE
-extern void usb_serial_console_init(int minor);
+extern int usb_serial_console_init(int minor);
 extern void usb_serial_console_exit(void);
 extern void usb_serial_console_disconnect(struct usb_serial *serial);
 #else
-static inline void usb_serial_console_init(int minor) { }
+static inline int usb_serial_console_init(int minor) { return 0; }
 static inline void usb_serial_console_exit(void) { }
 static inline void usb_serial_console_disconnect(struct usb_serial *serial) {}
 #endif
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 5cc608de6883..d082d7fbea27 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -863,11 +863,16 @@ static void kgdb_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
+static const struct console_operations kgdb_ops = {
+	.write		= kgdb_console_write,
+};
+
 static struct console kgdbcons = {
 	.name		= "kgdb",
-	.write		= kgdb_console_write,
 	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.ops		= &kgdb_ops,
 	.index		= -1,
+	.is_static	= 1,
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a4b41484afe..eb48ad341411 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -709,7 +709,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		while (c) {
-			c->write(c, cp, retlen - (cp - kdb_buffer));
+			c->ops->write(c, cp, retlen - (cp - kdb_buffer));
 			touch_nmi_watchdog();
 			c = c->next;
 		}
@@ -773,7 +773,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		while (c) {
-			c->write(c, moreprompt, strlen(moreprompt));
+			c->ops->write(c, moreprompt, strlen(moreprompt));
 			touch_nmi_watchdog();
 			c = c->next;
 		}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2e0eb89f046c..67e1e993ab80 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -108,6 +108,8 @@ enum devkmsg_log_masks {
 
 static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
 
+static int printk_late_done;
+
 static int __control_devkmsg(char *str)
 {
 	if (!str)
@@ -1731,7 +1733,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 			continue;
 		if (!(con->flags & CON_ENABLED))
 			continue;
-		if (!con->write)
+		if (!con->ops->write)
 			continue;
 		if (!cpu_online(smp_processor_id()) &&
 		    !(con->flags & CON_ANYTIME))
@@ -1739,9 +1741,9 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		if (suppress_message_printing(level, con))
 			continue;
 		if (con->flags & CON_EXTENDED)
-			con->write(con, ext_text, ext_len);
+			con->ops->write(con, ext_text, ext_len);
 		else
-			con->write(con, text, len);
+			con->ops->write(con, text, len);
 	}
 }
 
@@ -2052,7 +2054,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 	n = vscnprintf(buf, sizeof(buf), fmt, ap);
 	va_end(ap);
 
-	early_console->write(early_console, buf, n);
+	early_console->ops->write(early_console, buf, n);
 }
 #endif
 
@@ -2481,8 +2483,8 @@ void console_unblank(void)
 	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
-		if ((c->flags & CON_ENABLED) && c->unblank)
-			c->unblank();
+		if ((c->flags & CON_ENABLED) && c->ops->unblank)
+			c->ops->unblank();
 	console_unlock();
 }
 
@@ -2515,9 +2517,9 @@ struct tty_driver *console_device(int *index)
 
 	console_lock();
 	for_each_console(c) {
-		if (!c->device)
+		if (!c->ops->device)
 			continue;
-		driver = c->device(c, index);
+		driver = c->ops->device(c, index);
 		if (driver)
 			break;
 	}
@@ -2558,6 +2560,68 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static struct bus_type console_subsys = {
+	.name = "console",
+};
+
+static void console_release(struct device *dev)
+{
+	struct console *con = container_of(dev, struct console, dev);
+
+	if (WARN(con->is_static, "Freeing static early console!\n"))
+		return;
+
+	if (WARN(con->flags & CON_ENABLED, "Freeing running console!\n"))
+		return;
+
+	pr_info("Freeing console %s\n", con->name);
+	kfree(con);
+}
+
+static void console_init_device(struct console *con)
+{
+	device_initialize(&con->dev);
+	dev_set_name(&con->dev, "%s", con->name);
+	con->dev.release = console_release;
+}
+
+static void console_register_device(struct console *new)
+{
+	/*
+	 * We might be called very early from register_console(): in that case,
+	 * printk_late_init() will take care of this later.
+	 */
+	if (!printk_late_done)
+		return;
+
+	if (new->is_static)
+		console_init_device(new);
+
+	new->dev.bus = &console_subsys;
+	WARN_ON(device_add(&new->dev));
+}
+
+struct console *allocate_console(const struct console_operations *ops,
+				 const char *name, short flags, short index,
+				 void *data)
+{
+	struct console *new;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->ops = ops;
+	strscpy(new->name, name, sizeof(new->name));
+	new->flags = flags;
+	new->index = index;
+	new->data = data;
+
+	console_init_device(new);
+	return new;
+}
+EXPORT_SYMBOL_GPL(allocate_console);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2622,10 +2686,10 @@ void register_console(struct console *newcon)
 	if (!has_preferred) {
 		if (newcon->index < 0)
 			newcon->index = 0;
-		if (newcon->setup == NULL ||
-		    newcon->setup(newcon, NULL) == 0) {
+		if (newcon->ops->setup == NULL ||
+		    newcon->ops->setup(newcon, NULL) == 0) {
 			newcon->flags |= CON_ENABLED;
-			if (newcon->device) {
+			if (newcon->ops->device) {
 				newcon->flags |= CON_CONSDEV;
 				has_preferred = true;
 			}
@@ -2639,8 +2703,8 @@ void register_console(struct console *newcon)
 	for (i = 0, c = console_cmdline;
 	     i < MAX_CMDLINECONSOLES && c->name[0];
 	     i++, c++) {
-		if (!newcon->match ||
-		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
+		if (!newcon->ops->match ||
+		    newcon->ops->match(newcon, c->name, c->index, c->options) != 0) {
 			/* default matching */
 			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
 			if (strcmp(c->name, newcon->name) != 0)
@@ -2660,8 +2724,8 @@ void register_console(struct console *newcon)
 			if (_braille_register_console(newcon, c))
 				return;
 
-			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
+			if (newcon->ops->setup &&
+			    newcon->ops->setup(newcon, c->options) != 0)
 				break;
 		}
 
@@ -2706,6 +2770,8 @@ void register_console(struct console *newcon)
 		console_drivers->next = newcon;
 	}
 
+	get_console(newcon);
+
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
@@ -2730,6 +2796,7 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 		logbuf_unlock_irqrestore(flags);
 	}
+	console_register_device(newcon);
 	console_unlock();
 	console_sysfs_notify();
 
@@ -2796,6 +2863,7 @@ int unregister_console(struct console *console)
 		console_drivers->flags |= CON_CONSDEV;
 
 	console->flags &= ~CON_ENABLED;
+	put_console(console);
 	console_unlock();
 	console_sysfs_notify();
 	return res;
@@ -2857,10 +2925,10 @@ static int __init printk_late_init(void)
 
 		/* Check addresses that might be used for enabled consoles. */
 		if (init_section_intersects(con, sizeof(*con)) ||
-		    init_section_contains(con->write, 0) ||
-		    init_section_contains(con->read, 0) ||
-		    init_section_contains(con->device, 0) ||
-		    init_section_contains(con->unblank, 0) ||
+		    init_section_contains(con->ops->write, 0) ||
+		    init_section_contains(con->ops->read, 0) ||
+		    init_section_contains(con->ops->device, 0) ||
+		    init_section_contains(con->ops->unblank, 0) ||
 		    init_section_contains(con->data, 0)) {
 			/*
 			 * Please, consider moving the reported consoles out
@@ -2877,6 +2945,14 @@ static int __init printk_late_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
+
+	ret = subsys_virtual_register(&console_subsys, NULL);
+	WARN_ON(ret < 0);
+
+	printk_late_done = 1;
+	for_each_console(con)
+		console_register_device(con);
+
 	return 0;
 }
 late_initcall(printk_late_init);
-- 
2.17.1

