Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDEB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRObA0jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfCSMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:08:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32968 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:08:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so10487348pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwEhLdG8Dr6UZfd/RRikzRLr+/O6qqFOFGvx57J3Gss=;
        b=FRObA0jnm2L9RCQ6yLNctWfcRHHeFZYUQssFs4JpJZnZPnXnD8O6QwOYxQURL78kA8
         IfNYDYRCnydFybqnOD9YlkZ8uAzzf17BggokVWot3fzlxoq4G5E89InyqknZJXppyjni
         GKIW6XwKicE//3cUaVlOOE9S4MlNv63bN73SYVCeQ9itgXxm8ByHjP9dDfIT+YOua8c+
         3KloPduZ8Xrl5pSHjSc7MjqBno+mc7mM0LsB2ZwlfWtD1zVaMgdnSUPE+2gS7HCtXukN
         rUVPZaymWgHbm/3Pz+72/cvtruQTNg+FZsAXEQpwa2kCLx0SFP0hPGpGxcLV7jV2fqjA
         zCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwEhLdG8Dr6UZfd/RRikzRLr+/O6qqFOFGvx57J3Gss=;
        b=Gv7GUcf204GzqUIAFi12vPJ5IY4tQTRL1AuwlufGs7jecYZoRoHTBdCCJzTQhlnOkR
         vuXTDv3w7ghZBWEG7ErRwkMmzktjXtxx3JO1sw/wf1Qkyyfh06zCiJSMxbPV4jiyUElj
         kJ+QgMAdWpf70fk/JORrQPOykPEXoCXNnfCF+gbtnbola3hrXvrJRdKG2DjG9Ru/Ihht
         V5vBlbwDEX5OUck+zobHLXxUCAumZXnXipabin8sUvCRAeTXjinO2LnjHx++CfcAwgPx
         Xvl9I1j7bRIzzt8CkeLf/mPOmP3kKjddtlZ2CF8KeNnyfOE3wHVujvQiPQ35BMqS6ZYO
         QFUg==
X-Gm-Message-State: APjAAAX8YPLSbPNNWtCcDLedg9BD5Pwe9LGDj7odesztto5BL7Y0w33s
        +0bbzfFGgbnv41HovIJFrJE=
X-Google-Smtp-Source: APXvYqyf7Vv2LBYOJqZnxmxfMh/MeZ9cuYYenCDUiaYG/1/ie3TXOqNGB7jCVNq/VFpbJV1lSVyFrA==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr1826989plb.258.1552997308462;
        Tue, 19 Mar 2019 05:08:28 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-235-235.dynamic-ip.hinet.net. [114.36.235.235])
        by smtp.gmail.com with ESMTPSA id w67sm12911562pfw.173.2019.03.19.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 05:08:28 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 3/4] Add support for SUNIX Multi-I/O board
Date:   Tue, 19 Mar 2019 20:08:18 +0800
Message-Id: <20190319120818.3791-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add header files and Makefile. 

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 mfd/sunix/Makefile      |    9 +
 mfd/sunix/driver_extd.h |   90 ++++
 mfd/sunix/snx_common.h  | 1031 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1130 insertions(+)
 create mode 100644 mfd/sunix/Makefile
 create mode 100644 mfd/sunix/driver_extd.h
 create mode 100644 mfd/sunix/snx_common.h

