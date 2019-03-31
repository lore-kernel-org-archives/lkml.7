Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C23C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586D320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKF55fPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfCaRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbfCaRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so8856440wre.7;
        Sun, 31 Mar 2019 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NOd0rY8GD+t3XQWJH4hDxRXVOIknhUQcuniG9Z/lBE=;
        b=JKF55fPF0Nx96qoVtwvelfPmzuSPmyULCxSgPqQSH+9lnHKJ4S5y6CUi2VPqqB4NGN
         C/BIghdb/i8seBciwvsx34TftEqirTxnyJ1cB9usRyyX+EG+I0N/jln50pxZLyB7JNnc
         sKMdsRrU/q8zmEH2uHCI58t83u9PZqY7GVeCWM440bTEO0tWBNGbW4gXR8J7Gk40pALT
         kn/JfDg+8y/VG27FRv/r8coGq+U6cTPpzPLtlzSjy+JwsKzoqH8Lz+GGsoxPwlpPxqLQ
         AaAOVBmdl9rUlgos8voMNi8hEx9Mq484aMEfR5bA0V51Z1w5zRgyZ1DZApmZpgbSC1xm
         F+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NOd0rY8GD+t3XQWJH4hDxRXVOIknhUQcuniG9Z/lBE=;
        b=t4Cox8IrICO3LBALLLjZhYWqnO1mfKQ+tG63UBMNglOfovR9DnRzQerF/HnWiOga6s
         7NeEz6kUO1WGDfdzB6raW6ZkSzxmIFjCWDL5VaRSNJsGVNgG+5ijI2krVlImkOFpF3Tv
         wOFkLiHZtvsNzq2aVki85ErGLOs9M6THYy1HBRBIHiy5IUl0TZIK12Ae4l4r/B8qxSU/
         UGe1kWVAdG4MAdQ9+T2PbTWsE0HVOE5AU3ZsIt6cgXi8BMlH7dJYjzYE7v3bFByTyJhS
         3xUtH2wL9q5w/5mcuKnNh4dxy/S/UXSBSVWTpv5qUveZ4Sf0sWREiwEZz19ncZnc/5eP
         rahg==
X-Gm-Message-State: APjAAAXRCCi5jFP8ORNPTkG+98JbCNdBJlyBQ2bU05hVWtyQbrUwNPZ2
        bmU9fXWpYu/YZJft0g0JWUc=
X-Google-Smtp-Source: APXvYqxV1M520sS++QGB3wO9fRaeNDDJ/nt5xqrw10lox4a+lfVNfkkx3AMdXyfrVSycGWIwTIcCSw==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr40930690wrq.133.1554054190157;
        Sun, 31 Mar 2019 10:43:10 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:09 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 15/17] net: dsa: sja1105: Add support for Spanning Tree Protocol
Date:   Sun, 31 Mar 2019 20:42:30 +0300
Message-Id: <20190331174232.22060-16-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 108 ++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index adf79b1caf55..4064abc46f48 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -93,8 +93,10 @@ static int sja1105_init_mac_settings(struct sja1105_private *priv)
 		.drpuntag = false,
 		/* Don't retag 802.1p (VID 0) traffic with the pvid */
 		.retag = false,
-		/* Enable learning and I/O on user ports by default. */
-		.dyn_learn = true,
+		/* Disable learning and I/O on user ports by default -
+		 * STP will enable it.
+		 */
+		.dyn_learn = false,
 		.egress = false,
 		.ingress = false,
 		.mirrcie = 0,
@@ -125,8 +127,17 @@ static int sja1105_init_mac_settings(struct sja1105_private *priv)
 
 	mac = table->entries;
 
-	for (i = 0; i < SJA1105_NUM_PORTS; i++)
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
 		mac[i] = default_mac;
+		if (i == dsa_upstream_port(priv->ds, i)) {
+			/* STP doesn't get called for CPU port, so we need to
+			 * set the I/O parameters statically.
+			 */
+			mac[i].dyn_learn = true;
+			mac[i].ingress = true;
+			mac[i].egress = true;
+		}
+	}
 
 	return 0;
 }
@@ -636,12 +647,14 @@ static sja1105_speed_t sja1105_get_speed_cfg(unsigned int speed_mbps)
  * for a specific port.
  *
  * @speed_mbps: If 0, leave the speed unchanged, else adapt MAC to PHY speed.
