Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9EDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661B2217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/AVcKGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDJA6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:58:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDJA5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so664205wmf.1;
        Tue, 09 Apr 2019 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PmTAYN5GT0Z3ydh/MjHfTSJcSVbg2uVPPFGFMir5bcw=;
        b=k/AVcKGj+xfDCD8TrpDjPGTR6Vktf0B1/hczpL7v6xchFnYl6cLmClrpnRFU6zSJi7
         Y/K2b55w+gn3cJ0HazK9aK3nidDi0YJ+MxDyAKFG395QSz1MZVDu6Zvije3HyaYS9S7g
         BcHRcfzCbqlZSsVCazc6i0ygNVNG9xkH3MdNXqVPal+4hJRFQ38nypJpIY7yEXtDPHfb
         Jx/Ohsn3kQL+YONXQ4BBBYPlxHC+ctx6rucH+H6hVWjjEWvU2tPix3YOOBO1v/Uh6bN+
         UM9+8wABtXqGjS5qDUipwtao+kgtkUkqtheSUNsA0vHOvbwJuyiJt7h2LxAuOSloUH/K
         7XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PmTAYN5GT0Z3ydh/MjHfTSJcSVbg2uVPPFGFMir5bcw=;
        b=Bbwg5c/Hq8KdzzPwbJ/U4kF7+30NLGMXrTg/LD584gVwoy8X3vN/2JTWV5qNIy0fNK
         AAojr6klPP9WzShnS2FIe4Ol4sY5hvWiWvNkIhsVXcE3L9CLgDXi5NZu4bR3fw3RCnu3
         V0eFWtdkbx6zt7FMEH1/fWiT+THDrBV69b/6LoWPcjjybDrAmulPtiEtOJL5bIaf6L7L
         w8iqkU4Dd+xy8UNMaxn+1JWvf2HUY/ZAS16YkYqk7AkKJqH64/FZ8M23txTATHOtyAt3
         xDZgjI9uBmvoHdRTjhitO/9mxzk5a8P3GHcCTAdv8SAtAP4DEEmzSDoHQ3kTfpY5is/g
         r7Lw==
X-Gm-Message-State: APjAAAWaFFP6HCPkNGKqYalBOWUa/fhw627Meq6OGE7IuWPGhx/+k7c4
        i5vFDEGdcO+F0w2lgiR4lx0=
X-Google-Smtp-Source: APXvYqwmwXYviKmTg7EPZPSQJle48KSwrHiMwpkuMU3jG5ZyTwBoCZrfEGGc9hUqL9/vQzyUXPCOCw==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr664743wmh.138.1554857860570;
        Tue, 09 Apr 2019 17:57:40 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:39 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 17/22] net: dsa: sja1105: Add support for Spanning Tree Protocol
Date:   Wed, 10 Apr 2019 03:56:55 +0300
Message-Id: <20190410005700.31582-18-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
None.

 drivers/net/dsa/sja1105/sja1105_main.c | 108 ++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 399469bbb5c4..322da6e6d2dc 100644
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
@@ -1371,6 +1460,7 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_fdb_del		= sja1105_fdb_del,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
+	.port_stp_state_set	= sja1105_bridge_stp_state_set,
 	.port_vlan_prepare	= sja1105_vlan_prepare,
 	.port_vlan_filtering	= sja1105_vlan_filtering,
 	.port_vlan_add		= sja1105_vlan_add,
-- 
2.17.1

