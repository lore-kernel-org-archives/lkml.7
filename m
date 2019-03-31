Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B8CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38120870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjf2Kw54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfCaRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36637 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfCaRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so8907878wrd.3;
        Sun, 31 Mar 2019 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/P64iA+aEWNy56YmY/qkf46AO0o879016G1AOdiS7is=;
        b=Gjf2Kw54xga+nh+YBhKkersWeMKvvMADOpf5MFNglQA3MTz0HAeh9hLwZN+IPv6Wzi
         +6v6zVhXZB2b4QesiEllHD6PhsOg5TqBvrMoXjc96rZH24HSW5NZ0yCLkFYDIIMBFunn
         N/uaFkxC1GILEPqubL8OFqyZ7qczp14hxwrtuxmQULi1ejt+5u3wVJK6sZXK6pQRQk8D
         f5D1UgAAjkzdXJtotOFYgFLOrsOdNDmgUsIly05AKUhoWc36GajuxZi9ir6nDsQNaNAE
         Qh6yGvMFvw85EILH2eXpfhg+AIwkZfSm71d2M8zQaoiRmcyPQkTe08Zw4WxvtkF5jR1L
         nFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/P64iA+aEWNy56YmY/qkf46AO0o879016G1AOdiS7is=;
        b=RCkLlDVfpXi6bQ+iBl7I0HA8kP1nJuto6qtKDd44bfRckscCB59GNACgOEErMYIVnJ
         DONYSmWf3zX1M3yOaoTpk5IIoAvfslcp5Umr9etEqJBSAPRQ3OELmhrdTvSX0wrs/SAk
         1PNX6uTTYy092ifZ6Kg2Dp0hHABu30eedrZBODG/vJ/rpkmiKDNJNWVIhI4cIkaa1ILq
         +aWvKP1d5cyv8/d1vuelVO0+5/vWr/OJMPXet2h4eZ3GQG3m5lwbM9HDa7WCG/6tj5KE
         ws4QnbsWeB7B6AyFPeulGecAqwBF9yXB48LHGRrtPbY2lKQupmjW1VMfCqYOtUaAt2n0
         ELeA==
X-Gm-Message-State: APjAAAULaMlFld8JAIco52cx95e1bhcm+rp2g62EoDsCqwHb3GUfHUVY
        rEdDCU/LPR/Ju4YSx6YHj6w=
X-Google-Smtp-Source: APXvYqwfCCJEYLwjzZRAQoLecnI4zqSyKmzsx8AD2O5k50R0y4lWRKkvIP5+vqszqUySmIal3+hAjw==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr41973738wrw.245.1554054187459;
        Sun, 31 Mar 2019 10:43:07 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:06 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 13/17] net: dsa: sja1105: Add support for ethtool port counters
Date:   Sun, 31 Mar 2019 20:42:28 +0300
Message-Id: <20190331174232.22060-14-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/sja1105/Makefile          |   1 +
 drivers/net/dsa/sja1105/sja1105.h         |   6 +
 drivers/net/dsa/sja1105/sja1105_ethtool.c | 423 ++++++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_main.c    |   3 +
 4 files changed, 433 insertions(+)
 create mode 100644 drivers/net/dsa/sja1105/sja1105_ethtool.c

diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
index ed00840802f4..bb4404c79eb2 100644
--- a/drivers/net/dsa/sja1105/Makefile
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
 sja1105-objs := \
     sja1105_spi.o \
     sja1105_main.o \
