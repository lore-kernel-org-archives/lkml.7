Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63378C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B944206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn3g5UVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHPF1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:27:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPF1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:27:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so2364235pgi.6;
        Thu, 15 Aug 2019 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9KwKvFVOTDLDa3dTif1y9TmO/iIOdliqAkfkI7vRl7U=;
        b=rn3g5UVE5rddEyKxk3Lr3p0eZ6IRRzjW8bP/SArD/P0Jc2mLuTLW/yVeiqORdti1eD
         ozh+4rZjPP4AWo8Sd7uibvDFjJ9Ni6dZRgTlRfXWUuGTjozOKELRa9rW76n3iS7Wr7UH
         xvuDzk00rAgsWVe1ARiIrgBc92WkqT527T48ZwccFp1MjNkBpVKdsbE6rmIXN6FBwVHA
         tKvmD+qJxWVjNs9GMh/mQ5BglhA9zVkRib99C47Z3p+VHH8fn2GymwISGmuMBB+mG5kK
         Zy48Wj91XvrlHtPz/KfA6OOVsZ++QxyGWTmQhy3PcWiHHps8u8PSc4hTPo66SKLLX1g5
         EVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9KwKvFVOTDLDa3dTif1y9TmO/iIOdliqAkfkI7vRl7U=;
        b=Hj+5ahpS04FB5ufF5qxnAk2xoXMsc9656qWrQOAjUkmEgNhXYbhiXoQAFbVF/AiSWg
         N23a+TtK3Cgu0rbRABBe27Jn5NivT1fLJvYFNh+Zm9SH2Y+/bmOmCzycA6LQ4cro5m/J
         8/yiBJhPJtVSrS0y8uKm8d3HTjgBvw+Jr1pHoDUE7KjGg9+cTipKg+KX/5nUD95e3LZT
         66rEmmhKzacSTatjvV6a3BVZIi2OQYgrv3XI4aS7dhIuzGr8BKeMpdYdwZuZYFLm1ZKP
         syaGs7B0pvUUbT9OU9WfN4AGmU3zXh14lCuD3/KPcj0LNDAS+ZI0np4WJlgLFhFMqLLN
         EPGw==
X-Gm-Message-State: APjAAAXk4g4p4FkIiX01FBv4Glw/5p9OvrBv5FS5/BzB6o9LvKKqsMnb
        HtFzhTwCniKqyvdzcpPgPko=
X-Google-Smtp-Source: APXvYqyrgzhsmOMqVDZcKIx1w7FWNNnsTAfhDylS0OZWrVVVECOI7ke3zvkAqbm0h8V839IXlSZc3Q==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr6472743pgh.325.1565933266656;
        Thu, 15 Aug 2019 22:27:46 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id s5sm4734461pfm.97.2019.08.15.22.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 22:27:45 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, jay.dolan@accesio.com,
        andriy.shevchenko@linux.intel.com, hslester96@gmail.com,
        je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com,
        heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Date:   Fri, 16 Aug 2019 13:27:29 +0800
Message-Id: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
only support IO.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c0d10a35bf70..80737862bbef 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -43,6 +43,11 @@ struct pci_serial_quirk {
 	void	(*exit)(struct pci_dev *dev);
 };
 
+struct f815xxa_data {
+	spinlock_t lock;
+	int idx;
+};
+
 #define PCI_NUM_BAR_RESOURCES	6
 
 struct serial_private {
@@ -1707,6 +1712,77 @@ static int pci_fintek_init(struct pci_dev *dev)
 	return max_port;
 }
 
