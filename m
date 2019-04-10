Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4DCC282DE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF78217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWlcd5FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDJA51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJA50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so840508wrp.0;
        Tue, 09 Apr 2019 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BPvi/jYPk9f+PrNTW/p75PhBuGRZ8vV0uFpECNzcSgY=;
        b=FWlcd5FTJAJdGYCeLyTrgcJrm7L7x9rgHWsF5Xc/NMN+xZa3/eWPr3NyTHEilfQSEK
         o9JhmXldN/TR6YaDH6beYF2y9gyoxqVOBkn6j5AiLKUg7AHEk12FsgGpJLKOINPKwvya
         tdXd9Tt+tZUPInmewH4xEIAdo4wEUkkCfh8YCWJwDX3LQKaRc8Ro4tjCelD/hLG05XEB
         1zX0hEtHrHI99aNA1Glk7TYR6hvaYdMV97MplFMpUpoU912upgJLcMl2tr2fxLFhIqc1
         2iXNajqOg3AnQ0lTgbSBGX9AEP3TPmXccnFhoVDkeBE89zroYk8veEDpsGtUUMRBsP0m
         6QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BPvi/jYPk9f+PrNTW/p75PhBuGRZ8vV0uFpECNzcSgY=;
        b=e3J5Bd9N81hQeCEo0zpF/FdUVGl0r/qeXpk+sdRD1RExUxflM8AbH9zKsaQ/gRcpzn
         kXA/rT9rKbhBbCdIp1pYBX9DqzmYrnyNWms5h0RxlBhxaqbiO71D4ir4nLwqn91s9aVV
         wFTI55+wGj+Wr5M8j52NY/xkRwnEj7H8sRo7SLdUUMcdFIGDGVYVXAjkKAchmLTgef9O
         etSOVuDsLW3idrM0TgCr+hlRZ1MQtxIYlbYT9U2/WnHX/EEYfRVtBsWbh23Qq/HCdqRd
         P7MLQBKSpFTwk/epMDY7MczX15mVxnXMF4bKTN38NH9+rUdvjH1R3Dxnah6hsmv6UTNT
         rkDw==
X-Gm-Message-State: APjAAAVtSShZD2YuOgQqSlDscIu2Ac78nPY8Zoa2GedybFmHLKMeBlop
        QdfbGe6+OBqFAnEihCELuYg=
X-Google-Smtp-Source: APXvYqwHv/mgZchdTxGI81qum1Q+P1c2FmzcmDd/c9m5obEFKGmbbixS+qGDOoaSyzhqFPh6Lo5Sfg==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr1128521wrv.131.1554857844162;
        Tue, 09 Apr 2019 17:57:24 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:23 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 04/22] net: dsa: mt7530: Use vlan_filtering property from dsa_port
Date:   Wed, 10 Apr 2019 03:56:42 +0300
Message-Id: <20190410005700.31582-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field was recently introduced, so keeping state inside the driver
is no longer necessary.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
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