+    sja1105_ethtool.o \
     sja1105_clocking.o \
     sja1105_static_config.o \
     sja1105_dynamic_config.o \
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 26d93afa77a1..dd41d7c70370 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -108,6 +108,12 @@ typedef enum {
 int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
 int sja1105_clocking_setup(struct sja1105_private *priv);
 
+/* From sja1105-ethtool.c */
+void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
+void sja1105_get_strings(struct dsa_switch *ds, int port,
+			 u32 stringset, u8 *data);
+int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset);
+
 /* From sja1105-dynamic-config.c */
 
 int sja1105_dynamic_config_read(struct sja1105_private *priv,
diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
new file mode 100644
index 000000000000..a52ee8107fc2
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include "sja1105.h"
+
+struct sja1105_port_status_mac {
+	u64 n_runt;
+	u64 n_soferr;
+	u64 n_alignerr;
+	u64 n_miierr;
+	u64 typeerr;
+	u64 sizeerr;
+	u64 tctimeout;
+	u64 priorerr;
+	u64 nomaster;
+	u64 memov;
+	u64 memerr;
+	u64 invtyp;
+	u64 intcyov;
+	u64 domerr;
+	u64 pcfbagdrop;
+	u64 spcprior;
+	u64 ageprior;
+	u64 portdrop;
+	u64 lendrop;
+	u64 bagdrop;
+	u64 policeerr;
+	u64 drpnona664err;
+	u64 spcerr;
+	u64 agedrp;
+};
+
+struct sja1105_port_status_hl1 {
+	u64 n_n664err;
+	u64 n_vlanerr;
+	u64 n_unreleased;
+	u64 n_sizeerr;
+	u64 n_crcerr;
+	u64 n_vlnotfound;
+	u64 n_ctpolerr;
+	u64 n_polerr;
+	u64 n_rxfrmsh;
+	u64 n_rxfrm;
+	u64 n_rxbytesh;
+	u64 n_rxbyte;
+	u64 n_txfrmsh;
+	u64 n_txfrm;
+	u64 n_txbytesh;
+	u64 n_txbyte;
+};
+
+struct sja1105_port_status_hl2 {
+	u64 n_qfull;
+	u64 n_part_drop;
+	u64 n_egr_disabled;
+	u64 n_not_reach;
+	u64 qlevel_hwm[8]; /* Only for P/Q/R/S */
+	u64 qlevel[8];     /* Only for P/Q/R/S */
+};
+
+struct sja1105_port_status {
+	struct sja1105_port_status_mac mac;
+	struct sja1105_port_status_hl1 hl1;
+	struct sja1105_port_status_hl2 hl2;
+};
+
+static void
+sja1105_port_status_mac_unpack(void *buf,
+			       struct sja1105_port_status_mac *status)
+{
+	/* Make pointer arithmetic work on 4 bytes */
+	u32 *p = (u32 *)buf;
+
+	sja1105_unpack(p + 0x0, &status->n_runt,       31, 24, 4);
+	sja1105_unpack(p + 0x0, &status->n_soferr,     23, 16, 4);
+	sja1105_unpack(p + 0x0, &status->n_alignerr,   15,  8, 4);
+	sja1105_unpack(p + 0x0, &status->n_miierr,      7,  0, 4);
+	sja1105_unpack(p + 0x1, &status->typeerr,      27, 27, 4);
+	sja1105_unpack(p + 0x1, &status->sizeerr,      26, 26, 4);
+	sja1105_unpack(p + 0x1, &status->tctimeout,    25, 25, 4);
+	sja1105_unpack(p + 0x1, &status->priorerr,     24, 24, 4);
+	sja1105_unpack(p + 0x1, &status->nomaster,     23, 23, 4);
+	sja1105_unpack(p + 0x1, &status->memov,        22, 22, 4);
+	sja1105_unpack(p + 0x1, &status->memerr,       21, 21, 4);
+	sja1105_unpack(p + 0x1, &status->invtyp,       19, 19, 4);
+	sja1105_unpack(p + 0x1, &status->intcyov,      18, 18, 4);
+	sja1105_unpack(p + 0x1, &status->domerr,       17, 17, 4);
+	sja1105_unpack(p + 0x1, &status->pcfbagdrop,   16, 16, 4);
+	sja1105_unpack(p + 0x1, &status->spcprior,     15, 12, 4);
+	sja1105_unpack(p + 0x1, &status->ageprior,     11,  8, 4);
+	sja1105_unpack(p + 0x1, &status->portdrop,      6,  6, 4);
+	sja1105_unpack(p + 0x1, &status->lendrop,       5,  5, 4);
+	sja1105_unpack(p + 0x1, &status->bagdrop,       4,  4, 4);
+	sja1105_unpack(p + 0x1, &status->policeerr,     3,  3, 4);
+	sja1105_unpack(p + 0x1, &status->drpnona664err, 2,  2, 4);
+	sja1105_unpack(p + 0x1, &status->spcerr,        1,  1, 4);
+	sja1105_unpack(p + 0x1, &status->agedrp,        0,  0, 4);
+}
+
+static void
+sja1105_port_status_hl1_unpack(void *buf,
+			       struct sja1105_port_status_hl1 *status)
+{
+	/* Make pointer arithmetic work on 4 bytes */
+	u32 *p = (u32 *)buf;
+
+	sja1105_unpack(p + 0xF, &status->n_n664err,    31,  0, 4);
+	sja1105_unpack(p + 0xE, &status->n_vlanerr,    31,  0, 4);
+	sja1105_unpack(p + 0xD, &status->n_unreleased, 31,  0, 4);
+	sja1105_unpack(p + 0xC, &status->n_sizeerr,    31,  0, 4);
+	sja1105_unpack(p + 0xB, &status->n_crcerr,     31,  0, 4);
+	sja1105_unpack(p + 0xA, &status->n_vlnotfound, 31,  0, 4);
+	sja1105_unpack(p + 0x9, &status->n_ctpolerr,   31,  0, 4);
+	sja1105_unpack(p + 0x8, &status->n_polerr,     31,  0, 4);
+	sja1105_unpack(p + 0x7, &status->n_rxfrmsh,    31,  0, 4);
+	sja1105_unpack(p + 0x6, &status->n_rxfrm,      31,  0, 4);
+	sja1105_unpack(p + 0x5, &status->n_rxbytesh,   31,  0, 4);
+	sja1105_unpack(p + 0x4, &status->n_rxbyte,     31,  0, 4);
+	sja1105_unpack(p + 0x3, &status->n_txfrmsh,    31,  0, 4);
+	sja1105_unpack(p + 0x2, &status->n_txfrm,      31,  0, 4);
+	sja1105_unpack(p + 0x1, &status->n_txbytesh,   31,  0, 4);
+	sja1105_unpack(p + 0x0, &status->n_txbyte,     31,  0, 4);
+	status->n_rxfrm  += status->n_rxfrmsh  << 32;
+	status->n_rxbyte += status->n_rxbytesh << 32;
+	status->n_txfrm  += status->n_txfrmsh  << 32;
+	status->n_txbyte += status->n_txbytesh << 32;
+}
+
+static void
+sja1105_port_status_hl2_unpack(void *buf,
+			       struct sja1105_port_status_hl2 *status)
+{
+	/* Make pointer arithmetic work on 4 bytes */
+	u32 *p = (u32 *)buf;
+
+	sja1105_unpack(p + 0x3, &status->n_qfull,        31,  0, 4);
+	sja1105_unpack(p + 0x2, &status->n_part_drop,    31,  0, 4);
+	sja1105_unpack(p + 0x1, &status->n_egr_disabled, 31,  0, 4);
+	sja1105_unpack(p + 0x0, &status->n_not_reach,    31,  0, 4);
+}
+
+static void
+sja1105pqrs_port_status_qlevel_unpack(void *buf,
+				      struct sja1105_port_status_hl2 *status)
+{
+	/* Make pointer arithmetic work on 4 bytes */
+	u32 *p = (u32 *)buf;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		sja1105_unpack(p + i, &status->qlevel_hwm[i], 24, 16, 4);
+		sja1105_unpack(p + i, &status->qlevel[i],      8,  0, 4);
+	}
+}
+
+static int sja1105_port_status_get_mac(struct sja1105_private *priv,
+				       struct sja1105_port_status_mac *status,
+				       int port)
+{
+#define SIZE_MAC_AREA (0x02 * 4)
+	u8 packed_buf[SIZE_MAC_AREA];
+	int rc = 0;
+
+	memset(status, 0, sizeof(*status));
+
+	/* MAC area */
+	rc = sja1105_spi_send_packed_buf(priv, SPI_READ, priv->regs->mac[port],
+					 packed_buf, SIZE_MAC_AREA);
+	if (rc < 0)
+		return rc;
+
+	sja1105_port_status_mac_unpack(packed_buf, status);
+
+	return 0;
+#undef SIZE_MAC_AREA
+}
+
+static int sja1105_port_status_get_hl1(struct sja1105_private *priv,
+				       struct sja1105_port_status_hl1 *status,
+				       int port)
+{
+#define SIZE_HL1_AREA (0x10 * 4)
+	u8 packed_buf[SIZE_HL1_AREA];
+	int rc = 0;
+
+	memset(status, 0, sizeof(*status));
+
+	rc = sja1105_spi_send_packed_buf(priv, SPI_READ,
+					 priv->regs->mac_hl1[port],
+					 packed_buf, SIZE_HL1_AREA);
+	if (rc < 0)
+		return rc;
+
+	sja1105_port_status_hl1_unpack(packed_buf, status);
+
+	return 0;
+#undef SIZE_HL1_AREA
+}
+
+static int sja1105_port_status_get_hl2(struct sja1105_private *priv,
+				       struct sja1105_port_status_hl2 *status,
+				       int port)
+{
+#define SIZE_HL2_AREA (0x4 * 4)
+#define SIZE_QLEVEL_AREA (0x8 * 4) /* 0x4 to 0xB */
+	u8 packed_buf[SIZE_QLEVEL_AREA];
+	int rc = 0;
+
+	memset(status, 0, sizeof(*status));
+
+	rc = sja1105_spi_send_packed_buf(priv, SPI_READ,
+					 priv->regs->mac_hl2[port],
+					 packed_buf, SIZE_HL2_AREA);
+	if (rc < 0)
+		return rc;
+
+	sja1105_port_status_hl2_unpack(packed_buf, status);
+
+	if (IS_ET(priv->device_id))
+		/* Code below is strictly P/Q/R/S specific. */
+		return 0;
+
+	rc = sja1105_spi_send_packed_buf(priv, SPI_READ,
+					 priv->regs->qlevel[port],
+					 packed_buf, SIZE_QLEVEL_AREA);
+	if (rc < 0)
+		return rc;
+
+	sja1105pqrs_port_status_qlevel_unpack(packed_buf, status);
+
+	return 0;
+#undef SIZE_QLEVEL_AREA
+#undef SIZE_HL2_AREA
+}
+
+static int sja1105_port_status_get(struct sja1105_private *priv,
+				   struct sja1105_port_status *status,
+				   int port)
+{
+	int rc;
+
+	rc = sja1105_port_status_get_mac(priv, &status->mac, port);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_port_status_get_hl1(priv, &status->hl1, port);
+	if (rc < 0)
+		return rc;
+	rc = sja1105_port_status_get_hl2(priv, &status->hl2, port);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static char sja1105_port_stats[][ETH_GSTRING_LEN] = {
+	/* MAC-Level Diagnostic Counters */
+	"n_runt",
+	"n_soferr",
+	"n_alignerr",
+	"n_miierr",
+	/* MAC-Level Diagnostic Flags */
+	"typeerr",
+	"sizeerr",
+	"tctimeout",
+	"priorerr",
+	"nomaster",
+	"memov",
+	"memerr",
+	"invtyp",
+	"intcyov",
+	"domerr",
+	"pcfbagdrop",
+	"spcprior",
+	"ageprior",
+	"portdrop",
+	"lendrop",
+	"bagdrop",
+	"policeerr",
+	"drpnona664err",
+	"spcerr",
+	"agedrp",
+	/* High-Level Diagnostic Counters */
+	"n_n664err",
+	"n_vlanerr",
+	"n_unreleased",
+	"n_sizeerr",
+	"n_crcerr",
+	"n_vlnotfound",
+	"n_ctpolerr",
+	"n_polerr",
+	"n_rxfrm",
+	"n_rxbyte",
+	"n_txfrm",
+	"n_txbyte",
+	"n_qfull",
+	"n_part_drop",
+	"n_egr_disabled",
+	"n_not_reach",
+};
+
+static char sja1105pqrs_extra_port_stats[][ETH_GSTRING_LEN] = {
+	/* Queue Levels */
+	"qlevel_hwm_0",
+	"qlevel_hwm_1",
+	"qlevel_hwm_2",
+	"qlevel_hwm_3",
+	"qlevel_hwm_4",
+	"qlevel_hwm_5",
+	"qlevel_hwm_6",
+	"qlevel_hwm_7",
+	"qlevel_0",
+	"qlevel_1",
+	"qlevel_2",
+	"qlevel_3",
+	"qlevel_4",
+	"qlevel_5",
+	"qlevel_6",
+	"qlevel_7",
+};
+
+void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_port_status status;
+	int rc, i, k = 0;
+
+	rc = sja1105_port_status_get(priv, &status, port);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to read port %d counters: %d\n",
+			port, rc);
+		return;
+	}
+	memset(data, 0, ARRAY_SIZE(sja1105_port_stats) * sizeof(u64));
+	data[k++] = status.mac.n_runt;
+	data[k++] = status.mac.n_soferr;
+	data[k++] = status.mac.n_alignerr;
+	data[k++] = status.mac.n_miierr;
+	data[k++] = status.mac.typeerr;
+	data[k++] = status.mac.sizeerr;
+	data[k++] = status.mac.tctimeout;
+	data[k++] = status.mac.priorerr;
+	data[k++] = status.mac.nomaster;
+	data[k++] = status.mac.memov;
+	data[k++] = status.mac.memerr;
+	data[k++] = status.mac.invtyp;
+	data[k++] = status.mac.intcyov;
+	data[k++] = status.mac.domerr;
+	data[k++] = status.mac.pcfbagdrop;
+	data[k++] = status.mac.spcprior;
+	data[k++] = status.mac.ageprior;
+	data[k++] = status.mac.portdrop;
+	data[k++] = status.mac.lendrop;
+	data[k++] = status.mac.bagdrop;
+	data[k++] = status.mac.policeerr;
+	data[k++] = status.mac.drpnona664err;
+	data[k++] = status.mac.spcerr;
+	data[k++] = status.mac.agedrp;
+	data[k++] = status.hl1.n_n664err;
+	data[k++] = status.hl1.n_vlanerr;
+	data[k++] = status.hl1.n_unreleased;
+	data[k++] = status.hl1.n_sizeerr;
+	data[k++] = status.hl1.n_crcerr;
+	data[k++] = status.hl1.n_vlnotfound;
+	data[k++] = status.hl1.n_ctpolerr;
+	data[k++] = status.hl1.n_polerr;
+	data[k++] = status.hl1.n_rxfrm;
+	data[k++] = status.hl1.n_rxbyte;
+	data[k++] = status.hl1.n_txfrm;
+	data[k++] = status.hl1.n_txbyte;
+	data[k++] = status.hl2.n_qfull;
+	data[k++] = status.hl2.n_part_drop;
+	data[k++] = status.hl2.n_egr_disabled;
+	data[k++] = status.hl2.n_not_reach;
+
+	if (!IS_PQRS(priv->device_id))
+		return;
+
+	memset(data + k, 0, ARRAY_SIZE(sja1105pqrs_extra_port_stats) *
+			sizeof(u64));
+	for (i = 0; i < 8; i++) {
+		data[k++] = status.hl2.qlevel_hwm[i];
+		data[k++] = status.hl2.qlevel[i];
+	}
+}
+
+void sja1105_get_strings(struct dsa_switch *ds, int port,
+			 u32 stringset, u8 *data)
+{
+	struct sja1105_private *priv = ds->priv;
+	u8 *p = data;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(sja1105_port_stats); i++) {
+			strlcpy(p, sja1105_port_stats[i], ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+		if (!IS_PQRS(priv->device_id))
+			return;
+		for (i = 0; i < ARRAY_SIZE(sja1105pqrs_extra_port_stats); i++) {
+			strlcpy(p, sja1105pqrs_extra_port_stats[i],
+				ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+		break;
+	}
+}
+
+int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	int count = ARRAY_SIZE(sja1105_port_stats);
+	struct sja1105_private *priv = ds->priv;
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	if (IS_PQRS(priv->device_id))
+		count += ARRAY_SIZE(sja1105pqrs_extra_port_stats);
+
+	return count;
+}
+
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 028ed1ebe358..066577192511 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1231,6 +1231,9 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.setup			= sja1105_setup,
 	.adjust_link		= sja1105_adjust_link,
+	.get_strings		= sja1105_get_strings,
+	.get_ethtool_stats	= sja1105_get_ethtool_stats,
+	.get_sset_count		= sja1105_get_sset_count,
 	.port_fdb_dump		= sja1105_fdb_dump,
 	.port_fdb_add		= sja1105_fdb_add,
 	.port_fdb_del		= sja1105_fdb_del,
-- 
2.17.1