+static void f815xxa_mem_serial_out(struct uart_port *p, int offset, int value)
+{
+	struct f815xxa_data *data = p->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	writeb(value, p->membase + offset);
+	readb(p->membase + UART_SCR); /* Dummy read for flush pcie tx queue */
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int pci_fintek_f815xxa_setup(struct serial_private *priv,
+			    const struct pciserial_board *board,
+			    struct uart_8250_port *port, int idx)
+{
+	struct pci_dev *pdev = priv->dev;
+	struct f815xxa_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->idx = idx;
+	spin_lock_init(&data->lock);
+
+	port->port.private_data = data;
+	port->port.iotype = UPIO_MEM;
+	port->port.flags |= UPF_IOREMAP;
+	port->port.mapbase = pci_resource_start(pdev, 0) + 8 * idx;
+	port->port.serial_out = f815xxa_mem_serial_out;
+
+	return 0;
+}
+
+static int pci_fintek_f815xxa_init(struct pci_dev *dev)
+{
+	u32 max_port, i;
+	int config_base;
+
+	if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM))
+		return -ENODEV;
+
+	switch (dev->device) {
+	case 0x1204: /* 4 ports */
+	case 0x1208: /* 8 ports */
+		max_port = dev->device & 0xff;
+		break;
+	case 0x1212: /* 12 ports */
+		max_port = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set to mmio decode */
+	pci_write_config_byte(dev, 0x209, 0x40);
+
+	for (i = 0; i < max_port; ++i) {
+		/* UART0 configuration offset start from 0x2A0 */
+		config_base = 0x2A0 + 0x08 * i;
+
+		/* Select 128-byte FIFO and 8x FIFO threshold */
+		pci_write_config_byte(dev, config_base + 0x01, 0x33);
+
+		/* Enable UART I/O port */
+		pci_write_config_byte(dev, config_base + 0, 0x01);
+	}
+
+	return max_port;
+}
+
 static int skip_tx_en_setup(struct serial_private *priv,
 			const struct pciserial_board *board,
 			struct uart_8250_port *port, int idx)
@@ -2781,6 +2857,30 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_fintek_setup,
 		.init		= pci_fintek_init,
 	},
+	{
+		.vendor		= 0x1c29,
+		.device		= 0x1204,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fintek_f815xxa_setup,
+		.init		= pci_fintek_f815xxa_init,
+	},
+	{
+		.vendor		= 0x1c29,
+		.device		= 0x1208,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fintek_f815xxa_setup,
+		.init		= pci_fintek_f815xxa_init,
+	},
+	{
+		.vendor		= 0x1c29,
+		.device		= 0x1212,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fintek_f815xxa_setup,
+		.init		= pci_fintek_f815xxa_init,
+	},
 
 	/*
 	 * Default "match everything" terminator entry
@@ -2976,6 +3076,9 @@ enum pci_board_num_t {
 	pbn_fintek_4,
 	pbn_fintek_8,
 	pbn_fintek_12,
+	pbn_fintek_F81504A,
+	pbn_fintek_F81508A,
+	pbn_fintek_F81512A,
 	pbn_wch382_2,
 	pbn_wch384_4,
 	pbn_pericom_PI7C9X7951,
@@ -3732,6 +3835,21 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 115200,
 		.first_offset	= 0x40,
 	},
+	[pbn_fintek_F81504A] = {
+		.num_ports	= 4,
+		.uart_offset	= 8,
+		.base_baud	= 115200,
+	},
+	[pbn_fintek_F81508A] = {
+		.num_ports	= 8,
+		.uart_offset	= 8,
+		.base_baud	= 115200,
+	},
+	[pbn_fintek_F81512A] = {
+		.num_ports	= 12,
+		.uart_offset	= 8,
+		.base_baud	= 115200,
+	},
 	[pbn_wch382_2] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
@@ -5634,6 +5752,9 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
 	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12 },
+	{ PCI_DEVICE(0x1c29, 0x1204), .driver_data = pbn_fintek_F81504A },
+	{ PCI_DEVICE(0x1c29, 0x1208), .driver_data = pbn_fintek_F81508A },
+	{ PCI_DEVICE(0x1c29, 0x1212), .driver_data = pbn_fintek_F81512A },
 
 	/* MKS Tenta SCOM-080x serial cards */
 	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
-- 
2.7.4

