Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4A8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E920820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfIVGFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 02:05:15 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58464 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfIVGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 02:05:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46bcP93Pwrz1rK4Q;
        Sun, 22 Sep 2019 08:05:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46bcP93CqSz1qqkb;
        Sun, 22 Sep 2019 08:05:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Djx9Fi2x_ceI; Sun, 22 Sep 2019 08:04:56 +0200 (CEST)
X-Auth-Info: QMFx0JFafIbtuzSv5efokL78tnCcEXbgcUEa3aFRAdQ=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 22 Sep 2019 08:04:56 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id DDB1318530E;
        Sun, 22 Sep 2019 08:04:06 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id D912F1A0097; Sun, 22 Sep 2019 08:04:06 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] misc: add support for the cc1101 RF transceiver chip from TI
Date:   Sun, 22 Sep 2019 08:03:56 +0200
Message-Id: <20190922060356.58763-3-hs@denx.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190922060356.58763-1-hs@denx.de>
References: <20190922060356.58763-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides support for the Low-Power Sub-1 GHz RF
Transceiver chip from Texas Instruments. It provides a
simple message based protocol to set chip registers, send
and receive packets to/from the chip. For more details
see Documentation/misc-devices/cc1101.txt and
Documentation/devicetree/bindings/misc/cc1101.txt

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 Documentation/misc-devices/cc1101.txt |  446 ++++++
 drivers/misc/Kconfig                  |   11 +
 drivers/misc/Makefile                 |    1 +
 drivers/misc/cc1101.c                 | 2004 +++++++++++++++++++++++++
 drivers/misc/cc1101.h                 |   89 ++
 include/uapi/linux/cc1101_user.h      |  255 ++++
 6 files changed, 2806 insertions(+)
 create mode 100644 Documentation/misc-devices/cc1101.txt
 create mode 100644 drivers/misc/cc1101.c
 create mode 100644 drivers/misc/cc1101.h
 create mode 100644 include/uapi/linux/cc1101_user.h

