Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A098C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/7J0TzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfCaRnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54907 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfCaRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so6628169wml.4;
        Sun, 31 Mar 2019 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=baj5fzRmYLcdiicaqYdP/NEHQvpgMWyw8DdAFJuVzb0=;
        b=c/7J0TzQs9Vld72cfgjYWt4yC5mNxNLISi69G+u1BNC0qqPqiB1Fcthug19dUsY3jX
         md69iUBEKMcXAFTIaMF6JXsi4qU5LpskZU32xnUw/pYqaNt8Q5sEKezokfVAoAnF7roG
         y+qaxmwowBAUJhzWMYb6CqSI6MBDw1gKMQ09LuqQfnAp8r03/CcSnyO4cWX1QtYiyAHK
         dEl7vLnbZou/ui69J5Iui1wZ4dpJtKqzPPvs0oo3FwtmKjd8Z7FuIrZQNu38UCj5D3B7
         7/b6qKX6NuPQ3XzCFpLv0//zIzTI7M4VUqwE9wZP/sXyX224f/Piwqkg2IsRbVpeLxbP
         Mbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=baj5fzRmYLcdiicaqYdP/NEHQvpgMWyw8DdAFJuVzb0=;
        b=LCYDWlbNw3HKNV0uz3sPet00MR+hWvk+7G1V55PkBFdbhIrKLwfI7mQcaM0IxxKVSp
         MvAKm9Sk5WHYj9x5Y95r1HigCja8ca0IeYMK/JPJLJNVBJcNtE0dfm+msqT0+eFx+q+y
         cFOi7+g0SA6/oXf7eZ18a0nevBndxFOyR3PhDjO+irHnd+Mq4DUGSqIBG24V9GZoV1gP
         f/5QiQsq6pEykcxV2yimw7eUo7hXKjD3we7/ipll2rBcalCgYwZbPvNKVqc2u5YXATnv
         oTK2MVzmgKpULcaxMS00cpjGea599mzZnijqH8TNDScr+bCQxx8Sye+2FHoTIerUPOJy
         RMqg==
X-Gm-Message-State: APjAAAUtY6bhn5HQUNaP/lX1BL0cL9reaVpvjpSC/eSSq68teG/RXETI
        Odd8/RniKL6We6K+G+p30dA=
X-Google-Smtp-Source: APXvYqwLZBw48ZLqqoENBjhpbdI+hug5sYW/8zl3B3ds43O4d5RHICFujVGGPaDWfbszgzV5utBjXg==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr10709955wmb.7.1554054183616;
        Sun, 31 Mar 2019 10:43:03 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:03 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 11/17] net: dsa: sja1105: Add support for FDB and MDB management
Date:   Sun, 31 Mar 2019 20:42:26 +0300
Message-Id: <20190331174232.22060-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
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
 drivers/net/dsa/sja1105/sja1105.h             |   2 +
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  40 ++++
 drivers/net/dsa/sja1105/sja1105_main.c        | 193 ++++++++++++++++++
 3 files changed, 235 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 2874423a5cd0..26d93afa77a1 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -118,6 +118,8 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 				 int index, void *entry, bool keep);
 void sja1105_dynamic_config_init(struct sja1105_private *priv);
 
+u8 sja1105_fdb_hash(struct sja1105_private *priv, const u8 *addr, u16 vid);
+
 /* Common implementations for the static and dynamic configs */
 size_t sja1105_l2_forwarding_entry_packing(void *buf, void *entry_ptr,
 					   enum packing_op op);
diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 4f3756e267ac..545988779fe5 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -476,3 +476,43 @@ void sja1105_dynamic_config_init(struct sja1105_private *priv)
 
 	priv->dyn_ops = ops;
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
index 45c233d7fbba..93d1f607eeab 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -187,6 +187,9 @@ static int sja1105_init_static_fdb(struct sja1105_private *priv)
 
 	table = &priv->static_config.tables[BLK_IDX_L2_LOOKUP];
 
+	/* We only populate the FDB table through dynamic
+	 * L2 Address Lookup entries
+	 */
 	if (table->entry_count) {
 		kfree(table->entries);
 		table->entry_count = 0;
@@ -699,6 +702,190 @@ static void sja1105_adjust_link(struct dsa_switch *ds, int port,
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
@@ -792,8 +979,14 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
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
 
 static int sja1105_probe(struct spi_device *spi)
-- 
2.17.1

