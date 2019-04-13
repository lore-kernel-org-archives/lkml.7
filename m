Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD3C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CB820850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp0kSieE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfDMB27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36788 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfDMB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so13016239wml.1;
        Fri, 12 Apr 2019 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UWRBoV4WEI/+CjKLjstsfeCSgHXbu3PMsLM1jDgBqsA=;
        b=Pp0kSieEeCn82LL5mxcbPb1XDzWWZFxvPvmlTbQpTl9agbEOFYCbpNYwt1apWJ5qcH
         DtsI2vXQFfkl3vQMCs+ATU7VSi8RYQwfl0LEe+PPLY4kQv/mdyt2kTP5lBiIwTTpGw2J
         Clhpvp9/nnROofUfyE850GaKTg+8MRxJwCbZ7h0mhn3vHwZiHIJEwIt8EqX+HV0Y956W
         lHT2eocv60s3SJMJiGA5bPxebKzAJj+2GavcD+YXLXJoL/26EhQPk2BmBI9LPh05rLz5
         cr9dagis+bAB/eZwd+HYRho2IAnD8AMqNV0b/F/CehsFdvaKRJIwDONgf1PQFtX2Fwl/
         0D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UWRBoV4WEI/+CjKLjstsfeCSgHXbu3PMsLM1jDgBqsA=;
        b=nGBPMbJhHlAirwWbzsg9eD7m+SnJOUs17WxJiLeRvH8AKUGAD4c8CPuzAZ7OnqutmM
         ItifiqaHmqGjSXa3+3zCU6dKtqRk8PJ6eYSE/41N+bXVRmqgYYlp9yNMTjvJDTNN78zH
         09HV8yVEvzR97PkkFKMkHlzJXgdgzAa+H3pTdWTSE0vuPteMEDLr9W0ZNu+ugUqIN288
         NiPLy+93Pbgz9GNENTxIBlQ9CtolDTAQrY0NOHUyAwU4sW5FBgay3u6je+cmW5FV5suH
         UXw00g6fGWmtZMWzhfcxU76V1/NqVm8nUbegphc8+zyGU5ZMKEA4AVTj9O0JnX51MPQM
         s1pQ==
X-Gm-Message-State: APjAAAXy5ruJ12+bfa0a7N69Fy5L7g3KWF36XfOp9YbHRz1MydUXLx3y
        QCIckFa+APsHLR/uVB7mgmI=
X-Google-Smtp-Source: APXvYqzZfciKvfvbJ7+zneazylt3WOMoTNGxFjdixfMle+nazgT5XdNZOS1k1Cxi65fXn3l8XlxNEg==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr13447086wmj.29.1555118929325;
        Fri, 12 Apr 2019 18:28:49 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:48 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 16/24] net: dsa: sja1105: Add support for VLAN operations
