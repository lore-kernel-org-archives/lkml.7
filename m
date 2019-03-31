Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C0C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A387620872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8/d4OtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfCaRnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40648 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbfCaRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so8856264wre.7;
        Sun, 31 Mar 2019 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tByQwYXE87Zz9NVaIh+AKJR4F8GEoO3D3Hc06L7TYxM=;
        b=c8/d4OtRh4fQtOlwhDWL2O3bl1cDUG9WCkT1jXZe3uJJwdzv0/0IxD52PVVCdqE0rI
         OGmGg6y+kBflgrPaGJssA3aQaVn9ppn/zyc/P68xA9nXeyVlwEgAKgDfWVqyVncxfwQi
         8+vBwLmnXEum0VnwZPPfttNvQUL6NZalnJ7373uWYZFn5BvZsIwdkT5WR0bPCAyxFosY
         io9pmW5L93XVW3aPEZlwDJ6GWLVcgSEtzisPbGxpn6UTxjcxiHYfH9ED0pCDTB2z/Sy2
         HDmM23d48/mBU3j4XVilmqTQLIA1i6gYsy2vVwvB8sTKLE12HmimtE3Gesj2/VJl+DEv
         QJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tByQwYXE87Zz9NVaIh+AKJR4F8GEoO3D3Hc06L7TYxM=;
        b=nethVDB6NZkGbPz6rw1459m+w9zBqaEEH5fQ3gdSCkfIIvogPwq/46reDzAAHP1Ges
         Dcfj05xqJo9SV41RHG7teJ28dLgBXtOPaOVGiLSHpxhcsJrUwo1fr6VmEeYZdIm4QqVV
         I6N1PWTReYZI2nkVVn8qdLKgqbNQrM1S8qZlNiVLsP3L8CxRSreyEFovkm87k2n0welR
         9XXZAZlVFiYyhAomrcgGhcCmg1QAG4BFhzk0GYzDQVnJ5iQADo9Xh3ZVJXjqw0snZr3R
         OAt0sh2O/PN1NGnAL/8TywrCeNljP9GdjwsQh9K0xNeiEXjgK6gkss9Gzh5xMtuQOmj6
         n+eQ==
X-Gm-Message-State: APjAAAWzOGKwg7yNG+MaEU3QpbNXdXlV7Gj5X4TqqsYUn2TuwWj9xl5C
        J/OwNAOxaF5lSEPO9rJF6kc=
X-Google-Smtp-Source: APXvYqxB/WROpogrQ4k/l7rbJCkYmnFPL3QqI18mqkdkvCnH3KgDkfHq6HRUSS7/JkAQfRkumgPWig==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr31292539wrw.314.1554054182393;
        Sun, 31 Mar 2019 10:43:02 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:01 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 10/17] net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch
Date:   Sun, 31 Mar 2019 20:42:25 +0300
Message-Id: <20190331174232.22060-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this moment the following is supported:
* Link state management through phylib
* Autonomous L2 forwarding managed through iproute2 bridge commands. The
  switch ports are initialized in a mode where they can only talk to the
  CPU port. However, IP termination must be done currently through the
  master netdevice.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Georg Waibel <georg.waibel@sensor-technik.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS                                   |    6 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/sja1105/Kconfig               |   17 +
 drivers/net/dsa/sja1105/Makefile              |    9 +
 drivers/net/dsa/sja1105/sja1105.h             |  134 +++
 drivers/net/dsa/sja1105/sja1105_clocking.c    |  643 ++++++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  478 ++++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.h  |   40 +
 drivers/net/dsa/sja1105/sja1105_main.c        |  890 ++++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c         |  665 +++++++++++
 .../net/dsa/sja1105/sja1105_static_config.c   | 1036 +++++++++++++++++
 .../net/dsa/sja1105/sja1105_static_config.h   |  308 +++++
 13 files changed, 4229 insertions(+)
 create mode 100644 drivers/net/dsa/sja1105/Kconfig
 create mode 100644 drivers/net/dsa/sja1105/Makefile
 create mode 100644 drivers/net/dsa/sja1105/sja1105.h
 create mode 100644 drivers/net/dsa/sja1105/sja1105_clocking.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_dynamic_config.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_dynamic_config.h
 create mode 100644 drivers/net/dsa/sja1105/sja1105_main.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_spi.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_static_config.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_static_config.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 89315bb1cb83..d808520b4fa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11117,6 +11117,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
 F:	sound/soc/codecs/sgtl5000*
 
+NXP SJA1105 ETHERNET SWITCH DRIVER
+M:	Vladimir Oltean <olteanv@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/net/dsa/sja1105
+
 NXP TDA998X DRM DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 71bb3aebded4..d38e7e00c4e8 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -51,6 +51,8 @@ source "drivers/net/dsa/microchip/Kconfig"
 
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
+source "drivers/net/dsa/sja1105/Kconfig"
+
 config NET_DSA_QCA8K
 	tristate "Qualcomm Atheros QCA8K Ethernet switch family support"
 	depends on NET_DSA
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 82e5d794c41f..fefb6aaa82ba 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx.o
 obj-y				+= b53/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
