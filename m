Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B5C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B3F20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAIaKjuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDMB3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:29:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39562 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfDMB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so12998457wmk.4;
        Fri, 12 Apr 2019 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PmHHokvPch6eJal551OKO3Y5v7k3jg7gOuERrDTSNkg=;
        b=gAIaKjuJgtqJFkwJ3ZxyhgdjdpLOQSH7JTO51k6lQIBFhAxyHZ3F71Z9xGeu3hUQ26
         CFZivWT1E13Be9fnAYGFu1swfYAihIYly5aD2aLd/HlhzbO+T+ZfAb6wxiadEIvLehPP
         4MhAXStOh/6TS2v2wKRrqE2QJ3+COEonZ/HVpQVC8KvvFOth8Jop0x4c0XvHYsXIubQt
         YVKCFJWtedaxVrJxQRLZCTz5X7Uqzz0ZsGoDkXYDFC2Vuad4E44JTZGkNtQ/teiNjMah
         16jN6JdP257dYKgxBeeUGXVxnG249zPZZjMmpdvJ1vir3j3Hkrn5UZE9v/izwPqlmquR
         FgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PmHHokvPch6eJal551OKO3Y5v7k3jg7gOuERrDTSNkg=;
        b=Tl6Fft12s1V/HcJB8yaiYjhkUk46K2OVWHTiQv4nygvVZHP7AjrY9ctaaEbZRFm8vZ
         dcvTAwLyYdy68bm3pPuSYc3EyiQSzJ2kBJ7OHHEJ+Pk3jOnW3nLeuvuiMQgFW2p8V0qx
         LVnZy2x4Sm+TOjgW95qjaDkPAe24OstXt95CSo5+oicyVeAT+FWpSrt4KSXXs6zdBwh/
         Qg/dohY+t4av22uYYTud9rsyOROJCjPCi50LoYpj5R/yV3sPuaNGdQtnuMEr3k5TYkoa
         w4er4bKjgZePGO8k7HPeGoghVKJQL+yj4DG/Xr9q+LeJhgYK7BwX3mYtqJr4xuk0Utvd
         NgAQ==
X-Gm-Message-State: APjAAAUBi3c81LRVNcSyD5pAFmbkVn926yG0BGi2IJgam1WfSG0SCkcn
        8/ZtJA8UDQXYlp6PPqviGX9mnYE8MRE=
X-Google-Smtp-Source: APXvYqyoIKfZZKXQc9PM712E5UHUhKcX2ZFnY9NBSSjtB20gYY2PKQ3YU8V5eAhJx/qK1l1TMlVz7Q==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr12389332wmh.13.1555118933146;
        Fri, 12 Apr 2019 18:28:53 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:52 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 19/24] net: dsa: sja1105: Add support for Spanning Tree Protocol
Date:   Sat, 13 Apr 2019 04:28:17 +0300
Message-Id: <20190413012822.30931-20-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not explicitly documented as supported in UM10944, compliance with
the STP states can be obtained by manipulating 3 settings at the
(per-port) MAC config level: dynamic learning, inhibiting reception of
regular traffic, and inhibiting transmission of regular traffic.

In all these modes, transmission and reception of special BPDU frames
from the stack is still enabled (not inhibited by the MAC-level
settings).

On ingress, BPDUs are classified by the MAC filter as link-local
(01-80-C2-00-00-00) and forwarded to the CPU port.  This mechanism works
under all conditions (even without the custom 802.1Q tagging) because
the switch hardware inserts the source port and switch ID into bytes 4
and 5 of the MAC-filtered frames. Then the DSA .rcv handler needs to put
back zeroes into the MAC address after decoding the source port
information.

On egress, BPDUs are transmitted using management routes from the xmit
worker thread. Again this does not require switch tagging, as the switch
port is programmed through SPI to hold a temporary (single-fire) route
for a frame with the programmed destination MAC (01-80-C2-00-00-00).

STP is activated using the following commands and was tested by
connecting two front-panel ports together and noticing that switching
loops were prevented (one port remains in the blocking state):

$ ip link add name br0 type bridge stp_state 1 && ip link set br0 up
$ for eth in $(ls /sys/devices/platform/soc/2100000.spi/spi_master/spi0/spi0.1/net/);
  do ip link set ${eth} master br0 && ip link set ${eth} up; done

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Added verbiage to the commit message.

Changes in v2:
None.

 drivers/net/dsa/sja1105/sja1105_main.c | 108 ++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 018044f358fd..e4abf8fb2013 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -94,8 +94,10 @@ static int sja1105_init_mac_settings(struct sja1105_private *priv)
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
@@ -126,8 +128,17 @@ static int sja1105_init_mac_settings(struct sja1105_private *priv)
 
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
@@ -642,12 +653,14 @@ static sja1105_speed_t sja1105_get_speed_cfg(unsigned int speed_mbps)
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
@@ -680,12 +693,13 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
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
@@ -943,6 +957,50 @@ static int sja1105_bridge_member(struct dsa_switch *ds, int port,
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
@@ -955,6 +1013,23 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
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
@@ -965,16 +1040,27 @@ static int sja1105_static_config_reload(struct sja1105_private *priv)
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
@@ -993,6 +1079,9 @@ static int sja1105_static_config_reload(struct sja1105_private *priv)
 	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
 		bool enabled = (speed_mbps[i] != 0);
 
+		if (i != dsa_upstream_port(priv->ds, i))
+			sja1105_bridge_stp_state_set(priv->ds, i, stp_state[i]);
+
 		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i],
 						enabled);
 		if (rc < 0)
@@ -1367,6 +1456,7 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_fdb_del		= sja1105_fdb_del,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
+	.port_stp_state_set	= sja1105_bridge_stp_state_set,
 	.port_vlan_prepare	= sja1105_vlan_prepare,
 	.port_vlan_filtering	= sja1105_vlan_filtering,
 	.port_vlan_add		= sja1105_vlan_add,
-- 
2.17.1