- * @enabled: Manage Rx and Tx settings for this port. Overrides the static
- *	     configuration settings.
+ * @enabled: Manage Rx and Tx settings for this port. If false, overrides the
+ *	     settings from the STP state, but not persistently (does not
+ *	     overwrite the static MAC info for this port).
  */
 static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
 				      int speed_mbps, bool enabled)
 {
+	struct sja1105_mac_config_entry dyn_mac;
 	struct sja1105_xmii_params_entry *mii;
 	struct sja1105_mac_config_entry *mac;
 	struct device *dev = priv->ds->dev;
@@ -674,12 +687,13 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
 	 * the code common, we'll use the static configuration tables as a
 	 * reasonable approximation for both E/T and P/Q/R/S.
 	 */
-	mac[port].ingress = enabled;
-	mac[port].egress  = enabled;
+	dyn_mac = mac[port];
+	dyn_mac.ingress = enabled && mac[port].ingress;
+	dyn_mac.egress  = enabled && mac[port].egress;
 
 	/* Write to the dynamic reconfiguration tables */
 	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG,
-					  port, &mac[port], true);
+					  port, &dyn_mac, true);
 	if (rc < 0) {
 		dev_err(dev, "Failed to write MAC config: %d\n", rc);
 		return rc;
@@ -928,6 +942,50 @@ static int sja1105_bridge_member(struct dsa_switch *ds, int port,
 					    port, &l2_fwd[port], true);
 }
 
+static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
+					 u8 state)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_mac_config_entry *mac;
+
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_BLOCKING:
+		/* From UM10944 description of DRPDTAG (why put this there?):
+		 * "Management traffic flows to the port regardless of the state
+		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
+		 * At the moment no difference between DISABLED and BLOCKING.
+		 */
+		mac[port].ingress   = false;
+		mac[port].egress    = false;
+		mac[port].dyn_learn = false;
+		break;
+	case BR_STATE_LISTENING:
+		mac[port].ingress   = true;
+		mac[port].egress    = false;
+		mac[port].dyn_learn = false;
+		break;
+	case BR_STATE_LEARNING:
+		mac[port].ingress   = true;
+		mac[port].egress    = false;
+		mac[port].dyn_learn = true;
+		break;
+	case BR_STATE_FORWARDING:
+		mac[port].ingress   = true;
+		mac[port].egress    = true;
+		mac[port].dyn_learn = true;
+		break;
+	default:
+		dev_err(ds->dev, "invalid STP state: %d\n", state);
+		return;
+	}
+
+	sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG, port,
+				     &mac[port], true);
+}
+
 static int sja1105_bridge_join(struct dsa_switch *ds, int port,
 			       struct net_device *br)
 {
@@ -940,6 +998,23 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 	sja1105_bridge_member(ds, port, br, false);
 }
 
+static u8 sja1105_stp_state_get(struct sja1105_private *priv, int port)
+{
+	struct sja1105_mac_config_entry *mac;
+
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
+
+	if (!mac[port].ingress && !mac[port].egress && !mac[port].dyn_learn)
+		return BR_STATE_BLOCKING;
+	if (mac[port].ingress && !mac[port].egress && !mac[port].dyn_learn)
+		return BR_STATE_LISTENING;
+	if (mac[port].ingress && !mac[port].egress && mac[port].dyn_learn)
+		return BR_STATE_LEARNING;
+	if (mac[port].ingress && mac[port].egress && mac[port].dyn_learn)
+		return BR_STATE_FORWARDING;
+	return -EINVAL;
+}
+
 /* For situations where we need to change a setting at runtime that is only
  * available through the static configuration, resetting the switch in order
  * to upload the new static config is unavoidable. Back up the settings we
@@ -950,16 +1025,27 @@ static int sja1105_static_config_reload(struct sja1105_private *priv)
 {
 	struct sja1105_mac_config_entry *mac;
 	int speed_mbps[SJA1105_NUM_PORTS];
+	u8 stp_state[SJA1105_NUM_PORTS];
 	int rc, i;
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
 	/* Back up settings changed by sja1105_adjust_port_config and
-	 * and restore their defaults.
+	 * sja1105_bridge_stp_state_set and restore their defaults.
 	 */
 	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
 		speed_mbps[i] = sja1105_speed[mac[i].speed];
 		mac[i].speed = SJA1105_SPEED_AUTO;
+		if (i == dsa_upstream_port(priv->ds, i)) {
+			mac[i].ingress = true;
+			mac[i].egress = true;
+			mac[i].dyn_learn = true;
+		} else {
+			stp_state[i] = sja1105_stp_state_get(priv, i);
+			mac[i].ingress = false;
+			mac[i].egress = false;
+			mac[i].dyn_learn = false;
+		}
 	}
 
 	/* Reset switch and send updated static configuration */
@@ -978,6 +1064,9 @@ static int sja1105_static_config_reload(struct sja1105_private *priv)
 	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
 		bool enabled = (speed_mbps[i] != 0);
 
+		if (i != dsa_upstream_port(priv->ds, i))
+			sja1105_bridge_stp_state_set(priv->ds, i, stp_state[i]);
+
 		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i],
 						enabled);
 		if (rc < 0)
@@ -1352,6 +1441,7 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_fdb_del		= sja1105_fdb_del,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
+	.port_stp_state_set	= sja1105_bridge_stp_state_set,
 	.port_vlan_prepare	= sja1105_vlan_prepare,
 	.port_vlan_filtering	= sja1105_vlan_filtering,
 	.port_vlan_add		= sja1105_vlan_add,
-- 
2.17.1