+obj-y				+= sja1105/
diff --git a/drivers/net/dsa/sja1105/Kconfig b/drivers/net/dsa/sja1105/Kconfig
new file mode 100644
index 000000000000..e6bb6579a809
--- /dev/null
+++ b/drivers/net/dsa/sja1105/Kconfig
@@ -0,0 +1,17 @@
+config NET_DSA_SJA1105
+tristate "NXP SJA1105 Ethernet switch family support"
+	depends on NET_DSA && SPI
+	select NET_DSA_TAG_SJA1105
+	select NET_DSA_TAG_8021Q
+	help
+	  This is the driver for the NXP SJA1105 automotive Ethernet switch
+	  family. These are 5-port devices and are managed over an SPI
+	  interface. Probing is handled based on OF bindings and so is the
+	  linkage to phylib. The driver supports the following revisions:
+	    - SJA1105E (Gen. 1, No TT-Ethernet)
+	    - SJA1105T (Gen. 1, TT-Ethernet)
+	    - SJA1105P (Gen. 2, No SGMII, No TT-Ethernet)
+	    - SJA1105Q (Gen. 2, No SGMII, TT-Ethernet)
+	    - SJA1105R (Gen. 2, SGMII, No TT-Ethernet)
+	    - SJA1105S (Gen. 2, SGMII, TT-Ethernet)
+
diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
new file mode 100644
index 000000000000..ed00840802f4
--- /dev/null
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -0,0 +1,9 @@
+obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
+
+sja1105-objs := \
+    sja1105_spi.o \
+    sja1105_main.o \
+    sja1105_clocking.o \
+    sja1105_static_config.o \
+    sja1105_dynamic_config.o \
+
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
new file mode 100644
index 000000000000..2874423a5cd0
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2018, Sensor-Technik Wiedemann GmbH
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#ifndef _SJA1105_H
+#define _SJA1105_H
+
+#include <net/dsa.h>
+#include "sja1105_static_config.h"
+
+/* IEEE 802.3 Annex 57A: Slow Protocols PDUs (01:80:C2:xx:xx:xx) */
+#define SJA1105_LINKLOCAL_FILTER_A	0x0180C2000000ull
+#define SJA1105_LINKLOCAL_FILTER_A_MASK	0xFFFFFF000000ull
+/* IEEE 1588 Annex F: Transport of PTP over Ethernet (01:1B:19:xx:xx:xx) */
+#define SJA1105_LINKLOCAL_FILTER_B	0x011B19000000ull
+#define SJA1105_LINKLOCAL_FILTER_B_MASK	0xFFFFFF000000ull
+
+#define SJA1105_NUM_PORTS 5
+#define SJA1105_NUM_TC    8
+#define SJA1105ET_FDB_BIN_SIZE 4
+
+/* Keeps the different addresses between E/T and P/Q/R/S */
+struct sja1105_regs {
+	u64 general_status;
+	u64 rgu;
+	u64 config;
+	u64 rmii_pll1;
+	u64 pad_mii_tx[SJA1105_NUM_PORTS];
+	u64 cgu_idiv[SJA1105_NUM_PORTS];
+	u64 rgmii_pad_mii_tx[SJA1105_NUM_PORTS];
+	u64 mii_tx_clk[SJA1105_NUM_PORTS];
+	u64 mii_rx_clk[SJA1105_NUM_PORTS];
+	u64 mii_ext_tx_clk[SJA1105_NUM_PORTS];
+	u64 mii_ext_rx_clk[SJA1105_NUM_PORTS];
+	u64 rgmii_txc[SJA1105_NUM_PORTS];
+	u64 rmii_ref_clk[SJA1105_NUM_PORTS];
+	u64 rmii_ext_tx_clk[SJA1105_NUM_PORTS];
+	u64 mac[SJA1105_NUM_PORTS];
+	u64 mac_hl1[SJA1105_NUM_PORTS];
+	u64 mac_hl2[SJA1105_NUM_PORTS];
+	u64 qlevel[SJA1105_NUM_PORTS];
+};
+
+struct sja1105_private {
+	const struct sja1105_dynamic_table_ops *dyn_ops;
+	struct sja1105_static_config static_config;
+	struct gpio_desc *reset_gpio;
+	struct spi_device *spidev;
+	struct sja1105_regs *regs;
+	struct dsa_switch *ds;
+	u64 device_id;
+	u64 part_nr; /* Needed for P/R distinction (same switch core) */
+};
+
+#include "sja1105_dynamic_config.h"
+
+struct sja1105_spi_message {
+	u64 access;
+	u64 read_count;
+	u64 address;
+};
+
+enum sja1105_spi_access_mode {
+	SPI_READ = 0,
+	SPI_WRITE = 1,
+};
+
+/* From sja1105-spi.c */
+int
+sja1105_spi_send_packed_buf(const struct sja1105_private *priv,
+			    enum sja1105_spi_access_mode read_or_write,
+			    u64 reg_addr, void *packed_buf, size_t size_bytes);
+int sja1105_spi_send_int(const struct sja1105_private *priv,
+			 enum sja1105_spi_access_mode read_or_write,
+			 u64 reg_addr, u64 *value, u64 size_bytes);
+int
+sja1105_spi_send_long_packed_buf(const struct sja1105_private *priv,
+				 enum sja1105_spi_access_mode read_or_write,
+				 u64 base_addr, void *packed_buf, u64 buf_len);
+int sja1105_static_config_upload(struct sja1105_private *priv);
+int sja1105_device_id_get(struct sja1105_private *priv);
+const char *sja1105_device_id_string_get(u64 device_id, u64 part_nr);
+
+#define SIZE_SPI_MSG_HEADER    4
+#define SIZE_SPI_MSG_MAXLEN    (64 * 4)
+
+/* From sja1105-clocking.c */
+
+typedef enum {
+	XMII_MAC = 0,
+	XMII_PHY = 1,
+} sja1105_mii_mode_t;
+
+typedef enum {
+	XMII_MODE_MII		= 0,
+	XMII_MODE_RMII		= 1,
+	XMII_MODE_RGMII		= 2,
+	XMII_MODE_TRISTATE	= 3,
+} sja1105_phy_interface_t;
+
+typedef enum {
+	SJA1105_SPEED_10MBPS	= 3,
+	SJA1105_SPEED_100MBPS	= 2,
+	SJA1105_SPEED_1000MBPS	= 1,
+	SJA1105_SPEED_AUTO	= 0,
+} sja1105_speed_t;
+
+int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
+int sja1105_clocking_setup(struct sja1105_private *priv);
+
+/* From sja1105-dynamic-config.c */
+
+int sja1105_dynamic_config_read(struct sja1105_private *priv,
+				enum sja1105_blk_idx blk_idx,
+				int index, void *entry);
+int sja1105_dynamic_config_write(struct sja1105_private *priv,
+				 enum sja1105_blk_idx blk_idx,
+				 int index, void *entry, bool keep);
+void sja1105_dynamic_config_init(struct sja1105_private *priv);
+
+/* Common implementations for the static and dynamic configs */
+size_t sja1105_l2_forwarding_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op);
+size_t sja1105pqrs_l2_lookup_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op);
+size_t sja1105et_l2_lookup_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op);
+size_t sja1105_vlan_lookup_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op);
+size_t sja1105pqrs_mac_config_entry_packing(void *buf, void *entry_ptr,
+					    enum packing_op op);
+
+#endif
+
diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
new file mode 100644
index 000000000000..62259571e374
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2016-2018, NXP Semiconductors
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/packing.h>
+#include "sja1105.h"
+
+struct sja1105_cfg_pad_mii_tx {
+	u64 d32_os;
+	u64 d32_ipud;
+	u64 d10_os;
+	u64 d10_ipud;
+	u64 ctrl_os;
+	u64 ctrl_ipud;
+	u64 clk_os;
+	u64 clk_ih;
+	u64 clk_ipud;
+};
+
+/* UM10944 Table 82.
+ * IDIV_0_C to IDIV_4_C control registers
+ * (addr. 10000Bh to 10000Fh)
+ */
+struct sja1105_cgu_idiv {
+	u64 clksrc;
+	u64 autoblock;
+	u64 idiv;
+	u64 pd;
+};
+
+/* UM10944 Table 80.
+ * PLL_x_S clock status registers 0 and 1
+ * (address 100007h and 100009h)
+ */
+struct sja1105_cgu_pll_status {
+	u64 lock;
+};
+
+/* PLL_1_C control register
+ *
+ * SJA1105 E/T: UM10944 Table 81 (address 10000Ah)
+ * SJA1105 P/Q/R/S: UM11040 Table 116 (address 10000Ah)
+ */
+struct sja1105_cgu_pll_ctrl {
+	u64 pllclksrc;
+	u64 msel;
+	u64 nsel; /* Only for P/Q/R/S series */
+	u64 autoblock;
+	u64 psel;
+	u64 direct;
+	u64 fbsel;
+	u64 p23en; /* Only for P/Q/R/S series */
+	u64 bypass;
+	u64 pd;
+};
+
+#define CLKSRC_MII0_TX_CLK 0x00
+#define CLKSRC_MII0_RX_CLK 0x01
+#define CLKSRC_MII1_TX_CLK 0x02
+#define CLKSRC_MII1_RX_CLK 0x03
+#define CLKSRC_MII2_TX_CLK 0x04
+#define CLKSRC_MII2_RX_CLK 0x05
+#define CLKSRC_MII3_TX_CLK 0x06
+#define CLKSRC_MII3_RX_CLK 0x07
+#define CLKSRC_MII4_TX_CLK 0x08
+#define CLKSRC_MII4_RX_CLK 0x09
+#define CLKSRC_PLL0        0x0B
+#define CLKSRC_PLL1        0x0E
+#define CLKSRC_IDIV0       0x11
+#define CLKSRC_IDIV1       0x12
+#define CLKSRC_IDIV2       0x13
+#define CLKSRC_IDIV3       0x14
+#define CLKSRC_IDIV4       0x15
+
+/* UM10944 Table 83.
+ * MIIx clock control registers 1 to 30
+ * (addresses 100013h to 100035h)
+ */
+struct sja1105_cgu_mii_ctrl {
+	u64 clksrc;
+	u64 autoblock;
+	u64 pd;
+};
+
+static void sja1105_cgu_idiv_packing(void *buf, struct sja1105_cgu_idiv *idiv,
+				     enum packing_op op)
+{
+	const int size = 4;
+
+	if (op == UNPACK)
+		memset(idiv, 0, sizeof(*idiv));
+	else
+		memset(buf, 0, size);
+
+	sja1105_packing(buf, &idiv->clksrc,    28, 24, size, op);
+	sja1105_packing(buf, &idiv->autoblock, 11, 11, size, op);
+	sja1105_packing(buf, &idiv->idiv,       5,  2, size, op);
+	sja1105_packing(buf, &idiv->pd,         0,  0, size, op);
+}
+
+static int sja1105_cgu_idiv_config(struct sja1105_private *priv, int port,
+				   bool enabled, int factor)
+{
+#define BUF_LEN 4
+	struct device *dev = priv->ds->dev;
+	struct sja1105_cgu_idiv idiv;
+	u8 packed_buf[BUF_LEN];
+
+	if (enabled && factor != 1 && factor != 10) {
+		dev_err(dev, "idiv factor must be 1 or 10\n");
+		return -ERANGE;
+	}
+
+	/* Payload for packed_buf */
+	idiv.clksrc    = 0x0A;            /* 25MHz */
+	idiv.autoblock = 1;               /* Block clk automatically */
+	idiv.idiv      = factor - 1;      /* Divide by 1 or 10 */
+	idiv.pd        = enabled ? 0 : 1; /* Power down? */
+	sja1105_cgu_idiv_packing(packed_buf, &idiv, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->cgu_idiv[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static void
+sja1105_cgu_mii_control_packing(void *buf, struct sja1105_cgu_mii_ctrl *cmd,
+				enum packing_op op)
+{
+	const int size = 4;
+
+	if (op == UNPACK)
+		memset(cmd, 0, sizeof(*cmd));
+	else
+		memset(buf, 0, size);
+
+	sja1105_packing(buf, &cmd->clksrc,    28, 24, 4, op);
+	sja1105_packing(buf, &cmd->autoblock, 11, 11, 4, op);
+	sja1105_packing(buf, &cmd->pd,         0,  0, 4, op);
+}
+
+static int sja1105_cgu_mii_tx_clk_config(struct sja1105_private *priv,
+					 int port, sja1105_mii_mode_t mode)
+{
+#define BUF_LEN 4
+	u8 packed_buf[BUF_LEN];
+	struct  sja1105_cgu_mii_ctrl mii_tx_clk;
+	const int mac_clk_sources[] = {
+		CLKSRC_MII0_TX_CLK,
+		CLKSRC_MII1_TX_CLK,
+		CLKSRC_MII2_TX_CLK,
+		CLKSRC_MII3_TX_CLK,
+		CLKSRC_MII4_TX_CLK,
+	};
+	const int phy_clk_sources[] = {
+		CLKSRC_IDIV0,
+		CLKSRC_IDIV1,
+		CLKSRC_IDIV2,
+		CLKSRC_IDIV3,
+		CLKSRC_IDIV4,
+	};
+	int clksrc;
+
+	if (mode == XMII_MAC)
+		clksrc = mac_clk_sources[port];
+	else
+		clksrc = phy_clk_sources[port];
+
+	/* Payload for packed_buf */
+	mii_tx_clk.clksrc    = clksrc;
+	mii_tx_clk.autoblock = 1;  /* Autoblock clk while changing clksrc */
+	mii_tx_clk.pd        = 0;  /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &mii_tx_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->mii_tx_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int
+sja1105_cgu_mii_rx_clk_config(struct sja1105_private *priv, int port)
+{
+#define BUF_LEN 4
+	u8 packed_buf[BUF_LEN];
+	struct  sja1105_cgu_mii_ctrl mii_rx_clk;
+	const int clk_sources[] = {
+		CLKSRC_MII0_RX_CLK,
+		CLKSRC_MII1_RX_CLK,
+		CLKSRC_MII2_RX_CLK,
+		CLKSRC_MII3_RX_CLK,
+		CLKSRC_MII4_RX_CLK,
+	};
+
+	/* Payload for packed_buf */
+	mii_rx_clk.clksrc    = clk_sources[port];
+	mii_rx_clk.autoblock = 1;  /* Autoblock clk while changing clksrc */
+	mii_rx_clk.pd        = 0;  /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &mii_rx_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->mii_rx_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int
+sja1105_cgu_mii_ext_tx_clk_config(struct sja1105_private *priv, int port)
+{
+#define BUF_LEN 4
+	u8 packed_buf[BUF_LEN];
+	struct  sja1105_cgu_mii_ctrl mii_ext_tx_clk;
+	const int clk_sources[] = {
+		CLKSRC_IDIV0,
+		CLKSRC_IDIV1,
+		CLKSRC_IDIV2,
+		CLKSRC_IDIV3,
+		CLKSRC_IDIV4,
+	};
+
+	/* Payload for packed_buf */
+	mii_ext_tx_clk.clksrc    = clk_sources[port];
+	mii_ext_tx_clk.autoblock = 1; /* Autoblock clk while changing clksrc */
+	mii_ext_tx_clk.pd        = 0; /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &mii_ext_tx_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->mii_ext_tx_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int
+sja1105_cgu_mii_ext_rx_clk_config(struct sja1105_private *priv, int port)
+{
+#define BUF_LEN 4
+	u8 packed_buf[BUF_LEN];
+	struct  sja1105_cgu_mii_ctrl mii_ext_rx_clk;
+	const int clk_sources[] = {
+		CLKSRC_IDIV0,
+		CLKSRC_IDIV1,
+		CLKSRC_IDIV2,
+		CLKSRC_IDIV3,
+		CLKSRC_IDIV4,
+	};
+
+	/* Payload for packed_buf */
+	mii_ext_rx_clk.clksrc    = clk_sources[port];
+	mii_ext_rx_clk.autoblock = 1; /* Autoblock clk while changing clksrc */
+	mii_ext_rx_clk.pd        = 0; /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &mii_ext_rx_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->mii_ext_rx_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int mii_clocking_setup(struct sja1105_private *priv, int port,
+			      sja1105_mii_mode_t mode)
+{
+	struct device *dev = priv->ds->dev;
+	int rc;
+
+	dev_dbg(dev, "Configuring MII-%s clocking\n",
+		(mode == XMII_MAC) ? "MAC" : "PHY");
+	/* If mode is MAC, disable IDIV
+	 * If mode is PHY, enable IDIV and configure for 1/1 divider
+	 */
+	rc = sja1105_cgu_idiv_config(priv, port, (mode == XMII_PHY), 1);
+	if (rc < 0)
+		return rc;
+
+	/* Configure CLKSRC of MII_TX_CLK_n
+	 *   * If mode is MAC, select TX_CLK_n
+	 *   * If mode is PHY, select IDIV_n
+	 */
+	rc = sja1105_cgu_mii_tx_clk_config(priv, port, mode);
+	if (rc < 0)
+		return rc;
+
+	/* Configure CLKSRC of MII_RX_CLK_n
+	 * Select RX_CLK_n
+	 */
+	rc = sja1105_cgu_mii_rx_clk_config(priv, port);
+	if (rc < 0)
+		return rc;
+
+	if (mode == XMII_PHY) {
+		/* Per MII spec, the PHY (which is us) drives the TX_CLK pin */
+
+		/* Configure CLKSRC of EXT_TX_CLK_n
+		 * Select IDIV_n
+		 */
+		rc = sja1105_cgu_mii_ext_tx_clk_config(priv, port);
+		if (rc < 0)
+			return rc;
+
+		/* Configure CLKSRC of EXT_RX_CLK_n
+		 * Select IDIV_n
+		 */
+		rc = sja1105_cgu_mii_ext_rx_clk_config(priv, port);
+		if (rc < 0)
+			return rc;
+	}
+	return 0;
+}
+
+static void
+sja1105_cgu_pll_control_packing(void *buf, struct sja1105_cgu_pll_ctrl *cmd,
+				enum packing_op op)
+{
+	const int size = 4;
+
+	if (op == UNPACK)
+		memset(cmd, 0, sizeof(*cmd));
+	else
+		memset(buf, 0, size);
+
+	sja1105_packing(buf, &cmd->pllclksrc, 28, 24, size, op);
+	sja1105_packing(buf, &cmd->msel,      23, 16, size, op);
+	sja1105_packing(buf, &cmd->autoblock, 11, 11, size, op);
+	sja1105_packing(buf, &cmd->psel,       9,  8, size, op);
+	sja1105_packing(buf, &cmd->direct,     7,  7, size, op);
+	sja1105_packing(buf, &cmd->fbsel,      6,  6, size, op);
+	sja1105_packing(buf, &cmd->bypass,     1,  1, size, op);
+	sja1105_packing(buf, &cmd->pd,         0,  0, size, op);
+	/* P/Q/R/S only, but packing zeroes for E/T doesn't hurt */
+	sja1105_packing(buf, &cmd->nsel,      13, 12, size, op);
+	sja1105_packing(buf, &cmd->p23en,      2,  2, size, op);
+}
+
+static int sja1105_cgu_rgmii_tx_clk_config(struct sja1105_private *priv,
+					   int port, sja1105_speed_t speed)
+{
+#define BUF_LEN 4
+	struct sja1105_cgu_mii_ctrl txc;
+	u8 packed_buf[BUF_LEN];
+	int clksrc;
+
+	if (speed == SJA1105_SPEED_1000MBPS) {
+		clksrc = CLKSRC_PLL0;
+	} else {
+		int clk_sources[] = {CLKSRC_IDIV0, CLKSRC_IDIV1, CLKSRC_IDIV2,
+				     CLKSRC_IDIV3, CLKSRC_IDIV4};
+		clksrc = clk_sources[port];
+	}
+
+	/* RGMII: 125MHz for 1000, 25MHz for 100, 2.5MHz for 10 */
+	txc.clksrc = clksrc;
+	/* Autoblock clk while changing clksrc */
+	txc.autoblock = 1;
+	/* Power Down off => enabled */
+	txc.pd = 0;
+	sja1105_cgu_mii_control_packing(packed_buf, &txc, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->rgmii_txc[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+/* AGU */
+static void
+sja1105_cfg_pad_mii_tx_packing(void *buf, struct sja1105_cfg_pad_mii_tx *cmd,
+			       enum packing_op op)
+{
+	const int size = 4;
+
+	if (op == UNPACK)
+		memset(cmd, 0, sizeof(*cmd));
+	else
+		memset(buf, 0, size);
+
+	sja1105_packing(buf, &cmd->d32_os,   28, 27, size, op);
+	sja1105_packing(buf, &cmd->d32_ipud, 25, 24, size, op);
+	sja1105_packing(buf, &cmd->d10_os,   20, 19, size, op);
+	sja1105_packing(buf, &cmd->d10_ipud, 17, 16, size, op);
+	sja1105_packing(buf, &cmd->ctrl_os,  12, 11, size, op);
+	sja1105_packing(buf, &cmd->ctrl_ipud, 9,  8, size, op);
+	sja1105_packing(buf, &cmd->clk_os,    4,  3, size, op);
+	sja1105_packing(buf, &cmd->clk_ih,    2,  2, size, op);
+	sja1105_packing(buf, &cmd->clk_ipud,  1,  0, size, op);
+}
+
+static int sja1105_rgmii_cfg_pad_tx_config(struct sja1105_private *priv,
+					   int port)
+{
+#define BUF_LEN 4
+	u8 packed_buf[BUF_LEN];
+	struct  sja1105_cfg_pad_mii_tx pad_mii_tx;
+
+	/* Payload */
+	pad_mii_tx.d32_os    = 3; /* TXD[3:2] output stage: */
+				  /*          high noise/high speed */
+	pad_mii_tx.d32_ipud  = 2; /* TXD[3:2] input stage: */
+				  /*          plain input (default) */
+	pad_mii_tx.d10_os    = 3; /* TXD[1:0] output stage: */
+				  /*          high noise/high speed */
+	pad_mii_tx.d10_ipud  = 2; /* TXD[1:0] input stage: */
+				  /*          plain input (default) */
+	pad_mii_tx.ctrl_os   = 3; /* TX_CTL / TX_ER output stage */
+	pad_mii_tx.ctrl_ipud = 2; /* TX_CTL / TX_ER input stage (default) */
+	pad_mii_tx.clk_os    = 3; /* TX_CLK output stage */
+	pad_mii_tx.clk_ih    = 0; /* TX_CLK input hysteresis (default) */
+	pad_mii_tx.clk_ipud  = 2; /* TX_CLK input stage (default) */
+	sja1105_cfg_pad_mii_tx_packing(packed_buf, &pad_mii_tx, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->rgmii_pad_mii_tx[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int rgmii_clocking_setup(struct sja1105_private *priv, int port)
+{
+	struct device *dev = priv->ds->dev;
+	struct sja1105_table *mac;
+	sja1105_speed_t speed;
+	int rc;
+
+	mac = &priv->static_config.tables[BLK_IDX_MAC_CONFIG];
+	speed = ((struct sja1105_mac_config_entry *)mac->entries)[port].speed;
+
+	dev_dbg(dev, "Configuring port %d RGMII at speed %dMbps\n",
+		port, speed);
+
+	switch (speed) {
+	case SJA1105_SPEED_1000MBPS:
+		/* 1000Mbps, IDIV disabled, divide by 1 */
+		rc = sja1105_cgu_idiv_config(priv, port, false, 1);
+		break;
+	case SJA1105_SPEED_100MBPS:
+		/* 100Mbps, IDIV enabled, divide by 1 */
+		rc = sja1105_cgu_idiv_config(priv, port, true, 1);
+		break;
+	case SJA1105_SPEED_10MBPS:
+		/* 10Mbps, IDIV enabled, divide by 10 */
+		rc = sja1105_cgu_idiv_config(priv, port, true, 10);
+		break;
+	case SJA1105_SPEED_AUTO:
+		/* Skip CGU configuration if there is no speed available
+		 * (e.g. link is not established yet)
+		 */
+		dev_dbg(dev, "Speed not available, skipping CGU config\n");
+		return 0;
+	default:
+		rc = -EINVAL;
+	}
+
+	if (rc < 0) {
+		dev_err(dev, "Failed to configure idiv\n");
+		return rc;
+	}
+	rc = sja1105_cgu_rgmii_tx_clk_config(priv, port, speed);
+	if (rc < 0) {
+		dev_err(dev, "Failed to configure RGMII Tx clock\n");
+		return rc;
+	}
+	rc = sja1105_rgmii_cfg_pad_tx_config(priv, port);
+	if (rc < 0) {
+		dev_err(dev, "Failed to configure Tx pad registers\n");
+		return rc;
+	}
+	return 0;
+}
+
+static int sja1105_cgu_rmii_ref_clk_config(struct sja1105_private *priv,
+					   int port)
+{
+#define BUF_LEN 4
+	struct  sja1105_cgu_mii_ctrl ref_clk;
+	u8 packed_buf[BUF_LEN];
+	const int clk_sources[] = {
+		CLKSRC_MII0_TX_CLK,
+		CLKSRC_MII1_TX_CLK,
+		CLKSRC_MII2_TX_CLK,
+		CLKSRC_MII3_TX_CLK,
+		CLKSRC_MII4_TX_CLK,
+	};
+
+	/* Payload for packed_buf */
+	ref_clk.clksrc    = clk_sources[port];
+	ref_clk.autoblock = 1;      /* Autoblock clk while changing clksrc */
+	ref_clk.pd        = 0;      /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &ref_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->rmii_ref_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int
+sja1105_cgu_rmii_ext_tx_clk_config(struct sja1105_private *priv, int port)
+{
+#define BUF_LEN 4
+	struct sja1105_cgu_mii_ctrl ext_tx_clk;
+	u8 packed_buf[BUF_LEN];
+
+	/* Payload for packed_buf */
+	ext_tx_clk.clksrc    = CLKSRC_PLL1;
+	ext_tx_clk.autoblock = 1;   /* Autoblock clk while changing clksrc */
+	ext_tx_clk.pd        = 0;   /* Power Down off => enabled */
+	sja1105_cgu_mii_control_packing(packed_buf, &ext_tx_clk, PACK);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					   priv->regs->rmii_ext_tx_clk[port],
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int sja1105_cgu_rmii_pll_config(struct sja1105_private *priv)
+{
+#define BUF_LEN 4
+	struct device *dev = priv->ds->dev;
+	struct sja1105_cgu_pll_ctrl pll;
+	u8 packed_buf[BUF_LEN];
+	int rc;
+
+	/* PLL1 must be enabled and output 50 Mhz.
+	 * This is done by writing first 0x0A010941 to
+	 * the PLL_1_C register and then deasserting
+	 * power down (PD) 0x0A010940.
+	 */
+
+	/* Step 1: PLL1 setup for 50Mhz */
+	pll.pllclksrc = 0xA;
+	pll.msel      = 0x1;
+	pll.autoblock = 0x1;
+	pll.psel      = 0x1;
+	pll.direct    = 0x0;
+	pll.fbsel     = 0x1;
+	pll.bypass    = 0x0;
+	pll.pd        = 0x1;
+	/* P/Q/R/S only */
+	pll.nsel      = 0x0; /* PLL pre-divider is 1 (nsel + 1) */
+	pll.p23en     = 0x0; /* disable 120 and 240 degree phase PLL outputs */
+
+	sja1105_cgu_pll_control_packing(packed_buf, &pll, PACK);
+	rc = sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					 priv->regs->rmii_pll1,
+					 packed_buf, BUF_LEN);
+	if (rc < 0) {
+		dev_err(dev, "failed to configure PLL1 for 50MHz\n");
+		return rc;
+	}
+
+	/* Step 2: Enable PLL1 */
+	pll.pd = 0x0;
+
+	sja1105_cgu_pll_control_packing(packed_buf, &pll, PACK);
+	rc = sja1105_spi_send_packed_buf(priv, SPI_WRITE,
+					 priv->regs->rmii_pll1,
+					 packed_buf, BUF_LEN);
+	if (rc < 0) {
+		dev_err(dev, "failed to enable PLL1\n");
+		return rc;
+	}
+	return rc;
+#undef BUF_LEN
+}
+
+static int rmii_clocking_setup(struct sja1105_private *priv, int port,
+			       sja1105_mii_mode_t mode)
+{
+	struct device *dev = priv->ds->dev;
+	int rc;
+
+	dev_dbg(dev, "Configuring RMII-%s clocking\n",
+		(mode == XMII_MAC) ? "MAC" : "PHY");
+	/* AH1601.pdf chapter 2.5.1. Sources */
+	if (mode == XMII_MAC) {
+		/* Configure and enable PLL1 for 50Mhz output */
+		rc = sja1105_cgu_rmii_pll_config(priv);
+		if (rc < 0)
+			return rc;
+	}
+	/* Disable IDIV for this port */
+	rc = sja1105_cgu_idiv_config(priv, port, false, 1);
+	if (rc < 0)
+		return rc;
+	/* Source to sink mappings */
+	rc = sja1105_cgu_rmii_ref_clk_config(priv, port);
+	if (rc < 0)
+		return rc;
+	if (mode == XMII_MAC) {
+		rc = sja1105_cgu_rmii_ext_tx_clk_config(priv, port);
+		if (rc < 0)
+			return rc;
+	}
+	return 0;
+}
+
+int sja1105_clocking_setup_port(struct sja1105_private *priv, int port)
+{
+	struct sja1105_xmii_params_entry *mii;
+	struct device *dev = priv->ds->dev;
+	sja1105_phy_interface_t phy_mode;
+	sja1105_mii_mode_t mode;
+	int rc;
+
+	mii = priv->static_config.tables[BLK_IDX_XMII_PARAMS].entries;
+
+	/* RGMII etc */
+	phy_mode = mii->xmii_mode[port];
+	/* MAC or PHY, for applicable types (not RGMII) */
+	mode = mii->phy_mac[port];
+
+	switch (phy_mode) {
+	case XMII_MODE_MII:
+		rc = mii_clocking_setup(priv, port, mode);
+		break;
+	case XMII_MODE_RMII:
+		rc = rmii_clocking_setup(priv, port, mode);
+		break;
+	case XMII_MODE_RGMII:
+		rc = rgmii_clocking_setup(priv, port);
+		break;
+	default:
+		dev_err(dev, "Invalid interface mode specified: %d\n",
+			phy_mode);
+		return -EINVAL;
+	}
+	if (rc)
+		dev_err(dev, "Clocking setup for port %d failed: %d\n",
+			port, rc);
+	return rc;
+}
+
+int sja1105_clocking_setup(struct sja1105_private *priv)
+{
+	int port, rc;
+
+	for (port = 0; port < SJA1105_NUM_PORTS; port++) {
+		rc = sja1105_clocking_setup_port(priv, port);
+		if (rc < 0)
+			return rc;
+	}
+	return 0;
+}
+
diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
new file mode 100644
index 000000000000..4f3756e267ac
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include "sja1105.h"
+
+#define SIZE_DYN_CMD                     4
+#define SIZE_MAC_CONFIG_DYN_ENTRY_ET     SIZE_DYN_CMD
+#define SIZE_L2_LOOKUP_DYN_CMD_ET       (SIZE_DYN_CMD + SIZE_L2_LOOKUP_ENTRY_ET)
+#define SIZE_L2_LOOKUP_DYN_CMD_PQRS     (SIZE_DYN_CMD + SIZE_L2_LOOKUP_ENTRY_PQRS)
+#define SIZE_VLAN_LOOKUP_DYN_CMD        (SIZE_DYN_CMD + 4 + SIZE_VLAN_LOOKUP_ENTRY)
+#define SIZE_L2_FORWARDING_DYN_CMD      (SIZE_DYN_CMD + SIZE_L2_FORWARDING_ENTRY)
+#define SIZE_MAC_CONFIG_DYN_CMD_ET      (SIZE_DYN_CMD + SIZE_MAC_CONFIG_DYN_ENTRY_ET)
+#define SIZE_MAC_CONFIG_DYN_CMD_PQRS    (SIZE_DYN_CMD + SIZE_MAC_CONFIG_ENTRY_PQRS)
+#define SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET SIZE_DYN_CMD
+#define SIZE_GENERAL_PARAMS_DYN_CMD_ET   SIZE_DYN_CMD
+#define MAX_DYN_CMD_SIZE                 SIZE_MAC_CONFIG_DYN_CMD_PQRS
+
+static void
+sja1105pqrs_l2_lookup_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				  enum packing_op op)
+{
+	u8 *p = buf + SIZE_L2_LOOKUP_ENTRY_PQRS;
+
+	sja1105_packing(p, &cmd->valid,    31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->rdwrset,  30, 30, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->errors,   29, 29, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->valident, 27, 27, SIZE_DYN_CMD, op);
+	/* Hack - The hardware takes the 'index' field within
+	 * struct sja1105_l2_lookup_entry as the index on which this command
+	 * will operate. However it will ignore everything else, so 'index'
+	 * is logically part of command but physically part of entry.
+	 * Populate the 'index' entry field from within the command callback,
+	 * such that our API doesn't need to ask for a full-blown entry
+	 * structure when e.g. a delete is requested.
+	 */
+	sja1105_packing(buf, &cmd->index, 29, 20, SIZE_L2_LOOKUP_ENTRY_PQRS, op);
+	/* TODO hostcmd */
+}
+
+static void
+sja1105et_l2_lookup_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				enum packing_op op)
+{
+	u8 *p = buf + SIZE_L2_LOOKUP_ENTRY_ET;
+
+	sja1105_packing(p, &cmd->valid,    31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->rdwrset,  30, 30, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->errors,   29, 29, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->valident, 27, 27, SIZE_DYN_CMD, op);
+	/* Hack - see comments above. */
+	sja1105_packing(buf, &cmd->index, 29, 20, SIZE_L2_LOOKUP_ENTRY_ET, op);
+}
+
+static void
+sja1105et_mgmt_route_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				 enum packing_op op)
+{
+	u8 *p = buf + SIZE_L2_LOOKUP_ENTRY_ET;
+	u64 mgmtroute = 1;
+
+	sja1105et_l2_lookup_cmd_packing(buf, cmd, op);
+	if (op == PACK)
+		sja1105_pack(p, &mgmtroute, 26, 26, SIZE_DYN_CMD);
+}
+
+static size_t sja1105et_mgmt_route_entry_packing(void *buf, void *entry_ptr,
+						 enum packing_op op)
+{
+	struct sja1105_mgmt_entry *entry = entry_ptr;
+	const size_t size = SIZE_L2_LOOKUP_ENTRY_ET;
+
+	/* UM10944: To specify if a PTP egress timestamp shall be captured on
+	 * each port upon transmission of the frame, the LSB of VLANID in the
+	 * ENTRY field provided by the host must be set.
+	 * Bit 1 of VLANID then specifies the register where the timestamp for
+	 * this port is stored in.
+	 */
+	sja1105_packing(buf, &entry->tsreg,     85, 85, size, op);
+	sja1105_packing(buf, &entry->takets,    84, 84, size, op);
+	sja1105_packing(buf, &entry->macaddr,   83, 36, size, op);
+	sja1105_packing(buf, &entry->destports, 35, 31, size, op);
+	sja1105_packing(buf, &entry->enfport,   30, 30, size, op);
+	return size;
+}
+
+/* In E/T, entry is at addresses 0x27-0x28. There is a 4 byte gap at 0x29,
+ * and command is at 0x2a. Similarly in P/Q/R/S there is a 1 register gap
+ * between entry (0x2d, 0x2e) and command (0x30).
+ */
+static void
+sja1105_vlan_lookup_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				enum packing_op op)
+{
+	u8 *p = buf + SIZE_VLAN_LOOKUP_ENTRY + 4;
+
+	sja1105_packing(p, &cmd->valid,    31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->rdwrset,  30, 30, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->valident, 27, 27, SIZE_DYN_CMD, op);
+	/* Hack - see comments above, applied for 'vlanid' field of
+	 * struct sja1105_vlan_lookup_entry.
+	 */
+	sja1105_packing(buf, &cmd->index, 38, 27, SIZE_VLAN_LOOKUP_ENTRY, op);
+}
+
+static void
+sja1105_l2_forwarding_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				  enum packing_op op)
+{
+	u8 *p = buf + SIZE_L2_FORWARDING_ENTRY;
+
+	sja1105_packing(p, &cmd->valid,   31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->errors,  30, 30, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->rdwrset, 29, 29, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->index,    4,  0, SIZE_DYN_CMD, op);
+}
+
+static void
+sja1105et_mac_config_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				 enum packing_op op)
+{
+	/* Yup, user manual definitions are reversed */
+	u8 *reg1 = buf + 4;
+
+	sja1105_packing(reg1, &cmd->valid, 31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(reg1, &cmd->index, 26, 24, SIZE_DYN_CMD, op);
+}
+
+static size_t sja1105et_mac_config_entry_packing(void *buf, void *entry_ptr,
+						 enum packing_op op)
+{
+	struct sja1105_mac_config_entry *entry = entry_ptr;
+	const int size = SIZE_MAC_CONFIG_DYN_ENTRY_ET;
+	/* Yup, user manual definitions are reversed */
+	u8 *reg1 = buf + 4;
+	u8 *reg2 = buf;
+
+	sja1105_packing(reg1, &entry->speed,     30, 29, size, op);
+	sja1105_packing(reg1, &entry->drpdtag,   23, 23, size, op);
+	sja1105_packing(reg1, &entry->drpuntag,  22, 22, size, op);
+	sja1105_packing(reg1, &entry->retag,     21, 21, size, op);
+	sja1105_packing(reg1, &entry->dyn_learn, 20, 20, size, op);
+	sja1105_packing(reg1, &entry->egress,    19, 19, size, op);
+	sja1105_packing(reg1, &entry->ingress,   18, 18, size, op);
+	sja1105_packing(reg1, &entry->ing_mirr,  17, 17, size, op);
+	sja1105_packing(reg1, &entry->egr_mirr,  16, 16, size, op);
+	sja1105_packing(reg1, &entry->vlanprio,  14, 12, size, op);
+	sja1105_packing(reg1, &entry->vlanid,    11,  0, size, op);
+	sja1105_packing(reg2, &entry->tp_delin,  31, 16, size, op);
+	sja1105_packing(reg2, &entry->tp_delout, 15,  0, size, op);
+	/* MAC configuration table entries which can't be reconfigured:
+	 * top, base, enabled, ifg, maxage, drpnona664
+	 */
+	/* Bogus return value, not used anywhere */
+	return 0;
+}
+
+static void
+sja1105pqrs_mac_config_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				   enum packing_op op)
+{
+	u8 *p = buf + SIZE_MAC_CONFIG_ENTRY_PQRS;
+
+	sja1105_packing(p, &cmd->valid,   31, 31, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->errors,  30, 30, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->rdwrset, 29, 29, SIZE_DYN_CMD, op);
+	sja1105_packing(p, &cmd->index,    2,  0, SIZE_DYN_CMD, op);
+}
+
+static void
+sja1105et_l2_lookup_params_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				       enum packing_op op)
+{
+	sja1105_packing(buf, &cmd->valid, 31, 31,
+			SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET, op);
+}
+
+static size_t
+sja1105et_l2_lookup_params_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op)
+{
+	struct sja1105_l2_lookup_params_entry *entry = entry_ptr;
+
+	sja1105_packing(buf, &entry->poly, 7, 0,
+			SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET, op);
+	/* Bogus return value, not used anywhere */
+	return 0;
+}
+
+static void
+sja1105et_general_params_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
+				     enum packing_op op)
+{
+	const int size = SIZE_GENERAL_PARAMS_DYN_CMD_ET;
+
+	sja1105_packing(buf, &cmd->valid,  31, 31, size, op);
+	sja1105_packing(buf, &cmd->errors, 30, 30, size, op);
+}
+
+static size_t
+sja1105et_general_params_entry_packing(void *buf, void *entry_ptr,
+				       enum packing_op op)
+{
+	struct sja1105_general_params_entry *entry = entry_ptr;
+	const int size = SIZE_GENERAL_PARAMS_DYN_CMD_ET;
+
+	sja1105_packing(buf, &entry->mirr_port, 2, 0, size, op);
+	/* Bogus return value, not used anywhere */
+	return 0;
+}
+
+#define OP_READ  BIT(0)
+#define OP_WRITE BIT(1)
+#define OP_DEL   BIT(2)
+
+/* SJA1105E/T: First generation */
+static struct sja1105_dynamic_table_ops sja1105et_table_ops[BLK_IDX_MAX_DYN] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.entry_packing = sja1105et_l2_lookup_entry_packing,
+		.cmd_packing = sja1105et_l2_lookup_cmd_packing,
+		.access = (OP_READ | OP_WRITE | OP_DEL),
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+		.packed_size = SIZE_L2_LOOKUP_DYN_CMD_ET,
+		.addr = 0x20,
+	},
+	[BLK_IDX_MGMT_ROUTE] = {
+		.entry_packing = sja1105et_mgmt_route_entry_packing,
+		.cmd_packing = sja1105et_mgmt_route_cmd_packing,
+		.access = (OP_READ | OP_WRITE),
+		.max_entry_count = SJA1105_NUM_PORTS,
+		.packed_size = SIZE_L2_LOOKUP_DYN_CMD_ET,
+		.addr = 0x20,
+	},
+	[BLK_IDX_L2_POLICING] = { 0 },
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.entry_packing = sja1105_vlan_lookup_entry_packing,
+		.cmd_packing = sja1105_vlan_lookup_cmd_packing,
+		.access = (OP_WRITE | OP_DEL),
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+		.packed_size = SIZE_VLAN_LOOKUP_DYN_CMD,
+		.addr = 0x27,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.entry_packing = sja1105_l2_forwarding_entry_packing,
+		.cmd_packing = sja1105_l2_forwarding_cmd_packing,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_L2_FORWARDING_DYN_CMD,
+		.addr = 0x24,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.entry_packing = sja1105et_mac_config_entry_packing,
+		.cmd_packing = sja1105et_mac_config_cmd_packing,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_MAC_CONFIG_DYN_CMD_ET,
+		.addr = 0x36,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.entry_packing = sja1105et_l2_lookup_params_entry_packing,
+		.cmd_packing = sja1105et_l2_lookup_params_cmd_packing,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET,
+		.addr = 0x38,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = { 0 },
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.entry_packing = sja1105et_general_params_entry_packing,
+		.cmd_packing = sja1105et_general_params_cmd_packing,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_GENERAL_PARAMS_DYN_CMD_ET,
+		.addr = 0x34,
+	},
+	[BLK_IDX_XMII_PARAMS] = { 0 },
+};
+
+/* SJA1105P/Q/R/S: Second generation: TODO */
+static struct sja1105_dynamic_table_ops sja1105pqrs_table_ops[BLK_IDX_MAX_DYN] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.entry_packing = sja1105pqrs_l2_lookup_entry_packing,
+		.cmd_packing = sja1105pqrs_l2_lookup_cmd_packing,
+		.access = (OP_READ | OP_WRITE | OP_DEL),
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+		.packed_size = SIZE_L2_LOOKUP_DYN_CMD_ET,
+		.addr = 0x24,
+	},
+	[BLK_IDX_L2_POLICING] = { 0 },
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.entry_packing = sja1105_vlan_lookup_entry_packing,
+		.cmd_packing = sja1105_vlan_lookup_cmd_packing,
+		.access = (OP_READ | OP_WRITE | OP_DEL),
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+		.packed_size = SIZE_VLAN_LOOKUP_DYN_CMD,
+		.addr = 0x2D,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.entry_packing = sja1105_l2_forwarding_entry_packing,
+		.cmd_packing = sja1105_l2_forwarding_cmd_packing,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_L2_FORWARDING_DYN_CMD,
+		.addr = 0x2A,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.entry_packing = sja1105pqrs_mac_config_entry_packing,
+		.cmd_packing = sja1105pqrs_mac_config_cmd_packing,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+		.access = (OP_READ | OP_WRITE),
+		.packed_size = SIZE_MAC_CONFIG_DYN_CMD_PQRS,
+		.addr = 0x4B,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.entry_packing = sja1105et_l2_lookup_params_entry_packing,
+		.cmd_packing = sja1105et_l2_lookup_params_cmd_packing,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+		.access = (OP_READ | OP_WRITE),
+		.packed_size = SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET,
+		.addr = 0x38,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = { 0 },
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.entry_packing = sja1105et_general_params_entry_packing,
+		.cmd_packing = sja1105et_general_params_cmd_packing,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+		.access = OP_WRITE,
+		.packed_size = SIZE_GENERAL_PARAMS_DYN_CMD_ET,
+		.addr = 0x34,
+	},
+	[BLK_IDX_XMII_PARAMS] = { 0 },
+};
+
+int sja1105_dynamic_config_read(struct sja1105_private *priv,
+				enum sja1105_blk_idx blk_idx,
+				int index, void *entry)
+{
+	const struct sja1105_dynamic_table_ops *ops;
+	struct sja1105_dyn_cmd cmd = { 0 };
+	/* SPI payload buffer */
+	u8 packed_buf[MAX_DYN_CMD_SIZE];
+	int retries = 3;
+	int rc;
+
+	if (blk_idx >= BLK_IDX_MAX_DYN)
+		return -ERANGE;
+
+	ops = &priv->dyn_ops[blk_idx];
+
+	if (index >= ops->max_entry_count)
+		return -ERANGE;
+	if (!(ops->access & OP_READ))
+		return -EOPNOTSUPP;
+	if (ops->packed_size > MAX_DYN_CMD_SIZE)
+		return -ERANGE;
+	if (!ops->cmd_packing)
+		return -EOPNOTSUPP;
+	if (!ops->entry_packing)
+		return -EOPNOTSUPP;
+
+	memset(packed_buf, 0, ops->packed_size);
+
+	cmd.valid = true; /* Trigger action on table entry */
+	cmd.rdwrset = SPI_READ; /* Action is read */
+	cmd.index = index;
+	ops->cmd_packing(packed_buf, &cmd, PACK);
+
+	/* Send SPI write operation: read config table entry */
+	rc = sja1105_spi_send_packed_buf(priv, SPI_WRITE, ops->addr,
+					 packed_buf, ops->packed_size);
+	if (rc < 0)
+		return rc;
+
+	/* Loop until we have confirmation that hardware has finished
+	 * processing the command and has cleared the VALID field
+	 */
+	do {
+		memset(packed_buf, 0, ops->packed_size);
+
+		/* Retrieve the read operation's result */
+		rc = sja1105_spi_send_packed_buf(priv, SPI_READ, ops->addr,
+						 packed_buf, ops->packed_size);
+		if (rc < 0)
+			return rc;
+
+		memset(&cmd, 0, sizeof(cmd));
+		ops->cmd_packing(packed_buf, &cmd, UNPACK);
+		/* UM10944: [valident] will always be found cleared
+		 * during a read access with MGMTROUTE set.
+		 * So don't error out in that case.
+		 */
+		if (!cmd.valident && blk_idx != BLK_IDX_MGMT_ROUTE)
+			return -EINVAL;
+		cpu_relax();
+	} while (cmd.valid && --retries);
+
+	if (cmd.valid)
+		return -ETIMEDOUT;
+
+	/* Don't dereference possibly NULL pointer - maybe caller
+	 * only wanted to see whether the entry existed or not.
+	 */
+	if (entry)
+		ops->entry_packing(packed_buf, entry, UNPACK);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sja1105_dynamic_config_read);
+
+int sja1105_dynamic_config_write(struct sja1105_private *priv,
+				 enum sja1105_blk_idx blk_idx,
+				 int index, void *entry, bool keep)
+{
+	const struct sja1105_dynamic_table_ops *ops;
+	struct sja1105_dyn_cmd cmd = { 0 };
+	/* SPI payload buffer */
+	u8 packed_buf[MAX_DYN_CMD_SIZE];
+	int rc;
+
+	if (blk_idx >= BLK_IDX_MAX_DYN)
+		return -ERANGE;
+
+	ops = &priv->dyn_ops[blk_idx];
+
+	if (index >= ops->max_entry_count)
+		return -ERANGE;
+	if (!(ops->access & OP_WRITE))
+		return -EOPNOTSUPP;
+	if (!keep && !(ops->access & OP_DEL))
+		return -EOPNOTSUPP;
+	if (ops->packed_size > MAX_DYN_CMD_SIZE)
+		return -ERANGE;
+
+	memset(packed_buf, 0, ops->packed_size);
+
+	cmd.valident = keep; /* If false, deletes entry */
+	cmd.valid = true; /* Trigger action on table entry */
+	cmd.rdwrset = SPI_WRITE; /* Action is write */
+	cmd.index = index;
+
+	if (!ops->cmd_packing)
+		return -EOPNOTSUPP;
+	ops->cmd_packing(packed_buf, &cmd, PACK);
+
+	if (!ops->entry_packing)
+		return -EOPNOTSUPP;
+	/* Don't dereference potentially NULL pointer if just
+	 * deleting a table entry is what was requested. For cases
+	 * where 'index' field is physically part of entry structure,
+	 * and needed here, we deal with that in the cmd_packing callback.
+	 */
+	if (keep)
+		ops->entry_packing(packed_buf, entry, PACK);
+
+	/* Send SPI write operation: read config table entry */
+	rc = sja1105_spi_send_packed_buf(priv, SPI_WRITE, ops->addr,
+					 packed_buf, ops->packed_size);
+	if (rc < 0)
+		return rc;
+
+	memset(&cmd, 0, sizeof(cmd));
+	ops->cmd_packing(packed_buf, &cmd, UNPACK);
+	if (cmd.errors)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sja1105_dynamic_config_write);
+
+void sja1105_dynamic_config_init(struct sja1105_private *priv)
+{
+	const struct sja1105_dynamic_table_ops *ops;
+
+	if (IS_ET(priv->device_id))
+		ops = sja1105et_table_ops;
+	else
+		ops = sja1105pqrs_table_ops;
+
+	priv->dyn_ops = ops;
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.h b/drivers/net/dsa/sja1105/sja1105_dynamic_config.h
new file mode 100644
index 000000000000..afc6d41f0330
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#ifndef _SJA1105_DYNAMIC_CONFIG_H
+#define _SJA1105_DYNAMIC_CONFIG_H
+
+#include "sja1105.h"
+#include <linux/packing.h>
+
+struct sja1105_dyn_cmd {
+	u64 valid;
+	u64 rdwrset;
+	u64 errors;
+	u64 valident;
+	u64 index;
+};
+
+struct sja1105_dynamic_table_ops {
+	/* This returns size_t just to keep same prototype as the
+	 * static config ops, of which we are reusing some functions.
+	 */
+	size_t (*entry_packing)(void *buf, void *entry_ptr, enum packing_op op);
+	void (*cmd_packing)(void *buf, struct sja1105_dyn_cmd *cmd,
+			    enum packing_op op);
+	size_t max_entry_count;
+	size_t packed_size;
+	u64 addr;
+	u8 access;
+};
+
+struct sja1105_mgmt_entry {
+	u64 tsreg;
+	u64 takets;
+	u64 macaddr;
+	u64 destports;
+	u64 enfport;
+	u64 index;
+};
+
+#endif
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
new file mode 100644
index 000000000000..45c233d7fbba
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Sensor-Technik Wiedemann GmbH
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/spi/spi.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+#include <linux/netdev_features.h>
+#include <linux/netdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include "sja1105.h"
+
+static void sja1105_hw_reset(struct gpio_desc *gpio, unsigned int pulse_len,
+			     unsigned int startup_delay)
+{
+	gpiod_set_value_cansleep(gpio, 1);
+	/* Wait for minimum reset pulse length */
+	msleep(pulse_len);
+	gpiod_set_value_cansleep(gpio, 0);
+	/* Wait until chip is ready after reset */
+	msleep(startup_delay);
+}
+
+static void
+sja1105_port_allow_traffic(struct sja1105_l2_forwarding_entry *l2_fwd,
+			   int from, int to, bool allow)
+{
+	if (allow) {
+		l2_fwd[from].bc_domain  |= BIT(to);
+		l2_fwd[from].reach_port |= BIT(to);
+		l2_fwd[from].fl_domain  |= BIT(to);
+	} else {
+		l2_fwd[from].bc_domain  &= ~BIT(to);
+		l2_fwd[from].reach_port &= ~BIT(to);
+		l2_fwd[from].fl_domain  &= ~BIT(to);
+	}
+}
+
+/* Structure used to temporarily transport device tree
+ * settings into sja1105_setup
+ */
+struct sja1105_dt_port {
+	phy_interface_t phy_mode;
+	sja1105_mii_mode_t mode;
+};
+
+static int sja1105_init_mac_settings(struct sja1105_private *priv)
+{
+	struct sja1105_mac_config_entry default_mac = {
+		/* Enable all 8 priority queues on egress.
+		 * Every queue i holds top[i] - base[i] frames.
+		 * Sum of top[i] - base[i] is 511 (max hardware limit).
+		 */
+		.top  = {0x3F, 0x7F, 0xBF, 0xFF, 0x13F, 0x17F, 0x1BF, 0x1FF},
+		.base = {0x0, 0x40, 0x80, 0xC0, 0x100, 0x140, 0x180, 0x1C0},
+		.enabled = {true, true, true, true, true, true, true, true},
+		/* Keep standard IFG of 12 bytes on egress. */
+		.ifg = 0,
+		/* Always put the MAC speed in automatic mode, where it can be
+		 * retrieved from the PHY object through phylib and
+		 * sja1105_adjust_port_config.
+		 */
+		.speed = SJA1105_SPEED_AUTO,
+		/* No static correction for 1-step 1588 events */
+		.tp_delin = 0,
+		.tp_delout = 0,
+		/* Disable aging for critical TTEthernet traffic */
+		.maxage = 0xFF,
+		/* Internal VLAN (pvid) to apply to untagged ingress */
+		.vlanprio = 0,
+		.vlanid = 0,
+		.ing_mirr = false,
+		.egr_mirr = false,
+		/* Don't drop traffic with other EtherType than 800h */
+		.drpnona664 = false,
+		/* Don't drop double-tagged traffic */
+		.drpdtag = false,
+		/* Don't drop VLAN with single outer tag - P/Q/R/S only */
+		.drpsotag = false,
+		/* Don't drop VLAN with single inner tag - P/Q/R/S only */
+		.drpsitag = false,
+		/* Don't drop untagged traffic */
+		.drpuntag = false,
+		/* Don't retag 802.1p (VID 0) traffic with the pvid */
+		.retag = false,
+		/* Enable learning and I/O on user ports by default. */
+		.dyn_learn = true,
+		.egress = false,
+		.ingress = false,
+		.mirrcie = 0,
+		.mirrcetag = 0,
+		.ingmirrvid = 0,
+		.ingmirrpcp = 0,
+		.ingmirrdei = 0,
+	};
+	struct sja1105_mac_config_entry *mac;
+	struct sja1105_table *table;
+	int i;
+
+	table = &priv->static_config.tables[BLK_IDX_MAC_CONFIG];
+
+	/* Discard previous MAC Configuration Table */
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(SJA1105_NUM_PORTS,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	/* Override table based on phylib DT bindings */
+	table->entry_count = SJA1105_NUM_PORTS;
+
+	mac = table->entries;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++)
+		mac[i] = default_mac;
+
+	return 0;
+}
+
+static int sja1105_init_mii_settings(struct sja1105_private *priv,
+				     struct sja1105_dt_port *ports)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct sja1105_xmii_params_entry *mii;
+	struct sja1105_table *table;
+	int i;
+
+	table = &priv->static_config.tables[BLK_IDX_XMII_PARAMS];
+
+	/* Discard previous xMII Mode Parameters Table */
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_XMII_PARAMS_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	/* Override table based on phylib DT bindings */
+	table->entry_count = MAX_XMII_PARAMS_COUNT;
+
+	mii = table->entries;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		switch (ports[i].phy_mode) {
+		case PHY_INTERFACE_MODE_MII:
+			mii->xmii_mode[i] = XMII_MODE_MII;
+			break;
+		case PHY_INTERFACE_MODE_RMII:
+			mii->xmii_mode[i] = XMII_MODE_RMII;
+			break;
+		case PHY_INTERFACE_MODE_RGMII:
+		case PHY_INTERFACE_MODE_RGMII_ID:
+		case PHY_INTERFACE_MODE_RGMII_RXID:
+		case PHY_INTERFACE_MODE_RGMII_TXID:
+			mii->xmii_mode[i] = XMII_MODE_RGMII;
+			break;
+		default:
+			dev_err(dev, "Unsupported PHY mode %s!\n",
+				phy_modes(ports[i].phy_mode));
+		}
+
+		mii->phy_mac[i] = ports[i].mode;
+	}
+	return 0;
+}
+
+static int sja1105_init_static_fdb(struct sja1105_private *priv)
+{
+	struct sja1105_table *table;
+
+	table = &priv->static_config.tables[BLK_IDX_L2_LOOKUP];
+
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+	return 0;
+}
+
+static int sja1105_init_l2_lookup_params(struct sja1105_private *priv)
+{
+	struct sja1105_table *table;
+	struct sja1105_l2_lookup_params_entry default_l2_lookup_params = {
+		/* TODO Learned FDB entries are never forgotten */
+		.maxage = 0,
+		/* All entries within a FDB bin are available for learning */
+		.dyn_tbsz = SJA1105ET_FDB_BIN_SIZE,
+		/* 2^8 + 2^5 + 2^3 + 2^2 + 2^1 + 1 in Koopman notation */
+		.poly = 0x97,
+		/* This selects between Independent VLAN Learning (IVL) and
+		 * Shared VLAN Learning (SVL)
+		 */
+		.shared_learn = false,
+		/* Don't discard management traffic based on ENFPORT -
+		 * we don't perform SMAC port enforcement anyway, so
+		 * what we are setting here doesn't matter.
+		 */
+		.no_enf_hostprt = false,
+		/* Don't learn SMAC for mac_fltres1 and mac_fltres0.
+		 * TODO Maybe correlate with no_linklocal_learn from bridge
+		 * driver?
+		 */
+		.no_mgmt_learn = true,
+	};
+
+	table = &priv->static_config.tables[BLK_IDX_L2_LOOKUP_PARAMS];
+
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_L2_LOOKUP_PARAMS_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	table->entry_count = MAX_L2_LOOKUP_PARAMS_COUNT;
+
+	/* This table only has a single entry */
+	((struct sja1105_l2_lookup_params_entry *)table->entries)[0] =
+				default_l2_lookup_params;
+
+	return 0;
+}
+
+static int sja1105_init_static_vlan(struct sja1105_private *priv)
+{
+	struct sja1105_table *table;
+	struct sja1105_vlan_lookup_entry pvid = {
+		.ving_mirr = 0,
+		.vegr_mirr = 0,
+		.vmemb_port = 0,
+		.vlan_bc = 0,
+		.tag_port = 0,
+		.vlanid = 0,
+	};
+	int i;
+
+	table = &priv->static_config.tables[BLK_IDX_VLAN_LOOKUP];
+
+	/* The static VLAN table will only contain the initial pvid of 0.
+	 */
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(1, table->ops->unpacked_entry_size,
+				 GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	table->entry_count = 1;
+
+	/* VLAN ID 0: all DT-defined ports are members; no restrictions on
+	 * forwarding; always transmit priority-tagged frames as untagged.
+	 */
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		pvid.vmemb_port |= BIT(i);
+		pvid.vlan_bc |= BIT(i);
+		pvid.tag_port &= ~BIT(i);
+	}
+
+	((struct sja1105_vlan_lookup_entry *)table->entries)[0] = pvid;
+	return 0;
+}
+
+static int sja1105_init_l2_forwarding(struct sja1105_private *priv)
+{
+	struct sja1105_l2_forwarding_entry *l2fwd;
+	struct sja1105_table *table;
+	int i, j;
+
+	table = &priv->static_config.tables[BLK_IDX_L2_FORWARDING];
+
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_L2_FORWARDING_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	table->entry_count = MAX_L2_FORWARDING_COUNT;
+
+	l2fwd = table->entries;
+
+	/* First 5 entries define the forwarding rules */
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		unsigned int upstream = dsa_upstream_port(priv->ds, i);
+
+		for (j = 0; j < SJA1105_NUM_TC; j++)
+			l2fwd[i].vlan_pmap[j] = j;
+
+		if (i == upstream)
+			continue;
+
+		sja1105_port_allow_traffic(l2fwd, i, upstream, true);
+		sja1105_port_allow_traffic(l2fwd, upstream, i, true);
+	}
+	/* Next 8 entries define VLAN PCP mapping from ingress to egress.
+	 * Create a one-to-one mapping.
+	 */
+	for (i = 0; i < SJA1105_NUM_TC; i++)
+		for (j = 0; j < SJA1105_NUM_PORTS; j++)
+			l2fwd[SJA1105_NUM_PORTS + i].vlan_pmap[j] = i;
+
+	return 0;
+}
+
+static int sja1105_init_l2_forwarding_params(struct sja1105_private *priv)
+{
+	struct sja1105_l2_forwarding_params_entry default_l2fwd_params = {
+		/* Disallow dynamic reconfiguration of vlan_pmap */
+		.max_dynp = 0,
+		/* Use a single memory partition for all ingress queues */
+		.part_spc = { MAX_FRAME_MEMORY, 0, 0, 0, 0, 0, 0, 0 },
+	};
+	struct sja1105_table *table;
+
+	table = &priv->static_config.tables[BLK_IDX_L2_FORWARDING_PARAMS];
+
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_L2_FORWARDING_PARAMS_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	table->entry_count = MAX_L2_FORWARDING_PARAMS_COUNT;
+
+	/* This table only has a single entry */
+	((struct sja1105_l2_forwarding_params_entry *)table->entries)[0] =
+				default_l2fwd_params;
+
+	return 0;
+}
+
+static int sja1105_init_general_params(struct sja1105_private *priv)
+{
+	struct sja1105_general_params_entry default_general_params = {
+		/* Disallow dynamic changing of the mirror port */
+		.mirr_ptacu = 0,
+		.switchid = priv->ds->index,
+		/* Priority queue for link-local frames trapped to CPU */
+		.hostprio = 0,
+		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
+		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
+		.incl_srcpt1 = true,
+		.send_meta1  = false,
+		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
+		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
+		.incl_srcpt0 = true,
+		.send_meta0  = false,
+		/* The destination for traffic matching mac_fltres1 and
+		 * mac_fltres0 on all ports except host_port. Such traffic
+		 * receieved on host_port itself would be dropped, except
+		 * by installing a temporary 'management route'
+		 */
+		.host_port = dsa_upstream_port(priv->ds, 0),
+		/* Same as host port */
+		.mirr_port = dsa_upstream_port(priv->ds, 0),
+		/* Link-local traffic received on casc_port will be forwarded
+		 * to host_port without embedding the source port and device ID
+		 * info in the destination MAC address (presumably because it
+		 * is a cascaded port and a downstream SJA switch already did
+		 * that). Default to an invalid port (to disable the feature)
+		 * and overwrite this if we find any DSA (cascaded) ports.
+		 */
+		.casc_port = SJA1105_NUM_PORTS,
+		/* No TTEthernet */
+		.vllupformat = 0,
+		.vlmarker = 0,
+		.vlmask = 0,
+		/* Only update correctionField for 1-step PTP (L2 transport) */
+		.ignore2stf = 0,
+		.tpid = ETH_P_8021Q,
+		.tpid2 = ETH_P_8021Q,
+		/* P/Q/R/S only */
+		.queue_ts = 0,
+		.egrmirrvid = 0,
+		.egrmirrpcp = 0,
+		.egrmirrdei = 0,
+		.replay_port = 0,
+	};
+	struct sja1105_table *table;
+	int i;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++)
+		if (dsa_is_dsa_port(priv->ds, i))
+			default_general_params.casc_port = i;
+
+	table = &priv->static_config.tables[BLK_IDX_GENERAL_PARAMS];
+
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_GENERAL_PARAMS_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	table->entry_count = MAX_GENERAL_PARAMS_COUNT;
+
+	/* This table only has a single entry */
+	((struct sja1105_general_params_entry *)table->entries)[0] =
+				default_general_params;
+
+	return 0;
+}
+
+static inline void
+sja1105_setup_policer(struct sja1105_l2_policing_entry *policing,
+		      int index)
+{
+#define RATE_MBPS(speed) (((speed) * 64000) / 1000)
+	policing[index].sharindx = index;
+	policing[index].smax = 65535; /* Burst size in bytes */
+	policing[index].rate = RATE_MBPS(1000);
+	policing[index].maxlen = ETH_FRAME_LEN + VLAN_HLEN + ETH_FCS_LEN;
+	policing[index].partition = 0;
+#undef RATE_MBPS
+}
+
+static int sja1105_init_l2_policing(struct sja1105_private *priv)
+{
+	struct sja1105_l2_policing_entry *policing;
+	struct sja1105_table *table;
+	int i, j, k;
+
+	table = &priv->static_config.tables[BLK_IDX_L2_POLICING];
+
+	/* Discard previous L2 Policing Table */
+	if (table->entry_count) {
+		kfree(table->entries);
+		table->entry_count = 0;
+	}
+
+	table->entries = kcalloc(MAX_L2_POLICING_COUNT,
+				 table->ops->unpacked_entry_size, GFP_KERNEL);
+	if (!table->entries)
+		return -ENOMEM;
+
+	/* Override table based on phylib DT bindings */
+	table->entry_count = MAX_L2_POLICING_COUNT;
+
+	policing = table->entries;
+
+	/* k sweeps through all unicast policers (0-39).
+	 * bcast sweeps through policers 40-44.
+	 */
+	for (i = 0, k = 0; i < SJA1105_NUM_PORTS; i++) {
+		int bcast = (SJA1105_NUM_PORTS * SJA1105_NUM_TC) + i;
+
+		for (j = 0; j < SJA1105_NUM_TC; j++, k++)
+			sja1105_setup_policer(policing, k);
+
+		/* Set up this port's policer for broadcast traffic */
+		sja1105_setup_policer(policing, bcast);
+	}
+	return 0;
+}
+
+static int sja1105_static_config_load(struct sja1105_private *priv,
+				      struct sja1105_dt_port *ports)
+{
+	int rc;
+
+	sja1105_static_config_free(&priv->static_config);
+	rc = sja1105_static_config_init(&priv->static_config,
+					priv->device_id, priv->part_nr);
+	if (rc)
+		return rc;
+
+	/* Build static configuration */
+	rc = sja1105_init_mac_settings(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_mii_settings(priv, ports);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_static_fdb(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_static_vlan(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_l2_lookup_params(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_l2_forwarding(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_l2_forwarding_params(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_l2_policing(priv);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_init_general_params(priv);
+	if (rc < 0)
+		return rc;
+
+	/* Send initial configuration to hardware via SPI */
+	return sja1105_static_config_upload(priv);
+}
+
+static int sja1105_parse_ports_node(struct sja1105_dt_port *ports,
+				    struct device_node *ports_node)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(ports_node, child) {
+		struct device_node *phy_node;
+		int phy_mode;
+		u32 index;
+
+		/* Get switch port number from DT */
+		if (of_property_read_u32(child, "reg", &index) < 0) {
+			pr_err("Port number not defined in device tree (property \"reg\")\n");
+			return -ENODEV;
+		}
+
+		/* Get PHY mode from DT */
+		phy_mode = of_get_phy_mode(child);
+		if (phy_mode < 0) {
+			pr_err("Failed to read phy-mode or phy-interface-type property for port %d\n",
+			       index);
+			return -ENODEV;
+		}
+		ports[index].phy_mode = phy_mode;
+
+		phy_node = of_parse_phandle(child, "phy-handle", 0);
+		if (!phy_node) {
+			if (!of_phy_is_fixed_link(child)) {
+				pr_err("phy-handle or fixed-link properties missing!\n");
+				return -ENODEV;
+			}
+			/* phy-handle is missing, but fixed-link isn't.
+			 * So it's a fixed link. Default to PHY mode.
+			 */
+			ports[index].mode = XMII_PHY;
+		} else {
+			/* phy-handle present => put port in MAC mode */
+			ports[index].mode = XMII_MAC;
+			of_node_put(phy_node);
+		}
+
+		/* The MAC/PHY role can be overridden with explicit bindings */
+		if (of_property_read_bool(child, "sja1105,mac-mode"))
+			ports[index].mode = XMII_MAC;
+		else if (of_property_read_bool(child, "sja1105,phy-mode"))
+			ports[index].mode = XMII_PHY;
+	}
+
+	return 0;
+}
+
+static int sja1105_parse_dt(struct sja1105_private *priv,
+			    struct sja1105_dt_port *ports)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct device_node *switch_node = dev->of_node;
+	struct device_node *ports_node;
+	int rc;
+
+	ports_node = of_get_child_by_name(switch_node, "ports");
+	if (!ports_node) {
+		dev_err(dev, "Incorrect bindings: absent \"ports\" node\n");
+		return -ENODEV;
+	}
+
+	rc = sja1105_parse_ports_node(ports, ports_node);
+	of_node_put(ports_node);
+
+	return rc;
+}
+
+/* Convert back and forth MAC speed from Mbps to SJA1105 encoding */
+static int sja1105_speed[] = {
+	[SJA1105_SPEED_AUTO]     = 0,
+	[SJA1105_SPEED_10MBPS]   = 10,
+	[SJA1105_SPEED_100MBPS]  = 100,
+	[SJA1105_SPEED_1000MBPS] = 1000,
+};
+
+static sja1105_speed_t sja1105_get_speed_cfg(unsigned int speed_mbps)
+{
+	int i;
+
+	for (i = SJA1105_SPEED_AUTO; i <= SJA1105_SPEED_1000MBPS; i++)
+		if (sja1105_speed[i] == speed_mbps)
+			return i;
+	return -EINVAL;
+}
+
+/* Set link speed and enable/disable traffic I/O in the MAC configuration
+ * for a specific port.
+ *
+ * @speed_mbps: If 0, leave the speed unchanged, else adapt MAC to PHY speed.
+ * @enabled: Manage Rx and Tx settings for this port. Overrides the static
+ *	     configuration settings.
+ */
+static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
+				      int speed_mbps, bool enabled)
+{
+	struct sja1105_xmii_params_entry *mii;
+	struct sja1105_mac_config_entry *mac;
+	struct device *dev = priv->ds->dev;
+	sja1105_phy_interface_t phy_mode;
+	sja1105_speed_t speed;
+	int rc;
+
+	mii = priv->static_config.tables[BLK_IDX_XMII_PARAMS].entries;
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
+
+	speed = sja1105_get_speed_cfg(speed_mbps);
+	if (speed_mbps && speed < 0) {
+		dev_err(dev, "Invalid speed %iMbps\n", speed_mbps);
+		return -EINVAL;
+	}
+
+	/* If requested, overwrite SJA1105_SPEED_AUTO from the static MAC
+	 * configuration table, since this will be used for the clocking setup,
+	 * and we no longer need to store it in the static config (already told
+	 * hardware we want auto during upload phase).
+	 */
+	if (speed_mbps)
+		mac[port].speed = speed;
+	else
+		mac[port].speed = SJA1105_SPEED_AUTO;
+
+	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
+	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
+	 * We have to *know* what the MAC looks like.  For the sake of keeping
+	 * the code common, we'll use the static configuration tables as a
+	 * reasonable approximation for both E/T and P/Q/R/S.
+	 */
+	mac[port].ingress = enabled;
+	mac[port].egress  = enabled;
+
+	/* Write to the dynamic reconfiguration tables */
+	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG,
+					  port, &mac[port], true);
+	if (rc < 0) {
+		dev_err(dev, "Failed to write MAC config: %d\n", rc);
+		return rc;
+	}
+
+	/* Reconfigure the PLLs for the RGMII interfaces (required 125 MHz at
+	 * gigabit, 25 MHz at 100 Mbps and 2.5 MHz at 10 Mbps). For MII and
+	 * RMII no change of the clock setup is required. Actually, changing
+	 * the clock setup does interrupt the clock signal for a certain time
+	 * which causes trouble for all PHYs relying on this signal.
+	 */
+	if (!enabled)
+		return 0;
+
+	phy_mode = mii->xmii_mode[port];
+	if (phy_mode != XMII_MODE_RGMII)
+		return 0;
+
+	return sja1105_clocking_setup_port(priv, port);
+}
+
+static void sja1105_adjust_link(struct dsa_switch *ds, int port,
+				struct phy_device *phydev)
+{
+	struct sja1105_private *priv = ds->priv;
+
+	if (!phydev->link)
+		sja1105_adjust_port_config(priv, port, 0, false);
+	else
+		sja1105_adjust_port_config(priv, port, phydev->speed, true);
+}
+
+static int sja1105_bridge_member(struct dsa_switch *ds, int port,
+				 struct net_device *br, bool member)
+{
+	struct sja1105_l2_forwarding_entry *l2_fwd;
+	struct sja1105_private *priv = ds->priv;
+	int i, rc;
+
+	l2_fwd = priv->static_config.tables[BLK_IDX_L2_FORWARDING].entries;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		/* Add this port to the forwarding matrix of the
+		 * other ports in the same bridge, and viceversa.
+		 */
+		if (!dsa_is_user_port(ds, i))
+			continue;
+		if (i == port)
+			continue;
+		if (dsa_to_port(ds, i)->bridge_dev != br)
+			continue;
+		sja1105_port_allow_traffic(l2_fwd, i, port, member);
+		sja1105_port_allow_traffic(l2_fwd, port, i, member);
+
+		rc = sja1105_dynamic_config_write(priv, BLK_IDX_L2_FORWARDING,
+						  i, &l2_fwd[i], true);
+		if (rc < 0)
+			return rc;
+	}
+
+	return sja1105_dynamic_config_write(priv, BLK_IDX_L2_FORWARDING,
+					    port, &l2_fwd[port], true);
+}
+
+static int sja1105_bridge_join(struct dsa_switch *ds, int port,
+			       struct net_device *br)
+{
+	return sja1105_bridge_member(ds, port, br, true);
+}
+
+static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
+				 struct net_device *br)
+{
+	sja1105_bridge_member(ds, port, br, false);
+}
+
+static enum dsa_tag_protocol
+sja1105_get_tag_protocol(struct dsa_switch *ds, int port)
+{
+	return DSA_TAG_PROTO_NONE;
+}
+
+/* The programming model for the SJA1105 switch is "all-at-once" via static
+ * configuration tables. Some of these can be dynamically modified at runtime,
+ * but not the xMII mode parameters table.
+ * Furthermode, some PHYs may not have crystals for generating their clocks
+ * (e.g. RMII). Instead, their 50MHz clock is supplied via the SJA1105 port's
+ * ref_clk pin. So port clocking needs to be initialized early, before
+ * connecting to PHYs is attempted, otherwise they won't respond through MDIO.
+ * Setting correct PHY link speed does not matter now.
+ * But dsa_slave_phy_setup is called later than sja1105_setup, so the PHY
+ * bindings are not yet parsed by DSA core. We need to parse early so that we
+ * can populate the xMII mode parameters table.
+ */
+static int sja1105_setup(struct dsa_switch *ds)
+{
+	struct sja1105_dt_port ports[SJA1105_NUM_PORTS];
+	struct sja1105_private *priv = ds->priv;
+	int rc;
+
+	rc = sja1105_parse_dt(priv, ports);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to parse DT: %d\n", rc);
+		return rc;
+	}
+	/* Create and send configuration down to device */
+	rc = sja1105_static_config_load(priv, ports);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to load static config: %d\n", rc);
+		return rc;
+	}
+	/* Configure the CGU (PHY link modes and speeds) */
+	rc = sja1105_clocking_setup(priv);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to configure MII clocking: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static const struct dsa_switch_ops sja1105_switch_ops = {
+	.get_tag_protocol	= sja1105_get_tag_protocol,
+	.setup			= sja1105_setup,
+	.adjust_link		= sja1105_adjust_link,
+	.port_bridge_join	= sja1105_bridge_join,
+	.port_bridge_leave	= sja1105_bridge_leave,
+};
+
+static int sja1105_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct sja1105_private *priv;
+	struct dsa_switch *ds;
+	int rc;
+
+	if (!dev->of_node) {
+		dev_err(dev, "No DTS bindings for SJA1105 driver\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(struct sja1105_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ds = dsa_switch_alloc(dev, SJA1105_NUM_PORTS);
+	if (!ds)
+		return -ENOMEM;
+
+	ds->ops = &sja1105_switch_ops;
+	ds->priv = priv;
+	priv->ds = ds;
+
+	/* Populate our driver private structure (priv) based on
+	 * the device tree node that was probed (spi)
+	 */
+	priv->spidev = spi;
+	spi_set_drvdata(spi, priv);
+
+	/* Configure the SPI bus */
+	spi->mode = SPI_CPHA;
+	spi->bits_per_word = 8;
+	rc = spi_setup(spi);
+	if (rc < 0) {
+		dev_err(dev, "Could not init SPI\n");
+		return rc;
+	}
+
+	/* Configure the optional reset pin and bring up switch */
+	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		dev_dbg(dev, "reset-gpios not defined, ignoring\n");
+	else
+		sja1105_hw_reset(priv->reset_gpio, 1, 1);
+
+	/* Detect hardware device */
+	rc = sja1105_device_id_get(priv);
+	if (rc < 0) {
+		dev_err(dev, "Failed to read device ID: %d\n", rc);
+		return rc;
+	}
+
+	dev_info(dev, "Probed switch chip: %s\n",
+		 sja1105_device_id_string_get(priv->device_id, priv->part_nr));
+
+	sja1105_dynamic_config_init(priv);
+
+	return dsa_register_switch(priv->ds);
+}
+
+static int sja1105_remove(struct spi_device *spi)
+{
+	struct sja1105_private *priv = spi_get_drvdata(spi);
+
+	dsa_unregister_switch(priv->ds);
+	sja1105_static_config_free(&priv->static_config);
+	return 0;
+}
+
+static const struct of_device_id sja1105_dt_ids[] = {
+	{ .compatible = "nxp,sja1105" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sja1105_dt_ids);
+
+static struct spi_driver sja1105_driver = {
+	.driver = {
+		.name  = "sja1105",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(sja1105_dt_ids),
+	},
+	.probe  = sja1105_probe,
+	.remove = sja1105_remove,
+};
+
+module_spi_driver(sja1105_driver);
+
+MODULE_AUTHOR("Vladimir Oltean <olteanv@gmail.com>");
+MODULE_AUTHOR("Georg Waibel <georg.waibel@sensor-technik.de>");
+MODULE_DESCRIPTION("SJA1105 Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
new file mode 100644
index 000000000000..19220ab1f44c
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2016-2018, NXP Semiconductors
+ * Copyright (c) 2018, Sensor-Technik Wiedemann GmbH
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/spi/spi.h>
+#include <linux/packing.h>
+#include "sja1105.h"
+
+#define SPI_TRANSFER_SIZE_MAX  (SIZE_SPI_MSG_HEADER + SIZE_SPI_MSG_MAXLEN)
+
+static int sja1105_spi_transfer(const struct sja1105_private *priv,
+				const void *tx, void *rx, int size)
+{
+	struct spi_device *spi = priv->spidev;
+	struct spi_transfer transfer = {
+		.tx_buf = tx,
+		.rx_buf = rx,
+		.len = size,
+	};
+	struct spi_message msg;
+	int rc;
+
+	if (size > SPI_TRANSFER_SIZE_MAX) {
+		dev_err(&spi->dev, "SPI message (%d) longer than max of %d\n",
+			size, SPI_TRANSFER_SIZE_MAX);
+		return -EMSGSIZE;
+	}
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&transfer, &msg);
+
+	rc = spi_sync(spi, &msg);
+	if (rc < 0) {
+		dev_err(&spi->dev, "SPI transfer failed: %d\n", rc);
+		return rc;
+	}
+
+	return rc;
+}
+
+static void
+sja1105_spi_message_pack(void *buf, const struct sja1105_spi_message *msg)
+{
+	const int size = SIZE_SPI_MSG_HEADER;
+
+	memset(buf, 0, size);
+
+	sja1105_pack(buf, &msg->access,     31, 31, size);
+	sja1105_pack(buf, &msg->read_count, 30, 25, size);
+	sja1105_pack(buf, &msg->address,    24,  4, size);
+}
+
+/* If read_or_write is:
+ *     * SPI_WRITE: creates and sends an SPI write message at absolute
+ *                  address reg_addr, taking size_bytes from *packed_buf
+ *     * SPI_READ: creates and sends an SPI read message from absolute
+ *                 address reg_addr, writing size_bytes into *packed_buf
+ *
+ * This function should only be called if it is priorly known that
+ * size_bytes is smaller than SIZE_SPI_MSG_MAXLEN. Larger packed buffers
+ * are chunked in smaller pieces by sja1105_spi_send_long_packed_buf below.
+ */
+int
+sja1105_spi_send_packed_buf(const struct sja1105_private *priv,
+			    enum sja1105_spi_access_mode read_or_write,
+			    u64 reg_addr, void *packed_buf, size_t size_bytes)
+{
+	const int msg_len = size_bytes + SIZE_SPI_MSG_HEADER;
+	struct sja1105_spi_message msg;
+	u8 tx_buf[SIZE_SPI_MSG_HEADER + SIZE_SPI_MSG_MAXLEN];
+	u8 rx_buf[SIZE_SPI_MSG_HEADER + SIZE_SPI_MSG_MAXLEN];
+	int rc;
+
+	if (msg_len > SIZE_SPI_MSG_HEADER + SIZE_SPI_MSG_MAXLEN)
+		return -ERANGE;
+
+	memset(rx_buf, 0, msg_len);
+
+	msg.access     = read_or_write;
+	msg.read_count = (read_or_write == SPI_READ) ? (size_bytes / 4) : 0;
+	msg.address    = reg_addr;
+	sja1105_spi_message_pack(tx_buf, &msg);
+
+	if (read_or_write == SPI_READ)
+		memset(tx_buf + SIZE_SPI_MSG_HEADER, 0, size_bytes);
+	else if (read_or_write == SPI_WRITE)
+		memcpy(tx_buf + SIZE_SPI_MSG_HEADER, packed_buf, size_bytes);
+	else
+		return -EINVAL;
+
+	rc = sja1105_spi_transfer(priv, tx_buf, rx_buf, msg_len);
+	if (rc < 0)
+		return rc;
+
+	if (read_or_write == SPI_READ)
+		memcpy(packed_buf, rx_buf + SIZE_SPI_MSG_HEADER, size_bytes);
+
+	return 0;
+}
+
+/* If read_or_write is:
+ *     * SPI_WRITE: creates and sends an SPI write message at absolute
+ *                  address reg_addr, taking size_bytes from *value
+ *     * SPI_READ: creates and sends an SPI read message from absolute
+ *                 address reg_addr, writing size_bytes into *value
+ *
+ * The u64 *value is unpacked, meaning that it's stored in the native
+ * CPU endianness and directly usable by software running on the core.
+ *
+ * This is a wrapper around sja1105_spi_send_packed_buf().
+ */
+int sja1105_spi_send_int(const struct sja1105_private *priv,
+			 enum sja1105_spi_access_mode read_or_write,
+			 u64 reg_addr, u64 *value, u64 size_bytes)
+{
+	u8 packed_buf[SIZE_SPI_MSG_MAXLEN];
+	int rc;
+
+	if (size_bytes > SIZE_SPI_MSG_MAXLEN)
+		return -ERANGE;
+
+	if (read_or_write == SPI_WRITE)
+		sja1105_pack(packed_buf, value, 8 * size_bytes - 1, 0,
+			     size_bytes);
+
+	rc = sja1105_spi_send_packed_buf(priv, read_or_write, reg_addr,
+					 packed_buf, size_bytes);
+
+	if (read_or_write == SPI_READ)
+		sja1105_unpack(packed_buf, value, 8 * size_bytes - 1, 0,
+			       size_bytes);
+
+	return rc;
+}
+
+/* Should be used if a packed_buf larger than SIZE_SPI_MSG_MAXLEN must be
+ * sent/received. Splitting the buffer into chunks and assembling those
+ * into SPI messages is done automatically by this function.
+ */
+int
+sja1105_spi_send_long_packed_buf(const struct sja1105_private *priv,
+				 enum sja1105_spi_access_mode read_or_write,
+				 u64 base_addr, void *packed_buf, u64 buf_len)
+{
+	struct chunk {
+		void *buf_ptr;
+		int len;
+		u64 spi_address;
+	} chunk;
+	int distance_to_end;
+	int rc = 0;
+
+	/* Initialize chunk */
+	chunk.buf_ptr = packed_buf;
+	chunk.spi_address = base_addr;
+	chunk.len = min_t(int, buf_len, SIZE_SPI_MSG_MAXLEN);
+
+	while (chunk.len) {
+		rc = sja1105_spi_send_packed_buf(priv, read_or_write,
+						 chunk.spi_address,
+						 chunk.buf_ptr, chunk.len);
+		if (rc < 0)
+			return rc;
+
+		chunk.buf_ptr += chunk.len;
+		chunk.spi_address += chunk.len / 4;
+		distance_to_end = (uintptr_t)((packed_buf + buf_len) -
+					chunk.buf_ptr);
+		chunk.len = min(distance_to_end, SIZE_SPI_MSG_MAXLEN);
+	}
+
+	return 0;
+}
+
+/* Back-ported structure from UM11040 Table 112.
+ * Reset control register (addr. 100440h)
+ * In the SJA1105 E/T, only warm_rst and cold_rst are
+ * supported (exposed in UM10944 as rst_ctrl), but the bit
+ * offsets of warm_rst and cold_rst are actually reversed.
+ */
+struct sja1105_reset_cmd {
+	u64 switch_rst;
+	u64 cfg_rst;
+	u64 car_rst;
+	u64 otp_rst;
+	u64 warm_rst;
+	u64 cold_rst;
+	u64 por_rst;
+};
+
+static void
+sja1105et_reset_cmd_pack(void *buf, const struct sja1105_reset_cmd *reset)
+{
+	const int size = 4;
+
+	memset(buf, 0, size);
+
+	sja1105_pack(buf, &reset->cold_rst, 3, 3, size);
+	sja1105_pack(buf, &reset->warm_rst, 2, 2, size);
+}
+
+static void
+sja1105pqrs_reset_cmd_pack(void *buf, const struct sja1105_reset_cmd *reset)
+{
+	const int size = 4;
+
+	memset(buf, 0, size);
+
+	sja1105_pack(buf, &reset->switch_rst, 8, 8, size);
+	sja1105_pack(buf, &reset->cfg_rst,    7, 7, size);
+	sja1105_pack(buf, &reset->car_rst,    5, 5, size);
+	sja1105_pack(buf, &reset->otp_rst,    4, 4, size);
+	sja1105_pack(buf, &reset->warm_rst,   3, 3, size);
+	sja1105_pack(buf, &reset->cold_rst,   2, 2, size);
+	sja1105_pack(buf, &reset->por_rst,    1, 1, size);
+}
+
+static int sja1105_reset_cmd_commit(const struct sja1105_private *priv,
+				    const struct sja1105_reset_cmd *reset)
+{
+#define BUF_LEN 4
+	struct device *dev = priv->ds->dev;
+	u8 packed_buf[BUF_LEN];
+
+	if (reset->switch_rst)
+		dev_dbg(dev, "Main reset for all functional modules requested\n");
+	if (reset->cfg_rst)
+		dev_dbg(dev, "Chip configuration reset requested\n");
+	if (reset->car_rst)
+		dev_dbg(dev, "Clock and reset control logic reset requested\n");
+	if (reset->otp_rst)
+		dev_dbg(dev, "OTP read cycle for reading product "
+			"config settings requested\n");
+	if (reset->warm_rst)
+		dev_dbg(dev, "Warm reset requested\n");
+	if (reset->cold_rst)
+		dev_dbg(dev, "Cold reset requested\n");
+	if (reset->por_rst)
+		dev_dbg(dev, "Power-on reset requested\n");
+
+	if ((reset->switch_rst || reset->cfg_rst || reset->car_rst ||
+	     reset->otp_rst || reset->por_rst) && IS_ET(priv->device_id)) {
+		dev_err(dev, "Only warm and cold reset is supported "
+			"for SJA1105 E/T!\n");
+		return -EINVAL;
+	}
+	if (IS_ET(priv->device_id))
+		sja1105et_reset_cmd_pack(packed_buf, reset);
+	else
+		sja1105pqrs_reset_cmd_pack(packed_buf, reset);
+
+	return sja1105_spi_send_packed_buf(priv, SPI_WRITE, priv->regs->rgu,
+					   packed_buf, BUF_LEN);
+#undef BUF_LEN
+}
+
+static int sja1105_cold_reset(const struct sja1105_private *priv)
+{
+	struct sja1105_reset_cmd reset = {0};
+
+	reset.cold_rst = 1;
+	return sja1105_reset_cmd_commit(priv, &reset);
+}
+
+static const char *SJA1105E_DEVICE_ID_STR   = "SJA1105E";
+static const char *SJA1105T_DEVICE_ID_STR   = "SJA1105T";
+static const char *SJA1105P_DEVICE_ID_STR   = "SJA1105P";
+static const char *SJA1105Q_DEVICE_ID_STR   = "SJA1105Q";
+static const char *SJA1105R_DEVICE_ID_STR   = "SJA1105R";
+static const char *SJA1105S_DEVICE_ID_STR   = "SJA1105S";
+static const char *SJA1105PR_DEVICE_ID_STR  = "SJA1105P or SJA1105R";
+static const char *SJA1105QS_DEVICE_ID_STR  = "SJA1105Q or SJA1105S";
+static const char *SJA1105_NO_DEVICE_ID_STR = "None";
+
+const char *sja1105_device_id_string_get(u64 device_id, u64 part_nr)
+{
+	if (device_id == SJA1105E_DEVICE_ID)
+		return SJA1105E_DEVICE_ID_STR;
+	if (device_id == SJA1105T_DEVICE_ID)
+		return SJA1105T_DEVICE_ID_STR;
+	/* P and R have same Device ID, and differ by Part Number.
+	 * Same do Q and S.
+	 */
+	if (IS_P(device_id, part_nr))
+		return SJA1105P_DEVICE_ID_STR;
+	if (IS_Q(device_id, part_nr))
+		return SJA1105Q_DEVICE_ID_STR;
+	if (IS_R(device_id, part_nr))
+		return SJA1105R_DEVICE_ID_STR;
+	if (IS_S(device_id, part_nr))
+		return SJA1105S_DEVICE_ID_STR;
+	/* Fallback: if we don't know/care what the part_nr is, and we
+	 * have a P/R, we can simply pass -1 to part_nr and have this
+	 * function say it's either P or R, instead of reporting it
+	 * as invalid.
+	 */
+	if (device_id == SJA1105PR_DEVICE_ID)
+		return SJA1105PR_DEVICE_ID_STR;
+	if (device_id == SJA1105QS_DEVICE_ID)
+		return SJA1105QS_DEVICE_ID_STR;
+
+	return SJA1105_NO_DEVICE_ID_STR;
+}
+
+struct sja1105_regs sja1105et_regs = {
+	.rgu = 0x100440,
+	.config = 0x020000,
+	.pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
+	.rmii_pll1 = 0x10000A,
+	.cgu_idiv = {0x10000B, 0x10000C, 0x10000D, 0x10000E, 0x10000F},
+	/* UM10944.pdf, Table 86, ACU Register overview */
+	.rgmii_pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
+	/* The base address is off-by-1 compared to UM10944,
+	 * because we are skipping device_id from the readout.
+	 */
+	.general_status = 0x1,
+	.mac = {0x200, 0x202, 0x204, 0x206, 0x208},
+	.mac_hl1 = {0x400, 0x410, 0x420, 0x430, 0x440},
+	.mac_hl2 = {0x600, 0x610, 0x620, 0x630, 0x640},
+	/* UM10944.pdf, Table 78, CGU Register overview */
+	.mii_tx_clk = {0x100013, 0x10001A, 0x100021, 0x100028, 0x10002F},
+	.mii_rx_clk = {0x100014, 0x10001B, 0x100022, 0x100029, 0x100030},
+	.mii_ext_tx_clk = {0x100018, 0x10001F, 0x100026, 0x10002D, 0x100034},
+	.mii_ext_rx_clk = {0x100019, 0x100020, 0x100027, 0x10002E, 0x100035},
+	.rgmii_txc = {0x100016, 0x10001D, 0x100024, 0x10002B, 0x100032},
+	.rmii_ref_clk = {0x100015, 0x10001C, 0x100023, 0x10002A, 0x100031},
+	.rmii_ext_tx_clk = {0x100018, 0x10001F, 0x100026, 0x10002D, 0x100034},
+};
+
+struct sja1105_regs sja1105pqrs_regs = {
+	.rgu = 0x100440,
+	.config = 0x020000,
+	.pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
+	.rmii_pll1 = 0x10000A,
+	.cgu_idiv = {0x10000B, 0x10000C, 0x10000D, 0x10000E, 0x10000F},
+	/* UM10944.pdf, Table 86, ACU Register overview */
+	.rgmii_pad_mii_tx = {0x100800, 0x100802, 0x100804, 0x100806, 0x100808},
+	/* The base address is off-by-1 compared to UM10944,
+	 * because we are skipping device_id from the readout.
+	 */
+	.general_status = 0x1,
+	.mac = {0x200, 0x202, 0x204, 0x206, 0x208},
+	.mac_hl1 = {0x400, 0x410, 0x420, 0x430, 0x440},
+	.mac_hl2 = {0x600, 0x610, 0x620, 0x630, 0x640},
+	/* UM11040.pdf, Table 114 */
+	.mii_tx_clk = {0x100013, 0x100019, 0x10001F, 0x100025, 0x10002B},
+	.mii_rx_clk = {0x100014, 0x10001A, 0x100020, 0x100026, 0x10002C},
+	.mii_ext_tx_clk = {0x100017, 0x10001D, 0x100023, 0x100029, 0x10002F},
+	.mii_ext_rx_clk = {0x100018, 0x10001E, 0x100024, 0x10002A, 0x100030},
+	.rgmii_txc = {0x100016, 0x10001C, 0x100022, 0x100028, 0x10002E},
+	.rmii_ref_clk = {0x100015, 0x10001B, 0x100021, 0x100027, 0x10002D},
+	.rmii_ext_tx_clk = {0x100017, 0x10001D, 0x100023, 0x100029, 0x10002F},
+	.qlevel = {0x604, 0x614, 0x624, 0x634, 0x644},
+};
+
+/* Populates priv structures device_id, part_nr and regs */
+int sja1105_device_id_get(struct sja1105_private *priv)
+{
+#define DEVICE_ID_ADDR	0x0
+#define PROD_ID_ADDR	0x100BC3
+	/* These can't be part of regs, because otherwise we'd have
+	 * a chicken and egg problem
+	 */
+	u64 compatible_device_ids[] = {
+		SJA1105E_DEVICE_ID,
+		SJA1105T_DEVICE_ID,
+		SJA1105PR_DEVICE_ID,
+		SJA1105QS_DEVICE_ID,
+	};
+	struct device *dev = priv->ds->dev;
+	u64 tmp_device_id;
+	u64 tmp_part_nr;
+	unsigned int i;
+	int rc;
+
+	rc = sja1105_spi_send_int(priv, SPI_READ, DEVICE_ID_ADDR,
+				  &tmp_device_id, SIZE_SJA1105_DEVICE_ID);
+	if (rc < 0)
+		return rc;
+
+	priv->device_id = SJA1105_NO_DEVICE_ID;
+	for (i = 0; i < ARRAY_SIZE(compatible_device_ids); i++) {
+		if (tmp_device_id == compatible_device_ids[i]) {
+			priv->device_id = compatible_device_ids[i];
+			break;
+		}
+	}
+	if (priv->device_id == SJA1105_NO_DEVICE_ID) {
+		dev_err(dev, "Unrecognized Device ID 0x%llx\n", tmp_device_id);
+		return -EINVAL;
+	}
+	if (IS_PQRS(priv->device_id)) {
+		rc = sja1105_spi_send_int(priv, SPI_READ, PROD_ID_ADDR,
+					  &tmp_part_nr, 4);
+		if (rc < 0)
+			return -EINVAL;
+
+		sja1105_unpack(&tmp_part_nr, &priv->part_nr, 19, 4, 4);
+	}
+
+	if (IS_ET(priv->device_id))
+		priv->regs = &sja1105et_regs;
+	else if (IS_PQRS(priv->device_id))
+		priv->regs = &sja1105pqrs_regs;
+
+	return 0;
+#undef PROD_ID_ADDR
+#undef DEVICE_ID_ADDR
+}
+
+struct sja1105_general_status {
+	u64 configs;
+	u64 crcchkl;
+	u64 ids;
+	u64 crcchkg;
+	u64 nslot;
+	u64 vlind;
+	u64 vlparind;
+	u64 vlroutes;
+	u64 vlparts;
+	u64 macaddl;
+	u64 portenf;
+	u64 fwds_03h;
+	u64 macfds;
+	u64 enffds;
+	u64 l2busyfds;
+	u64 l2busys;
+	u64 macaddu;
+	u64 macaddhcl;
+	u64 vlanidhc;
+	u64 hashconfs;
+	u64 macaddhcu;
+	u64 wpvlanid;
+	u64 port_07h;
+	u64 vlanbusys;
+	u64 wrongports;
+	u64 vnotfounds;
+	u64 vlid;
+	u64 portvl;
+	u64 vlnotfound;
+	u64 emptys;
+	u64 buffers;
+	u64 buflwmark; /* Only on P/Q/R/S */
+	u64 port_0ah;
+	u64 fwds_0ah;
+	u64 parts;
+	u64 ramparerrl;
+	u64 ramparerru;
+};
+
+static void
+sja1105_general_status_unpack(void *buf, struct sja1105_general_status *status,
+			      u64 device_id)
+{
+	/* So that addition translates to 4 bytes */
+	u32 *p = (u32 *)buf;
+
+	memset(status, 0, sizeof(*status));
+	/* device_id is missing from the buffer, but we don't
+	 * want to diverge from the manual definition of the
+	 * register addresses, so we'll back off one step with
+	 * the register pointer, and never access p[0].
+	 */
+	p--;
+	sja1105_unpack(p + 0x1, &status->configs,   31, 31, 4);
+	sja1105_unpack(p + 0x1, &status->crcchkl,   30, 30, 4);
+	sja1105_unpack(p + 0x1, &status->ids,       29, 29, 4);
+	sja1105_unpack(p + 0x1, &status->crcchkg,   28, 28, 4);
+	sja1105_unpack(p + 0x1, &status->nslot,      3,  0, 4);
+	sja1105_unpack(p + 0x2, &status->vlind,     31, 16, 4);
+	sja1105_unpack(p + 0x2, &status->vlparind,  15,  8, 4);
+	sja1105_unpack(p + 0x2, &status->vlroutes,   1,  1, 4);
+	sja1105_unpack(p + 0x2, &status->vlparts,    0,  0, 4);
+	sja1105_unpack(p + 0x3, &status->macaddl,   31, 16, 4);
+	sja1105_unpack(p + 0x3, &status->portenf,   15,  8, 4);
+	sja1105_unpack(p + 0x3, &status->fwds_03h,   4,  4, 4);
+	sja1105_unpack(p + 0x3, &status->macfds,     3,  3, 4);
+	sja1105_unpack(p + 0x3, &status->enffds,     2,  2, 4);
+	sja1105_unpack(p + 0x3, &status->l2busyfds,  1,  1, 4);
+	sja1105_unpack(p + 0x3, &status->l2busys,    0,  0, 4);
+	sja1105_unpack(p + 0x4, &status->macaddu,   31,  0, 4);
+	sja1105_unpack(p + 0x5, &status->macaddhcl, 31, 16, 4);
+	sja1105_unpack(p + 0x5, &status->vlanidhc,  15,  4, 4);
+	sja1105_unpack(p + 0x5, &status->hashconfs,  0,  0, 4);
+	sja1105_unpack(p + 0x6, &status->macaddhcu, 31,  0, 4);
+	sja1105_unpack(p + 0x7, &status->wpvlanid,  31, 16, 4);
+	sja1105_unpack(p + 0x7, &status->port_07h,  15,  8, 4);
+	sja1105_unpack(p + 0x7, &status->vlanbusys,  4,  4, 4);
+	sja1105_unpack(p + 0x7, &status->wrongports, 3,  3, 4);
+	sja1105_unpack(p + 0x7, &status->vnotfounds, 2,  2, 4);
+	sja1105_unpack(p + 0x8, &status->vlid,      31, 16, 4);
+	sja1105_unpack(p + 0x8, &status->portvl,    15,  8, 4);
+	sja1105_unpack(p + 0x8, &status->vlnotfound, 0,  0, 4);
+	sja1105_unpack(p + 0x9, &status->emptys,    31, 31, 4);
+	sja1105_unpack(p + 0x9, &status->buffers,   30,  0, 4);
+	if (IS_ET(device_id)) {
+		sja1105_unpack(p + 0xA, &status->port_0ah,   15,  8, 4);
+		sja1105_unpack(p + 0xA, &status->fwds_0ah,    1,  1, 4);
+		sja1105_unpack(p + 0xA, &status->parts,       0,  0, 4);
+		sja1105_unpack(p + 0xB, &status->ramparerrl, 20,  0, 4);
+		sja1105_unpack(p + 0xC, &status->ramparerru,  4,  0, 4);
+	} else {
+		sja1105_unpack(p + 0xA, &status->buflwmark,  30,  0, 4);
+		sja1105_unpack(p + 0xB, &status->port_0ah,   15,  8, 4);
+		sja1105_unpack(p + 0xB, &status->fwds_0ah,    1,  1, 4);
+		sja1105_unpack(p + 0xB, &status->parts,       0,  0, 4);
+		sja1105_unpack(p + 0xC, &status->ramparerrl, 22,  0, 4);
+		sja1105_unpack(p + 0xD, &status->ramparerru,  4,  0, 4);
+	}
+}
+
+static int sja1105_general_status_get(struct sja1105_private *priv,
+				      struct sja1105_general_status *status)
+{
+#define SIZE_ET   (0x0C * 4) /* 0x01 to 0x0C */
+#define SIZE_PQRS (0x0D * 4) /* 0x01 to 0x0D */
+#define MAX_SIZE (max(SIZE_ET, SIZE_PQRS))
+	u8 packed_buf[MAX_SIZE];
+	const int size = IS_ET(priv->device_id) ? SIZE_ET : SIZE_PQRS;
+	int rc;
+
+	rc = sja1105_spi_send_packed_buf(priv, SPI_READ,
+					 priv->regs->general_status,
+					 packed_buf, size);
+	if (rc < 0)
+		return rc;
+
+	sja1105_general_status_unpack(packed_buf, status, priv->device_id);
+
+	return 0;
+#undef MAX_SIZE
+#undef SIZE_PQRS
+#undef SIZE_ET
+}
+
+/* Not const because unpacking priv->static_config into buffers and preparing
+ * for upload requires the recalculation of table CRCs and updating the
+ * structures with these.
+ */
+static int
+static_config_buf_prepare_for_upload(struct sja1105_private *priv,
+				     void *config_buf, int buf_len)
+{
+	struct sja1105_static_config *config = &priv->static_config;
+	enum sja1105_static_config_validity valid;
+	struct sja1105_table_header final_header;
+	char *final_header_ptr;
+	int crc_len;
+
+	valid = sja1105_static_config_check_valid(config);
+	if (valid != SJA1105_CONFIG_OK) {
+		dev_err(&priv->spidev->dev,
+			sja1105_static_config_error_msg[valid]);
+		return -EINVAL;
+	}
+
+	if (config->device_id != priv->device_id) {
+		dev_err(&priv->spidev->dev,
+			"The static config is for device id %llx "
+			"but the chip is %s (%llx)\n", config->device_id,
+			sja1105_device_id_string_get(priv->device_id,
+						     priv->part_nr),
+			priv->device_id);
+		return -EINVAL;
+	}
+
+	/* Write Device ID and config tables to config_buf */
+	sja1105_static_config_pack(config_buf, config);
+	/* Recalculate CRC of the last header (right now 0xDEADBEEF).
+	 * Don't include the CRC field itself.
+	 */
+	crc_len = buf_len - 4;
+	/* Read the whole table header */
+	final_header_ptr = config_buf + buf_len - SIZE_TABLE_HEADER;
+	sja1105_table_header_packing(final_header_ptr, &final_header, UNPACK);
+	/* Modify */
+	final_header.crc = sja1105_crc32(config_buf, crc_len);
+	/* Rewrite */
+	sja1105_table_header_packing(final_header_ptr, &final_header, PACK);
+
+	return 0;
+}
+
+int sja1105_static_config_upload(struct sja1105_private *priv)
+{
+#define RETRIES 10
+	struct sja1105_static_config *config = &priv->static_config;
+	struct device *dev = &priv->spidev->dev;
+	struct sja1105_general_status status;
+	int rc, retries = RETRIES;
+	u8 *config_buf;
+	int buf_len;
+
+	buf_len = sja1105_static_config_get_length(config);
+	config_buf = kcalloc(buf_len, sizeof(char), GFP_KERNEL);
+	if (!config_buf)
+		return -ENOMEM;
+
+	rc = static_config_buf_prepare_for_upload(priv, config_buf, buf_len);
+	if (rc < 0) {
+		dev_err(dev, "Invalid config, cannot upload\n");
+		return -EINVAL;
+	}
+	do {
+		/* Put the SJA1105 in programming mode */
+		rc = sja1105_cold_reset(priv);
+		if (rc < 0) {
+			dev_err(dev, "Failed to reset switch, retrying...\n");
+			continue;
+		}
+		/* Wait for the switch to come out of reset */
+		usleep_range(1000, 5000);
+		/* Upload the static config to the device */
+		rc = sja1105_spi_send_long_packed_buf(priv, SPI_WRITE,
+						      priv->regs->config,
+						      config_buf, buf_len);
+		if (rc < 0) {
+			dev_err(dev, "Failed to upload config, retrying...\n");
+			continue;
+		}
+		/* Check that SJA1105 responded well to the config upload */
+		rc = sja1105_general_status_get(priv, &status);
+		if (rc < 0)
+			continue;
+
+		if (status.ids == 1) {
+			dev_err(dev, "Mismatch between hardware and staging area "
+				"device id. Wrote 0x%llx, wants 0x%llx\n",
+				config->device_id, priv->device_id);
+			continue;
+		}
+		if (status.crcchkl == 1) {
+			dev_err(dev, "Switch reported invalid local CRC on "
+				"the uploaded config, retrying...\n");
+			continue;
+		}
+		if (status.crcchkg == 1) {
+			dev_err(dev, "Switch reported invalid global CRC on "
+				"the uploaded config, retrying...\n");
+			continue;
+		}
+		if (status.configs == 0) {
+			dev_err(dev, "Switch reported that configuration is "
+				"invalid, retrying...\n");
+			continue;
+		}
+	} while (--retries && (status.crcchkl == 1 || status.crcchkg == 1 ||
+		 status.configs == 0 || status.ids == 1));
+
+	if (!retries) {
+		rc = -EIO;
+		dev_err(dev, "Failed to upload config to device, giving up\n");
+		goto out;
+	} else if (retries != RETRIES - 1) {
+		dev_info(dev, "Succeeded after %d tried\n", RETRIES - retries);
+	}
+
+	dev_info(dev, "Reset switch and programmed static config\n");
+out:
+	kfree(config_buf);
+	return rc;
+#undef RETRIES
+}
+
diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
new file mode 100644
index 000000000000..f5d1866216bd
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -0,0 +1,1036 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2016-2018, NXP Semiconductors
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include "sja1105_static_config.h"
+#include <linux/crc32.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+/* Convenience wrappers over the generic packing functions. These take into
+ * account the SJA1105 memory layout quirks and provide some level of
+ * programmer protection against incorrect API use. The errors are not expected
+ * to occur durring runtime, therefore printing and swallowing them here is
+ * appropriate instead of clutterring up higher-level code.
+ */
+void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len)
+{
+	int rc = packing(buf, (u64 *)val, start, end, len,
+			 PACK, QUIRK_LSW32_IS_FIRST);
+
+	if (likely(!rc))
+		return;
+
+	if (rc == -EINVAL) {
+		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
+		       start, end);
+	} else if (rc == -ERANGE) {
+		if ((start - end + 1) > 64)
+			pr_err("Field %d-%d too large for 64 bits!\n",
+			       start, end);
+		else
+			pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
+			       *val, start, end);
+	}
+	dump_stack();
+}
+
+void sja1105_unpack(const void *buf, u64 *val, int start, int end, size_t len)
+{
+	int rc = packing((void *)buf, val, start, end, len,
+			 UNPACK, QUIRK_LSW32_IS_FIRST);
+
+	if (likely(!rc))
+		return;
+
+	if (rc == -EINVAL)
+		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
+		       start, end);
+	else if (rc == -ERANGE)
+		pr_err("Field %d-%d too large for 64 bits!\n",
+		       start, end);
+	dump_stack();
+}
+
+void sja1105_packing(void *buf, u64 *val, int start, int end,
+		     size_t len, enum packing_op op)
+{
+	int rc = packing(buf, val, start, end, len, op, QUIRK_LSW32_IS_FIRST);
+
+	if (likely(!rc))
+		return;
+
+	if (rc == -EINVAL) {
+		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
+		       start, end);
+	} else if (rc == -ERANGE) {
+		if ((start - end + 1) > 64)
+			pr_err("Field %d-%d too large for 64 bits!\n",
+			       start, end);
+		else
+			pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
+			       *val, start, end);
+	}
+	dump_stack();
+}
+
+/* Little-endian Ethernet CRC32 of data packed as big-endian u32 words */
+u32 sja1105_crc32(const void *buf, size_t len)
+{
+	unsigned int i;
+	u64 word;
+	u32 crc;
+
+	/* seed */
+	crc = ~0;
+	for (i = 0; i < len; i += 4) {
+		sja1105_unpack((void *)buf + i, &word, 31, 0, 4);
+		crc = crc32_le(crc, (u8 *)&word, 4);
+	}
+	return ~crc;
+}
+
+static size_t sja1105et_general_params_entry_packing(void *buf, void *entry_ptr,
+						     enum packing_op op)
+{
+	const size_t size = SIZE_GENERAL_PARAMS_ENTRY_ET;
+	struct sja1105_general_params_entry *entry;
+
+	entry = (struct sja1105_general_params_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->vllupformat, 319, 319, size, op);
+	sja1105_packing(buf, &entry->mirr_ptacu,  318, 318, size, op);
+	sja1105_packing(buf, &entry->switchid,    317, 315, size, op);
+	sja1105_packing(buf, &entry->hostprio,    314, 312, size, op);
+	sja1105_packing(buf, &entry->mac_fltres1, 311, 264, size, op);
+	sja1105_packing(buf, &entry->mac_fltres0, 263, 216, size, op);
+	sja1105_packing(buf, &entry->mac_flt1,    215, 168, size, op);
+	sja1105_packing(buf, &entry->mac_flt0,    167, 120, size, op);
+	sja1105_packing(buf, &entry->incl_srcpt1, 119, 119, size, op);
+	sja1105_packing(buf, &entry->incl_srcpt0, 118, 118, size, op);
+	sja1105_packing(buf, &entry->send_meta1,  117, 117, size, op);
+	sja1105_packing(buf, &entry->send_meta0,  116, 116, size, op);
+	sja1105_packing(buf, &entry->casc_port,   115, 113, size, op);
+	sja1105_packing(buf, &entry->host_port,   112, 110, size, op);
+	sja1105_packing(buf, &entry->mirr_port,   109, 107, size, op);
+	sja1105_packing(buf, &entry->vlmarker,    106,  75, size, op);
+	sja1105_packing(buf, &entry->vlmask,       74,  43, size, op);
+	sja1105_packing(buf, &entry->tpid,         42,  27, size, op);
+	sja1105_packing(buf, &entry->ignore2stf,   26,  26, size, op);
+	sja1105_packing(buf, &entry->tpid2,        25,  10, size, op);
+	return size;
+}
+
+static size_t
+sja1105pqrs_general_params_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op)
+{
+	const size_t size = SIZE_GENERAL_PARAMS_ENTRY_PQRS;
+	struct sja1105_general_params_entry *entry;
+
+	entry = (struct sja1105_general_params_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->vllupformat, 351, 351, size, op);
+	sja1105_packing(buf, &entry->mirr_ptacu,  350, 350, size, op);
+	sja1105_packing(buf, &entry->switchid,    349, 347, size, op);
+	sja1105_packing(buf, &entry->hostprio,    346, 344, size, op);
+	sja1105_packing(buf, &entry->mac_fltres1, 343, 296, size, op);
+	sja1105_packing(buf, &entry->mac_fltres0, 295, 248, size, op);
+	sja1105_packing(buf, &entry->mac_flt1,    247, 200, size, op);
+	sja1105_packing(buf, &entry->mac_flt0,    199, 152, size, op);
+	sja1105_packing(buf, &entry->incl_srcpt1, 151, 151, size, op);
+	sja1105_packing(buf, &entry->incl_srcpt0, 150, 150, size, op);
+	sja1105_packing(buf, &entry->send_meta1,  149, 149, size, op);
+	sja1105_packing(buf, &entry->send_meta0,  148, 148, size, op);
+	sja1105_packing(buf, &entry->casc_port,   147, 145, size, op);
+	sja1105_packing(buf, &entry->host_port,   144, 142, size, op);
+	sja1105_packing(buf, &entry->mirr_port,   141, 139, size, op);
+	sja1105_packing(buf, &entry->vlmarker,    138, 107, size, op);
+	sja1105_packing(buf, &entry->vlmask,      106,  75, size, op);
+	sja1105_packing(buf, &entry->tpid,         74,  59, size, op);
+	sja1105_packing(buf, &entry->ignore2stf,   58,  58, size, op);
+	sja1105_packing(buf, &entry->tpid2,        57,  42, size, op);
+	sja1105_packing(buf, &entry->queue_ts,     41,  41, size, op);
+	sja1105_packing(buf, &entry->egrmirrvid,   40,  29, size, op);
+	sja1105_packing(buf, &entry->egrmirrpcp,   28,  26, size, op);
+	sja1105_packing(buf, &entry->egrmirrdei,   25,  25, size, op);
+	sja1105_packing(buf, &entry->replay_port,  24,  22, size, op);
+	return size;
+}
+
+static size_t
+sja1105_l2_forwarding_params_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op)
+{
+	const size_t size = SIZE_L2_FORWARDING_PARAMS_ENTRY;
+	struct sja1105_l2_forwarding_params_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_l2_forwarding_params_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->max_dynp, 95, 93, size, op);
+	for (i = 0, offset = 13; i < 8; i++, offset += 10)
+		sja1105_packing(buf, &entry->part_spc[i],
+				offset + 9, offset + 0, size, op);
+	return size;
+}
+
+size_t sja1105_l2_forwarding_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op)
+{
+	const size_t size = SIZE_L2_FORWARDING_ENTRY;
+	struct sja1105_l2_forwarding_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_l2_forwarding_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->bc_domain,  63, 59, size, op);
+	sja1105_packing(buf, &entry->reach_port, 58, 54, size, op);
+	sja1105_packing(buf, &entry->fl_domain,  53, 49, size, op);
+	for (i = 0, offset = 25; i < 8; i++, offset += 3)
+		sja1105_packing(buf, &entry->vlan_pmap[i],
+				offset + 2, offset + 0, size, op);
+	return size;
+}
+
+static size_t
+sja1105et_l2_lookup_params_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op)
+{
+	const size_t size = SIZE_L2_LOOKUP_PARAMS_ENTRY_ET;
+	struct sja1105_l2_lookup_params_entry *entry;
+
+	entry = (struct sja1105_l2_lookup_params_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->maxage,         31, 17, size, op);
+	sja1105_packing(buf, &entry->dyn_tbsz,       16, 14, size, op);
+	sja1105_packing(buf, &entry->poly,           13,  6, size, op);
+	sja1105_packing(buf, &entry->shared_learn,    5,  5, size, op);
+	sja1105_packing(buf, &entry->no_enf_hostprt,  4,  4, size, op);
+	sja1105_packing(buf, &entry->no_mgmt_learn,   3,  3, size, op);
+	return size;
+}
+
+static size_t
+sja1105pqrs_l2_lookup_params_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op)
+{
+	const size_t size = SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS;
+	struct sja1105_l2_lookup_params_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_l2_lookup_params_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->drpbc,         127, 123, size, op);
+	sja1105_packing(buf, &entry->drpmc,         122, 118, size, op);
+	sja1105_packing(buf, &entry->drpuni,        117, 113, size, op);
+	for (i = 0, offset = 58; i < 5; i++, offset += 11)
+		sja1105_packing(buf, &entry->maxaddrp[i],
+				offset + 10, offset + 0, size, op);
+	sja1105_packing(buf, &entry->maxage,         57,  43, size, op);
+	sja1105_packing(buf, &entry->start_dynspc,   42,  33, size, op);
+	sja1105_packing(buf, &entry->drpnolearn,     32,  28, size, op);
+	sja1105_packing(buf, &entry->shared_learn,   27,  27, size, op);
+	sja1105_packing(buf, &entry->no_enf_hostprt, 26,  26, size, op);
+	sja1105_packing(buf, &entry->no_mgmt_learn,  25,  25, size, op);
+	sja1105_packing(buf, &entry->use_static,     24,  24, size, op);
+	sja1105_packing(buf, &entry->owr_dyn,        23,  23, size, op);
+	sja1105_packing(buf, &entry->learn_once,     22,  22, size, op);
+	return size;
+}
+
+size_t sja1105et_l2_lookup_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op)
+{
+	const size_t size = SIZE_L2_LOOKUP_ENTRY_ET;
+	struct sja1105_l2_lookup_entry *entry;
+
+	entry = (struct sja1105_l2_lookup_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->vlanid,    95, 84, size, op);
+	sja1105_packing(buf, &entry->macaddr,   83, 36, size, op);
+	sja1105_packing(buf, &entry->destports, 35, 31, size, op);
+	sja1105_packing(buf, &entry->enfport,   30, 30, size, op);
+	sja1105_packing(buf, &entry->index,     29, 20, size, op);
+	return size;
+}
+
+size_t sja1105pqrs_l2_lookup_entry_packing(void *buf, void *entry_ptr,
+					   enum packing_op op)
+{
+	const size_t size = SIZE_L2_LOOKUP_ENTRY_PQRS;
+	struct sja1105_l2_lookup_entry *entry;
+
+	entry = (struct sja1105_l2_lookup_entry *)entry_ptr;
+
+	/* These are static L2 lookup entries, so the structure
+	 * should match UM11040 Table 16/17 definitions when
+	 * LOCKEDS is 1.
+	 */
+	sja1105_packing(buf, &entry->mirrvlan,     158, 147, size, op);
+	sja1105_packing(buf, &entry->mirr,         145, 145, size, op);
+	sja1105_packing(buf, &entry->retag,        144, 144, size, op);
+	sja1105_packing(buf, &entry->mask_iotag,   143, 143, size, op);
+	sja1105_packing(buf, &entry->mask_vlanid,  142, 131, size, op);
+	sja1105_packing(buf, &entry->mask_macaddr, 130,  83, size, op);
+	sja1105_packing(buf, &entry->iotag,         82,  82, size, op);
+	sja1105_packing(buf, &entry->vlanid,        81,  70, size, op);
+	sja1105_packing(buf, &entry->macaddr,       69,  22, size, op);
+	sja1105_packing(buf, &entry->destports,     21,  17, size, op);
+	sja1105_packing(buf, &entry->enfport,       16,  16, size, op);
+	sja1105_packing(buf, &entry->index,         15,   6, size, op);
+	return size;
+}
+
+static size_t sja1105_l2_policing_entry_packing(void *buf, void *entry_ptr,
+						enum packing_op op)
+{
+	const size_t size = SIZE_L2_POLICING_ENTRY;
+	struct sja1105_l2_policing_entry *entry;
+
+	entry = (struct sja1105_l2_policing_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->sharindx,  63, 58, size, op);
+	sja1105_packing(buf, &entry->smax,      57, 42, size, op);
+	sja1105_packing(buf, &entry->rate,      41, 26, size, op);
+	sja1105_packing(buf, &entry->maxlen,    25, 15, size, op);
+	sja1105_packing(buf, &entry->partition, 14, 12, size, op);
+	return size;
+}
+
+static size_t sja1105et_mac_config_entry_packing(void *buf, void *entry_ptr,
+						 enum packing_op op)
+{
+	const size_t size = SIZE_MAC_CONFIG_ENTRY_ET;
+	struct sja1105_mac_config_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_mac_config_entry *)entry_ptr;
+
+	for (i = 0, offset = 72; i < 8; i++, offset += 19) {
+		sja1105_packing(buf, &entry->enabled[i],
+				offset +  0, offset +  0, size, op);
+		sja1105_packing(buf, &entry->base[i],
+				offset +  9, offset +  1, size, op);
+		sja1105_packing(buf, &entry->top[i],
+				offset + 18, offset + 10, size, op);
+	}
+	sja1105_packing(buf, &entry->ifg,       71, 67, size, op);
+	sja1105_packing(buf, &entry->speed,     66, 65, size, op);
+	sja1105_packing(buf, &entry->tp_delin,  64, 49, size, op);
+	sja1105_packing(buf, &entry->tp_delout, 48, 33, size, op);
+	sja1105_packing(buf, &entry->maxage,    32, 25, size, op);
+	sja1105_packing(buf, &entry->vlanprio,  24, 22, size, op);
+	sja1105_packing(buf, &entry->vlanid,    21, 10, size, op);
+	sja1105_packing(buf, &entry->ing_mirr,   9,  9, size, op);
+	sja1105_packing(buf, &entry->egr_mirr,   8,  8, size, op);
+	sja1105_packing(buf, &entry->drpnona664, 7,  7, size, op);
+	sja1105_packing(buf, &entry->drpdtag,    6,  6, size, op);
+	sja1105_packing(buf, &entry->drpuntag,   5,  5, size, op);
+	sja1105_packing(buf, &entry->retag,      4,  4, size, op);
+	sja1105_packing(buf, &entry->dyn_learn,  3,  3, size, op);
+	sja1105_packing(buf, &entry->egress,     2,  2, size, op);
+	sja1105_packing(buf, &entry->ingress,    1,  1, size, op);
+	return size;
+}
+
+size_t sja1105pqrs_mac_config_entry_packing(void *buf, void *entry_ptr,
+					    enum packing_op op)
+{
+	const size_t size = SIZE_MAC_CONFIG_ENTRY_PQRS;
+	struct sja1105_mac_config_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_mac_config_entry *)entry_ptr;
+
+	for (i = 0, offset = 104; i < 8; i++, offset += 19) {
+		sja1105_packing(buf, &entry->enabled[i],
+				offset +  0, offset +  0, size, op);
+		sja1105_packing(buf, &entry->base[i],
+				offset +  9, offset +  1, size, op);
+		sja1105_packing(buf, &entry->top[i],
+				offset + 18, offset + 10, size, op);
+	}
+	sja1105_packing(buf, &entry->ifg,       103, 99, size, op);
+	sja1105_packing(buf, &entry->speed,      98, 97, size, op);
+	sja1105_packing(buf, &entry->tp_delin,   96, 81, size, op);
+	sja1105_packing(buf, &entry->tp_delout,  80, 65, size, op);
+	sja1105_packing(buf, &entry->maxage,     64, 57, size, op);
+	sja1105_packing(buf, &entry->vlanprio,   56, 54, size, op);
+	sja1105_packing(buf, &entry->vlanid,     53, 42, size, op);
+	sja1105_packing(buf, &entry->ing_mirr,   41, 41, size, op);
+	sja1105_packing(buf, &entry->egr_mirr,   40, 40, size, op);
+	sja1105_packing(buf, &entry->drpnona664, 39, 39, size, op);
+	sja1105_packing(buf, &entry->drpdtag,    38, 38, size, op);
+	sja1105_packing(buf, &entry->drpsotag,   37, 37, size, op);
+	sja1105_packing(buf, &entry->drpsitag,   36, 36, size, op);
+	sja1105_packing(buf, &entry->drpuntag,   35, 35, size, op);
+	sja1105_packing(buf, &entry->retag,      34, 34, size, op);
+	sja1105_packing(buf, &entry->dyn_learn,  33, 33, size, op);
+	sja1105_packing(buf, &entry->egress,     32, 32, size, op);
+	sja1105_packing(buf, &entry->ingress,    31, 31, size, op);
+	sja1105_packing(buf, &entry->mirrcie,    30, 30, size, op);
+	sja1105_packing(buf, &entry->mirrcetag,  29, 29, size, op);
+	sja1105_packing(buf, &entry->ingmirrvid, 28, 17, size, op);
+	sja1105_packing(buf, &entry->ingmirrpcp, 16, 14, size, op);
+	sja1105_packing(buf, &entry->ingmirrdei, 13, 13, size, op);
+	return size;
+}
+
+size_t sja1105_vlan_lookup_entry_packing(void *buf, void *entry_ptr,
+					 enum packing_op op)
+{
+	const size_t size = SIZE_VLAN_LOOKUP_ENTRY;
+	struct sja1105_vlan_lookup_entry *entry;
+
+	entry = (struct sja1105_vlan_lookup_entry *)entry_ptr;
+
+	sja1105_packing(buf, &entry->ving_mirr,  63, 59, size, op);
+	sja1105_packing(buf, &entry->vegr_mirr,  58, 54, size, op);
+	sja1105_packing(buf, &entry->vmemb_port, 53, 49, size, op);
+	sja1105_packing(buf, &entry->vlan_bc,    48, 44, size, op);
+	sja1105_packing(buf, &entry->tag_port,   43, 39, size, op);
+	sja1105_packing(buf, &entry->vlanid,     38, 27, size, op);
+	return size;
+}
+
+static size_t sja1105_xmii_params_entry_packing(void *buf, void *entry_ptr,
+						enum packing_op op)
+{
+	const size_t size = SIZE_XMII_PARAMS_ENTRY;
+	struct sja1105_xmii_params_entry *entry;
+	int offset, i;
+
+	entry = (struct sja1105_xmii_params_entry *)entry_ptr;
+
+	for (i = 0, offset = 17; i < 5; i++, offset += 3) {
+		sja1105_packing(buf, &entry->xmii_mode[i],
+				offset + 1, offset + 0, size, op);
+		sja1105_packing(buf, &entry->phy_mac[i],
+				offset + 2, offset + 2, size, op);
+	}
+	return size;
+}
+
+size_t sja1105_table_header_packing(void *buf, void *entry_ptr,
+				    enum packing_op op)
+{
+	const size_t size = SIZE_TABLE_HEADER;
+	struct sja1105_table_header *entry;
+
+	entry = (struct sja1105_table_header *)entry_ptr;
+
+	sja1105_packing(buf, &entry->block_id, 31, 24, size, op);
+	sja1105_packing(buf, &entry->len,      55, 32, size, op);
+	sja1105_packing(buf, &entry->crc,      95, 64, size, op);
+	return size;
+}
+
+/* WARNING: the *hdr pointer is really non-const, because it is
+ * modifying the CRC of the header for a 2-stage packing operation
+ */
+void
+sja1105_table_header_pack_with_crc(void *buf, struct sja1105_table_header *hdr)
+{
+	/* First pack the table as-is, then calculate the CRC, and
+	 * finally put the proper CRC into the packed buffer
+	 */
+	memset(buf, 0, SIZE_TABLE_HEADER);
+	sja1105_table_header_packing(buf, hdr, PACK);
+	hdr->crc = sja1105_crc32(buf, SIZE_TABLE_HEADER - 4);
+	sja1105_pack(buf + SIZE_TABLE_HEADER - 4, &hdr->crc, 31, 0, 4);
+}
+
+static void sja1105_table_write_crc(u8 *table_start, u8 *crc_ptr)
+{
+	u64 computed_crc;
+	int len_bytes;
+
+	len_bytes = (uintptr_t)(crc_ptr - table_start);
+	computed_crc = sja1105_crc32(table_start, len_bytes);
+	sja1105_pack(crc_ptr, &computed_crc, 31, 0, 4);
+}
+
+/* The block IDs that the switches support are unfortunately sparse, so keep a
+ * mapping table to "block indices" and translate back and forth so that we
+ * don't waste useless memory in struct sja1105_static_config.
+ * Also, since the block id comes from essentially untrusted input (unpacking
+ * the static config from userspace) it has to be sanitized (range-checked)
+ * before blindly indexing kernel memory with the blk_idx.
+ */
+static u64 blk_id_map[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = BLKID_L2_LOOKUP,
+	[BLK_IDX_L2_POLICING] = BLKID_L2_POLICING,
+	[BLK_IDX_VLAN_LOOKUP] = BLKID_VLAN_LOOKUP,
+	[BLK_IDX_L2_FORWARDING] = BLKID_L2_FORWARDING,
+	[BLK_IDX_MAC_CONFIG] = BLKID_MAC_CONFIG,
+	[BLK_IDX_L2_LOOKUP_PARAMS] = BLKID_L2_LOOKUP_PARAMS,
+	[BLK_IDX_L2_FORWARDING_PARAMS] = BLKID_L2_FORWARDING_PARAMS,
+	[BLK_IDX_GENERAL_PARAMS] = BLKID_GENERAL_PARAMS,
+	[BLK_IDX_XMII_PARAMS] = BLKID_XMII_PARAMS,
+};
+
+const char *sja1105_static_config_error_msg[] = {
+	[SJA1105_CONFIG_OK] = "",
+	[SJA1105_DEVICE_ID_INVALID] =
+		"Device ID present in the static config is invalid",
+	[SJA1105_MISSING_L2_POLICING_TABLE] =
+		"l2-policing-table needs to have at least one entry",
+	[SJA1105_MISSING_L2_FORWARDING_TABLE] =
+		"l2-forwarding-table is either missing or incomplete",
+	[SJA1105_MISSING_L2_FORWARDING_PARAMS_TABLE] =
+		"l2-forwarding-parameters-table is missing",
+	[SJA1105_MISSING_GENERAL_PARAMS_TABLE] =
+		"general-parameters-table is missing",
+	[SJA1105_MISSING_VLAN_TABLE] =
+		"vlan-lookup-table needs to have at least the default untagged VLAN",
+	[SJA1105_MISSING_XMII_TABLE] =
+		"xmii-table is missing",
+	[SJA1105_MISSING_MAC_TABLE] =
+		"mac-configuration-table needs to contain an entry for each port",
+	[SJA1105_OVERCOMMITTED_FRAME_MEMORY] =
+		"Not allowed to overcommit frame memory. L2 memory partitions "
+		"and VL memory partitions share the same space. The sum of all "
+		"16 memory partitions is not allowed to be larger than 929 "
+		"128-byte blocks (or 910 with retagging). Please adjust "
+		"l2-forwarding-parameters-table.part_spc and/or "
+		"vl-forwarding-parameters-table.partspc.",
+	[SJA1105_UNEXPECTED_END_OF_BUFFER] =
+		"Unexpected end of buffer",
+	[SJA1105_INVALID_DEVICE_ID] =
+		"Invalid device ID present in static config",
+	[SJA1105_INVALID_TABLE_HEADER_CRC] =
+		"One of the table headers has an incorrect CRC",
+	[SJA1105_INVALID_TABLE_HEADER] =
+		"One of the table headers contains an invalid block id",
+	[SJA1105_INCORRECT_TABLE_LENGTH] =
+		"The data length specified in one of the table headers is "
+		"longer than the actual size of the entries that were parsed",
+	[SJA1105_DATA_CRC_INVALID] =
+		"One of the tables has an incorrect CRC over the data area",
+	[SJA1105_EXTRA_BYTES_AT_END_OF_BUFFER] =
+		"Extra bytes found at the end of buffer after parsing it",
+};
+
+static enum sja1105_static_config_validity
+static_config_check_memory_size(const struct sja1105_table *tables)
+{
+	const struct sja1105_l2_forwarding_params_entry *l2_fwd_params;
+	int i, mem = 0;
+
+	l2_fwd_params = tables[BLK_IDX_L2_FORWARDING_PARAMS].entries;
+
+	for (i = 0; i < 8; i++)
+		mem += l2_fwd_params->part_spc[i];
+
+	if (mem > MAX_FRAME_MEMORY)
+		return SJA1105_OVERCOMMITTED_FRAME_MEMORY;
+
+	return SJA1105_CONFIG_OK;
+}
+
+enum sja1105_static_config_validity
+sja1105_static_config_check_valid(const struct sja1105_static_config *config)
+{
+	const struct sja1105_table *tables = config->tables;
+#define IS_FULL(blk_idx) \
+	(tables[blk_idx].entry_count == tables[blk_idx].ops->max_entry_count)
+
+	if (!DEVICE_ID_VALID(config->device_id))
+		return SJA1105_DEVICE_ID_INVALID;
+
+	if (tables[BLK_IDX_L2_POLICING].entry_count == 0)
+		return SJA1105_MISSING_L2_POLICING_TABLE;
+
+	if (tables[BLK_IDX_VLAN_LOOKUP].entry_count == 0)
+		return SJA1105_MISSING_VLAN_TABLE;
+
+	if (!IS_FULL(BLK_IDX_L2_FORWARDING))
+		return SJA1105_MISSING_L2_FORWARDING_TABLE;
+
+	if (!IS_FULL(BLK_IDX_MAC_CONFIG))
+		return SJA1105_MISSING_MAC_TABLE;
+
+	if (!IS_FULL(BLK_IDX_L2_FORWARDING_PARAMS))
+		return SJA1105_MISSING_L2_FORWARDING_PARAMS_TABLE;
+
+	if (!IS_FULL(BLK_IDX_GENERAL_PARAMS))
+		return SJA1105_MISSING_GENERAL_PARAMS_TABLE;
+
+	if (!IS_FULL(BLK_IDX_XMII_PARAMS))
+		return SJA1105_MISSING_XMII_TABLE;
+
+	return static_config_check_memory_size(tables);
+#undef IS_FULL
+}
+
+void
+sja1105_static_config_pack(void *buf, struct sja1105_static_config *config)
+{
+	struct sja1105_table_header header = {0};
+	enum sja1105_blk_idx i;
+	char *p = buf;
+	int j;
+
+	sja1105_pack(p, &config->device_id, 31, 0, 4);
+	p += SIZE_SJA1105_DEVICE_ID;
+
+	for (i = 0; i < BLK_IDX_MAX; i++) {
+		const struct sja1105_table *table;
+		char *table_start;
+
+		table = &config->tables[i];
+		if (!table->entry_count)
+			continue;
+
+		header.block_id = blk_id_map[i];
+		header.len = table->entry_count *
+			     table->ops->packed_entry_size / 4;
+		sja1105_table_header_pack_with_crc(p, &header);
+		p += SIZE_TABLE_HEADER;
+		table_start = p;
+		for (j = 0; j < table->entry_count; j++) {
+			u8 *entry_ptr = table->entries;
+
+			entry_ptr += j * table->ops->unpacked_entry_size;
+			memset(p, 0, table->ops->packed_entry_size);
+			table->ops->packing(p, entry_ptr, PACK);
+			p += table->ops->packed_entry_size;
+		}
+		sja1105_table_write_crc(table_start, p);
+		p += 4;
+	}
+	/* Final header:
+	 * Block ID does not matter
+	 * Length of 0 marks that header is final
+	 * CRC will be replaced on-the-fly on "config upload"
+	 */
+	header.block_id = 0;
+	header.len = 0;
+	header.crc = 0xDEADBEEF;
+	memset(p, 0, SIZE_TABLE_HEADER);
+	sja1105_table_header_packing(p, &header, PACK);
+}
+
+size_t
+sja1105_static_config_get_length(const struct sja1105_static_config *config)
+{
+	unsigned int sum;
+	unsigned int header_count;
+	enum sja1105_blk_idx i;
+
+	/* Ending header */
+	header_count = 1;
+	sum = SIZE_SJA1105_DEVICE_ID;
+
+	/* Tables (headers and entries) */
+	for (i = 0; i < BLK_IDX_MAX; i++) {
+		const struct sja1105_table *table;
+
+		table = &config->tables[i];
+		if (table->entry_count)
+			header_count++;
+
+		sum += table->ops->packed_entry_size * table->entry_count;
+	}
+	/* Headers have an additional CRC at the end */
+	sum += header_count * (SIZE_TABLE_HEADER + 4);
+	/* Last header does not have an extra CRC because there is no data */
+	sum -= 4;
+
+	return sum;
+}
+
+/* Compatibility matrices */
+
+/* SJA1105E: First generation, no TTEthernet */
+static struct sja1105_table_ops sja1105e_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105et_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_ET,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105et_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_ET,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105et_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_ET,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105et_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_ET,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+/* SJA1105T: First generation, TTEthernet */
+static struct sja1105_table_ops sja1105t_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105et_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_ET,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105et_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_ET,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105et_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_ET,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105et_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_ET,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+/* SJA1105P: Second generation, no TTEthernet, no SGMII */
+static struct sja1105_table_ops sja1105p_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105pqrs_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105pqrs_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_PQRS,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105pqrs_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105pqrs_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+/* SJA1105Q: Second generation, TTEthernet, no SGMII */
+static struct sja1105_table_ops sja1105q_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105pqrs_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105pqrs_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_PQRS,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105pqrs_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105pqrs_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+/* SJA1105R: Second generation, no TTEthernet, SGMII */
+static struct sja1105_table_ops sja1105r_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105pqrs_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105pqrs_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_PQRS,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105pqrs_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105pqrs_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+/* SJA1105S: Second generation, TTEthernet, SGMII */
+static struct sja1105_table_ops sja1105s_table_ops[BLK_IDX_MAX] = {
+	[BLK_IDX_L2_LOOKUP] = {
+		.packing = sja1105pqrs_l2_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_POLICING] = {
+		.packing = sja1105_l2_policing_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_policing_entry),
+		.packed_entry_size = SIZE_L2_POLICING_ENTRY,
+		.max_entry_count = MAX_L2_POLICING_COUNT,
+	},
+	[BLK_IDX_VLAN_LOOKUP] = {
+		.packing = sja1105_vlan_lookup_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_vlan_lookup_entry),
+		.packed_entry_size = SIZE_VLAN_LOOKUP_ENTRY,
+		.max_entry_count = MAX_VLAN_LOOKUP_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING] = {
+		.packing = sja1105_l2_forwarding_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_COUNT,
+	},
+	[BLK_IDX_MAC_CONFIG] = {
+		.packing = sja1105pqrs_mac_config_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_mac_config_entry),
+		.packed_entry_size = SIZE_MAC_CONFIG_ENTRY_PQRS,
+		.max_entry_count = MAX_MAC_CONFIG_COUNT,
+	},
+	[BLK_IDX_L2_LOOKUP_PARAMS] = {
+		.packing = sja1105pqrs_l2_lookup_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_lookup_params_entry),
+		.packed_entry_size = SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_L2_LOOKUP_PARAMS_COUNT,
+	},
+	[BLK_IDX_L2_FORWARDING_PARAMS] = {
+		.packing = sja1105_l2_forwarding_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_l2_forwarding_params_entry),
+		.packed_entry_size = SIZE_L2_FORWARDING_PARAMS_ENTRY,
+		.max_entry_count = MAX_L2_FORWARDING_PARAMS_COUNT,
+	},
+	[BLK_IDX_GENERAL_PARAMS] = {
+		.packing = sja1105pqrs_general_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_general_params_entry),
+		.packed_entry_size = SIZE_GENERAL_PARAMS_ENTRY_PQRS,
+		.max_entry_count = MAX_GENERAL_PARAMS_COUNT,
+	},
+	[BLK_IDX_XMII_PARAMS] = {
+		.packing = sja1105_xmii_params_entry_packing,
+		.unpacked_entry_size = sizeof(struct sja1105_xmii_params_entry),
+		.packed_entry_size = SIZE_XMII_PARAMS_ENTRY,
+		.max_entry_count = MAX_XMII_PARAMS_COUNT,
+	},
+};
+
+int sja1105_static_config_init(struct sja1105_static_config *config,
+			       u64 device_id, u64 part_nr)
+{
+	const struct sja1105_table_ops *ops;
+	enum sja1105_blk_idx i;
+
+	memset(config, 0, sizeof(*config));
+
+	if (device_id == SJA1105E_DEVICE_ID)
+		ops = sja1105e_table_ops;
+	else if (device_id == SJA1105T_DEVICE_ID)
+		ops = sja1105t_table_ops;
+	else if (IS_P(device_id, part_nr))
+		ops = sja1105p_table_ops;
+	else if (IS_Q(device_id, part_nr))
+		ops = sja1105q_table_ops;
+	else if (IS_R(device_id, part_nr))
+		ops = sja1105r_table_ops;
+	else if (IS_S(device_id, part_nr))
+		ops = sja1105s_table_ops;
+	else
+		return -EINVAL;
+
+	for (i = 0; i < BLK_IDX_MAX; i++)
+		config->tables[i].ops = &ops[i];
+
+	config->device_id = device_id;
+	return 0;
+}
+
+void sja1105_static_config_free(struct sja1105_static_config *config)
+{
+	enum sja1105_blk_idx i;
+
+	for (i = 0; i < BLK_IDX_MAX; i++) {
+		if (config->tables[i].entry_count) {
+			kfree(config->tables[i].entries);
+			config->tables[i].entry_count = 0;
+		}
+	}
+}
+
diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.h b/drivers/net/dsa/sja1105/sja1105_static_config.h
new file mode 100644
index 000000000000..1c331c9e20b3
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2016-2018, NXP Semiconductors
+ * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#ifndef _SJA1105_STATIC_CONFIG_H
+#define _SJA1105_STATIC_CONFIG_H
+
+#include <linux/packing.h>
+
+#define SIZE_SJA1105_DEVICE_ID                  4
+#define SIZE_TABLE_HEADER                       12
+#define SIZE_L2_LOOKUP_ENTRY_ET                 12
+#define SIZE_L2_LOOKUP_ENTRY_PQRS               20
+#define SIZE_L2_POLICING_ENTRY                  8
+#define SIZE_VLAN_LOOKUP_ENTRY                  8
+#define SIZE_L2_FORWARDING_ENTRY                8
+#define SIZE_MAC_CONFIG_ENTRY_ET                28
+#define SIZE_MAC_CONFIG_ENTRY_PQRS              32
+#define SIZE_L2_LOOKUP_PARAMS_ENTRY_ET          4
+#define SIZE_L2_LOOKUP_PARAMS_ENTRY_PQRS        16
+#define SIZE_L2_FORWARDING_PARAMS_ENTRY         12
+#define SIZE_GENERAL_PARAMS_ENTRY_ET            40
+#define SIZE_GENERAL_PARAMS_ENTRY_PQRS          44
+#define SIZE_XMII_PARAMS_ENTRY                  4
+
+/* UM10944.pdf Page 11, Table 2. Configuration Blocks */
+#define BLKID_L2_LOOKUP                    0x05
+#define BLKID_L2_POLICING                  0x06
+#define BLKID_VLAN_LOOKUP                  0x07
+#define BLKID_L2_FORWARDING                0x08
+#define BLKID_MAC_CONFIG                   0x09
+#define BLKID_L2_LOOKUP_PARAMS             0x0D
+#define BLKID_L2_FORWARDING_PARAMS         0x0E
+#define BLKID_GENERAL_PARAMS               0x11
+#define BLKID_XMII_PARAMS                  0x4E
+#define BLKID_MAX                          BLKID_XMII_PARAMS
+
+enum sja1105_blk_idx {
+	BLK_IDX_L2_LOOKUP = 0,
+	BLK_IDX_L2_POLICING,
+	BLK_IDX_VLAN_LOOKUP,
+	BLK_IDX_L2_FORWARDING,
+	BLK_IDX_MAC_CONFIG,
+	BLK_IDX_L2_LOOKUP_PARAMS,
+	BLK_IDX_L2_FORWARDING_PARAMS,
+	BLK_IDX_GENERAL_PARAMS,
+	BLK_IDX_XMII_PARAMS,
+	BLK_IDX_MAX,
+	/* Fake block indices that are only valid for dynamic access */
+	BLK_IDX_MGMT_ROUTE,
+	BLK_IDX_MAX_DYN,
+	BLK_IDX_INVAL = -1,
+};
+
+#define MAX_L2_LOOKUP_COUNT                      1024
+#define MAX_L2_POLICING_COUNT                    45
+#define MAX_VLAN_LOOKUP_COUNT                    4096
+#define MAX_L2_FORWARDING_COUNT                  13
+#define MAX_MAC_CONFIG_COUNT                     5
+#define MAX_L2_LOOKUP_PARAMS_COUNT               1
+#define MAX_L2_FORWARDING_PARAMS_COUNT           1
+#define MAX_GENERAL_PARAMS_COUNT                 1
+#define MAX_XMII_PARAMS_COUNT                    1
+
+#define MAX_FRAME_MEMORY                         929
+#define MAX_FRAME_MEMORY_RETAGGING               910
+
+#define SJA1105E_DEVICE_ID         0x9C00000Cull
+#define SJA1105T_DEVICE_ID         0x9E00030Eull
+#define SJA1105PR_DEVICE_ID        0xAF00030Eull
+#define SJA1105QS_DEVICE_ID        0xAE00030Eull
+#define SJA1105_NO_DEVICE_ID       0x00000000ull
+
+#define SJA1105P_PART_NR           0x9A84
+#define SJA1105Q_PART_NR           0x9A85
+#define SJA1105R_PART_NR           0x9A86
+#define SJA1105S_PART_NR           0x9A87
+#define SJA1105_PART_NR_DONT_CARE  0xFFFF
+
+#define IS_PQRS(device_id) \
+	(((device_id) == SJA1105PR_DEVICE_ID) || \
+	 ((device_id) == SJA1105QS_DEVICE_ID))
+#define IS_ET(device_id) \
+	(((device_id) == SJA1105E_DEVICE_ID) || \
+	 ((device_id) == SJA1105T_DEVICE_ID))
+/* P and R have same Device ID, and differ by Part Number */
+#define IS_P(device_id, part_nr) \
+	(((device_id) == SJA1105PR_DEVICE_ID) && \
+	 ((part_nr) == SJA1105P_PART_NR))
+#define IS_R(device_id, part_nr) \
+	(((device_id) == SJA1105PR_DEVICE_ID) && \
+	 ((part_nr) == SJA1105R_PART_NR))
+/* Same do Q and S */
+#define IS_Q(device_id, part_nr) \
+	(((device_id) == SJA1105QS_DEVICE_ID) && \
+	 ((part_nr) == SJA1105Q_PART_NR))
+#define IS_S(device_id, part_nr) \
+	(((device_id) == SJA1105QS_DEVICE_ID) && \
+	 ((part_nr) == SJA1105S_PART_NR))
+#define DEVICE_ID_VALID(device_id) \
+	(IS_ET(device_id) || IS_PQRS(device_id))
+
+#ifdef __KERNEL__
+#include <asm/types.h>
+#include <linux/types.h>
+#endif
+
+struct sja1105_general_params_entry {
+	u64 vllupformat;
+	u64 mirr_ptacu;
+	u64 switchid;
+	u64 hostprio;
+	u64 mac_fltres1;
+	u64 mac_fltres0;
+	u64 mac_flt1;
+	u64 mac_flt0;
+	u64 incl_srcpt1;
+	u64 incl_srcpt0;
+	u64 send_meta1;
+	u64 send_meta0;
+	u64 casc_port;
+	u64 host_port;
+	u64 mirr_port;
+	u64 vlmarker;
+	u64 vlmask;
+	u64 tpid;
+	u64 ignore2stf;
+	u64 tpid2;
+	/* P/Q/R/S only */
+	u64 queue_ts;
+	u64 egrmirrvid;
+	u64 egrmirrpcp;
+	u64 egrmirrdei;
+	u64 replay_port;
+};
+
+struct sja1105_vlan_lookup_entry {
+	u64 ving_mirr;
+	u64 vegr_mirr;
+	u64 vmemb_port;
+	u64 vlan_bc;
+	u64 tag_port;
+	u64 vlanid;
+};
+
+struct sja1105_l2_lookup_entry {
+	u64 mirrvlan;      /* P/Q/R/S only - LOCKEDS=1 */
+	u64 mirr;          /* P/Q/R/S only - LOCKEDS=1 */
+	u64 retag;         /* P/Q/R/S only - LOCKEDS=1 */
+	u64 mask_iotag;    /* P/Q/R/S only */
+	u64 mask_vlanid;   /* P/Q/R/S only */
+	u64 mask_macaddr;  /* P/Q/R/S only */
+	u64 iotag;         /* P/Q/R/S only */
+	u64 vlanid;
+	u64 macaddr;
+	u64 destports;
+	u64 enfport;
+	u64 index;
+};
+
+struct sja1105_l2_lookup_params_entry {
+	u64 drpbc;           /* P/Q/R/S only */
+	u64 drpmc;           /* P/Q/R/S only */
+	u64 drpuni;          /* P/Q/R/S only */
+	u64 maxaddrp[5];     /* P/Q/R/S only */
+	u64 start_dynspc;    /* P/Q/R/S only */
+	u64 drpnolearn;      /* P/Q/R/S only */
+	u64 use_static;      /* P/Q/R/S only */
+	u64 owr_dyn;         /* P/Q/R/S only */
+	u64 learn_once;      /* P/Q/R/S only */
+	u64 maxage;          /* Shared */
+	u64 dyn_tbsz;        /* E/T only */
+	u64 poly;            /* E/T only */
+	u64 shared_learn;    /* Shared */
+	u64 no_enf_hostprt;  /* Shared */
+	u64 no_mgmt_learn;   /* Shared */
+};
+
+struct sja1105_l2_forwarding_entry {
+	u64 bc_domain;
+	u64 reach_port;
+	u64 fl_domain;
+	u64 vlan_pmap[8];
+};
+
+struct sja1105_l2_forwarding_params_entry {
+	u64 max_dynp;
+	u64 part_spc[8];
+};
+
+struct sja1105_l2_policing_entry {
+	u64 sharindx;
+	u64 smax;
+	u64 rate;
+	u64 maxlen;
+	u64 partition;
+};
+
+struct sja1105_mac_config_entry {
+	u64 top[8];
+	u64 base[8];
+	u64 enabled[8];
+	u64 ifg;
+	u64 speed;
+	u64 tp_delin;
+	u64 tp_delout;
+	u64 maxage;
+	u64 vlanprio;
+	u64 vlanid;
+	u64 ing_mirr;
+	u64 egr_mirr;
+	u64 drpnona664;
+	u64 drpdtag;
+	u64 drpsotag;   /* only on P/Q/R/S */
+	u64 drpsitag;   /* only on P/Q/R/S */
+	u64 drpuntag;
+	u64 retag;
+	u64 dyn_learn;
+	u64 egress;
+	u64 ingress;
+	u64 mirrcie;    /* only on P/Q/R/S */
+	u64 mirrcetag;  /* only on P/Q/R/S */
+	u64 ingmirrvid; /* only on P/Q/R/S */
+	u64 ingmirrpcp; /* only on P/Q/R/S */
+	u64 ingmirrdei; /* only on P/Q/R/S */
+};
+
+struct sja1105_xmii_params_entry {
+	u64 phy_mac[5];
+	u64 xmii_mode[5];
+};
+
+struct sja1105_avb_params_entry {
+	u64 l2cbs; /* only on P/Q/R/S */
+	u64 cas_master; /* only on P/Q/R/S */
+	u64 destmeta;
+	u64 srcmeta;
+};
+
+struct sja1105_table_header {
+	u64 block_id;
+	u64 len;
+	u64 crc;
+};
+
+struct sja1105_table_ops {
+	size_t (*packing)(void *buf, void *entry_ptr, enum packing_op op);
+	size_t unpacked_entry_size;
+	size_t packed_entry_size;
+	size_t max_entry_count;
+};
+
+struct sja1105_table {
+	const struct sja1105_table_ops *ops;
+	size_t entry_count;
+	void *entries;
+};
+
+struct sja1105_static_config {
+	u64 device_id;
+	struct sja1105_table tables[BLK_IDX_MAX];
+};
+
+size_t sja1105_table_header_packing(void *buf, void *hdr, enum packing_op op);
+void
+sja1105_table_header_pack_with_crc(void *buf, struct sja1105_table_header *hdr);
+size_t
+sja1105_static_config_get_length(const struct sja1105_static_config *config);
+
+enum sja1105_static_config_validity {
+	SJA1105_CONFIG_OK = 0,
+	SJA1105_DEVICE_ID_INVALID,
+	SJA1105_MISSING_L2_POLICING_TABLE,
+	SJA1105_MISSING_L2_FORWARDING_TABLE,
+	SJA1105_MISSING_L2_FORWARDING_PARAMS_TABLE,
+	SJA1105_MISSING_GENERAL_PARAMS_TABLE,
+	SJA1105_MISSING_VLAN_TABLE,
+	SJA1105_MISSING_XMII_TABLE,
+	SJA1105_MISSING_MAC_TABLE,
+	SJA1105_OVERCOMMITTED_FRAME_MEMORY,
+	SJA1105_UNEXPECTED_END_OF_BUFFER,
+	SJA1105_INVALID_DEVICE_ID,
+	SJA1105_INVALID_TABLE_HEADER_CRC,
+	SJA1105_INVALID_TABLE_HEADER,
+	SJA1105_INCORRECT_TABLE_LENGTH,
+	SJA1105_DATA_CRC_INVALID,
+	SJA1105_EXTRA_BYTES_AT_END_OF_BUFFER,
+};
+
+extern const char *sja1105_static_config_error_msg[];
+
+enum sja1105_static_config_validity
+sja1105_static_config_check_valid(const struct sja1105_static_config *config);
+void
+sja1105_static_config_pack(void *buf, struct sja1105_static_config *config);
+int sja1105_static_config_init(struct sja1105_static_config *config,
+			       u64 device_id, u64 part_nr);
+void sja1105_static_config_free(struct sja1105_static_config *config);
+
+u32 sja1105_crc32(const void *buf, size_t len);
+
+void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len);
+void sja1105_unpack(const void *buf, u64 *val, int start, int end, size_t len);
+void sja1105_packing(void *buf, u64 *val, int start, int end,
+		     size_t len, enum packing_op op);
+
+#endif
+
-- 
2.17.1

