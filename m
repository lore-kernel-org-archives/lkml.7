Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD89C282DA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53953218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT5abNCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfDMB3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:29:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfDMB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so14142141wrp.2;
        Fri, 12 Apr 2019 18:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=54kVdl8kpOCQFTtC2doNpszMP27unjkp5JWJalcaPb8=;
        b=LT5abNCVhMuWjXUZK5o+6fqVRrsW2PTtoVIgqjwef+FhCy69TbOkvip3ivCDXtMbYk
         zPLIgm6F4x/m8vz4tQ/CvEmXskOerGK4Ouv0uZoNVhiUTK31PcJ75+0UoldCWwj3Vil6
         pH/Nc/tvADhjb71f4fKJpNdS/Pgm8ZF/LKBXkVumvVrGuB0EqHVyk/J68yKdLjkfS3bV
         fnY7UuEWjRvMfMvrxrYVBxE3yL7p0RGfUGgBNk9bY33yiZOYVoe4KpE/2/7JIp3CIoVT
         4JFxcmh0cu3rS4kq7c5wAMWU+bFfM5vOLlQcni8s23QKXZCPyUQ9bcxYRAGZWTWttq/Q
         Zk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=54kVdl8kpOCQFTtC2doNpszMP27unjkp5JWJalcaPb8=;
        b=BSIZquZHCiOrafHTll1ZJ4Fky12wjxRDJrrtr8CUSy3WleVvcTjLteQpwWFoVPUt2J
         ITVMUHd4O4GOkER/La/7ApVxb7P3Nr1S383PUgLI6HSfvYLTgUbJbGuvLgcHLkwjnQuV
         1MPw2rc6TJaWRCSi0seDYU8uDFjX6QeAzoZjJ/IQgLeLZyEVlgakWRoLa9hH09kqg/Y5
         0RYsAnUfJu++BcRaJhPzUdpynbZB7kEAZRMnLNkkbGn14v56M0kYP4X/ETo3pDca5DJt
         OVYez5gwanK1wRvyCtvIYb9ZfTSu/QlVIWOzoRltaIcs24Xsqamm9NG9dGrkElL+hhVP
         3Ojw==
X-Gm-Message-State: APjAAAVwE4SQ7zSSavuuyMo17wOR+/fhVVzyGS7vqCv1U+rvVqkhGcNF
        j47DKXaDFN1IF/rQf9jrMvc=
X-Google-Smtp-Source: APXvYqy0Xs7M+7109aicnlXeLlQfY0B7DJqpzNbcXaJ4M5ZuD//wQNjSrFRtHtgfQ5KNc+G5UQAqjQ==
X-Received: by 2002:adf:82f0:: with SMTP id 103mr38530929wrc.260.1555118934462;
        Fri, 12 Apr 2019 18:28:54 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:53 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 20/24] net: dsa: sja1105: Error out if RGMII delays are requested in DT
Date:   Sat, 13 Apr 2019 04:28:18 +0300
Message-Id: <20190413012822.30931-21-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/net/ethernet.txt is confusing because
it says what the MAC should not do, but not what it *should* do:

  * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
     should not add an RX delay in this case)

The gap in semantics is threefold:
1. Is it illegal for the MAC to apply the Rx internal delay by itself,
   and simplify the phy_mode (mask off "rgmii-rxid" into "rgmii") before
   passing it to of_phy_connect? The documentation would suggest yes.
1. For "rgmii-rxid", while the situation with the Rx clock skew is more
   or less clear (needs to be added by the PHY), what should the MAC
   driver do about the Tx delays? Is it an implicit wild card for the
   MAC to apply delays in the Tx direction if it can? What if those were
   already added as serpentine PCB traces, how could that be made more
   obvious through DT bindings so that the MAC doesn't attempt to add
   them twice and again potentially break the link?
3. If the interface is a fixed-link and therefore the PHY object is
   fixed (a purely software entity that obviously cannot add clock
   skew), what is the meaning of the above property?

So an interpretation of the RGMII bindings was chosen that hopefully
does not contradict their intention but also makes them more applied.
The SJA1105 driver understands to act upon "rgmii-*id" phy-mode bindings
if the port is in the PHY role (either explicitly, or if it is a
fixed-link). Otherwise it always passes the duty of setting up delays to
the PHY driver.

The error behavior that this patch adds is required on SJA1105E/T where
the MAC really cannot apply internal delays. If the other end of the
fixed-link cannot apply RGMII delays either (this would be specified
through its own DT bindings), then the situation requires PCB delays.

For SJA1105P/Q/R/S, this is however hardware supported and the error is
thus only temporary. I created a stub function pointer for configuring
delays per-port on RXC and TXC, and will implement it when I have access
to a board with this hardware setup.

Meanwhile do not allow the user to select an invalid configuration.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None.

Changes in v2:
Patch is new.

 drivers/net/dsa/sja1105/sja1105.h          |  3 ++
 drivers/net/dsa/sja1105/sja1105_clocking.c |  7 ++++-
 drivers/net/dsa/sja1105/sja1105_main.c     | 32 +++++++++++++++++++++-
 drivers/net/dsa/sja1105/sja1105_spi.c      |  6 ++++
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index b7e745c0bb3a..3c16b991032c 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -22,6 +22,8 @@
 
 struct sja1105_port {
 	struct dsa_port *dp;
+	bool rgmii_rx_delay;
+	bool rgmii_tx_delay;
 	struct work_struct xmit_work;
 	struct sja1105_skb_ring xmit_ring;
 };