Date:   Sat, 13 Apr 2019 04:28:14 +0300
Message-Id: <20190413012822.30931-17-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VLAN filtering cannot be properly disabled in SJA1105. So in order to
emulate the "no VLAN awareness" behavior (not dropping traffic that is
tagged with a VID that isn't configured on the port), we need to hack
another switch feature: programmable TPID (which is 0x8100 for 802.1Q).
We are reprogramming the TPID to a bogus value (ETH_P_EDSA) which leaves
the switch thinking that all traffic is untagged, and therefore accepts
it.

Under a vlan_filtering bridge, the proper TPID of ETH_P_8021Q is
installed again, and the switch starts identifying 802.1Q-tagged
traffic.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes from v3:
Changed back to ETH_P_EDSA.

Changes from v2:
Changed the TPID from ETH_P_EDSA (0xDADA) to a newly introduced one:
ETH_P_DSA_8021Q (0xDADB).

 drivers/net/dsa/sja1105/sja1105_main.c        | 254 +++++++++++++++++-
 .../net/dsa/sja1105/sja1105_static_config.c   |  38 +++
 .../net/dsa/sja1105/sja1105_static_config.h   |   3 +
 3 files changed, 293 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index e37181bd2a6a..a0851d1c9d89 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -261,6 +261,13 @@ static int sja1105_init_static_vlan(struct sja1105_private *priv)
 	table = &priv->static_config.tables[BLK_IDX_VLAN_LOOKUP];
 
 	/* The static VLAN table will only contain the initial pvid of 0.
+	 * All other VLANs are to be configured through dynamic entries,
+	 * and kept in the static configuration table as backing memory.
+	 * The pvid of 0 is sufficient to pass traffic while the ports are
+	 * standalone and when vlan_filtering is disabled. When filtering
+	 * gets enabled, the switchdev core sets up the VLAN ID 1 and sets
+	 * it as the new pvid. Actually 'pvid 1' still comes up in 'bridge
+	 * vlan' even when vlan_filtering is off, but it has no effect.
 	 */
 	if (table->entry_count) {
 		kfree(table->entries);
@@ -401,8 +408,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.vlmask = 0,
 		/* Only update correctionField for 1-step PTP (L2 transport) */
 		.ignore2stf = 0,
-		.tpid = ETH_P_8021Q,
-		.tpid2 = ETH_P_8021Q,
+		/* Forcefully disable VLAN filtering by telling
+		 * the switch that VLAN has a different EtherType.
+		 */
+		.tpid = ETH_P_EDSA,
+		.tpid2 = ETH_P_EDSA,
 		/* P/Q/R/S only */
 		.queue_ts = 0,
 		.egrmirrvid = 0,
@@ -945,12 +955,240 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 	sja1105_bridge_member(ds, port, br, false);
 }
 
+/* For situations where we need to change a setting at runtime that is only
+ * available through the static configuration, resetting the switch in order
+ * to upload the new static config is unavoidable. Back up the settings we
+ * modify at runtime (currently only MAC) and restore them after uploading,
+ * such that this operation is relatively seamless.
+ */
+static int sja1105_static_config_reload(struct sja1105_private *priv)
+{
+	struct sja1105_mac_config_entry *mac;
+	int speed_mbps[SJA1105_NUM_PORTS];
+	int rc, i;
+
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
+
+	/* Back up settings changed by sja1105_adjust_port_config and
+	 * and restore their defaults.
+	 */
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		speed_mbps[i] = sja1105_speed[mac[i].speed];
+		mac[i].speed = SJA1105_SPEED_AUTO;
+	}
+
+	/* Reset switch and send updated static configuration */
+	rc = sja1105_static_config_upload(priv);
+	if (rc < 0)
+		goto out;
+
+	/* Configure the CGU (PLLs) for MII and RMII PHYs.
+	 * For these interfaces there is no dynamic configuration
+	 * needed, since PLLs have same settings at all speeds.
+	 */
+	rc = sja1105_clocking_setup(priv);
+	if (rc < 0)
+		goto out;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		bool enabled = (speed_mbps[i] != 0);
+
+		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i],
+						enabled);
+		if (rc < 0)
+			goto out;
+	}
+out:
+	return rc;
+}
+
+#define sja1105_vlan_filtering_enabled(priv) \
+	(((struct sja1105_general_params_entry *) \
+	((struct sja1105_private *)priv)->static_config. \
+	tables[BLK_IDX_GENERAL_PARAMS].entries)->tpid == ETH_P_8021Q)
+
+/* The TPID setting belongs to the General Parameters table,
+ * which can only be partially reconfigured at runtime (and not the TPID).
+ * So a switch reset is required.
+ */
+static int sja1105_change_tpid(struct sja1105_private *priv,
+			       u16 tpid, u16 tpid2)
+{
+	struct sja1105_general_params_entry *general_params;
+	struct sja1105_table *table;
+
+	table = &priv->static_config.tables[BLK_IDX_GENERAL_PARAMS];
+	general_params = table->entries;
+	general_params->tpid = tpid;
+	general_params->tpid2 = tpid2;
+	return sja1105_static_config_reload(priv);
+}
+
+static int sja1105_pvid_apply(struct sja1105_private *priv, int port, u16 pvid)
+{
+	struct sja1105_mac_config_entry *mac;
+
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
+
+	mac[port].vlanid = pvid;
+
+	return sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG, port,
+					   &mac[port], true);
+}
+
+static int sja1105_is_vlan_configured(struct sja1105_private *priv, u16 vid)
+{
+	struct sja1105_vlan_lookup_entry *vlan;
+	int count, i;
+
+	vlan = priv->static_config.tables[BLK_IDX_VLAN_LOOKUP].entries;
+	count = priv->static_config.tables[BLK_IDX_VLAN_LOOKUP].entry_count;
+
+	for (i = 0; i < count; i++)
+		if (vlan[i].vlanid == vid)
+			return i;
+
+	/* Return an invalid entry index if not found */
+	return -1;
+}
+
+static int sja1105_vlan_apply(struct sja1105_private *priv, int port, u16 vid,
+			      bool enabled, bool untagged)
+{
+	struct sja1105_vlan_lookup_entry *vlan;
+	struct sja1105_table *table;
+	bool keep = true;
+	int match, rc;
+
+	table = &priv->static_config.tables[BLK_IDX_VLAN_LOOKUP];
+
+	match = sja1105_is_vlan_configured(priv, vid);
+	if (match < 0) {
+		/* Can't delete a missing entry. */
+		if (!enabled)
+			return 0;
+		rc = sja1105_table_resize(table, table->entry_count + 1);
+		if (rc)
+			return rc;
+		match = table->entry_count - 1;
+	}
+	/* Assign pointer after the resize (it's new memory) */
+	vlan = table->entries;
+	vlan[match].vlanid = vid;
+	if (enabled) {
+		vlan[match].vlan_bc |= BIT(port);
+		vlan[match].vmemb_port |= BIT(port);
+	} else {
+		vlan[match].vlan_bc &= ~BIT(port);
+		vlan[match].vmemb_port &= ~BIT(port);
+	}
+	/* Also unset tag_port if removing this VLAN was requested,
+	 * just so we don't have a confusing bitmap (no practical purpose).
+	 */
+	if (untagged || !enabled)
+		vlan[match].tag_port &= ~BIT(port);
+	else
+		vlan[match].tag_port |= BIT(port);
+	/* If there's no port left as member of this VLAN,
+	 * it's time for it to go.
+	 */
+	if (!vlan[match].vmemb_port)
+		keep = false;
+
+	dev_dbg(priv->ds->dev,
+		"%s: port %d, vid %llu, broadcast domain 0x%llx, "
+		"port members 0x%llx, tagged ports 0x%llx, keep %d\n",
+		__func__, port, vlan[match].vlanid, vlan[match].vlan_bc,
+		vlan[match].vmemb_port, vlan[match].tag_port, keep);
+
+	rc = sja1105_dynamic_config_write(priv, BLK_IDX_VLAN_LOOKUP, vid,
+					  &vlan[match], keep);
+	if (rc < 0)
+		return rc;
+
+	if (!keep)
+		return sja1105_table_delete_entry(table, match);
+
+	return 0;
+}
+
 static enum dsa_tag_protocol
 sja1105_get_tag_protocol(struct dsa_switch *ds, int port)
 {
 	return DSA_TAG_PROTO_NONE;
 }
 