diff --git a/mfd/sunix/Makefile b/mfd/sunix/Makefile
new file mode 100644
index 00000000..aae096b0
--- /dev/null
+++ b/mfd/sunix/Makefile
@@ -0,0 +1,9 @@
+#
+# drivers/mfd/sunix/Makefile
+#
+# Makefile for the SUNIX Multi-I/O device drivers.
+#
+
+obj-$(CONFIG_SUNIX) += snx.o
+
+snx-y := snx_main.o snx_serial.o snx_parallel.o snx_share.o snx_ieee1284.o snx_ieee1284_ops.o snx_ppdev.o snx_lp.o
diff --git a/mfd/sunix/driver_extd.h b/mfd/sunix/driver_extd.h
new file mode 100644
index 00000000..6000e285
--- /dev/null
+++ b/mfd/sunix/driver_extd.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _SNXHW_DRVR_EXTR_H_
+#define _SNXHW_DRVR_EXTR_H_
+
+#ifndef SNX_IOCTL
+#define SNX_IOCTL 0x900
+#endif
+
+#define SNX_COMM_GET_BOARD_CNT          (SNX_IOCTL + 100)
+#define SNX_COMM_GET_BOARD_INFO         (SNX_IOCTL + 101)
+
+#define SNX_UART_GET_TYPE               (SNX_IOCTL + 300)
+#define SNX_UART_SET_TYPE               (SNX_IOCTL + 301)
+#define SNX_UART_GET_ACS                (SNX_IOCTL + 302)
+#define SNX_UART_SET_ACS                (SNX_IOCTL + 303)
+
+#define SNX_BOARD_MAX_UARTCNT     32
+
+#define SNX_UART_RS232            0
+#define SNX_UART_RS422            1
+#define SNX_UART_RS485            2
+#define SNX_UART_A422485          3
+#define SNX_UART_ACS_D            0
+#define SNX_UART_ACS_E            1
+
+#define SNX_UART_TYPE_RS232       0
+#define SNX_UART_TYPE_RS422485    1
+#define SNX_UART_TYPE_3IN1        2
+
+
+typedef struct _SNX_DRVR_BOARD_CNT {
+	int                 cnt;
+
+} SNX_DRVR_BOARD_CNT, *PSNX_DRVR_BOARD_CNT;
+
+typedef struct _SNX_DRVR_UART_INFO {
+	int                 status;
+	int                 node_num;
+	int                 uart_type;
+
+} SNX_DRVR_UART_INFO, *PSNX_DRVR_UART_INFO;
+
+
+typedef struct _SNX_DRVR_BOARD_INFO {
+	int                 board_id;
+	int                 subvender_id;
+	int                 subsystem_id;
+	int                 oem_id;
+	int                 uart_cnt;
+	SNX_DRVR_UART_INFO  uart_info[SNX_BOARD_MAX_UARTCNT];
+	int                 gpio_chl_cnt;
+	int                 board_uart_type;
+int                 board_gpio_type;
+
+} SNX_DRVR_BOARD_INFO, *PSNX_DRVR_BOARD_INFO;
+
+typedef struct _SNX_DRVR_UART_GET_TYPE {
+	int                 board_id;
+	int                 uart_num;
+	int                 uart_type;
+
+} SNX_DRVR_UART_GET_TYPE, *PSNX_DRVR_UART_GET_TYPE;
+
+
+typedef struct _SNX_DRVR_UART_SET_TYPE {
+	int                 board_id;
+	int                 uart_num;
+	int                 uart_type;
+
+} SNX_DRVR_UART_SET_TYPE, *PSNX_DRVR_UART_SET_TYPE;
+
+
+typedef struct _SNX_DRVR_UART_GET_ACS {
+	int                 board_id;
+	int                 uart_num;
+	int                 uart_acs;
+
+} SNX_DRVR_UART_GET_ACS, *PSNX_DRVR_UART_GET_ACS;
+
+
+typedef struct _SNX_DRVR_UART_SET_ACS {
+	int                 board_id;
+	int                 uart_num;
+	int                 uart_acs;
+
+} SNX_DRVR_UART_SET_ACS, *PSNX_DRVR_UART_SET_ACS;
+
+
+#endif
diff --git a/mfd/sunix/snx_common.h b/mfd/sunix/snx_common.h
new file mode 100644
index 00000000..542964ed
--- /dev/null
+++ b/mfd/sunix/snx_common.h
@@ -0,0 +1,1031 @@
+﻿/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "driver_extd.h"
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/tty.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/parport.h>
+#include <linux/poll.h>
+#include <linux/serial_8250.h>
+#include <linux/sched/signal.h>
+#include <linux/tty_flip.h>
+
+#define SNX_DBG					0
+#define SNX_DBG_BOARD			0
+#define SNX_DBG_SERPORT			0
+#define SNX_DBG_PARPORT			0
+
+#define	VENID_GOLDEN			0x1409
+#define	DEVID_G_SERIAL			0x7168
+#define DEVID_G_PARALL			0x7268
+#define SUBVENID_GOLDEN			0x1409
+
+#define	VENID_MATRIX			0x1FD4
+#define	DEVID_M_SERIAL			0x0001
+#define SUBVENID_MATRIX			0x0001
+
+#define	VENID_SUN1999			0x1FD4
+#define	DEVID_S_SERIAL			0x1999
+#define DEVID_S_PARALL			0x1999
+#define SUBVENID_SUN1999		0x1FD4
+
+// golden board
+#define SUBDEVID_TEST			0x9999
+
+// matrix board
+// P1002
+#define SUBDEVID_P1002			0x1002
+// P1004
+#define SUBDEVID_P1004			0x1004
+// P1008
+#define SUBDEVID_P1008			0x1008
+// P1016
+#define SUBDEVID_P1016			0x1016
+// P2002
+#define SUBDEVID_P2002			0x2002
+// P2004
+#define SUBDEVID_P2004			0x2004
+// P2008
+#define SUBDEVID_P2008			0x2008
+// P3002
+#define SUBDEVID_P3002			0x3002
+// P3004
+#define SUBDEVID_P3004			0x3004
+// P3008
+#define SUBDEVID_P3008			0x3008
+
+
+// SUN1999 board
+//5027A 5027H 5027AL 5027HL
+#define SUBDEVID_5027A			0x0001
+//5037A 5037H
+#define SUBDEVID_5037A			0x0002
+//5056A 5056AL 5056H 5056HL
+#define SUBDEVID_5056A			0x0004
+//5066A 5066H
+#define SUBDEVID_5066A			0x0008
+//5016A
+#define SUBDEVID_5016A			0x0010
+
+
+// SUN1999-multi I/O
+//5069A 5069H
+#define SUBDEVID_5069A			0x0101
+//5079A 5079H
+#define SUBDEVID_5079A			0x0102
+//5099A 5099H
+#define SUBDEVID_5099A			0x0104
+
+// SUN1999-parallel board
+//5008A/AL
+#define SUBDEVID_5008A			0x0100
+
+//IPC-P2102 IPC-P2102SI
+#define SUBDEVID_P2102			0x0002
+//IPC-P2104 IPC-P2104SI
+#define SUBDEVID_P2104			0x0004
+//IPC-P2108 IPC-P2108SI
+#define SUBDEVID_P2108			0x0008
+//IPC-P2116
+#define SUBDEVID_P2116			0x0010
+
+// 3_in_1
+//IPC-P3104 IPC-P3104SI
+#define SUBDEVID_P3104			0x0084
+
+//IPC-P3108 IPC-P3104SI
+#define SUBDEVID_P3108			0x0088
+
+//CASH DRAWER CARD
+#define SUBDEVID_CASH_2S		0x0002
+#define SUBDEVID_CASH_4S		0x0004
+
+//DIO CARD
+#define SUBDEVID_DIO0802		0x0002
+
+#define SUBDEVID_DIO1604		0x0004
+
+#define SUBDEVID_DIO3204		0x0004
+
+
+// for chip_flag
+#define SUNNONE_HWID			0x0000
+#define SUN1889_HWID			0x0001
+#define SUN1699_HWID			0x0002
+#define SUN1888_HWID			0x0004
+#define SUN1689_HWID			0x0008
+#define SUNMATX_HWID			0x0010
+#define SUN1999_HWID			0x0020
+
+// for board_flag
+#define BOARDFLAG_NONE			0x0000
+#define BOARDFLAG_REMAP			0x0001
+#define BOARDFLAG_16PORTS		0x0002
+
+// for port_flag
+#define PORTFLAG_NONE			0x0000
+#define PORTFLAG_REMAP			0x0001
+#define PORTFLAG_16PORTS		0x0002
+
+// for part_number
+#define PART_NUMBER_NONE    0x0000
+
+// for card_type )
+#define CARD_TYPE_UART_ONLY    0x00
+#define CARD_TYPE_UART_GINTR   0x01
+#define CARD_TYPE_UART_GEXTR   0x02
+
+// for Gpio_ch_cnt )
+#define GPIO_NONE			0
+#define INTR_GPIO_6PORT		6
+#define EXTR_GPIO_8PORT		8
+#define EXTR_GPIO_16PORT	16
+#define EXTR_GPIO_32PORT	32
+
+// for port_flag
+#define PORTFLAG_NONE			0x0000
+#define PORTFLAG_REMAP			0x0001
+#define PORTFLAG_16PORTS		0x0002
+
+// board info
+#define SNX_BOARDS_MAX			4
+#define SNX_PORT_ONBOARD_MAX	16
+
+#define SNX_SER_TOTAL_MAX		32
+#define SNX_SER_ONBOARD_MAX		16
+
+// include lp0 and lp1 (mother board)
+#define SNX_PAR_SUPPORT_MAX		2
+#define SNX_PAR_TOTAL_MAX		4
+#define SNX_PAR_ONBOARD_MAX		2
+
+#define SUN1699_CLK_DIVIDER_DISABLE	0x10
+
+// 1889 uart fifo info
+#define SUN1889_FIFOSIZE_16					16
+#define SUN1889_TRIGGER_LEVEL_16FIFO_01		1
+#define SUN1889_TRIGGER_LEVEL_16FIFO_04		4
+#define SUN1889_TRIGGER_LEVEL_16FIFO_08		8
+#define SUN1889_TRIGGER_LEVEL_16FIFO_14		14
+
+#define SUN1889_FIFOSIZE_32					32
+#define SUN1889_TRIGGER_LEVEL_32FIFO_08		8
+#define SUN1889_TRIGGER_LEVEL_32FIFO_16		16
+#define SUN1889_TRIGGER_LEVEL_32FIFO_24		24
+#define SUN1889_TRIGGER_LEVEL_32FIFO_28		28
+
+// 1699 uart fifo info
+#define SUN1699_FIFOSIZE_16					16
+#define SUN1699_TRIGGER_LEVEL_16FIFO_01		1
+#define SUN1699_TRIGGER_LEVEL_16FIFO_04		4
+#define SUN1699_TRIGGER_LEVEL_16FIFO_08		8
+#define SUN1699_TRIGGER_LEVEL_16FIFO_14		14
+
+#define SUN1699_FIFOSIZE_32					32
+#define SUN1699_TRIGGER_LEVEL_32FIFO_08		8
+#define SUN1699_TRIGGER_LEVEL_32FIFO_16		16
+#define SUN1699_TRIGGER_LEVEL_32FIFO_24		24
+#define SUN1699_TRIGGER_LEVEL_32FIFO_28		28
+
+#define SUN1699_FIFOSIZE_64					64
+#define SUN1699_TRIGGER_LEVEL_64FIFO_16		16
+#define SUN1699_TRIGGER_LEVEL_64FIFO_32		32
+#define SUN1699_TRIGGER_LEVEL_64FIFO_48		48
+#define SUN1699_TRIGGER_LEVEL_64FIFO_56		56
+
+// matrix uart fifo info
+#define SUNMATX_FIFOSIZE_16					16
+#define SUNMATX_TRIGGER_LEVEL_16FIFO_01		1
+#define SUNMATX_TRIGGER_LEVEL_16FIFO_04		4
+#define SUNMATX_TRIGGER_LEVEL_16FIFO_08		8
+#define SUNMATX_TRIGGER_LEVEL_16FIFO_14		14
+
+#define SUNMATX_FIFOSIZE_64					64
+#define SUNMATX_TRIGGER_LEVEL_64FIFO_01		1
+#define SUNMATX_TRIGGER_LEVEL_64FIFO_16		16
+#define SUNMATX_TRIGGER_LEVEL_64FIFO_32		32
+#define SUNMATX_TRIGGER_LEVEL_64FIFO_56		56
+
+// 1999 uart fifo info
+#define SUN1999_FIFOSIZE_32					32
+#define SUN1999_TRIGGER_LEVEL_32FIFO_01		1
+#define SUN1999_TRIGGER_LEVEL_32FIFO_8		8
+#define SUN1999_TRIGGER_LEVEL_32FIFO_16		16
+#define SUN1999_TRIGGER_LEVEL_32FIFO_28		28
+
+#define SUN1999_FIFOSIZE_128				128
+#define SUN1999_TRIGGER_LEVEL_128FIFO_01	1
+#define SUN1999_TRIGGER_LEVEL_128FIFO_32	32
+#define SUN1999_TRIGGER_LEVEL_128FIFO_64	64
+#define SUN1999_TRIGGER_LEVEL_128FIFO_112	112
+
+// uart fifo setup
+#define SUN1889_FIFOSIZE_SET		SUN1889_FIFOSIZE_32
+#define SUN1889_TRIGGER_LEVEL_SET	SUN1889_TRIGGER_LEVEL_32FIFO_16
+
+#define SUN1699_FIFOSIZE_SET		SUN1699_FIFOSIZE_32
+#define SUN1699_TRIGGER_LEVEL_SET	SUN1699_TRIGGER_LEVEL_32FIFO_16
+
+#define SUNMATX_FIFOSIZE_SET		SUNMATX_FIFOSIZE_64
+#define SUNMATX_TRIGGER_LEVEL_SET	SUNMATX_TRIGGER_LEVEL_64FIFO_32
+
+#define SUN1999_FIFOSIZE_SET		SUN1999_FIFOSIZE_128
+#define SUN1999_TRIGGER_LEVEL_SET	SUN1999_TRIGGER_LEVEL_128FIFO_64
+
+#define UART_SUN1889_FCR_16BYTE		0x00
+#define UART_SUN1889_FCR_32BYTE		0x20
+
+#define UART_SUN1699_FCR_16BYTE		0x00
+#define UART_SUN1699_FCR_32BYTE		0x20
+#define UART_SUN1699_FCR_64BYTE		0x30
+
+#define UART_SUNMATX_FCR_64BYTE		0x20
+
+#define UART_SUN1999_FCR_128BYTE	0x20
+#define UART_DEFAULT_FCR			0x00
+
+#define DEFAULT_FIFOSIZE			1
+#define DEFAULT_TRIGGER_LEVEL		1
+
+// register status info
+#define UART_LSR_ERR_IN_RFIFO		0x80
+#define UART_MCR_AFE				0x20
+#define UART_IIR_CTO				0x0C
+
+// interrupt vedtor offset
+#define SUN1889_INTRSERVREG			0x1C
+
+// serial address length
+#define SNX_SER_ADDRESS_LENGTH		8
+
+// parallel address length
+#define SNX_PAR_ADDRESS_LENGTH		8
+#define SNX_PAR_STD_ADDR_LENGTH		3
+#define SNX_PAR_ETD_ADDR_LENGTH		5
+
+// PCI configuration bar 0 ~ 5
+#define SNX_PCICFG_BAR_TOTAL				6
+
+#define INTERRUPT_COUNT 128
+#define WAKEUP_CHARS    256
+
+#define SNXTERMIOS  ktermios
+
+// for snx_ser_port->snx_type
+#define SNX_SER_PORT_MAX_UART	5
+#define SNX_SER_PORT_UNKNOWN	0
+#define SNX_SER_PORT_SUN1889	1
+#define SNX_SER_PORT_SUN1699	2
+#define SNX_SER_PORT_SUNMATX	3
+#define SNX_SER_PORT_SUN1999    4
+
+
+// for snx_ser_port->setserial_flag
+#define SNX_SER_BAUD_SETSERIAL	1
+#define SNX_SER_BAUD_NOTSETSER	0
+
+// name length
+#define SNX_BOARDNAME_LENGTH  15
+#define SNX_DRIVERVERSION_LENGTH 15
+
+
+
+struct snx_ser_port_info {
+	char			board_name_info[SNX_BOARDNAME_LENGTH];
+	unsigned int	bus_number_info;
+	unsigned int	dev_number_info;
+	unsigned int	port_info;
+	unsigned int	base_info;
+	unsigned int	irq_info;
+};
+
+
+struct snx_par_port_info {
+	char			board_name_info[SNX_BOARDNAME_LENGTH];
+	unsigned int	bus_number_info;
+	unsigned int	dev_number_info;
+	unsigned int	port_info;
+	unsigned int	base_info;
+	unsigned int	base_hi_info;
+	unsigned int	irq_info;
+	unsigned int	minor;
+
+};
+
+
+typedef struct _snx_port {
+	char			type;
+	int				bar1;
+	unsigned char	offset1;
+	unsigned char	length1;
+	int				bar2;
+	unsigned char	offset2;
+	unsigned char	length2;
+	unsigned int	intmask;
+	unsigned int	chip_flag;
+
+} snx_port;
+
+
+typedef struct _pci_board {
+	unsigned int	vendor_id;
+	unsigned int	device_id;
+	unsigned int	sub_vendor_id;
+	unsigned int	sub_device_id;
+	unsigned int	num_serport;
+	unsigned int	num_parport;
+	unsigned int	intr_vector_bar;
+	unsigned char	intr_vector_offset;
+
+	char			board_name[SNX_BOARDNAME_LENGTH];
+	unsigned int	board_flag;
+	unsigned int	part_number;
+	unsigned int	card_type;
+	int				gpio_ch_cnt;
+
+	snx_port			port[SNX_PORT_ONBOARD_MAX];
+
+} pci_board;
+
+
+struct sunix_board;
+struct sunix_ser_port;
+struct sunix_par_port;
+
+
+struct sunix_board {
+	int						board_enum;
+	int						board_number;
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+
+	unsigned int			ports;
+	unsigned int			ser_port;
+	unsigned int			par_port;
+
+	unsigned int			ser_port_index;
+	unsigned int			par_port_index;
+
+	unsigned int			bar_addr[SNX_PCICFG_BAR_TOTAL];
+	unsigned int			irq;
+
+	unsigned int			board_flag;
+
+	unsigned int			vector_mask;
+	pci_board		pb_info;
+	struct pci_dev		*pdev;
+	int	(*ser_isr)(struct sunix_board *sb, struct sunix_ser_port *port);
+	int	(*par_isr)(struct sunix_board *sb, struct sunix_par_port *port);
+
+	unsigned int	oem_id;
+	int		uart_cnt;
+	int		gpio_chl_cnt;
+	unsigned char		board_uart_type;
+	unsigned char		board_gpio_type;
+	unsigned char		board_gpio_card_type;
+
+};
+
+#define SNX_IOCTL  0x900
+#define SNX_SER_DUMP_PORT_INFO  (SNX_IOCTL + 50)
+#define SNX_SER_DUMP_PORT_PERF  (SNX_IOCTL + 51)
+#define SNX_SER_DUMP_DRIVER_VER (SNX_IOCTL + 52)
+#define SNX_PAR_DUMP_PORT_INFO  (SNX_IOCTL + 53)
+#define SNX_PAR_DUMP_DRIVER_VER (SNX_IOCTL + 54)
+
+#define PORT_SER_UNKNOWN		0
+#define PORT_SER_8250			1
+#define PORT_SER_16450			2
+#define PORT_SER_16550			3
+#define PORT_SER_16550A			4
+#define PORT_SER_CIRRUS         5
+#define PORT_SER_16650			6
+#define PORT_SER_16650V2		7
+#define PORT_SER_16750			8
+#define PORT_SER_MAX_UART		8	/* max serial port ID */
+
+
+#define SNX_USF_CLOSING_WAIT_INF	(0)
+#define SNX_USF_CLOSING_WAIT_NONE	(65535)
+#define SNX_UART_CONFIG_TYPE	(1 << 0)
+#define SNX_UART_CONFIG_IRQ		(1 << 1)
+
+#define SNX_UART_XMIT_SIZE		4096
+
+#define snx_ser_circ_empty(circ)	\
+((circ)->head == (circ)->tail)
+#define snx_ser_circ_clear(circ)	\
+((circ)->head = (circ)->tail = 0)
+#define snx_ser_circ_chars_pending(circ)	\
+(CIRC_CNT((circ)->head, (circ)->tail, SNX_UART_XMIT_SIZE))
+#define snx_ser_circ_chars_free(circ)	\
+(CIRC_SPACE((circ)->head, (circ)->tail, SNX_UART_XMIT_SIZE))
+#define snx_ser_tx_stopped(port)	\
+((port)->info->tty->stopped || (port)->info->tty->hw_stopped)
+
+#define SNX_UPIO_PORT				(0)
+#define SNX_UPIO_MEM				(1)
+
+#define SNX_UPF_SAK						(1 << 2)
+#define SNX_UPF_SPD_MASK			(0x1030)
+#define SNX_UPF_SPD_HI				(0x0010)
+#define SNX_UPF_SPD_VHI				(0x0020)
+#define SNX_UPF_SPD_CUST			(0x0030)
+#define SNX_UPF_SPD_SHI				(0x1000)
+#define SNX_UPF_SPD_WARP			(0x1010)
+#define SNX_UPF_SKIP_TEST			(1 << 6)
+#define SNX_UPF_HARDPPS_CD		(1 << 11)
+#define SNX_UPF_LOW_LATENCY		(1 << 13)
+#define SNX_UPF_BUGGY_UART		(1 << 14)
+#define SNX_UPF_MAGIC_MULTIPLIER	(1 << 16)
+
+#define SNX_UPF_CHANGE_MASK		(0x17fff)
+#define SNX_UPF_USR_MASK	(SNX_UPF_SPD_MASK | SNX_UPF_LOW_LATENCY)
+
+#define SNX_UIF_CHECK_CD			(1 << 25)
+#define SNX_UIF_CTS_FLOW			(1 << 26)
+
+#define SNX_UIF_NORMAL_ACTIVE		(1 << 29)
+#define SNX_UIF_INITIALIZED			(1 << 31)
+
+#define SNX_ENABLE_MS(port, cflag)	\
+((port)->flags & SNX_UPF_HARDPPS_CD ||	\
+(cflag) & CRTSCTS || !((cflag) & CLOCAL))
+
+#define SNX_SER_DEVNUM(x)   ((x)->index)
+
+struct snx_ser_info;
+struct snx_ser_port;
+
+struct snx_ser_icount {
+	__u32	cts;
+	__u32	dsr;
+	__u32	rng;
+	__u32	dcd;
+	__u32	rx;
+	__u32	tx;
+	__u32	frame;
+	__u32	overrun;
+	__u32	parity;
+	__u32	brk;
+	__u32	buf_overrun;
+};
+
+struct snx_ser_info {
+	struct tty_struct		*tty;
+	struct circ_buf			xmit;
+	unsigned int			flags;
+	unsigned char			*tmpbuf;
+	struct semaphore		tmpbuf_sem;
+	int						blocked_open;
+	struct tasklet_struct	tlet;
+
+	wait_queue_head_t		open_wait;
+	wait_queue_head_t		delta_msr_wait;
+};
+
+struct snx_ser_driver {
+	struct module	*owner;
+	const char	*driver_name;
+	const char	*dev_name;
+	int		major;
+	int		minor;
+	int		nr;
+	struct snx_ser_state	*state;
+};
+
+
+struct snx_ser_port {
+	spinlock_t				lock;
+	unsigned int			iobase;
+	unsigned int			irq;
+	unsigned int			uartclk;
+	unsigned char			fifosize;
+	unsigned char			x_char;
+	unsigned char			iotype;
+
+	unsigned int			read_status_mask;
+	unsigned int			ignore_status_mask;
+	struct snx_ser_info		*info;
+	struct snx_ser_icount	icount;
+
+	unsigned int			flags;
+	unsigned int			mctrl;
+	unsigned int			timeout;
+	unsigned int			snx_type;
+	unsigned int			type;
+	unsigned int			custom_divisor;
+	unsigned int			line;
+
+	int						board_enum;
+	unsigned int			bus_number;
+	unsigned int			dev_number;
+	pci_board				pb_info;
+	unsigned int			vector;
+	unsigned int			vector_mask;
+	unsigned char			chip_flag;
+	unsigned int			port_flag;
+	unsigned int			baud_base;
+	int						rx_trigger;
+	unsigned char			ldisc_stop_rx;
+
+	unsigned int			setserial_flag;
+
+	int AHDC_State;
+	int RS422_State;
+
+	unsigned char			suspended;
+	struct device			*dev;
+};
+
+struct snx_ser_state {
+	struct tty_port			tport;
+
+	unsigned int			close_delay;
+	unsigned int			closing_wait;
+	int								count;
+	struct snx_ser_info	    *info;
+	struct snx_ser_port		*port;
+	struct semaphore		sem;
+};
+
+static inline int snx_ser_handle_break(struct snx_ser_port *port)
+{
+	struct snx_ser_info *info = port->info;
+
+	if (info->flags & SNX_UPF_SAK)
+		do_SAK(info->tty);
+
+	return 0;
+}
+
+static inline void snx_ser_handle_dcd_change(struct snx_ser_port *port,
+unsigned int status)
+{
+	struct snx_ser_info *info = port->info;
+
+	port->icount.dcd++;
+
+	if (info->flags & SNX_UIF_CHECK_CD) {
+		if (status)
+			wake_up_interruptible(&info->open_wait);
+		else if (info->tty)
+			tty_hangup(info->tty);
+	}
+}
+
+struct sunix_ser_port {
+	struct snx_ser_port port;
+	struct timer_list	timer;
+	struct list_head	list;
+
+	unsigned int		capabilities;
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		mcr_mask;
+	unsigned char		mcr_force;
+	unsigned char		lsr_break_flag;
+};
+
+#define SNX_CONFIG_PARPORT_1284
+#define SNX_CONFIG_PARPORT_PC_FIFO
+
+#ifdef SNX_CONFIG_PARPORT_1284
+#undef SNX_CONFIG_PARPORT_1284
+#endif
+
+#ifdef SNX_CONFIG_PARPORT_PC_FIFO
+#undef SNX_CONFIG_PARPORT_PC_FIFO
+#endif
+
+#define SNX_PAR_PORT_MAX_UART	5
+#define SNX_PAR_PORT_UNKNOWN	0
+#define SNX_PAR_PORT_SUN1888	1
+#define SNX_PAR_PORT_SUN1689	2
+#define SNX_PAR_PORT_SUNMATX	3
+#define SNX_PAR_PORT_SUN1999    4
+
+#define SNX_ECR(p)	((p)->base_hi + 0x2)
+#define SNX_CFGB(p)	((p)->base_hi + 0x1)
+#define SNX_CFGA(p)	((p)->base_hi + 0x0)
+#define SNX_FIFO(p)	((p)->base_hi + 0x0)
+#define SNX_EPPDATA(p)	((p)->base    + 0x4)
+#define SNX_EPPADDR(p)	((p)->base    + 0x3)
+#define SNX_DCR(p)	((p)->base    + 0x2)
+#define SNX_DSR(p)	((p)->base    + 0x1)
+#define SNX_DATA(p)	((p)->base    + 0x0)
+
+#define SNX_ROUND_UP(x, y) (((x)+(y)-1)/(y))
+
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+#ifndef PARPORT_W91284PIC
+#define PARPORT_W91284PIC (1 << 1)
+#endif
+
+#define SNX_PARPORT_INACTIVITY_O_NONBLOCK 1
+
+struct snx_parport;
+struct snx_pardevice;
+
+
+struct snx_parport_driver {
+	const char	*name;
+	void	(*attach)(struct snx_parport *port);
+	void	(*detach)(struct snx_parport *port);
+	struct list_head	list;
+};
+
+struct snx_pc_parport_state {
+	unsigned int ctr;
+	unsigned int ecr;
+};
+
+struct snx_parport_state {
+	union {
+		struct snx_pc_parport_state pc;
+		void *misc;
+	} u;
+};
+
+struct snx_parport_ops {
+	void	(*write_data)(struct snx_parport *p, unsigned char d);
+	unsigned char	(*read_data)(struct snx_parport *p);
+	void	(*write_control)(struct snx_parport *p, unsigned char ctl);
+	unsigned char	(*read_control)(struct snx_parport *p);
+	unsigned char	(*frob_control)(struct snx_parport *p,
+					unsigned char mask, unsigned char val);
+	unsigned char	(*read_status)(struct snx_parport *p);
+	void		(*enable_irq)(struct snx_parport *p);
+	void		(*disable_irq)(struct snx_parport *p);
+	void		(*data_forward)(struct snx_parport *p);
+	void		(*data_reverse)(struct snx_parport *p);
+	void		(*init_state)(struct snx_pardevice *d,
+						struct snx_parport_state *s);
+	void	(*save_state)(struct snx_parport *p,
+						struct snx_parport_state *s);
+	void	(*restore_state)(struct snx_parport *p,
+						struct snx_parport_state *s);
+
+	size_t	(*epp_write_data)(struct snx_parport *port,
+					const void *buf, size_t len, int flags);
+	size_t	(*epp_read_data)(struct snx_parport *port,
+					void *buf, size_t len, int flags);
+	size_t	(*epp_write_addr)(struct snx_parport *port,
+					const void *buf, size_t len, int flags);
+	size_t	(*epp_read_addr)(struct snx_parport *port,
+					void *buf, size_t len, int flags);
+	size_t	(*ecp_write_data)(struct snx_parport *port,
+					const void *buf, size_t len, int flags);
+	size_t	(*ecp_read_data)(struct snx_parport *port,
+					void *buf, size_t len, int flags);
+	size_t	(*ecp_write_addr)(struct snx_parport *port,
+					const void *buf, size_t len, int flags);
+
+	size_t	(*compat_write_data)(struct snx_parport *port,
+					const void *buf, size_t len, int flags);
+	size_t	(*nibble_read_data)(struct snx_parport *port,
+					void *buf, size_t len, int flags);
+	size_t	(*byte_read_data)(struct snx_parport *port,
+					void *buf, size_t len, int flags);
+	struct module	*owner;
+};
+
+
+struct snx_parport_device_info {
+	parport_device_class	class;
+	const char	*class_name;
+	const char	*mfr;
+	const char	*model;
+	const char	*cmdset;
+	const char	*description;
+};
+
+
+struct snx_pardevice {
+	const char					*name;
+	struct snx_parport			*port;
+
+	int							daisy;
+	int				(*preempt)(void *);
+	void			(*wakeup)(void *);
+	void			*private;
+	void			(*irq_func)(int, void *, struct pt_regs *);
+	unsigned int				flags;
+	struct snx_pardevice		*next;
+	struct snx_pardevice		*prev;
+	struct snx_parport_state	*state;
+
+	wait_queue_head_t			wait_q;
+	unsigned long int			time;
+	unsigned long int			timeslice;
+
+	volatile long int			timeout;
+
+	unsigned long				waiting;
+	struct snx_pardevice		*waitprev;
+	struct snx_pardevice		*waitnext;
+
+	void						*sysctl_table;
+};
+
+
+struct snx_parport {
+	unsigned long	base;
+	unsigned long	base_hi;
+	unsigned int	size;
+	const char		*name;
+	unsigned int	modes;
+	int		irq;
+	int		dma;
+	int		muxport;
+	int		portnum;
+
+	struct snx_parport		*physport;
+	struct snx_pardevice	*devices;
+	struct snx_pardevice	*cad;
+
+	int		daisy;
+	int		muxsel;
+
+	struct snx_pardevice	*waithead;
+	struct snx_pardevice	*waittail;
+
+	struct list_head	list;
+	struct timer_list	timer;
+	unsigned int		flags;
+	void				*sysctl_table;
+	struct snx_parport_device_info	probe_info[5];
+	struct ieee1284_info		ieee1284;
+	struct snx_parport_ops		*ops;
+	void	*private_data;
+	int		number;
+	spinlock_t		pardevice_lock;
+	spinlock_t		waitlist_lock;
+	rwlock_t		cad_lock;
+	int			spintime;
+	atomic_t	ref_count;
+	struct list_head	full_list;
+	struct snx_parport	*slaves[3];
+	struct snx_parport	*next;
+	dev_t	dev;
+	struct semaphore	sem;
+};
+
+
+struct sunix_par_port {
+	struct snx_parport	*port;
+
+	unsigned char		ctr;
+	unsigned char		ctr_writable;
+	int					ecr;
+	int					fifo_depth;
+	int					pword;
+	int					read_intr_threshold;
+	int					write_intr_threshold;
+
+	char				*dma_buf;
+	dma_addr_t			dma_handle;
+	struct list_head	list;
+
+	unsigned long		base;
+	unsigned long		base_hi;
+	int					irq;
+	int					portnum;
+	unsigned int		snx_type;
+
+	int					board_enum;
+	unsigned int		bus_number;
+	unsigned int		dev_number;
+
+	pci_board			pb_info;
+
+	unsigned char		chip_flag;
+	unsigned int		port_flag;
+};
+
+// snx_devtable.c
+//extern pci_board snx_pci_board_conf[];
+
+// snx_ieee1284_ops.c
+extern size_t	sunix_parport_ieee1284_write_compat(
+struct snx_parport *port, const void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_read_nibble(
+struct snx_parport *port, void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_read_byte(
+struct snx_parport *port, void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_ecp_write_data(
+struct snx_parport *port, const void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_ecp_read_data(
+struct snx_parport *port, void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_ecp_write_addr(
+struct snx_parport *port, const void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_epp_write_data(
+struct snx_parport *port, const void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_epp_read_data(
+struct snx_parport *port, void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_epp_write_addr(
+struct snx_parport *port, const void *buffer, size_t len, int flags);
+extern size_t	sunix_parport_ieee1284_epp_read_addr(
+struct snx_parport *port, void *buffer, size_t len, int flags);
+
+// snx_ieee1284.c
+extern int	sunix_parport_wait_event(struct snx_parport *port,
+				signed long timeout);
+extern int		sunix_parport_poll_peripheral(struct snx_parport *port,
+unsigned char mask, unsigned char result, int usec);
+
+extern int	sunix_parport_wait_peripheral(struct snx_parport *port,
+	unsigned char mask, unsigned char result);
+
+extern int		sunix_parport_negotiate(struct snx_parport *port,
+					int mode);
+extern ssize_t	sunix_parport_write(struct snx_parport *port,
+					const void *buffer, size_t len);
+extern ssize_t	sunix_parport_read(struct snx_parport *port,
+					void *buffer, size_t len);
+extern long	sunix_parport_set_timeout(struct snx_pardevice *dev,
+					long inactivity);
+
+// snx_share.c
+extern int		sunix_parport_default_spintime;
+extern int	sunix_parport_register_driver(struct snx_parport_driver *drv);
+extern void	sunix_parport_unregister_driver(struct snx_parport_driver *drv);
+extern void	sunix_parport_put_port(struct snx_parport *port);
+extern void	sunix_parport_announce_port(struct snx_parport *port);
+extern void	sunix_parport_remove_port(struct snx_parport *port);
+extern void	sunix_parport_unregister_device(struct snx_pardevice *dev);
+extern int	sunix_parport_claim(struct snx_pardevice *dev);
+extern int	sunix_parport_claim_or_block(struct snx_pardevice *dev);
+extern void	sunix_parport_release(struct snx_pardevice *dev);
+extern struct snx_parport *sunix_parport_get_port(struct snx_parport *port);
+
+extern struct snx_parport *sunix_parport_register_port(
+struct sunix_par_port *priv,  struct snx_parport_ops *ops);
+
+extern struct snx_parport *sunix_parport_find_number(int number);
+extern struct snx_parport *sunix_parport_find_base(unsigned long base);
+extern struct snx_pardevice *sunix_parport_register_device(
+	struct snx_parport	*port,
+	const char			*name,
+	int		(*pf)(void *),
+	void	(*kf)(void *),
+	void	(*irq_func)(int, void *, struct pt_regs *),
+	int		flags,
+	void	*handle
+	);
+
+// snx_parallel.c
+extern int		sunix_par_parport_init(void);
+extern void		sunix_par_parport_exit(void);
+
+// snx_serial.c
+extern int		sunix_ser_register_ports(struct snx_ser_driver *drv);
+extern void		sunix_ser_unregister_ports(struct snx_ser_driver *drv);
+extern int		sunix_ser_register_driver(struct snx_ser_driver *drv);
+extern void		sunix_ser_unregister_driver(struct snx_ser_driver *drv);
+extern int		sunix_ser_interrupt(struct sunix_board *sb,
+struct sunix_ser_port *first_sp);
+extern void		snx_ser_change_speed(struct snx_ser_state *state,
+struct SNXTERMIOS *old_termios);
+
+// snx_ppdev.c
+extern int	sunix_par_ppdev_init(void);
+extern void	sunix_par_ppdev_exit(void);
+
+// snx_lp.c
+extern int	sunix_par_lp_init(void);
+extern void	sunix_par_lp_exit(void);
+
+// snx_main.c
+extern struct sunix_board	sunix_board_table[SNX_BOARDS_MAX];
+extern struct sunix_ser_port	sunix_ser_table[SNX_SER_TOTAL_MAX + 1];
+extern struct sunix_par_port	sunix_par_table[SNX_PAR_TOTAL_MAX];
+
+extern int      snx_ser_startup(struct snx_ser_state *state, int init_hw);
+extern void     snx_ser_update_termios(struct snx_ser_state *state);
+
+#define sunix_parport_write_data(p, x)	sunix_parport_pc_write_data(p, x)
+#define sunix_parport_read_data(p)	sunix_parport_pc_read_data(p)
+#define sunix_parport_write_control(p, x)	\
+sunix_parport_pc_write_control(p, x)
+#define sunix_parport_read_control(p)	sunix_parport_pc_read_control(p)
+#define sunix_parport_frob_control(p, m, v)	\
+sunix_parport_pc_frob_control(p, m, v)
+#define sunix_parport_read_status(p)	\
+sunix_parport_pc_read_status(p)
+#define sunix_parport_enable_irq(p)	sunix_parport_pc_enable_irq(p)
+#define sunix_parport_disable_irq(p)	sunix_parport_pc_disable_irq(p)
+#define sunix_parport_data_forward(p)	sunix_parport_pc_data_forward(p)
+#define sunix_parport_data_reverse(p)	sunix_parport_pc_data_reverse(p)
+
+static inline void sunix_parport_pc_write_data(struct snx_parport *p,
+unsigned char d)
+{
+	outb(d, SNX_DATA(p));
+}
+
+static inline unsigned char sunix_parport_pc_read_data(struct snx_parport *p)
+{
+	unsigned char val = inb(SNX_DATA(p));
+
+	return val;
+}
+
+static inline unsigned char __sunix_parport_pc_frob_control(
+struct snx_parport *p, unsigned char mask, unsigned char val)
+{
+	struct sunix_par_port *priv = p->physport->private_data;
+	unsigned char ctr = priv->ctr;
+
+	ctr = (ctr & ~mask) ^ val;
+	ctr &= priv->ctr_writable;
+	outb(ctr, SNX_DCR(p));
+	priv->ctr = ctr;
+	return ctr;
+}
+
+static inline void sunix_parport_pc_data_reverse(struct snx_parport *p)
+{
+	__sunix_parport_pc_frob_control(p, 0x20, 0x20);
+}
+
+
+static inline void sunix_parport_pc_data_forward(struct snx_parport *p)
+{
+	__sunix_parport_pc_frob_control(p, 0x20, 0x00);
+}
+
+static inline void sunix_parport_pc_write_control(struct snx_parport *p,
+unsigned char d)
+{
+	const unsigned char wm = (PARPORT_CONTROL_STROBE |
+							PARPORT_CONTROL_AUTOFD |
+							PARPORT_CONTROL_INIT |
+							PARPORT_CONTROL_SELECT);
+
+	if (d & 0x20)
+		sunix_parport_pc_data_reverse(p);
+
+
+	__sunix_parport_pc_frob_control(p, wm, d & wm);
+}
+
+
+
+static inline unsigned char sunix_parport_pc_frob_control(
+struct snx_parport *p, unsigned char mask, unsigned char val)
+{
+	const unsigned char wm = (PARPORT_CONTROL_STROBE |
+							PARPORT_CONTROL_AUTOFD |
+							PARPORT_CONTROL_INIT |
+							PARPORT_CONTROL_SELECT);
+
+	if (mask & 0x20) {
+		if (val & 0x20)
+			sunix_parport_pc_data_reverse(p);
+		else
+			sunix_parport_pc_data_forward(p);
+
+	}
+
+	mask &= wm;
+	val &= wm;
+
+	return __sunix_parport_pc_frob_control(p, mask, val);
+}
+
+
+static inline unsigned char sunix_parport_pc_read_status(struct snx_parport *p)
+{
+	return inb(SNX_DSR(p));
+}
+
+
+
+
+static inline void sunix_parport_pc_enable_irq(struct snx_parport *p)
+{
+	__sunix_parport_pc_frob_control(p, 0x10, 0x10);
+}
+
+
+static inline int sunix_parport_yield_blocking(struct snx_pardevice *dev)
+{
+	unsigned long int timeslip = (jiffies - dev->time);
+
+	if ((dev->port->waithead == NULL) || (timeslip < dev->timeslice))
+		return 0;
+
+
+	sunix_parport_release(dev);
+	return sunix_parport_claim_or_block(dev);
+}
+
-- 
2.17.1