diff --git a/Documentation/misc-devices/cc1101.txt b/Documentation/misc-devices/cc1101.txt
new file mode 100644
index 0000000000000..61d11baa70dad
--- /dev/null
+++ b/Documentation/misc-devices/cc1101.txt
@@ -0,0 +1,446 @@
+=============
+cc1101 driver
+=============
+
+abstract
+========
+
+This driver add support for the cc1101 Low-Power Sub-1 GHz RF Transceiver
+chip from Texas Instruments [1].
+
+The driver do not know anything about the data which is received
+or transmitted, beside the first byte is always a length byte, as
+this driver supports only variable packet length mode, see [1]
+chapter "0x08: PKTCTRL0 – Packet Automation Control"
+
+driver supports:
+
+- define different cc1101 register configurations. Each configuration
+  is referenced through a name.
+
+- define delay tables which are used for CSMA delay timeouts. Each
+  delay table is referenced through a name.
+
+- receive data from the cc1101 chip.
+
+- send data to the cc1101 chip
+
+  - optionally check if channel is free (CSMA). It is configurable
+    which delay table is used for the current packet, and how many
+    times the driver tries to get a free band.
+
+  - optionally send a preamble before the data, length of the preamble
+    is configurable through module parameter preamble_timeout in msec.
+
+- communication with userspace is message based
+
+- userspace can define a job, which contains more than one message
+  the driver executes each message.
+
+- driver can generate events (if enabled in register configuration)
+  which means the driver calculates all 100 ms the current rssi value
+  and send it to userspace.
+
+module parameter
+================
+
+preamble_timeout: timeout for sending preamble in msec
+                  default: 360
+
+DTS
+===
+
+see:
+Documentation/devicetree/bindings/misc/cc1101.txt
+
+cc1101 register settings
+========================
+
+For correct working the driver needs some register settings,
+you cannot change. Without them it makes no sense to use the
+driver (for example, the GDOx pins are used as IRQ pins, and
+if they are not setup in IRQ mode you get unexpected behaviour.
+For example on GDO0 outputs a 24MHz clock ... which will stall
+your cpu when the driver enables the GDO0 pin as irq).
+
+Following the register settings the driver checks:
+
+GDO0 setting
+............
+
+IOCFG0 (0x2) mode 0x6
+Asserts when sync word has been sent / received, and de-asserts
+at the end of the packet. In RX, the pin will also deassert when
+a packet is discarded due to address or maximum length filtering
+or when the radio enters RXFIFO_OVERFLOW state. In TX the pin
+will de-assert if the TX FIFO underflows.
+
+GDO2 setting
+............
+
+IOCFG2 (0x0) mode 0xe
+Carrier sense. High if RSSI level is above threshold.
+Cleared when entering IDLE mode.
+
+set automatic rx mode
+.....................
+
+MCSM1 (0x17): RXOFF_MODE und TXOFF_MODE must be 0xf
+so the cc1101 chip go into rx mode after tx or rx finished.
+
+If this bits are not set, driver tries to set rx mode after
+successful rx or tx. But this is slow and may leads in missing
+rx packets.
+
+variable packet length mode
+...........................
+
+This driver supports variable packet length mode only,
+see [1] chapter "0x08: PKTCTRL0 – Packet Automation Control"
+
+packet format
+.............
+
+only "normal" mode (use FIFOs for RX and TX) is supported.
+
+append status
+.............
+
+This setting is optional.
+
+PKTCTRL1 (0x07) APPEND_STATUS
+-> cc1101 appends 2 bytes to each received packet
+
+
+userspace interface
+===================
+
+The driver interface is message based, which means the Userspace
+has to setup messages and send them to the driver. Also, the driver
+use messages to communicate with the Userspace process.
+
+It could be needed to send more than one message to the driver
+at once, so messages can be grouped into one job, give the job an ID
+and send it to the driver, see "send a job". The driver than go through
+the single messages in the job and executes them. For example it is
+possible to set a register configuration A, send some data, switch than
+to register configuration B and send there again some data, switch than
+back to register setting A and switch to rx mode. If the driver has
+finsihed the job, or an error occured, the driver sends back
+a message to the userspace, see "infos for a finished job".
+
+common message format
+---------------------
+
+all messages in read and write direction start with:
+
++----------+...
+| int type |
++----------+...
+
+The content of type differs between read and write direction.
+
+write to driver
+---------------
+
+The following message types are possible:
+
+- CC1101_MSG_RCV
+- CC1101_MSG_DEFINE_CONFIG
+- CC1101_MSG_DEL_CONFIG
+- CC1101_MSG_JOB
+- CC1101_MSG_DEFINE_DELAY
+- CC1101_MSG_SET_PATABLE
+- CC1101_MSG_GET_CARRIER_SENSE
+
+set receive mode
+................
+
+Use this type for setting up the cc1101 registers with
+a register configuration, defined with CC1101_MSG_DEFINE_CONFIG
+and put the cc1101 chip into rx mode.
+
+setup the struct msg_queue_user_rcv
+
++----------------+-------------------------------+
+| CC1101_MSG_RCV | config_name[CFG_NAME_MAX_LEN] |
++----------------+-------------------------------+
+
+config_name: 0 terminated string, contains the name of a register setting.
+
+define a register configuration
+...............................
+
+type: CC1101_MSG_DEFINE_CONFIG
+
+define a register setting for the cc1101 and give it a name.
+This register setting can than be used for setting a specific
+register setting. Before a register setting is applied to the
+cc1101 chip, the driver resets the cc1101 chip, so all registers
+have default values, which means, you only have to define registers
+which have different values from the default value.
+
+If you use SmartRFstudio [2] you can export a register table,
+in c friendly format which exactly contains only the differences,
+and you can use it in your userspace program.
+
+setup the struct msg_queue_user_config_data
+
++--------------------------+-------------------------------+------------+-----------+----------+      +---+---+
+| CC1101_MSG_DEFINE_CONFIG | config_name[CFG_NAME_MAX_LEN] | char flags | char addr | char val | .... | 0 | 0 |
++--------------------------+-------------------------------+------------+-----------+----------+      +---+---+
+
+flags : CC1101_FLAG_CFG_*
+config_name: 0 terminated string, contains the name of a register setting.
+followed by a list of "addr | value" elements, terminated with "0 0"
+
+Userspace example:
+
+::
+
+  static const struct config_param demo_rx[] =
+  {
+  {CCxxx0_IOCFG0, 0x06},
+  {CCxxx0_FIFOTHR, 0x47},
+  {CCxxx0_PKTCTRL0, 0x05},
+  {CCxxx0_FSCTRL1, 0x06},
+  {CCxxx0_FREQ2, 0x21},
+  {CCxxx0_FREQ1, 0x62},
+  {CCxxx0_FREQ0, 0x76},
+  {CCxxx0_MDMCFG4, 0xC8},
+  {CCxxx0_MDMCFG3, 0x93},
+  {CCxxx0_MDMCFG2, 0x13},
+  {CCxxx0_DEVIATN, 0x34},
+  {CCxxx0_MCSM0, 0x18},
+  {CCxxx0_FOCCFG, 0x16},
+  {CCxxx0_AGCCTRL2, 0x43},
+  {CCxxx0_WORCTRL, 0xFB},
+  {CCxxx0_FSCAL3, 0xE9},
+  {CCxxx0_FSCAL2, 0x2A},
+  {CCxxx0_FSCAL1, 0x00},
+  {CCxxx0_FSCAL0, 0x1F},
+  {CCxxx0_TEST2, 0x81},
+  {CCxxx0_TEST1, 0x35},
+  {CCxxx0_TEST0, 0x09},
+  {CFG_END, CFG_END},
+  };
+
+  #define CONFIG_MAX_EL	30
+  struct config_demo {
+	int		type;
+	char		config_name[CFG_NAME_MAX_LEN];
+	struct		config_param cfg[CONFIG_MAX_EL];
+  };
+
+  struct config_demo cfg1;
+
+  memset(&cfg1, 0x0, sizeof(cfg1));
+  cfg1.type = CC1101_MSG_DEFINE_CONFIG;
+  memcpy(cfg1.cfg, demo_rx, sizeof(demo_rx));
+  sprintf(cfg1.config_name, "%s", "demo");
+  ret = write(fd, &cfg1, sizeof(cfg1));
+
+delete a register configuration
+...............................
+
+not implemented yet.
+
+type = CC1101_MSG_DEL_CONFIG
+
+define a delay timing configuration
+...................................
+
+With this message userspace can define a table of count min and max
+timeout values and give this table a name. Later when sending a
+packet with csma checking activated, this table can be selected from
+the CC1101_MSG_USER_TYPE_SEND and the timeouts from this table are
+used.
+
+type: CC1101_MSG_DEFINE_DELAY
+
+setup the struct msg_queue_user_delay_data
+
++-------------------------+------------------------------+-----------+---------------+---------------+      +---+
+| CC1101_MSG_DEFINE_DELAY | delay_name[CFG_NAME_MAX_LEN] | int count | int delay_min | int delay_max | .... |   |
++-------------------------+------------------------------+-----------+---------------+---------------+      +---+
+
+config_name: 0 terminated string, contains the name of a delay table.
+count: maximal delays
+delay: list of count delays (min/max pairs) in ms
+
+example:
+
+::
+
+  static const struct delay_param delay_table_first[] =
+  {
+     {1, 4},
+     {5, 9},
+     {16, 32},
+  };
+
+  struct delay_table {
+        struct  msg_queue_user msg_user;
+        struct  msg_delay_data_user delay_data_user;
+        struct  delay_param delays[MAX_DELAYS];
+  };
+
+  struct delay_table dt;
+  memset(&dt, 0x0, sizeof(dt));
+  dt.msg_user.type = CC1101_MSG_DEFINE_DELAY;
+  dt.delay_data_user.count = sizeof(delay_table_first) / sizeof(struct delay_param);
+  sprintf(dt.delay_data_user.delay_name, "%s", "delay_first");
+  memcpy(&dt.delays, &delay_table_first, sizeof(delay_table_first));
+  ret = write(fd, &dt, sizeof(dt));
+
+Now you can select this delay table under the name "delay_first" in the
+driver.
+
+set patable
+...........
+
+Use this type for setting up the cc1101 registers 0x3e
+(PATABLE)
+
+setup the struct msg_queue_user_rcv
+
++------------------------+------------+
+| CC1101_MSG_SET_PATABLE | char value |
++------------------------+------------+
+
+value : contains the patable value
+
+send a job
+..........
+
+use this message format:
+
++----------------+------------+         ...         +
+| CC1101_MSG_JOB | int job id | n * struct msg_user |
++----------------+------------+         ...         +
+
+job id:
+  int, give the job a unique id. The driver sends a CC1101_READ_TYPE_ID
+  message with this ID back to the userspace, when the job is finished.
+
+struct msg_user:
+
++----------+--------------+----------+--------------------------+
+| int type | int preamble | int csma | buf[CC1101_MAX_DATA_LEN] |
++----------+--------------+----------+--------------------------+
+
+with
+
+type    : CC1101_MSG_USER_TYPE_
+preamble: 0 = short other long preamble
+csma    : -1 no csma,
+           0 send only
+          >0 try n times to get free channel
+buf     : dependend on type contains different content
+
+
+possible message types:
+
+CC1101_MSG_USER_TYPE_SEND
+
+send data in buf, with preamble and csma settings
+buf[0] is the length of the data
+
+CC1101_MSG_USER_TYPE_SET_CFG
+
+set a register configuration with name in buf
+buf contains a 0 terminated string.
+preamble and csma not used, should be 0
+
+CC1101_MSG_USER_TYPE_SET_DELAY
+
+set a delay table with name in buf. This table is used
+when a CC1101_MSG_USER_TYPE_SEND message with csma > 0
+value runs later.
+
+CC1101_MSG_USER_TYPE_SET_PATABLE
+
+patable value in buf[0]
+
+get carrier sense event
+.......................
+
+message format:
+
++------------------------------+
+| CC1101_MSG_GET_CARRIER_SENSE |
++------------------------------+
+
+You get back an event message:
+
+type    : CC1101_READ_TYPE_EVENT
+eventid : CC1101_READ_EVENT_ID_CARRIER
+value   : value
+reason  : CC1101_READ_EVENT_REASON_CALCULATED
+
+see events.
+
+Only enabled, if eventgeneration (CC1101_FLAG_CFG_TRIGGER) is set
+in configuration flags of the current register configuration.
+
+read from driver
+----------------
+
+all messages in read direction start with:
+
++----------+...
+| int type |
++----------+...
+
+types:
+
+rx data
+.......
+
++----------+--------+-----------+----------+-------------------------------+
+| int type | int id | char rssi | char len | char buf[CC1101_MAX_DATA_LEN] |
++----------+--------+-----------+----------+-------------------------------+
+
+  type:  CC1101_READ_TYPE_RX
+  id   : not used should be 0
+  rssi : contain rssi value
+  len  : len of received bytes
+  buf  : received data + 2 additional data bytes RSSI and LQI
+
+infos for a finished job
+........................
+
++----------+--------+---------------+-----------------------------------+
+| int type | int id | int errorcode | char data[CC1101_MAX_DATA_LEN -2] |
++----------+--------+---------------+-----------------------------------+
+
+  type      : C1101_READ_TYPE_ID
+  id        : job id
+  errorcode : CC1101_ECA_*
+
+Error                       Errorcode  data
+all fine                    0          none
+channel busy                -1         string: config name
+SPI communication error     -2         none
+unknown config name         -3         string: name of unknown config
+error setting config        -4         string: name of config
+unknown delay name          -5         string: name of unknown table
+error setting patable       -6         none
+
+events
+......
+
++----------+-------------+-----------+-----------+--------------------------------+
+| int type | int eventid | u8 value  | u8 reason | char data[CC1101_MAX_DATA_LEN] |
++----------+-------------+-----------+-----------+--------------------------------+
+
+type    : CC1101_READ_TYPE_EVENT
+eventid : CC1101_READ_EVENT_ID_*
+value   : value
+reason  : CC1101_READ_EVENT_REASON_*
+
+links
+=====
+
+[1] datasheet: http://www.ti.com/lit/ds/symlink/cc1101.pdf
+[2] smartRFstudio: http://www.ti.com/tool/SMARTRFTM-STUDIO
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c55b63750757d..fe2c9b8b72a63 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -466,6 +466,17 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config CC1101
+	tristate "cc1101 device support"
+	depends on SPI
+	help
+	  This driver provides support for the Low-Power Sub-1 GHz RF
+	  Transceiver chip from Texas Instruments. It provides a
+	  simple message based protocol to set chip registers, send
+	  and receive packets to/from the chip. For more details
+	  see Documentation/misc-devices/cc1101.txt and
+	  Documentation/devicetree/bindings/misc/cc1101.txt
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d35dc7e2..ec51e73359c48 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_CC1101)		+= cc1101.o
diff --git a/drivers/misc/cc1101.c b/drivers/misc/cc1101.c
new file mode 100644
index 0000000000000..432a33039ac02
--- /dev/null
+++ b/drivers/misc/cc1101.c
@@ -0,0 +1,2004 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Heiko Schocher <hs@denx.de>
+ * DENX Software Engineering GmbH
+ *
+ */
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/of_gpio.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/list.h>
+#include <linux/atomic.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi.h>
+#include <linux/cc1101_user.h>
+
+#include <cc1101.h>
+
+static int preamble_timeout = 360;
+module_param(preamble_timeout, int, 0644);
+MODULE_PARM_DESC(preamble_timeout,
+		 "timeout for long preamble in msec");
+
+#define CC1101_TIMEOUT_WAIT_IRQ		(5 * HZ)
+
+#define	CLASS_NAME	"rf868"
+#define DRV_NAME	"cc1101"
+#define DRV_VERSION	"1.00"
+#define CC1101_MAJOR	247
+
+static int opened;
+static int cc1101_major = CC1101_MAJOR;
+static struct class *cc1101_class;
+static struct device *cc1101_device;
+struct cc1101_data *g_cc1101;
+
+#define BITS_X_WORD		8
+
+#define CC1101_WRITE_SINGLE(A)  ((A)&(~0xC0))
+#define CC1101_WRITE_BURST(A)   (((A)&(~0xC0)) | 0x40)
+#define CC1101_READ_SINGLE(A)   (((A)&(~0xC0)) | 0x80)
+#define CC1101_READ_BURST(A)    (((A)&(~0xC0)) | 0xC0)
+
+#define FIFO_BYTES                      0x7F
+#define FIFO_UNDER_OVERFLOW             0x80
+
+/* max time in usec, for waiting after chip reset */
+#define CC1101_WAIT_CHIP_RESET	1000000
+
+struct msg_config_data {
+	struct	list_head	list;
+	char	config_name[CFG_NAME_MAX_LEN];
+	char	flags; /* CC1101_FLAG_CFG_* */
+	struct	config_param *cfg;
+} __packed;
+
+struct msg_delay_data {
+	struct	list_head	list;
+	struct	msg_delay_data_user mddu;
+	struct	delay_param *delay;
+} __packed;
+
+/* list of jobs to do */
+struct job_data {
+	struct	list_head	list;
+	struct job_data_user	jobu;
+	struct	list_head	msg_list;
+} __packed;
+
+/* one message in a job */
+struct msg_data {
+	struct	list_head	list;
+	struct msg_user		user;
+} __packed;
+
+/* list of data to user space */
+struct read_data {
+	struct	list_head	list;
+	struct	read_data_user	user;
+} __packed;
+
+struct cc1101_stat {
+	unsigned long flags;
+	int rx_pcts;
+	int rx_bytes;
+	int tx_pcts;
+	int tx_bytes;
+	int tx_miss;
+	int tx_signal;
+	int err_csma;
+	int err_dt_count;
+	int err_rx;
+	int err_rx_len;
+	int err_tx_busy;
+	int err_tx_count;
+	int err_tx_fifo_not_empty;
+	int err_tx_underflow;
+	int err_crc_drop;
+	int poll_reset;
+};
+
+#define CC1101_INIT_MEM		0x01
+#define CC1101_INIT_CHAR_DEV	0x02
+#define CC1101_INIT_CDEV	0x04
+#define CC1101_INIT_CLASS	0x08
+#define CC1101_INIT_DEVICE	0x10
+#define CC1101_INIT_WQ_IRQ	0x20
+#define CC1101_INIT_SYSFS	0x80
+
+struct cc1101_data {
+	/* structs */
+	struct cdev cdev;
+	struct spi_device	*spi;
+	wait_queue_head_t	poll_wait;
+	wait_queue_head_t	wait_tx_irq;
+	struct workqueue_struct *wq_irq;
+	struct work_struct	work;
+	struct msg_config_data	cfg_list;
+	struct mutex		lock_cfg_list;
+	struct msg_delay_data	delay_list;
+	struct mutex		lock_delay_list;
+	struct msg_delay_data	*cur_delay_table;
+	struct job_data		job_list;
+	struct mutex		lock_write;
+	struct read_data	read_list;
+	struct mutex		lock_read;
+	/* vars */
+	struct cc1101_stat	stat;
+	atomic_t		tx_active;
+	struct msg_config_data	*config_set;
+	unsigned long		init;
+	int			irq_ena;
+	int			csma_busy;
+	int			spi_transfer_error;
+	int			newjob;
+	int			append_status;
+	int			set_rx;
+	/* carrier sense event */
+	int			average;
+	u8			cur_val;
+	u8			old_val;
+	int			trigger;
+	atomic_t		dotimer;
+	atomic_t		doirq;
+	int			cancel_timer;
+	struct hrtimer		event_timer;
+	ktime_t			event_delay;
+	/* parameters */
+	u32			freq;
+	u32			gdo0; /* IRQ pin */
+	u32			gdo0_flags;
+	u32			gdo2; /* busy */
+	u32			gdo2_flags;
+	/* buffers */
+	char			buf[CC1101_MAX_USER_BUF];
+	u8 __aligned(4)		spi_rx_buf[CC1101_MAX_DATA_LEN];
+	u8 __aligned(4)		spi_tx_buf[CC1101_MAX_DATA_LEN];
+};
+
+static inline int
+cc1101_get_count_msg(size_t l)
+{
+	return (l - sizeof(struct job_data_user)) / sizeof(struct msg_user);
+}
+
+static inline int
+cc1101_check_count_msg(size_t l)
+{
+	return (l - sizeof(struct job_data_user)) % sizeof(struct msg_user);
+}
+
+static inline struct job_data_user
+*cc1101_get_job_data_user(char *buf)
+{
+	return (struct job_data_user *)&buf[sizeof(struct msg_queue_user)];
+}
+
+static inline struct msg_user
+*cc1101_get_msg_data_user(char *buf)
+{
+	int off;
+
+	off = sizeof(struct job_data_user) + sizeof(struct msg_queue_user);
+	return (struct msg_user *)&buf[off];
+}
+
+/* list functions */
+static int
+cc1101_cfg_add_list(struct cc1101_data *cc1101, struct msg_config_data *new)
+{
+	int ret = 0;
+
+	mutex_lock(&cc1101->lock_cfg_list);
+	list_add_tail(&(new->list), &(cc1101->cfg_list.list));
+	mutex_unlock(&cc1101->lock_cfg_list);
+
+	return ret;
+}
+
+static int cc1101_cfg_rm_list(struct cc1101_data *cc1101, char *name)
+{
+	struct msg_config_data *found, *tmp;
+	int	len = strlen(name);
+
+	mutex_lock(&cc1101->lock_cfg_list);
+	list_for_each_entry_safe(found, tmp,
+			&cc1101->cfg_list.list, list) {
+		if (strncmp(found->config_name, name, len) == 0) {
+			kfree(found->cfg);
+			list_del(&found->list);
+			kfree(found);
+			mutex_unlock(&cc1101->lock_cfg_list);
+			return 0;
+		}
+	}
+	mutex_unlock(&cc1101->lock_cfg_list);
+
+	return -EFAULT;
+}
+
+static int
+cc1101_cfg_create_new_list(struct cc1101_data *cc1101,
+			   struct msg_config_data_user *user,
+			   int len)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct msg_config_data *cfg_data;
+	struct config_param *cfg;
+	int	count;
+	int	ret;
+
+	cc1101_cfg_rm_list(cc1101, user->config_name);
+	cfg_data = kzalloc(sizeof(struct msg_config_data), GFP_ATOMIC);
+	if (!cfg_data) {
+		dev_err(&spi->dev, "could not alloc msg_config_data\n");
+		return -ENOMEM;
+	}
+
+	count = (len - CFG_NAME_MAX_LEN - 1) / sizeof(struct config_param);
+	/* plus one for end */
+	cfg = kzalloc(sizeof(struct config_param) * (count + 1), GFP_ATOMIC);
+	if (!cfg) {
+		dev_err(&spi->dev, "could not alloc config_param\n");
+		kfree(cfg_data);
+		return -ENOMEM;
+	}
+	strncpy(cfg_data->config_name, user->config_name, CFG_NAME_MAX_LEN);
+	cfg_data->flags = user->flags;
+	memcpy(cfg, &user->cfg, count * sizeof(struct config_param));
+	cfg[count].addr = CFG_END;
+	cfg[count].val = CFG_END;
+
+	cfg_data->cfg = cfg;
+
+	ret = cc1101_cfg_add_list(cc1101, cfg_data);
+
+	return ret;
+}
+
+static struct msg_config_data
+*cc1101_cfg_get_data_list(struct cc1101_data *cc1101, char *name)
+{
+	struct msg_config_data *found, *tmp;
+	int	len = strlen(name);
+
+	mutex_lock(&cc1101->lock_cfg_list);
+	list_for_each_entry_safe(found, tmp,
+			&cc1101->cfg_list.list, list) {
+		if (strncmp(found->config_name, name, len) == 0) {
+			mutex_unlock(&cc1101->lock_cfg_list);
+			return found;
+		}
+	}
+
+	mutex_unlock(&cc1101->lock_cfg_list);
+
+	return NULL;
+}
+
+static struct msg_delay_data
+*cc1101_delay_get_data_list(struct cc1101_data *cc1101, char *name)
+{
+	struct msg_delay_data *found, *tmp;
+	int	len = strlen(name);
+
+	mutex_lock(&cc1101->lock_delay_list);
+	list_for_each_entry_safe(found, tmp,
+			&cc1101->delay_list.list, list) {
+		if (strncmp(found->mddu.delay_name, name, len) == 0) {
+			mutex_unlock(&cc1101->lock_delay_list);
+			return found;
+		}
+	}
+
+	mutex_unlock(&cc1101->lock_delay_list);
+
+	return NULL;
+}
+
+static int cc1101_delay_rm_list(struct cc1101_data *cc1101, char *name)
+{
+	struct msg_delay_data *found;
+
+	found = cc1101_delay_get_data_list(cc1101, name);
+	if (!found)
+		return 0;
+
+	if (cc1101->cur_delay_table == found)
+		cc1101->cur_delay_table = NULL;
+
+	kfree(found->delay);
+	list_del(&found->list);
+	kfree(found);
+	return 0;
+}
+
+static int
+cc1101_delay_create_new_list(struct cc1101_data *cc1101,
+			     struct msg_queue_user_delay_data *user)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct msg_delay_data_user *delay_data_user = &user->delay_data_user;
+	struct msg_delay_data *delay_data;
+	int	count;
+	int	ret;
+
+	cc1101_delay_rm_list(cc1101, delay_data_user->delay_name);
+	count = delay_data_user->count;
+	delay_data = kzalloc(sizeof(struct msg_delay_data), GFP_ATOMIC);
+	if (!delay_data) {
+		dev_err(&spi->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	delay_data->delay = kzalloc(sizeof(struct delay_param) * count,
+				    GFP_ATOMIC);
+	if (!delay_data->delay) {
+		dev_err(&spi->dev, "could not alloc delay_param\n");
+		kfree(delay_data);
+		return -ENOMEM;
+	}
+
+	memcpy(&delay_data->mddu, delay_data_user,
+	       sizeof(struct msg_delay_data_user));
+	memcpy(delay_data->delay, &user->delays,
+	       count * sizeof(struct delay_param));
+
+	mutex_lock(&cc1101->lock_delay_list);
+	list_add_tail(&(delay_data->list), &(cc1101->delay_list.list));
+	mutex_unlock(&cc1101->lock_delay_list);
+
+	return ret;
+}
+
+static int cc1101_job_add(struct cc1101_data *cc1101, struct job_data *new)
+{
+	int ret = 0;
+
+	mutex_lock(&cc1101->lock_write);
+	list_add_tail(&(new->list), &(cc1101->job_list.list));
+	cc1101->newjob = 1;
+	mutex_unlock(&cc1101->lock_write);
+	queue_work(cc1101->wq_irq, &cc1101->work);
+
+	return ret;
+}
+
+static int cc1101_job_empty(struct cc1101_data *cc1101)
+{
+	int ret = 0;
+
+	mutex_lock(&cc1101->lock_write);
+	ret = list_empty(&cc1101->job_list.list);
+	cc1101->newjob = !ret;
+	mutex_unlock(&cc1101->lock_write);
+
+	return ret;
+}
+
+static struct job_data *cc1101_job_get(struct cc1101_data *cc1101)
+{
+	struct job_data *job;
+	int ret = 0;
+
+	mutex_lock(&cc1101->lock_write);
+	ret = list_empty(&cc1101->job_list.list);
+	cc1101->newjob = !ret;
+	if (ret) {
+		mutex_unlock(&cc1101->lock_write);
+		return NULL;
+	}
+
+	job = list_first_entry(&(cc1101->job_list.list), struct job_data,
+			       list);
+	list_del(&(job->list));
+	mutex_unlock(&cc1101->lock_write);
+	kfree(job);
+
+	return job;
+}
+
+static int cc1101_read_add(struct cc1101_data *cc1101, struct read_data *new)
+{
+	int ret = 0;
+
+	mutex_lock(&cc1101->lock_read);
+	list_add_tail(&(new->list), &(cc1101->read_list.list));
+	mutex_unlock(&cc1101->lock_read);
+
+	/* wakeup poll users */
+	wake_up_interruptible(&cc1101->poll_wait);
+
+	return ret;
+}
+
+static int cc1101_read_empty(struct cc1101_data *cc1101)
+{
+	int ret;
+
+	mutex_lock(&cc1101->lock_read);
+	ret = list_empty(&cc1101->read_list.list);
+	mutex_unlock(&cc1101->lock_read);
+
+	return ret;
+}
+
+static struct read_data *cc1101_read_get(struct cc1101_data *cc1101)
+{
+	struct read_data *read;
+
+	mutex_lock(&cc1101->lock_read);
+	if (list_empty(&cc1101->read_list.list)) {
+		mutex_unlock(&cc1101->lock_read);
+		return NULL;
+	}
+
+	read = list_first_entry(&(cc1101->read_list.list), struct read_data,
+				list);
+	list_del(&(read->list));
+	mutex_unlock(&cc1101->lock_read);
+
+	return read;
+}
+
+static int
+cc1101_msg_add(struct cc1101_data *cc1101, struct job_data *job,
+	       struct msg_data *new)
+{
+	int ret = 0;
+
+	list_add_tail(&(new->list), &(job->msg_list));
+	return ret;
+}
+
+static struct msg_data
+*cc1101_msg_get(struct cc1101_data *cc1101, struct job_data *job)
+{
+	struct msg_data *tmp;
+
+	if (list_empty(&job->msg_list))
+		return NULL;
+
+	tmp = list_first_entry(&(job->msg_list), struct msg_data, list);
+	return tmp;
+}
+
+static int cc1101_msg_free(struct cc1101_data *cc1101, struct msg_data *msg)
+{
+	list_del(&(msg->list));
+	kfree(msg);
+	return 0;
+}
+
+/* spi functions */
+
+/* The parameters for SPI are fixed as defined from chip */
+static void spi_cc1101_initialize(struct spi_device *spi)
+{
+	/* Configure the SPI bus */
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = BITS_X_WORD;
+	spi_setup(spi);
+}
+
+static int cc1101_spi_transfer(struct cc1101_data *cc1101, u32 len)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct spi_message m;
+	struct spi_transfer t;
+	int ret = 0;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf = cc1101->spi_tx_buf;
+	t.rx_buf = cc1101->spi_rx_buf;
+	t.len = len;
+	t.cs_change = 0;
+	if (cc1101->freq)
+		t.speed_hz = cc1101->freq;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(spi, &m);
+	if (ret)
+		dev_err(&spi->dev, "spi transfer failed\n");
+	cc1101->spi_transfer_error = ret;
+	return ret;
+}
+
+static int
+cc1101_write_reg(struct cc1101_data *cc1101, int reg, u8 data, u8 *status)
+{
+	struct spi_device *spi = cc1101->spi;
+	int len = 2;
+	int ret = 0;
+
+	cc1101->spi_tx_buf[0] = CC1101_WRITE_SINGLE(reg);
+	cc1101->spi_tx_buf[1] = data;
+	ret = cc1101_spi_transfer(cc1101, len);
+	if (ret < 0) {
+		dev_err(&spi->dev, "write reg failed: %x ret: %d\n", reg,
+			ret);
+		return ret;
+	}
+	*status = cc1101->spi_rx_buf[1];
+	return ret;
+}
+
+static int
+cc1101_write_reg_burst(struct cc1101_data *cc1101, int reg, u8 *data,
+		       int count, u8 *status)
+{
+	struct spi_device *spi = cc1101->spi;
+	int len = count + 1;
+	int ret = 0;
+
+	cc1101->spi_tx_buf[0] = CC1101_WRITE_BURST(reg);
+	memcpy(&cc1101->spi_tx_buf[1], data, count);
+	ret = cc1101_spi_transfer(cc1101, len);
+	if (ret < 0) {
+		dev_err(&spi->dev, "write reg burst failed: %x ret: %d\n",
+			reg, ret);
+		return ret;
+	}
+	*status = cc1101->spi_rx_buf[1];
+	return ret;
+}
+
+static int
+cc1101_read_reg(struct cc1101_data *cc1101, int reg, u8 *status, u8 *val)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret = 0;
+
+	if ((reg >= CCxxx0_IOCFG2) && (reg <= CCxxx0_TEST0)) {
+		cc1101->spi_tx_buf[0] = CC1101_READ_SINGLE(reg);
+	} else if ((reg >= CCxxx0_PARTNUM) && (reg <= CCxxx0_RXFIFO)) {
+		cc1101->spi_tx_buf[0] = CC1101_READ_BURST(reg);
+	} else {
+		dev_err(&spi->dev, "no valid register address: %x\n", reg);
+		return -EFAULT;
+	}
+	cc1101->spi_tx_buf[1] = 0;
+	ret = cc1101_spi_transfer(cc1101, 2);
+	if (ret < 0) {
+		dev_err(&spi->dev, "read reg failed: %x ret: %d\n", reg,
+			ret);
+		return ret;
+	}
+	*status = cc1101->spi_rx_buf[0];
+	*val = cc1101->spi_rx_buf[1];
+	return ret;
+}
+
+static int
+cc1101_read_reg_burst(struct cc1101_data *cc1101, int reg, u8 *data,
+		      int count, u8 *status)
+{
+	struct spi_device *spi = cc1101->spi;
+	int len = count + 1;
+	int ret = 0;
+
+	memset(cc1101->spi_tx_buf, 0, len);
+	if ((reg >= CCxxx0_PARTNUM) && (reg <= CCxxx0_RXFIFO)) {
+		cc1101->spi_tx_buf[0] = CC1101_READ_BURST(reg);
+	} else {
+		dev_err(&spi->dev, "no valid register address for burst: %x\n",
+			reg);
+		return -EFAULT;
+	}
+	ret = cc1101_spi_transfer(cc1101, len);
+	if (ret < 0) {
+		dev_err(&spi->dev, "read reg burst failed: %x ret: %d\n",
+			reg, ret);
+		return ret;
+	}
+	*status = cc1101->spi_rx_buf[0];
+	memcpy(data, &cc1101->spi_rx_buf[1], count);
+
+	return ret;
+}
+
+static int cc1101_cmd(struct cc1101_data *cc1101, int reg)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret = 0;
+	u8 status;
+
+	cc1101->spi_tx_buf[0] = CC1101_WRITE_SINGLE(reg);
+	cc1101->spi_rx_buf[0] = 0;
+	cc1101->spi_rx_buf[1] = 0;
+	ret = cc1101_spi_transfer(cc1101, 1);
+	if (ret < 0)
+		dev_err(&spi->dev, "command %x failed. ret: %d\n", reg, ret);
+
+	/* status table page 31 */
+	status = cc1101->spi_rx_buf[0];
+
+	return ret;
+}
+
+static void cc1101_sleep(int intervall)
+{
+	if (intervall > 10000) {
+		msleep(intervall / 1000);
+		return;
+	}
+	usleep_range(intervall, intervall);
+}
+
+/* chip functions */
+static int cc1101_start_rx_mode(struct cc1101_data *cc1101)
+{
+	struct spi_device *spi = cc1101->spi;
+
+	/* check, if we are not in Tx Mode */
+	if (atomic_read(&cc1101->tx_active) == 1) {
+		dev_err(&spi->dev, "we are in tx mode\n");
+		return -EBUSY;
+	}
+
+	/* switch to receive mode */
+	cc1101_cmd(cc1101, CCxxx0_SRX);
+
+	return 0;
+}
+
+static int
+cc1101_tx_packet(struct cc1101_data *cc1101, u8 *buf, u8 count, int preamble)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret;
+	u8 state;
+	u8 val;
+
+	if (preamble) {
+		atomic_set(&cc1101->tx_active, 1);
+		/* set into IDLE */
+		cc1101_cmd(cc1101, CCxxx0_SIDLE);
+		/* flush TX FIFO */
+		cc1101_cmd(cc1101, CCxxx0_SFTX);
+		/* enable freq synthesizer */
+		cc1101_cmd(cc1101, CCxxx0_SFSTXON);
+		/* enable TX */
+		cc1101_cmd(cc1101, CCxxx0_STX);
+
+		/*
+		 * now cc1101 starts with generating the preamble
+		 * wait preamble timeout
+		 */
+		cc1101_sleep(preamble_timeout * 1000);
+	}
+
+	ret = cc1101_write_reg_burst(cc1101, CCxxx0_TXFIFO, buf, count,
+				     &state);
+	if (ret < 0)
+		return ret;
+
+	if (!preamble) {
+		/* now start the Tx */
+		atomic_set(&cc1101->tx_active, 1);
+		cc1101_cmd(cc1101, CCxxx0_STX);
+	}
+
+	/* Now wait for Tx end IRQ */
+	ret = wait_event_interruptible_timeout(cc1101->wait_tx_irq,
+					       !atomic_read(&cc1101->tx_active),
+					       CC1101_TIMEOUT_WAIT_IRQ);
+	if (ret > 0) {
+		/* all fine, IRQ arrived */
+		ret = cc1101_read_reg(cc1101, CCxxx0_TXBYTES, &state, &val);
+		if ((ret != 0) || ((val & FIFO_BYTES) != 0)) {
+			dev_err(&spi->dev,
+				"%s: TX fifo underflow val: %x state: %x\n",
+				__func__, val, state);
+			cc1101->stat.err_tx_underflow++;
+			return -EIO;
+		}
+
+		cc1101->stat.tx_pcts++;
+		cc1101->stat.tx_bytes += count;
+		return 0;
+	} else if (ret == 0) {
+		/* timeout ... missing IRQ */
+		dev_err(&spi->dev, "%s IRQ missing!\n", __func__);
+		atomic_set(&cc1101->tx_active, 0);
+		cc1101->stat.tx_miss++;
+		return -EIO;
+	}
+
+	/* Interrupted through signal */
+	atomic_set(&cc1101->tx_active, 0);
+	cc1101->stat.tx_signal++;
+
+	return ret;
+}
+
+/*
+ * function should be called, after GDO0 is cleared
+ * -> end of packet received
+ */
+static int
+cc1101_rx_packet(struct cc1101_data *cc1101, u8 *buf, u8 *sz, u8 *rssi)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret;
+	u8 state;
+	u8 val;
+	u8 p_len;
+
+	ret = cc1101_read_reg(cc1101, CCxxx0_RXBYTES, &state, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & FIFO_UNDER_OVERFLOW) {
+		cc1101->stat.err_rx++;
+		dev_err(&spi->dev, "%s fifo underflow: state: %x val: %x\n",
+			__func__, state, val);
+		cc1101_read_reg(cc1101, CCxxx0_PKTSTATUS, &state, &val);
+		dev_err(&spi->dev, "%s pktstate: %x\n", __func__, val);
+		cc1101_cmd(cc1101, CCxxx0_SIDLE);
+		cc1101_cmd(cc1101, CCxxx0_SFRX);
+		cc1101_start_rx_mode(cc1101);
+		return -EPROTO;
+	} else if (!(val & FIFO_BYTES)) {
+		/* no packet due to filtering */
+		cc1101_read_reg(cc1101, CCxxx0_PKTSTATUS, &state, &val);
+		cc1101_cmd(cc1101, CCxxx0_SIDLE);
+		cc1101_cmd(cc1101, CCxxx0_SFRX);
+		cc1101_start_rx_mode(cc1101);
+		return -ENOENT;
+	}
+
+	ret = cc1101_read_reg(cc1101, CCxxx0_RXFIFO, &state, &p_len);
+	if (ret < 0)
+		return ret;
+
+	if (p_len > *sz) {
+		dev_err(&spi->dev, "%s p_len: %x > buffersize: %x\n",
+			__func__, p_len, *sz);
+		cc1101->stat.err_rx_len++;
+		cc1101_cmd(cc1101, CCxxx0_SIDLE);
+		cc1101_cmd(cc1101, CCxxx0_SFRX);
+		cc1101_start_rx_mode(cc1101);
+		return -ENOSPC;
+	}
+
+	/*
+	 * read 2 additional state bytes if
+	 * PKTCTRL1 (0x07) APPEND_STATUS is set.
+	 * state[0] = RSSI
+	 * state[1] = LQI
+	 */
+	ret = cc1101_read_reg_burst(cc1101, CCxxx0_RXFIFO, buf,
+				    p_len + cc1101->append_status, &state);
+	if (ret < 0)
+		return ret;
+
+	*sz = p_len;
+	cc1101->stat.rx_pcts++;
+	cc1101->stat.rx_bytes += p_len;
+
+	*rssi = 0;
+	if (cc1101->append_status) {
+		*rssi = buf[p_len];
+		if (!(buf[p_len + 1] & CRC_OK)) {
+			cc1101->stat.err_crc_drop++;
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int
+cc1101_check_register(struct cc1101_data *cc1101, int reg, u8 *val)
+{
+	struct spi_device *spi = cc1101->spi;
+
+	if (reg == CCxxx0_IOCFG2) {
+		if (*val != 0xe)
+			dev_err(&spi->dev,
+				"reg: %x val: %x not supported. Only mode 0xe allowed.\n",
+				reg, *val);
+		*val = 0xe;
+	}
+	if (reg == CCxxx0_IOCFG1) {
+		if (*val != 0x2e)
+			dev_err(&spi->dev,
+				"reg: %x val: %x not supported. Only mode 0x2e allowed.\n",
+				reg, *val);
+		*val = 0x2e;
+	}
+
+	if (reg == CCxxx0_IOCFG0) {
+		if (*val != 0x6)
+			dev_err(&spi->dev,
+				"reg: %x val: %x not supported. Only mode 0x6 allowed.\n",
+				reg, *val);
+		*val = 0x6;
+	}
+	if (reg == CCxxx0_PKTCTRL1) {
+		cc1101->append_status = 0;
+		/* check if append status bit is set */
+		if ((*val & CCxxx0_PKTCTRL1_APPEND_STATUS) ==
+		    CCxxx0_PKTCTRL1_APPEND_STATUS)
+			cc1101->append_status = 2;
+	}
+	if (reg == CCxxx0_PKTCTRL0) {
+		/* check if append status bit is set */
+		if ((*val & 0x30) != 0) {
+			dev_err(&spi->dev,
+				"reg: %x val: %x pkt_format must be 0\n",
+				reg, *val);
+		}
+		if ((*val & 0x03) != 1) {
+			dev_err(&spi->dev,
+				"reg: %x val: %x length config must be 1\n",
+				reg, *val);
+		}
+	}
+
+	if (reg == CCxxx0_MCSM1) {
+		cc1101->set_rx = 0;
+		if ((*val & 0xf) != 0xf) {
+			cc1101->set_rx = 1;
+			dev_err(&spi->dev,
+				"reg: %x val: %x not supported. Try to set Rx mode.\n",
+				reg, *val);
+		}
+	}
+	return 0;
+}
+
+static int cc1101_chip_reset(struct cc1101_data *cc1101)
+{
+	struct spi_device *spi = cc1101->spi;
+	ktime_t ktstart;
+	ktime_t delta_ktime;
+	u32 delta_usecs = 0;
+	u8 status, part;
+
+	/*
+	 * remove irq, as after reset default of gdo0 pin is 24MHz
+	 * which would stall our cpu.
+	 */
+	if (cc1101->irq_ena == 1) {
+		devm_free_irq(&spi->dev, gpio_to_irq(cc1101->gdo0), cc1101);
+		cc1101->irq_ena = 0;
+	}
+
+	/* reset */
+	cc1101_cmd(cc1101, 0);
+	cc1101_cmd(cc1101, CCxxx0_SRES);
+
+	/*
+	 * after a reset, we must poll the SO line, until it goes
+	 * low, see chapter 10.4 in the manual for the cc1101.
+	 *
+	 * Unfortunately, we cannot do this, so we read the
+	 * part number and check if it is 0.
+	 *
+	 * This works only for part number == 0, but we do check
+	 * the partnumber in this driver, so other supported
+	 * partnumbers must be added here too!
+	 */
+	cc1101->stat.poll_reset = 0;
+	ktstart = ktime_get();
+	cc1101_read_reg(cc1101, CCxxx0_PARTNUM, &status, &part);
+	while (part != 0) {
+		cc1101->stat.poll_reset++;
+		cc1101_read_reg(cc1101, CCxxx0_PARTNUM, &status, &part);
+		delta_ktime = ktime_sub(ktime_get(), ktstart);
+		delta_usecs = ktime_to_us(delta_ktime);
+		if (delta_usecs > CC1101_WAIT_CHIP_RESET) {
+			dev_dbg(&spi->dev,
+				"%s Timeout waiting for chip reset\n",
+				__func__);
+			return -EIO;
+		}
+	}
+
+	/* after reset we need a new config */
+	cc1101->config_set = NULL;
+	return 0;
+}
+
+static irqreturn_t cc1101_irq(int irq, void *pdata);
+
+static int
+cc1101_apply_config(struct cc1101_data *cc1101, struct msg_config_data *cfg)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct config_param *config = cfg->cfg;
+	int ret = 0;
+	int i;
+	int reg;
+	u8 val;
+
+	/* check if config is already set, so do not set it again. */
+	if (cc1101->config_set) {
+		if (cfg == cc1101->config_set) {
+			dev_dbg(&spi->dev, "config %s already set.\n",
+				cfg->config_name);
+			return -EEXIST;
+		}
+	}
+
+	/*
+	 * we reset the chip, as we know the default configuration
+	 * of the chip registers. So we need only to set register-
+	 * differences when we want a new configuration of the
+	 * chip.
+	 */
+	ret = cc1101_chip_reset(cc1101);
+	if (ret)
+		return ret;
+
+	i = 0;
+	while (!((config[i].addr == CFG_END) &&
+	       (config[i].val == CFG_END))) {
+		u8 status = 0;
+		u8 tmp;
+
+		reg = config[i].addr;
+		val = config[i].val;
+
+		cc1101_check_register(cc1101, reg, &val);
+		ret = cc1101_write_reg(cc1101, reg, val, &status);
+		if (ret != 0)
+			return ret;
+		ret = cc1101_read_reg(cc1101, reg, &status, &tmp);
+		if (ret != 0)
+			return ret;
+
+		if (tmp != val) {
+			dev_err(&spi->dev,
+				"config reg: %x failed: %x != %x\n", reg,
+				tmp, val);
+			return -EIO;
+		}
+		i++;
+	}
+
+	if (!cc1101->irq_ena) {
+		u32 active = (cc1101->gdo0_flags & GPIO_ACTIVE_LOW) ? 0 : 1;
+
+		/*
+		 * enable irq only after config is written
+		 * else we may have a wrong config for GDO0
+		 * default: there is a 24MHz clock output on it
+		 */
+		ret = devm_request_irq(&spi->dev, gpio_to_irq(cc1101->gdo0),
+				       cc1101_irq,
+				       (active ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING),
+				       "cc1101", cc1101);
+		if (ret)
+			return -ENODEV;
+
+		cc1101->irq_ena = 1;
+	}
+
+	cc1101->config_set = cfg;
+	return ret;
+}
+
+static int cc1101_detect_chip(struct cc1101_data *cc1101)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret = 0;
+	u8 status, part, vers;
+
+	ret = cc1101_chip_reset(cc1101);
+	if (ret != 0)
+		return ret;
+
+	ret = cc1101_read_reg(cc1101, CCxxx0_PARTNUM, &status, &part);
+	if (ret != 0)
+		return ret;
+
+	ret = cc1101_read_reg(cc1101, CCxxx0_VERSION, &status, &vers);
+	if (ret != 0)
+		return ret;
+
+	if ((part != 0) || (vers != 0x14)) {
+		dev_err(&spi->dev, "chip not found: part: %d version: %d\n",
+			part, vers);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int
+cc1101_startup(struct cc1101_data *cc1101, struct msg_config_data *cfg)
+{
+	int rx_notset;
+
+	rx_notset = cc1101_apply_config(cc1101, cfg);
+	if (rx_notset == -EEXIST)
+		rx_notset = 0;
+
+	atomic_set(&cc1101->tx_active, 0);
+	/* start in rx mode */
+	if (rx_notset == 0)
+		cc1101_start_rx_mode(cc1101);
+
+	return rx_notset;
+}
+
+/* GPIO Interrupt Handler. */
+static irqreturn_t cc1101_irq_gdo2(int irq, void *pdata)
+{
+	struct cc1101_data *cc1101 = (struct cc1101_data *)pdata;
+
+	cc1101->csma_busy = 1;
+	return IRQ_HANDLED;
+}
+
+
+static irqreturn_t cc1101_irq(int irq, void *pdata)
+{
+	struct cc1101_data *cc1101 = (struct cc1101_data *)pdata;
+
+	if (atomic_read(&cc1101->tx_active) == 1) {
+		atomic_set(&cc1101->tx_active, 0);
+		wake_up(&cc1101->wait_tx_irq);
+	} else {
+		queue_work(cc1101->wq_irq, &cc1101->work);
+		atomic_inc(&cc1101->doirq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* event specific functions */
+static int cc1101_send_event(struct cc1101_data *cc1101, u8 reason)
+{
+	struct read_data *new;
+	struct read_data_user_event *event;
+
+	new = kzalloc(sizeof(struct read_data), GFP_ATOMIC);
+	event = (struct read_data_user_event *)&new->user;
+	event->type = CC1101_READ_TYPE_EVENT;
+	event->eventid = CC1101_READ_EVENT_ID_CARRIER;
+	event->value = cc1101->cur_val;
+	event->reason = reason;
+
+	cc1101->old_val = cc1101->cur_val;
+	return cc1101_read_add(cc1101, new);
+}
+
+static int
+cc1101_check_carrier_sense_event(struct cc1101_data *cc1101, u8 reason)
+{
+	int ret = 0;
+
+	if (reason == CC1101_READ_EVENT_REASON_CALCULATED) {
+		ret = cc1101_send_event(cc1101, reason);
+		return ret;
+	}
+
+	/* if we have no running timer -> do not send event */
+	if (!hrtimer_active(&cc1101->event_timer))
+		return 0;
+
+	if (cc1101->cur_val > cc1101->old_val + 20)
+		ret = cc1101_send_event(cc1101,
+					CC1101_READ_EVENT_REASON_RISING);
+	if (cc1101->cur_val < cc1101->old_val - 20)
+		ret = cc1101_send_event(cc1101,
+					CC1101_READ_EVENT_REASON_FALLING);
+
+	return ret;
+}
+
+static int cc1101_calc_carrier_sense(struct cc1101_data *cc1101, u8 reason)
+{
+	struct spi_device *spi = cc1101->spi;
+	int val;
+	u16 carrier = 0;
+
+	if (atomic_read(&cc1101->tx_active) == 1) {
+		dev_dbg(&spi->dev, "do not calc carrier, as in tx mode\n");
+		return -EBUSY;
+	}
+
+	val = gpio_get_value(cc1101->gdo2);
+	if (val)
+		carrier = 200;
+
+	cc1101->average = cc1101->average - cc1101->cur_val + carrier;
+	cc1101->cur_val = cc1101->average >> 6;
+	cc1101_check_carrier_sense_event(cc1101, reason);
+
+	return 0;
+}
+
+static enum hrtimer_restart
+cc1101_event_timer_callback_nolock(struct hrtimer *timer)
+{
+	struct cc1101_data *cc1101 = container_of(timer, struct cc1101_data,
+						  event_timer);
+
+	atomic_inc(&cc1101->dotimer);
+	queue_work(cc1101->wq_irq, &cc1101->work);
+	if (cc1101->cancel_timer)
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, ns_to_ktime(cc1101->event_delay));
+	return HRTIMER_RESTART;
+}
+
+static void cc1101_stop_event_timer(struct cc1101_data *cc1101)
+{
+	cc1101->cancel_timer = 1;
+	hrtimer_cancel(&cc1101->event_timer);
+}
+
+static void cc1101_start_event_timer(struct cc1101_data *cc1101)
+{
+	unsigned int delay = 100;
+	ktime_t softlimit = ms_to_ktime(delay);
+	int ret;
+
+	cc1101->cancel_timer = 0;
+	ret = hrtimer_active(&cc1101->event_timer);
+	if (ret)
+		return;
+
+	cc1101->event_delay = softlimit;
+	hrtimer_start(&cc1101->event_timer, softlimit, HRTIMER_MODE_REL);
+}
+
+/*
+ * check if channel is free (CSMA)
+ *
+ * csma    : -1 no csma,
+ *          0 send only
+ *         >0 try n times to get free channel
+ */
+static int cc1101_check_csma(struct cc1101_data *cc1101,
+			      struct msg_user *msg)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct  delay_param *dp;
+	int csma = msg->csma;
+	int val;
+	int wait;
+	int i = 0;
+	int ret;
+	char random;
+
+	if (csma <= 0)
+		return 0;
+
+	/* timeouts in cur_delay_table */
+	mutex_lock(&cc1101->lock_delay_list);
+	if (csma > cc1101->cur_delay_table->mddu.count) {
+		cc1101->stat.err_dt_count++;
+		mutex_unlock(&cc1101->lock_delay_list);
+		return -EFAULT;
+	}
+	dp = cc1101->cur_delay_table->delay;
+	mutex_unlock(&cc1101->lock_delay_list);
+
+	while (i < csma) {
+		/* wait for cc1101->cur_delay_table */
+		get_random_bytes(&random, 1);
+		wait = dp->min + (dp->max - dp->min) * random / 255;
+
+		val = gpio_get_value(cc1101->gdo2);
+		if (val == 0) {
+			cc1101->csma_busy = 0;
+			/*
+			 * use ggdo2 as interrupt
+			 * if gdo2 goes to 1 we know, that the slot is busy!
+			 */
+			ret = devm_request_irq(&spi->dev,
+					       gpio_to_irq(cc1101->gdo2),
+					       cc1101_irq_gdo2,
+					       IRQF_TRIGGER_RISING,
+					       "cc1101-gdo2", cc1101);
+			if (ret)
+				return -ENODEV;
+
+			cc1101_sleep(wait * 1000);
+			/* disable gdo2 irq */
+			devm_free_irq(&spi->dev, gpio_to_irq(cc1101->gdo2),
+				      cc1101);
+			if (cc1101->csma_busy == 0)
+				return 0;
+		} else {
+			/* slot is busy -> wait */
+			cc1101_sleep(dp->max * 1000);
+		}
+		i++;
+		dp++;
+	}
+
+	cc1101->stat.err_csma++;
+	return -EBUSY;
+}
+
+static int cc1101_handle_message_send(struct cc1101_data *cc1101,
+				      struct msg_user *msg)
+{
+	struct spi_device *spi = cc1101->spi;
+	int ret = 0;
+	u8 state;
+	u8 val;
+	int preamble = msg->preamble;
+
+	if ((atomic_read(&cc1101->tx_active) == 1) ||
+	    (cc1101->config_set == NULL)) {
+		cc1101->stat.err_tx_busy++;
+		dev_err(&spi->dev, "%s tx not possible %d %p\n", __func__,
+			atomic_read(&cc1101->tx_active), cc1101->config_set);
+		return -EBUSY;
+	}
+
+	/* check if Tx FIFO is empty */
+	ret = cc1101_read_reg(cc1101, CCxxx0_TXBYTES, &state, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0) {
+		cc1101->stat.err_tx_fifo_not_empty++;
+		dev_err(&spi->dev, "%s Tx FIFO not empty val: %x\n",
+			__func__, val);
+		cc1101_cmd(cc1101, CCxxx0_SIDLE);
+		cc1101_cmd(cc1101, CCxxx0_SFRX);
+		cc1101_cmd(cc1101, CCxxx0_SFTX);
+		cc1101_start_rx_mode(cc1101);
+	}
+
+	/* check CSMA */
+	ret = cc1101_check_csma(cc1101, msg);
+	if (ret) {
+		cc1101_start_rx_mode(cc1101);
+		return ret;
+	}
+
+	/* now we can send our message */
+	ret = cc1101_tx_packet(cc1101, msg->buf, msg->buf[0] + 1, preamble);
+
+	if (cc1101->set_rx)
+		/* always go back into rx mode */
+		cc1101_start_rx_mode(cc1101);
+
+	if (ret) {
+		dev_err(&spi->dev, "error sending: %d\n", ret);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int
+cc1101_handle_set_cfg(struct cc1101_data *cc1101, char *config_name)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct msg_config_data *config_data;
+	int ret = 0;
+
+	/* find config from name */
+	config_data = cc1101_cfg_get_data_list(cc1101, config_name);
+	if (!config_data) {
+		dev_err(&spi->dev, "unknown cfg: %s\n", config_name);
+		return -EINVAL;
+	}
+
+	cc1101_stop_event_timer(cc1101);
+
+	/* switch to config */
+	ret = cc1101_startup(cc1101, config_data);
+	if (ret) {
+		dev_err(&spi->dev, "error startup %d cfg: %s\n", ret,
+			config_name);
+		return -EFAULT;
+	}
+
+	/* start event timer */
+	if ((config_data->flags & CC1101_FLAG_CFG_TRIGGER) ==
+	    CC1101_FLAG_CFG_TRIGGER)
+		cc1101_start_event_timer(cc1101);
+
+	return 0;
+}
+
+static int
+cc1101_handle_set_delay(struct cc1101_data *cc1101, struct msg_user *msg)
+{
+	struct spi_device *spi = cc1101->spi;
+	unsigned char *name = msg->buf;
+	struct msg_delay_data *delay_data;
+
+	/* find config from name */
+	delay_data = cc1101_delay_get_data_list(cc1101, name);
+	if (!delay_data) {
+		dev_err(&spi->dev, "unknown delay table: %s\n", name);
+		return -EINVAL;
+	}
+
+	/* set table */
+	mutex_lock(&cc1101->lock_delay_list);
+	cc1101->cur_delay_table = delay_data;
+	mutex_unlock(&cc1101->lock_delay_list);
+
+	return 0;
+}
+
+static int
+cc1101_handle_set_patable(struct cc1101_data *cc1101, struct msg_user *msg)
+{
+	struct spi_device *spi = cc1101->spi;
+	u8 state;
+	int ret;
+
+	ret = cc1101_write_reg(cc1101, CCxxx0_PATABLE, msg->buf[0], &state);
+	if (ret) {
+		dev_err(&spi->dev, "error %d set patable: %x %x\n", ret,
+			msg->buf[0], state);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+cc1101_handle_message(struct cc1101_data *cc1101, struct msg_data *msg)
+{
+	struct spi_device *spi = cc1101->spi;
+	struct msg_user *msgu = &msg->user;
+	int type = msgu->type;
+	int ret = 0;
+
+	switch (type) {
+	case CC1101_MSG_USER_TYPE_SEND:
+		ret = cc1101_handle_message_send(cc1101, msgu);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_CFG:
+		ret = cc1101_handle_set_cfg(cc1101,
+					     (unsigned char *)msgu->buf);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_DELAY:
+		ret = cc1101_handle_set_delay(cc1101, msgu);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_PATABLE:
+		ret = cc1101_handle_set_patable(cc1101, msgu);
+		break;
+	default:
+		dev_err(&spi->dev, "unknown type: %d\n", type);
+		ret =  -EFAULT;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * end job, as an error occurred.
+ * generate the message to userspace
+ */
+static struct read_data
+*cc1101_break_job(struct cc1101_data *cc1101, struct msg_data *msg,
+		  struct job_data *job, int retval)
+{
+	struct read_data *new;
+	struct read_data_user_ack *dtu;
+	struct msg_user *msgu = &msg->user;
+	int type = msgu->type;
+
+	/* init the message for the userspace */
+	new = kzalloc(sizeof(struct read_data), GFP_ATOMIC);
+	dtu = (struct read_data_user_ack *)&new->user;
+	dtu->type = CC1101_READ_TYPE_ID;
+	dtu->id = job->jobu.id;
+
+	dtu->errorcode = retval;
+	/* detect errorcode */
+	switch (type) {
+	case CC1101_MSG_USER_TYPE_SEND:
+		dtu->errorcode = CC1101_ECA_SEND;
+		memcpy(dtu->buf, cc1101->config_set->config_name,
+		       CFG_NAME_MAX_LEN);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_CFG:
+		if (retval == -EINVAL)
+			dtu->errorcode = CC1101_ECA_CFG_INVAL;
+		else
+			dtu->errorcode = CC1101_ECA_CFG;
+		memcpy(dtu->buf, msgu->buf,
+		       CC1101_MAX_DATA_LEN - 2);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_DELAY:
+		dtu->errorcode = CC1101_ECA_DELAY;
+		memcpy(dtu->buf, msgu->buf,
+		       CC1101_MAX_DATA_LEN - 2);
+		break;
+	case CC1101_MSG_USER_TYPE_SET_PATABLE:
+		dtu->errorcode = CC1101_ECA_PATABLE;
+		break;
+	}
+
+	/* in errorcase, delete all following messages */
+	while (msg != NULL) {
+		cc1101_msg_free(cc1101, msg);
+		msg = cc1101_msg_get(cc1101, job);
+	}
+
+	return new;
+}
+
+static int
+cc1101_handle_job(struct cc1101_data *cc1101, struct job_data *job)
+{
+	struct read_data *new = NULL;
+	struct read_data_user *dtu;
+	struct msg_data *msg;
+	int id = job->jobu.id;
+	int ret = 0;
+
+	msg = cc1101_msg_get(cc1101, job);
+	while (msg) {
+		/* handle message */
+		ret = cc1101_handle_message(cc1101, msg);
+		if (ret != 0) {
+			new = cc1101_break_job(cc1101, msg, job, ret);
+			msg = NULL;
+		} else {
+			cc1101_msg_free(cc1101, msg);
+			msg = cc1101_msg_get(cc1101, job);
+		}
+	}
+
+	if (!new) {
+		/* No error, Ack to userspace */
+		new = kzalloc(sizeof(struct read_data), GFP_ATOMIC);
+		dtu = &new->user;
+		dtu->type = CC1101_READ_TYPE_ID;
+		dtu->id = id;
+	}
+	if (cc1101->spi_transfer_error) {
+		struct read_data_user_ack *dua = (struct read_data_user_ack *)&new->user;
+
+		/* SPI communication problem */
+		dua->errorcode = CC1101_ECA_SPI_COM;
+	}
+	cc1101_read_add(cc1101, new);
+
+	return ret;
+}
+
+/* sysFS functions */
+static ssize_t
+cc1101_stat_show(struct device *dev, struct device_attribute *attr,
+		 char *buf)
+{
+	struct cc1101_data *cc1101 = g_cc1101;
+	struct cc1101_stat *st = &cc1101->stat;
+
+	return sprintf(buf, "%d %d %d %d %d %d %d %d\n",
+		       st->rx_pcts,
+		       st->rx_bytes,
+		       st->tx_pcts,
+		       st->tx_bytes,
+		       st->tx_miss,
+		       st->tx_signal,
+		       cc1101->append_status,
+		       cc1101->set_rx);
+}
+static DEVICE_ATTR_RO(cc1101_stat);
+
+static ssize_t
+cc1101_stat_error_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cc1101_data *cc1101 = g_cc1101;
+	struct cc1101_stat *st = &cc1101->stat;
+
+	return sprintf(buf, "%d %d %d %d %d %d %d %d %d %d\n",
+		       st->err_csma,
+		       st->err_dt_count,
+		       st->err_rx,
+		       st->err_rx_len,
+		       st->err_tx_fifo_not_empty,
+		       st->err_tx_count,
+		       st->err_tx_busy,
+		       st->err_tx_underflow,
+		       st->err_crc_drop,
+		       st->poll_reset);
+}
+static DEVICE_ATTR_RO(cc1101_stat_error);
+
+static int cc1101_create_sysfs(struct cc1101_data *cc1101)
+{
+	int ret = 0;
+
+	ret = device_create_file(cc1101_device, &dev_attr_cc1101_stat);
+	if (!ret)
+		cc1101->stat.flags |= 0x01;
+
+	ret = device_create_file(cc1101_device, &dev_attr_cc1101_stat_error);
+	if (!ret)
+		cc1101->stat.flags |= 0x02;
+
+	return ret;
+}
+
+static int cc1101_delete_sysfs(struct cc1101_data *cc1101)
+{
+	int ret = 0;
+
+	if ((cc1101->stat.flags & 0x01) == 0x01)
+		device_remove_file(cc1101_device, &dev_attr_cc1101_stat);
+
+	if ((cc1101->stat.flags & 0x02) == 0x02)
+		device_remove_file(cc1101_device,
+				   &dev_attr_cc1101_stat_error);
+	return ret;
+}
+
+/* device functions */
+static int cc1101_open(struct inode *inodep, struct file *filep)
+{
+	struct cc1101_data *cc1101 = g_cc1101;
+	struct spi_device *spi = cc1101->spi;
+	int ret;
+
+	if (opened)
+		return -EBUSY;
+
+	atomic_set(&cc1101->tx_active, 0);
+	filep->private_data = cc1101;
+	spi_cc1101_initialize(cc1101->spi);
+	ret = cc1101_detect_chip(cc1101);
+	if (ret != 0) {
+		dev_err(&spi->dev, "%s: could not find chip\n", DRV_NAME);
+		return ret;
+	}
+
+	cc1101_cmd(cc1101, CCxxx0_SIDLE);
+	cc1101_cmd(cc1101, CCxxx0_SFRX);
+	cc1101_cmd(cc1101, CCxxx0_SFTX);
+
+	hrtimer_init(&cc1101->event_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	cc1101->event_timer.function = cc1101_event_timer_callback_nolock;
+	cc1101_stop_event_timer(cc1101);
+	opened++;
+	return 0;
+}
+
+static ssize_t
+cc1101_read(struct file *filep, char *buffer, size_t len, loff_t *offset)
+{
+	struct cc1101_data *cc1101 = filep->private_data;
+	struct read_data *read;
+	struct  read_data_user	*user;
+	int ret;
+	int count = 0;
+	int pcklen = sizeof(struct read_data_user);
+
+	read = cc1101_read_get(cc1101);
+	while (read != NULL && (len >= count + pcklen)) {
+		user = &read->user;
+		ret = copy_to_user(&buffer[count], user, pcklen);
+		kfree(read);
+		if (ret != 0)
+			return -EFAULT;
+
+		count += pcklen;
+		read = cc1101_read_get(cc1101);
+	}
+
+	return count;
+}
+
+static ssize_t
+cc1101_write(struct file *filep, const char *buffer, size_t len,
+	     loff_t *offset)
+{
+	struct cc1101_data *cc1101 = filep->private_data;
+	struct spi_device *spi = cc1101->spi;
+	int ret;
+	struct msg_queue_user *msg;
+	struct msg_queue_user_config_data *config_data;
+	struct msg_queue_user_delay_data *dd;
+	struct msg_queue_user_rcv *rcv;
+	struct msg_queue_user_patable_data *pa;
+	struct job_data_user *user;
+	struct job_data *job;
+	struct msg_user	*msg_user;
+	struct msg_data	*msg_data;
+	int count;
+	int i;
+	u8 state;
+	u8 reason;
+	size_t l;
+
+	if (len > CC1101_MAX_USER_BUF)
+		return -ENOMEM;
+
+	ret = copy_from_user(&cc1101->buf[0], buffer, len);
+	if (ret)
+		return -EFAULT;
+
+	msg = (struct msg_queue_user *)cc1101->buf;
+	switch (msg->type) {
+	case CC1101_MSG_RCV:
+		/* set config */
+		rcv = (struct msg_queue_user_rcv *)cc1101->buf;
+		ret = cc1101_handle_set_cfg(cc1101,
+					    rcv->config_name);
+		break;
+	case CC1101_MSG_DEFINE_CONFIG:
+		config_data = (struct msg_queue_user_config_data *)cc1101->buf;
+		ret = cc1101_cfg_create_new_list(cc1101,
+						 &config_data->config_data_user,
+						 len - sizeof(int));
+		break;
+	case CC1101_MSG_DEFINE_DELAY:
+		dd = (struct msg_queue_user_delay_data *)cc1101->buf;
+		ret = cc1101_delay_create_new_list(cc1101, dd);
+		break;
+	case CC1101_MSG_GET_CARRIER_SENSE:
+		reason = CC1101_READ_EVENT_REASON_CALCULATED;
+		ret = cc1101_check_carrier_sense_event(cc1101, reason);
+		break;
+	case CC1101_MSG_SET_PATABLE:
+		/* set patable */
+		pa = (struct msg_queue_user_patable_data *)cc1101->buf;
+		ret = cc1101_write_reg(cc1101, CCxxx0_PATABLE,
+				       pa->patable_data_user.val, &state);
+		if (ret)
+			dev_err(&spi->dev, "error %d set patable: %x %x\n",
+				ret, pa->patable_data_user.val, state);
+		break;
+	case CC1101_MSG_JOB:
+		l = len - sizeof(struct msg_queue_user);
+		if (cc1101_check_count_msg(l)) {
+			dev_err(&spi->dev, "len: %d l: %d %d %d %d\n",
+				len, l, sizeof(struct msg_queue_user),
+				sizeof(struct job_data_user),
+				sizeof(struct msg_user));
+			return -EINVAL;
+		}
+		count = cc1101_get_count_msg(l);
+		user = cc1101_get_job_data_user(cc1101->buf);
+		job = kzalloc(sizeof(struct job_data), GFP_ATOMIC);
+		if (!job) {
+			dev_err(&spi->dev, "error job create, no mem\n");
+			return -ENOMEM;
+		}
+		job->jobu.id = user->id;
+		INIT_LIST_HEAD(&job->msg_list);
+		/* get now messages */
+		msg_user = cc1101_get_msg_data_user(cc1101->buf);
+		for (i = 0; i < count; i++) {
+			msg_data = kzalloc(sizeof(struct msg_data),
+					   GFP_ATOMIC);
+			memcpy(&msg_data->user, msg_user,
+			       sizeof(struct msg_user));
+			/* add to job list */
+			cc1101_msg_add(cc1101, job, msg_data);
+			msg_user++;
+		}
+		/* add job to job list */
+		cc1101_job_add(cc1101, job);
+		break;
+	default:
+		dev_err(&spi->dev, "unknown type: %d\n", msg->type);
+		ret = -EINVAL;
+	}
+
+	if (ret == 0)
+		return len;
+
+	return ret;
+}
+
+static int cc1101_release(struct inode *inodep, struct file *filep)
+{
+	struct cc1101_data *cc1101 = filep->private_data;
+	struct spi_device *spi = cc1101->spi;
+	struct read_data *rd;
+
+	if (!opened)
+		return 0;
+
+	/* wait for finishing all jobs */
+	while (!cc1101_job_empty(cc1101))
+		msleep(10);
+
+	cc1101_stop_event_timer(cc1101);
+
+	/* delete all messages to userspace */
+	rd = cc1101_read_get(cc1101);
+	while (rd != NULL)
+		rd = cc1101_read_get(cc1101);
+
+	atomic_set(&cc1101->dotimer, 0);
+	atomic_set(&cc1101->doirq, 0);
+	devm_free_irq(&spi->dev, gpio_to_irq(cc1101->gdo0), cc1101);
+	cc1101->irq_ena = 0;
+	opened--;
+
+	return 0;
+}
+
+static unsigned int
+cc1101_poll(struct file *filep, poll_table *wait)
+{
+	struct cc1101_data *cc1101 = filep->private_data;
+	unsigned int mask = 0;
+
+	poll_wait(filep, &cc1101->poll_wait, wait);
+	if (!cc1101_read_empty(cc1101))
+		mask |= POLLIN | POLLRDNORM;
+	return mask;
+}
+
+static void cc1101_irq_work(struct cc1101_data *cc1101)
+{
+	struct read_data *new;
+	struct read_data_user *dt;
+	int ret;
+
+	/* called if rx data is there */
+	/* get data and save it in buffer */
+	new = kzalloc(sizeof(struct read_data), GFP_ATOMIC);
+	dt = &new->user;
+	dt->type = CC1101_READ_TYPE_RX;
+	dt->len = CC1101_MAX_DATA_LEN;
+	ret = cc1101_rx_packet(cc1101, dt->buf, &dt->len, &dt->rssi);
+	if (ret) {
+		kfree(new);
+		new = NULL;
+	}
+	if (new)
+		cc1101_read_add(cc1101, new);
+
+	/* we must enable rx mode again */
+	if (cc1101->set_rx)
+		cc1101_start_rx_mode(cc1101);
+}
+
+static void cc1101_work(struct work_struct *ws)
+{
+	struct cc1101_data *cc1101 = container_of(ws, struct cc1101_data,
+						  work);
+	struct job_data *job;
+
+	while (atomic_read(&cc1101->dotimer) || atomic_read(&cc1101->doirq)) {
+		if (atomic_read(&cc1101->doirq)) {
+			cc1101_irq_work(cc1101);
+			atomic_dec(&cc1101->doirq);
+		}
+		if (atomic_read(&cc1101->dotimer)) {
+			cc1101_calc_carrier_sense(cc1101,
+						  CC1101_READ_EVENT_REASON_CYCLE);
+			atomic_dec(&cc1101->dotimer);
+		}
+	}
+	job = cc1101_job_get(cc1101);
+	if (job)
+		cc1101_handle_job(cc1101, job);
+}
+
+static const struct file_operations cc1101_fops = {
+	.open = cc1101_open,
+	.read = cc1101_read,
+	.write = cc1101_write,
+	.release = cc1101_release,
+	.poll  = cc1101_poll,
+};
+
+static void cc1101_free(struct cc1101_data *cc1101)
+{
+	if ((cc1101->init & CC1101_INIT_SYSFS) == CC1101_INIT_SYSFS)
+		cc1101_delete_sysfs(cc1101);
+	if ((cc1101->init & CC1101_INIT_WQ_IRQ) == CC1101_INIT_WQ_IRQ) {
+		flush_workqueue(cc1101->wq_irq);
+		destroy_workqueue(cc1101->wq_irq);
+	}
+	if ((cc1101->init & CC1101_INIT_DEVICE) == CC1101_INIT_DEVICE)
+		device_destroy(cc1101_class, MKDEV(cc1101_major, 0));
+	if ((cc1101->init & CC1101_INIT_CLASS) == CC1101_INIT_CLASS)
+		class_destroy(cc1101_class);
+	if ((cc1101->init & CC1101_INIT_CDEV) == CC1101_INIT_CDEV)
+		cdev_del(&cc1101->cdev);
+	if ((cc1101->init & CC1101_INIT_CHAR_DEV) == CC1101_INIT_CHAR_DEV)
+		unregister_chrdev(cc1101_major, DRV_NAME);
+
+	g_cc1101 = NULL;
+}
+
+static int cc1101_probe(struct spi_device *spi)
+{
+	dev_t dev = MKDEV(CC1101_MAJOR, 0);
+	struct cc1101_data *cc1101;
+	u32 flags;
+	int ret = 0;
+	int freq = 0;
+
+	cc1101 = devm_kzalloc(&spi->dev, sizeof(*cc1101), GFP_ATOMIC);
+	if (!cc1101)
+		return -ENOMEM;
+
+	cc1101->init |= CC1101_INIT_MEM;
+	g_cc1101 = cc1101;
+
+	cc1101->spi = spi;
+	spi_set_drvdata(spi, cc1101);
+
+	if (!spi->dev.of_node) {
+		dev_err(&spi->dev, "no DTS info\n");
+		cc1101_free(cc1101);
+		return -ENODEV;
+	}
+
+	if (!freq)
+		of_property_read_u32(spi->dev.of_node,
+				     "freq", &cc1101->freq);
+
+	cc1101->gdo0 = of_get_gpio_flags(spi->dev.of_node, 0, &flags);
+	cc1101->gdo0_flags = flags;
+	if (!gpio_is_valid(cc1101->gdo0)) {
+		dev_err(&spi->dev, "irq GPIO: %d\n",
+			cc1101->gdo0);
+		cc1101_free(cc1101);
+		return -EINVAL;
+	}
+
+	cc1101->gdo2 = of_get_gpio_flags(spi->dev.of_node, 1, &flags);
+	cc1101->gdo2_flags = flags;
+	if (!gpio_is_valid(cc1101->gdo2)) {
+		dev_err(&spi->dev, "GDO2 GPIO: %d\n",
+			cc1101->gdo0);
+		cc1101_free(cc1101);
+		return -EINVAL;
+	}
+
+
+	ret = devm_gpio_request(&spi->dev, cc1101->gdo0, "cc1101-irq");
+	if (ret) {
+		dev_err(&spi->dev, "gpio %d cannot be acquired\n",
+			cc1101->gdo0);
+		cc1101_free(cc1101);
+		return -ENODEV;
+	}
+
+	ret = devm_gpio_request(&spi->dev, cc1101->gdo2, "cc1101-gdo2");
+	if (ret) {
+		dev_err(&spi->dev, "gpio %d cannot be acquired\n",
+			cc1101->gdo2);
+		cc1101_free(cc1101);
+		return -ENODEV;
+	}
+
+	/*
+	 * Get the GPIO used as interrupt. The Slave raises
+	 * an interrupt when receive data is there.
+	 */
+	gpio_direction_input(cc1101->gdo0);
+	gpio_direction_input(cc1101->gdo2);
+
+	cc1101_major = register_chrdev(0, DRV_NAME, &cc1101_fops);
+	if (cc1101_major < 0) {
+		dev_err(&spi->dev, "Could not get major %d\n", cc1101_major);
+		cc1101_free(cc1101);
+		return cc1101_major;
+	}
+	cc1101->init |= CC1101_INIT_CHAR_DEV;
+
+	cdev_init(&cc1101->cdev, &cc1101_fops);
+	ret = cdev_add(&cc1101->cdev, dev, 1);
+	if (ret) {
+		dev_err(&spi->dev, "ccdev init %d\n", ret);
+		cc1101_free(cc1101);
+		return ret;
+	}
+	cc1101->init |= CC1101_INIT_CDEV;
+
+	/* Register the device class */
+	cc1101_class = class_create(THIS_MODULE, CLASS_NAME);
+	if (IS_ERR(cc1101_class)) {
+		cc1101_free(cc1101);
+		return PTR_ERR(cc1101_class);
+	}
+	cc1101->init |= CC1101_INIT_CLASS;
+
+	/* Register the device driver */
+	cc1101_device = device_create(cc1101_class, NULL,
+				      MKDEV(cc1101_major, 0),
+				      cc1101, DRV_NAME);
+	if (IS_ERR(cc1101_device)) {
+		cc1101_free(cc1101);
+		return PTR_ERR(cc1101_device);
+	}
+	cc1101->init |= CC1101_INIT_DEVICE;
+
+	atomic_set(&cc1101->dotimer, 0);
+	atomic_set(&cc1101->doirq, 0);
+	INIT_WORK(&cc1101->work, cc1101_work);
+	init_waitqueue_head(&cc1101->wait_tx_irq);
+	/* stuff from userspace */
+	init_waitqueue_head(&cc1101->poll_wait);
+	INIT_LIST_HEAD(&cc1101->cfg_list.list);
+	mutex_init(&cc1101->lock_cfg_list);
+	INIT_LIST_HEAD(&cc1101->delay_list.list);
+	mutex_init(&cc1101->lock_delay_list);
+	INIT_LIST_HEAD(&cc1101->job_list.list);
+	mutex_init(&cc1101->lock_write);
+	/* stuff to userspace */
+	INIT_LIST_HEAD(&cc1101->read_list.list);
+	mutex_init(&cc1101->lock_read);
+	cc1101->wq_irq = alloc_workqueue("cc1101_wq_irq",
+					 WQ_HIGHPRI | WQ_FREEZABLE |
+					 WQ_MEM_RECLAIM, 0);
+	if (!cc1101->wq_irq) {
+		cc1101_free(cc1101);
+		return -ENOMEM;
+	}
+	cc1101->init |= CC1101_INIT_WQ_IRQ;
+
+	ret = cc1101_create_sysfs(cc1101);
+	if (ret) {
+		cc1101_free(cc1101);
+		return ret;
+	}
+	cc1101->init |= CC1101_INIT_SYSFS;
+
+	dev_info(&spi->dev, "%s version %s initialized, major: %d freq: %d preamble_timeout: %d %p\n",
+		 DRV_NAME, DRV_VERSION, cc1101_major, cc1101->freq,
+		 preamble_timeout, g_cc1101);
+
+	return ret;
+};
+
+static int cc1101_remove(struct spi_device *spi)
+{
+	struct cc1101_data *cc1101 = spi_get_drvdata(spi);
+	int ret = 0;
+
+	cc1101_free(cc1101);
+	return ret;
+};
+
+static const struct spi_device_id cc1101_ids[] = {
+	{DRV_NAME, 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cc1101_ids);
+
+static const struct of_device_id cc1101_of_table[] = {
+	{ .compatible = "ti,cc1101" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cc1101_of_table);
+
+static struct spi_driver cc1101_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.of_match_table = cc1101_of_table,
+		.bus = &spi_bus_type,
+	},
+	.id_table	= cc1101_ids,
+	.probe	= cc1101_probe,
+	.remove	= cc1101_remove,
+};
+module_spi_driver(cc1101_driver);
+
+MODULE_DESCRIPTION("TI cc1101 driver");
+MODULE_AUTHOR("Heiko Schocher hs@denx.de");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/cc1101.h b/drivers/misc/cc1101.h
new file mode 100644
index 0000000000000..4877a5cf836f7
--- /dev/null
+++ b/drivers/misc/cc1101.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Heiko Schocher <hs@denx.de>
+ * DENX Software Engineering GmbH
+ *
+ */
+#ifndef _CC1101_H
+#define _CC1101_H
+
+/* Strobe commands */
+
+// Reset chip.
+#define CCxxx0_SRES		0x30
+/*
+ * Enable and calibrate frequency synthesizer (if MCSM0.FS_AUTOCAL=1).
+ * If in RX/TX: Go to a wait state where only the synthesizer is
+ * running (for quick RX / TX turnaround).
+ */
+#define CCxxx0_SFSTXON		0x31
+// Turn off crystal oscillator.
+#define CCxxx0_SXOFF		0x32
+/*
+ * Calibrate frequency synthesizer and turn it off
+ *(enables quick start).
+ */
+#define CCxxx0_SCAL		0x33
+/*
+ * Enable RX. Perform calibration first if coming from IDLE and
+ * MCSM0.FS_AUTOCAL=1.
+ */
+#define CCxxx0_SRX		0x34
+/*
+ * In IDLE state: Enable TX. Perform calibration first if
+ * MCSM0.FS_AUTOCAL=1. If in RX state and CCA is enabled:
+ * Only go to TX if channel is clear.
+ */
+#define CCxxx0_STX		0x35
+/*
+ * Exit RX / TX, turn off frequency synthesizer and exit
+ * Wake-On-Radio mode if applicable.
+ */
+#define CCxxx0_SIDLE		0x36
+// Perform AFC adjustment of the frequency synthesizer
+#define CCxxx0_SAFC		0x37
+// Start automatic RX polling sequence (Wake-on-Radio)
+#define CCxxx0_SWOR		0x38
+// Enter power down mode when CSn goes high.
+#define CCxxx0_SPWD		0x39
+// Flush the RX FIFO buffer.
+#define CCxxx0_SFRX		0x3A
+// Flush the TX FIFO buffer.
+#define CCxxx0_SFTX		0x3B
+// Reset real time clock.
+#define CCxxx0_SWORRST		0x3C
+/*
+ * No operation. May be used to pad strobe commands to two
+ * bytes for simpler software.
+ */
+#define CCxxx0_SNOP		0x3D
+
+#define CCxxx0_PARTNUM		0x30
+#define CCxxx0_VERSION		0x31
+#define CCxxx0_FREQEST		0x32
+#define CCxxx0_LQI		0x33
+#define CCxxx0_RSSI		0x34
+#define CCxxx0_MARCSTATE	0x35
+#define CCxxx0_WORTIME1		0x36
+#define CCxxx0_WORTIME0		0x37
+#define CCxxx0_PKTSTATUS	0x38
+#define CCxxx0_VCO_VC_DAC	0x39
+#define CCxxx0_TXBYTES		0x3A
+#define CCxxx0_RXBYTES		0x3B
+#define CCxxx0_RCCTRL1_STATUS	0x3C
+#define CCxxx0_RCCTRL0_STATUS	0x3D
+
+#define CCxxx0_PATABLE		0x3E
+#define CCxxx0_TXFIFO		0x3F
+#define CCxxx0_RXFIFO		0x3F
+
+/* main state machine mode in status byte */
+#define MSMM			0x70
+#define IS_RXFIFO_OVERFLOW(status)      (((status) & (0x80)) == 0x80)
+#define IS_TXFIFO_UNDERFLOW(status)     (((status) & (0x80)) == 0x80)
+
+#define CRC_OK                  0x80
+
+#define CCxxx0_PKTCTRL1_APPEND_STATUS	0x04
+
+#endif /* _CC1101_H */
diff --git a/include/uapi/linux/cc1101_user.h b/include/uapi/linux/cc1101_user.h
new file mode 100644
index 0000000000000..20dca5271a9ad
--- /dev/null
+++ b/include/uapi/linux/cc1101_user.h
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Heiko Schocher <hs@denx.de>
+ * DENX Software Engineering GmbH
+ *
+ */
+#ifndef _CC1101_UAPI_H
+#define _CC1101_UAPI_H
+
+// GDO2 output pin configuration
+#define CCxxx0_IOCFG2       0x00
+// GDO1 output pin configuration
+#define CCxxx0_IOCFG1       0x01
+// GDO0 output pin configuration
+#define CCxxx0_IOCFG0       0x02
+// RX FIFO and TX FIFO thresholds
+#define CCxxx0_FIFOTHR      0x03
+// Sync word, high byte
+#define CCxxx0_SYNC1        0x04
+// Sync word, low byte
+#define CCxxx0_SYNC0        0x05
+// Packet length
+#define CCxxx0_PKTLEN       0x06
+// Packet automation control
+#define CCxxx0_PKTCTRL1     0x07
+// Packet automation control
+#define CCxxx0_PKTCTRL0     0x08
+// Device address
+#define CCxxx0_ADDR         0x09
+// Channel number
+#define CCxxx0_CHANNR       0x0A
+// Frequency synthesizer control
+#define CCxxx0_FSCTRL1      0x0B
+// Frequency synthesizer control
+#define CCxxx0_FSCTRL0      0x0C
+// Frequency control word, high byte
+#define CCxxx0_FREQ2        0x0D
+// Frequency control word, middle byte
+#define CCxxx0_FREQ1        0x0E
+// Frequency control word, low byte
+#define CCxxx0_FREQ0        0x0F
+// Modem configuration
+#define CCxxx0_MDMCFG4      0x10
+// Modem configuration
+#define CCxxx0_MDMCFG3      0x11
+// Modem configuration
+#define CCxxx0_MDMCFG2      0x12
+// Modem configuration
+#define CCxxx0_MDMCFG1      0x13
+// Modem configuration
+#define CCxxx0_MDMCFG0      0x14
+// Modem deviation setting
+#define CCxxx0_DEVIATN      0x15
+// Main Radio Control State Machine configuration
+#define CCxxx0_MCSM2        0x16
+// Main Radio Control State Machine configuration
+#define CCxxx0_MCSM1        0x17
+// Main Radio Control State Machine configuration
+#define CCxxx0_MCSM0        0x18
+// Frequency Offset Compensation configuration
+#define CCxxx0_FOCCFG       0x19
+// Bit Synchronization configuration
+#define CCxxx0_BSCFG        0x1A
+// AGC control
+#define CCxxx0_AGCCTRL2     0x1B
+// AGC control
+#define CCxxx0_AGCCTRL1     0x1C
+// AGC control
+#define CCxxx0_AGCCTRL0     0x1D
+// High byte Event 0 timeout
+#define CCxxx0_WOREVT1      0x1E
+// Low byte Event 0 timeout
+#define CCxxx0_WOREVT0      0x1F
+// Wake On Radio control
+#define CCxxx0_WORCTRL      0x20
+// Front end RX configuration
+#define CCxxx0_FREND1       0x21
+// Front end TX configuration
+#define CCxxx0_FREND0       0x22
+// Frequency synthesizer calibration
+#define CCxxx0_FSCAL3       0x23
+// Frequency synthesizer calibration
+#define CCxxx0_FSCAL2       0x24
+// Frequency synthesizer calibration
+#define CCxxx0_FSCAL1       0x25
+// Frequency synthesizer calibration
+#define CCxxx0_FSCAL0       0x26
+// RC oscillator configuration
+#define CCxxx0_RCCTRL1      0x27
+// RC oscillator configuration
+#define CCxxx0_RCCTRL0      0x28
+// Frequency synthesizer calibration control
+#define CCxxx0_FSTEST       0x29
+// Production test
+#define CCxxx0_PTEST        0x2A
+// AGC test
+#define CCxxx0_AGCTEST      0x2B
+// Various test settings
+#define CCxxx0_TEST2        0x2C
+// Various test settings
+#define CCxxx0_TEST1        0x2D
+// Various test settings
+#define CCxxx0_TEST0        0x2E
+// RSSI
+#define CCxxx0_RSSI         0x34
+// PA Table
+#define CCxxx0_PATABLE      0x3E
+
+#define CFG_NAME_MAX_LEN	20
+/* 1 byte length + max length 64 + 2 bytes status */
+#define CC1101_MAX_DATA_LEN	(1 + 64 + 2)
+
+#define CC1101_MAX_USER_BUF	1024
+
+/* Message IDs */
+#define	CC1101_MSG_RCV			2
+#define	CC1101_MSG_DEFINE_CONFIG	3
+#define	CC1101_MSG_DEL_CONFIG		4
+#define	CC1101_MSG_JOB			5
+#define	CC1101_MSG_DEFINE_DELAY		6
+#define	CC1101_MSG_SET_PATABLE		7
+#define	CC1101_MSG_GET_CARRIER_SENSE	8
+
+struct __attribute__ ((packed)) msg_queue_user {
+	int	type; /* CC1101_MSG_SET_ */
+};
+
+/* CC1101_MSG_DEFINE_CONFIG */
+struct __attribute__ ((packed)) config_param {
+	char addr;
+	char val;
+};
+#define CFG_END	0x0
+
+#define CC1101_FLAG_CFG_TRIGGER		0x01
+
+struct __attribute__ ((packed)) msg_config_data_user {
+	char	config_name[CFG_NAME_MAX_LEN];
+	char	flags; /* CC1101_FLAG_CFG_* */
+	struct	config_param cfg;
+};
+
+struct __attribute__ ((packed)) msg_queue_user_config_data {
+	struct msg_queue_user msg_user;
+	struct msg_config_data_user config_data_user;
+};
+
+/* CC1101_MSG_DEFINE_DELAY */
+struct __attribute__ ((packed)) delay_param {
+	int	min;
+	int	max;
+};
+
+struct __attribute__ ((packed)) msg_delay_data_user {
+	char	delay_name[CFG_NAME_MAX_LEN];
+	int	count;
+};
+
+struct __attribute__ ((packed)) msg_queue_user_delay_data {
+	struct	msg_queue_user msg_user;
+	struct	msg_delay_data_user delay_data_user;
+	struct	delay_param delays;
+};
+
+/* CC1101_MSG_SET_PATABLE */
+struct __attribute__ ((packed)) msg_patable_data_user {
+	char	val;
+};
+
+struct __attribute__ ((packed)) msg_queue_user_patable_data {
+	struct	msg_queue_user msg_user;
+	struct	msg_patable_data_user patable_data_user;
+};
+
+/* CC1101_MSG_RCV */
+struct __attribute__ ((packed)) msg_queue_user_rcv {
+	struct msg_queue_user msg_user;
+	char	config_name[CFG_NAME_MAX_LEN];
+};
+
+/* CC1101_MSG_SEND */
+struct __attribute__ ((packed)) msg_queue_user_send {
+	struct msg_queue_user msg_user;
+	int	preamble; /* 0 short, other long */
+	int	csma;		/* -1 = no csma,
+				 * 0 = send,
+				 * try csma times with delays defines from
+				 * currentdelay table.
+				 */
+	char	buf[CC1101_MAX_DATA_LEN]; /* first byte is len */
+};
+
+#define CC1101_READ_TYPE_RX	0 /* Rx packet */
+#define CC1101_READ_TYPE_ID	1 /* ID ack tx */
+#define CC1101_READ_TYPE_EVENT	2 /* Events */
+
+struct __attribute__ ((packed)) read_data_user {
+	int	type;	/* CC1101_READ_TYPE_RX */
+	int	id;
+	char	rssi;
+	char	len;
+	char	buf[CC1101_MAX_DATA_LEN];
+};
+
+/* Errorcodes from driver to Userspace */
+#define CC1101_ECA_SEND		-1
+#define CC1101_ECA_SPI_COM	-2
+#define CC1101_ECA_CFG_INVAL	-3
+#define CC1101_ECA_CFG		-4
+#define CC1101_ECA_DELAY	-5
+#define CC1101_ECA_PATABLE	-6
+
+struct __attribute__ ((packed)) read_data_user_ack {
+	int	type;	/* CC1101_READ_TYPE_ID */
+	int	id;
+	int	errorcode;
+	char	buf[CC1101_MAX_DATA_LEN - 2];
+};
+
+#define CC1101_READ_EVENT_ID_CARRIER	1
+
+#define CC1101_READ_EVENT_REASON_CYCLE		0
+#define CC1101_READ_EVENT_REASON_CALCULATED	1
+#define CC1101_READ_EVENT_REASON_FALLING	2
+#define CC1101_READ_EVENT_REASON_RISING		3
+
+struct __attribute__ ((packed)) read_data_user_event {
+	int	type;	/* CC1101_READ_TYPE_EVENT */
+	int	eventid;/* CC1101_READ_EVENT_ID_* */
+	char	value;	/* current event value */
+	char	reason;	/* CC1101_READ_EVENT_REASON_* */
+	char	buf[CC1101_MAX_DATA_LEN];
+};
+
+/* JOB struct */
+struct __attribute__ ((packed)) job_data_user {
+	int	id; /* unique ID got from userspace */
+};
+
+#define CC1101_MSG_USER_TYPE_SEND	1
+#define CC1101_MSG_USER_TYPE_SET_CFG	2
+#define CC1101_MSG_USER_TYPE_SET_DELAY	3
+#define CC1101_MSG_USER_TYPE_SET_PATABLE	4
+struct __attribute__ ((packed)) msg_user {
+	int	type;	/* CC1101_MSG_USER_TYPE_ */
+	int	preamble; /* 0 short, other long */
+	int	csma;		/* -1 = no csma,
+				 * 0 = send,
+				 * try csma times with delays defines from
+				 * currentdelay table.
+				 */
+	char	buf[CC1101_MAX_DATA_LEN]; /* first byte is len */
+};
+
+#endif
-- 
2.21.0