+/* This callback needs to be present */
+static int sja1105_vlan_prepare(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_vlan *vlan)
+{
+	return 0;
+}
+
+static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
+{
+	struct sja1105_private *priv = ds->priv;
+	int rc;
+
+	if (enabled && !sja1105_vlan_filtering_enabled(priv))
+		/* Enable VLAN filtering. */
+		rc = sja1105_change_tpid(priv, ETH_P_8021Q, ETH_P_8021AD);
+	else if (!enabled && sja1105_vlan_filtering_enabled(priv))
+		/* Disable VLAN filtering. */
+		rc = sja1105_change_tpid(priv, ETH_P_EDSA, ETH_P_EDSA);
+	else
+		return 0;
+	if (rc)
+		dev_err(ds->dev, "Failed to change VLAN Ethertype\n");
+
+	return rc;
+}
+
+static void sja1105_vlan_add(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_vlan *vlan)
+{
+	struct sja1105_private *priv = ds->priv;
+	u16 vid;
+	int rc;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		rc = sja1105_vlan_apply(priv, port, vid, true, vlan->flags &
+					BRIDGE_VLAN_INFO_UNTAGGED);
+		if (rc < 0) {
+			dev_err(ds->dev, "Failed to add VLAN %d to port %d: %d\n",
+				vid, port, rc);
+			return;
+		}
+		if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+			rc = sja1105_pvid_apply(ds->priv, port, vid);
+			if (rc < 0) {
+				dev_err(ds->dev, "Failed to set pvid %d on port %d: %d\n",
+					vid, port, rc);
+				return;
+			}
+		}
+	}
+}
+
+static int sja1105_vlan_del(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_port_vlan *vlan)
+{
+	struct sja1105_private *priv = ds->priv;
+	u16 vid;
+	int rc;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		rc = sja1105_vlan_apply(priv, port, vid, false, vlan->flags &
+					BRIDGE_VLAN_INFO_UNTAGGED);
+		if (rc < 0) {
+			dev_err(ds->dev, "Failed to remove VLAN %d from port %d: %d\n",
+				vid, port, rc);
+			return rc;
+		}
+	}
+	return 0;
+}
+
 /* The programming model for the SJA1105 switch is "all-at-once" via static
  * configuration tables. Some of these can be dynamically modified at runtime,
  * but not the xMII mode parameters table.
@@ -986,6 +1224,14 @@ static int sja1105_setup(struct dsa_switch *ds)
 		dev_err(ds->dev, "Failed to configure MII clocking: %d\n", rc);
 		return rc;
 	}
+	/* On SJA1105, VLAN filtering per se is always enabled in hardware.
+	 * The only thing we can do to disable it is lie about what the 802.1Q
+	 * EtherType is. So it will still try to apply VLAN filtering, but all
+	 * ingress traffic (except frames received with EtherType of
+	 * ETH_P_EDSA) will be internally tagged with a distorted VLAN header
+	 * where the TPID is ETH_P_EDSA, and the VLAN ID is the port pvid.
+	 */
+	ds->vlan_filtering_is_global = true;
 
 	return 0;
 }
