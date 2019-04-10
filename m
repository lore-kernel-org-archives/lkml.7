Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC0B2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv8/4Qgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDJA7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:59:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44755 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfDJA5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so762922wrn.11;
        Tue, 09 Apr 2019 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pmx68vCEe31j7FaMT4Mna5yQk50mFMhHcwMptl7ekTg=;
        b=Cv8/4QgvSbdoQMkjKd1UAe4fA3pBDfUmubI8urn7XH81aDM8tEWtbDte73d1mMHFV7
         C1p/fSS1/cWhJyQwfgrkkO0C3Q+q6CE51dBZBVyfLPsJz+JZ/B3/8smeqS9dzeX6MfjO
         5Vr3dPNSOgfSWw2aOiBX44ex/GMgIhLlgHhgaX83M1VgZZkFGcLa4Ew4U4Kf/VE6glMX
         3BIEzWy46hDQXOUoj7fksJBCiqgd8uL4bCa0F5y7K0BbxuS0ZFtyzHPb3k6Wd3Q63PGJ
         5HbfmR//htffi3hWsGL8Dr8O2k6n6YXMpgrFiPv+EjgOkRw8I5CFrtHEotKrzZIR8m24
         oSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pmx68vCEe31j7FaMT4Mna5yQk50mFMhHcwMptl7ekTg=;
        b=ksVWCAgdaXMwiVr0xYABab22AbO4Ix+hzMok9tqXBwN+mDU7iuIyp4swWz1mqLFybL
         bDSHSdSjdnBJQEFVcmjQYZbYlcmNMzDl4ionelSU7Jjc+iFCcCx5ceY9z6VtcKRSEZ5W
         h91XLuPGzQ0SovphTKn7RWOaXzoxpaJBFW4Pcx3Wu9ecK34S5kIjTKs87XDgNFA2tF/q
         hvHyrMLvTpeCKlTJ3YekVBwAnMytL+G66LyAOEz+SvRGMOxdhecgKOunB6j15cByTTxL
         jylCmNCruDgpSsUn/Lkv6NwGnpqXxwPXk3Ct/uiezkNnr5UxawkX+PIN9SxmekEmLMx5
         UDVQ==
X-Gm-Message-State: APjAAAWNuPzJX3wkvajVNwCU9snFDBkjO9pcrJzdPH7C/2f+3sFU+DJy
        Lla4IDsdYGmbThxnrchhGxk=
X-Google-Smtp-Source: APXvYqxQvf/rwhj+LBTJbiB3rA4yykO4FQqeRP8FlomhtJmcs76dvow5WttSw+X7BsdwsWMmAc1O4A==
X-Received: by 2002:a5d:60cf:: with SMTP id x15mr24906417wrt.96.1554857855449;
        Tue, 09 Apr 2019 17:57:35 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:34 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 13/22] net: dsa: sja1105: Add support for FDB and MDB management
Date:   Wed, 10 Apr 2019 03:56:51 +0300
Message-Id: <20190410005700.31582-14-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
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

