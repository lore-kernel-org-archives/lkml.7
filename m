Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF13C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619A20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjVnG4P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfCaRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:44:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfCaRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so8901839wrp.0;
        Sun, 31 Mar 2019 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3fpeYCO9kDLwd50NxuC7KLskMk8lSVAAL1cs5WoCdU=;
        b=jjVnG4P9aZleokggN7k52DHmmi1CZHuUQh2mztsLX8AwVXkzKahFRxITouLmEZ1BXq
         VPass+pgcSXfMSF2pvMyfzA/gMA3mk6Vlaf3yYz6Ss6J0AXpeju2KAyrIyIDPKq36RGQ
         2urI4tKtWate5yA6CPFFRBFIR9qWjipQQ7KlrS9hDPrtYjLL+7NUNAJQQEtRzGpLC9s1
         9g9kRB1MiQsrZx2FUftC1b4RB0muPbL7jClzyYzNoplHxaw/E5j/APw0hWOEe5vlAPUE
         Y1/CRg/ZEgtRnurLrj71M4AHn5vfAfAuVvEabOgZZ63l2wGbw7jho2sbsaQMVFtjvvDy
         IIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3fpeYCO9kDLwd50NxuC7KLskMk8lSVAAL1cs5WoCdU=;
        b=eFqhl+4vWvR0h7neM9E0rf4uzGj4+2OK/xLzdqCF2uwvT3LgAVCajjR5DxjbsZv7RZ
         fKP3HD7UZzZa9KqBcvgNK4rekQDlFYFGxo4G3Y/CQIij8fMZwuqV1oTYul1HDuoTCLNQ
         Th94HgXZcn1ZHPYX73wjAKMO+Urcbp5caltKKJcVvsD3zMw39IYd0mqwNXnlRTUvtMoO
         zDb4XmS+PddpCqRwosuTq7UsijcGetTsGuZgxDVskJ9OP9fyRBTCloPBi6sRtAFh6jvv
         HLit9jg1ffM9SP26tKEGblmEmsJUytijvYZGFNW0cqlibOIDuyImthTW0j2lRfJMTY5p
         b1SQ==
X-Gm-Message-State: APjAAAX4k/bbe78htbaZO6BcxX+n19+9AthI14AUtjNEBx/Mg7/cSYsH
        8p/8GPz9hmBZBlwXLYZy9+c=
X-Google-Smtp-Source: APXvYqy33Aei5XDS9jhXn6PM9kIe093ZwbrjXG1eIAM967GdkJF0oLedHzKSVyFWS7EeS8h9lzjw4A==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr35813503wrn.90.1554054175990;
        Sun, 31 Mar 2019 10:42:55 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:55 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 05/17] net: dsa: Add more convenient functions for installing port VLANs
Date:   Sun, 31 Mar 2019 20:42:20 +0300
Message-Id: <20190331174232.22060-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hides the need to perform a two-phase transaction and construct a
switchdev_obj_port_vlan struct.

Call graph (including a function that will be introduced in a follow-up
patch) looks like this now (same for the *_vlan_del function):

dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
            |                        |
            |                        |
            |          +-------------+
            |          |
            v          v
         __dsa_port_vlan_add     dsa_slave_port_obj_add
                  |                         |
                  +-------+         +-------+
                          |         |
                          v         v
                       dsa_port_vlan_add

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 31 +++++++++++++++++++++++++++++++
 net/dsa/slave.c    | 16 ++--------------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 093b7d145eb1..766d015f6f38 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -169,6 +169,8 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		      struct switchdev_trans *trans);
 int dsa_port_vlan_del(struct dsa_port *dp,
 		      const struct switchdev_obj_port_vlan *vlan);
+int __dsa_port_vlan_add(struct dsa_port *dp, u16 vid, u16 flags);
+int __dsa_port_vlan_del(struct dsa_port *dp, u16 vid);
 int dsa_port_link_register_of(struct dsa_port *dp);
 void dsa_port_link_unregister_of(struct dsa_port *dp);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index a86fe3be1261..10065a622ada 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -326,6 +326,37 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	return 0;
 }
 
+int __dsa_port_vlan_add(struct dsa_port *dp, u16 vid, u16 flags)
+{
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.flags = flags,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+	struct switchdev_trans trans;
+	int err;
+
+	trans.ph_prepare = true;
+	err = dsa_port_vlan_add(dp, &vlan, &trans);
+	if (err == -EOPNOTSUPP)
+		return 0;
+
+	trans.ph_prepare = false;
+	return dsa_port_vlan_add(dp, &vlan, &trans);
+}
+
+int __dsa_port_vlan_del(struct dsa_port *dp, u16 vid)
+{
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.vid_begin = vid,
+		.vid_end = vid,
+	};
+
+	return dsa_port_vlan_del(dp, &vlan);
+}
+
 static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
 {
 	struct device_node *phy_dn;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 093eef6f2599..e644095fdd44 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -987,13 +987,6 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 				     u16 vid)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct switchdev_obj_port_vlan vlan = {
-		.vid_begin = vid,
-		.vid_end = vid,
-		/* This API only allows programming tagged, non-PVID VIDs */
-		.flags = 0,
-	};
-	struct switchdev_trans trans;
 	struct bridge_vlan_info info;
 	int ret;
 
@@ -1010,13 +1003,8 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 			return -EBUSY;
 	}
 
-	trans.ph_prepare = true;
-	ret = dsa_port_vlan_add(dp, &vlan, &trans);
-	if (ret == -EOPNOTSUPP)
-		return 0;
-
-	trans.ph_prepare = false;
-	return dsa_port_vlan_add(dp, &vlan, &trans);
+	/* This API only allows programming tagged, non-PVID VIDs */
+	return __dsa_port_vlan_add(dp, vid, 0);
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
-- 
2.17.1