@@ -999,6 +1245,10 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_fdb_del		= sja1105_fdb_del,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
+	.port_vlan_prepare	= sja1105_vlan_prepare,
+	.port_vlan_filtering	= sja1105_vlan_filtering,
+	.port_vlan_add		= sja1105_vlan_add,
+	.port_vlan_del		= sja1105_vlan_del,
 	.port_mdb_prepare	= sja1105_mdb_prepare,
 	.port_mdb_add		= sja1105_mdb_add,
 	.port_mdb_del		= sja1105_mdb_del,
diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index ae5c2551ad90..42f71e373d1c 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -1002,3 +1002,41 @@ void sja1105_static_config_free(struct sja1105_static_config *config)
 	}
 }
 
+int sja1105_table_delete_entry(struct sja1105_table *table, int i)
+{
+	size_t entry_size = table->ops->unpacked_entry_size;
+	u8 *entries = table->entries;
+
+	if (i > table->entry_count)
+		return -ERANGE;
+
+	memmove(entries + i * entry_size, entries + (i + 1) * entry_size,
+		(table->entry_count - i) * entry_size);
+
+	table->entry_count--;
+
+	return 0;
+}
+
+/* No pointers to table->entries should be kept when this is called. */
+int sja1105_table_resize(struct sja1105_table *table, size_t new_count)
+{
+	size_t entry_size = table->ops->unpacked_entry_size;
+	void *new_entries, *old_entries = table->entries;
+
+	if (new_count > table->ops->max_entry_count)
+		return -ERANGE;
+
+	new_entries = kcalloc(new_count, entry_size, GFP_KERNEL);
+	if (!new_entries)
+		return -ENOMEM;
+
+	memcpy(new_entries, old_entries, min(new_count, table->entry_count) *
+		entry_size);
+
+	table->entries = new_entries;
+	table->entry_count = new_count;
+	kfree(old_entries);
+	return 0;
+}
+
diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.h b/drivers/net/dsa/sja1105/sja1105_static_config.h
index a2e2ef2a0d8b..c71ef9d366db 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.h
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.h
@@ -263,6 +263,9 @@ int sja1105_static_config_init(struct sja1105_static_config *config,
 			       u64 device_id);
 void sja1105_static_config_free(struct sja1105_static_config *config);
 
+int sja1105_table_delete_entry(struct sja1105_table *table, int i);
+int sja1105_table_resize(struct sja1105_table *table, size_t new_count);
+
 u32 sja1105_crc32(const void *buf, size_t len);
 
 void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len);
-- 
2.17.1

