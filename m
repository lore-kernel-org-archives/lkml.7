Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A261DC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71131217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1BbJDo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDJA5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDJA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so646887wml.4;
        Tue, 09 Apr 2019 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u88tY7XQ2sT/yyrpbRhxyGVKT59pJ4UjBz2fFsEVEoo=;
        b=W1BbJDo7L3Ky31HN5msmRXDCKHOCa4aE6SBLBXsvUzrKTMBKdcOrVx4NDMG8YSHxPi
         wwMWmUVx8K5gSOXQ/F1PuHqoysu5491JGu/2w9f0G0egtzWB2YZ6YOu9dp3zSXl7ZCEP
         Xlj9G1rRrjYmRx7832yWlr/aWQgG2Y2skdqLM7oO2uZxfri1UjML6mZ9NUv94fAT0f8G
         7+PX7y/y3Cu/b9GVrvVYEGqCWZ+lhxMDz5j75AcocIcr5Qm5ZEZy/Eb0ADXNxS/Ws2U0
         IQ3RxzCGw4YddSXyPLiL4Vd1zFtQ5m++3GceFHQcD+Heez/w4Z5OMF0k1oKl6yfPzz/R
         A/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u88tY7XQ2sT/yyrpbRhxyGVKT59pJ4UjBz2fFsEVEoo=;
        b=U/LNSH+tVWKZDtah++ClESF9/pfvEMqArFJ90+wvPsrY/qk+6Z9o/LlLvwCHmGyQRe
         ruMrRkLdkgfBgmmeuYyWShOAsNo0bsbLZRua/OqY8MyUSNpt03X8Z/WlvM8//0QQ8kt7
         K78asA7rgbo6AQisIRB+asoovm4lgEwJptLjl0TSJJHYKkhbdkzRhbD3lbQN0WAUt4oG
         kDL2yfNJaBAUyMUTLlX14ZPkDuWLu5cPF/SR4s4wUhpCW4qTNqWosrggTKepOVe6JusI
         ZhSRbn39lxPNF8qoN46QuM2QoOunNB9sv4V7Q5LZx2mYDu8kG6xI4/pJR/VOdhqgZYur
         3yMw==
X-Gm-Message-State: APjAAAXTXHy5DktBSny3A/KD/IB/NcqG0z/tRUKXfW9wSJsFtoffvNbZ
        szS33HGY7oUxzPDIvVWudwU=
X-Google-Smtp-Source: APXvYqwNcdDaG44UBgdwRVWlv+WGZEARW4upBLYw0ypvfrLS2F06xpYuNoQagzpE9vHr5aMXc7eSOQ==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr672910wmi.138.1554857864118;
        Tue, 09 Apr 2019 17:57:44 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:43 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 20/22] net: dsa: sja1105: Reject unsupported link modes for AN
Date:   Wed, 10 Apr 2019 03:56:58 +0300
Message-Id: <20190410005700.31582-21-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet flow control:

The switch MAC does not consume, nor does it emit pause frames. It
simply forwards them as any other Ethernet frame (and since the DMAC is,
per IEEE spec, 01-80-C2-00-00-01, it means they are filtered as
link-local traffic and forwarded to the CPU, which can't do anything
useful with them).

Duplex:

There is no duplex setting in the SJA1105 MAC. It is known to forward
traffic at line rate on the same port in both directions. Therefore it
must be that it only supports full duplex.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
Patch is new.

 drivers/net/dsa/sja1105/sja1105_main.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 04fdca788a87..6dca2036f910 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -11,6 +11,7 @@
 #include <linux/spi/spi.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
+#include <linux/phylink.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
@@ -747,6 +748,35 @@ static void sja1105_adjust_link(struct dsa_switch *ds, int port,
 		sja1105_adjust_port_config(priv, port, phydev->speed, true);
 }
 
+static void sja1105_phylink_validate(struct dsa_switch *ds, int port,
+				     unsigned long *supported,
+				     struct phylink_link_state *state)
+{
+	/* Construct a new mask which exhaustively contains all link features
+	 * supported by the MAC, and then apply that (logical AND) to what will
+	 * be sent to the PHY for "marketing".
+	 */
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_xmii_params_entry *mii;
+
+	mii = priv->static_config.tables[BLK_IDX_XMII_PARAMS].entries;
+
+	/* The MAC does not support pause frames, and also doesn't
+	 * support half-duplex traffic modes.
+	 */
+	phylink_set(mask, Autoneg);
+	phylink_set(mask, MII);
+	phylink_set(mask, 10baseT_Full);
+	phylink_set(mask, 100baseT_Full);
+	if (mii->xmii_mode[port] == XMII_MODE_RGMII)
+		phylink_set(mask, 1000baseT_Full);
+
+	bitmap_and(supported, supported, mask, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	bitmap_and(state->advertising, state->advertising, mask,
+		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 #define fdb(bin, index) \
 	((bin) * SJA1105ET_FDB_BIN_SIZE + (index))
 #define is_bin_index_valid(i) \
@@ -1482,6 +1512,7 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.setup			= sja1105_setup,
 	.adjust_link		= sja1105_adjust_link,
+	.phylink_validate	= sja1105_phylink_validate,
 	.get_strings		= sja1105_get_strings,
 	.get_ethtool_stats	= sja1105_get_ethtool_stats,
 	.get_sset_count		= sja1105_get_sset_count,
-- 
2.17.1