@@ -61,6 +63,7 @@ struct sja1105_info {
 	const struct sja1105_table_ops *static_ops;
 	const struct sja1105_regs *regs;
 	int (*reset_cmd)(const void *ctx, const void *data);
+	int (*setup_rgmii_delay)(const void *ctx, int port, bool rx, bool tx);
 	const char *name;
 };
 
diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
index d40da3d52464..c02fec181676 100644
--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
@@ -432,7 +432,12 @@ static int rgmii_clocking_setup(struct sja1105_private *priv, int port)
 		dev_err(dev, "Failed to configure Tx pad registers\n");
 		return rc;
 	}
-	return 0;
+	if (!priv->info->setup_rgmii_delay)
+		return 0;
+
+	return priv->info->setup_rgmii_delay(priv, port,
+					     priv->ports[port].rgmii_rx_delay,
+					     priv->ports[port].rgmii_tx_delay);
 }
 
 static int sja1105_cgu_rmii_ref_clk_config(struct sja1105_private *priv,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index e4abf8fb2013..5f7ddb1da006 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -555,6 +555,21 @@ static int sja1105_static_config_load(struct sja1105_private *priv,
 	return sja1105_static_config_upload(priv);
 }
 
+static void sja1105_parse_rgmii_delay(const struct sja1105_dt_port *in,
+				      struct sja1105_port *out)
+{
+	if (in->role == XMII_MAC)
+		return;
+
+	if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
+		out->rgmii_rx_delay = true;
+
+	if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID ||
+	    in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
+		out->rgmii_tx_delay = true;
+}
+
 static int sja1105_parse_ports_node(struct sja1105_private *priv,
 				    struct sja1105_dt_port *ports,
 				    struct device_node *ports_node)
@@ -1315,13 +1330,28 @@ static int sja1105_setup(struct dsa_switch *ds)
 {
 	struct sja1105_dt_port ports[SJA1105_NUM_PORTS];
 	struct sja1105_private *priv = ds->priv;
-	int rc;
+	int rc, i;
 
 	rc = sja1105_parse_dt(priv, ports);
 	if (rc < 0) {
 		dev_err(ds->dev, "Failed to parse DT: %d\n", rc);
 		return rc;
 	}
+
+	/* Error out early if internal delays are required through DT
+	 * and we can't apply them.
+	 */
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		sja1105_parse_rgmii_delay(&ports[i], &priv->ports[i]);
+
+		if ((priv->ports[i].rgmii_rx_delay ||
+		     priv->ports[i].rgmii_tx_delay) &&
+		     !priv->info->setup_rgmii_delay) {
+			dev_err(ds->dev, "RGMII delay not supported\n");
+			return -EINVAL;
+		}
+	}
+
 	/* Create and send configuration down to device */
 	rc = sja1105_static_config_load(priv, ports);
 	if (rc < 0) {
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 09cb28e9be20..e4ef4d8048b2 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -499,6 +499,7 @@ struct sja1105_info sja1105e_info = {
 	.part_no		= SJA1105ET_PART_NO,
 	.static_ops		= sja1105e_table_ops,
 	.dyn_ops		= sja1105et_dyn_ops,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105et_reset_cmd,
 	.regs			= &sja1105et_regs,
 	.name			= "SJA1105E",
@@ -508,6 +509,7 @@ struct sja1105_info sja1105t_info = {
 	.part_no		= SJA1105ET_PART_NO,
 	.static_ops		= sja1105t_table_ops,
 	.dyn_ops		= sja1105et_dyn_ops,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105et_reset_cmd,
 	.regs			= &sja1105et_regs,
 	.name			= "SJA1105T",
@@ -517,6 +519,7 @@ struct sja1105_info sja1105p_info = {
 	.part_no		= SJA1105P_PART_NO,
 	.static_ops		= sja1105p_table_ops,
 	.dyn_ops		= sja1105pqrs_dyn_ops,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105pqrs_reset_cmd,
 	.regs			= &sja1105pqrs_regs,
 	.name			= "SJA1105P",
@@ -526,6 +529,7 @@ struct sja1105_info sja1105q_info = {
 	.part_no		= SJA1105Q_PART_NO,
 	.static_ops		= sja1105q_table_ops,
 	.dyn_ops		= sja1105pqrs_dyn_ops,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105pqrs_reset_cmd,
 	.regs			= &sja1105pqrs_regs,
 	.name			= "SJA1105Q",
@@ -535,6 +539,7 @@ struct sja1105_info sja1105r_info = {
 	.part_no		= SJA1105R_PART_NO,
 	.static_ops		= sja1105r_table_ops,
 	.dyn_ops		= sja1105pqrs_dyn_ops,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105pqrs_reset_cmd,
 	.regs			= &sja1105pqrs_regs,
 	.name			= "SJA1105R",
@@ -545,6 +550,7 @@ struct sja1105_info sja1105s_info = {
 	.static_ops		= sja1105s_table_ops,
 	.dyn_ops		= sja1105pqrs_dyn_ops,
 	.regs			= &sja1105pqrs_regs,
+	.setup_rgmii_delay	= NULL,
 	.reset_cmd		= sja1105pqrs_reset_cmd,
 	.name			= "SJA1105S",
 };
-- 
2.17.1

