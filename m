Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4221A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SARNEuqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfCaRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:44:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbfCaRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so6627927wml.4;
        Sun, 31 Mar 2019 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lCDAPgf4hGbpOYScV+BQ2KLIJxsNpgDIONWhaUqiFU=;
        b=SARNEuqgrKmAm0fNNaINOXX1VyLCN9J9GfNjWafwf2YDWjO9+ihMpWz85J32ZPnQpa
         0PPWVtxlSHA1Z1tX5NzATpisO75IJ2jEumL22vuGdmn+24DWWRm/aM7HLvidqwlxi+/k
         Vmj+3VghpCE/OBGrJBPar49lFGCT7MaBIJaAIPnhfwMbJQcnffrrZFhAWB4h6h5t3RlQ
         h+xIoNv7P8D9Fr2kiJZc6O/UcjZiLsr/JPqkPX9e1yOU9ff/FHqVegiY9EVmDbH7Tl1h
         gyqdlO5nlFm4ySHZwqDb3w+irVkcABOA0D7k3XHp18BYskRTNCJMmzfRi9LKGRIpYlcv
         LYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lCDAPgf4hGbpOYScV+BQ2KLIJxsNpgDIONWhaUqiFU=;
        b=mqb2+QBro52xamTelq9Rul0xtpbE1M/IdcthKoUTwS/HySUzs9Z+mMdNMJ7kmJQoNK
         /mo0I/RLEdzKyvdqtZV6+wX79NIKK4OMnQeN4r1sVV8XARY8bvMuZ7n9V6iaV8Z+ewlh
         GVFA+kr3kzQO+5UmR6/DO4uZZet3HaMVM8l5sv/Z6ECmaY2yTev5UVOf1eyoBSy6LTaV
         hp1N+LAqlw7lPWMcxHP6tP3UPwoFIUV1ICtQbabiZ54nJ7P+pbdtoplInRsasv+uvjyS
         yPVlbfYh+BMUC3hr6eKOPY4DrFkfLcNLWmODJMZw33PpyeWbPfizCbjJgb2lAUccskbe
         P0vA==
X-Gm-Message-State: APjAAAVCervjKTKNWCQGTz/9ofI/09SZLlm5W8O1roopA3eP0MYyckGJ
        G3WkrVSk7sxW/TKjblvP2O4=
X-Google-Smtp-Source: APXvYqw8Jcb0TguK3ei3m+Qoc2RUJPymN6zbj1GHoWj05SLuXqCaqMxHabMUu1ze20Ok/tfMsnDHeg==
X-Received: by 2002:a1c:ce06:: with SMTP id e6mr9837529wmg.1.1554054174817;
        Sun, 31 Mar 2019 10:42:54 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:54 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 04/17] net: dsa: mt7530: Use vlan_filtering property from dsa_port
Date:   Sun, 31 Mar 2019 20:42:19 +0300
Message-Id: <20190331174232.22060-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field was recently introduced, so keeping state inside the driver
is no longer necessary.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
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

