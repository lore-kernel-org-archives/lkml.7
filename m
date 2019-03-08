Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F31C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD1920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz5rJNZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCHMeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:34:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35204 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:34:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so14086584pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xHJWOzbSoV1kKTO+tLiHBJ0s4c0z0jNn/UsuTOG361A=;
        b=Uz5rJNZCb04hRdFMWX8CbsOK5NqsT9EGyH1Y+bfCmtw6oZep9+9ZLKUAtCEg1zN6DS
         NA+YVdNK+2F3HW/8QPYgqNsPJeOjBToym27evcXBXpuSMG53s3ajRbkVpqLmXmmvWiFh
         veaZm/XKPDV4emsxzeV1mpFIDvs/tSxeNSRTR9d2RPaoshggRwpdDCi4c19oz5TU+oym
         qII7Scs20GWtQb9aTUQ0cHmEbHa7FOpbZYjWj6MZduppf3RatPX7tvqkLmZaLHLJKfCN
         +3GKbJyn7TcDntGAh7PKoyWLp+hUVUIMM4BRhW9cKpNVY0cgZ/fA8Hr6yg4anXbMZa8Q
         I4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHJWOzbSoV1kKTO+tLiHBJ0s4c0z0jNn/UsuTOG361A=;
        b=YMCY6Mt+oNnIBrobt+t1u2p2cqKx1J670Gp0mCxTwuOG9c0r91NiGvVq+thAqjRl1b
         Vhl9S75/04BY+ZhuIwxm4O46msa0UcJ82iV7tbi8SWEnkzU3375KwGWQxvanZPx4wxsG
         oehrXEyd2ZBTp/xuSCM47Vx/bXTu4f1lRHD+NQBHfyhKvZ6xLmAbUvLl8jnLpNyQMSwf
         t25WmC6hus6EIrGxIjRErXnCrP7kesN6ONTikjNPeqq5e5tIU+K48BrZad7wse2QsXlp
         OSYHf2krJ+U39vrhD97Jgcnw3vMZT5N0o7tMW3pXi3Hia4X3ny56IuK4vwkx2A2LiabZ
         F+Bg==
X-Gm-Message-State: APjAAAVMDJjfZXwA2eAayNpX5iV3b9lwxI8fgQHTFHLFn24eHPlKGS2x
        16Co2wSoHZ6eGNiIrXCjmTs=
X-Google-Smtp-Source: APXvYqyeG/yJdrX7ygvKZO3vwHVlTEYyQXaN52kdYkOc4uDJNGitaiFIPE6odUlxDs335Vco5ml/ig==
X-Received: by 2002:a62:f517:: with SMTP id n23mr18355453pfh.209.1552048484958;
        Fri, 08 Mar 2019 04:34:44 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-243-101.dynamic-ip.hinet.net. [114.36.243.101])
        by smtp.gmail.com with ESMTPSA id l5sm13457236pfi.97.2019.03.08.04.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 04:34:44 -0800 (PST)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 2/4] Add SUNIX Multi-I/O card device driver
Date:   Fri,  8 Mar 2019 20:34:32 +0800
Message-Id: <20190308123432.20520-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for SUNIX Multi-I/O card.
Based on driver/char/serial.c by Linus Torvalds, Theodore Ts'o.

SUNIX serial card designed with SUNIX UART controller and
compatible with 16C950 UART specification.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 char/snx/snx_main.c   | 1219 ++++++++++++
 char/snx/snx_serial.c | 4263 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 5482 insertions(+)
 create mode 100644 char/snx/snx_main.c
 create mode 100644 char/snx/snx_serial.c

