Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B941C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75F420850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgzfrn8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDMB2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44972 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDMB2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so14106134wrn.11;
        Fri, 12 Apr 2019 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CDLFlB8/t3AYFiMqIkYv3WqpBGIZSHzMjHYUN6v1OGs=;
        b=Dgzfrn8fO129Se/wCPotqacnW8uJzQg083h39NT2rxoVkMWqMmvSgoOi524AnuENMP
         bzsp1KfmTypla3wqdB2Db5SNZlw4aTln9Jj2QlF/MMiHMHasirheLIPImVPiBO5NfH3b
         ZoypHEYmEVy/Nzf1uA4k6DTJ+lFTiiC6M98N7Fc2R3sKqyEaLhf2HOR+yvXPFw0wLxzL
         nBSHJu04EaMcbX5O2eR5MDlGglHsgM2SBymWUq2fiI8ApZueGH75uNOOn7MY+++3nYpZ
         vCU2BxkcdgO0UQu3XGIc3kHo39VISLRFD3isUTz/wfBvS/PoMMKS3PFibAabu15zwk9G
         b+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CDLFlB8/t3AYFiMqIkYv3WqpBGIZSHzMjHYUN6v1OGs=;
        b=IQc+q2RyvlWICbQeq1/afmgqd8iz66Vtqjj+g58JSAF0ZBTGwk2T42DAmrwxJ/ti9O
         yovI3jZaxFG7DvOmLBa1i3EtYQuLxw5kUa8cBI0XDGdTw0Ie3+y1rrNfLll25ItRo335
         DQw1xoocSAxgcdqNWy/Xvn5/Hv5jAZ7j3K6/HWqHKqRSucgvRJBsU1N6fz39JfTRUucn
         VpwE6o5UyaK5+YVDvhTVqvxQ26HJidfAWoKt7wDVGVgmgdL3ngOzpbd88olYU/QHeOHP
         gOfZ2ruRcDuPdAe7H0iQg1msbhmSWlQXuZuMzrBBryUfstIR37h2iPW3Wk+4Med0ASqz
         4E+Q==
X-Gm-Message-State: APjAAAWAH8fQ5xDWrNheRUPDpW5gARhsqPdwnhMbLoWCbZeoaSd0w497
        7CyEL84IbNXcFsW79X3IoUE=
X-Google-Smtp-Source: APXvYqxtE4VlSUC4d7t3n17luXrO/KqGSdHolrl+/zOVvd/6B4kiwjZE8n2sJwhweZ9i5NUHiAQNtQ==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr39591281wrp.298.1555118914687;
        Fri, 12 Apr 2019 18:28:34 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:34 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 04/24] net: dsa: mt7530: Use vlan_filtering property from dsa_port
Date:   Sat, 13 Apr 2019 04:28:02 +0300
Message-Id: <20190413012822.30931-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field was recently introduced, so keeping state inside the driver
is no longer necessary.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None

Changes in v2:
None

 drivers/net/dsa/mt7530.c | 14 ++++----------
 drivers/net/dsa/mt7530.h |  1 -
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7357b4fc0185..8bb0837792b1 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -828,11 +828,9 @@ mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 	mt7530_rmw(priv, MT7530_PVC_P(port), VLAN_ATTR_MASK,
 		   VLAN_ATTR(MT7530_VLAN_TRANSPARENT));
 
-	priv->ports[port].vlan_filtering = false;
-
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
 		if (dsa_is_user_port(ds, i) &&
-		    priv->ports[i].vlan_filtering) {
+		    ds->ports[i].vlan_filtering) {
 			all_user_ports_removed = false;
 			break;
 		}
@@ -891,7 +889,7 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 		 * And the other port's port matrix cannot be broken when the
 		 * other port is still a VLAN-aware port.
 		 */
-		if (!priv->ports[i].vlan_filtering &&
+		if (!ds->ports[i].vlan_filtering &&
 		    dsa_is_user_port(ds, i) && i != port) {
 			if (dsa_to_port(ds, i)->bridge_dev != bridge)
 				continue;
@@ -1013,10 +1011,6 @@ static int
 mt7530_port_vlan_filtering(struct dsa_switch *ds, int port,
 			   bool vlan_filtering)
 {
-	struct mt7530_priv *priv = ds->priv;
-
-	priv->ports[port].vlan_filtering = vlan_filtering;
-
 	if (vlan_filtering) {
 		/* The port is being kept as VLAN-unaware port when bridge is
 		 * set up with vlan_filtering not being set, Otherwise, the
@@ -1139,7 +1133,7 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 	/* The port is kept as VLAN-unaware if bridge with vlan_filtering not
 	 * being set.
 	 */
-	if (!priv->ports[port].vlan_filtering)
+	if (!ds->ports[port].vlan_filtering)
 		return;
 
 	mutex_lock(&priv->reg_mutex);
@@ -1170,7 +1164,7 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 	/* The port is kept as VLAN-unaware if bridge with vlan_filtering not
 	 * being set.
 	 */
-	if (!priv->ports[port].vlan_filtering)
+	if (!ds->ports[port].vlan_filtering)
 		return 0;
 
 	mutex_lock(&priv->reg_mutex);
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index a95ed958df5b..1eec7bdc283a 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -410,7 +410,6 @@ struct mt7530_port {
 	bool enable;
 	u32 pm;
 	u16 pvid;
-	bool vlan_filtering;
 };
 
 /* struct mt7530_priv -	This is the main data structure for holding the state
-- 
2.17.1

