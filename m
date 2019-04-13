Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ECEC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B620850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ3QarDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDMBaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:30:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfDMB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so1598279wmi.0;
        Fri, 12 Apr 2019 18:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=exva9poVT1nCV51k9IucDjPGaPVdIPu195h3usAjIbg=;
        b=XJ3QarDIM+Nb11h53XHT7lMgl9gfz9nQxNK6+8k/16KltIvqHqFo4UlMX8kO1beCe1
         q1ySn+189+UdUpJMqreZ3Gb8wwxGl8mXPvBk70lPsVkoWzWRCnkjTQqlkWOWlYu11oJ0
         7z1jzYJYxAABjm6OzaCTtFeKNdVc40pttcLOB5ccLQyELSau1s95Xx3zq5zdAEwRLkjh
         dUdVcmJ2FAi2mswsqxFTk0YLHsQaBDpgQfg3uSe0YOISbnxHK9s9I/saaXq8mL5L3F2Y
         MHpVv+IPqhU0f3h3xsQ9BidF9r4LdiWrJDOz2kBQxlPxo1/6IiqUKXi4sl88MNb/hiB5
         2u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exva9poVT1nCV51k9IucDjPGaPVdIPu195h3usAjIbg=;
        b=Y391liCL4fuIY/Gj1tT/tqP4i1I0hdccnivHePtlEm/Mn8q/IiIr9ER9AJyOQ3/yx/
         rHIkXG5U/dAQ/vvXNVujnb97s8B+u/ct3bHJlSdrEiyVQdZqQVGnARColDBoJygBHdSr
         MI4hFB1o0VMZMDSCvXWshJov6N/sd1UpR7pkxbhwrD1Utp5cpJKZQ7LG2vGzcTTVSfSa
         RIhgcyQbIsHTypLH4Wje1Pg1uY5oE0k1SlEcp59jnWR65274NmLkui6n06mYVIIJJcVf
         7sVGAYJkE6A7sU5gh7Oy/M3mpkcDOKcwLzzZsjObFdR7LyIHDq7VpksbX67t8n7OABc2
         pIpA==
X-Gm-Message-State: APjAAAXO9wQW9FBQ6dfhtcHQPn3w4lhq7eeytKt45cf5DkpenU0j4AVV
        kPNlwWpByiKB75MIN2KXcnTHWaDyXPI=
X-Google-Smtp-Source: APXvYqx6YlCdRt9MTGDwlZ+fnwy8udzFCg4+fOFMpaOX66i4JzHZiz7Tz7JGokJHJDzuC6vYNrgjvA==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr13646880wmj.121.1555118928000;
        Fri, 12 Apr 2019 18:28:48 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:47 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 15/24] net: dsa: sja1105: Add support for FDB and MDB management
Date:   Sat, 13 Apr 2019 04:28:13 +0300
Message-Id: <20190413012822.30931-16-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the (more difficult) first generation E/T series is
supported. Here the TCAM is only 4-way associative, and to know where
the hardware will search for a FDB entry, we need to perform the same
hash algorithm in order to install the entry in the correct bin.

On P/Q/R/S, the TCAM should be fully associative. However the SPI
command interface is different, and because I don't have access to a
new-generation device at the moment, support for it is TODO.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes from v3:
None

Changes from v2:
None

 drivers/net/dsa/sja1105/sja1105.h             |   2 +
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  40 ++++
 drivers/net/dsa/sja1105/sja1105_main.c        | 193 ++++++++++++++++++
 3 files changed, 235 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index ef555dd385a3..4c9df44a4478 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -129,6 +129,8 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 				 enum sja1105_blk_idx blk_idx,
 				 int index, void *entry, bool keep);
 
+u8 sja1105_fdb_hash(struct sja1105_private *priv, const u8 *addr, u16 vid);
+
 /* Common implementations for the static and dynamic configs */
 size_t sja1105_l2_forwarding_entry_packing(void *buf, void *entry_ptr,
 					   enum packing_op op);
diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 74c3a00d453c..0aeda6868c27 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -462,3 +462,43 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 
 	return 0;
 }