diff --git a/char/snx/snx_main.c b/char/snx/snx_main.c
new file mode 100644
index 00000000..dd4fba1b
--- /dev/null
+++ b/char/snx/snx_main.c
@@ -0,0 +1,1219 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+#include "driver_extd.h"
+
+MODULE_AUTHOR(SNX_DRIVER_AUTHOR);
+MODULE_DESCRIPTION(SNX_DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+char snx_ser_ic_table[SNX_SER_PORT_MAX_UART][10] = {
+	{"UNKNOWN"},
+	{"SUN1889"},
+	{"SUN1699"},
+	{"SUNMATX"},
+	{"SUN1999"}
+};
+
+char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10] = {
+	{"UNKNOWN"},
+	{"SUN1888"},
+	{"SUN1689"},
+	{"SUNMATX"},
+	{"SUN1999"}
+};
+
+char snx_port_remap[2][10] = {
+	{"NON-REMAP"},
+	{"REMAP"}
+};
+
+enum{
+// golden-serial
+	GOLDEN_BOARD_TEST = 0,
+
+// matrix-serial
+	MATRIX_BOARD_P1002,
+	MATRIX_BOARD_P1004,
+	MATRIX_BOARD_P1008,
+	MATRIX_BOARD_P1016,
+	MATRIX_BOARD_P2002,
+	MATRIX_BOARD_P2004,
+	MATRIX_BOARD_P2008,
+	MATRIX_BOARD_P3002,
+	MATRIX_BOARD_P3004,
+	MATRIX_BOARD_P3008,
+
+// sun1999-serial RS232
+	SUN1999_BOARD_5027A,
+	SUN1999_BOARD_5037A,
+	SUN1999_BOARD_5056A,
+	SUN1999_BOARD_5066A,
+	SUN1999_BOARD_5016A,
+
+	//sun1999-multi I/O
+	SUN1999_BOARD_5069A,
+	SUN1999_BOARD_5079A,
+	SUN1999_BOARD_5099A,
+
+	//sun1999-parallel
+
+	SUN1999_BOARD_5008A,
+
+	//sun1999-serial RS422/485
+	SUN1999_BOARD_P2102,
+	SUN1999_BOARD_P2104,
+	SUN1999_BOARD_P2108,
+	SUN1999_BOARD_P2116,
+
+	//sun1999 3_in_1
+	SUN1999_BOARD_P3104,
+	SUN1999_BOARD_P3108,
+
+	//cash drawer card
+	SUN1999_BOARD_CASH_2S,
+	SUN1999_BOARD_CASH_4S,
+
+	//DIO
+	SUN1999_BOARD_DIO0802,
+	SUN1999_BOARD_DIO1604,
+	SUN1999_BOARD_DIO3204,
+
+};
+
+static  struct pci_device_id	sunix_pci_board_id[] = {
+// golden-serial
+	{VENID_GOLDEN,	DEVID_G_SERIAL,	SUBVENID_GOLDEN,
+		SUBDEVID_TEST,	0,	0,	GOLDEN_BOARD_TEST},
+
+// matrix-serial
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P1002,	0,	0,	MATRIX_BOARD_P1002},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P1004,	0,	0,	MATRIX_BOARD_P1004},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P1008,	0,	0,	MATRIX_BOARD_P1008},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P1016,	0,	0,	MATRIX_BOARD_P1016},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P2002,	0,	0,	MATRIX_BOARD_P2002},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P2004,	0,	0,	MATRIX_BOARD_P2004},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P2008,	0,	0,	MATRIX_BOARD_P2008},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P3002,	0,	0,	MATRIX_BOARD_P3002},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P3004,	0,	0,	MATRIX_BOARD_P3004},
+	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
+		SUBDEVID_P3008,	0,	0,	MATRIX_BOARD_P3008},
+
+	// sun1999-serial RS232
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5027A,	0,	0,	SUN1999_BOARD_5027A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5037A,	0,	0,	SUN1999_BOARD_5037A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5056A,	0,	0,	SUN1999_BOARD_5056A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5066A,	0,	0,	SUN1999_BOARD_5066A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5016A,	0,	0,	SUN1999_BOARD_5016A},
+
+	// sun1999-multi I/O
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5069A,	0,	0,	SUN1999_BOARD_5069A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5079A,	0,	0,	SUN1999_BOARD_5079A},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_5099A,	0,	0,	SUN1999_BOARD_5099A},
+
+	// sun1999-parallel
+	{VENID_SUN1999,	DEVID_S_PARALL,	SUBVENID_SUN1999,
+		SUBDEVID_5008A,	0,	0,	SUN1999_BOARD_5008A},
+
+	// sun1999-serial RS422/485
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P2102,	0,	0,	SUN1999_BOARD_P2102},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P2104,	0,	0,	SUN1999_BOARD_P2104},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P2108,	0,	0,	SUN1999_BOARD_P2108},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P2116,	0,	0,	SUN1999_BOARD_P2116},
+
+	// sun1999 3_in_1
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P3104,	0,	0,	SUN1999_BOARD_P3104},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_P3108,	0,	0,	SUN1999_BOARD_P3108},
+
+	//cash drawer card  2S
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_CASH_2S, 0,	0,	SUN1999_BOARD_CASH_2S},
+
+	//cash drawer card  4S
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_CASH_4S, 0,	0,	SUN1999_BOARD_CASH_4S},
+
+	//DIO
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_DIO0802, 0,	0,	SUN1999_BOARD_DIO0802},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_DIO1604, 0,	0,	SUN1999_BOARD_DIO1604},
+	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
+		SUBDEVID_DIO3204, 0,	0,	SUN1999_BOARD_DIO3204},
+
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, sunix_pci_board_id);
+
+struct sunix_board			sunix_board_table[SNX_BOARDS_MAX];
+struct sunix_ser_port	    sunix_ser_table[SNX_SER_TOTAL_MAX + 1];
+struct sunix_par_port	    sunix_par_table[SNX_PAR_TOTAL_MAX];
+
+static int snx_ser_port_total_cnt;
+static int snx_par_port_total_cnt;
+
+int snx_board_count;
+
+static struct snx_ser_driver	sunix_ser_reg = {
+	.dev_name = "ttySNX",
+	.major = 0,
+	.minor = 0,
+	.nr = (SNX_SER_TOTAL_MAX + 1),
+};
+
+static irqreturn_t sunix_interrupt(int irq, void *dev_id)
+{
+	struct sunix_ser_port *sp = NULL;
+	struct sunix_par_port *pp = NULL;
+	struct sunix_board *sb = NULL;
+	int i;
+	int status = 0;
+
+	int handled = IRQ_NONE;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+
+		if (dev_id == &(sunix_board_table[i])) {
+			sb = dev_id;
+			break;
+		}
+	}
+
+	if (i == SNX_BOARDS_MAX)
+		status = 1;
+
+	if (!sb)
+		status = 1;
+
+	if (sb->board_enum <= 0)
+		status = 1;
+
+	if (status != 0)
+		return handled;
+
+	if ((sb->ser_port > 0) && (sb->ser_isr != NULL)) {
+		sp = &sunix_ser_table[sb->ser_port_index];
+
+		if (!sp)
+			status = 1;
+
+		status = sb->ser_isr(sb, sp);
+	}
+
+	if ((sb->par_port > 0) && (sb->par_isr != NULL)) {
+		pp = &sunix_par_table[sb->par_port_index];
+
+		if (!pp)
+			status = 1;
+
+		status = sb->par_isr(sb, pp);
+	}
+
+	if (status != 0)
+		return handled;
+
+	handled = IRQ_HANDLED;
+	return handled;
+}
+
+static int snx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	return 0;
+}
+
+static int snx_suspend_one(struct pci_dev *pdev, pm_message_t state)
+{
+	return  0;
+}
+
+static int snx_set_port_termios(struct snx_ser_state *state)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct SNXTERMIOS *termios;
+
+	int retval = 0;
+
+	termios = &tty->termios;
+
+	retval = snx_ser_startup(state, 0);
+
+	if (retval == 0)
+		snx_ser_update_termios(state);
+
+	return 0;
+}
+
+static int snx_resume_port_termios(struct snx_ser_info *info)
+{
+	struct snx_ser_state *state = NULL;
+	struct tty_struct *tty = info->tty;
+
+	state = tty->driver_data;
+	snx_set_port_termios(state);
+
+	return 0;
+}
+
+
+static int snx_resume_port(struct sunix_ser_port *sp)
+{
+	struct snx_ser_port *port = &sp->port;
+	struct snx_ser_info *info = port->info;
+
+	if (info)
+		snx_resume_port_termios(info);
+
+	return 0;
+}
+
+static int snx_resume_one(struct pci_dev *pdev)
+{
+	struct sunix_board *sb = pci_get_drvdata(pdev);
+	struct sunix_ser_port *sp = NULL;
+	int j;
+
+	if (sb == NULL)
+		return 0;
+
+	for (j = 0; j < sb->ser_port; j++) {
+		sp = &sunix_ser_table[j];
+
+		if (sp == NULL)
+			return 0;
+
+		if (sp->port.suspended == 1)
+			snx_resume_port(sp);
+	}
+
+	return 0;
+}
+
+
+static int sunix_pci_board_probe(void)
+{
+	struct sunix_board *sb;
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pdev_array[4] = {NULL, NULL, NULL, NULL};
+
+	int sunix_pci_board_id_cnt;
+	int tablecnt;
+	int boardcnt;
+	int i;
+	unsigned short int sub_device_id;
+	unsigned short int device_part_number;
+	unsigned int bar3_base_add;
+
+	int status;
+	unsigned int bar3_Byte5;
+	unsigned int bar3_Byte6;
+	unsigned int bar3_Byte7;
+	unsigned int oem_id;
+	unsigned char uart_type;
+	unsigned char gpio_type;
+	unsigned char gpio_card_type;
+	int gpio_ch_cnt;
+
+	// clear and init some variable
+	memset(sunix_board_table, 0, SNX_BOARDS_MAX *
+	sizeof(struct sunix_board));
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sunix_board_table[i].board_enum = -1;
+		sunix_board_table[i].board_number = -1;
+	}
+
+	sunix_pci_board_id_cnt =
+	(sizeof(sunix_pci_board_id) / sizeof(sunix_pci_board_id[0])) - 1;
+
+	// search matrix serial board
+	pdev = NULL;
+	tablecnt = 0;
+	boardcnt = 0;
+	sub_device_id = 0;
+	status = 0;
+
+	while (tablecnt < sunix_pci_board_id_cnt) {
+
+		pdev = pci_get_device(VENID_MATRIX, DEVID_M_SERIAL, pdev);
+
+		if (pdev == NULL) {
+			tablecnt++;
+			continue;
+		}
+
+		if ((tablecnt > 0) && ((pdev == pdev_array[0]) ||
+		(pdev == pdev_array[1]) ||
+		(pdev == pdev_array[2]) ||
+		(pdev == pdev_array[3]))) {
+			continue;
+		}
+
+		pci_read_config_word(pdev, 0x2e, &sub_device_id);
+
+		if (sub_device_id == 0) {
+			status = -EIO;
+			return status;
+		}
+
+		if (sub_device_id != sunix_pci_board_id[tablecnt].subdevice)
+			continue;
+		if (pdev == NULL) {
+			pr_err("SNX Error: PCI device object is NULL !\n");
+			status = -EIO;
+			return status;
+
+		} else {
+
+			status = pci_enable_device(pdev);
+
+			if (status != 0) {
+				pr_err("SNX Error: SUNIX Board Enable Fail !\n\n");
+				status = -ENXIO;
+				return status;
+			}
+		}
+
+		boardcnt++;
+		if (boardcnt > SNX_BOARDS_MAX) {
+			pr_err("SNX Error: Support Four Boards In Maximum !\n");
+			status = -ENOSPC;
+			return status;
+		}
+
+		sb = &sunix_board_table[boardcnt-1];
+		pdev_array[boardcnt-1] = pdev;
+		sb->pdev = pdev;
+		sb->bus_number = pdev->bus->number;
+		sb->dev_number = PCI_SLOT(pdev->devfn);
+		sb->board_enum = (int)sunix_pci_board_id[tablecnt].driver_data;
+		sb->pb_info = snx_pci_board_conf[sb->board_enum];
+		sb->board_flag = sb->pb_info.board_flag;
+		sb->board_number = boardcnt - 1;
+	}
+
+	// search sun1999 muti I/O board
+	pdev = NULL;
+	tablecnt = 0;
+	sub_device_id = 0;
+	status = 0;
+	device_part_number = 0;
+	bar3_base_add = 0;
+	bar3_Byte5 = 0;
+	bar3_Byte6 = 0;
+	bar3_Byte7 = 0;
+	oem_id = 0;
+	uart_type = 0;
+	gpio_type = 0;
+	gpio_card_type = 0;
+	gpio_ch_cnt = 0;
+
+	while (tablecnt < sunix_pci_board_id_cnt) {
+
+		pdev = pci_get_device(VENID_SUN1999, DEVID_S_SERIAL, pdev);
+
+		if (pdev == NULL) {
+			tablecnt++;
+			continue;
+		}
+
+		if ((tablecnt > 0) &&
+		((pdev == pdev_array[0]) ||
+		(pdev == pdev_array[1]) ||
+		(pdev == pdev_array[2]) ||
+		(pdev == pdev_array[3]))) {
+			continue;
+		}
+
+		pci_read_config_word(pdev, 0x2e, &sub_device_id);
+
+		if (sub_device_id == 0) {
+			status = -EIO;
+			return status;
+		}
+
+		if (sub_device_id != sunix_pci_board_id[tablecnt].subdevice)
+			continue;
+
+		if (pdev == NULL) {
+			pr_err("SNX Error: PCI device object is an NULL pointer !\n\n");
+			status = -EIO;
+			return status;
+
+		} else {
+
+			status = pci_enable_device(pdev);
+
+			if (status != 0) {
+				pr_err("SNX Error: SUNIX Board Enable Fail !\n\n");
+				status = -ENXIO;
+				return status;
+			}
+		}
+
+		bar3_base_add = pci_resource_start(pdev, 3);
+		device_part_number = inb(bar3_base_add + 5);
+		bar3_Byte5 = device_part_number;
+		bar3_Byte6 = inb(bar3_base_add + 0x06);
+		bar3_Byte7 = inb(bar3_base_add + 0x07);
+		gpio_card_type = ((bar3_Byte7 & 0x18)>>3);
+		oem_id = (bar3_Byte5 | (bar3_Byte6 << 8) | (bar3_Byte7 << 16));
+		uart_type = ((bar3_Byte5 & 0xc0)>>6);
+		gpio_ch_cnt = ((bar3_Byte7 & 0x60)>>5);
+		gpio_type = ((bar3_Byte7 & 0x80)>>7);
+
+		if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x01))
+			gpio_ch_cnt = 6;
+		else if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x02))
+			gpio_ch_cnt = 8;
+		else if (gpio_ch_cnt == 0x01)
+			gpio_ch_cnt = 16;
+		else if (gpio_ch_cnt == 0x02)
+			gpio_ch_cnt = 32;
+
+	if (device_part_number != snx_pci_board_conf[tablecnt].part_number)
+		continue;
+	else if (gpio_card_type != snx_pci_board_conf[tablecnt].card_type)
+		continue;
+	else if (gpio_ch_cnt != snx_pci_board_conf[tablecnt].gpio_ch_cnt)
+		continue;
+	else
+		pr_err("\n");
+
+		boardcnt++;
+		if (boardcnt > SNX_BOARDS_MAX) {
+			pr_err("SNX Error: Support Four Boards In Maximum !\n");
+			status = -ENOSPC;
+			return status;
+		}
+
+		sb = &sunix_board_table[boardcnt-1];
+		pdev_array[boardcnt-1] = pdev;
+		sb->pdev = pdev;
+		sb->bus_number = pdev->bus->number;
+		sb->dev_number = PCI_SLOT(pdev->devfn);
+		sb->board_enum = (int)sunix_pci_board_id[tablecnt].driver_data;
+		sb->pb_info = snx_pci_board_conf[sb->board_enum];
+		sb->board_flag = sb->pb_info.board_flag;
+		sb->board_number = boardcnt - 1;
+		sb->oem_id = oem_id;
+		sb->uart_cnt = sb->pb_info.num_serport;
+		sb->gpio_chl_cnt = gpio_ch_cnt;
+		sb->board_uart_type = uart_type;
+		sb->board_gpio_card_type = gpio_card_type;
+		sb->board_gpio_type = gpio_type;
+	}
+
+	// search SUN1999 parallel board
+	pdev = NULL;
+	tablecnt = 0;
+	sub_device_id = 0;
+	status = 0;
+
+	while (tablecnt < sunix_pci_board_id_cnt) {
+
+		pdev = pci_get_device(VENID_SUN1999, DEVID_S_PARALL, pdev);
+
+		if (pdev == NULL) {
+			tablecnt++;
+			continue;
+		}
+
+		if ((tablecnt > 0) &&
+		((pdev == pdev_array[0]) ||
+		(pdev == pdev_array[1]) ||
+		(pdev == pdev_array[2]) ||
+		(pdev == pdev_array[3]))) {
+			continue;
+		}
+
+		pci_read_config_word(pdev, 0x2e, &sub_device_id);
+
+		if (sub_device_id == 0) {
+			status = -EIO;
+			return status;
+		}
+
+		if (sub_device_id != sunix_pci_board_id[tablecnt].subdevice)
+			continue;
+
+		if (pdev == NULL) {
+			pr_err("SNX Error: PCI device object is an NULL pointer !\n\n");
+			status = -EIO;
+			return status;
+
+		} else {
+
+			status = pci_enable_device(pdev);
+
+			if (status != 0) {
+				pr_err("SNX Error: SUNIX Board Enable Fail !\n\n");
+				status = -ENXIO;
+				return status;
+			}
+		}
+
+		boardcnt++;
+		if (boardcnt > SNX_BOARDS_MAX) {
+			pr_err("\n");
+			pr_err("SNX Error: SUNIX Driver Module Support Four Boards In Maximum !\n\n");
+			status = -ENOSPC;
+			return status;
+		}
+
+		sb = &sunix_board_table[boardcnt-1];
+		pdev_array[boardcnt-1] = pdev;
+		sb->pdev = pdev;
+		sb->bus_number = pdev->bus->number;
+		sb->dev_number = PCI_SLOT(pdev->devfn);
+		sb->board_enum = (int)sunix_pci_board_id[tablecnt].driver_data;
+		sb->pb_info = snx_pci_board_conf[sb->board_enum];
+		sb->board_flag = sb->pb_info.board_flag;
+		sb->board_number = boardcnt - 1;
+	}
+
+	// print info
+	if (boardcnt == 0) {
+		pr_err("SNX Info : No SUNIX Multi-I/O Board Found !\n\n");
+		status = -ENXIO;
+		return status;
+
+	} else {
+
+		for (i = 0; i < SNX_BOARDS_MAX; i++) {
+			sb = &sunix_board_table[i];
+
+			if (sb->board_enum > 0) {
+				pr_err("\n");
+
+			if ((sb->pb_info.num_serport > 0) &&
+				(sb->pb_info.num_parport > 0)) {
+				pr_err("SNX Info : Found SUNIX %s Series Board (%dS%dP),\n",
+				sb->pb_info.board_name,
+				sb->pb_info.num_serport,
+				sb->pb_info.num_parport);
+			} else if ((sb->pb_info.num_serport) > 0) {
+				pr_err("SNX Info : Found SUNIX %s Series Board (%dS),\n",
+				sb->pb_info.board_name,
+				sb->pb_info.num_serport);
+			} else {
+				pr_err("SNX Info : Found SUNIX %s Series Board (%dP),\n",
+				sb->pb_info.board_name,
+				sb->pb_info.num_parport);
+			}
+				pr_err(" bus number:%d, device number:%d\n\n",
+				sb->bus_number, sb->dev_number);
+			}
+		}
+		snx_board_count = boardcnt;
+	}
+
+	return status;
+}
+
+
+static int sunix_get_pci_board_conf(void)
+{
+	struct sunix_board *sb = NULL;
+	struct pci_dev *pdev = NULL;
+	int status = 0;
+	int i;
+	int j;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+		if (sb->board_enum > 0) {
+			pdev = sb->pdev;
+			sb->ports = sb->pb_info.num_serport +
+				sb->pb_info.num_parport;
+			sb->ser_port = sb->pb_info.num_serport;
+			sb->par_port = sb->pb_info.num_parport;
+			snx_ser_port_total_cnt = snx_ser_port_total_cnt +
+				sb->ser_port;
+			snx_par_port_total_cnt = snx_par_port_total_cnt +
+				sb->par_port;
+
+			if (snx_ser_port_total_cnt > SNX_SER_TOTAL_MAX) {
+				pr_err("SNX Error: Too much serial port\n");
+				status = -EIO;
+				return status;
+			}
+
+			if (snx_par_port_total_cnt > SNX_PAR_SUPPORT_MAX) {
+				pr_err("SNX Error: Too much parallel port\n");
+				status = -EIO;
+				return status;
+			}
+
+			for (j = 0; j < SNX_PCICFG_BAR_TOTAL; j++)
+				sb->bar_addr[j] = pci_resource_start(pdev, j);
+
+
+			sb->irq = sb->pdev->irq;
+
+			if (sb->irq <= 0) {
+				pr_err("SNX Error: SUNIX Board %s Series (bus:%d device:%d), in configuartion space, irq isn't valid !\n\n",
+				sb->pb_info.board_name,
+				sb->bus_number,
+				sb->dev_number);
+
+				status = -EIO;
+				return status;
+			}
+		}
+	}
+
+	return status;
+}
+
+
+static int sunix_assign_resource(void)
+{
+	struct sunix_board *sb = NULL;
+	struct sunix_ser_port *sp = NULL;
+	struct sunix_par_port *pp = NULL;
+
+	int status = 0;
+	int i;
+	int j;
+	int k;
+	int ser_n;
+	int ser_port_index = 0;
+
+	memset(sunix_ser_table, 0, (SNX_SER_TOTAL_MAX + 1) *
+	sizeof(struct sunix_ser_port));
+
+	memset(sunix_par_table, 0, (SNX_PAR_TOTAL_MAX) *
+	sizeof(struct sunix_par_port));
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+		if (sb->board_enum > 0) {
+			if (sb->ser_port > 0) {
+				sb->vector_mask = 0;
+
+		// assign serial port resource
+		ser_n = sb->ser_port_index = ser_port_index;
+
+		sp = &sunix_ser_table[ser_n];
+
+		if (sp == NULL) {
+			status = -ENXIO;
+			pr_err("SNX Error: Serial port table address error !\n");
+			return status;
+		}
+
+		for (j = 0; j < sb->ser_port; j++, ser_n++, sp++) {
+			sp->port.chip_flag = sb->pb_info.port[j].chip_flag;
+			sp->port.iobase = sb->bar_addr[
+			sb->pb_info.port[j].bar1] +
+			sb->pb_info.port[j].offset1;
+
+			if ((sb->board_flag & BOARDFLAG_REMAP) ==
+			BOARDFLAG_REMAP) {
+				sp->port.vector = 0;
+				sb->vector_mask = 0x00;
+			} else {
+				sp->port.vector = sb->bar_addr[
+				sb->pb_info.intr_vector_bar] +
+				sb->pb_info.intr_vector_offset;
+				sb->vector_mask |= (1 << j);
+			}
+		}
+
+			ser_port_index = ser_port_index + sb->ser_port;
+		}
+
+
+		// assign parallel port resource
+		if (sb->par_port > 0) {
+			k = 0;
+
+			for (j = 0; j < SNX_PAR_TOTAL_MAX; j++) {
+				if ((k + 1) > sb->par_port)
+					break;
+
+				if (j >= SNX_PAR_TOTAL_MAX) {
+					status = -EACCES;
+					pr_err("SNX Error: Too much parallel port!\n");
+					return status;
+				}
+
+				pp = &sunix_par_table[j];
+
+				if (pp == NULL) {
+					status = -ENXIO;
+					pr_err("SNX Error: Parallel port table address error !\n");
+					return status;
+				}
+
+				if (pp->chip_flag != SUNNONE_HWID) {
+					continue;
+				} else {
+					pp->chip_flag = sb->pb_info.port[k +
+					sb->ser_port].chip_flag;
+
+					pp->base = sb->bar_addr[
+					sb->pb_info.port[k +
+					sb->ser_port].bar1] +
+					sb->pb_info.port[k +
+					sb->ser_port].offset1;
+
+					pp->base_hi = sb->bar_addr[
+					sb->pb_info.port[k +
+					sb->ser_port].bar2] +
+					sb->pb_info.port[k +
+					sb->ser_port].offset2;
+
+					pp->bus_number = sb->bus_number;
+					pp->dev_number = sb->dev_number;
+					pp->board_enum = sb->board_enum;
+					k++;
+				}
+			}
+		}
+		}
+	}
+
+	return status;
+}
+
+
+static int sunix_ser_port_table_init(void)
+{
+	struct sunix_board *sb = NULL;
+	struct sunix_ser_port *sp = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int n;
+	int AHDC_State = 0;
+	int RS422_State = 0;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+	if (sb == NULL) {
+		status = -ENXIO;
+		pr_err("SNX Error: Board table pointer error !\n");
+		return status;
+	}
+
+	if ((sb->board_enum > 0) && (sb->ser_port > 0)) {
+		n = sb->ser_port_index;
+		sp = &sunix_ser_table[n];
+
+		if (sp == NULL) {
+			status = -ENXIO;
+			pr_err("SNX Error: Serial port table pointer error !\n");
+			return status;
+		}
+
+		for (j = 0; j < sb->ser_port; j++, n++, sp++) {
+			if (j < 4) {
+				AHDC_State = inb(sb->bar_addr[3]+2) & 0x0F &
+						(0x01 << (((j+1)-1) % 4));
+				RS422_State = inb(sb->bar_addr[3]+3) &
+				0xF0 & (0x10 << (((j+1)-1) % 4));
+			} else if (j < 8) {
+				AHDC_State = inb(sb->bar_addr[1] + 0x32) &
+				0x0F & (0x01 << (((j+1)-1) % 4));
+				RS422_State = inb(sb->bar_addr[1] + 0x33) &
+				0xF0 & (0x10 << (((j+1)-1) % 4));
+			}
+
+			RS422_State = ((RS422_State & 0xF0) >> 4);
+			sp->port.AHDC_State = AHDC_State >> (((j+1)-1)%4);
+			sp->port.RS422_State = RS422_State >> (((j+1)-1)%4);
+
+			sp->port.board_enum	= sb->board_enum;
+			sp->port.bus_number	= sb->bus_number;
+			sp->port.dev_number	= sb->dev_number;
+			sp->port.baud_base = 921600;
+			sp->port.pb_info = sb->pb_info;
+			sp->port.irq = sb->irq;
+			sp->port.line = n;
+			sp->port.uartclk = sp->port.baud_base * 16;
+			sp->port.iotype = SNX_UPIO_PORT;
+			sp->port.flags = ASYNC_SHARE_IRQ;
+			sp->port.ldisc_stop_rx = 0;
+			spin_lock_init(&sp->port.lock);
+
+			if (sp->port.chip_flag == SUN1889_HWID) {
+				sp->port.snx_type = SNX_SER_PORT_SUN1889;
+				sp->port.type = PORT_SER_16650V2;
+				sp->port.fifosize = SUN1889_FIFOSIZE_SET;
+				sp->port.rx_trigger = SUN1889_TRIGGER_LEVEL_SET;
+			} else if (sp->port.chip_flag == SUN1699_HWID) {
+				sp->port.snx_type = SNX_SER_PORT_SUN1699;
+				sp->port.type = PORT_SER_16650V2;
+				sp->port.fifosize = SUN1699_FIFOSIZE_SET;
+				sp->port.rx_trigger = SUN1699_TRIGGER_LEVEL_SET;
+			} else if (sp->port.chip_flag == SUNMATX_HWID) {
+				sp->port.snx_type = SNX_SER_PORT_SUNMATX;
+				sp->port.type = PORT_SER_16750;
+				sp->port.fifosize = SUNMATX_FIFOSIZE_SET;
+				sp->port.rx_trigger = SUNMATX_TRIGGER_LEVEL_SET;
+			} else if (sp->port.chip_flag == SUN1999_HWID) {
+				sp->port.snx_type = SNX_SER_PORT_SUN1999;
+				sp->port.type = PORT_SER_16750;
+				sp->port.fifosize = SUN1999_FIFOSIZE_SET;
+				sp->port.rx_trigger = SUN1999_TRIGGER_LEVEL_SET;
+			} else {
+				sp->port.snx_type = SNX_SER_PORT_UNKNOWN;
+				sp->port.type = PORT_SER_16450;
+				sp->port.fifosize = DEFAULT_FIFOSIZE;
+				sp->port.rx_trigger = DEFAULT_TRIGGER_LEVEL;
+			}
+
+
+			if ((sb->pb_info.board_flag &
+				BOARDFLAG_REMAP) == BOARDFLAG_REMAP) {
+				sp->port.vector_mask = 0;
+				sp->port.port_flag = PORTFLAG_REMAP;
+			} else {
+				sp->port.vector_mask = sb->vector_mask;
+				sp->port.port_flag = PORTFLAG_NONE;
+			}
+
+			if ((sb->pb_info.board_flag &
+				BOARDFLAG_16PORTS) ==	BOARDFLAG_16PORTS)
+				sp->port.port_flag |= PORTFLAG_16PORTS;
+
+
+			sp->port.setserial_flag = SNX_SER_BAUD_NOTSETSER;
+			}
+
+			sb->ser_isr = sunix_ser_interrupt;
+		} else {
+			sb->ser_isr = NULL;
+		}
+	}
+
+
+	// release io resource
+	for (i = 0; i < SNX_SER_TOTAL_MAX; i++) {
+		sp = &sunix_ser_table[i];
+
+		if (sp->port.iobase > 0)
+			release_region(sp->port.iobase, SNX_SER_ADDRESS_LENGTH);
+
+	}
+	return status;
+}
+
+
+static int sunix_par_port_table_init(void)
+{
+	struct sunix_board *sb = NULL;
+	struct sunix_par_port *pp = NULL;
+	int status = 0;
+	int i;
+	int j;
+	int k;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+		if (sb == NULL) {
+			status = -ENXIO;
+			pr_err("SNX Error: Board table pointer error !\n");
+			return status;
+		}
+
+		if ((sb->board_enum > 0) && (sb->par_port > 0)) {
+			k = 0;
+			for (j = 0; j < SNX_PAR_TOTAL_MAX; j++) {
+				pp = &sunix_par_table[j];
+
+				if (pp == NULL) {
+					status = -ENXIO;
+		pr_err("SNX Error: Parallel port tablepointer error\n");
+					return status;
+				}
+
+				if ((k + 1) > sb->par_port)
+					break;
+
+				if ((pp->bus_number == sb->bus_number) &&
+					(pp->dev_number == sb->dev_number) &&
+					(pp->board_enum	== sb->board_enum)) {
+
+					pp->pb_info = sb->pb_info;
+					//pp->irq = sb->irq;
+					pp->irq	= PARPORT_IRQ_NONE;
+					pp->portnum = j;
+
+					if (pp->chip_flag == SUN1888_HWID) {
+						pp->snx_type =
+						SNX_PAR_PORT_SUN1888;
+					} else if (pp->chip_flag ==
+						SUN1689_HWID) {
+						pp->snx_type =
+						SNX_PAR_PORT_SUN1689;
+					} else if (pp->chip_flag ==
+						SUNMATX_HWID) {
+						pp->snx_type =
+						SNX_PAR_PORT_SUNMATX;
+					} else if (pp->chip_flag ==
+						SUN1999_HWID) {
+						pp->snx_type =
+						SNX_PAR_PORT_SUN1999;
+					} else {
+						pp->snx_type =
+						SNX_PAR_PORT_UNKNOWN;
+					}
+
+					if ((sb->pb_info.board_flag &
+						BOARDFLAG_REMAP) ==
+						BOARDFLAG_REMAP) {
+						pp->port_flag = PORTFLAG_REMAP;
+					} else {
+						pp->port_flag = PORTFLAG_NONE;
+					}
+					sb->par_isr = NULL;
+					k++;
+				}
+			}
+		}
+	}
+
+
+	// release io resource
+	for (i = 0; i < SNX_PAR_TOTAL_MAX; i++) {
+		pp = &sunix_par_table[i];
+
+		if (pp->base > 0) {
+			release_region(pp->base, SNX_PAR_ADDRESS_LENGTH);
+
+
+			release_region(pp->base, SNX_PAR_STD_ADDR_LENGTH);
+
+			release_region(pp->base +
+			SNX_PAR_STD_ADDR_LENGTH,
+			SNX_PAR_ETD_ADDR_LENGTH);
+
+			if (pp->base_hi > 0) {
+				release_region(pp->base_hi,
+				SNX_PAR_ADDRESS_LENGTH);
+
+				release_region(pp->base_hi,
+				SNX_PAR_STD_ADDR_LENGTH);
+
+				release_region(pp->base_hi +
+				SNX_PAR_STD_ADDR_LENGTH,
+				SNX_PAR_ETD_ADDR_LENGTH);
+			}
+		}
+	}
+
+	return status;
+}
+
+int sunix_register_irq(void)
+{
+	struct sunix_board *sb = NULL;
+	int status = 0;
+	int i;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+		if (sb == NULL) {
+			status = -ENXIO;
+			pr_err("SNX Error: Board table pointer error !\n");
+			return status;
+		}
+
+		if (sb->board_enum > 0) {
+			status = request_irq(sb->irq,
+			sunix_interrupt,
+			IRQF_SHARED,
+			"snx", sb);
+
+			if (status) {
+				pr_err("SNX Error: SUNIX Multi-I/O %s Board(bus:%d device:%d), request\n",
+				sb->pb_info.board_name,
+				sb->bus_number,
+				sb->dev_number);
+				pr_err("           IRQ %d fail, IRQ %d may be conflit with another device.\n",
+				sb->irq, sb->irq);
+				return status;
+			}
+		}
+	}
+
+	return status;
+}
+
+
+void sunix_release_irq(void)
+{
+	struct sunix_board *sb = NULL;
+	int i;
+
+	for (i = 0; i < SNX_BOARDS_MAX; i++) {
+		sb = &sunix_board_table[i];
+
+		if (sb->board_enum > 0)
+			free_irq(sb->irq, sb);
+	}
+}
+
+static struct pci_driver snx_pci_driver = {
+	.name			= "snx",
+	.probe			= snx_pci_probe,
+	.suspend		= snx_suspend_one,
+	.resume			= snx_resume_one,
+	.id_table		= sunix_pci_board_id,
+};
+
+static int __init snx_init(void)
+{
+	int status = 0;
+
+	pr_err("SNX Info : Loading SUNIX Multi-I/O Board Driver Module\n");
+
+	snx_ser_port_total_cnt = snx_par_port_total_cnt = 0;
+
+	status = sunix_pci_board_probe();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_get_pci_board_conf();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_assign_resource();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_ser_port_table_init();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_par_port_table_init();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_register_irq();
+	if (status != 0)
+		goto step1_fail;
+
+	status = sunix_ser_register_driver(&sunix_ser_reg);
+	if (status != 0)
+		goto step2_fail;
+
+	status = sunix_ser_register_ports(&sunix_ser_reg);
+	if (status != 0)
+		goto step3_fail;
+
+	status = pci_register_driver(&snx_pci_driver);
+	if (status != 0)
+		goto step7_fail;
+
+	if (snx_par_port_total_cnt > 0) {
+		status = sunix_par_parport_init();
+		if (status != 0)
+			goto step4_fail;
+
+		status = sunix_par_ppdev_init();
+		if (status != 0)
+			goto step5_fail;
+
+		status = sunix_par_lp_init();
+		if (status != 0)
+			goto step6_fail;
+	}
+
+#if SNX_DBG
+	sunix_debug();
+#endif
+
+	return status;
+
+
+	if (snx_par_port_total_cnt > 0) {
+step7_fail:
+
+		pci_unregister_driver(&snx_pci_driver);
+step6_fail:
+
+		sunix_par_ppdev_exit();
+
+
+step5_fail:
+
+		sunix_par_parport_exit();
+
+
+step4_fail:
+
+		sunix_ser_unregister_ports(&sunix_ser_reg);
+	}
+
+step3_fail:
+
+	sunix_ser_unregister_driver(&sunix_ser_reg);
+
+
+step2_fail:
+
+	sunix_release_irq();
+
+
+step1_fail:
+
+	pr_err("SNX Error: Couldn't Loading SUNIX Multi-I/O Board Driver Module correctly,\n");
+	pr_err("           please reboot system and try again. If still can't loading driver,\n");
+	pr_err("           contact support.\n\n");
+
+	return status;
+}
+
+
+static void __exit snx_exit(void)
+{
+	if (snx_par_port_total_cnt > 0) {
+		sunix_par_lp_exit();
+
+		sunix_par_ppdev_exit();
+
+		sunix_par_parport_exit();
+	}
+
+	sunix_ser_unregister_ports(&sunix_ser_reg);
+
+	sunix_ser_unregister_driver(&sunix_ser_reg);
+
+	sunix_release_irq();
+	pci_unregister_driver(&snx_pci_driver);
+	pr_err("SNX Info : Unload SUNIX Multi-I/O Board Driver Module Done.\n");
+}
+
+module_init(snx_init);
+module_exit(snx_exit);
+
diff --git a/char/snx/snx_serial.c b/char/snx/snx_serial.c
new file mode 100644
index 00000000..fdac4c90
--- /dev/null
+++ b/char/snx/snx_serial.c
@@ -0,0 +1,4263 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+#include "driver_extd.h"
+
+#define SNX_ioctl_DBG	0
+#define	EEPROM_ACCESS_DELAY_COUNT			100000
+
+static DEFINE_SEMAPHORE(ser_port_sem);
+
+#define SNX_HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
+#define sunix_ser_users(state) \
+((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
+
+static struct tty_port snx_service_port;
+
+struct serial_uart_config {
+	char	*name;
+	int		dfl_xmit_fifo_size;
+	int		flags;
+};
+
+static const struct serial_uart_config
+snx_uart_config[PORT_SER_MAX_UART + 1] = {
+	{ "unknown",	1,		0 },
+	{ "8250",		1,		0 },
+	{ "16450",		1,		0 },
+	{ "16550",		1,		0 },
+	{ "16550A",	16,	UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "Cirrus",		1,		0 },
+	{ "ST16650",	1,		0 },
+	{ "ST16650V2",	32,		UART_CLEAR_FIFO | UART_USE_FIFO },
+	{ "TI16750",	64,		UART_CLEAR_FIFO | UART_USE_FIFO },
+};
+
+
+static _INLINE_ void snx_ser_handle_cts_change(
+	struct snx_ser_port *, unsigned int);
+static _INLINE_ void snx_ser_update_mctrl(
+	struct snx_ser_port *, unsigned int, unsigned int);
+static void     snx_ser_write_wakeup(struct snx_ser_port *);
+static void     snx_ser_stop(struct tty_struct *);
+static void     __snx_ser_start(struct tty_struct *);
+static void     snx_ser_start(struct tty_struct *);
+static void     snx_ser_tasklet_action(unsigned long);
+static void     snx_ser_shutdown(struct snx_ser_state *);
+static _INLINE_ void __snx_ser_put_char(
+	struct snx_ser_port *, struct circ_buf *, unsigned char);
+static int      snx_ser_put_char(
+	struct tty_struct *, unsigned char);
+static void     snx_ser_flush_chars(struct tty_struct *);
+static int      snx_ser_chars_in_buffer(struct tty_struct *);
+static void     snx_ser_flush_buffer(struct tty_struct *);
+static void     snx_ser_send_xchar(struct tty_struct *, char);
+static void     snx_ser_throttle(struct tty_struct *);
+static void     snx_ser_unthrottle(struct tty_struct *);
+static int      snx_ser_get_info(
+	struct snx_ser_state *, struct serial_struct *);
+static int      snx_ser_set_info(
+	struct snx_ser_state *, struct serial_struct *);
+static int      snx_ser_write_room(struct tty_struct *);
+static int      snx_ser_write(
+	struct tty_struct *, const unsigned char *, int);
+static int      snx_ser_get_lsr_info(
+	struct snx_ser_state *, unsigned int *);
+static int      snx_ser_tiocmget(struct tty_struct *);
+static int      snx_ser_tiocmset(
+	struct tty_struct *, unsigned int, unsigned int);
+static int      snx_ser_break_ctl(struct tty_struct *, int);
+static int      snx_ser_wait_modem_status(
+	struct snx_ser_state *, unsigned long);
+static int      snx_ser_get_count(struct snx_ser_state *,
+	struct serial_icounter_struct *);
+static int      snx_ser_ioctl(struct tty_struct *, unsigned int, unsigned long);
+static void		snx_ser_hangup(struct tty_struct *tty);
+static unsigned int	snx_ser_get_divisor(
+	struct snx_ser_port *port, unsigned int baud);
+
+//extern void		snx_ser_change_speed(
+	//struct snx_ser_state *state, struct SNXTERMIOS *old_termios);
+
+static void		snx_ser_set_termios(
+	struct tty_struct *, struct SNXTERMIOS *);
+static void		snx_ser_update_timeout(
+	struct snx_ser_port *, unsigned int, unsigned int);
+static struct	snx_ser_state *snx_ser_get(struct snx_ser_driver *, int);
+static int		snx_ser_block_til_ready(
+	struct file *, struct snx_ser_state *);
+static void		snx_ser_wait_until_sent(struct tty_struct *, int);
+static int		snx_ser_open(struct tty_struct *, struct file *);
+static void		snx_ser_close(struct tty_struct *, struct file *);
+
+
+static void		sunix_ser_set_mctrl(
+	struct snx_ser_port *, unsigned int);
+static unsigned int sunix_ser_tx_empty(struct snx_ser_port *);
+static unsigned int sunix_ser_get_mctrl(struct snx_ser_port *);
+static void		sunix_ser_stop_tx(struct snx_ser_port *, unsigned int);
+static void		sunix_ser_start_tx(struct snx_ser_port *, unsigned int);
+static void		sunix_ser_stop_rx(struct snx_ser_port *);
+static void		sunix_ser_enable_ms(struct snx_ser_port *);
+static void		sunix_ser_break_ctl(struct snx_ser_port *, int);
+static int		sunix_ser_startup(struct snx_ser_port *);
+static void		sunix_ser_shutdown(struct snx_ser_port *);
+static unsigned int sunix_ser_get_divisor(
+	struct snx_ser_port *, unsigned int);
+static void		sunix_ser_set_termios(
+	struct snx_ser_port *, struct SNXTERMIOS *, struct SNXTERMIOS *);
+
+static void sunix_ser_timeout(struct timer_list *t);
+
+static _INLINE_ void sunix_ser_receive_chars(
+	struct sunix_ser_port *, unsigned char *);
+static _INLINE_ void sunix_ser_transmit_chars(
+	struct sunix_ser_port *);
+static _INLINE_ void sunix_ser_check_modem_status(
+	struct sunix_ser_port *, unsigned char);
+static _INLINE_ void sunix_ser_handle_port(
+	struct sunix_ser_port *, unsigned char);
+
+
+//extern int	sunix_ser_interrupt(
+	//struct sunix_board *, struct sunix_ser_port *first_sp);
+static void		sunix_ser_release_io(struct snx_ser_port *port);
+static void		sunix_ser_request_io(struct snx_ser_port *port);
+static void		sunix_ser_configure_port(
+	struct snx_ser_driver *drv,
+	struct snx_ser_state *state,
+	struct snx_ser_port *port);
+static void		sunix_ser_unconfigure_port(
+	struct snx_ser_driver *drv,
+	struct snx_ser_state *state);
+static int		sunix_ser_add_one_port(
+	struct snx_ser_driver *drv, struct snx_ser_port *port);
+static int		sunix_ser_remove_one_port(
+	struct snx_ser_driver *drv, struct snx_ser_port *port);
+//extern int      sunix_ser_register_ports(struct snx_ser_driver *drv);
+//extern void     sunix_ser_unregister_ports(struct snx_ser_driver *drv);
+//extern int      sunix_ser_register_driver(struct snx_ser_driver *drv);
+//extern void     sunix_ser_unregister_driver(struct snx_ser_driver *drv);
+
+
+static unsigned char READ_INTERRUPT_VECTOR_BYTE(
+	struct sunix_ser_port *);
+static unsigned int  READ_INTERRUPT_VECTOR_WORD(
+	struct sunix_ser_port *);
+static unsigned int  READ_1999_INTERRUPT_VECTOR_WORD(
+	struct sunix_board *, struct sunix_ser_port *);
+static unsigned char READ_UART_RX(struct sunix_ser_port *);
+static unsigned char READ_UART_IIR(struct sunix_ser_port *);
+static unsigned char READ_UART_LCR(struct sunix_ser_port *);
+static unsigned char READ_UART_LSR(struct sunix_ser_port *);
+static unsigned char READ_UART_MSR(struct sunix_ser_port *);
+static void WRITE_UART_TX(struct sunix_ser_port *, unsigned char);
+static void WRITE_UART_IER(struct sunix_ser_port *, unsigned char);
+static void WRITE_UART_FCR(struct sunix_ser_port *, unsigned char);
+static void WRITE_UART_LCR(struct sunix_ser_port *, unsigned char);
+static void WRITE_UART_MCR(struct sunix_ser_port *, unsigned char);
+static void WRITE_UART_DLL(struct sunix_ser_port *, int);
+static void WRITE_UART_DLM(struct sunix_ser_port *, int);
+
+static int EEPROMWriteData(int, int, int);
+
+
+static unsigned char READ_INTERRUPT_VECTOR_BYTE(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.vector) {
+		data = inb(sp->port.vector);
+		return data;
+	}
+	return 0;
+}
+
+
+static unsigned int READ_INTERRUPT_VECTOR_WORD(struct sunix_ser_port *sp)
+{
+	unsigned int data;
+	unsigned int vet1;
+	unsigned int vet2;
+
+	if (sp->port.vector) {
+		vet1 = inb(sp->port.vector);
+		vet2 = inb(sp->port.vector + 1);
+
+		vet2 <<= 8;
+		data = (vet1 | vet2);
+	return data;
+	}
+	return 0;
+}
+
+static unsigned int READ_1999_INTERRUPT_VECTOR_WORD(
+struct sunix_board *sb, struct sunix_ser_port *sp)
+{
+	unsigned int data;
+	unsigned int vet1 = 0;
+	unsigned int vet2 = 0;
+	unsigned int vet3 = 0;
+	unsigned int vet4 = 0;
+	unsigned int var;
+	unsigned int local_vector;
+
+	if (sp->port.vector) {
+		vet1 = inb(sp->port.vector);
+		var = inb(sp->port.vector + 1);
+		local_vector = sb->bar_addr[1];
+
+		if (var == 0x01) {
+			vet2 = inb(local_vector + 0x30);
+			vet2 <<= 4;
+		}
+
+		if (var == 0x02) {
+			vet3 = inb(local_vector + 0x70);
+			vet3 <<= 8;
+		}
+
+		if (var == 0x04) {
+			vet4 = inb(local_vector + 0xb0);
+			vet4 <<= 12;
+		}
+
+		data = (vet1 | vet2 | vet3 | vet4);
+
+		return data;
+	}
+	return 0;
+}
+
+
+
+static unsigned char READ_UART_RX(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.iobase) {
+		data = inb(sp->port.iobase + UART_RX);
+
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_TX(struct sunix_ser_port *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_TX);
+
+}
+
+
+static void WRITE_UART_IER(struct sunix_ser_port *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_IER);
+
+}
+
+
+static unsigned char READ_UART_IIR(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.iobase) {
+		data = inb(sp->port.iobase + UART_IIR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_FCR(struct sunix_ser_port *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_FCR);
+
+}
+
+
+static unsigned char READ_UART_LCR(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.iobase) {
+		data = inb(sp->port.iobase + UART_LCR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_LCR(struct sunix_ser_port *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_LCR);
+
+}
+
+
+static void WRITE_UART_MCR(struct sunix_ser_port *sp, unsigned char data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_MCR);
+
+}
+
+
+static unsigned char READ_UART_LSR(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.iobase) {
+		data = inb(sp->port.iobase + UART_LSR);
+		return data;
+	}
+	return 0;
+}
+
+
+static unsigned char READ_UART_MSR(struct sunix_ser_port *sp)
+{
+	unsigned char data;
+
+	if (sp->port.iobase) {
+		data = inb(sp->port.iobase + UART_MSR);
+		return data;
+	}
+	return 0;
+}
+
+
+static void WRITE_UART_DLL(struct sunix_ser_port *sp, int data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_DLL);
+
+}
+
+
+static void WRITE_UART_DLM(struct sunix_ser_port *sp, int data)
+{
+	if (sp->port.iobase)
+		outb(data, sp->port.iobase + UART_DLM);
+
+}
+
+static int EEPROMWriteData(int targetConfigAddress, int address, int data)
+{
+	int Busy = -1;
+	int Error = -1;
+	int delayCount = 0;
+
+	do {
+		do {
+			Busy = inb(targetConfigAddress + 0x08) & 0x01;
+
+			if (delayCount++ > EEPROM_ACCESS_DELAY_COUNT)
+				return -1;
+
+		} while (Busy);
+
+		outb(address, targetConfigAddress + 0x09);
+		outb(data, targetConfigAddress + 0x0A);
+		outb(0x03, targetConfigAddress + 0x08);
+
+		delayCount	= 0;
+
+		do {
+			Busy = inb(targetConfigAddress + 0x08) & 0x01;
+
+			if (delayCount++ > EEPROM_ACCESS_DELAY_COUNT)
+				return -1;
+
+		} while (Busy);
+
+		Error = inb(targetConfigAddress + 0x08) & 0x04;
+
+	} while (Error);
+
+	return 0;
+
+}
+
+
+static _INLINE_ void snx_ser_handle_cts_change(
+struct snx_ser_port *port, unsigned int status)
+{
+	struct snx_ser_info *info = port->info;
+	struct tty_struct *tty = info->tty;
+
+	port->icount.cts++;
+
+	if (info->flags & SNX_UIF_CTS_FLOW) {
+		if (tty->hw_stopped) {
+			if (status) {
+				tty->hw_stopped = 0;
+				sunix_ser_start_tx(port, 0);
+				snx_ser_write_wakeup(port);
+			}
+		} else {
+
+			if (!status) {
+				tty->hw_stopped = 1;
+				sunix_ser_stop_tx(port, 0);
+			}
+		}
+	}
+}
+
+
+static _INLINE_ void snx_ser_update_mctrl(
+struct snx_ser_port *port, unsigned int set, unsigned int clear)
+{
+	unsigned long flags;
+	unsigned int old;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	old = port->mctrl;
+	port->mctrl = (old & ~clear) | set;
+
+	if (old != port->mctrl)
+		sunix_ser_set_mctrl(port, port->mctrl);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+#define snx_set_mctrl(port, set)	snx_ser_update_mctrl(port, set, 0)
+#define snx_clear_mctrl(port, clear)	snx_ser_update_mctrl(port, 0, clear)
+
+
+static void snx_ser_write_wakeup(struct snx_ser_port *port)
+{
+	struct snx_ser_info *info = port->info;
+
+	tasklet_schedule(&info->tlet);
+}
+
+
+static void snx_ser_stop(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+	port = state->port;
+
+	spin_lock_irqsave(&port->lock, flags);
+	sunix_ser_stop_tx(port, 1);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+static void __snx_ser_start(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = tty->driver_data;
+	struct snx_ser_port *port = state->port;
+
+	if (!snx_ser_circ_empty(&state->info->xmit) &&
+	state->info->xmit.buf && !tty->stopped && !tty->hw_stopped) {
+		sunix_ser_start_tx(port, 1);
+	}
+}
+
+
+static void snx_ser_start(struct tty_struct *tty)
+{
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	//spin_lock_irqsave(&port->lock, flags);
+	__snx_ser_start(tty);
+	//spin_unlock_irqrestore(&port->lock, flags);
+}
+
+
+static void snx_ser_tasklet_action(unsigned long data)
+{
+	struct snx_ser_state *state = (struct snx_ser_state *)data;
+	struct tty_struct *tty = NULL;
+
+	tty = state->info->tty;
+	if (tty) {
+
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		tty->ldisc->ops->write_wakeup) {
+			tty->ldisc->ops->write_wakeup(tty);
+		}
+		wake_up_interruptible(&tty->write_wait);
+	}
+}
+
+
+extern int snx_ser_startup(struct snx_ser_state *state, int init_hw)
+{
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+	unsigned long page;
+	int retval = 0;
+
+	if (info->flags & SNX_UIF_INITIALIZED)
+		return 0;
+
+	if (info->tty)
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+
+	if (port->type == PORT_UNKNOWN)
+		return 0;
+
+	if (!info->xmit.buf) {
+		page = get_zeroed_page(GFP_KERNEL);
+
+		if (!page)
+			return -ENOMEM;
+
+		info->xmit.buf = (unsigned char *) page;
+
+		info->tmpbuf = info->xmit.buf + SNX_UART_XMIT_SIZE;
+
+		sema_init(&info->tmpbuf_sem, 1);
+
+		snx_ser_circ_clear(&info->xmit);
+	}
+
+	retval = sunix_ser_startup(port);
+
+	if (retval == 0) {
+		if (init_hw) {
+			snx_ser_change_speed(state, NULL);
+
+			if (info->tty->termios.c_cflag & CBAUD)
+				snx_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+
+		}
+
+		info->flags |= SNX_UIF_INITIALIZED;
+
+		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+	}
+
+	if (retval && capable(CAP_SYS_ADMIN))
+		retval = 0;
+
+	return retval;
+}
+
+
+static void snx_ser_shutdown(struct snx_ser_state *state)
+{
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+
+	if (!(info->flags & SNX_UIF_INITIALIZED))
+		return;
+
+	if (!info->tty || (info->tty->termios.c_cflag & HUPCL))
+		snx_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+
+	wake_up_interruptible(&info->delta_msr_wait);
+
+	sunix_ser_shutdown(port);
+
+	synchronize_irq(port->irq);
+
+	if (info->xmit.buf) {
+		free_page((unsigned long)info->xmit.buf);
+		info->xmit.buf = NULL;
+		info->tmpbuf = NULL;
+	}
+
+	tasklet_kill(&info->tlet);
+
+	if (info->tty)
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+
+	info->flags &= ~SNX_UIF_INITIALIZED;
+}
+
+
+static _INLINE_ void __snx_ser_put_char(
+struct snx_ser_port *port, struct circ_buf *circ, unsigned char c)
+{
+	unsigned long flags;
+
+	if (!circ->buf)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (snx_ser_circ_chars_free(circ) != 0) {
+		circ->buf[circ->head] = c;
+		circ->head = (circ->head + 1) & (SNX_UART_XMIT_SIZE - 1);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int  snx_ser_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+	state = tty->driver_data;
+	__snx_ser_put_char(state->port, &state->info->xmit, ch);
+
+	return 0;
+}
+
+
+static void snx_ser_flush_chars(struct tty_struct *tty)
+{
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	snx_ser_start(tty);
+}
+
+
+static int snx_ser_chars_in_buffer(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+
+	state = tty->driver_data;
+
+	return snx_ser_circ_chars_pending(&state->info->xmit);
+}
+
+
+static void snx_ser_flush_buffer(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+
+	state = tty->driver_data;
+	port = state->port;
+
+	if (!state || !state->info)
+		return;
+
+
+	spin_lock_irqsave(&port->lock, flags);
+	snx_ser_circ_clear(&state->info->xmit);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	wake_up_interruptible(&tty->write_wait);
+
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	tty->ldisc->ops->write_wakeup) {
+		(tty->ldisc->ops->write_wakeup)(tty);
+	}
+}
+
+
+static void snx_ser_send_xchar(struct tty_struct *tty, char ch)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long flags;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+	port = state->port;
+	port->x_char = ch;
+
+	if (ch) {
+		spin_lock_irqsave(&port->lock, flags);
+		sunix_ser_start_tx(port, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+
+static void snx_ser_throttle(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+	port = state->port;
+
+	port->ldisc_stop_rx = 1;
+
+	if (I_IXOFF(tty))
+		snx_ser_send_xchar(tty, STOP_CHAR(tty));
+
+	if (tty->termios.c_cflag & CRTSCTS)
+		snx_clear_mctrl(state->port, TIOCM_RTS);
+}
+
+
+static void snx_ser_unthrottle(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+	port = state->port;
+
+	port->ldisc_stop_rx = 0;
+
+	if (I_IXOFF(tty)) {
+		if (port->x_char)
+			port->x_char = 0;
+		else
+			snx_ser_send_xchar(tty, START_CHAR(tty));
+
+	}
+
+	if (tty->termios.c_cflag & CRTSCTS)
+		snx_set_mctrl(port, TIOCM_RTS);
+
+}
+
+static int snx_ser_get_info(struct snx_ser_state *state,
+struct serial_struct *retinfo)
+{
+	struct snx_ser_port *port = state->port;
+
+	struct serial_struct tmp;
+
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.type            = port->type;
+	tmp.line            = port->line;
+	tmp.port            = port->iobase;
+
+	if (SNX_HIGH_BITS_OFFSET)
+		tmp.port_high = (long) port->iobase >> SNX_HIGH_BITS_OFFSET;
+
+	tmp.irq             = port->irq;
+	tmp.flags           = port->flags;
+	tmp.xmit_fifo_size  = port->fifosize;
+	tmp.baud_base       = port->uartclk / 16;
+	tmp.close_delay     = state->close_delay;
+	tmp.closing_wait    = state->closing_wait;
+
+	tmp.custom_divisor  = port->custom_divisor;
+	tmp.io_type         = port->iotype;
+
+	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
+		return -EFAULT;
+
+	return 0;
+}
+
+
+static int snx_ser_set_info(struct snx_ser_state *state,
+struct serial_struct *newinfo)
+{
+	struct serial_struct new_serial;
+	struct snx_ser_port *port = state->port;
+	struct tty_port		*tport = &state->tport;
+	unsigned long new_port;
+	unsigned int change_irq;
+	unsigned int change_port;
+	unsigned int old_custom_divisor;
+	unsigned int closing_wait;
+	unsigned int close_delay;
+	unsigned int old_flags;
+	unsigned int new_flags;
+	int retval = 0;
+
+	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
+		return -EFAULT;
+
+	new_port = new_serial.port;
+
+	if (SNX_HIGH_BITS_OFFSET)
+		new_port += (unsigned long)
+			new_serial.port_high << SNX_HIGH_BITS_OFFSET;
+
+	new_serial.irq = irq_canonicalize(new_serial.irq);
+
+	close_delay = new_serial.close_delay;
+	closing_wait = new_serial.closing_wait ==
+		ASYNC_CLOSING_WAIT_NONE ?
+		SNX_USF_CLOSING_WAIT_NONE : new_serial.closing_wait;
+
+	down(&state->sem);
+
+	change_irq  = new_serial.irq != port->irq;
+
+	change_port =   new_port != port->iobase ||
+					new_serial.io_type != port->iotype ||
+					new_serial.type != port->type;
+
+	old_flags = port->flags;
+	new_flags = new_serial.flags;
+	old_custom_divisor = port->custom_divisor;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		retval = -EPERM;
+		if (change_irq ||
+			change_port ||
+			(new_serial.baud_base != port->uartclk / 16) ||
+			(close_delay != state->close_delay) ||
+			(closing_wait != state->closing_wait) ||
+			(new_serial.xmit_fifo_size != port->fifosize) ||
+			(((new_flags ^ old_flags) & ~SNX_UPF_USR_MASK) != 0)) {
+			goto exit;
+		}
+
+		port->flags = ((port->flags & ~SNX_UPF_USR_MASK) |
+			(new_flags & SNX_UPF_USR_MASK));
+		port->custom_divisor = new_serial.custom_divisor;
+		goto check_and_exit;
+	}
+
+	if (change_port || change_irq) {
+		retval = -EBUSY;
+
+		if (sunix_ser_users(state) > 1)
+			goto exit;
+
+		snx_ser_shutdown(state);
+	}
+
+	if (change_port) {
+		unsigned int old_type;
+
+		old_type = port->type;
+
+		if (old_type != PORT_UNKNOWN)
+			sunix_ser_release_io(port);
+
+		port->iobase = new_port;
+		port->type = new_serial.type;
+		port->iotype = new_serial.io_type;
+
+		retval = 0;
+	}
+
+	port->irq	= new_serial.irq;
+	port->uartclk	= new_serial.baud_base * 16;
+	port->flags	= ((port->flags & ~SNX_UPF_CHANGE_MASK) |
+		(new_flags & SNX_UPF_CHANGE_MASK));
+	port->custom_divisor	= new_serial.custom_divisor;
+	state->close_delay	= close_delay;
+	state->closing_wait	= closing_wait;
+	port->fifosize	= new_serial.xmit_fifo_size;
+
+	tport->low_latency = (port->flags & SNX_UPF_LOW_LATENCY) ? 1 : 0;
+
+check_and_exit:
+	retval = 0;
+	if (port->type == PORT_UNKNOWN)
+		goto exit;
+
+
+	if (state->info->flags & SNX_UIF_INITIALIZED) {
+		if (((old_flags ^ port->flags) & SNX_UPF_SPD_MASK) ||
+		old_custom_divisor != port->custom_divisor) {
+
+			if (port->flags & SNX_UPF_SPD_MASK) {
+				pr_info("SNX Info : %s sets custom speed ",
+					current->comm);
+				pr_info("on ttySNX%d. This is deprecated.\n",
+					port->line);
+			}
+			snx_ser_change_speed(state, NULL);
+		}
+	} else {
+		retval = snx_ser_startup(state, 1);
+	}
+exit:
+
+	up(&state->sem);
+
+	return retval;
+}
+
+
+static int snx_ser_write_room(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+	int status = 0;
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+	state = tty->driver_data;
+
+	status = snx_ser_circ_chars_free(&state->info->xmit);
+
+	return status;
+}
+
+
+static int snx_ser_write(struct tty_struct *tty,
+const unsigned char *buf, int count)
+{
+	struct snx_ser_state *state = tty->driver_data;
+	struct circ_buf *circ = NULL;
+	struct snx_ser_port *port = state->port;
+	unsigned long flags;
+
+	int c;
+	int ret = 0;
+
+	if (!state || !state->info)
+		return -EL3HLT;
+
+	circ = &state->info->xmit;
+
+	if (!circ->buf)
+		return 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (1) {
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail,
+			SNX_UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+
+		if (c <= 0)
+			break;
+
+		memcpy(circ->buf + circ->head, buf, c);
+
+		circ->head = (circ->head + c) & (SNX_UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	snx_ser_start(tty);
+
+	return ret;
+}
+
+
+static int snx_ser_get_lsr_info(struct snx_ser_state *state,
+unsigned int *value)
+{
+	struct snx_ser_port *port = state->port;
+	unsigned int result = 0;
+
+	result = sunix_ser_tx_empty(port);
+
+
+	if ((port->x_char) ||
+		((snx_ser_circ_chars_pending(&state->info->xmit) > 0) &&
+		!state->info->tty->stopped && !state->info->tty->hw_stopped)) {
+		result &= ~TIOCSER_TEMT;
+	}
+
+	return put_user(result, value);
+
+}
+
+
+static int snx_ser_tiocmget(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int result = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+		result = port->mctrl;
+		result |= sunix_ser_get_mctrl(port);
+	}
+
+	up(&state->sem);
+
+	return result;
+}
+
+static int snx_ser_tiocmset(struct tty_struct *tty,
+unsigned int set, unsigned int clear)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int ret = -EIO;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+		snx_ser_update_mctrl(port, set, clear);
+		ret = 0;
+	}
+
+	up(&state->sem);
+
+	return ret;
+}
+
+
+static int  snx_ser_break_ctl(struct tty_struct *tty, int break_state)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return 0;
+
+
+	state = tty->driver_data;
+	port = state->port;
+
+	down(&state->sem);
+
+	if (port->type != PORT_UNKNOWN)
+		sunix_ser_break_ctl(port, break_state);
+
+
+	up(&state->sem);
+
+	return 0;
+}
+
+
+static int snx_ser_wait_modem_status(
+struct snx_ser_state *state, unsigned long arg)
+{
+	struct snx_ser_port *port = state->port;
+	DECLARE_WAITQUEUE(wait, current);
+	struct snx_ser_icount cprev;
+	struct snx_ser_icount cnow;
+	int ret = 0;
+
+	spin_lock_irq(&port->lock);
+	memcpy(&cprev, &port->icount, sizeof(struct snx_ser_icount));
+
+	sunix_ser_enable_ms(port);
+
+	spin_unlock_irq(&port->lock);
+
+	add_wait_queue(&state->info->delta_msr_wait, &wait);
+
+	for (;;) {
+		spin_lock_irq(&port->lock);
+		memcpy(&cnow, &port->icount, sizeof(struct snx_ser_icount));
+		spin_unlock_irq(&port->lock);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
+			((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
+			((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
+			((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
+			ret = 0;
+			break;
+		}
+
+		schedule();
+
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+
+		cprev = cnow;
+	}
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&state->info->delta_msr_wait, &wait);
+
+	return ret;
+}
+
+
+static int snx_ser_get_count(struct snx_ser_state *state,
+struct serial_icounter_struct *icnt)
+{
+	struct serial_icounter_struct icount;
+	struct snx_ser_icount cnow;
+	struct snx_ser_port *port = state->port;
+
+	spin_lock_irq(&port->lock);
+	memcpy(&cnow, &port->icount, sizeof(struct snx_ser_icount));
+	spin_unlock_irq(&port->lock);
+
+	icount.cts         = cnow.cts;
+	icount.dsr         = cnow.dsr;
+	icount.rng         = cnow.rng;
+	icount.dcd         = cnow.dcd;
+	icount.rx          = cnow.rx;
+	icount.tx          = cnow.tx;
+	icount.frame       = cnow.frame;
+	icount.overrun     = cnow.overrun;
+	icount.parity      = cnow.parity;
+	icount.brk         = cnow.brk;
+	icount.buf_overrun = cnow.buf_overrun;
+
+	return copy_to_user(icnt, &icount, sizeof(icount)) ? -EFAULT : 0;
+}
+
+static int snx_ser_ioctl(struct tty_struct *tty,
+unsigned int cmd, unsigned long arg)
+{
+	struct snx_ser_state *state = NULL;
+	int ret = -ENOIOCTLCMD;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line < SNX_SER_TOTAL_MAX)
+		state = tty->driver_data;
+
+
+	switch (cmd) {
+	case TIOCGSERIAL:
+	{
+		if (line < SNX_SER_TOTAL_MAX)
+			ret = snx_ser_get_info(state,
+				(struct serial_struct *)arg);
+
+		break;
+	}
+
+	case TIOCSSERIAL:
+	{
+		if (line < SNX_SER_TOTAL_MAX) {
+			state->port->setserial_flag = SNX_SER_BAUD_SETSERIAL;
+			ret = snx_ser_set_info(state,
+				(struct serial_struct *)arg);
+		}
+		break;
+	}
+
+
+	case TCSETS:
+	{
+		if (line < SNX_SER_TOTAL_MAX) {
+			state->port->flags &= ~(SNX_UPF_SPD_HI |
+				SNX_UPF_SPD_VHI |
+				SNX_UPF_SPD_SHI |
+				SNX_UPF_SPD_WARP);
+			state->port->setserial_flag = SNX_SER_BAUD_NOTSETSER;
+			snx_ser_update_termios(state);
+		}
+		break;
+	}
+
+	case TIOCSERGWILD:
+	case TIOCSERSWILD:
+	{
+		if (line < SNX_SER_TOTAL_MAX)
+			ret = 0;
+
+	break;
+	}
+
+	case SNX_SER_DUMP_PORT_INFO:
+	{
+		int i;
+		struct snx_ser_port_info snx_port_info[SNX_SER_TOTAL_MAX];
+		struct snx_ser_port *sdn = NULL;
+
+		memset(snx_port_info, 0,
+			(sizeof(struct snx_ser_port_info) *
+				SNX_SER_TOTAL_MAX));
+
+		if (line == 0) {
+			for (i = 0; i < SNX_SER_TOTAL_MAX; i++) {
+				sdn = (struct snx_ser_port *)
+					&sunix_ser_table[i];
+
+				memcpy(&snx_port_info[i].board_name_info[0],
+					&sdn->pb_info.board_name[0],
+					SNX_BOARDNAME_LENGTH);
+
+				snx_port_info[i].bus_number_info =
+					sdn->bus_number;
+				snx_port_info[i].dev_number_info =
+					sdn->dev_number;
+				snx_port_info[i].port_info       = sdn->line;
+				snx_port_info[i].base_info       = sdn->iobase;
+				snx_port_info[i].irq_info        = sdn->irq;
+			}
+
+			if (copy_to_user((void *)arg, snx_port_info,
+			SNX_SER_TOTAL_MAX * sizeof(struct snx_ser_port_info)))
+				ret = -EFAULT;
+			else
+				ret = 0;
+
+		} else {
+			ret = 0;
+		}
+
+		ret = 0;
+		break;
+	}
+
+	case SNX_SER_DUMP_DRIVER_VER:
+	{
+		char driver_ver[SNX_DRIVERVERSION_LENGTH];
+
+		memset(driver_ver, 0,
+			(sizeof(char) * SNX_DRIVERVERSION_LENGTH));
+
+		if (line == 0) {
+
+			memcpy(&driver_ver[0], SNX_DRIVER_VERSION,
+				sizeof(SNX_DRIVER_VERSION));
+
+			if (copy_to_user((void *)arg, &driver_ver,
+			(sizeof(char) * SNX_DRIVERVERSION_LENGTH)))
+				ret = -EFAULT;
+			else
+				ret = 0;
+
+		} else {
+			ret = 0;
+		}
+
+		break;
+	}
+
+	case SNX_COMM_GET_BOARD_CNT:
+	{
+		SNX_DRVR_BOARD_CNT gb;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_BOARD_CNT)));
+
+		gb.cnt = snx_board_count;
+
+		if (copy_to_user((void *)arg, &gb,
+		(sizeof(SNX_DRVR_BOARD_CNT))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+
+		break;
+	}
+
+	case SNX_COMM_GET_BOARD_INFO:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_BOARD_INFO		board_info;
+
+		memset(&board_info, 0, (sizeof(SNX_DRVR_BOARD_INFO)));
+
+		if (copy_from_user(&board_info, (void *)arg,
+		(sizeof(SNX_DRVR_BOARD_INFO))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[board_info.board_id - 1];
+
+		board_info.subvender_id = sb->pb_info.sub_vendor_id;
+		board_info.subsystem_id = sb->pb_info.sub_device_id;
+		board_info.oem_id = sb->oem_id;
+		board_info.uart_cnt = sb->uart_cnt;
+		board_info.gpio_chl_cnt = sb->gpio_chl_cnt;
+		board_info.board_uart_type = sb->board_uart_type;
+		board_info.board_gpio_type = sb->board_gpio_type;
+
+		if (copy_to_user((void *)arg, &board_info,
+		(sizeof(SNX_DRVR_BOARD_INFO))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		break;
+	}
+
+	case SNX_GPIO_GET:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_GPIO_GET gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_GET)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_GET))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		switch (sb->gpio_chl_cnt) {
+		case 6:
+		{
+			gb.bank1_direct = inb(bar3_base_Address + 0x0D);
+			gb.bank2_direct = 0x00;
+			gb.bank3_direct = 0x00;
+			gb.bank4_direct = 0x00;
+			break;
+		}
+
+		case 8:
+		{
+			gb.bank1_direct = inb(bar1_base_Address + 0xC4);
+			gb.bank2_direct = 0x00;
+			gb.bank3_direct = 0x00;
+			gb.bank4_direct = 0x00;
+			break;
+		}
+
+		case 16:
+		{
+			gb.bank1_direct = inb(bar1_base_Address + 0xC4);
+			gb.bank2_direct = inb(bar1_base_Address + 0xC5);
+			gb.bank3_direct = 0x00;
+			gb.bank4_direct = 0x00;
+			break;
+		}
+
+		case 32:
+		{
+			gb.bank1_direct = inb(bar1_base_Address + 0xC4);
+			gb.bank2_direct = inb(bar1_base_Address + 0xC5);
+			gb.bank3_direct = inb(bar1_base_Address + 0xC6);
+			gb.bank4_direct = inb(bar1_base_Address + 0xC7);
+			break;
+		}
+
+			break;
+		}
+
+		if (copy_to_user((void *)arg, &gb,
+		(sizeof(SNX_DRVR_GPIO_GET))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		break;
+	}
+
+	case SNX_GPIO_SET:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_GPIO_SET gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_SET)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_SET))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		if (sb->board_gpio_type == SNX_GPIO_TYPE_STANDARD) {
+			switch (sb->gpio_chl_cnt) {
+			case 6:
+			{
+				outb(gb.bank1_direct, bar3_base_Address + 0x0D);
+				break;
+			}
+
+			case 8:
+			{
+				outb(gb.bank1_direct, bar1_base_Address + 0xC4);
+				break;
+			}
+
+			case 16:
+			{
+				outb(gb.bank1_direct, bar1_base_Address + 0xC4);
+				outb(gb.bank2_direct, bar1_base_Address + 0xC5);
+				break;
+			}
+
+			case 32:
+			{
+				outb(gb.bank1_direct, bar1_base_Address + 0xC4);
+				outb(gb.bank2_direct, bar1_base_Address + 0xC5);
+				outb(gb.bank3_direct, bar1_base_Address + 0xC6);
+				outb(gb.bank4_direct, bar1_base_Address + 0xC7);
+				break;
+			}
+			break;
+			}
+		}
+
+		break;
+	}
+
+	case SNX_GPIO_READ:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_GPIO_READ	gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		unsigned char	bank1_data = 0;
+		unsigned char	bank2_data = 0;
+		unsigned char bank3_data = 0;
+		unsigned char	bank4_data = 0;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_READ)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_READ))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		switch (sb->gpio_chl_cnt) {
+		case 6:
+		{
+			bank1_data = inb(bar3_base_Address + 0x0C);
+			break;
+		}
+
+		case 8:
+		{
+			bank1_data = inb(bar1_base_Address + 0xC0);
+			break;
+		}
+
+		case 16:
+		{
+			bank1_data = inb(bar1_base_Address + 0xC0);
+			bank2_data = inb(bar1_base_Address + 0xC1);
+			break;
+		}
+
+		case 32:
+		{
+			bank1_data = inb(bar1_base_Address + 0xC0);
+			bank2_data = inb(bar1_base_Address + 0xC1);
+			bank3_data = inb(bar1_base_Address + 0xC2);
+			bank4_data = inb(bar1_base_Address + 0xC3);
+			break;
+		}
+		break;
+		}
+
+		gb.bank1_signal = bank1_data;
+		gb.bank2_signal = bank2_data;
+		gb.bank3_signal = bank3_data;
+		gb.bank4_signal = bank4_data;
+
+		if (copy_to_user((void *)arg, &gb,
+		(sizeof(SNX_DRVR_GPIO_READ))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		break;
+	}
+
+	case SNX_GPIO_WRITE:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_GPIO_WRITE	gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_WRITE)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_WRITE))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		switch (sb->gpio_chl_cnt) {
+		case 6:
+		{
+			outb(gb.bank1_signal, bar3_base_Address + 0x0C);
+			break;
+		}
+
+		case 8:
+		{
+			outb(gb.bank1_signal, bar1_base_Address + 0xC0);
+			break;
+		}
+
+		case 16:
+		{
+			outb(gb.bank1_signal, bar1_base_Address + 0xC0);
+			outb(gb.bank2_signal, bar1_base_Address + 0xC1);
+			break;
+		}
+
+		case 32:
+		{
+			outb(gb.bank1_signal, bar1_base_Address + 0xC0);
+			outb(gb.bank2_signal, bar1_base_Address + 0xC1);
+			outb(gb.bank3_signal, bar1_base_Address + 0xC2);
+			outb(gb.bank4_signal, bar1_base_Address + 0xC3);
+			break;
+		}
+		break;
+		}
+
+		break;
+	}
+
+	case SNX_GPIO_SET_DEFAULT:
+	{
+		struct sunix_board *sb = NULL;
+		SNX_DRVR_GPIO_SET gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+		int Busy = -1;
+		int Error = -1;
+		int delayCount = 0;
+		int dataCount = 0;
+
+		unsigned char FlashData[20];
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_SET)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_SET))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		switch (sb->gpio_chl_cnt) {
+		case 6:
+		{
+			do {
+				do {
+					Busy = inb(bar3_base_Address +
+						0x08) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+
+				} while (Busy);
+
+				outb(0x19, bar3_base_Address + 0x09);
+
+				outb(gb.bank1_direct ^ 0xFF,
+					bar3_base_Address + 0x0A);
+
+				outb(0x03, bar3_base_Address + 0x08);
+
+				do {
+					Busy = inb(bar3_base_Address +
+						0x08) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+
+				} while (Busy);
+
+				Error = inb(bar3_base_Address + 0x08) & 0x04;
+			} while (Error);
+
+			break;
+		}
+
+		case 32:
+		case 16:
+		case 8:
+		{
+			for (dataCount = 0; dataCount < 19; ++dataCount) {
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				outb(dataCount, bar1_base_Address + 0xE1);
+
+				outb(0x01, bar1_base_Address + 0xE0);
+
+				delayCount = 0;
+
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				FlashData[dataCount] =
+					inb(bar1_base_Address + 0xE2);
+			}
+
+			switch (sb->gpio_chl_cnt) {
+			case 32:
+			{
+				FlashData[0x07]	= gb.bank1_direct ^ 0xFF;
+				FlashData[0x08]	= gb.bank2_direct ^ 0xFF;
+				FlashData[0x09]	= gb.bank3_direct ^ 0xFF;
+				FlashData[0x0A]	= gb.bank4_direct ^ 0xFF;
+				break;
+			}
+			case 16:
+			{
+				FlashData[0x07]	= gb.bank1_direct ^ 0xFF;
+				FlashData[0x08]	= gb.bank2_direct ^ 0xFF;
+
+				break;
+			}
+			case 8:
+			{
+				FlashData[0x07]	= gb.bank1_direct ^ 0xFF;
+				break;
+			}
+			break;
+			}
+
+			do {
+				Busy = inb(bar1_base_Address + 0xE0) & 0x01;
+
+				if (++delayCount > EEPROM_ACCESS_DELAY_COUNT)
+					return -EFAULT;
+
+			} while (Busy);
+
+			outb(0x09, bar1_base_Address + 0xE0);
+
+			do {
+				Busy = inb(bar1_base_Address + 0xE0) & 0x01;
+
+				if (++delayCount > EEPROM_ACCESS_DELAY_COUNT)
+					return -EFAULT;
+
+			} while (Busy);
+
+			for (dataCount = 0; dataCount < 19; ++dataCount) {
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				outb(dataCount, bar1_base_Address + 0xE1);
+
+				outb(FlashData[dataCount],
+					bar1_base_Address + 0xE2);
+
+				outb(0x03, bar1_base_Address + 0xE0);
+
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+			}
+			break;
+		}
+	break;
+	}
+	break;
+	}
+
+	case SNX_GPIO_WRITE_DEFAULT:
+	{
+		struct sunix_board	*sb = NULL;
+		SNX_DRVR_GPIO_WRITE	gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+		int Busy = -1;
+		int Error = -1;
+		int delayCount = 0;
+		int dataCount = 0;
+		unsigned char FlashData[20];
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_GPIO_WRITE)));
+
+		if (copy_from_user(&gb, (void *)arg,
+		(sizeof(SNX_DRVR_GPIO_WRITE))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		switch (sb->gpio_chl_cnt) {
+		case 6:
+		{
+			do {
+				do {
+					Busy = inb(bar3_base_Address +
+						0x08) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+
+				} while (Busy);
+
+				outb(0x1A, bar3_base_Address + 0x09);
+
+				outb(gb.bank1_signal, bar3_base_Address + 0x0A);
+
+				outb(0x03, bar3_base_Address + 0x08);
+
+				do {
+					Busy = inb(bar3_base_Address +
+						0x08) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				Error = inb(bar3_base_Address + 0x08) & 0x04;
+			} while (Error);
+		break;
+		}
+
+		case 32:
+		case 16:
+		case 8:
+		{
+			for (dataCount = 0; dataCount < 19 ; ++dataCount) {
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				outb(dataCount, bar1_base_Address + 0xE1);
+
+				outb(0x01, bar1_base_Address + 0xE0);
+
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+					if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+						return -EFAULT;
+
+				} while (Busy);
+
+				FlashData[dataCount] =
+				inb(bar1_base_Address + 0xE2);
+			}
+
+				switch (sb->gpio_chl_cnt) {
+				case 32:
+				{
+					FlashData[0x0B]	= gb.bank1_signal;
+					FlashData[0x0C]	= gb.bank2_signal;
+					FlashData[0x0D]	= gb.bank3_signal;
+					FlashData[0x0E]	= gb.bank4_signal;
+					break;
+				}
+				case 16:
+				{
+					FlashData[0x0B]	= gb.bank1_signal;
+					FlashData[0x0C]	= gb.bank2_signal;
+					break;
+				}
+				case 8:
+				{
+					FlashData[0x0B]	= gb.bank1_signal;
+					break;
+				}
+				break;
+			}
+
+			do {
+				Busy = inb(bar1_base_Address + 0xE0) & 0x01;
+
+				if (++delayCount > EEPROM_ACCESS_DELAY_COUNT)
+					return -EFAULT;
+
+			} while (Busy);
+
+			outb(0x09, bar1_base_Address + 0xE0);
+
+			for (dataCount = 0; dataCount < 19 ; ++dataCount) {
+
+				do {
+					Busy = inb(bar1_base_Address +
+						0xE0) & 0x01;
+
+				if (++delayCount > EEPROM_ACCESS_DELAY_COUNT)
+					return -EFAULT;
+
+				} while (Busy);
+
+			outb(dataCount, bar1_base_Address + 0xE1);
+
+			outb(FlashData[dataCount],
+				bar1_base_Address + 0xE2);
+
+			outb(0x03, bar1_base_Address + 0xE0);
+
+			delayCount = 0;
+
+			do {
+				Busy = inb(bar1_base_Address +
+					0xE0) & 0x01;
+
+				if (++delayCount >
+					EEPROM_ACCESS_DELAY_COUNT)
+					return -EFAULT;
+
+			} while (Busy);
+			}
+
+			break;
+		}
+
+		break;
+		}
+	break;
+	}
+
+	case SNX_GPIO_GET_INPUT_INVERT:
+	{
+		struct sunix_board	*sb = NULL;
+		SNX_DRVR_GPIO_GET_INPUT_INVERT gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		memset(&gb, 0,
+			(sizeof(SNX_DRVR_GPIO_GET_INPUT_INVERT)));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_GPIO_GET_INPUT_INVERT))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+			switch (sb->gpio_chl_cnt) {
+			case 6:
+			{
+				gb.bank1_invert =
+					inb(bar3_base_Address + 0x0F);
+				gb.bank2_invert = 0x00;
+				gb.bank3_invert = 0x00;
+				gb.bank4_invert = 0x00;
+				break;
+			}
+
+			case 16:
+			{
+				gb.bank1_invert =
+					inb(bar1_base_Address + 0xD0);
+				gb.bank2_invert =
+					inb(bar1_base_Address + 0xD1);
+				gb.bank3_invert = 0x00;
+				gb.bank4_invert = 0x00;
+
+				break;
+			}
+
+			case 32:
+			{
+				gb.bank1_invert =
+					inb(bar1_base_Address + 0xD0);
+				gb.bank2_invert =
+					inb(bar1_base_Address + 0xD1);
+				gb.bank3_invert =
+					inb(bar1_base_Address + 0xD2);
+				gb.bank4_invert =
+					inb(bar1_base_Address + 0xD3);
+
+				break;
+			}
+
+			case 8:
+			{
+				gb.bank1_invert =
+					inb(bar1_base_Address + 0xD0);
+				gb.bank2_invert = 0x00;
+				gb.bank3_invert = 0x00;
+				gb.bank4_invert = 0x00;
+				break;
+			}
+
+			break;
+		}
+
+		if (copy_to_user((void *)arg, &gb,
+			(sizeof(SNX_DRVR_GPIO_GET_INPUT_INVERT))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		break;
+	}
+
+	case SNX_GPIO_SET_INPUT_INVERT:
+	{
+		struct sunix_board	*sb = NULL;
+		SNX_DRVR_GPIO_SET_INPUT_INVERT gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		memset(&gb, 0,
+			(sizeof(SNX_DRVR_GPIO_SET_INPUT_INVERT)));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_GPIO_SET_INPUT_INVERT))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+			switch (sb->gpio_chl_cnt) {
+			case 6:
+			{
+				outb(gb.bank1_invert,
+					bar3_base_Address + 0x0F);
+				break;
+			}
+
+			case 16:
+			{
+				outb(gb.bank1_invert,
+					bar1_base_Address + 0xD0);
+				outb(gb.bank2_invert,
+					bar1_base_Address + 0xD1);
+				break;
+			}
+
+			case 32:
+			{
+				outb(gb.bank1_invert,
+					bar1_base_Address + 0xD0);
+				outb(gb.bank2_invert,
+					bar1_base_Address + 0xD1);
+				outb(gb.bank3_invert,
+					bar1_base_Address + 0xD2);
+				outb(gb.bank4_invert,
+					bar1_base_Address + 0xD3);
+				break;
+			}
+
+			case 8:
+			{
+				outb(gb.bank1_invert,
+					bar1_base_Address + 0xD0);
+				break;
+			}
+
+			break;
+		}
+
+		break;
+	}
+
+	case SNX_UART_GET_TYPE:
+	{
+		struct sunix_board	*sb = NULL;
+		SNX_DRVR_UART_GET_TYPE gb;
+
+		int bar3_base_Address;
+		int bar1_base_Address;
+
+		int bar3_byte5;
+		int uart_type;
+		int	RS422state;
+		int	AHDCstate;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_UART_GET_TYPE)));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_UART_GET_TYPE))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		bar3_base_Address = pci_resource_start(sb->pdev, 3);
+		bar1_base_Address = pci_resource_start(sb->pdev, 1);
+
+		bar3_byte5 = inb(bar3_base_Address + 5);
+		uart_type = (bar3_byte5 & 0xC0) >> 6;
+
+		if (gb.uart_num <= 4) {
+			AHDCstate = inb(bar3_base_Address + 2)
+			& 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
+			RS422state = inb(bar3_base_Address + 3)
+			& 0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 8) {
+			AHDCstate = inb(bar1_base_Address + 0x32)
+			& 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
+			RS422state = inb(bar1_base_Address + 0x33) &
+			0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 12) {
+			AHDCstate = inb(bar1_base_Address
+			+ 0x32 + 0x40) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+			RS422state = inb(bar1_base_Address +
+			0x33 + 0x40) & 0xF0 &
+			(0x10 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 16) {
+			AHDCstate = inb(bar1_base_Address +
+			0x32 + 0x80) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+			RS422state = inb(bar1_base_Address +
+			0x33 + 0x80) & 0xF0 &
+			(0x10 << ((gb.uart_num - 1) % 4));
+		} else {
+			//pr_err(CE_NOTE, "WARNING : incorrect port
+			//number (port = %d)!",gb.uart_num);
+			break;
+		}
+
+			switch (uart_type) {
+			case 0: // RS-232
+			{
+				gb.uart_type = 0;
+				break;
+			}
+			case 1:
+			{
+				if (AHDCstate && RS422state)
+					gb.uart_type = 3;
+				else if (AHDCstate && !RS422state)
+					gb.uart_type = 2;
+				else if (!AHDCstate && RS422state)
+					gb.uart_type = 1;
+				else
+					gb.uart_type = -1;
+
+				break;
+			}
+			case 2:
+			{
+				if (AHDCstate && RS422state)
+					gb.uart_type = 3;
+				else if (AHDCstate && !RS422state)
+					gb.uart_type = 2;
+				else if (!AHDCstate && RS422state)
+					gb.uart_type = 1;
+				else if (!AHDCstate && !RS422state)
+					gb.uart_type = 0;
+				else
+					gb.uart_type = -1;
+
+				break;
+			}
+		}
+
+		if (copy_to_user((void *)arg, &gb,
+			(sizeof(SNX_DRVR_UART_GET_TYPE)))) {
+			ret = -EFAULT;
+		} else {
+			ret = 0;
+		}
+
+	break;
+	}
+
+	case SNX_UART_SET_TYPE: {
+		struct sunix_board	*sb = NULL;
+		struct sunix_ser_port *sp = NULL;
+
+		SNX_DRVR_UART_SET_TYPE gb;
+
+		int targetConfigAddress = 0;
+		int bar3_byte5;
+		int uart_type;
+		int AHDCstate;
+		int iobase;
+		int ModemControl;
+		int GPIOcontrol;
+		unsigned char	RS422state = 0;
+		unsigned char	GPIOstate = 0;
+
+		int n = 0;
+
+		memset(&gb, 0, (sizeof(SNX_DRVR_UART_SET_TYPE)));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_UART_SET_TYPE)))) {
+			ret = -EFAULT;
+		} else {
+			ret = 0;
+		}
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		n = (sb->ser_port_index - 1) + gb.uart_num;
+		sp = &sunix_ser_table[n];
+
+		bar3_byte5 = inb(sb->bar_addr[3] + 5);
+		uart_type  = (bar3_byte5 & 0xC0) >> 6;
+
+		if (gb.uart_num <= 4) {
+			targetConfigAddress	= sb->bar_addr[3];
+		} else if (gb.uart_num <= 8) {
+			targetConfigAddress	=
+				(sb->bar_addr[1] + 0x30);
+		} else if (gb.uart_num <= 12) {
+			targetConfigAddress	=
+				(sb->bar_addr[1] + 0x30 + 0x40);
+		} else if (gb.uart_num <= 16) {
+			targetConfigAddress	=
+				(sb->bar_addr[1] + 0x30 + 0x80);
+		}
+
+		AHDCstate = inb(targetConfigAddress + 0x02);
+		RS422state = inb(targetConfigAddress + 0x03);
+		GPIOstate = inb(targetConfigAddress + 0x0C);
+		GPIOcontrol = inb(targetConfigAddress + 0x0D);
+
+		iobase = sp->port.iobase;
+
+		ModemControl = inb(iobase + UART_MCR);
+
+		AHDCstate &= ~(0x01 <<
+			((gb.uart_num - 1) % 4));
+		RS422state &= ~(0x10 <<
+			((gb.uart_num - 1) % 4));
+		GPIOstate &= ~(0x01 <<
+			((gb.uart_num - 1) % 4));
+		GPIOstate &= ~(0x10 <<
+			((gb.uart_num - 1) % 4));
+		GPIOcontrol &= ~(0x01 <<
+			((gb.uart_num - 1) % 4));
+
+		if (uart_type == 0) {
+			if (gb.uart_type == 0) {
+				AHDCstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				sp->port.AHDC_State = 0x00;
+				sp->port.RS422_State = 0x00;
+			}
+		} else if (uart_type == 1) {
+			if (gb.uart_type == 3) {
+				AHDCstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				AHDCstate |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				sp->port.AHDC_State = 0x01;
+				sp->port.RS422_State = 0x01;
+			} else if (gb.uart_type == 2) {
+				AHDCstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				AHDCstate |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x10 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				// close DTR, close RTS
+				outb((ModemControl & 0xFC) |
+				0x03, iobase + UART_MCR);
+
+				sp->port.AHDC_State = 0x01;
+				sp->port.RS422_State = 0x00;
+			} else if (gb.uart_type == 1) {
+				AHDCstate |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				AHDCstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				outb((ModemControl & 0xFC) |
+					0x03, iobase + UART_MCR);
+
+				sp->port.AHDC_State = 0x00;
+				sp->port.RS422_State = 0x01;
+			}
+		} else if (uart_type == 2) {
+			if (gb.uart_type == 3) {
+				AHDCstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				sp->port.AHDC_State = 0x01;
+				sp->port.RS422_State = 0x01;
+			} else if (gb.uart_type == 2) {
+				AHDCstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x10 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				outb((ModemControl & 0xFC) |
+				0x03, iobase + UART_MCR);
+
+				sp->port.AHDC_State = 0x01;
+				sp->port.RS422_State = 0x00;
+			} else if (gb.uart_type == 1) {
+				AHDCstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state |= (0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+
+				outb((ModemControl & 0xFC) |
+				0x03, iobase + UART_MCR);
+
+				sp->port.AHDC_State = 0x00;
+				sp->port.RS422_State = 0x01;
+			} else if (gb.uart_type == 0) {
+				AHDCstate &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x10 <<
+					((gb.uart_num - 1) % 4));
+				RS422state &= ~(0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOstate |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+				GPIOcontrol |= (0x01 <<
+					((gb.uart_num - 1) % 4));
+
+				sp->port.AHDC_State = 0x00;
+				sp->port.RS422_State = 0x00;
+			}
+		}
+
+		outb(AHDCstate,
+			targetConfigAddress + 0x02);
+		outb(RS422state,
+			targetConfigAddress + 0x03);
+		outb(GPIOstate,
+			targetConfigAddress + 0x0C);
+		outb(GPIOcontrol,
+			targetConfigAddress + 0x0D);
+
+		EEPROMWriteData(targetConfigAddress,
+		0x13, AHDCstate);
+		EEPROMWriteData(targetConfigAddress,
+		0x14, RS422state);
+		EEPROMWriteData(targetConfigAddress,
+		0x19, ~GPIOcontrol);
+		EEPROMWriteData(targetConfigAddress,
+		0x1A, GPIOstate);
+
+		break;
+	}
+
+	case SNX_UART_GET_ACS:
+	{
+		SNX_DRVR_UART_GET_ACS gb;
+		struct sunix_board	*sb = NULL;
+		int	ACSstate = 0;
+
+		memset(&gb, 0, sizeof(SNX_DRVR_UART_GET_ACS));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_UART_GET_ACS))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		if (gb.uart_num <= 4) {
+			ACSstate = inb(sb->bar_addr[3] +
+			3) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 8) {
+			ACSstate = inb(sb->bar_addr[1] +
+			0x33) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 12) {
+			ACSstate = inb(sb->bar_addr[1] +
+			0x33 + 0x40) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+		} else if (gb.uart_num <= 16) {
+			ACSstate = inb(sb->bar_addr[1] +
+			0x33 + 0x80) & 0x0F &
+			(0x01 << ((gb.uart_num - 1) % 4));
+		}
+
+		if (ACSstate)
+			gb.uart_acs = 1;
+		else
+			gb.uart_acs = 0;
+
+		if (copy_to_user((void *)arg, &gb,
+			(sizeof(SNX_DRVR_UART_GET_ACS))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		break;
+	}
+
+	case SNX_UART_SET_ACS:
+	{
+		SNX_DRVR_UART_SET_ACS gb;
+		struct sunix_board	*sb = NULL;
+		int ACSstate = 0;
+		int targetConfigAddress = 0;
+
+		memset(&gb, 0, sizeof(SNX_DRVR_UART_SET_ACS));
+
+		if (copy_from_user(&gb, (void *)arg,
+			(sizeof(SNX_DRVR_UART_SET_ACS))))
+			ret = -EFAULT;
+		else
+			ret = 0;
+
+		sb = &sunix_board_table[gb.board_id - 1];
+
+		if (gb.uart_num <= 4) {
+			targetConfigAddress	=
+			sb->bar_addr[3];
+		} else if (gb.uart_num <= 8) {
+			targetConfigAddress	=
+			(sb->bar_addr[1] + 0x30);
+		} else if (gb.uart_num <= 12) {
+			targetConfigAddress	=
+			(sb->bar_addr[1] + 0x30 + 0x40);
+		} else if (gb.uart_num <= 16) {
+			targetConfigAddress	=
+			(sb->bar_addr[1] + 0x30 + 0x80);
+		}
+			ACSstate = inb(targetConfigAddress + 0x03);
+
+			ACSstate &= ~(0x01 << ((gb.uart_num - 1) % 4));
+
+			if (gb.uart_acs == 1) {
+				ACSstate |=	(0x01 <<
+				((gb.uart_num - 1) % 4));
+			}
+
+			outb(ACSstate, targetConfigAddress + 0x03);
+
+			EEPROMWriteData(targetConfigAddress,
+			0x14, ACSstate);
+
+		break;
+	}
+	}
+
+	if (ret != -ENOIOCTLCMD)
+		goto out;
+
+
+	if (tty->flags & (1 << TTY_IO_ERROR)) {
+		ret = -EIO;
+		goto out;
+	}
+
+		switch (cmd) {
+		case TIOCMIWAIT:
+		if (line < SNX_SER_TOTAL_MAX)
+			ret = snx_ser_wait_modem_status(state, arg);
+
+		break;
+
+		case TIOCGICOUNT:
+		if (line < SNX_SER_TOTAL_MAX) {
+			ret = snx_ser_get_count(state,
+				(struct serial_icounter_struct *)arg);
+		}
+		break;
+		}
+
+	if (ret != -ENOIOCTLCMD)
+		goto out;
+
+	if (line < SNX_SER_TOTAL_MAX) {
+		down(&state->sem);
+
+			switch (cmd) {
+			case TIOCSERGETLSR:
+			ret = snx_ser_get_lsr_info(state, (unsigned int *)arg);
+			break;
+
+			default:
+			{
+				break;
+			}
+			}
+
+		up(&state->sem);
+	}
+
+out:
+	return ret;
+}
+
+
+static void snx_ser_hangup(struct tty_struct *tty)
+{
+	struct snx_ser_state *state = NULL;
+	struct tty_port *tport = &state->tport;
+
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+
+	tport = &state->tport;
+
+	down(&state->sem);
+
+	if (state->info && state->info->flags & SNX_UIF_NORMAL_ACTIVE) {
+		snx_ser_flush_buffer(tty);
+		snx_ser_shutdown(state);
+		state->count = 0;
+		state->info->flags &= ~SNX_UIF_NORMAL_ACTIVE;
+
+		tty_port_tty_set(tport, NULL);
+
+		state->info->tty = NULL;
+		wake_up_interruptible(&state->info->open_wait);
+		wake_up_interruptible(&state->info->delta_msr_wait);
+	}
+
+	up(&state->sem);
+}
+
+
+static unsigned int snx_ser_get_divisor(struct snx_ser_port *port,
+unsigned int baud)
+{
+	unsigned int quot;
+
+	if (baud == 38400 && (port->flags & SNX_UPF_SPD_MASK) ==
+		SNX_UPF_SPD_CUST)
+		quot = port->custom_divisor;
+	else
+		quot = port->uartclk / (16 * baud);
+
+	return quot;
+}
+
+
+unsigned int snx_ser_get_baud_rate(struct snx_ser_port *port,
+struct SNXTERMIOS *termios, struct SNXTERMIOS *old,
+unsigned int min, unsigned int max)
+{
+	unsigned int try;
+	unsigned int baud;
+	unsigned int altbaud = 0;
+	unsigned int flags = port->flags & SNX_UPF_SPD_MASK;
+
+	for (try = 0; try < 2; try++) {
+		if ((port->setserial_flag == SNX_SER_BAUD_SETSERIAL) ||
+			(port->flags & SNX_UPF_SPD_MASK)) {
+			altbaud = 38400;
+
+			if (flags == SNX_UPF_SPD_HI)
+				altbaud = 57600;
+
+			if (flags == SNX_UPF_SPD_VHI)
+				altbaud = 115200;
+
+			if (flags == SNX_UPF_SPD_SHI)
+				altbaud = 230400;
+
+			if (flags == SNX_UPF_SPD_WARP)
+				altbaud = 460800;
+
+			baud = altbaud;
+		} else {
+			switch (termios->c_cflag & (CBAUD | CBAUDEX)) {
+			case B921600:
+			baud = 921600;
+			break;
+
+			case B460800:
+			baud = 460800;
+			break;
+
+			case B230400:
+			baud = 230400;
+			break;
+
+			case B115200:
+			baud = 115200;
+			break;
+
+			case B57600:
+			baud = 57600;
+			break;
+
+			case B38400:
+			baud = 38400;
+			break;
+
+			case B19200:
+			baud = 19200;
+			break;
+
+			case B9600:
+			baud = 9600;
+			break;
+
+			case B4800:
+			baud = 4800;
+			break;
+
+			case B2400:
+			baud = 2400;
+			break;
+
+			case B1800:
+			baud = 1800;
+			break;
+
+			case B1200:
+			baud = 1200;
+			break;
+
+			case B600:
+			baud = 600;
+			break;
+
+			case B300:
+			baud = 300;
+			break;
+
+			case B200:
+			baud = 200;
+			break;
+
+			case B150:
+			baud = 150;
+			break;
+
+			case B134:
+			baud = 134;
+			break;
+
+			case B110:
+			baud = 110;
+			break;
+
+			case B75:
+			baud = 75;
+			break;
+
+			case B50:
+			baud = 50;
+			break;
+
+			default:
+			baud = 9600;
+			break;
+			}
+		}
+
+		if (baud == 0)
+			baud = 9600;
+
+		if (baud >= min && baud <= max)
+			return baud;
+
+		termios->c_cflag &= ~CBAUD;
+
+		if (old) {
+			termios->c_cflag |= old->c_cflag & CBAUD;
+			old = NULL;
+			continue;
+		}
+
+		termios->c_cflag |= B9600;
+	}
+
+	return 0;
+}
+
+
+extern void snx_ser_change_speed(struct snx_ser_state *state,
+struct SNXTERMIOS *old_termios)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct snx_ser_port *port = state->port;
+	struct SNXTERMIOS *termios;
+
+	if (!tty || port->type == PORT_UNKNOWN)
+		return;
+
+	termios = &tty->termios;
+
+	if (termios->c_cflag & CRTSCTS)
+		state->info->flags |= SNX_UIF_CTS_FLOW;
+	else
+		state->info->flags &= ~SNX_UIF_CTS_FLOW;
+
+	if (termios->c_cflag & CLOCAL)
+		state->info->flags &= ~SNX_UIF_CHECK_CD;
+	else
+		state->info->flags |= SNX_UIF_CHECK_CD;
+
+	sunix_ser_set_termios(port, termios, old_termios);
+}
+
+
+static void snx_ser_set_termios(struct tty_struct *tty,
+struct SNXTERMIOS *old_termios)
+{
+	struct snx_ser_state *state = NULL;
+	unsigned long flags;
+	unsigned int cflag = tty->termios.c_cflag;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+
+#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
+
+	if ((cflag ^ old_termios->c_cflag) == 0 && RELEVANT_IFLAG(
+		tty->termios.c_iflag ^ old_termios->c_iflag) == 0) {
+		return;
+	}
+
+	snx_ser_change_speed(state, old_termios);
+
+	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
+		snx_clear_mctrl(state->port, TIOCM_RTS | TIOCM_DTR);
+
+	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
+		unsigned int mask = TIOCM_DTR;
+
+		if (!(cflag & CRTSCTS) || !test_bit(TTY_THROTTLED, &tty->flags))
+			mask |= TIOCM_RTS;
+
+		snx_set_mctrl(state->port, mask);
+	}
+
+	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
+		spin_lock_irqsave(&state->port->lock, flags);
+		tty->hw_stopped = 0;
+		__snx_ser_start(tty);
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	}
+}
+
+extern void snx_ser_update_termios(struct snx_ser_state *state)
+{
+	struct tty_struct *tty = state->info->tty;
+	struct snx_ser_port *port = state->port;
+
+	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+		snx_ser_change_speed(state, NULL);
+
+		if (tty->termios.c_cflag & CBAUD)
+			snx_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	}
+}
+
+
+static void snx_ser_update_timeout(struct snx_ser_port *port,
+unsigned int cflag, unsigned int baud)
+{
+	unsigned int bits;
+
+	switch (cflag & CSIZE) {
+	case CS5:
+	bits = 7;
+	break;
+
+	case CS6:
+	bits = 8;
+	break;
+
+	case CS7:
+	bits = 9;
+	break;
+
+	default:
+	bits = 10;
+	break;
+	}
+
+	if (cflag & CSTOPB)
+		bits++;
+
+	if (cflag & PARENB)
+		bits++;
+
+	bits = bits * port->fifosize;
+
+	port->timeout = (HZ * bits) / baud + HZ/50;
+}
+
+
+static struct snx_ser_state *snx_ser_get(struct snx_ser_driver *drv, int line)
+{
+	struct snx_ser_state *state = NULL;
+
+	down(&ser_port_sem);
+
+	state = drv->state + line;
+
+	if (down_interruptible(&state->sem)) {
+		state = ERR_PTR(-ERESTARTSYS);
+		goto out;
+	}
+
+	state->count++;
+
+	if (!state->port) {
+		state->count--;
+		up(&state->sem);
+		state = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	if (!state->port->iobase) {
+		state->count--;
+		up(&state->sem);
+		state = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	if (!state->info) {
+		state->info = kmalloc(sizeof(struct snx_ser_info), GFP_KERNEL);
+
+		if (state->info) {
+			memset(state->info, 0, sizeof(struct snx_ser_info));
+			init_waitqueue_head(&state->info->open_wait);
+			init_waitqueue_head(&state->info->delta_msr_wait);
+
+			state->port->info = state->info;
+
+			tasklet_init(&state->info->tlet,
+			snx_ser_tasklet_action, (unsigned long)state);
+		} else {
+			state->count--;
+			up(&state->sem);
+			state = ERR_PTR(-ENOMEM);
+		}
+	}
+
+out:
+	up(&ser_port_sem);
+
+	return state;
+}
+
+
+static int snx_ser_block_til_ready(struct file *filp,
+struct snx_ser_state *state)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct snx_ser_info *info = state->info;
+	struct snx_ser_port *port = state->port;
+
+	info->blocked_open++;
+	state->count--;
+
+	add_wait_queue(&info->open_wait, &wait);
+
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (tty_hung_up_p(filp) || info->tty == NULL)
+			break;
+
+		if (!(info->flags & SNX_UIF_INITIALIZED))
+			break;
+
+		if ((filp->f_flags & O_NONBLOCK) ||
+			(info->tty->termios.c_cflag & CLOCAL) ||
+			(info->tty->flags & (1 << TTY_IO_ERROR))) {
+			break;
+		}
+
+		if (info->tty->termios.c_cflag & CBAUD)
+			snx_set_mctrl(port, TIOCM_DTR);
+
+		if (sunix_ser_get_mctrl(port) & TIOCM_CAR)
+			break;
+
+		up(&state->sem);
+		schedule();
+		down(&state->sem);
+
+		if (signal_pending(current))
+			break;
+	}
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&info->open_wait, &wait);
+
+	state->count++;
+	info->blocked_open--;
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (!info->tty || tty_hung_up_p(filp))
+		return -EAGAIN;
+
+	return 0;
+}
+
+
+static void snx_ser_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct snx_ser_state *state = NULL;
+	struct snx_ser_port *port = NULL;
+	unsigned long char_time;
+	unsigned long expire;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line >= SNX_SER_TOTAL_MAX)
+		return;
+
+	state = tty->driver_data;
+	port = state->port;
+
+	if (port->type == PORT_UNKNOWN || port->fifosize == 0)
+		return;
+
+	char_time = (port->timeout - HZ/50) / port->fifosize;
+
+	char_time = char_time / 5;
+
+	if (char_time == 0)
+		char_time = 1;
+
+	if (timeout && timeout < char_time)
+		char_time = timeout;
+
+	if (timeout == 0 || timeout > 2 * port->timeout)
+		timeout = 2 * port->timeout;
+
+	expire = jiffies + timeout;
+
+	while (!sunix_ser_tx_empty(port)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(char_time);
+
+		if (signal_pending(current))
+			break;
+
+		if (time_after(jiffies, expire))
+			break;
+	}
+	set_current_state(TASK_RUNNING);
+}
+
+
+static int snx_ser_open(struct tty_struct *tty, struct file *filp)
+{
+	struct snx_ser_driver *drv =
+	(struct snx_ser_driver *)tty->driver->driver_state;
+
+	struct snx_ser_state *state = NULL;
+	struct tty_port *tport = NULL;
+
+	int retval = 0;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line < SNX_SER_TOTAL_MAX) {
+		retval = -ENODEV;
+
+		if (line >= SNX_SER_TOTAL_MAX)
+			goto fail;
+
+		state = snx_ser_get(drv, line);
+
+		tport = &state->tport;
+
+		if (IS_ERR(state)) {
+			retval = PTR_ERR(state);
+			goto fail;
+		}
+
+		if (!state)
+			goto fail;
+
+
+		state->port->suspended = 1;
+		tty->driver_data = state;
+
+		tport->low_latency = (state->port->flags &
+		SNX_UPF_LOW_LATENCY) ? 1 : 0;
+
+		state->info->tty = tty;
+
+		tty_port_tty_set(tport, tty);
+
+		if (tty_hung_up_p(filp)) {
+			retval = -EAGAIN;
+			state->count--;
+			up(&state->sem);
+			goto fail;
+		}
+
+		retval = snx_ser_startup(state, 0);
+
+		if (retval == 0)
+			retval = snx_ser_block_til_ready(filp, state);
+
+		up(&state->sem);
+
+		if (retval == 0 && !(state->info->flags &
+			SNX_UIF_NORMAL_ACTIVE)) {
+			state->info->flags |= SNX_UIF_NORMAL_ACTIVE;
+
+			snx_ser_update_termios(state);
+		}
+
+		try_module_get(THIS_MODULE);
+
+	} else {
+	}
+
+fail:
+
+	return retval;
+}
+
+
+static void snx_ser_close(struct tty_struct *tty, struct file *filp)
+{
+	struct snx_ser_state *state = tty->driver_data;
+	struct tty_port *tport;
+	struct snx_ser_port *port = NULL;
+	int line = SNX_SER_DEVNUM(tty);
+
+	if (line < SNX_SER_TOTAL_MAX) {
+		if (!state || !state->port)
+			return;
+
+		port = state->port;
+
+		tport = &state->tport;
+
+		down(&state->sem);
+
+		if (tty_hung_up_p(filp))
+			goto done;
+
+		if ((tty->count == 1) && (state->count != 1)) {
+			pr_info("SNX Info : tty->count is 1, state->count is %d\n",
+			state->count);
+			state->count = 1;
+		}
+
+		if (--state->count < 0) {
+			pr_info("SNX Info : bad serial port count : ttySNX%d: %d\n",
+			port->line, state->count);
+			state->count = 0;
+		}
+
+		if (state->count)
+			goto done;
+
+		tty->closing = 1;
+
+		port->suspended = 0;
+		if (state->closing_wait != SNX_USF_CLOSING_WAIT_NONE)
+			tty_wait_until_sent(tty, state->closing_wait);
+
+		if (state->info->flags & SNX_UIF_INITIALIZED) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&port->lock, flags);
+			sunix_ser_stop_rx(port);
+			spin_unlock_irqrestore(&port->lock, flags);
+
+			snx_ser_wait_until_sent(tty, port->timeout);
+		}
+
+		snx_ser_shutdown(state);
+		snx_ser_flush_buffer(tty);
+
+		if (tty->ldisc->ops->flush_buffer)
+			tty->ldisc->ops->flush_buffer(tty);
+
+		tty_port_tty_set(tport, NULL);
+
+		tty->closing = 0;
+		state->info->tty = NULL;
+
+		if (state->info->blocked_open) {
+			if (state->close_delay) {
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(state->close_delay);
+			}
+		}
+
+		state->info->flags &= ~SNX_UIF_NORMAL_ACTIVE;
+		wake_up_interruptible(&state->info->open_wait);
+
+done:
+		up(&state->sem);
+
+		module_put(THIS_MODULE);
+
+	} else {
+	}
+}
+
+
+static void sunix_ser_set_mctrl(struct snx_ser_port *port,
+unsigned int mctrl)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+	unsigned char mcr = 0;
+
+	if (sp->port.pb_info.sub_vendor_id == SUBVENID_SUN1999) {
+		if ((sp->port.AHDC_State  == 0) &&
+			(sp->port.RS422_State == 1)) {
+			if (mctrl & TIOCM_OUT1)
+				mcr |= UART_MCR_OUT1;
+
+			if (mctrl & TIOCM_OUT2)
+				mcr |= UART_MCR_OUT2;
+
+			if (mctrl & TIOCM_LOOP)
+				mcr |= UART_MCR_LOOP;
+
+			mcr = (mcr & sp->mcr_mask) | sp->mcr_force | sp->mcr;
+		} else if ((sp->port.AHDC_State == 1) &&
+			(sp->port.RS422_State == 0)) {
+
+			if (mctrl & TIOCM_OUT1)
+				mcr |= UART_MCR_OUT1;
+
+			if (mctrl & TIOCM_OUT2)
+				mcr |= UART_MCR_OUT2;
+
+			if (mctrl & TIOCM_LOOP)
+				mcr |= UART_MCR_LOOP;
+
+			mcr = (mcr & sp->mcr_mask) | sp->mcr_force | sp->mcr;
+
+		} else {
+			if (mctrl & TIOCM_RTS)
+				mcr |= UART_MCR_RTS;
+
+			if (mctrl & TIOCM_DTR)
+				mcr |= UART_MCR_DTR;
+
+			if (mctrl & TIOCM_OUT1)
+				mcr |= UART_MCR_OUT1;
+
+			if (mctrl & TIOCM_OUT2)
+				mcr |= UART_MCR_OUT2;
+
+			if (mctrl & TIOCM_LOOP)
+				mcr |= UART_MCR_LOOP;
+
+			mcr = (mcr & sp->mcr_mask) | sp->mcr_force | sp->mcr;
+		}
+	} else {
+		if (mctrl & TIOCM_RTS)
+			mcr |= UART_MCR_RTS;
+
+		if (mctrl & TIOCM_DTR)
+			mcr |= UART_MCR_DTR;
+
+		if (mctrl & TIOCM_OUT1)
+			mcr |= UART_MCR_OUT1;
+
+		if (mctrl & TIOCM_OUT2)
+			mcr |= UART_MCR_OUT2;
+
+		if (mctrl & TIOCM_LOOP)
+			mcr |= UART_MCR_LOOP;
+
+		mcr = (mcr & sp->mcr_mask) | sp->mcr_force | sp->mcr;
+	}
+
+	WRITE_UART_MCR(sp, mcr);
+}
+
+
+static unsigned int sunix_ser_tx_empty(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+	ret = READ_UART_LSR(sp) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+
+	return ret;
+}
+
+
+static unsigned int sunix_ser_get_mctrl(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+	unsigned long flags;
+	unsigned char status;
+	unsigned int ret;
+
+	ret = 0;
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+	status = READ_UART_MSR(sp);
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+
+	if (sp->port.pb_info.sub_vendor_id == SUBVENID_SUN1999) {
+		if ((sp->port.AHDC_State  == 0) &&
+			(sp->port.RS422_State == 1)) {
+			//RS422 mode : bypass DCD RI DSR CTS
+		} else if ((sp->port.AHDC_State == 1) &&
+			(sp->port.RS422_State == 0)) {
+			//RS485 mode : bypass DCD RI DSR CTS
+		} else {
+			if (status & UART_MSR_DCD)
+				ret |= TIOCM_CAR;
+
+			if (status & UART_MSR_RI)
+				ret |= TIOCM_RNG;
+
+			if (status & UART_MSR_DSR)
+				ret |= TIOCM_DSR;
+
+			if (status & UART_MSR_CTS)
+				ret |= TIOCM_CTS;
+		}
+
+	} else {
+		ret = 0;
+		if (status & UART_MSR_DCD)
+			ret |= TIOCM_CAR;
+
+		if (status & UART_MSR_RI)
+			ret |= TIOCM_RNG;
+
+		if (status & UART_MSR_DSR)
+			ret |= TIOCM_DSR;
+
+		if (status & UART_MSR_CTS)
+			ret |= TIOCM_CTS;
+	}
+	return ret;
+}
+
+
+static void sunix_ser_stop_tx(struct snx_ser_port *port, unsigned int tty_stop)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+
+	if (sp->ier & UART_IER_THRI) {
+		sp->ier &= ~UART_IER_THRI;
+		WRITE_UART_IER(sp, sp->ier);
+	}
+}
+
+
+static void sunix_ser_start_tx(struct snx_ser_port *port,
+unsigned int tty_start)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	if (!(sp->ier & UART_IER_THRI)) {
+		sp->ier |= UART_IER_THRI;
+		WRITE_UART_IER(sp, sp->ier);
+	}
+}
+
+
+static void sunix_ser_stop_rx(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	sp->ier &= ~UART_IER_RLSI;
+	sp->port.read_status_mask &= ~UART_LSR_DR;
+	WRITE_UART_IER(sp, sp->ier);
+}
+
+
+static void sunix_ser_enable_ms(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	sp->ier |= UART_IER_MSI;
+	WRITE_UART_IER(sp, sp->ier);
+}
+
+
+static void sunix_ser_break_ctl(struct snx_ser_port *port, int break_state)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+
+	if (break_state == -1)
+		sp->lcr |= UART_LCR_SBC;
+	else
+		sp->lcr &= ~UART_LCR_SBC;
+
+	WRITE_UART_LCR(sp, sp->lcr);
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+}
+
+
+static int sunix_ser_startup(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	sp->capabilities = snx_uart_config[sp->port.type].flags;
+	sp->mcr = 0;
+
+	if (sp->capabilities & UART_CLEAR_FIFO) {
+		WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO);
+		WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO |
+		UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		WRITE_UART_FCR(sp, 0);
+	}
+
+	(void) READ_UART_LSR(sp);
+	(void) READ_UART_RX(sp);
+	(void) READ_UART_IIR(sp);
+	(void) READ_UART_MSR(sp);
+
+	if (!(sp->port.flags & SNX_UPF_BUGGY_UART) &&
+		(READ_UART_LSR(sp) == 0xff)) {
+		pr_err("SNX Info : ttySNX%d: LSR safety check engaged!\n",
+		sp->port.line);
+		return -ENODEV;
+	}
+
+	WRITE_UART_LCR(sp, UART_LCR_WLEN8);
+
+	if (sp->port.snx_type == SNX_SER_PORT_SUN1699)
+		sp->ier = UART_IER_RLSI | UART_IER_RDI |
+		SUN1699_CLK_DIVIDER_DISABLE;
+	else
+		sp->ier = UART_IER_RLSI | UART_IER_RDI;
+
+
+	WRITE_UART_IER(sp, sp->ier);
+
+	(void) READ_UART_LSR(sp);
+	(void) READ_UART_RX(sp);
+	(void) READ_UART_IIR(sp);
+	(void) READ_UART_MSR(sp);
+
+	return 0;
+}
+
+
+static void sunix_ser_shutdown(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	sp->ier = 0;
+	WRITE_UART_IER(sp, 0);
+
+	WRITE_UART_LCR(sp, READ_UART_LCR(sp) & ~UART_LCR_SBC);
+
+	WRITE_UART_FCR(sp, UART_FCR_ENABLE_FIFO |
+	UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+	WRITE_UART_FCR(sp, 0);
+
+	(void) READ_UART_RX(sp);
+}
+
+
+static unsigned int sunix_ser_get_divisor(struct snx_ser_port *port,
+unsigned int baud)
+{
+	unsigned int quot;
+
+	if ((port->flags & SNX_UPF_MAGIC_MULTIPLIER) &&
+		baud == (port->uartclk/4)) {
+		quot = 0x8001;
+	} else if ((port->flags & SNX_UPF_MAGIC_MULTIPLIER) &&
+				baud == (port->uartclk/8)) {
+		quot = 0x8002;
+	} else {
+		quot = snx_ser_get_divisor(port, baud);
+	}
+
+	return quot;
+}
+
+
+static void sunix_ser_set_termios(struct snx_ser_port *port,
+struct SNXTERMIOS *termios, struct SNXTERMIOS *old)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+	unsigned char cval;
+	unsigned char fcr = 0;
+	unsigned long flags;
+	unsigned int baud;
+	unsigned int quot;
+
+		switch (termios->c_cflag & CSIZE) {
+		case CS5:
+			cval = 0x00;
+			break;
+
+		case CS6:
+			cval = 0x01;
+			break;
+
+		case CS7:
+			cval = 0x02;
+			break;
+
+		default:
+		case CS8:
+			cval = 0x03;
+			break;
+		}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |= 0x04;
+
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+
+#ifdef CMSPAR
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+
+#endif
+
+	baud = snx_ser_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
+	quot = sunix_ser_get_divisor(port, baud);
+
+	if (sp->capabilities & UART_USE_FIFO) {
+		if (baud < 2400)
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
+		else
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
+
+	}
+
+
+	if (sp->port.snx_type == SNX_SER_PORT_SUN1889) {
+		sp->mcr &= ~UART_MCR_AFE;
+
+		if (termios->c_cflag & CRTSCTS)
+			sp->mcr |= UART_MCR_AFE;
+
+		fcr |= UART_SUN1889_FCR_32BYTE;
+	} else if (sp->port.snx_type == SNX_SER_PORT_SUN1699) {
+		sp->mcr &= ~UART_MCR_AFE;
+
+		if (termios->c_cflag & CRTSCTS)
+			sp->mcr |= UART_MCR_AFE;
+
+		fcr |= UART_SUN1699_FCR_32BYTE;
+	} else if (sp->port.snx_type == SNX_SER_PORT_SUNMATX) {
+		sp->mcr &= ~UART_MCR_AFE;
+
+		if (termios->c_cflag & CRTSCTS)
+			sp->mcr |= UART_MCR_AFE;
+
+		fcr |= UART_SUNMATX_FCR_64BYTE;
+	} else if (sp->port.snx_type == SNX_SER_PORT_SUN1999) {
+		sp->mcr &= ~UART_MCR_AFE;
+
+		if (termios->c_cflag & CRTSCTS)
+			sp->mcr |= UART_MCR_AFE;
+
+		fcr |= UART_SUN1999_FCR_128BYTE;
+	} else {
+		sp->mcr &= ~UART_MCR_AFE;
+
+		if (termios->c_cflag & CRTSCTS)
+			sp->mcr |= UART_MCR_AFE;
+
+		fcr |= UART_DEFAULT_FCR;
+	}
+
+	spin_lock_irqsave(&sp->port.lock, flags);
+
+
+	snx_ser_update_timeout(port, termios->c_cflag, baud);
+
+
+	sp->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+
+	if (termios->c_iflag & INPCK)
+		sp->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		sp->port.read_status_mask |= UART_LSR_BI;
+
+	sp->port.ignore_status_mask = 0;
+
+	if (termios->c_iflag & IGNPAR)
+		sp->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+
+	if (termios->c_iflag & IGNBRK) {
+		sp->port.ignore_status_mask |= UART_LSR_BI;
+
+		if (termios->c_iflag & IGNPAR)
+			sp->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	if ((termios->c_cflag & CREAD) == 0)
+		sp->port.ignore_status_mask |= UART_LSR_DR;
+
+	sp->ier &= ~UART_IER_MSI;
+	if (SNX_ENABLE_MS(&sp->port, termios->c_cflag))
+		sp->ier |= UART_IER_MSI;
+
+
+	WRITE_UART_LCR(sp, cval | UART_LCR_DLAB);
+
+	WRITE_UART_DLL(sp, quot & 0xff);
+	WRITE_UART_DLM(sp, quot >> 8);
+
+	WRITE_UART_FCR(sp, fcr);
+
+	WRITE_UART_LCR(sp, cval);
+
+	sp->lcr = cval;
+
+	sunix_ser_set_mctrl(&sp->port, sp->port.mctrl);
+
+	WRITE_UART_IER(sp, sp->ier);
+
+	spin_unlock_irqrestore(&sp->port.lock, flags);
+}
+
+
+static void sunix_ser_timeout(struct timer_list *t)
+{
+	struct sunix_ser_port *sp = from_timer(sp, t, timer);
+
+	unsigned int timeout;
+	unsigned int iir;
+
+	iir = READ_UART_IIR(sp);
+
+	if (!(iir & UART_IIR_NO_INT)) {
+		spin_lock(&sp->port.lock);
+		sunix_ser_handle_port(sp, iir);
+		spin_unlock(&sp->port.lock);
+	}
+
+	timeout = sp->port.timeout;
+	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
+
+	mod_timer(&sp->timer, jiffies + timeout);
+}
+
+
+static _INLINE_ void sunix_ser_receive_chars(
+struct sunix_ser_port *sp, unsigned char *status)
+{
+	struct tty_struct *tty = sp->port.info->tty;
+	unsigned char ch;
+	int max_count = 256;
+	unsigned char lsr = *status;
+	char flag;
+
+	struct snx_ser_state *state = NULL;
+	struct tty_port *tport = NULL;
+
+	state = tty->driver_data;
+	tport = &state->tport;
+
+	do {
+		ch = READ_UART_RX(sp);
+		flag = TTY_NORMAL;
+		sp->port.icount.rx++;
+
+		if (unlikely(lsr & (UART_LSR_BI | UART_LSR_PE |
+		UART_LSR_FE | UART_LSR_OE)))
+
+		{
+			if (lsr & UART_LSR_BI) {
+				lsr &= ~(UART_LSR_FE | UART_LSR_PE);
+				sp->port.icount.brk++;
+
+				if (snx_ser_handle_break(&sp->port))
+					goto ignore_char;
+
+			} else if (lsr & UART_LSR_PE) {
+				sp->port.icount.parity++;
+			} else if (lsr & UART_LSR_FE) {
+				sp->port.icount.frame++;
+			}
+
+			if (lsr & UART_LSR_OE)
+				sp->port.icount.overrun++;
+
+			lsr &= sp->port.read_status_mask;
+
+			if (lsr & UART_LSR_BI)
+				flag = TTY_BREAK;
+			else if (lsr & UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (lsr & UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+
+
+		if ((I_IXOFF(tty)) || I_IXON(tty)) {
+			if (ch == START_CHAR(tty)) {
+				tty->stopped = 0;
+				sunix_ser_start_tx(&sp->port, 1);
+				goto ignore_char;
+			} else if (ch == STOP_CHAR(tty)) {
+				tty->stopped = 1;
+				sunix_ser_stop_tx(&sp->port, 1);
+				goto ignore_char;
+			}
+		}
+
+	snx_ser_insert_char(&sp->port, lsr, UART_LSR_OE, ch, flag);
+
+ignore_char:
+		lsr = READ_UART_LSR(sp);
+
+		if (lsr == 0xff)
+			lsr = 0x01;
+
+	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+
+	spin_unlock(&sp->port.lock);
+
+	tty_flip_buffer_push(tport);
+
+	spin_lock(&sp->port.lock);
+	*status = lsr;
+}
+
+
+static _INLINE_ void sunix_ser_transmit_chars(struct sunix_ser_port *sp)
+{
+	struct circ_buf *xmit = &sp->port.info->xmit;
+	int count;
+
+	if ((!sp) || (!sp->port.iobase))
+		return;
+
+
+	if (!sp->port.info)
+		return;
+
+
+	if (!xmit)
+		return;
+
+
+	if (sp->port.x_char) {
+		WRITE_UART_TX(sp, sp->port.x_char);
+		sp->port.icount.tx++;
+		sp->port.x_char = 0;
+		return;
+	}
+
+	if (snx_ser_circ_empty(xmit) || snx_ser_tx_stopped(&sp->port)) {
+		sunix_ser_stop_tx(&sp->port, 0);
+		return;
+	}
+
+	count = sp->port.fifosize;
+
+	do {
+		WRITE_UART_TX(sp, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (SNX_UART_XMIT_SIZE - 1);
+		sp->port.icount.tx++;
+
+		if (snx_ser_circ_empty(xmit))
+			break;
+
+
+	} while (--count > 0);
+
+	if (snx_ser_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		snx_ser_write_wakeup(&sp->port);
+
+}
+
+
+static _INLINE_ void sunix_ser_check_modem_status(
+struct sunix_ser_port *sp, unsigned char status)
+{
+	if ((status & UART_MSR_ANY_DELTA) == 0)
+		return;
+
+	if (!sp->port.info)
+		return;
+
+	if (status & UART_MSR_TERI)
+		sp->port.icount.rng++;
+
+	if (status & UART_MSR_DDSR)
+		sp->port.icount.dsr++;
+
+	if (status & UART_MSR_DDCD)
+		snx_ser_handle_dcd_change(&sp->port, status & UART_MSR_DCD);
+
+	if (status & UART_MSR_DCTS)
+		snx_ser_handle_cts_change(&sp->port, status & UART_MSR_CTS);
+
+	wake_up_interruptible(&sp->port.info->delta_msr_wait);
+}
+
+
+static _INLINE_ void sunix_ser_handle_port(struct sunix_ser_port *sp,
+unsigned char iir)
+{
+	unsigned char lsr = READ_UART_LSR(sp);
+	unsigned char msr = 0;
+
+	if (lsr == 0xff)
+		lsr = 0x01;
+
+
+	if ((iir == UART_IIR_RLSI) || (iir == UART_IIR_CTO) ||
+		(iir == UART_IIR_RDI))
+		sunix_ser_receive_chars(sp, &lsr);
+
+
+	if ((iir == UART_IIR_THRI) && (lsr & UART_LSR_THRE))
+		sunix_ser_transmit_chars(sp);
+
+
+	msr = READ_UART_MSR(sp);
+
+	if (msr & UART_MSR_ANY_DELTA) {
+		sunix_ser_check_modem_status(sp, msr);
+	} else {
+		if ((iir == 0x00) && (sp->port.chip_flag == SUN1699_HWID)) {
+			if (!(sp->ier & UART_IER_THRI)) {
+				sp->ier |= UART_IER_THRI;
+				WRITE_UART_IER(sp, sp->ier);
+			}
+		}
+	}
+}
+
+static const struct tty_operations sunix_tty_ops = {
+	.open               = snx_ser_open,
+	.close              = snx_ser_close,
+	.write              = snx_ser_write,
+	.put_char           = snx_ser_put_char,
+	.flush_chars        = snx_ser_flush_chars,
+	.write_room         = snx_ser_write_room,
+	.chars_in_buffer    = snx_ser_chars_in_buffer,
+	.flush_buffer       = snx_ser_flush_buffer,
+	.ioctl              = snx_ser_ioctl,
+	.throttle           = snx_ser_throttle,
+	.unthrottle         = snx_ser_unthrottle,
+	.send_xchar         = snx_ser_send_xchar,
+	.set_termios        = snx_ser_set_termios,
+	.stop               = snx_ser_stop,
+	.start              = snx_ser_start,
+	.hangup             = snx_ser_hangup,
+	.break_ctl          = snx_ser_break_ctl,
+	.wait_until_sent    = snx_ser_wait_until_sent,
+	.tiocmget           = snx_ser_tiocmget,
+	.tiocmset           = snx_ser_tiocmset,
+};
+
+extern int sunix_ser_register_driver(struct snx_ser_driver *drv)
+{
+	struct tty_driver *normal = NULL;
+	int i;
+	int ret = 0;
+
+	drv->state = kmalloc(sizeof(struct snx_ser_state) * drv->nr,
+		GFP_KERNEL);
+
+	ret = -ENOMEM;
+
+	if (!drv->state) {
+		pr_err("SNX Error: Allocate memory fail !\n\n");
+		goto out;
+	}
+
+	memset(drv->state, 0, sizeof(struct snx_ser_state) * drv->nr);
+
+	for (i = 0; i < drv->nr; i++) {
+		struct snx_ser_state *state = drv->state + i;
+		struct tty_port *tport = &state->tport;
+
+		tty_port_init(tport);
+
+		if (!state) {
+			ret = -1;
+			pr_err("SNX Error: Memory error !\n\n");
+			goto out;
+		}
+
+		state->close_delay     = 5 * HZ / 100;
+		state->closing_wait    = 3 * HZ;
+
+		sema_init(&state->sem, 1);
+	}
+
+	normal = tty_alloc_driver(SNX_SER_TOTAL_MAX + 1,
+	TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (!normal) {
+		pr_err("SNX Error: Allocate tty driver fail !\n\n");
+		goto out;
+	}
+
+	drv->tty_driver = normal;
+
+	normal->magic                   = TTY_DRIVER_MAGIC;
+	normal->name                    = drv->dev_name;
+	normal->major                   = drv->major;
+	normal->minor_start             = drv->minor;
+	normal->num                     = (SNX_SER_TOTAL_MAX + 1);
+	normal->type                    = TTY_DRIVER_TYPE_SERIAL;
+	normal->subtype                 = SERIAL_TYPE_NORMAL;
+
+	normal->init_termios            = tty_std_termios;
+	normal->init_termios.c_cflag    = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	normal->init_termios.c_iflag    = 0;
+
+	normal->driver_state            = drv;
+
+	tty_set_operations(normal, &sunix_tty_ops);
+
+	tty_port_link_device(&snx_service_port, normal, SNX_SER_TOTAL_MAX);
+
+	kref_init(&normal->kref);
+
+	ret = tty_register_driver(normal);
+
+	if (ret < 0) {
+		pr_err("SNX Error: Register tty driver fail !\n\n");
+		goto out;
+	}
+
+	for (i = 0; i < drv->nr; i++) {
+		struct snx_ser_state *state = drv->state + i;
+		struct tty_port *tport = &state->tport;
+
+		tty_port_destroy(tport);
+	}
+
+out:
+	if (ret < 0) {
+		put_tty_driver(normal);
+		kfree(drv->state);
+	}
+
+	return (ret);
+}
+
+extern void sunix_ser_unregister_driver(struct snx_ser_driver *drv)
+{
+	struct tty_driver *normal = NULL;
+
+	unsigned int i;
+
+	normal = drv->tty_driver;
+
+	if (!normal)
+		return;
+
+
+	tty_unregister_driver(normal);
+	put_tty_driver(normal);
+
+	for (i = 0; i < drv->nr; i++) {
+		struct snx_ser_state *state = drv->state + i;
+		struct tty_port *tport = &state->tport;
+
+		tty_port_destroy(tport);
+	}
+
+	drv->tty_driver = NULL;
+
+	if (drv->state)
+		kfree(drv->state);
+}
+
+
+static void sunix_ser_request_io(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	switch (sp->port.iotype) {
+	case SNX_UPIO_PORT:
+	request_region(sp->port.iobase, SNX_SER_ADDRESS_LENGTH, "snx_ser");
+	break;
+
+	default:
+	break;
+	}
+}
+
+
+static void sunix_ser_configure_port(struct snx_ser_driver *drv,
+struct snx_ser_state *state, struct snx_ser_port *port)
+{
+	unsigned long flags;
+
+	if (!port->iobase)
+		return;
+
+	flags = SNX_UART_CONFIG_TYPE;
+
+	if (port->type != PORT_UNKNOWN) {
+		sunix_ser_request_io(port);
+
+		spin_lock_irqsave(&port->lock, flags);
+
+		sunix_ser_set_mctrl(port, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+
+static int sunix_ser_add_one_port(struct snx_ser_driver *drv,
+struct snx_ser_port *port)
+{
+	struct snx_ser_state *state = NULL;
+	struct tty_port *tport;
+	struct device *tty_dev;
+
+	int ret = 0;
+
+	if (port->line >= drv->nr)
+		return -EINVAL;
+
+	state = drv->state + port->line;
+
+	tport = &state->tport;
+
+	down(&ser_port_sem);
+
+	if (state->port) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	state->port = port;
+
+	port->info = state->info;
+
+	sunix_ser_configure_port(drv, state, port);
+
+	tty_dev = tty_port_register_device(tport,
+		drv->tty_driver, port->line, port->dev);
+
+	if (likely(!IS_ERR(tty_dev)))
+		device_set_wakeup_capable(tty_dev, 1);
+	else
+		pr_info("Cannot register tty device on line %d\n",
+		port->line);
+
+out:
+	up(&ser_port_sem);
+
+	return ret;
+}
+
+
+extern int sunix_ser_register_ports(struct snx_ser_driver *drv)
+{
+	struct sunix_board *sb = NULL;
+
+	int i;
+	int ret;
+
+	sb = &sunix_board_table[0];
+
+	if (sb == NULL)
+		return 0;
+
+	pci_set_drvdata(sb->pdev, sb);
+
+	for (i = 0; i < SNX_SER_TOTAL_MAX + 1; i++) {
+		struct sunix_ser_port *sp = &sunix_ser_table[i];
+
+		if (!sp)
+			return -1;
+
+		sp->port.line = i;
+
+		if (sp->port.iobase) {
+
+			timer_setup(&sp->timer, sunix_ser_timeout, 0);
+
+			sp->mcr_mask = ~0;
+			sp->mcr_force = 0;
+
+			ret = sunix_ser_add_one_port(drv, &sp->port);
+
+			if (ret != 0)
+				return ret;
+
+		}
+	}
+
+	return 0;
+}
+
+
+static void sunix_ser_release_io(struct snx_ser_port *port)
+{
+	struct sunix_ser_port *sp = (struct sunix_ser_port *)port;
+
+	switch (sp->port.iotype) {
+	case SNX_UPIO_PORT:
+	release_region(sp->port.iobase, SNX_SER_ADDRESS_LENGTH);
+	break;
+
+	default:
+	break;
+	}
+}
+
+
+static void sunix_ser_unconfigure_port(struct snx_ser_driver *drv,
+struct snx_ser_state *state)
+{
+	struct snx_ser_port *port = state->port;
+	struct snx_ser_info *info = state->info;
+
+	if (info && info->tty)
+		tty_hangup(info->tty);
+
+	down(&state->sem);
+
+	tty_unregister_device(drv->tty_driver, port->line);
+
+	state->info = NULL;
+
+	if (port->type != PORT_UNKNOWN)
+		sunix_ser_release_io(port);
+
+	port->type = PORT_UNKNOWN;
+
+	if (info) {
+		tasklet_kill(&info->tlet);
+		kfree(info);
+	}
+
+	up(&state->sem);
+}
+
+
+static int sunix_ser_remove_one_port(struct snx_ser_driver *drv,
+struct snx_ser_port *port)
+{
+	struct snx_ser_state *state = drv->state + port->line;
+
+	if (state->port != port) {
+		pr_info("SNX Info : Removing wrong port: %p != %p\n\n",
+		state->port, port);
+	}
+
+	down(&ser_port_sem);
+
+	sunix_ser_unconfigure_port(drv, state);
+
+	state->port = NULL;
+
+	up(&ser_port_sem);
+
+	return 0;
+}
+
+
+extern void sunix_ser_unregister_ports(struct snx_ser_driver *drv)
+{
+	int i;
+
+	for (i = 0; i < SNX_SER_TOTAL_MAX + 1; i++) {
+		struct sunix_ser_port *sp = &sunix_ser_table[i];
+
+		if (sp->port.iobase)
+			sunix_ser_remove_one_port(drv, &sp->port);
+
+	}
+}
+
+extern int sunix_ser_interrupt(struct sunix_board *sb,
+struct sunix_ser_port *first_sp)
+{
+	struct sunix_ser_port *sp = NULL;
+	int i;
+	int max;
+	int irqbits;
+	int bits;
+	int pass_counter = 0;
+	unsigned char iir;
+
+	max = sb->ser_port;
+
+	if ((first_sp->port.port_flag & PORTFLAG_REMAP) == PORTFLAG_REMAP) {
+		while (1) {
+			for (i = 0; i < max; i++) {
+				sp = first_sp + i;
+
+				if (!sp->port.iobase)
+					continue;
+
+
+				iir = READ_UART_IIR(sp) & 0x0f;
+
+				if (iir & UART_IIR_NO_INT) {
+					continue;
+				} else {
+					spin_lock(&sp->port.lock);
+					sunix_ser_handle_port(sp, iir);
+					spin_unlock(&sp->port.lock);
+				}
+			}
+
+			if (pass_counter++ > INTERRUPT_COUNT)
+				break;
+
+		}
+	} else if (first_sp->port.snx_type == SNX_SER_PORT_SUN1999) {
+		while (1) {
+			irqbits = READ_1999_INTERRUPT_VECTOR_WORD
+			(sb, first_sp) & first_sp->port.vector_mask;
+
+			if (irqbits == 0x0000)
+				break;
+
+
+			for (i = 0, bits = 1; i < max; i++, bits <<= 1) {
+				if (!(bits & irqbits))
+					continue;
+
+
+			sp = first_sp + i;
+
+			iir = READ_UART_IIR(sp) & 0x0f;
+
+			if (iir & UART_IIR_NO_INT) {
+				continue;
+			} else {
+				spin_lock(&sp->port.lock);
+				sunix_ser_handle_port(sp, iir);
+				spin_unlock(&sp->port.lock);
+			}
+			}
+
+			if (pass_counter++ > INTERRUPT_COUNT)
+				break;
+
+		}
+	} else {
+		if (first_sp->port.snx_type == SNX_SER_PORT_SUNMATX) {
+			while (1) {
+				irqbits = READ_INTERRUPT_VECTOR_WORD(first_sp) &
+				first_sp->port.vector_mask;
+
+				if (irqbits == 0x0000)
+					break;
+
+
+				for (i = 0, bits = 1; i < max; i++,
+				bits <<= 1) {
+					if (!(bits & irqbits))
+						continue;
+
+
+					sp = first_sp + i;
+
+					iir = READ_UART_IIR(sp) & 0x0f;
+
+					if (iir & UART_IIR_NO_INT) {
+						continue;
+					} else {
+						spin_lock(&sp->port.lock);
+						sunix_ser_handle_port(sp, iir);
+						spin_unlock(&sp->port.lock);
+					}
+				}
+
+				if (pass_counter++ > INTERRUPT_COUNT)
+					break;
+
+			}
+		} else {
+			while (1) {
+				irqbits = READ_INTERRUPT_VECTOR_BYTE(first_sp) &
+				first_sp->port.vector_mask;
+
+				if (irqbits == 0x0000)
+					break;
+
+				for (i = 0, bits = 1; i < max; i++,
+				bits <<= 1) {
+					if (!(bits & irqbits))
+						continue;
+
+					sp = first_sp + i;
+
+					iir = READ_UART_IIR(sp) & 0x0f;
+
+					if (iir & UART_IIR_NO_INT) {
+						continue;
+					} else {
+						spin_lock(&sp->port.lock);
+						sunix_ser_handle_port(sp, iir);
+						spin_unlock(&sp->port.lock);
+					}
+				}
+
+				if (pass_counter++ > INTERRUPT_COUNT)
+					break;
+
+			}
+		}
+	}
+
+	return 0;
+}
+
+
-- 
2.17.1

