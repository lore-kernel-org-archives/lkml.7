Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0441FC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D4C218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrPnVwV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDMB3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:29:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfDMB26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so14103670wra.12;
        Fri, 12 Apr 2019 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mrwFAU00dBWfB3R5gRN5OyqqnDzhbmHoidm2Ev+1Lo8=;
        b=jrPnVwV74ywMgyNKiBQx6/o+KmqaIuU0QCdPK1mXcuU0tshZzqpJfxrUFVHetytlQQ
         TIP++Iui+Rb+e5gCSGzgvvmdrN6vNBqAJEn2LY32L6sCxWdEgmC1vG9VshfJMTM5jTaL
         yhBNIiMcFXEZfVf/xw7g6NVldn2Z6Xj5IF68KaxjXSevH2DS+xBbRQ1mV8IW7urOi+E/
         AKkpqaxddotEKscPlWnlI6jRqcSsinwTK3+REQ4wbGdtDafYVBTzYVRy2xgXIp9FlVXv
         5Z8weJiMpdsrEkav3C/REwfa9cfSuPxnbHldvRUUP3ERRC1othE2r5WlRO1AsSRcUAfJ
         cMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mrwFAU00dBWfB3R5gRN5OyqqnDzhbmHoidm2Ev+1Lo8=;
        b=St5S6kJ+cnbZTsHIrMzOGwA+/zzV1sbd3vqYlyOMzR/5NhyfZsXb72CJaJDoR34ivg
         NYYVj+DKbNI+zkASMflVMSdgX1gV9iQMGFdar6o7mwMIwr6DLkZUqMTW2BgrP0pYdzr3
         VE6XHt++C1xfEpGx1HsQ2NkR7MInnrd1BtpPv2+mcmEbnIpgPN1N/pnAQ4bPUcF5NIIb
         j68C4/sNL0vPBB+gom+ryDx9M99exUv0vgP0yT7u8/uk7908rc/qN28buwpgHuzk+LTj
         gsnMGyZFxX9hJu+Um6t2adSkcejyCmjM0fvZ3FAHjgUHx+SoHtpTMNw9rbKam66/jaNE
         8lsg==
X-Gm-Message-State: APjAAAU1NiBP+xzybZpJ8ebRUMeJxsZkoXpAVR9m+SE/C2Hh75cpTEjt
        dDk3sGdVyxCVr7cz3lhVqH1JFRUXxmI=
X-Google-Smtp-Source: APXvYqyLnbQN0/f6Pjj8Fwv/ZnqtHzDOrATAG76RJKYmmil/MhPD9NAyptPP9I+n6bWr5L7BYwF5KA==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr34911730wrv.18.1555118936938;
        Fri, 12 Apr 2019 18:28:56 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:56 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 22/24] net: dsa: sja1105: Reject unsupported link modes for AN
Date:   Sat, 13 Apr 2019 04:28:20 +0300
Message-Id: <20190413012822.30931-23-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None.

Changes in v2:
Patch is new.

 drivers/net/dsa/sja1105/sja1105_main.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 5f7ddb1da006..e22f7b666259 100644
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
@@ -1478,6 +1508,7 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.setup			= sja1105_setup,
 	.adjust_link		= sja1105_adjust_link,
+	.phylink_validate	= sja1105_phylink_validate,
 	.get_strings		= sja1105_get_strings,
 	.get_ethtool_stats	= sja1105_get_ethtool_stats,
 	.get_sset_count		= sja1105_get_sset_count,
-- 
2.17.1