+
+static u8 crc8_add(u8 crc, u8 byte, u8 poly)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if ((crc ^ byte) & (1 << 7)) {
+			crc <<= 1;
+			crc ^= poly;
+		} else {
+			crc <<= 1;
+		}
+		byte <<= 1;
+	}
+	return crc;
+}
+
+/* CRC8 algorithm with non-reversed input, non-reversed output,
+ * no input xor and no output xor. Code customized for receiving
+ * the SJA1105 E/T FDB keys (vlanid, macaddr) as input. CRC polynomial
+ * is also received as argument in the Koopman notation that the switch
+ * hardware stores it in.
+ */
+u8 sja1105_fdb_hash(struct sja1105_private *priv, const u8 *addr, u16 vid)
+{
+	struct sja1105_l2_lookup_params_entry *l2_lookup_params =
+		priv->static_config.tables[BLK_IDX_L2_LOOKUP_PARAMS].entries;
+	u64 poly_koopman = l2_lookup_params->poly;
+	/* Convert polynomial from Koopman to 'normal' notation */
+	u8 poly = (u8)(1 + (poly_koopman << 1));
+	u64 vlanid = l2_lookup_params->shared_learn ? 0 : vid;
+	u64 input = (vlanid << 48) | ether_addr_to_u64(addr);
+	u8 crc = 0; /* seed */
+	int i;
+
+	/* Mask the eight bytes starting from MSB one at a time */
+	for (i = 56; i >= 0; i -= 8)
+		crc = crc8_add(crc, (input & (0xffull << i)) >> i, poly);
+	return crc;
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c3e4fff11101..e37181bd2a6a 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -188,6 +188,9 @@ static int sja1105_init_static_fdb(struct sja1105_private *priv)
 
 	table = &priv->static_config.tables[BLK_IDX_L2_LOOKUP];
 
+	/* We only populate the FDB table through dynamic
+	 * L2 Address Lookup entries
+	 */
 	if (table->entry_count) {
 		kfree(table->entries);
 		table->entry_count = 0;
@@ -705,6 +708,190 @@ static void sja1105_adjust_link(struct dsa_switch *ds, int port,
 		sja1105_adjust_port_config(priv, port, phydev->speed, true);
 }
 
+#define fdb(bin, index) \
+	((bin) * SJA1105ET_FDB_BIN_SIZE + (index))
+#define is_bin_index_valid(i) \
+	((i) >= 0 && (i) < SJA1105ET_FDB_BIN_SIZE)
+
+static int
+sja1105_is_fdb_entry_in_bin(struct sja1105_private *priv, int bin,
+			    const u8 *addr, u16 vid,
+			    struct sja1105_l2_lookup_entry *fdb_match,
+			    int *last_unused)
+{
+	int index_in_bin;
+
+	for (index_in_bin = 0; index_in_bin < SJA1105ET_FDB_BIN_SIZE;
+	     index_in_bin++) {
+		struct sja1105_l2_lookup_entry l2_lookup = { 0 };
+
+		/* Skip unused entries, optionally marking them
+		 * into the return value
+		 */
+		if (sja1105_dynamic_config_read(priv, BLK_IDX_L2_LOOKUP,
+						fdb(bin, index_in_bin),
+						&l2_lookup)) {
+			if (last_unused)
+				*last_unused = index_in_bin;
+			continue;
+		}
+
+		if (l2_lookup.macaddr == ether_addr_to_u64(addr) &&
+		    l2_lookup.vlanid == vid) {
+			if (fdb_match)
+				*fdb_match = l2_lookup;
+			return index_in_bin;
+		}
+	}
+	/* Return an invalid entry index if not found */
+	return SJA1105ET_FDB_BIN_SIZE;
+}
+
+static int sja1105_fdb_add(struct dsa_switch *ds, int port,
+			   const unsigned char *addr, u16 vid)
+{
+	struct sja1105_l2_lookup_entry l2_lookup = { 0 };
+	struct sja1105_private *priv = ds->priv;
+	struct device *dev = ds->dev;
+	int bin, index_in_bin;
+	int last_unused;
+
+	bin = sja1105_fdb_hash(priv, addr, vid);
+
+	index_in_bin = sja1105_is_fdb_entry_in_bin(priv, bin, addr, vid,
+						   &l2_lookup, &last_unused);
+	if (is_bin_index_valid(index_in_bin)) {
+		/* We have an FDB entry. Is our port in the destination
+		 * mask? If yes, we need to do nothing. If not, we need
+		 * to rewrite the entry by adding this port to it.
+		 */
+		if (l2_lookup.destports & BIT(port))
+			return 0;
+		l2_lookup.destports |= BIT(port);
+	} else {
+		/* We don't have an FDB entry. We construct a new one and
+		 * try to find a place for it within the FDB table.
+		 */
+		l2_lookup.macaddr = ether_addr_to_u64(addr);
+		l2_lookup.destports = BIT(port);
+		l2_lookup.vlanid = vid;
+
+		if (is_bin_index_valid(last_unused)) {
+			index_in_bin = last_unused;
+		} else {
+			/* Bin is full, need to evict somebody.
+			 * Choose victim at random. If you get these messages
+			 * often, you may need to consider changing the
+			 * distribution function:
+			 * static_config[BLK_IDX_L2_LOOKUP_PARAMS].entries->poly
+			 */
+			get_random_bytes(&index_in_bin, sizeof(u8));
+			index_in_bin %= SJA1105ET_FDB_BIN_SIZE;
+			dev_warn(dev, "Warning, FDB bin %d full while adding entry for %pM. Evicting entry %u.\n",
+				 bin, addr, index_in_bin);
+			/* Evict entry */
+			sja1105_dynamic_config_write(priv, BLK_IDX_L2_LOOKUP,
+						     fdb(bin, index_in_bin),
+						     NULL, false);
+		}
+	}
+	l2_lookup.index = fdb(bin, index_in_bin);
+
+	return sja1105_dynamic_config_write(priv, BLK_IDX_L2_LOOKUP,
+				l2_lookup.index, &l2_lookup, true);
+}
+
+static int sja1105_fdb_del(struct dsa_switch *ds, int port,
+			   const unsigned char *addr, u16 vid)
+{
+	struct sja1105_l2_lookup_entry l2_lookup = { 0 };
+	struct sja1105_private *priv = ds->priv;
+	u8 bin, index_in_bin;
+	bool keep;
+
+	bin = sja1105_fdb_hash(priv, addr, vid);
+
+	index_in_bin = sja1105_is_fdb_entry_in_bin(priv, bin, addr, vid,
+						   &l2_lookup, NULL);
+	if (!is_bin_index_valid(index_in_bin))
+		return 0;
+
+	/* We have an FDB entry. Is our port in the destination mask? If yes,
+	 * we need to remove it. If the resulting port mask becomes empty, we
+	 * need to completely evict the FDB entry.
+	 * Otherwise we just write it back.
+	 */
+	if (l2_lookup.destports & BIT(port))
+		l2_lookup.destports &= ~BIT(port);
+	if (l2_lookup.destports)
+		keep = true;
+	else
+		keep = false;
+
+	return sja1105_dynamic_config_write(priv, BLK_IDX_L2_LOOKUP,
+					    fdb(bin, index_in_bin),
+					    &l2_lookup, keep);
+}
+
+static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
+			    dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct device *dev = ds->dev;
+	int i;
+
+	for (i = 0; i < MAX_L2_LOOKUP_COUNT; i++) {
+		struct sja1105_l2_lookup_entry l2_lookup;
+		u8 macaddr[ETH_ALEN];
+		int rc;
+
+		memset(&l2_lookup, 0, sizeof(l2_lookup));
+		rc = sja1105_dynamic_config_read(priv, BLK_IDX_L2_LOOKUP,
+						 i, &l2_lookup);
+		/* No fdb entry at i, not an issue */
+		if (rc == -EINVAL)
+			continue;
+		if (rc) {
+			dev_err(dev, "Failed to dump FDB: %d\n", rc);
+			return rc;
+		}
+
+		/* FDB dump callback is per port. This means we have to
+		 * disregard a valid entry if it's not for this port, even if
+		 * only to revisit it later. This is inefficient because the
+		 * 1024-sized FDB table needs to be traversed 4 times through
+		 * SPI during a 'bridge fdb show' command.
+		 */
+		if (!(l2_lookup.destports & BIT(port)))
+			continue;
+		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
+		cb(macaddr, l2_lookup.vlanid, false, data);
+	}
+	return 0;
+}
+
+#undef fdb
+#undef is_bin_index_valid
+
+/* This callback needs to be present */
+static int sja1105_mdb_prepare(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_mdb *mdb)
+{
+	return 0;
+}
+
+static void sja1105_mdb_add(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_port_mdb *mdb)
+{
+	sja1105_fdb_add(ds, port, mdb->addr, mdb->vid);
+}
+
+static int sja1105_mdb_del(struct dsa_switch *ds, int port,
+			   const struct switchdev_obj_port_mdb *mdb)
+{
+	return sja1105_fdb_del(ds, port, mdb->addr, mdb->vid);
+}
+
 static int sja1105_bridge_member(struct dsa_switch *ds, int port,
 				 struct net_device *br, bool member)
 {
@@ -807,8 +994,14 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.setup			= sja1105_setup,
 	.adjust_link		= sja1105_adjust_link,
+	.port_fdb_dump		= sja1105_fdb_dump,
+	.port_fdb_add		= sja1105_fdb_add,
+	.port_fdb_del		= sja1105_fdb_del,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
+	.port_mdb_prepare	= sja1105_mdb_prepare,
+	.port_mdb_add		= sja1105_mdb_add,
+	.port_mdb_del		= sja1105_mdb_del,
 };
 
 static int sja1105_check_device_id(struct sja1105_private *priv)
-- 
2.17.1

