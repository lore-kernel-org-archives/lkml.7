Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA9C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8746217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjhcLBKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDJA5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDJA51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so654802wmj.3;
        Tue, 09 Apr 2019 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2m0Vwcs+ZIuLsQ4pkrDqVEww3osjoTm+Yu8uuKiIOeo=;
        b=MjhcLBKZ+/3TqQffZn3YjqnzrdPsmFAsXE4NLmwY3zNyJ0L4feDS9ePA+1R5pqY1Mq
         LHm2yUtiDiv6TE6BtRaBKkk3V3aaNmKssXgyF4QnndYLakTj3co6mDJMxH7pKnUdhxVD
         80aHxibZhd6W8YgrzdC1QNAkZpxcfRxDDqjryyHVXexOX5cEeqq+CTDfGq2ub4b3uo4P
         EllhSf138VjpACGJwss9vKLQkTOxXP0J3EmlK6aFpkElgeIyl7V6Gc7jZZxAx0iWX/iB
         uLqNj7u4in93mrxsL9wnbydRXDA0ic141ncmZGfAMo7Calj4s47kTcl7Kj7dSQzjEeP+
         8djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2m0Vwcs+ZIuLsQ4pkrDqVEww3osjoTm+Yu8uuKiIOeo=;
        b=t60RQBhu9sEla4vTo4ew3Jl0acQo6zBwHT2mDtZm5+hax4YxEUq0Ck0wrgMICE8+t6
         pkpSUnfCAn03/OaFOKYi/oLNLhEA4EtrEY3ADE5urh6gQz2IKOicNWNcOfWU9zEci/Z5
         LJ0ebiWKFbZuJXt6vk11oXnsaL9eHGNXxgVhak1HMyiYcUTnpw7mHAsOFkdI6VFD3Lj2
         BNgklZUnVx2buupuPfkZQbFr61QhyQAY/0nsg1zPxCGecllmO6bPHqFb53CT10uJoPoX
         95yO2BIJGSfmeJCjPMNMQJIQiqn2N/DoKyfP1r8wG+Yau/bws9OhPlIjG6K2nbMyxxof
         /tZg==
X-Gm-Message-State: APjAAAUiCf4LrG+j0e99TnSYlI+7X7699HJOw/NHQI9TunxGm8YJi+1Y
        8HShipbNn2JouuDUeabsqL8=
X-Google-Smtp-Source: APXvYqzAIw1ZphsPWLGJVHg7bcD1ZMcGWt/MokLpR4l6jx7OvqkvL05SGIr4+INFtJqX4dvyCZQ4CA==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr738217wmb.58.1554857845594;
        Tue, 09 Apr 2019 17:57:25 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:24 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 05/22] net: dsa: Add more convenient functions for installing port VLANs
Date:   Wed, 10 Apr 2019 03:56:43 +0300
Message-Id: <20190410005700.31582-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
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
           dsa_port_vid_add      dsa_slave_port_obj_add
                  |                         |
                  +-------+         +-------+
                          |         |
                          v         v
                       dsa_port_vlan_add

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
Renamed __dsa_port_vlan_add to dsa_port_vid_add and not to
dsa_port_vlan_add_trans, as suggested, because the corresponding _del function
does not have a transactional phase and the naming is more uniform this way.

 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 31 +++++++++++++++++++++++++++++++
 net/dsa/slave.c    | 16 ++--------------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 093b7d145eb1..4246523e3133 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -169,6 +169,8 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		      struct switchdev_trans *trans);
 int dsa_port_vlan_del(struct dsa_port *dp,
 		      const struct switchdev_obj_port_vlan *vlan);
+int dsa_port_vid_add(struct dsa_port *dp, u16 vid, u16 flags);
+int dsa_port_vid_del(struct dsa_port *dp, u16 vid);
 int dsa_port_link_register_of(struct dsa_port *dp);
 void dsa_port_link_unregister_of(struct dsa_port *dp);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index a86fe3be1261..19f3b91c648d 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -326,6 +326,37 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	return 0;
 }
 
+int dsa_port_vid_add(struct dsa_port *dp, u16 vid, u16 flags)
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
+int dsa_port_vid_del(struct dsa_port *dp, u16 vid)
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
index 80be8e86c82d..d0905fd720b2 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -994,13 +994,6 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
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
 
@@ -1017,13 +1010,8 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
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
+	return dsa_port_vid_add(dp, vid, 0);
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
-- 
2.17.1

